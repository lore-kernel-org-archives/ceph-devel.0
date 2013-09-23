From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 3/3] ceph: handle race between cap reconnect and cap release
Date: Tue, 24 Sep 2013 00:08:55 +0800
Message-ID: <CAAM7YA=apJ-jJy3iHVrW3O-_nhXvkYFUTKBv73kD-B-RoY47Dg@mail.gmail.com>
References: <1379825212-10438-1-git-send-email-zheng.z.yan@intel.com>
	<1379825212-10438-3-git-send-email-zheng.z.yan@intel.com>
	<alpine.DEB.2.00.1309230729140.19555@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:37189 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab3IWQI5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 12:08:57 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so2698593lab.27
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 09:08:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309230729140.19555@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 23, 2013 at 10:31 PM, Sage Weil <sage@inktank.com> wrote:
> On Sun, 22 Sep 2013, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> When a cap get released while composing the cap reconnect message.
>> We should skip queuing the release message if the cap hasn't been
>> added to the cap reconnect message.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/caps.c       |  4 +++-
>>  fs/ceph/mds_client.c | 21 ++++++++++++++++++---
>>  fs/ceph/mds_client.h |  1 +
>>  3 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index d2d6e40..acc8564 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -909,7 +909,9 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
>>
>>       /* remove from session list */
>>       spin_lock(&session->s_cap_lock);
>> -     if (queue_release)
>> +     if (queue_release &&
>> +         (!session->s_cap_reconnect ||
>> +          cap->cap_gen == session->s_cap_gen))
>
> The locking here is imprecise... s_cap_reconnect is protected by
> s_cap_ttl_lock vs c_cap_lock for s_cap_gen.  I think it does not matter,
> but we should document why (s_cap_ttl_lock unlock includes memory barrier;
> s_cap_gen does not change while s_cap_lock is held?)

s_cap_reconnect is protected by s_cap_lock, and no one should change
session->s_cap_gen
while the session is in reconnect state.  So I think the locking here
is race free. (the reason
I don't use "session->s_state == CEPH_MDS_SESSION_RECONNECTING" here is to avoid
writing code that relies implicit memory barrier)

...
>
>>               __queue_cap_release(session, ci->i_vino.ino, cap->cap_id,
>>                                   cap->mseq, cap->issue_seq);
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 6b4ed35..30397a6 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -444,6 +444,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
>>       INIT_LIST_HEAD(&s->s_waiting);
>>       INIT_LIST_HEAD(&s->s_unsafe);
>>       s->s_num_cap_releases = 0;
>> +     s->s_cap_reconnect = 0;
>>       s->s_cap_iterator = NULL;
>>       INIT_LIST_HEAD(&s->s_cap_releases);
>>       INIT_LIST_HEAD(&s->s_cap_releases_done);
>> @@ -1415,7 +1416,6 @@ static void discard_cap_releases(struct ceph_mds_client *mdsc,
>>       unsigned num;
>>
>>       dout("discard_cap_releases mds%d\n", session->s_mds);
>> -     spin_lock(&session->s_cap_lock);
>>
>>       /* zero out the in-progress message */
>>       msg = list_first_entry(&session->s_cap_releases,
>> @@ -1442,8 +1442,6 @@ static void discard_cap_releases(struct ceph_mds_client *mdsc,
>>               msg->front.iov_len = sizeof(*head);
>>               list_add(&msg->list_head, &session->s_cap_releases);
>>       }
>> -
>> -     spin_unlock(&session->s_cap_lock);
>
> Why is the locking was dropped here?
>

it's moved into send_mds_reconnect()

Regards
Yan, Zheng


> Thanks!
> sage
>
>
>>  }
>>
>>  /*
>> @@ -2488,6 +2486,7 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
>>       cap->seq = 0;        /* reset cap seq */
>>       cap->issue_seq = 0;  /* and issue_seq */
>>       cap->mseq = 0;       /* and migrate_seq */
>> +     cap->cap_gen = cap->session->s_cap_gen;
>>
>>       if (recon_state->flock) {
>>               rec.v2.cap_id = cpu_to_le64(cap->cap_id);
>> @@ -2611,8 +2610,20 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
>>       dout("session %p state %s\n", session,
>>            session_state_name(session->s_state));
>>
>> +     spin_lock(&session->s_gen_ttl_lock);
>> +     session->s_cap_gen++;
>> +     spin_unlock(&session->s_gen_ttl_lock);
>> +
>> +     spin_lock(&session->s_cap_lock);
>> +     /*
>> +      * notify __ceph_remove_cap() that we are composing cap reconnect.
>> +      * If a cap get released before being added to the cap reconnect,
>> +      * __ceph_remove_cap() should skip queuing cap release.
>> +      */
>> +     session->s_cap_reconnect = 1;
>>       /* drop old cap expires; we're about to reestablish that state */
>>       discard_cap_releases(mdsc, session);
>> +     spin_unlock(&session->s_cap_lock);
>>
>>       /* traverse this session's caps */
>>       s_nr_caps = session->s_nr_caps;
>> @@ -2627,6 +2638,10 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
>>       if (err < 0)
>>               goto fail;
>>
>> +     spin_lock(&session->s_cap_lock);
>> +     session->s_cap_reconnect = 0;
>> +     spin_unlock(&session->s_cap_lock);
>> +
>>       /*
>>        * snaprealms.  we provide mds with the ino, seq (version), and
>>        * parent for all of our realms.  If the mds has any newer info,
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index c2a19fb..4c053d0 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -132,6 +132,7 @@ struct ceph_mds_session {
>>       struct list_head  s_caps;     /* all caps issued by this session */
>>       int               s_nr_caps, s_trim_caps;
>>       int               s_num_cap_releases;
>> +     int               s_cap_reconnect;
>>       struct list_head  s_cap_releases; /* waiting cap_release messages */
>>       struct list_head  s_cap_releases_done; /* ready to send */
>>       struct ceph_cap  *s_cap_iterator;
>> --
>> 1.8.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
