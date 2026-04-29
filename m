Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB563B27F3
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497784; cv=none; b=AVSseiEx5+toSG17xLz1xqC+3MFtb0XNSu5sCOpfTtr8tz87/44KXJb3C8fRdMnXtgtpMiq92YtBzO1Nf+i1YWWBDUwyBfGC88+Y6WNW9CJ8GnJZABH7bg7atOBSCTgQBH7pAUvx+MsCpd3XXyk6owvk1hlWVL5j2ygeev+1b28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497784; c=relaxed/simple;
	bh=rPTKlYxwsKJIBYi1alZrguH4Lfg6693Dvi37q+P374k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oAzCoMLKTY6go69sF0bn9+q+3hzx2lpHa1u6BMnacC/5mGQaIqPx6XsfmoTxsTvlesrkhIRygCVWiN88DQFXlDkIVFZ5gXVzV3UZKYxmJBrtu/tLP3a5wCSJaOg6txqnX/q6wyCxVfZdeRqODRKvZ5tbP+0JusmQwSvPFJNJm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsFMeQIa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C14bCOIu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsFMeQIa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C14bCOIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777497781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9XV7Lfw9nnvXVnz8ouPDy0aINijSqHprb4nyTLxV6w=;
	b=NsFMeQIaNTGq1vpUhS8nX8Wp8hQETbL8wwP8oInoRrfYbYfcC1LqUqVM/XayHwMsNsIpl8
	WUqGxS05y9031uHEYQOJjOUzAWlYKvHHDDcS+6YaqOv41lUyChu8wMRXvw9Cu5CVlpU0La
	YoO/7fQtPEWRNumA2l+lRyHlUd2q54s=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-lL_NJajgOOWgmyCbJOR4Bg-1; Wed, 29 Apr 2026 17:23:00 -0400
X-MC-Unique: lL_NJajgOOWgmyCbJOR4Bg-1
X-Mimecast-MFC-AGG-ID: lL_NJajgOOWgmyCbJOR4Bg_1777497780
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79a51ba2bf9so5345457b3.3
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777497778; x=1778102578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K9XV7Lfw9nnvXVnz8ouPDy0aINijSqHprb4nyTLxV6w=;
        b=C14bCOIuobQNv69Wu5mUxW5dtUuh3oGyrlyx7h2MC4wvAjEPf8Rgiqo/rsfzrqm5Nq
         7NehVQGmTBwxBP/GsaI6vtofgfujndHlEwVYZLPxaH4dh0PzfMsVJv3QmXDFGqUW+9ZB
         YdDuq43Ye2qloL+xvHserq0LTOI2SBO7GSorXHRYjDu9sKIg+KBUEKPUko8cCNoXvCzg
         FqkjWRoWOvkfJqIz+VoqZHHweK5czhpNzVpDiH9YWnsWop1f3ZUeAU/NifkjV1CHqVnp
         /hFV8GF1fZfwVZqJD+nNy3c/pn8gu99LdAxeVhawxGJem4Dv2JEVW1Fph+kkyD56XeHF
         5JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497778; x=1778102578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9XV7Lfw9nnvXVnz8ouPDy0aINijSqHprb4nyTLxV6w=;
        b=seB1BjKMem8/zucXeoQB9MW83Swzbm7kR04zi82gOPjxvApxhdZuGyQznrRLOF9Q0A
         KXUwQKzk+wWTZFz3VMrYURy8ibXeKjJcqviOCpRPpUbZRSCTonoFO8w6Y8nJe2ziGJFv
         CpNRb+1m+xpBTn63/YDFlduTDM+m53BTsr69ZF/ae2G4W/dqYa4cKHf1yh74RIzpai3N
         yuTj3Yx6LDBlT44dP5QVZDqEwiKhySNOVmctwaKNjT5xcUdM78ne2zulcLi4Sea4W8b8
         wpiHU6M02oUx8SBdwJtUD3mPI74L6Win0u96Gy9HTFhD8Issp7ALusBLeTCqAOvr8DvS
         w+iw==
X-Forwarded-Encrypted: i=1; AFNElJ84FsB+8QmBMaRELcsl14J6gNtubpgZQ8vfUSJhV8tMkqdvciez08ejogL2P1oRuxmrilfS9Y+NM6r3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03ySZkOwRIrjK9Rgwks6gnR8hdJIX3ogSzqSTndBUFq9STyix
	19poV5NwZAlaE9GgQe2tq2ykjpXLRcXiINsqiUYtYfVMZGpCwXFHG3/qFk6Xx1OhWTSHEQ7BVf2
	AauMElanuhvsRbBJFG/QkoPfKnzVl1oxNivd37DyEUhLjlP6K5IqNVdLNvlN/OXTYL8k5vUc=
