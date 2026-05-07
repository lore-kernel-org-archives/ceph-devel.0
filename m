Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EF3C2761
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179418; cv=none; b=b0Mi+jnIq7i61ghaFWE1uEwn7s63Km7nR4DhA2adw96DVS009IuNjLxXIQi1Hq3e22nOR8oOwEXOMmZDq99ST8DZkaorBtaN/giAMTa5NC3dwYR9JnbRZa/hILXCh8/Zcq6FcavMofCJOmou8ZRUOqaW3QGmCpI7rtOixgviARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179418; c=relaxed/simple;
	bh=KSBXFHDbCJbfKMv6RGLqylbRYWyMQHdVE787ngyXHMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vvh9/eaf8T6/JelcAeXmRQcU1tvTyQX2/aUvSmCkPcABXctFYAVNaBeX29iiXS/giblRvWYnMwXRfW3Mb+XRV9fjYRQSwyGE7cmw9xrMY6zebE6Vojoe3QIEGkIqIAwWgp7M1dqo5hyj1KuPbtzU4WHRv6Ch21OGO4DleMnP2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGoTpdBl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzfisqOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGoTpdBl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzfisqOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778179415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lncWYBc0spi8cvF4zW0Ybg0AzF3GoMiippbuzqynaBE=;
	b=SGoTpdBlaRtLJNj5rmbOoknvpENnzoX/JQ/Hx080l5RnNn7ZwIzQKp8bbb6QSU3xXh8ulb
	UL4HM+q0FngR2egyTh/oTPTsdFmhDHMwRispW7KYcB+CMrFU8lPGkjWjmrgrP3FcBMTBou
	UEpne1v9pkP1M3gXGoEJMYk1GUBoR1U=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-dvDdFSrwPYaYP2yQJQAvZQ-1; Thu, 07 May 2026 14:43:34 -0400
X-MC-Unique: dvDdFSrwPYaYP2yQJQAvZQ-1
X-Mimecast-MFC-AGG-ID: dvDdFSrwPYaYP2yQJQAvZQ_1778179413
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79064868702so34778907b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778179413; x=1778784213; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lncWYBc0spi8cvF4zW0Ybg0AzF3GoMiippbuzqynaBE=;
        b=SzfisqOPw9xM66frY502hjUhNfrrIPofgTP0IBWND6DQCSF0JKy7SY8f3NfzhJhjmy
         YRgpyjShFmfdxM91EL6oLPPQfFMnK9q0H9GdImDqoPVUYoLlaxzfX5jXx8jw08kNrdUx
         W2q9qDBgp2kz2LY5L6XgOKQXUVizNpYKrppPHUYD2ScE36BVKAzDZXE2N04UWdymo1Z6
         763fRSeg2x7LT2rvPsleakchEp9sYZq1NYpZk6xkPOQjaVLZmE/tPBk8ULGoqFAhMJ7K
         tNUMjCU5O0Pi+J0MEh9K2vw9BexKvyOE9hiCxJ7mVZpo3hAtqzL2lzeSkkaTlrLuERsT
         l1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179413; x=1778784213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lncWYBc0spi8cvF4zW0Ybg0AzF3GoMiippbuzqynaBE=;
        b=Ck/LXN1iCUh3CTfDCNt5FYU/QUMKfZr2JqlLIHMrPE0cNdVAwF5AJ4tV2ivhg9fV7N
         IMoTGJeD9atneUEfWIUlOrYUhAW9w5veAfsoo4hXps0LvPOAXA8aIDik5gewJgrnvQv+
         Tcj1fXzu+F+hxLDe3D9jNyD2OaH7maMzYckqDwlJfWoxl+Q1EfYZzdaDanZpavHODmUx
         W6FuY71ObtYcS0eRRCe6qN75HammvqTlpJJGeNz27j4g2YyQP8AAhB+7xadJnT58Ws2m
         6ZezDDBhMM29vVXH+pLWlzXy0QEeZfwZjfGZSOLMxVZD9xeGkc8S9rqk5K855nYOMA2G
         xDkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+znSNW4xukuZhVdaLijNpYjBUKDss8ZtQvF7RXF2wOt+Mpueb1FML7XhtGYNTKKJjewOPVHi7rCVjH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsow1VEVU2hezAY/ET1RTZKbvk9Vr3DKsH/PU7fx7vFT0KnT24
	fOQPsuxS02QaOU2haG3nQpoBjxXWe057cm6Ke8ghnN9xyU7j0Ln8vksHUATy8KpNK1go+lna1ou
	/ln0pJp9cqzwKJZjmpS9TDerv4femVKzp8teHK2jh2kG8dAvECFo2rsE1/zuwE/IlDGwh8Tc=
