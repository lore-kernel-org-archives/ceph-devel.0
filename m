Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842044D695
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181472; cv=none; b=XvQl1W1FVk0oyLb6oYDDYBcKTea2mZaupaoeSQtNze4qSsB3NdL4qcj6+P1A+hj5bvGjilSdlwpBVIig4/7Q/qk9Jf24a8O/5hUN2RoeE5d/0lj9hdbfZvscP+DJRkRFYcyf5Hhu5nYFyGOTuFsLkpM+zPzOmEva9rvNjz+1vKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181472; c=relaxed/simple;
	bh=cAMSL8ZLIsCbVFkR58Y9SK1mnSlagx7WzuHSMSqr7Wg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DesGGiNyM3Wo9LMzMQkM2dAckCGcGCZ3QlVD6gBORot12X5W4bNVvK5PykHYlCOtaWsIumIbvm/9CWfyCsymSsLXOegXeXp7fDZECWllKA4ZXVWwWY5/0eJq80zaHG9H1UDBEr+DlHv8It5hU63sqvYiS/abE11pSwuLckOx88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDEqKa7y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jqpUE4Xy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDEqKa7y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jqpUE4Xy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778181467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DalxMAGH9HZA+FhOvFhKYNgA3kvy76ttEBq/Iz4Aq8=;
	b=CDEqKa7yDnjI8Dw6U6bgugDOAD/5viUArLmbM1WTtt9cK3PAe+lDNGl70h9EiJOqaONjVd
	0GBMO3O9UUi3Vbu9zNjs32GVrbl8SpeLaZ4pHPdAZzB/WLNMAV/vfWcd8ond+Fq/2RfiLO
	AeCbk6Ugo5iHBNJtsaVhPVl71TMZd6M=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-Zr0vSnFnPz-uGGqj_IFqJw-1; Thu, 07 May 2026 15:17:45 -0400
X-MC-Unique: Zr0vSnFnPz-uGGqj_IFqJw-1
X-Mimecast-MFC-AGG-ID: Zr0vSnFnPz-uGGqj_IFqJw_1778181465
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bdd1ef8648so34947697b3.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778181465; x=1778786265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+DalxMAGH9HZA+FhOvFhKYNgA3kvy76ttEBq/Iz4Aq8=;
        b=jqpUE4Xy0/UlKjwaY1ohb54RN/B+dXuEAfKmhcrdoSFvx1FIiLE9uvXy0pDYhsWXho
         dkQx6Z7ZumGA0wEHiXlBI8hEp4oYV+raPEJ8liHU0ZWIhFULitaHeDp2BPBMK1QBcMK/
         HjE0kRupZdiHoC29/6dYIGDz97agsOLPnodQlux1QfSFrnVWYnwqvxM9E2JlEs+fvmes
         cY3N1ulKkqM78K7zWiBfZAhEvPrjjAXFz09rtzZJ52OeJEUArdIKCm0T63gXkiW6OBFY
         JZZ427D5j4irIvqqr0BTHCt5afFO0AlL2tRHnzCHo730XWmlaXVwPdIJRg1gBhvmlfKJ
         UOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181465; x=1778786265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DalxMAGH9HZA+FhOvFhKYNgA3kvy76ttEBq/Iz4Aq8=;
        b=BtwAMh4cU//C5Q0q/3bHCSN/xSNV60hfpf/OAEDs06373tYc8ygO3Z043DIUkL6Fx5
         5mDHl06YNRKMbfSmJP0rsFN7BHfIadZl8dUAXjspfGXZVzSJvvliogl6rzp6aJcJ7HXq
         9GzYmqsNeMF0yJp06oCOBkQ/uVbd+QLMCgBEw/8IG2sKTzdwr6p5yq6Pcfr0qpDZmpC4
         xAPxfudjc46x/fsI+hcv2b4IUnZWA++kjdPHN19tgBqoAi891j8Llozjdt7+XrVIodEH
         A+itokZLzFOVamiRUeK/v1RjdAcvWB4VBflLKAWjiGfvAd8DNiQ3o06IvUQQt9tFS5uM
         oyMw==
X-Forwarded-Encrypted: i=1; AFNElJ/krbULy7MLvyX74bemYxuBFRqtAjka+jbyymwvA0FV5D5OwebMdzPWKxJkf+9g1YEtmUkXefORBXkw@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBuGwfhFyhFzGZfSVJdpAdqLjQCSZezVm9fgbh246OjE5WC3U
	KEXmdmkizOOS1odtm9Rp+gRGQ8gTPP4H8ha7DNs28ASx9emjYzWrB6+F1mkHcbi3fz2M/MpLfX3
	rY6ggdA5RzVdzKJbwWALKr7OHuEKMZeIUtTgeBPkgVZ7uq3FsmBc/TuFoXViudQQ=
