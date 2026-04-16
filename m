Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A13E3D92
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367989; cv=none; b=XQf6RKE13wpUrDdik2FJhXoQeWBnb3UhVPVrD1tRdqojtPRpdImPkY74W1wbCcmrpPzLVcP8b/FiqtYSdK4LC3BfOwKsNFvTaA10upGSNfHpfcRTSrQ9uib1zc5FJb3m6ncsshTGiSaqqlo4//HaOQMq4EQvYmbi5ayIpn8kwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367989; c=relaxed/simple;
	bh=tF2U4uZwDlhkA84IXYsHqXEQUJ0+pnHuS7c6OGRI2uM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A2cnZhK9tsP+GM18Moe4PH4xKhV7Bj0tDTvJH5nw6Ahw3RBDLg+Su2BW1qJrvWLua1pxNsp8vb4h0RKN0nlGyfVLwbjVKYKWUUHz6TrXZfT2hR80i632zus9ODD73bjXaNPsXm/Foq14BiDnNHehfySHHYJ65GX6a/0tvemLuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyqH+3LP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rSP+6xXv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyqH+3LP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rSP+6xXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776367986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PgkOoNwqrS8ohO7sq2Ie2VKdlOy9hdcjNjtNOY0wRo=;
	b=KyqH+3LPt+apHdvg+de/H89d+vWzDzIcSqk9cG12SSEZSaMfP1P8VAUwGBreICPrg2QAfk
	GVG5s8fH9BpmG2nJbaX20D7bKnJax3faCRz6vK/eLASe2NTzT9LnugBMROwYjecybrkxH4
	KJmM61XcuzE/5xQh01+l67e5Ie+jtRY=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-HDEGErMtNAmLt6Xl0Gp-CA-1; Thu, 16 Apr 2026 15:33:05 -0400
X-MC-Unique: HDEGErMtNAmLt6Xl0Gp-CA-1
X-Mimecast-MFC-AGG-ID: HDEGErMtNAmLt6Xl0Gp-CA_1776367985
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-652cacbc35bso853549d50.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776367985; x=1776972785; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6PgkOoNwqrS8ohO7sq2Ie2VKdlOy9hdcjNjtNOY0wRo=;
        b=rSP+6xXvxOwrltcnzoU18xR6OmLWsWIy/3shIMWoq/fE5GMqnNA5g7rIEFMIt73soK
         f32uj+6t3l/OIoiosJT57z4hp9hh1o5qzcuybyqZSW0ZomaE2qe13ct1UtpylVnI8n9Z
         ilQyFRJi4bZ7pLuz3dbnUxaKc2Bmjym/p2EJQQfjO93EIE6IwP3PPhiVvpMZevy8dnaG
         uY8IE2y0P7I/cJ+grsTh9UnodLeqelDhAqEwSx2VBuQrUdf6WD57LGGF2bc73xG/CuYV
         IQx/kJroAFv8d0isHoXUtLtuvgO4LSEE4EPfNA3H9zX/BkGo3PeedlTXjny/8I90npWu
         Hg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367985; x=1776972785;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PgkOoNwqrS8ohO7sq2Ie2VKdlOy9hdcjNjtNOY0wRo=;
        b=acBSdv57gUzBsQZ1YSNITlrw5/hrWyMBgUmmcWk1GWqWFVg9/kMitEw9f1S7XAJ1ZZ
         T95Sxv1bpgMtTlil6mKjPUhRrs25bFt2KDqYlJNPDQu+t6tXuV9uG0R90wJw6EAjTt83
         7HqVA3yWThpSRKSwLLGXRzlwk9g36mlAippkQoSbGdW4xbmtQ/mmvUS+AZeJFFPyRRdS
         bMjB2fNQKE0xlBEKcpEh1SNLN54kCBu51O+HTStHwSAxABYMAu/jxB9oqsAc0qR1WO0J
         +KL2Xe+1rYfyfQ2nEEv979LpqKJKReobLZ3pdL2tuG2DhTS0W5zNX5C1iIdl1Ln7sZtS
         WPBA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZE20dgybuvP0vTwi9DMlJ4Z+E7LlOR8E39RNWgGl41bMEbnUpLMb6Bz40Zonl3iREPdm+tg7oiK/7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/NOBZCY6RZFBIiAZmeMwCAdnoa1ZobsxC7pVdqgKnOIpjyjI
	BRXuEIwErqHbQvqhxj/aCnY39RrfiNIIJO8cz4ZzW3xBoYrvvdOx1eCU0HAO4Ubq06hwyP7igQI
	Xn4EzF8VMnalH6nUnHey4fe1h37r5BmTzl69U7SnKPQZ8VGw18h0jbf+IxrlkghY=
