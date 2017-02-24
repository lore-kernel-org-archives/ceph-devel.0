From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/3] libceph: get rid of ack vs commit
Date: Fri, 24 Feb 2017 12:19:00 +0100
Message-ID: <CAOi1vP-YeptK4bEj-=nwXy80kgKDOXQ6HEb5podmiPBTX=4pJw@mail.gmail.com>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
 <1487883561-32001-3-git-send-email-idryomov@gmail.com> <1487891643.10904.10.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35993 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdBXLTy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 06:19:54 -0500
Received: by mail-ua0-f193.google.com with SMTP id j56so1346716uaa.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2017 03:19:01 -0800 (PST)
In-Reply-To: <1487891643.10904.10.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Zheng Yan <zyan@redhat.com>

On Fri, Feb 24, 2017 at 12:14 AM, Jeff Layton <jlayton@redhat.com> wrote:
> On Thu, 2017-02-23 at 21:59 +0100, Ilya Dryomov wrote:
>> - CEPH_OSD_FLAG_ACK shouldn't be set anymore, so assert on it
>> - remove support for handling ack replies (OSDs will send ack replies
>>   only if clients request them)
>> - drop the "do lingering callbacks under osd->lock" logic from
>>   handle_reply() -- lreq->lock is sufficient in all three cases
>>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  include/linux/ceph/osd_client.h |   6 +--
>>  net/ceph/osd_client.c           | 113 +++++++++-------------------------------
>>  2 files changed, 27 insertions(+), 92 deletions(-)
>>
>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
>> index 03a6653d329a..f2ce9cd5ede6 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -22,7 +22,6 @@ struct ceph_osd_client;
>>   * completion callback for async writepages
>>   */
>>  typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *);
>> -typedef void (*ceph_osdc_unsafe_callback_t)(struct ceph_osd_request *, bool);
>>
>>  #define CEPH_HOMELESS_OSD    -1
>>
>> @@ -170,15 +169,12 @@ struct ceph_osd_request {
>>       unsigned int            r_num_ops;
>>
>>       int               r_result;
>> -     bool              r_got_reply;
>>
>>       struct ceph_osd_client *r_osdc;
>>       struct kref       r_kref;
>>       bool              r_mempool;
>> -     struct completion r_completion;
>> -     struct completion r_done_completion;  /* fsync waiter */
>> +     struct completion r_completion;       /* fsync waiter */
>
> Minor nit: surely we also wait on that for things other than fsync?

Of course, ceph_osdc_wait_request() waits on it.  I left the comment in
to stress that r_completion is now also used for syncfs.

The difference between r_completion and r_done_completion was that you
were allowed to complete r_completion whenever, while r_done_completion
was used for syncfs, private to osd_client.c.

It's basically meant to convey that you shouldn't mess with it.  I can
change it to "private to osd_client.c" or so, if that's better.

>
>>       ceph_osdc_callback_t r_callback;
>> -     ceph_osdc_unsafe_callback_t r_unsafe_callback;
>>       struct list_head  r_unsafe_item;
>>
>>       struct inode *r_inode;                /* for use by callbacks */
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index ac4753421d0c..e1c6c2b4a295 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -460,7 +460,6 @@ static void request_init(struct ceph_osd_request *req)
>>
>>       kref_init(&req->r_kref);
>>       init_completion(&req->r_completion);
>> -     init_completion(&req->r_done_completion);
>>       RB_CLEAR_NODE(&req->r_node);
>>       RB_CLEAR_NODE(&req->r_mc_node);
>>       INIT_LIST_HEAD(&req->r_unsafe_item);
>> @@ -1637,7 +1636,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
>>       bool need_send = false;
>>       bool promoted = false;
>>
>> -     WARN_ON(req->r_tid || req->r_got_reply);
>> +     WARN_ON(req->r_tid);
>>       dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
>>
>>  again:
>> @@ -1705,17 +1704,10 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
>>
>>  static void account_request(struct ceph_osd_request *req)
>>  {
>> -     unsigned int mask = CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK;
>> +     WARN_ON(req->r_flags & CEPH_OSD_FLAG_ACK);
>> +     WARN_ON(!(req->r_flags & (CEPH_OSD_FLAG_READ | CEPH_OSD_FLAG_WRITE)));
>
> nit: Those should probably be WARN_ON_ONCE. This gets called fairly
> frequently, and one stack trace is probably enough to point out the
> problem.

I usually use WARN_ONs to make sure they are noticed.  We are slowly
transitioning from BUG_ONs -- baby steps... ;)

Thanks,

                Ilya