X-Gm-Gg: AeBDievyEtmP+VUDtpVdSI/4g0iYu55Z1oelHLOpxeDL+eO6Pz99bFWn8ra4hU0nr2X
	Q7Ck6oLmKjQ1G9qpvh4Mt+bdKkEqUF0lAsA4aKA0HtEFEkbCUZ1YxC3C7XxTWYw6KW+6+phCy25
	70d7hiuQvTYoTHP06yGYtU6Zp7nYzdUrF0ExMeGCwgJ8tJ/eKi/NNXvr58Xf3k0SIxVIIotmfgy
	zFOTCS6kEUHsieOWiFRZUVUZyiGsp6TKJDzsrjCgNi8VwrPzIGaLoG+ClUSxdA/976/b1KYK+ds
	tWq2zA8iM4C8Y6Eb/mZRGjzgiv3p9bqITQRIX+pMp7Pr4zlAXSANkox+dIaBJh42zbTdlI8utK5
	TLIHRBNBwdnQ9ApkWKte1oxDpqU4R1RQ+XN0QvHs+gajaA4ohNM5+gap5lkl3mWU=
X-Received: by 2002:a05:690e:d57:b0:651:c71d:8a4f with SMTP id 956f58d0204a3-65c18f8ae91mr15537d50.51.1777497778377;
        Wed, 29 Apr 2026 14:22:58 -0700 (PDT)
X-Received: by 2002:a05:690e:d57:b0:651:c71d:8a4f with SMTP id 956f58d0204a3-65c18f8ae91mr15516d50.51.1777497777858;
        Wed, 29 Apr 2026 14:22:57 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff4c19aasm1813163d50.3.2026.04.29.14.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:57 -0700 (PDT)
Message-ID: <f3ff03de8cadd533fbe71f271f61890e856f3b06.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v3 03/11] ceph: harden send_mds_reconnect and
 handle active-MDS peer reset
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Wed, 29 Apr 2026 14:22:56 -0700
In-Reply-To: <20260429125206.1512203-4-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
	 <20260429125206.1512203-4-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-29 at 12:51 +0000, Alex Markuze wrote:
