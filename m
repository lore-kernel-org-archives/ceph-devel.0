Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96C30EF63
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376244; cv=none; b=DqNl3tHzbm9h4yuoHv9b6NwVrOmQmtkPUWwAsPVlXBs6WStKVimFK20OBTLUqZmEjO8AcuRiMdnh8I30rIts6sKXUZvWDVcrvXXcViZy0xCYih8mtzdVklCxoDEqQJ94VmgKGW60VG/ehIonPRUYUSJwyvRkUF+MTorpWfXh8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376244; c=relaxed/simple;
	bh=hZsqAN97TGFk1/JUlMf7ut8j+8Vd4lmaq8xQPO8r6yI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FP75pg+oL+ON/9PqwuM8WaHGx46ruwlvAHF3Kuqze16bF7vx4zbPFAUzpXpUm8r6mms2MMYBR+6wXmFANNni8OqHyVDq/nGR0SmhASEGIC7XnhNJBBnkDNO7kW80jLOK+5mlZOctsPK8W2kE/MGMgMkTZS2lga+pNtcS9mIHFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKrDI9NX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=blavlRA8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKrDI9NX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="blavlRA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776376241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaGLpGnfCk2dzR/SMBrQnkgmVdZ7D3WG1di9tO+1KxE=;
	b=KKrDI9NXA7Y4X0LR5srOtqNl3e2mN3XNN1DVsl1DsllfHuiCGg7DxiKoMzdR+lKgCysMcx
	fes7ZfgGlUDRk8UMQQcFMJSX1kHvSBPUtIQjejwjebQxzjWojX3E4dS8vp8cCqwX2Wxw5d
	GH/puPgnKMvJjhG6JkK2cynhcEfqxqY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-vORVhFkgM-W33g_Ef92wSg-1; Thu, 16 Apr 2026 17:50:39 -0400
X-MC-Unique: vORVhFkgM-W33g_Ef92wSg-1
X-Mimecast-MFC-AGG-ID: vORVhFkgM-W33g_Ef92wSg_1776376239
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7985951fa83so250734587b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776376239; x=1776981039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oaGLpGnfCk2dzR/SMBrQnkgmVdZ7D3WG1di9tO+1KxE=;
        b=blavlRA8RkxFURyk8no8iTEHtDP//Hb9bNTvMX+spruNvsSQsRCF6JHXvaYQ9IuYvq
         AvAi+sZKMuEZeHqg2qiYpbGQyeCxDiEvOdxx1wfkQ22EdwhXIMFbLH2AgjDppPvTn9uu
         41ic/mBTeCcd1+n6xbMZSB08fTsZGwoFJhzyzzkvOzdlrZG2XY9vHctfRnWkEAs/JqY7
         Ck0/AKxluL4Wkm4iZzuMpOyDjaC3+LTIrKwkTs4xLKV6vdWqsUBi+D7yhveIqI3X8E4+
         v4M91jkloTfFDcn4SyUu+6wP/m/nmn1bjJQKQ5pnlZG040BMSLLxl1ZqWSxtfzkgY4EI
         gW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776376239; x=1776981039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaGLpGnfCk2dzR/SMBrQnkgmVdZ7D3WG1di9tO+1KxE=;
        b=oy8cbEKPW+Cb1WMRir7mszMGvBSOhr1FphNNjecxW1u84GPFm19Ek7gDEDFOGezrd+
         xhRljRYzSM2HbN6McVVu0kW4NrsnS1YWHJB+I1ee7KMVWuYomXjSoCum6+b8PkUKWZrG
         xEyr2T150Mk/laZWRug2fhtm8F+NRpV5KcYz0kxaO2TGtSIdsOukomnjJgDzkkro33rq
         puzBY/RUg5F8gY/+6P//WIzcivnauYsKz0ysGgCxr/7RT9vOZRc0Sb6ocLrQtKaTttdv
         lKJx56VkFOC36e8gVIb2SN1VWnaSN6UjBKOqhj+mg3wNGW5Bi2iSqAYIH4uB5PMYek9u
         Kxkg==
X-Forwarded-Encrypted: i=1; AFNElJ9eoa3wlnX942d4v8UN9AkcUzLXdGtrmrtFW6XVHvq/82ayPf7UTVjh1bjkWtNvAkwBhRmeuFtr05lc@vger.kernel.org
X-Gm-Message-State: AOJu0YySWYQJdI6P4WhzIBTkDQmrb52jHp3P1+Y3zcvSSB1heMYYxSzt
	eri9MztNzABOylzriAGrFuRM7I6Q0KjyxPDM5mcatw3ijO+vvin10oTkqlPD0XbCf83nfT+NH5Z
	rtw/93OIdiikY9ac7MmPggm2/X9q2R6xAFrk8NY4WsxTy72bBriSMV06XQXNCkB4UhUE6icg=
X-Gm-Gg: AeBDietG3vChJ8UZXjTUx8kNTcH6iS3gmz3xWLSAqML1TgnrSLKOvZUaPMANsytP9TL
	Rk1jeESdD510XKYQ18AbJ0+/wDcFfyX2C6FAqB9Kh4P/76b5h0iMRFeRoe/XmivY6JHb7xXmqlv
	aX/iRwrCBkT1Zna0ycdz0svzusffOsh8jTtS3CI9hupiglbnRdYGeTIi5n/6ZWfUTcy+5vVhTUx
	s3Kfzz1p9Lue0Pcz/8AB0xG5Lo2gcMK3oJirUW1u3dMC1Nx2clXOAIvOpuA1dG1xyhqjiDpSyNQ
	j6lFF5GI05bfcaRciDg7LHAojBOlys3W5H1h/c/psygcX96whMHCJJAjSsye4+B3Fs7Bbnz15aH
	s4oQFkZ5dq26+SeJrtpIiAOCimDJ0IkAfhMfWPkPpzTYEWsESmFzKOXy5gE2l8tQ=
