Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106153DB63F
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501749; cv=none; b=GFXv7oZbHVNeDM2x7dqpRnWO/lHHEJ/WBZ6zgYYnrlqaPoOnr2ijZbpZDTMHq5PrTPiN9kERB12/LG+WNplHar1cZ/9/GtcXP5RhN2xqyxvgrrX4pkTtISAAZQP/PyIEqVSj/cgHgfGuuwCTCDclV3VqXAxfRZwfxx2N9wJUBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501749; c=relaxed/simple;
	bh=jI/B9zoCoPXmGHvvjs0M+S2APkRIFpW47w0JbYJ6WYc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYk40ZThOBfDhTVjmhxLJEexbRKPsB6FEJBRT8nVLyDaaXybhEA5S3+zKjCQzGMIf3/tf2bVgROAnJgKsHcbk/J9AaxVNlOenIXvGcypwcDY6OlasrDYoKnQhCfu/jC7Y3858OIsF9WUyCNSWZq9vpHTjqKG8QQPJ24J5roPjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/IqiYkV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAVgYQ8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/IqiYkV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAVgYQ8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777501745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMn4oIUuLG2bxWSN5SG8gkc/YATeLxg4A35BBe/pa3s=;
	b=A/IqiYkVz/HW13IhP+ETcRbIOepBs1NKO1ToNZRdkHFFRYPbSgNV9N/orC2ZXtxzU1X5md
	2y8TY8ly9eJd9O5qshrccASqIiXtakwyIlFNJPuFyUxhSSaKYSQLCw+mvZFRvUiDsciUu9
	23uo8jTYUAXiHXppb60ZyoPeqf2m28g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-ad-INMKONfKc_NAg0k7o7A-1; Wed, 29 Apr 2026 18:29:03 -0400
X-MC-Unique: ad-INMKONfKc_NAg0k7o7A-1
X-Mimecast-MFC-AGG-ID: ad-INMKONfKc_NAg0k7o7A_1777501743
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7b3e41a97f0so5533927b3.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777501743; x=1778106543; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YMn4oIUuLG2bxWSN5SG8gkc/YATeLxg4A35BBe/pa3s=;
        b=dAVgYQ8brWuNgUiWnSQexzUOmEhXTtPcAC+Q9maRiavi8mvoo58v9XmdR3XQgmPlcS
         yxJ2pnX/7iotvegQ4o0ROzacXfHzaHLYyQCew7Q1ZndjrA8SNWcNS72BKC+8BQ+VJRRb
         rKGNcLHi/dMXcOGVX81TRJy0uO16Xc3svi2Xot1zTeNz6IvYXoX00mhk4MeUSMJFpZ1A
         cTr0ZLHTNxdHTrP4Vz0MuFEqaLvDPnKg3uwuQXoDL+T+U+b/z98dXS89IrWeA81pMAy/
         1u4T/b8mXio34enqk/uCdFngiScOAeZdsPGADQZPHnadLn+lCnO7QUMIkC73WYGG+3b7
         mUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777501743; x=1778106543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMn4oIUuLG2bxWSN5SG8gkc/YATeLxg4A35BBe/pa3s=;
        b=onSqE+klgwdzdW0U6Kq/xU4NDwIKbbhA2EkZUDkdqZCEQyIm/YVYNbBUsl76ozX7QC
         FHQh/+tSb9zArLmLjFE9UIsj7oz9YSbS8AP+0nA7KSQPg6qc515h+HZ0ScywuB7hdIwH
         0tD70JP5KpsWG38Vw6XWUCiidg7kN1DusRNAozaVz1XWgCkrZ9N60FdwpEQwoW/f8aD1
         qXmwJwq+/gRUYpWZaEq+fypNfRE4/3VBn45V3XqERLPYmxp6Z0lHVvoxG6FZrgSQaKpk
         G+LdmLFgBNKRzk1+eNdWVvyMdb2qpNawb6jiVN5zL1oap4IxlH/SZvb8XNTw02Q9tOUb
         jsuA==
X-Forwarded-Encrypted: i=1; AFNElJ+teSfE5ygjTE08E5Daxflmhcny54sUwJvpNcfEoCXpbo7nv0tgsUg32cUvLkYzSgNKcerpxJ0NOvgH@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkLRmNlKqJ2voj1b37x4Jx+u1tzQaqbwI4XCBmbsNCc7iRRgX
	wHEh4oCclR4oAvA+Xhi38Hoi0KKr17XNGzFPYQY+kuTiW9q5kesrVbgfBQXvTuVttj0eKqnBhtP
	K6ChHnfVVs6kPwJXANTdM3x+nMy65zq8D2PcjWtACuX/optzvow/eVHJJPVL88bE=