X-Gm-Gg: AeBDiesMj1MOBz5neIUDcn9DlsqkebLEZLCay22AReoGRG+dO9qd8+YEZqK+IJXBCQv
	6KSauljD4w58qUtikwLpt41s2rADLHR04MYvnB52PZtr5GSmkTsddBcpk8+WNAhXas7vjirNVxd
	y1ngyFDPGdXHmKq/MaRtANBIe53lf4H8+OZD1qAUS371l/2K6bx3F0pr7/P++Xx9wNpg3AQ2waM
	ZEAijLJXroNvi2KSISs9lpX3CKEhgC4VZJIMfmHK1SN0/g7980lvGsAHSvTAKxWNOsN004gcJ/k
	yeZ6Le0Xuv+y/TPaGKRpmxGlshvxzI+9pDmBc46vgbhcTEOsxilbumBCRUzTj3M5hY2+GFoj6Mf
	VFHLDxe/Jfx9LBb2j9ImfN5C6pdgw9369oFw14cMZcFHdhUSOoMcKknk7GpqygZI=
X-Received: by 2002:a05:690e:d09:b0:650:1a8b:3df7 with SMTP id 956f58d0204a3-6530f2a3870mr379569d50.23.1776367984832;
        Thu, 16 Apr 2026 12:33:04 -0700 (PDT)
X-Received: by 2002:a05:690e:d09:b0:650:1a8b:3df7 with SMTP id 956f58d0204a3-6530f2a3870mr379536d50.23.1776367984239;
        Thu, 16 Apr 2026 12:33:04 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e4503aafsm2417454d50.6.2026.04.16.12.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:33:03 -0700 (PDT)
Message-ID: <d43e3117e96faedf5eb8e07a9f8d933622e0ac68.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v2 3/7] ceph: harden send_mds_reconnect and
 handle active-MDS peer reset
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 16 Apr 2026 12:33:02 -0700
In-Reply-To: <20260415170043.3882912-4-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
	 <20260415170043.3882912-4-amarkuze@redhat.com>
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
>  fs/ceph/mds_client.c | 163 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 151 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 871f0eef468d..b14ede808436 100644
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
> @@ -4892,13 +4905,14 @@ static int encode_snap_realms(struct ceph_mds_cli=
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
> @@ -4917,6 +4931,31 @@ static void send_mds_reconnect(struct ceph_mds_cli=
ent *mdsc,
>  	xa_destroy(&session->s_delegated_inos);
> =20

As far as I can see, we have this message at first [1]:

pr_info_client(cl, "mds%d reconnect start\n", mds);

And, then, we will have message "skipping reconnect". It looks like that we=
 need
to remove or move this message at the start of method.


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
> +	old_state =3D session->s_state;
>  	session->s_state =3D CEPH_MDS_SESSION_RECONNECTING;
>  	session->s_seq =3D 0;
> =20
> @@ -5046,18 +5085,34 @@ static void send_mds_reconnect(struct ceph_mds_cl=
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
> @@ -5138,9 +5193,15 @@ static void check_new_map(struct ceph_mds_client *=
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
> @@ -5204,7 +5265,11 @@ static void check_new_map(struct ceph_mds_client *=
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
> @@ -6284,12 +6349,84 @@ static void mds_peer_reset(struct ceph_connection=
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
> +	default:

It looks like that CEPH_MDS_SESSION_CLOSED and CEPH_MDS_SESSION_REJECTED wi=
ll be
treated as unexpected states. Is it correct? Do we need this fix here?

case CEPH_MDS_SESSION_CLOSED:
case CEPH_MDS_SESSION_REJECTED:
      break;  /* terminal states =E2=80=94 connection drop is expected */

Thanks,
Slava.

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
> @@ -6301,6 +6438,8 @@ static void mds_dispatch(struct ceph_connection *co=
n, struct ceph_msg *msg)
> =20
>  	mutex_lock(&mdsc->mutex);
>  	if (__verify_registered_session(mdsc, s) < 0) {
> +		doutc(cl, "dropping tid %llu from unregistered session %d\n",
> +		      le64_to_cpu(msg->hdr.tid), s->s_mds);
>  		mutex_unlock(&mdsc->mutex);
>  		goto out;
>  	}

[1] https://elixir.bootlin.com/linux/v7.0/source/fs/ceph/mds_client.c#L4905