X-Gm-Gg: Acq92OEqDiHSsxVl9R2ZkRjon1viZ84Kw+mtJNjpQVmSZWftnKwsDA943HfXAwDL8GE
	m4NRcaIt2aBogCDeAXj5FZ73WarBVjRhhcYcVio20W77APGSpfcovOsoHmyVnOR/yDoVNeWCio4
	mv1ek+C0t88YDRFbM6rg/LkQmsP3ncQoPnIqCHSWasR1QXUfdomh6FnRJfZSccjtq6p64jMwfpl
	+/kwrEVm6BDJA9w9X0KgVdfAslR1I30OVl4HimFMhiG9KWAeZ0ExzXM2XLKdx5253KgQcmXcM7Q
	YPV4THwE9LB3LEgbmS8Fd9V9JpwkQ+2nEudGI1U4xTduq3+LqSeDI1kRMIbcJgqux5WFV4bZofS
	JC/CtkyS+2CUpE/xSchy5jiMxsizdzf0SEunlXNLMTOldKu+7rwKS
X-Received: by 2002:a05:690c:e3cb:b0:7b3:3a49:756 with SMTP id 00721157ae682-7bdf5e7eb5bmr99044737b3.25.1778181464877;
        Thu, 07 May 2026 12:17:44 -0700 (PDT)
X-Received: by 2002:a05:690c:e3cb:b0:7b3:3a49:756 with SMTP id 00721157ae682-7bdf5e7eb5bmr99044267b3.25.1778181464243;
        Thu, 07 May 2026 12:17:44 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686fbcdsm95909257b3.40.2026.05.07.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:17:43 -0700 (PDT)