X-Gm-Gg: Acq92OHUQ/1LNZip2eaRrRYfO0xiANq8+iNtA72NX3JALxjJ92QVOFhJgMiJ+ghPpV4
	9vJhu+anL8i7nugqj3Fq5z8lyxJ0jldhrUd0qSNMf59spzDPbLpmmpX830pEtDtebQUPLdNVuvo
	wsqZdHWDWdkGlUCAFpKjjvzKbNlBMx/vWF67fpJ8OHYZPMl8o/RILmt6Z+KjHpgXXbizhHqEulf
	WUpa3LDsvsUvKWg0luCySfBeFXZikvw/iJ/KMV5NI+Q8KpcDDJYUf+yfI3XcgNfGYzlzE7lMBAV
	7ID19jcCznJvy5De3xp5QVAbKXPNQuUhMprR150EJhgIUsbggf6zl5BqYDz3M5rm1gxMy9lFXVI
	9gHZq5wiVy2yL3kdC/5Cr3buS7LQJLVMe+QWTVsxZHYn2y3bhLbyI
X-Received: by 2002:a05:690c:360a:b0:7ba:ee75:f115 with SMTP id 00721157ae682-7bdf5d8d6eamr109600787b3.4.1778179412852;
        Thu, 07 May 2026 11:43:32 -0700 (PDT)
X-Received: by 2002:a05:690c:360a:b0:7ba:ee75:f115 with SMTP id 00721157ae682-7bdf5d8d6eamr109600497b3.4.1778179412188;
        Thu, 07 May 2026 11:43:32 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652742csm94988847b3.9.2026.05.07.11.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:43:31 -0700 (PDT)
Message-ID: <bf9683e2e3b14139d0faf66ca8ea124611044cfb.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 03/11] ceph: harden send_mds_reconnect and
 handle active-MDS peer reset
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 11:43:30 -0700
In-Reply-To: <20260507122737.2804094-4-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-4-amarkuze@redhat.com>
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
>  fs/ceph/mds_client.c | 178 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 163 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d9543399b129..249419c17d3c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4470,9 +4470,14 @@ static void handle_session(struct ceph_mds_session=
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
> @@ -4732,6 +4737,14 @@ static int reconnect_caps_cb(struct inode *inode, =
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
> @@ -4946,20 +4959,19 @@ static int encode_snap_realms(struct ceph_mds_cli=
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
> @@ -4968,9 +4980,37 @@ static void send_mds_reconnect(struct ceph_mds_cli=
ent *mdsc,
>  	if (!reply)
>  		goto fail_nomsg;
> =20
> +	mutex_lock(&session->s_mutex);
> +
> +	/* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
>  	xa_destroy(&session->s_delegated_inos);
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
> =20
> -	mutex_lock(&session->s_mutex);
> +	/* s_mutex -> mdsc->mutex matches cleanup_session_requests() order. */
> +	mutex_lock(&mdsc->mutex);
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
> @@ -5100,7 +5140,7 @@ static void send_mds_reconnect(struct ceph_mds_clie=
nt *mdsc,
> =20
>  	up_read(&mdsc->snap_rwsem);
>  	ceph_pagelist_release(recon_state.pagelist);
> -	return;
> +	return 0;
> =20
>  fail_clear_cap_reconnect:
>  	spin_lock(&session->s_cap_lock);
> @@ -5109,13 +5149,29 @@ static void send_mds_reconnect(struct ceph_mds_cl=
ient *mdsc,
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
> @@ -5196,9 +5252,15 @@ static void check_new_map(struct ceph_mds_client *=
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
> @@ -5262,7 +5324,11 @@ static void check_new_map(struct ceph_mds_client *=
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
> @@ -6350,12 +6416,92 @@ static void mds_peer_reset(struct ceph_connection=
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
> +	/*
> +	 * Only reconnect if MDS is in its RECONNECT phase.  An MDS past
> +	 * RECONNECT (REJOIN, CLIENTREPLAY, ACTIVE) will reject reconnect
> +	 * attempts, so those states fall through to session teardown below.
> +	 */
> +	if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) =3D=3D CEPH_MDS_STATE=
_RECONNECT) {
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
> @@ -6367,6 +6513,8 @@ static void mds_dispatch(struct ceph_connection *co=
n, struct ceph_msg *msg)
> =20
>  	mutex_lock(&mdsc->mutex);
>  	if (__verify_registered_session(mdsc, s) < 0) {
> +		doutc(cl, "dropping tid %llu from unregistered session %d\n",
> +		      le64_to_cpu(msg->hdr.tid), s->s_mds);
>  		mutex_unlock(&mdsc->mutex);
>  		goto out;
>  	}

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