X-Received: by 2002:a05:690c:d1c:b0:7b5:88ec:91b0 with SMTP id 00721157ae682-7b9ed02633amr2978137b3.48.1776376238604;
        Thu, 16 Apr 2026 14:50:38 -0700 (PDT)
X-Received: by 2002:a05:690c:d1c:b0:7b5:88ec:91b0 with SMTP id 00721157ae682-7b9ed02633amr2977817b3.48.1776376237975;
        Thu, 16 Apr 2026 14:50:37 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b76621668asm28531157b3.4.2026.04.16.14.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:50:37 -0700 (PDT)
Message-ID: <71af93a698543220d63a581ee9d485ce34b32b53.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v2 5/7] ceph: add client reset state machine
 and session teardown
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 16 Apr 2026 14:50:36 -0700
In-Reply-To: <20260415170043.3882912-6-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
	 <20260415170043.3882912-6-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 17:00 +0000, Alex Markuze wrote:
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
> result.  The destroy path marks reset as failed and wakes blocked
> waiters before cancel_work_sync() so unmount does not stall.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/locks.c      |  16 ++
>  fs/ceph/mds_client.c | 421 +++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.h |  42 +++++
>  3 files changed, 479 insertions(+)
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

The ceph_mdsc_wait_for_reset returns st->last_errno:

ret =3D st->last_errno;

Potentially, it could fail with -ENOMEM (from kcalloc). As a result, flock(=
) or
open() could return -ENOMEM. However, caller is just waiting for the reset =
to
clear. Is it correct to return the st->last_errno?

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
> index 7d17332d72d7..7e399b0dcc55 100644
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
> @@ -3756,6 +3758,22 @@ int ceph_mdsc_submit_request(struct ceph_mds_clien=
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
> @@ -5163,6 +5181,387 @@ static int send_mds_reconnect(struct ceph_mds_cli=
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
> +/*
> + * Wait for an active reset to complete.
> + * Returns 0 if reset completed successfully or no reset was active.
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
> +	wait_ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> +						    READ_ONCE(st->phase) =3D=3D
> +						     CEPH_CLIENT_RESET_IDLE,
> +						    deadline - jiffies);

I am slightly worried about this calculation. Could be deadline smaller tha=
n
jiffies? It looks like a potential overflow here.

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
> +	return ret;
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
> +	 * final bookkeeping.  Just bail so we don't overwrite the
> +	 * -ESHUTDOWN result that waiters already observed.
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
> +	st->phase =3D CEPH_CLIENT_RESET_DRAINING;
> +	spin_unlock(&st->lock);

It's not so easy to analyze the state machine. But, maybe, I see something =
here.
What if ceph_mdsc_destroy() sets st->phase to CEPH_CLIENT_RESET_IDLE and st=
-
>shutdown =3D true. We change st->phase unconditionally here. Potentially, =
we
could have unexpected outcome. Should we check st->shutdown?

> +
> +	/*
> +	 * Best-effort drain: flush dirty state while sessions are still
> +	 * alive.  New requests are blocked while phase !=3D IDLE.
> +	 * The sessions are functional, so non-stuck state drains normally.
> +	 * Stuck state (the cause of the stalemate the operator is trying
> +	 * to break) will not drain - that is expected, and we proceed to
> +	 * forced teardown after the timeout.
> +	 *
> +	 * Three things are drained:
> +	 *  1. MDS journal - send_flush_mdlog asks each MDS to journal
> +	 *     pending unsafe operations (creates, renames, setattrs).
> +	 *     Once journaled, they survive the session teardown.
> +	 *  2. Dirty caps - ceph_flush_dirty_caps triggers cap flush on
> +	 *     all sessions.  Non-stuck caps flush in milliseconds.
> +	 *  3. Cap releases - push pending cap release messages.
> +	 *
> +	 * All three happen concurrently during the bounded wait window.
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
> +			spin_unlock(&st->lock);
> +		} else {
> +			pr_info_client(cl, "drain completed successfully\n");
> +			spin_lock(&st->lock);
> +			st->drain_timed_out =3D false;
> +			spin_unlock(&st->lock);
> +		}
> +	} else {
> +		spin_unlock(&mdsc->cap_dirty_lock);
> +		spin_lock(&st->lock);
> +		st->drain_timed_out =3D false;
> +		spin_unlock(&st->lock);
> +	}
> +
> +	spin_lock(&st->lock);
> +	st->phase =3D CEPH_CLIENT_RESET_TEARDOWN;
> +	spin_unlock(&st->lock);

The same issue with st->shutdown here.

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
> +	if (n > 0)
> +		msleep(CEPH_CLIENT_RESET_CLOSE_GRACE_MS);

Are you sure that msleep is a really good approach? I would like to see mor=
e
steady basis here. :) Could we do something here in more reasonable way?

Thanks,
Slava.

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
> @@ -5702,6 +6101,11 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
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
> @@ -6227,6 +6631,23 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
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
> +#define CEPH_CLIENT_RESET_CLOSE_GRACE_MS 100
> +#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
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