X-Gm-Gg: AeBDiesmub3yOBAMdTKenaZuttDu8VyObnQCmEs6ad249vUh2f9ZNKno3QTQ2I4aImt
	5BLN6d8GOJ665BkyPnQ7zOM0mSonUeN8ghRaTsICbYctFSDcMvCBRPQ0WIy5WqqiBjCOhgMltBn
	5YyGLVAFw4ubZk+mzzxzQTCoV/flHfY3TLg5zcs6O68tD+0y4vi+/CD+Ei2hNqRim/ApRAYRjxH
	JjJCWluAQPUMvLFKC3HUxBD5f7m4x5UtT9t8+0tnKsBxtKap/h4GSbxl3U5hL4RFDOE6cnM1l+8
	f2U08EPUUe99IKDeqoKED6f/w1blxwsSxW1wIOlv21Miz1GP/2Dd9QSXhbsR38x8xttS3YBgg2X
	yAqV5mb34zXE8LO0H0mLVnUHrcz+GwFnIHDCSltb8tKPWG/K4oLmktGyuqM4d8n8=
X-Received: by 2002:a05:690c:a004:b0:7b8:9418:7605 with SMTP id 00721157ae682-7bd52a759c9mr6000577b3.38.1777501742609;
        Wed, 29 Apr 2026 15:29:02 -0700 (PDT)
X-Received: by 2002:a05:690c:a004:b0:7b8:9418:7605 with SMTP id 00721157ae682-7bd52a759c9mr6000357b3.38.1777501741987;
        Wed, 29 Apr 2026 15:29:01 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5512b04csm456437b3.34.2026.04.29.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:29:01 -0700 (PDT)
