From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v1 4/7] ceph: handle new osdmap epoch updates in
 CLIENT_CAPS and WRITE codepaths
Date: Mon, 23 Jan 2017 09:38:16 +0800
Message-ID: <610D739A-0DDD-4967-A30A-09410A8C890E@redhat.com>
References: <20170120151738.9584-1-jlayton@redhat.com>
 <20170120151738.9584-5-jlayton@redhat.com>
 <1CA9B32B-E3EA-47A0-8803-A4CD969737B0@redhat.com>
 <1485099534.2992.1.camel@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750712AbdAWBiX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 22 Jan 2017 20:38:23 -0500
In-Reply-To: <1485099534.2992.1.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>


> On 22 Jan 2017, at 23:38, Jeff Layton <jlayton@redhat.com> wrote:
> 
> On Sun, 2017-01-22 at 17:40 +0800, Yan, Zheng wrote:
>>> On 20 Jan 2017, at 23:17, Jeff Layton <jlayton@redhat.com> wrote:
>>> 
>>> This patch is heavily inspired by John Spray's earlier work, but
>>> implemented in a different way.
>>> 
>>> Create and register a new map_cb for cephfs, to allow it to handle
>>> changes to the osdmap.
>>> 
>>> In the version 5 of CLIENT_CAPS messages, the barrier field is added as an
>>> instruction to clients that they may not use the attached capabilities
>>> until they have a particular OSD map epoch.
>>> 
>>> When we get a message with such a field and don't have the requisite map
>>> epoch yet, we put that message on a list in the session, to be run when
>>> the map does come in.
>>> 
>>> When we get a new map update, the map_cb routine first checks to see
>>> whether there may be an OSD or pool full condition. If so, then we walk
>>> the list of OSD calls and kill off any writes to full OSDs or pools with
>>> -ENOSPC.  While cancelling, we store the latest OSD epoch seen in each
>>> request. This will be used later in the CAPRELEASE messages.
>>> 
>>> Then, it walks the session list and queues the workqueue job for each.
>>> When the workqueue job runs, it walks the list of delayed caps and tries
>>> to rerun each one. If the epoch is still not high enough, they just get
>>> put back on the delay queue for when the map does come in.
>>> 
>>> Suggested-by: John Spray <john.spray@redhat.com>
>>> Signed-off-by: Jeff Layton <jlayton@redhat.com>
>>> ---
>>> fs/ceph/caps.c       | 43 +++++++++++++++++++++++++++---
>>> fs/ceph/debugfs.c    |  3 +++
>>> fs/ceph/mds_client.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> fs/ceph/mds_client.h |  3 +++
>>> 4 files changed, 120 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>> index d941c48e8bff..f33d424b5e12 100644
>>> --- a/fs/ceph/caps.c
>>> +++ b/fs/ceph/caps.c
>>> @@ -1077,7 +1077,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
>>> 	/* inline data size */
>>> 	ceph_encode_32(&p, 0);
>>> 	/* osd_epoch_barrier (version 5) */
>>> -	ceph_encode_32(&p, 0);
>>> +	ceph_encode_32(&p, arg->session->s_mdsc->cap_epoch_barrier);
>>> 	/* oldest_flush_tid (version 6) */
>>> 	ceph_encode_64(&p, arg->oldest_flush_tid);
>>> 
>>> @@ -3577,9 +3577,12 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>>> 	void *snaptrace;
>>> 	size_t snaptrace_len;
>>> 	void *p, *end;
>>> +	u32 epoch_barrier = 0;
>>> 
>>> 	dout("handle_caps from mds%d\n", mds);
>>> 
>>> +	WARN_ON_ONCE(!list_empty(&msg->list_head));
>>> +
>>> 	/* decode */
>>> 	end = msg->front.iov_base + msg->front.iov_len;
>>> 	tid = le64_to_cpu(msg->hdr.tid);
>>> @@ -3625,13 +3628,45 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>>> 		p += inline_len;
>>> 	}
>>> 
>>> +	if (le16_to_cpu(msg->hdr.version) >= 5) {
>>> +		struct ceph_osd_client *osdc = &mdsc->fsc->client->osdc;
>>> +
>>> +		ceph_decode_32_safe(&p, end, epoch_barrier, bad);
>>> +
>>> +		/* Do lockless check first to avoid mutex if we can */
>>> +		if (epoch_barrier > mdsc->cap_epoch_barrier) {
>>> +			mutex_lock(&mdsc->mutex);
>>> +			if (epoch_barrier > mdsc->cap_epoch_barrier)
>>> +				mdsc->cap_epoch_barrier = epoch_barrier;
>>> +			mutex_unlock(&mdsc->mutex);
>>> +		}
>>> +
>>> +		down_read(&osdc->lock);
>>> +		if (osdc->osdmap->epoch < epoch_barrier) {
>>> +			dout("handle_caps delaying message until OSD epoch %d\n", epoch_barrier);
>>> +			ceph_msg_get(msg);
>>> +			spin_lock(&session->s_cap_lock);
>>> +			list_add(&msg->list_head, &session->s_delayed_caps);
>>> +			spin_unlock(&session->s_cap_lock);
>>> +
>>> +			// Kick OSD client to get the latest map
>>> +			__ceph_osdc_maybe_request_map(osdc);
>>> +
>>> +			up_read(&osdc->lock);
>>> +			return;
>>> +		}
>> 
>> Cap messages need to be handled in the same order as they were sent. I’m worry if the delay breaks something or makes cap revoke slow. Why not use the use the same approach as user space client? pass the epoch_barrier to libceph and let libceph delay sending osd requests.
>> 
>> Regards
>> Yan, Zheng
>> 
>> 
> 
> 
> Can you explain why that needs to be done, and how that ordering
> guaranteed now? AFAICT, the libceph code seems to drop con->mutex before
> it calls ->dispatch, and I don't see anything that would prevent two cap
> messages from reordered at that point. 

I think the ordering is guaranteed by "single dispatch thread for each connection”.
One example is that MDS issues caps ABC to client, then issues caps AB to client
(revokes caps C). If the two messages get processed out of order, client does not
release cap C to MDS, which causes operation hang.
 
Regards
Yan, Zheng

> 
> That said, plumbing an epoch barrier into libceph does sound better.
> I'll have a look at that approach this week.
> 
> Thanks,
> Jeff
> 
>>> +
>>> +		dout("handle_caps barrier %d already satisfied (%d)\n", epoch_barrier, osdc->osdmap->epoch);
>>> +		up_read(&osdc->lock);
>>> +	}
>>> +
>>> +	dout("handle_caps v=%d barrier=%d\n", le16_to_cpu(msg->hdr.version), epoch_barrier);
>>> +
>>> 	if (le16_to_cpu(msg->hdr.version) >= 8) {
>>> 		u64 flush_tid;
>>> 		u32 caller_uid, caller_gid;
>>> -		u32 osd_epoch_barrier;
>>> 		u32 pool_ns_len;
>>> -		/* version >= 5 */
>>> -		ceph_decode_32_safe(&p, end, osd_epoch_barrier, bad);
>>> +
>>> 		/* version >= 6 */
>>> 		ceph_decode_64_safe(&p, end, flush_tid, bad);
>>> 		/* version >= 7 */
>>> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
>>> index 39ff678e567f..825df757fba5 100644
>>> --- a/fs/ceph/debugfs.c
>>> +++ b/fs/ceph/debugfs.c
>>> @@ -172,6 +172,9 @@ static int mds_sessions_show(struct seq_file *s, void *ptr)
>>> 	/* The -o name mount argument */
>>> 	seq_printf(s, "name \"%s\"\n", opt->name ? opt->name : "");
>>> 
>>> +	/* The latest OSD epoch barrier known to this client */
>>> +	seq_printf(s, "osd_epoch_barrier \"%d\"\n", mdsc->cap_epoch_barrier);
>>> +
>>> 	/* The list of MDS session rank+state */
>>> 	for (mds = 0; mds < mdsc->max_sessions; mds++) {
>>> 		struct ceph_mds_session *session =
>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>> index 176512960b14..7055b499c08b 100644
>>> --- a/fs/ceph/mds_client.c
>>> +++ b/fs/ceph/mds_client.c
>>> @@ -393,6 +393,7 @@ void ceph_put_mds_session(struct ceph_mds_session *s)
>>> 	dout("mdsc put_session %p %d -> %d\n", s,
>>> 	     atomic_read(&s->s_ref), atomic_read(&s->s_ref)-1);
>>> 	if (atomic_dec_and_test(&s->s_ref)) {
>>> +		WARN_ON_ONCE(cancel_work_sync(&s->s_delayed_caps_work));
>>> 		if (s->s_auth.authorizer)
>>> 			ceph_auth_destroy_authorizer(s->s_auth.authorizer);
>>> 		kfree(s);
>>> @@ -432,6 +433,74 @@ static int __verify_registered_session(struct ceph_mds_client *mdsc,
>>> 	return 0;
>>> }
>>> 
>>> +static void handle_osd_map(struct ceph_osd_client *osdc, void *p)
>>> +{
>>> +	struct ceph_mds_client *mdsc = (struct ceph_mds_client*)p;
>>> +	u32 cancelled_epoch = 0;
>>> +	int mds_id;
>>> +
>>> +	lockdep_assert_held(&osdc->lock);
>>> +
>>> +	if ((osdc->osdmap->flags & CEPH_OSDMAP_FULL) ||
>>> +	    ceph_osdc_have_pool_full(osdc))
>>> +		cancelled_epoch = ceph_osdc_complete_writes(osdc, -ENOSPC);
>>> +
>>> +	dout("handle_osd_map: epoch=%d\n", osdc->osdmap->epoch);
>>> +
>>> +	mutex_lock(&mdsc->mutex);
>>> +	if (cancelled_epoch)
>>> +		mdsc->cap_epoch_barrier = max(cancelled_epoch + 1,
>>> +					      mdsc->cap_epoch_barrier);
>>> +
>>> +	/* Schedule the workqueue job for any sessions */
>>> +	for (mds_id = 0; mds_id < mdsc->max_sessions; ++mds_id) {
>>> +		struct ceph_mds_session *session = mdsc->sessions[mds_id];
>>> +		bool empty;
>>> +
>>> +		if (session == NULL)
>>> +			continue;
>>> +
>>> +		/* Any delayed messages? */
>>> +		spin_lock(&session->s_cap_lock);
>>> +		empty = list_empty(&session->s_delayed_caps);
>>> +		spin_unlock(&session->s_cap_lock);
>>> +		if (empty)
>>> +			continue;
>>> +
>>> +		/* take a reference -- if we can't get one, move on */
>>> +		if (!get_session(session))
>>> +			continue;
>>> +
>>> +		/*
>>> +		 * Try to schedule work. If it's already queued, then just
>>> +		 * drop the session reference.
>>> +		 */
>>> +		if (!schedule_work(&session->s_delayed_caps_work))
>>> +			ceph_put_mds_session(session);
>>> +	}
>>> +	mutex_unlock(&mdsc->mutex);
>>> +}
>>> +
>>> +static void
>>> +run_delayed_caps(struct work_struct *work)
>>> +{
>>> +	struct ceph_mds_session *session = container_of(work,
>>> +			struct ceph_mds_session, s_delayed_caps_work);
>>> +	LIST_HEAD(delayed);
>>> +
>>> +	spin_lock(&session->s_cap_lock);
>>> +	list_splice_init(&session->s_delayed_caps, &delayed);
>>> +	spin_unlock(&session->s_cap_lock);
>>> +
>>> +	while (!list_empty(&delayed)) {
>>> +		struct ceph_msg *msg = list_first_entry(&delayed,
>>> +						struct ceph_msg, list_head);
>>> +		list_del_init(&msg->list_head);
>>> +		ceph_handle_caps(session, msg);
>>> +		ceph_msg_put(msg);
>>> +	}
>>> +}
>>> +
>>> /*
>>> * create+register a new session for given mds.
>>> * called under mdsc->mutex.
>>> @@ -469,11 +538,13 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
>>> 	atomic_set(&s->s_ref, 1);
>>> 	INIT_LIST_HEAD(&s->s_waiting);
>>> 	INIT_LIST_HEAD(&s->s_unsafe);
>>> +	INIT_LIST_HEAD(&s->s_delayed_caps);
>>> 	s->s_num_cap_releases = 0;
>>> 	s->s_cap_reconnect = 0;
>>> 	s->s_cap_iterator = NULL;
>>> 	INIT_LIST_HEAD(&s->s_cap_releases);
>>> 	INIT_LIST_HEAD(&s->s_cap_flushing);
>>> +	INIT_WORK(&s->s_delayed_caps_work, run_delayed_caps);
>>> 
>>> 	dout("register_session mds%d\n", mds);
>>> 	if (mds >= mdsc->max_sessions) {
>>> @@ -3480,6 +3551,10 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>>> 
>>> 	ceph_caps_init(mdsc);
>>> 	ceph_adjust_min_caps(mdsc, fsc->min_caps);
>>> +	mdsc->cap_epoch_barrier = 0;
>>> +
>>> +	ceph_osdc_register_map_cb(&fsc->client->osdc,
>>> +				  handle_osd_map, (void*)mdsc);
>>> 
>>> 	init_rwsem(&mdsc->pool_perm_rwsem);
>>> 	mdsc->pool_perm_tree = RB_ROOT;
>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>> index 3c6f77b7bb02..eb8144ab4995 100644
>>> --- a/fs/ceph/mds_client.h
>>> +++ b/fs/ceph/mds_client.h
>>> @@ -159,6 +159,8 @@ struct ceph_mds_session {
>>> 	atomic_t          s_ref;
>>> 	struct list_head  s_waiting;  /* waiting requests */
>>> 	struct list_head  s_unsafe;   /* unsafe requests */
>>> +	struct list_head	s_delayed_caps;
>>> +	struct work_struct	s_delayed_caps_work;
>>> };
>>> 
>>> /*
>>> @@ -331,6 +333,7 @@ struct ceph_mds_client {
>>> 	int               num_cap_flushing; /* # caps we are flushing */
>>> 	spinlock_t        cap_dirty_lock;   /* protects above items */
>>> 	wait_queue_head_t cap_flushing_wq;
>>> +	u32               cap_epoch_barrier;
>>> 
>>> 	/*
>>> 	 * Cap reservations
>>> -- 
>>> 2.9.3
>>> 
>> 
>> 
> 
> -- 
> Jeff Layton <jlayton@redhat.com>