Message-ID: <017bcd9b8533b8ad159a2d679c73152cbb98e5ef.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 05/11] ceph: add client reset state
 machine and session teardown
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:17:42 -0700
In-Reply-To: <20260507122737.2804094-6-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-6-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 12:27 +0000, Alex Markuze wrote:
> Add the client-side reset state machine, request gating, and manual
> session teardown implementation.
>=20
> Manual reset is an operator-triggered escape hatch for client/MDS
> stalemates in which caps, locks, or unsafe metadata state stop making
> forward progress.  The reset blocks new metadata work, attempts a
> bounded best-effort drain of dirty client state while sessions are
> still alive, and finally asks the MDS to close sessions before tearing
> local session state down directly.
>=20
> The reset state machine tracks four phases: IDLE -> QUIESCING ->
> DRAINING -> TEARDOWN -> IDLE.  QUIESCING is set synchronously by
> schedule_reset() before the workqueue item is dispatched, so that new
> metadata requests and file-lock acquisitions are gated immediately --
> even before the work function begins running.  All non-IDLE phases
> block callers on blocked_wq, preventing races with session teardown.
>=20
> The drain phase flushes mdlog state, dirty caps, and pending cap
> releases for a bounded interval.  State that still cannot make progress
> within that interval is discarded during teardown, which is the point
> of the reset: break the stalemate and allow fresh sessions to rebuild
> clean state.
>=20
> The session teardown follows the established check_new_map()
> forced-close pattern: unregister sessions under mdsc->mutex, then clean
> up caps and requests under s->s_mutex.  Reconnect is not attempted
> because the MDS only accepts reconnects during its own RECONNECT phase
> after restart, not from an active client.
>=20
> Blocked callers are released when reset completes and observe the final
> result via -EAGAIN (reset failed) or 0 (success).  Internal work-function
> errors such as -ENOMEM are not propagated to unrelated callers like
> open() or flock(); the detailed error remains in debugfs and
> tracepoints.
>=20
> The work function checks st->shutdown before each phase transition
> (DRAINING, TEARDOWN) so that a concurrent ceph_mdsc_destroy() is not
> overwritten.  If destroy already took ownership, the work function
> releases session references and returns without touching the state.
>=20
> The timeout calculation for blocked-request waiters uses max_t() to
> prevent jiffies underflow when the deadline has already passed.
>=20
> The close-grace sleep before teardown is a best-effort nudge to let
> queued REQUEST_CLOSE messages egress; it is not a correctness
> requirement since the MDS still has session_autoclose as a fallback.
>=20
> The destroy path marks reset as failed and wakes blocked waiters before
> cancel_work_sync() so unmount does not stall.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/locks.c      |  16 ++
>  fs/ceph/mds_client.c | 508 +++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.h |  46 ++++
>  3 files changed, 570 insertions(+)
>=20
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index c4ff2266bb94..677221bd64e0 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -249,6 +249,7 @@ int ceph_lock(struct file *file, int cmd, struct file=
_lock *fl)
>  {
>  	struct inode *inode =3D file_inode(file);
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
> +	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(inode->i_sb);
>  	struct ceph_client *cl =3D ceph_inode_to_client(inode);
>  	int err =3D 0;
>  	u16 op =3D CEPH_MDS_OP_SETFILELOCK;
> @@ -275,6 +276,13 @@ int ceph_lock(struct file *file, int cmd, struct fil=
e_lock *fl)
>  		return -EIO;
>  	}
> =20
> +	/* Wait for reset to complete before acquiring new locks */
> +	if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && !lock_is_unlock(fl)) {
> +		err =3D ceph_mdsc_wait_for_reset(mdsc);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (lock_is_read(fl))
>  		lock_cmd =3D CEPH_LOCK_SHARED;
>  	else if (lock_is_write(fl))
> @@ -311,6 +319,7 @@ int ceph_flock(struct file *file, int cmd, struct fil=
e_lock *fl)
>  {
>  	struct inode *inode =3D file_inode(file);
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
> +	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(inode->i_sb);
>  	struct ceph_client *cl =3D ceph_inode_to_client(inode);
>  	int err =3D 0;
>  	u8 wait =3D 0;
> @@ -330,6 +339,13 @@ int ceph_flock(struct file *file, int cmd, struct fi=
le_lock *fl)
>  		return -EIO;
>  	}
> =20
> +	/* Wait for reset to complete before acquiring new locks */
> +	if (!lock_is_unlock(fl)) {
> +		err =3D ceph_mdsc_wait_for_reset(mdsc);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (IS_SETLKW(cmd))
>  		wait =3D 1;
> =20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 6ab5031e697a..ce773b1095da 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -6,6 +6,7 @@
>  #include <linux/slab.h>
>  #include <linux/gfp.h>
>  #include <linux/sched.h>
> +#include <linux/delay.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/ratelimit.h>
> @@ -65,6 +66,7 @@ static void __wake_requests(struct ceph_mds_client *mds=
c,
>  			    struct list_head *head);
>  static void ceph_cap_release_work(struct work_struct *work);
>  static void ceph_cap_reclaim_work(struct work_struct *work);
> +static void ceph_mdsc_reset_workfn(struct work_struct *work);
> =20
>  static const struct ceph_connection_operations mds_con_ops;
> =20
> @@ -3844,6 +3846,22 @@ int ceph_mdsc_submit_request(struct ceph_mds_clien=
t *mdsc, struct inode *dir,
>  	struct ceph_client *cl =3D mdsc->fsc->client;
>  	int err =3D 0;
> =20
> +	/*
> +	 * If a reset is in progress, wait for it to complete.
> +	 *
> +	 * This is best-effort: a request can pass this check just
> +	 * before the phase leaves IDLE and proceed concurrently with
> +	 * reset.  That is acceptable because (a) such requests will
> +	 * either complete normally or fail and be retried by the
> +	 * caller, and (b) adding lock serialization here would
> +	 * penalize every request for a rare manual operation.
> +	 */
> +	err =3D ceph_mdsc_wait_for_reset(mdsc);
> +	if (err) {
> +		doutc(cl, "wait_for_reset failed: %d\n", err);
> +		return err;
> +	}
> +
>  	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
>  	if (req->r_inode)
>  		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
> @@ -5266,6 +5284,474 @@ static int send_mds_reconnect(struct ceph_mds_cli=
ent *mdsc,
>  	return err;
>  }
> =20
> +const char *ceph_reset_phase_name(enum ceph_client_reset_phase phase)
> +{
> +	switch (phase) {
> +	case CEPH_CLIENT_RESET_IDLE:	  return "idle";
> +	case CEPH_CLIENT_RESET_QUIESCING: return "quiescing";
> +	case CEPH_CLIENT_RESET_DRAINING:  return "draining";
> +	case CEPH_CLIENT_RESET_TEARDOWN:  return "teardown";
> +	default:			  return "unknown";
> +	}
> +}
> +
> +/**
> + * ceph_mdsc_wait_for_reset - wait for an active reset to complete
> + * @mdsc: MDS client
> + *
> + * Returns 0 if reset completed successfully or no reset was active.
> + * Returns -EAGAIN if reset completed with an error, signalling the
> + * caller to retry.  The internal error (e.g. -ENOMEM) is not propagated
> + * because callers like open() or flock() have no way to act on
> + * work-function internals.  The detailed error is available via debugfs
> + * reset/status and tracepoints.
> + * Returns -ETIMEDOUT if we timed out waiting.
> + * Returns -ERESTARTSYS if interrupted by signal.
> + */
> +int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
> +{
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	unsigned long deadline =3D jiffies + CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC=
 * HZ;
> +	int blocked_count;
> +	long remaining;
> +	long wait_ret;
> +	int ret;
> +
> +	if (ceph_reset_is_idle(st))
> +		return 0;
> +
> +	blocked_count =3D atomic_inc_return(&st->blocked_requests);
> +	doutc(cl, "request blocked during reset, %d total blocked\n",
> +	      blocked_count);
> +
> +retry:
> +	remaining =3D max_t(long, deadline - jiffies, 1);
> +	wait_ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> +						    ceph_reset_is_idle(st),
> +						    remaining);
> +
> +	if (wait_ret =3D=3D 0) {
> +		atomic_dec(&st->blocked_requests);
> +		pr_warn_client(cl, "timed out waiting for reset to complete\n");
> +		return -ETIMEDOUT;
> +	}
> +	if (wait_ret < 0) {
> +		atomic_dec(&st->blocked_requests);
> +		return (int)wait_ret;  /* -ERESTARTSYS */
> +	}
> +
> +	/*
> +	 * Verify phase is still IDLE under the lock.  If another reset
> +	 * was scheduled between the wake-up and this check, loop back
> +	 * and wait for it to finish rather than returning a stale result.
> +	 */
> +	spin_lock(&st->lock);
> +	if (st->phase !=3D CEPH_CLIENT_RESET_IDLE) {
> +		spin_unlock(&st->lock);
> +		if (time_before(jiffies, deadline))
> +			goto retry;
> +		atomic_dec(&st->blocked_requests);
> +		return -ETIMEDOUT;
> +	}
> +	ret =3D st->last_errno;
> +	spin_unlock(&st->lock);
> +
> +	atomic_dec(&st->blocked_requests);
> +	return ret ? -EAGAIN : 0;
> +}
> +
> +static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int r=
et)
> +{
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +
> +	spin_lock(&st->lock);
> +	/*
> +	 * If destroy already marked us as shut down, it owns the
> +	 * final bookkeeping and waiter wakeup.  Just bail so we
> +	 * don't overwrite its state.
> +	 */
> +	if (st->shutdown) {
> +		spin_unlock(&st->lock);
> +		return;
> +	}
> +	st->last_finish =3D jiffies;
> +	st->last_errno =3D ret;
> +	st->phase =3D CEPH_CLIENT_RESET_IDLE;
> +	if (ret)
> +		st->failure_count++;
> +	else
> +		st->success_count++;
> +	spin_unlock(&st->lock);
> +
> +	/* Wake up all requests that were blocked waiting for reset */
> +	wake_up_all(&st->blocked_wq);
> +
> +}
> +
> +static void ceph_mdsc_reset_workfn(struct work_struct *work)
> +{
> +	struct ceph_mds_client *mdsc =3D
> +		container_of(work, struct ceph_mds_client, reset_work);
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	struct ceph_mds_session **sessions =3D NULL;
> +	char reason[CEPH_CLIENT_RESET_REASON_LEN];
> +	unsigned long drain_deadline;
> +	int max_sessions, i, n =3D 0, torn_down =3D 0;
> +	int ret =3D 0;
> +
> +	spin_lock(&st->lock);
> +	strscpy(reason, st->last_reason, sizeof(reason));
> +	spin_unlock(&st->lock);
> +
> +	mutex_lock(&mdsc->mutex);
> +	max_sessions =3D mdsc->max_sessions;
> +	if (max_sessions <=3D 0) {
> +		mutex_unlock(&mdsc->mutex);
> +		goto out_complete;
> +	}
> +
> +	sessions =3D kcalloc(max_sessions, sizeof(*sessions), GFP_KERNEL);
> +	if (!sessions) {
> +		mutex_unlock(&mdsc->mutex);
> +		ret =3D -ENOMEM;
> +		pr_err_client(cl,
> +			      "manual session reset failed to allocate session array\n");
> +		ceph_mdsc_reset_complete(mdsc, ret);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < max_sessions; i++) {
> +		struct ceph_mds_session *session =3D mdsc->sessions[i];
> +
> +		if (!session)
> +			continue;
> +
> +		/*
> +		 * Read session state without s_mutex to avoid nesting
> +		 * mdsc->mutex -> s_mutex, which would invert the
> +		 * s_mutex -> mdsc->mutex order used by
> +		 * cleanup_session_requests().  s_state is an int
> +		 * so loads are atomic; the teardown loop below
> +		 * handles races with concurrent state transitions.
> +		 */
> +		switch (READ_ONCE(session->s_state)) {
> +		case CEPH_MDS_SESSION_OPEN:
> +		case CEPH_MDS_SESSION_HUNG:
> +		case CEPH_MDS_SESSION_OPENING:
> +		case CEPH_MDS_SESSION_RESTARTING:
> +		case CEPH_MDS_SESSION_RECONNECTING:
> +		case CEPH_MDS_SESSION_CLOSING:
> +			sessions[n++] =3D ceph_get_mds_session(session);
> +			break;
> +		default:
> +			pr_info_client(cl,
> +				       "mds%d in state %s, skipping reset\n",
> +				       session->s_mds,
> +				       ceph_session_state_name(session->s_state));
> +			break;
> +		}
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +
> +	pr_info_client(cl,
> +		       "manual session reset executing (sessions=3D%d, reason=3D\"%s\"=
)\n",
> +		       n, reason);
> +
> +	if (n =3D=3D 0) {
> +		kfree(sessions);
> +		goto out_complete;
> +	}
> +
> +	spin_lock(&st->lock);
> +	if (st->shutdown) {
> +		spin_unlock(&st->lock);
> +		goto out_sessions;
> +	}
> +	st->phase =3D CEPH_CLIENT_RESET_DRAINING;
> +	spin_unlock(&st->lock);
> +
> +	/*
> +	 * Best-effort drain: flush dirty state while sessions are still
> +	 * alive.  New requests are blocked while phase !=3D IDLE.
> +	 * The sessions are functional, so non-stuck state drains normally.
> +	 * Stuck state (the cause of the stalemate the operator is trying
> +	 * to break) will not drain -- that is expected, and we proceed to
> +	 * forced teardown after the timeout.
> +	 *
> +	 * Four things are drained:
> +	 *  1. MDS journal -- send_flush_mdlog asks each MDS to journal
> +	 *     pending unsafe operations (creates, renames, setattrs).
> +	 *  2. Unsafe requests -- bounded wait for each unsafe write
> +	 *     request to reach safe status via r_safe_completion.
> +	 *  3. Dirty caps -- ceph_flush_dirty_caps triggers cap flush on
> +	 *     all sessions.  Non-stuck caps flush in milliseconds.
> +	 *  4. Cap releases -- push pending cap release messages.
> +	 *
> +	 * The unsafe-request wait and cap-flush wait below provide
> +	 * the bounded drain window during which all categories can
> +	 * make progress.
> +	 */
> +	for (i =3D 0; i < n; i++)
> +		send_flush_mdlog(sessions[i]);
> +
> +	/*
> +	 * Both drain legs (unsafe requests and cap flushes) share a
> +	 * single deadline so the total drain time is bounded at
> +	 * CEPH_CLIENT_RESET_DRAIN_SEC.
> +	 */
> +	drain_deadline =3D jiffies + CEPH_CLIENT_RESET_DRAIN_SEC * HZ;
> +
> +	/*
> +	 * Wait for unsafe write requests (creates, renames, setattrs)
> +	 * to reach safe status.  Uses the same pattern as
> +	 * flush_mdlog_and_wait_mdsc_unsafe_requests() but bounded by
> +	 * the shared drain deadline.  Requests that do not complete within
> +	 * the window are force-dropped during teardown.
> +	 */
> +	{
> +		struct ceph_mds_request *req;
> +		struct rb_node *rn;
> +		u64 last_tid;
> +
> +		mutex_lock(&mdsc->mutex);
> +		last_tid =3D mdsc->last_tid;
> +		mutex_unlock(&mdsc->mutex);
> +
> +		mutex_lock(&mdsc->mutex);
> +		rn =3D rb_first(&mdsc->request_tree);
> +		while (rn) {
> +			req =3D rb_entry(rn, struct ceph_mds_request, r_node);
> +			if (req->r_tid > last_tid)
> +				break;
> +			if (req->r_op =3D=3D CEPH_MDS_OP_SETFILELOCK ||
> +			    !(req->r_op & CEPH_MDS_OP_WRITE)) {
> +				rn =3D rb_next(rn);
> +				continue;
> +			}
> +			ceph_mdsc_get_request(req);
> +			mutex_unlock(&mdsc->mutex);
> +
> +			wait_for_completion_timeout(&req->r_safe_completion,
> +				max_t(long, drain_deadline - jiffies, 1));
> +
> +			mutex_lock(&mdsc->mutex);
> +			ceph_mdsc_put_request(req);
> +			if (time_after(jiffies, drain_deadline))
> +				break;
> +			rn =3D rb_first(&mdsc->request_tree);
> +		}
> +		mutex_unlock(&mdsc->mutex);
> +
> +		if (time_after_eq(jiffies, drain_deadline))
> +			WRITE_ONCE(st->drain_timed_out, true);
> +	}
> +
> +	ceph_flush_dirty_caps(mdsc);
> +	ceph_flush_cap_releases(mdsc);
> +
> +	spin_lock(&mdsc->cap_dirty_lock);
> +	if (!list_empty(&mdsc->cap_flush_list)) {
> +		struct ceph_cap_flush *cf =3D
> +			list_last_entry(&mdsc->cap_flush_list,
> +					struct ceph_cap_flush, g_list);
> +		u64 want_flush =3D mdsc->last_cap_flush_tid;
> +		long drain_ret;
> +
> +		/*
> +		 * Setting wake on the last entry is sufficient: flush
> +		 * entries complete in order, so when this entry finishes
> +		 * all earlier ones are already done.
> +		 */
> +		cf->wake =3D true;
> +		spin_unlock(&mdsc->cap_dirty_lock);
> +		pr_info_client(cl,
> +			       "draining (want_flush=3D%llu, %d sessions)\n",
> +			       want_flush, n);
> +		drain_ret =3D wait_event_timeout(mdsc->cap_flushing_wq,
> +					       check_caps_flush(mdsc,
> +								want_flush),
> +					       max_t(long,
> +						     drain_deadline - jiffies,
> +						     1));
> +		if (drain_ret =3D=3D 0) {
> +			pr_info_client(cl,
> +				       "drain timed out, proceeding with forced teardown\n");
> +			WRITE_ONCE(st->drain_timed_out, true);
> +		} else {
> +			pr_info_client(cl, "drain completed successfully\n");
> +		}
> +	} else {
> +		spin_unlock(&mdsc->cap_dirty_lock);
> +	}
> +
> +	spin_lock(&st->lock);
> +	if (st->shutdown) {
> +		spin_unlock(&st->lock);
> +		goto out_sessions;
> +	}
> +	st->phase =3D CEPH_CLIENT_RESET_TEARDOWN;
> +	spin_unlock(&st->lock);
> +
> +	/*
> +	 * Ask each MDS to close the session before we tear it down
> +	 * locally.  Without this the MDS sees only a connection drop and
> +	 * waits for the client to reconnect (up to session_autoclose
> +	 * seconds) before evicting the session and releasing locks.
> +	 *
> +	 * Reuse the normal close machinery so the session state/sequence
> +	 * snapshot is serialized under s_mutex and a racing s_seq bump
> +	 * retransmits REQUEST_CLOSE while the session remains CLOSING.
> +	 * We send all close requests first, then yield briefly to let the
> +	 * network stack transmit them before __unregister_session()
> +	 * closes the connections.
> +	 */
> +	for (i =3D 0; i < n; i++) {
> +		int err;
> +
> +		mutex_lock(&sessions[i]->s_mutex);
> +		err =3D __close_session(mdsc, sessions[i]);
> +		mutex_unlock(&sessions[i]->s_mutex);
> +		if (err < 0)
> +			pr_warn_client(cl,
> +				       "mds%d failed to queue close request before reset: %d\n",
> +				       sessions[i]->s_mds, err);
> +	}
> +	/*
> +	 * Best-effort grace period: yield briefly so the network stack
> +	 * can transmit the queued REQUEST_CLOSE messages before we tear
> +	 * down connections.  Not a correctness requirement -- the MDS
> +	 * will still evict via session_autoclose if it never receives
> +	 * the close request.
> +	 *
> +	 * Event-based waiting is not viable here: there is no completion
> +	 * event for "message left the NIC," and waiting for the MDS
> +	 * SESSION_CLOSE response would re-create the stalemate that the
> +	 * reset is meant to break.
> +	 */
> +	if (n > 0)
> +		msleep(CEPH_CLIENT_RESET_CLOSE_GRACE_MS);
> +
> +	/*
> +	 * Tear down each session: close the connection, remove all
> +	 * caps, clean up requests, then kick pending requests so they
> +	 * re-open a fresh session on the next attempt.
> +	 *
> +	 * This is modeled on the check_new_map() forced-close path
> +	 * for stopped MDS ranks - a proven pattern for hard session
> +	 * teardown.  We do NOT attempt send_mds_reconnect() because
> +	 * the MDS only accepts reconnects during its own RECONNECT
> +	 * phase (after MDS restart), not from an active client.
> +	 *
> +	 * Any state that did not drain (caps that didn't flush, unsafe
> +	 * requests that the MDS didn't journal) is force-dropped here.
> +	 * This is intentional: that state is stuck and is the reason
> +	 * the operator triggered the reset.
> +	 */
> +	for (i =3D 0; i < n; i++) {
> +		int mds =3D sessions[i]->s_mds;
> +
> +		pr_info_client(cl, "mds%d resetting session\n", mds);
> +
> +		mutex_lock(&mdsc->mutex);
> +		if (mds >=3D mdsc->max_sessions ||
> +		    mdsc->sessions[mds] !=3D sessions[i]) {
> +			pr_info_client(cl,
> +				       "mds%d session already torn down, skipping\n",
> +				       mds);
> +			mutex_unlock(&mdsc->mutex);
> +			ceph_put_mds_session(sessions[i]);
> +			sessions[i] =3D NULL;
> +			continue;
> +		}
> +		sessions[i]->s_state =3D CEPH_MDS_SESSION_CLOSED;
> +		__unregister_session(mdsc, sessions[i]);
> +		__wake_requests(mdsc, &sessions[i]->s_waiting);
> +		mutex_unlock(&mdsc->mutex);
> +
> +		mutex_lock(&sessions[i]->s_mutex);
> +		cleanup_session_requests(mdsc, sessions[i]);
> +		remove_session_caps(sessions[i]);
> +		mutex_unlock(&sessions[i]->s_mutex);
> +
> +		wake_up_all(&mdsc->session_close_wq);
> +
> +		ceph_put_mds_session(sessions[i]);
> +
> +		mutex_lock(&mdsc->mutex);
> +		kick_requests(mdsc, mds);
> +		mutex_unlock(&mdsc->mutex);
> +
> +		torn_down++;
> +		pr_info_client(cl, "mds%d session reset complete\n", mds);
> +	}
> +
> +	kfree(sessions);
> +
> +	spin_lock(&st->lock);
> +	st->sessions_reset =3D torn_down;
> +	spin_unlock(&st->lock);
> +
> +out_complete:
> +	ceph_mdsc_reset_complete(mdsc, ret);
> +	return;
> +
> +out_sessions:
> +	/* shutdown =3D=3D true: ceph_mdsc_destroy() owns the final transition.=
 */
> +	for (i =3D 0; i < n; i++)
> +		ceph_put_mds_session(sessions[i]);
> +	kfree(sessions);
> +}

This function contains several code blocks that can be made as static inlin=
e
functions. It could make the ceph_mdsc_reset_workfn() shorter and easy to=
=20
understand.

> +
> +int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
> +			     const char *reason)
> +{
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	struct ceph_fs_client *fsc =3D mdsc->fsc;
> +	const char *msg =3D (reason && reason[0]) ? reason : "manual";
> +	int mount_state;
> +
> +	mount_state =3D READ_ONCE(fsc->mount_state);
> +	if (mount_state !=3D CEPH_MOUNT_MOUNTED) {
> +		pr_warn_client(fsc->client,
> +			       "reset rejected: mount_state=3D%d (not mounted)\n",
> +			       mount_state);
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&st->lock);
> +	if (st->phase !=3D CEPH_CLIENT_RESET_IDLE) {
> +		spin_unlock(&st->lock);
> +		return -EBUSY;
> +	}
> +
> +	st->phase =3D CEPH_CLIENT_RESET_QUIESCING;
> +	st->last_start =3D jiffies;
> +	st->last_errno =3D 0;
> +	st->drain_timed_out =3D false;
> +	st->sessions_reset =3D 0;
> +	st->trigger_count++;
> +	strscpy(st->last_reason, msg, sizeof(st->last_reason));
> +	spin_unlock(&st->lock);
> +
> +	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
> +		spin_lock(&st->lock);
> +		st->phase =3D CEPH_CLIENT_RESET_IDLE;
> +		st->last_errno =3D -EALREADY;
> +		st->last_finish =3D jiffies;
> +		st->failure_count++;
> +		spin_unlock(&st->lock);
> +		wake_up_all(&st->blocked_wq);
> +		return -EALREADY;
> +	}
> +
> +	pr_info_client(mdsc->fsc->client,
> +		       "manual session reset scheduled (reason=3D\"%s\")\n",
> +		       msg);
> +	return 0;
> +}
> +
> =20
>  /*
>   * compare old and new mdsmaps, kicking requests
> @@ -5811,6 +6297,11 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	INIT_LIST_HEAD(&mdsc->dentry_leases);
>  	INIT_LIST_HEAD(&mdsc->dentry_dir_leases);
> =20
> +	spin_lock_init(&mdsc->reset_state.lock);
> +	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
> +	atomic_set(&mdsc->reset_state.blocked_requests, 0);
> +	INIT_WORK(&mdsc->reset_work, ceph_mdsc_reset_workfn);
> +
>  	ceph_caps_init(mdsc);
>  	ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
> =20
> @@ -6336,6 +6827,23 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
>  	/* flush out any connection work with references to us */
>  	ceph_msgr_flush();
> =20
> +	/*
> +	 * Mark reset as failed and wake any blocked waiters before
> +	 * cancelling, so unmount doesn't stall on blocked_wq timeout
> +	 * if cancel_work_sync() prevents the work from running.
> +	 */
> +	spin_lock(&mdsc->reset_state.lock);
> +	mdsc->reset_state.shutdown =3D true;
> +	if (mdsc->reset_state.phase !=3D CEPH_CLIENT_RESET_IDLE) {
> +		mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
> +		mdsc->reset_state.last_errno =3D -ESHUTDOWN;
> +		mdsc->reset_state.last_finish =3D jiffies;
> +		mdsc->reset_state.failure_count++;
> +	}
> +	spin_unlock(&mdsc->reset_state.lock);
> +	wake_up_all(&mdsc->reset_state.blocked_wq);
> +
> +	cancel_work_sync(&mdsc->reset_work);
>  	ceph_mdsc_stop(mdsc);
> =20
>  	ceph_metric_destroy(&mdsc->metric);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 8208fdf02efe..b1a0621cd37e 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -80,7 +80,47 @@ struct ceph_cap;
>  #define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
>  #define CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES 5
>  #define CEPH_CAP_FLUSH_MAX_DUMP_ITERS 5
> +#define CEPH_CLIENT_RESET_REASON_LEN	64
> +#define CEPH_CLIENT_RESET_DRAIN_SEC	30
> +#define CEPH_CLIENT_RESET_CLOSE_GRACE_MS 100
> +#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
> =20
> +enum ceph_client_reset_phase {
> +	CEPH_CLIENT_RESET_IDLE =3D 0,
> +	/*
> +	 * QUIESCING is set synchronously by schedule_reset() before the
> +	 * workqueue item is dispatched.  It gates new requests (any
> +	 * phase !=3D IDLE blocks callers) during the window between
> +	 * scheduling and the work function's transition to DRAINING.
> +	 */
> +	CEPH_CLIENT_RESET_QUIESCING,
> +	CEPH_CLIENT_RESET_DRAINING,
> +	CEPH_CLIENT_RESET_TEARDOWN,
> +};
> +
> +struct ceph_client_reset_state {
> +	spinlock_t lock;		/* protects all fields below */
> +	u64 trigger_count;		/* number of resets triggered */
> +	u64 success_count;		/* number of successful resets */
> +	u64 failure_count;		/* number of failed resets */
> +	unsigned long last_start;	/* jiffies when last reset started */
> +	unsigned long last_finish;	/* jiffies when last reset finished */
> +	int last_errno;			/* result of most recent reset */
> +	enum ceph_client_reset_phase phase; /* current reset phase */
> +	bool drain_timed_out;		/* drain exceeded timeout */
> +	bool shutdown;			/* destroy in progress */
> +	int sessions_reset;		/* sessions torn down in last reset */
> +	char last_reason[CEPH_CLIENT_RESET_REASON_LEN]; /* operator-supplied re=
ason */
> +
> +	/* Request blocking during reset */
> +	wait_queue_head_t blocked_wq;	/* waitqueue for blocked callers */
> +	atomic_t blocked_requests;	/* count of blocked callers */
> +};
> +
> +static inline bool ceph_reset_is_idle(struct ceph_client_reset_state *st=
)
> +{
> +	return READ_ONCE(st->phase) =3D=3D CEPH_CLIENT_RESET_IDLE;
> +}
>  struct ceph_mds_cap_match {
>  	s64 uid;  /* default to MDS_AUTH_UID_ANY */
>  	u32 num_gids;
> @@ -543,6 +583,8 @@ struct ceph_mds_client {
>  	struct list_head  dentry_dir_leases; /* lru list */
> =20
>  	struct ceph_client_metric metric;
> +	struct work_struct	reset_work;
> +	struct ceph_client_reset_state reset_state;
>  	struct ceph_subvolume_metrics_tracker subvol_metrics;
> =20
>  	/* Subvolume metrics send tracking */
> @@ -574,10 +616,14 @@ extern struct ceph_mds_session *
>  __ceph_lookup_mds_session(struct ceph_mds_client *, int mds);
> =20
>  extern const char *ceph_session_state_name(int s);
> +extern const char *ceph_reset_phase_name(enum ceph_client_reset_phase ph=
ase);
> =20
>  extern struct ceph_mds_session *
>  ceph_get_mds_session(struct ceph_mds_session *s);
>  extern void ceph_put_mds_session(struct ceph_mds_session *s);
> +int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
> +			     const char *reason);
> +int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
> =20
>  extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
>  extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