Message-ID: <eaec3781eb6034d87a0fb4cbf011c3dbe6d73eb4.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v3 05/11] ceph: add client reset state
 machine and session teardown
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Wed, 29 Apr 2026 15:29:00 -0700
In-Reply-To: <20260429125206.1512203-6-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
	 <20260429125206.1512203-6-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-29 at 12:52 +0000, Alex Markuze wrote:
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
> result via -EIO (reset failed) or 0 (success).  Internal work-function
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
>  fs/ceph/mds_client.c | 455 +++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.h |  42 ++++
>  3 files changed, 513 insertions(+)
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
> index d83003acfb06..777af51ec8d8 100644
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
> @@ -67,6 +68,7 @@ static void __wake_requests(struct ceph_mds_client *mds=
c,
>  			    struct list_head *head);
>  static void ceph_cap_release_work(struct work_struct *work);
>  static void ceph_cap_reclaim_work(struct work_struct *work);
> +static void ceph_mdsc_reset_workfn(struct work_struct *work);
> =20
>  static const struct ceph_connection_operations mds_con_ops;
> =20
> @@ -3797,6 +3799,22 @@ int ceph_mdsc_submit_request(struct ceph_mds_clien=
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
> @@ -5203,6 +5221,421 @@ static int send_mds_reconnect(struct ceph_mds_cli=
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
> + * Returns -EIO if reset completed with an error.
> + * Returns -ETIMEDOUT if we timed out waiting.
> + * Returns -ERESTARTSYS if interrupted by signal.
> + *
> + * Internal work-function errors (e.g. -ENOMEM) are not propagated
> + * to callers; they are mapped to -EIO.  The detailed error is
> + * available via debugfs status and tracepoints.
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
> +	if (READ_ONCE(st->phase) =3D=3D CEPH_CLIENT_RESET_IDLE)
> +		return 0;
> +
> +	blocked_count =3D atomic_inc_return(&st->blocked_requests);
> +	doutc(cl, "request blocked during reset, %d total blocked\n",
> +	      blocked_count);
> +
> +retry:
> +	remaining =3D max_t(long, deadline - jiffies, 1);
> +	wait_ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> +						    READ_ONCE(st->phase) =3D=3D
> +						     CEPH_CLIENT_RESET_IDLE,

Maybe, static inline function for this check?

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
> +	return ret ? -EIO : 0;

The ceph_mdsc_wait_for_reset() maps all non-zero last_errno to -EIO. Any
internal failure gets silently mapped to -EIO. Callers seeing -EIO from ope=
n()
or flock() won't be able to distinguish "reset failed" from "session lost".

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

The out_sessions silently skips ceph_mdsc_reset_complete(). Is it always co=
rrect
logic?

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
> +	 * Three things are kicked off:
> +	 *  1. MDS journal -- send_flush_mdlog asks each MDS to journal
> +	 *     pending unsafe operations (creates, renames, setattrs).
> +	 *     This is best-effort: we do not wait for individual unsafe
> +	 *     requests to reach safe status.  Non-stuck ops typically
> +	 *     complete within the bounded wait window below; stuck ops
> +	 *     will not, and are force-dropped during teardown.
> +	 *  2. Dirty caps -- ceph_flush_dirty_caps triggers cap flush on
> +	 *     all sessions.  Non-stuck caps flush in milliseconds.
> +	 *  3. Cap releases -- push pending cap release messages.
> +	 *
> +	 * The cap-flush wait below provides the bounded drain window
> +	 * during which all three categories can make progress.
> +	 */
> +	for (i =3D 0; i < n; i++)
> +		send_flush_mdlog(sessions[i]);
> +
> +	ceph_flush_dirty_caps(mdsc);
> +	ceph_flush_cap_releases(mdsc);
> +
> +	spin_lock(&mdsc->cap_dirty_lock);
> +	if (!list_empty(&mdsc->cap_flush_list)) {
> +		struct ceph_cap_flush *cf =3D

Why not declare variable on one line and then assign on another line?

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
> +					       CEPH_CLIENT_RESET_DRAIN_SEC * HZ);
> +		if (drain_ret =3D=3D 0) {
> +			pr_info_client(cl,
> +				       "drain timed out, proceeding with forced teardown\n");
> +			spin_lock(&st->lock);
> +			st->drain_timed_out =3D true;

Do we really need to use spin_lock() here? Could WRITE_ONCE() be enough for
changing one field?

> +			spin_unlock(&st->lock);
> +		} else {
> +			pr_info_client(cl, "drain completed successfully\n");
> +			spin_lock(&st->lock);
> +			st->drain_timed_out =3D false;

Ditto.

> +			spin_unlock(&st->lock);
> +		}
> +	} else {
> +		spin_unlock(&mdsc->cap_dirty_lock);
> +		spin_lock(&st->lock);
> +		st->drain_timed_out =3D false;

Ditto.

> +		spin_unlock(&st->lock);
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
> +	 */
> +	if (n > 0)
> +		msleep(CEPH_CLIENT_RESET_CLOSE_GRACE_MS);

I don't like to use the msleep(). Can we use of waiting some event instead?

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

If I understood correctly, ceph_put_mds_session() could free pointer on
sessions. Could we have use-after-free issue here? Should we do sessions[i]=
 =3D
NULL here?

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
> +	for (i =3D 0; i < n; i++)
> +		ceph_put_mds_session(sessions[i]);
> +	kfree(sessions);
> +}
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
> @@ -5742,6 +6175,11 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
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
> @@ -6267,6 +6705,23 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
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
> index e91a199d56fd..afc08b0abbd5 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -74,6 +74,42 @@ struct ceph_fs_client;
>  struct ceph_cap;
> =20
>  #define MDS_AUTH_UID_ANY -1
> +#define CEPH_CLIENT_RESET_REASON_LEN	64
> +#define CEPH_CLIENT_RESET_DRAIN_SEC	5

Probably, this value could be short for production. 5 seconds to flush dirt=
y
caps across sessions under any meaningful write load is very tight. The exi=
sting
wait_caps_flush() has no timeout at all. Maybe, 30=E2=80=9360 seconds would=
 be more
useful?

> +#define CEPH_CLIENT_RESET_CLOSE_GRACE_MS 100
> +#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120

I think we need to collect all timeout declarations in one place.

> +
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
> +	spinlock_t lock;
> +	u64 trigger_count;
> +	u64 success_count;
> +	u64 failure_count;
> +	unsigned long last_start;
> +	unsigned long last_finish;
> +	int last_errno;
> +	enum ceph_client_reset_phase phase;
> +	bool drain_timed_out;
> +	bool shutdown;
> +	int sessions_reset;
> +	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
> +
> +	/* Request blocking during reset */
> +	wait_queue_head_t blocked_wq;
> +	atomic_t blocked_requests;
> +};

It's big enough structure and it requires the commenting of all fields.

Thanks,
Slava.

> =20
>  struct ceph_mds_cap_match {
>  	s64 uid;  /* default to MDS_AUTH_UID_ANY */
> @@ -536,6 +572,8 @@ struct ceph_mds_client {
>  	struct list_head  dentry_dir_leases; /* lru list */
> =20
>  	struct ceph_client_metric metric;
> +	struct work_struct	reset_work;
> +	struct ceph_client_reset_state reset_state;
> =20
>  	spinlock_t		snapid_map_lock;
>  	struct rb_root		snapid_map_tree;
> @@ -559,10 +597,14 @@ extern struct ceph_mds_session *
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

