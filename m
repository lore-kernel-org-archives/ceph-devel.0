From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] libceph: fix "safe" completion
Date: Wed, 01 May 2013 18:13:49 +0800
Message-ID: <5180EADD.6020202@intel.com>
References: <1367327864-21408-1-git-send-email-zheng.z.yan@intel.com> <CAPYLRzgvUHhFVBFz9wrstO+EE_QkG1Oj-uQtb+iPL=7fpm8UTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:55453 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759051Ab3EAKN5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 May 2013 06:13:57 -0400
In-Reply-To: <CAPYLRzgvUHhFVBFz9wrstO+EE_QkG1Oj-uQtb+iPL=7fpm8UTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Elder <elder@inktank.com>

The kernel client set the FLAG_ACK flag only when it can't get Fb or Fl caps
(O_DIRECT and O_SYNC writes do not set the FLAG_ACK flag). ceph_sync_write()
allocates separate buffer to hold user date, it's safe even in the case of
OSD failure. I agree that the names and usages of callbacks are confusing.
Other than that, I can't see any issue.

Regards
Yan, Zheng


On 05/01/2013 01:04 AM, Gregory Farnum wrote:
> I was looking at this code recently and had similar thoughts; I've
> included the relevant parts of a conversation on this topic below. In
> light of that I'm not sure if this patch is appropriate or not (it
> might be; it certainly needs some cleanup IMO).
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 
> 
> ---------- Forwarded message ----------
> From: Sage Weil <sage@inktank.com>
> Date: Thu, Apr 18, 2013 at 1:41 PM
> Subject: Re: use of osd_client's r_callback
> To: Gregory Farnum <greg@inktank.com>
> Cc: Alex Elder <elder@inktank.com>, Josh Durgin <josh.durgin@inktank.com>
> 
> 
> It is a bit fragile, but not broken AFAICS.  We only se the FLAG_ACK flag
> on the request (which controls whether we get an ACK in addition to a
> COMMIT reply from the osd) for the sync write path (O_DIRECT and O_SYNC
> writes).. and in that case, the callback is expecting to be called on the
> ack and the commit is just clenaing up that safe/unsafe list for fsync.
> 
> I think we could clean this code up so that the names and meanings of the
> callbacks are more consistent (e.g., r_commit_callback vs
> r_ack_callback)...
> 
> s
> 
> On Thu, 18 Apr 2013, Gregory Farnum wrote:
> 
>> The recent series of patches to deal with deadlocks has me spending a
>> little bit more time looking at the kernel client, especially after I
>> didn't understand some of the comments going back and forth about safe
>> and unsafe lists and callbacks (specifically, compared to their
>> meanings in userspace). This investigation has left me concerned, and
>> maybe confused, about when we're reporting writes as done.
>>
>> In particular, following on from change to "unsafe" so it no longer
>> indicates any communication from the OSD (which might be fine?), I
>> spent some time looking at how the other callback is handled. As best
>> I can tell, the osdc's "r_callback" is used, from the caller's
>> perspective (drivers/block/rbd.c and fs/ceph/*), to indicate that a
>> write is permanent and it can forget the data/unlock the pages/etc ?
>> this matches what the userspace clients do with a "safe" response.
>> However, in looking at the handle_reply() function, it sure looks to
>> me as if r_callback() is invoked on the first reply from an OSD ?
>> which can in many cases be an "unsafe" reply meaning that the data
>> hasn't been persisted yet! The only reference I can find to it seeing
>> if the reply is a safe or unsafe reply happens during duplicate
>> response checking, on the second (or subsequent) responses.
>>
>> Am I missing something here, or is the kernel client broken under OSD
>> failures? (I note that these issues aren't going to turn up when the
>> OSDs are running xfs/ext4 because on those FSes the first reply will
>> always be the "safe" response, which explains why we haven't detected
>> them if there are no other reasons.)
>> -Greg
>>
>>
> 
> 
> On Tue, Apr 30, 2013 at 6:17 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> complete_request() is never called if the first OSD replay doesn't
>> have ONDISK flag.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  include/linux/ceph/osd_client.h |  1 -
>>  net/ceph/osd_client.c           | 16 ++++++++--------
>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
>> index 4191cd2..70f79fb 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -145,7 +145,6 @@ struct ceph_osd_request {
>>         s32               r_reply_op_result[CEPH_OSD_MAX_OP];
>>         int               r_got_reply;
>>         int               r_linger;
>> -       int               r_completed;
>>
>>         struct ceph_osd_client *r_osdc;
>>         struct kref       r_kref;
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 57d8db5..8a5fc37 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -1522,6 +1522,8 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
>>         for (i = 0; i < numops; i++)
>>                 req->r_reply_op_result[i] = ceph_decode_32(&p);
>>
>> +       already_completed = req->r_got_reply;
>> +
>>         if (!req->r_got_reply) {
>>
>>                 req->r_result = result;
>> @@ -1552,16 +1554,14 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
>>             ((flags & CEPH_OSD_FLAG_WRITE) == 0))
>>                 __unregister_request(osdc, req);
>>
>> -       already_completed = req->r_completed;
>> -       req->r_completed = 1;
>>         mutex_unlock(&osdc->request_mutex);
>> -       if (already_completed)
>> -               goto done;
>>
>> -       if (req->r_callback)
>> -               req->r_callback(req, msg);
>> -       else
>> -               complete_all(&req->r_completion);
>> +       if (!already_completed) {
>> +               if (req->r_callback)
>> +                       req->r_callback(req, msg);
>> +               else
>> +                       complete_all(&req->r_completion);
>> +       }
>>
>>         if (flags & CEPH_OSD_FLAG_ONDISK)
>>                 complete_request(req);
>> --
>> 1.8.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