> Change send_mds_reconnect() to return an error code so callers can detect
> and report reconnect failures instead of silently ignoring them. Add earl=
y
> bailout checks for sessions that are already closed, rejected, or
> unregistered, which avoids sending reconnect messages for sessions that
> can no longer be recovered.
>=20
> The early -ESTALE and -ENOENT bailouts use a separate fail_return label
> that skips the pr_err_client diagnostic, since these codes indicate
> expected concurrent-teardown races rather than genuine reconnect build
> failures.
>=20
> Move the "reconnect start" log after the early-bailout checks so it
> only appears for sessions that actually proceed with reconnect.
>=20
> Save the prior session state before transitioning to RECONNECTING,
> and restore it in the failure path.  Without this, a transient
> build or encoding failure (-ENOMEM, -ENOSPC) strands the session
> in RECONNECTING indefinitely because check_new_map() only retries
> sessions in RESTARTING state.
>=20
> Rewrite mds_peer_reset() to handle the case where the MDS is past its
> RECONNECT phase (i.e. active). An active MDS rejects CLIENT_RECONNECT
> messages because it only accepts them during its own RECONNECT window
> after restart. Previously, the client would send a doomed reconnect
> that the MDS would reject or ignore. Now, the client tears the session
> down locally and lets new requests re-open a fresh session, which is
> the correct recovery for this scenario. The RECONNECTING state is
> handled on the same teardown path, since the MDS will reject reconnect
> attempts from an active client regardless of the session's local state.
>=20
> Add explicit cases for CLOSED and REJECTED session states in
> mds_peer_reset() since these are terminal states where a connection
> drop is expected behavior.
>=20
> The session teardown path in mds_peer_reset() follows the established
> drop-and-reacquire locking pattern from check_new_map(): take
> mdsc->mutex for session unregistration, release it, then take s->s_mutex
> separately for cleanup. This avoids introducing a new simultaneous lock
> nesting pattern.
>=20
> Log reconnect failures from check_new_map() and mds_peer_reset() at
> pr_warn level rather than pr_err, since return codes like -ESTALE
> (closed/rejected session) and -ENOENT (unregistered session) are
> expected during concurrent teardown. Log dropped messages for
> unregistered sessions via doutc() (dynamic debug) rather than
> pr_info, as post-reset message arrival is routine and does not
> warrant unconditional logging.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/mds_client.c | 169 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 155 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 871f0eef468d..b62abae72c4c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4416,9 +4416,14 @@ static void handle_session(struct ceph_mds_session=
 *session,
>  		break;
> =20
>  	case CEPH_SESSION_REJECT:
> -		WARN_ON(session->s_state !=3D CEPH_MDS_SESSION_OPENING);
> -		pr_info_client(cl, "mds%d rejected session\n",
> -			       session->s_mds);
> +		WARN_ON(session->s_state !=3D CEPH_MDS_SESSION_OPENING &&
> +			session->s_state !=3D CEPH_MDS_SESSION_RECONNECTING);
> +		if (session->s_state =3D=3D CEPH_MDS_SESSION_RECONNECTING)
> +			pr_info_client(cl, "mds%d reconnect rejected\n",
> +				       session->s_mds);
> +		else
> +			pr_info_client(cl, "mds%d rejected session\n",
> +				       session->s_mds);
>  		session->s_state =3D CEPH_MDS_SESSION_REJECTED;
>  		cleanup_session_requests(mdsc, session);
>  		remove_session_caps(session);
> @@ -4678,6 +4683,14 @@ static int reconnect_caps_cb(struct inode *inode, =
int mds, void *arg)
>  	cap->mseq =3D 0;       /* and migrate_seq */
>  	cap->cap_gen =3D atomic_read(&cap->session->s_cap_gen);
> =20
> +	/*
> +	 * Note: CEPH_I_ERROR_FILELOCK is not set during reconnect.
> +	 * Instead, locks are submitted for best-effort MDS reclaim
> +	 * via the flock_len field below.  If reclaim fails (e.g.,
> +	 * another client grabbed a conflicting lock), future lock
> +	 * operations will fail and set the error flag at that point.
> +	 */
> +
>  	/* These are lost when the session goes away */
>  	if (S_ISDIR(inode->i_mode)) {
>  		if (cap->issued & CEPH_CAP_DIR_CREATE) {
> @@ -4892,20 +4905,19 @@ static int encode_snap_realms(struct ceph_mds_cli=
ent *mdsc,
>   *
>   * This is a relatively heavyweight operation, but it's rare.
>   */
> -static void send_mds_reconnect(struct ceph_mds_client *mdsc,
> -			       struct ceph_mds_session *session)
> +static int send_mds_reconnect(struct ceph_mds_client *mdsc,
> +			      struct ceph_mds_session *session)
>  {
>  	struct ceph_client *cl =3D mdsc->fsc->client;
>  	struct ceph_msg *reply;
>  	int mds =3D session->s_mds;
>  	int err =3D -ENOMEM;
> +	int old_state;
>  	struct ceph_reconnect_state recon_state =3D {
>  		.session =3D session,
>  	};
>  	LIST_HEAD(dispose);
> =20
> -	pr_info_client(cl, "mds%d reconnect start\n", mds);
> -
>  	recon_state.pagelist =3D ceph_pagelist_alloc(GFP_NOFS);
>  	if (!recon_state.pagelist)
>  		goto fail_nopagelist;
> @@ -4917,6 +4929,32 @@ static void send_mds_reconnect(struct ceph_mds_cli=
ent *mdsc,
>  	xa_destroy(&session->s_delegated_inos);

Is xa_destroy(&session->s_delegated_inos) thread safe now? If an in-flight =
async
create is mid-way through ceph_get_deleg_ino (which does xa_for_each + xa_e=
rase)
while xa_destroy runs on the same XArray from a different thread, that is
unsafe. What do you think?

> =20
>  	mutex_lock(&session->s_mutex);
> +	if (session->s_state =3D=3D CEPH_MDS_SESSION_CLOSED ||
> +	    session->s_state =3D=3D CEPH_MDS_SESSION_REJECTED) {
> +		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
> +			       mds,
> +			       ceph_session_state_name(session->s_state));
> +		mutex_unlock(&session->s_mutex);
> +		ceph_msg_put(reply);
> +		err =3D -ESTALE;
> +		goto fail_return;
> +	}
> +
> +	mutex_lock(&mdsc->mutex);

I started to guess is it safe to call mutex_lock(&mdsc->mutex) under sessio=
n-
>s_mutex lock? Could we introduce potential deadlock here?

> +	if (mds >=3D mdsc->max_sessions || mdsc->sessions[mds] !=3D session) {
> +		mutex_unlock(&mdsc->mutex);
> +		pr_info_client(cl,
> +			       "mds%d skipping reconnect, session unregistered\n",
> +			       mds);
> +		mutex_unlock(&session->s_mutex);
> +		ceph_msg_put(reply);
> +		err =3D -ENOENT;
> +		goto fail_return;
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +
> +	pr_info_client(cl, "mds%d reconnect start\n", mds);
> +	old_state =3D session->s_state;
>  	session->s_state =3D CEPH_MDS_SESSION_RECONNECTING;
>  	session->s_seq =3D 0;
> =20
> @@ -5046,18 +5084,34 @@ static void send_mds_reconnect(struct ceph_mds_cl=
ient *mdsc,
> =20
>  	up_read(&mdsc->snap_rwsem);
>  	ceph_pagelist_release(recon_state.pagelist);
> -	return;
> +	return 0;
> =20
>  fail:
>  	ceph_msg_put(reply);
>  	up_read(&mdsc->snap_rwsem);
> +	/*
> +	 * Restore prior session state so map-driven reconnect logic
> +	 * (check_new_map) can retry.  Without this, a transient build
> +	 * failure strands the session in RECONNECTING indefinitely.
> +	 */
> +	session->s_state =3D old_state;
>  	mutex_unlock(&session->s_mutex);
>  fail_nomsg:
>  	ceph_pagelist_release(recon_state.pagelist);
>  fail_nopagelist:
>  	pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
>  		      err, mds);
> -	return;
> +	return err;
> +
> +fail_return:
> +	/*
> +	 * Early-exit path for expected concurrent-teardown races
> +	 * (-ESTALE for closed/rejected sessions, -ENOENT for
> +	 * unregistered sessions).  Skip the pr_err_client diagnostic
> +	 * since these are not genuine reconnect build failures.
> +	 */
> +	ceph_pagelist_release(recon_state.pagelist);
> +	return err;
>  }
> =20
> =20
> @@ -5138,9 +5192,15 @@ static void check_new_map(struct ceph_mds_client *=
mdsc,
>  		 */
>  		if (s->s_state =3D=3D CEPH_MDS_SESSION_RESTARTING &&
>  		    newstate >=3D CEPH_MDS_STATE_RECONNECT) {
> +			int rc;
> +
>  			mutex_unlock(&mdsc->mutex);
>  			clear_bit(i, targets);
> -			send_mds_reconnect(mdsc, s);
> +			rc =3D send_mds_reconnect(mdsc, s);
> +			if (rc)
> +				pr_warn_client(cl,
> +					       "mds%d reconnect failed: %d\n",
> +					       i, rc);
>  			mutex_lock(&mdsc->mutex);
>  		}
> =20
> @@ -5204,7 +5264,11 @@ static void check_new_map(struct ceph_mds_client *=
mdsc,
>  		}
>  		doutc(cl, "send reconnect to export target mds.%d\n", i);
>  		mutex_unlock(&mdsc->mutex);
> -		send_mds_reconnect(mdsc, s);
> +		err =3D send_mds_reconnect(mdsc, s);
> +		if (err)
> +			pr_warn_client(cl,
> +				       "mds%d export target reconnect failed: %d\n",
> +				       i, err);
>  		ceph_put_mds_session(s);
>  		mutex_lock(&mdsc->mutex);
>  	}
> @@ -6284,12 +6348,87 @@ static void mds_peer_reset(struct ceph_connection=
 *con)
>  {
>  	struct ceph_mds_session *s =3D con->private;
>  	struct ceph_mds_client *mdsc =3D s->s_mdsc;
> +	int session_state;
> =20
>  	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
>  		       s->s_mds);
> -	if (READ_ONCE(mdsc->fsc->mount_state) !=3D CEPH_MOUNT_FENCE_IO &&
> -	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >=3D CEPH_MDS_STATE_R=
ECONNECT)
> -		send_mds_reconnect(mdsc, s);
> +
> +	if (READ_ONCE(mdsc->fsc->mount_state) =3D=3D CEPH_MOUNT_FENCE_IO ||
> +	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) < CEPH_MDS_STATE_RECO=
NNECT)
> +		return;
> +
> +	if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) =3D=3D CEPH_MDS_STATE=
_RECONNECT) {

We had >=3D CEPH_MDS_STATE_RECONNECT before. When an MDS restarts, it moves
through these states in order:

  RECONNECT    (10)  -> waits for clients to reconnect
  REJOIN       (11)  -> rejoins the distributed MDS cache
  CLIENTREPLAY (12)  -> replays in-flight client operations
  ACTIVE       (13)  -> fully operational

If the connection dropped and the MDS was in any of those four states, the
client sent a CLIENT_RECONNECT message. REJOIN (11) and CLIENTREPLAY (12) n=
ow
fall through to the teardown path, not the reconnect path.

Thanks,
Slava.

> +		int rc =3D send_mds_reconnect(mdsc, s);
> +
> +		if (rc)
> +			pr_warn_client(mdsc->fsc->client,
> +				       "mds%d reconnect failed: %d\n",
> +				       s->s_mds, rc);
> +		return;
> +	}
> +
> +	/*
> +	 * MDS is active (past RECONNECT).  It will not accept a
> +	 * CLIENT_RECONNECT from us, so tear the session down locally
> +	 * and let new requests re-open a fresh session.
> +	 *
> +	 * Snapshot session state with READ_ONCE, then revalidate under
> +	 * mdsc->mutex before acting.  The subsequent mdsc->mutex
> +	 * section rechecks s_state to catch concurrent transitions, so
> +	 * the lockless snapshot here is safe.  s->s_mutex is taken
> +	 * separately for cleanup after unregistration, which avoids
> +	 * introducing a new s->s_mutex + mdsc->mutex nesting.
> +	 */
> +	session_state =3D READ_ONCE(s->s_state);
> +
> +	switch (session_state) {
> +	case CEPH_MDS_SESSION_RESTARTING:
> +	case CEPH_MDS_SESSION_RECONNECTING:
> +	case CEPH_MDS_SESSION_CLOSING:
> +	case CEPH_MDS_SESSION_OPEN:
> +	case CEPH_MDS_SESSION_HUNG:
> +	case CEPH_MDS_SESSION_OPENING:
> +		mutex_lock(&mdsc->mutex);
> +		if (s->s_mds >=3D mdsc->max_sessions ||
> +		    mdsc->sessions[s->s_mds] !=3D s ||
> +		    s->s_state !=3D session_state) {
> +			pr_info_client(mdsc->fsc->client,
> +				       "mds%d state changed to %s during peer reset\n",
> +				       s->s_mds,
> +				       ceph_session_state_name(s->s_state));
> +			mutex_unlock(&mdsc->mutex);
> +			return;
> +		}
> +
> +		ceph_get_mds_session(s);
> +		s->s_state =3D CEPH_MDS_SESSION_CLOSED;
> +		__unregister_session(mdsc, s);
> +		__wake_requests(mdsc, &s->s_waiting);
> +		mutex_unlock(&mdsc->mutex);
> +
> +		mutex_lock(&s->s_mutex);
> +		cleanup_session_requests(mdsc, s);
> +		remove_session_caps(s);
> +		mutex_unlock(&s->s_mutex);
> +
> +		wake_up_all(&mdsc->session_close_wq);
> +
> +		mutex_lock(&mdsc->mutex);
> +		kick_requests(mdsc, s->s_mds);
> +		mutex_unlock(&mdsc->mutex);
> +
> +		ceph_put_mds_session(s);
> +		break;
> +	case CEPH_MDS_SESSION_CLOSED:
> +	case CEPH_MDS_SESSION_REJECTED:
> +		break;
> +	default:
> +		pr_warn_client(mdsc->fsc->client,
> +			       "mds%d peer reset in unexpected state %s\n",
> +			       s->s_mds,
> +			       ceph_session_state_name(session_state));
> +		break;
> +	}
>  }
> =20
>  static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *m=
sg)
> @@ -6301,6 +6440,8 @@ static void mds_dispatch(struct ceph_connection *co=
n, struct ceph_msg *msg)
> =20
>  	mutex_lock(&mdsc->mutex);
>  	if (__verify_registered_session(mdsc, s) < 0) {
> +		doutc(cl, "dropping tid %llu from unregistered session %d\n",
> +		      le64_to_cpu(msg->hdr.tid), s->s_mds);
>  		mutex_unlock(&mdsc->mutex);
>  		goto out;
>  	}

