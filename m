From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 03/14] libceph: move and add dout()s to ceph_msg_{get,put}()
Date: Tue, 8 Jul 2014 15:12:14 +0400
Message-ID: <CALFYKtCuMn5MfPF4aOYBbyXM1TD7sNQ5M6XJtzGmuLWQW+6Ogw@mail.gmail.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
	<1403716607-13535-4-git-send-email-ilya.dryomov@inktank.com>
	<53B15815.7050700@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:40094 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbaGHLMP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jul 2014 07:12:15 -0400
Received: by mail-qa0-f50.google.com with SMTP id m5so4674000qaj.9
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jul 2014 04:12:14 -0700 (PDT)
In-Reply-To: <53B15815.7050700@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 30, 2014 at 4:29 PM, Alex Elder <elder@ieee.org> wrote:
> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>> Add dout()s to ceph_msg_{get,put}().  Also move them to .c and turn
>> kref release callback into a static function.
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>
> This is all very good.
>
> I have one suggestion though, below, but regardless:
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>
>> ---
>>  include/linux/ceph/messenger.h |   14 ++------------
>>  net/ceph/messenger.c           |   31 ++++++++++++++++++++++---------
>>  2 files changed, 24 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
>> index d21f2dba0731..40ae58e3e9db 100644
>> --- a/include/linux/ceph/messenger.h
>> +++ b/include/linux/ceph/messenger.h
>> @@ -285,19 +285,9 @@ extern void ceph_msg_data_add_bio(struct ceph_msg *msg, struct bio *bio,
>>
>>  extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
>>                                    bool can_fail);
>> -extern void ceph_msg_kfree(struct ceph_msg *m);
>>
>> -
>> -static inline struct ceph_msg *ceph_msg_get(struct ceph_msg *msg)
>> -{
>> -     kref_get(&msg->kref);
>> -     return msg;
>> -}
>> -extern void ceph_msg_last_put(struct kref *kref);
>> -static inline void ceph_msg_put(struct ceph_msg *msg)
>> -{
>> -     kref_put(&msg->kref, ceph_msg_last_put);
>> -}
>> +extern struct ceph_msg *ceph_msg_get(struct ceph_msg *msg);
>> +extern void ceph_msg_put(struct ceph_msg *msg);
>>
>>  extern void ceph_msg_dump(struct ceph_msg *msg);
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 1948d592aa54..8bffa5b90fef 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -3269,24 +3269,21 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
>>  /*
>>   * Free a generically kmalloc'd message.
>>   */
>> -void ceph_msg_kfree(struct ceph_msg *m)
>> +static void ceph_msg_free(struct ceph_msg *m)
>>  {
>> -     dout("msg_kfree %p\n", m);
>> +     dout("%s %p\n", __func__, m);
>>       ceph_kvfree(m->front.iov_base);
>>       kmem_cache_free(ceph_msg_cache, m);
>>  }
>>
>> -/*
>> - * Drop a msg ref.  Destroy as needed.
>> - */
>> -void ceph_msg_last_put(struct kref *kref)
>> +static void ceph_msg_release(struct kref *kref)
>>  {
>>       struct ceph_msg *m = container_of(kref, struct ceph_msg, kref);
>>       LIST_HEAD(data);
>>       struct list_head *links;
>>       struct list_head *next;
>>
>> -     dout("ceph_msg_put last one on %p\n", m);
>> +     dout("%s %p\n", __func__, m);
>>       WARN_ON(!list_empty(&m->list_head));
>>
>>       /* drop middle, data, if any */
>> @@ -3308,9 +3305,25 @@ void ceph_msg_last_put(struct kref *kref)
>>       if (m->pool)
>>               ceph_msgpool_put(m->pool, m);
>>       else
>> -             ceph_msg_kfree(m);
>> +             ceph_msg_free(m);
>> +}
>> +
>> +struct ceph_msg *ceph_msg_get(struct ceph_msg *msg)
>> +{
>> +     dout("%s %p (was %d)\n", __func__, msg,
>> +          atomic_read(&msg->kref.refcount));
>> +     kref_get(&msg->kref);
>
> I suggest you do the dout() *after* you call kref_get().
> I'm sure it doesn't matter in practice here, but my
> reasoning is that you get the reference immediately, and
> you'll have the reference when reading the refcount value.
> It also  makes the dout() calls here and in ceph_msg_put()
> end up getting symmetrically wrapped by the get kref
> get and put.  (You have a race reading the updated
> refcount value either way, but it's debug code.)

My inspiration was rbd_{img,obj}_request_get().  kref_get() can't fail
(may spit out a WARN though) and it is racey anyway, so I'll leave it as
is for consistency.

Thanks,

                Ilya
