Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1639478F
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898522; cv=none; b=RJXt8DWMPpnd9FU8bQ+FqB7PYhXIMy5G8xDGIbylpjzCvjfDtJ/h8DHEcZfU1IjUzl3PzWLXNIP1ACtS76S2OqxgZc6/UDN+oGN6hbp63fE+ZBxPk6hNMieG/Cup9dkl1a+zT6P1LCHEQha8spZ+zoGUYuzmmF0hd+DAXtU1jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898522; c=relaxed/simple;
	bh=i+fKbVYLyG/jF+wCpG3R3XVn45h7NFQOrVfdzPjQrGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KB2bLoNaMRGpi9BNleyRflTwxn7f8dXIDaMp/Jaq+dWR1ddgo5RCk66V53YR9OM+WRJeeoe4gDQ3cRhgE88KMzyVGVsxutkXvJ7ocnfVcz7kOAXf4jIrajBbR+xzpwAJcfiO2YwcWETVcYPrsz0opnK7snpiioKrpGUGk4A61wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvUAJNpZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d75M/XuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvUAJNpZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d75M/XuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774898519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fBN9qywuCgSvKEzMHjrd742nj2ICqZxv1X+3gC9rdw=;
	b=TvUAJNpZrApHdZS1TqzjK/yws1TTlMT0qTDqLH3h0aQQqW36OOQ+AOLILrsTFmsEspX3aH
	zr/s9e2oVWoqwMjRbWT0g5uXk/Wb/TXzbwk2A4DsW7abw39zZ1fwypMTjCv3/84M2P1yRT
	5yPVDAKE6nJ5v1x/URz+JRGIGGxE67g=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-KBUcZaNaO-eYgZHUNlptGQ-1; Mon, 30 Mar 2026 15:21:57 -0400
X-MC-Unique: KBUcZaNaO-eYgZHUNlptGQ-1
X-Mimecast-MFC-AGG-ID: KBUcZaNaO-eYgZHUNlptGQ_1774898517
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64eb0bbab48so3820550d50.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774898517; x=1775503317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3fBN9qywuCgSvKEzMHjrd742nj2ICqZxv1X+3gC9rdw=;
        b=d75M/XuPXOwCnGvxCeyYQrsYHBwqL9S3K/WX2433WCEmeVlBhNgqoixwbHaKyOvJ2P
         VSfOLtBDY0e8F8X5e6ECrbMdVY8wTRfLvPN/tbOiSn8CZ2+LLL7K3GosPj6y3p3GgKlt
         yfxyre+cKqBuggj5e8+7I3cfvluq/ECAkl/Q2gBNQt8ENGRznn3rhHh4HdyExt3J+KNS
         2O+onpPgyqz6YL3spy9WfKFZjeZEFSBJCA92ILD9oVfNMET7FOM0ecYJVvQuGlixEQ+D
         PPdS8dvHd1yINekwDMj9avuy7njSj98/M6Zu3b4t+cSETE3Ul3NTrnmz241tioC1DtyD
         mgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898517; x=1775503317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fBN9qywuCgSvKEzMHjrd742nj2ICqZxv1X+3gC9rdw=;
        b=ZTUiYeKa89GcvGURJscBsDnYJSh6jWE+nf6kQElOksi12zu6YJZebIwNdmBhTewSC6
         K48TG7UFoLfi+0B/tb6ScIQ5tDgoH8PRgMQYkqfBzWyncgxqjErMZo0hYLgzQ6pCLnZX
         kXeMY0ls/tBzO00TrScqT2h+Jcu1s7yklISIcqTxJstC6HjhCrmjUn20fzt11Wb3XyZ5
         ZJaW2OhhMgSFyue8iDdV5ETcJnanD+Gdzf8QkW1nqe9uQPLccjLN5qAxa6FKmUfQmJjs
         r1RrDArtgtv32ldfkpdT3Owyuv9wYtAsRVvj46jCwo0/ujDC/R6Cdhe+Of/dIqpoRaIX
         55KA==
X-Forwarded-Encrypted: i=1; AJvYcCWpMm1PcD2gbsUMfOmJNoDKQqG7NL46oEM5U9euBAvsQwAP1kH7Z8HlphOQGFKLjkyiVJV78Dy4TJ4x@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoMW+dpw5J0F2ZRix3JztRoSoqkcdUOrp0ocweUKG6bB1ueVh
	Om2ozqrH2FN27DIEIwj9nWuyUtOZVr4jsc1vDdboubKfxASGVoWE678vytn6mfCD0uL9k/1vE0S
	WoNsHldRBPI96fFHWYjtlysh56iKvskRK9rbfxbABh98csyDVxLTVKxBErcb2LsI=
X-Gm-Gg: ATEYQzzWRETBTo4leFGIfCYEKye/QoVOWFH+H5/r8TcSNX16xX34zUaNkNxSRsK0kAZ
	vlsqU3Q3Ss3JyMakL+QUGmThd/6mXM59S+ASU9c0bEfOjYzsOI0Fl6+5Dizhhdcao7+SCgi/zHV
	9vTSwVTkp2LdMSHowK1IVuOyzZQsODU4KVUaZCR8IPpB4g3zzyT+Tb2YNxFA9bFZobMzEFJCuNF
	+nx3jWP7c7qxASFSfEfpL+lOzArgkN9+0kijHC6kT57zN95Yj3vYpCFeb7f1aWhGwmOVPpd6fRN
	o4mQsgufqHt83cERyCQ2BEuJbXePlW67OrP+FKSuU8Wg6Uf0s+3Nsi/rm5GqpsmGVSv3/O5Hx2b
	Q2SEF8SyuD0lFursxDJw+r/8wjDv0y/Dshzk5cG2mvnsqr8arUE+0
X-Received: by 2002:a05:690c:690b:b0:794:c2fc:73b1 with SMTP id 00721157ae682-7a0a0b3fd3cmr9232397b3.2.1774898516620;
        Mon, 30 Mar 2026 12:21:56 -0700 (PDT)
X-Received: by 2002:a05:690c:690b:b0:794:c2fc:73b1 with SMTP id 00721157ae682-7a0a0b3fd3cmr9232147b3.2.1774898516124;
        Mon, 30 Mar 2026 12:21:56 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cba95b868sm38875387b3.45.2026.03.30.12.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:21:55 -0700 (PDT)
Message-ID: <fe3af6ee370b19061d8742ef5cc2032714530606.camel@redhat.com>
Subject: Re: [PATCH 07/10] ceph: add reset state machine, drain phase, and
 status reporting
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 30 Mar 2026 12:21:54 -0700
In-Reply-To: <20260327143045.1393612-8-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
	 <20260327143045.1393612-8-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 14:30 +0000, Alex Markuze wrote:
> Track manual reset progress with explicit phases so blocked callers and
> debugfs status can distinguish quiescing, draining, and teardown. Add a
> bounded best-effort drain window before session teardown and report the
> outcome so operators can see whether dirty state drained or had to be
> dropped.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/debugfs.c    |  14 ++++--
>  fs/ceph/mds_client.c | 116 ++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/mds_client.h |  16 ++++--
>  3 files changed, 127 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 9e2c32fb1f38..88969dc5dde5 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -374,8 +374,10 @@ static int reset_status_show(struct seq_file *s, voi=
d *p)
>  	u64 trigger =3D 0, success =3D 0, failure =3D 0;
>  	unsigned long last_start =3D 0, last_finish =3D 0;
>  	int last_errno =3D 0;
> -	bool in_progress =3D false;
> +	enum ceph_client_reset_phase phase =3D CEPH_CLIENT_RESET_IDLE;
>  	bool inject_error =3D false;
> +	bool drain_timed_out =3D false;
> +	int sessions_reset =3D 0;
>  	int pending_reconnects =3D 0;
>  	int blocked_requests =3D 0;
>  	char reason[CEPH_CLIENT_RESET_REASON_LEN];
> @@ -392,15 +394,17 @@ static int reset_status_show(struct seq_file *s, vo=
id *p)
>  	last_start =3D st->last_start;
>  	last_finish =3D st->last_finish;
>  	last_errno =3D st->last_errno;
> -	in_progress =3D st->in_progress;
> +	phase =3D st->phase;
>  	inject_error =3D st->inject_error;
> +	drain_timed_out =3D st->drain_timed_out;
> +	sessions_reset =3D st->sessions_reset;
>  	strscpy(reason, st->last_reason, sizeof(reason));
>  	spin_unlock(&st->lock);
> =20
>  	pending_reconnects =3D atomic_read(&st->pending_reconnects);
>  	blocked_requests =3D atomic_read(&st->blocked_requests);
> =20
> -	seq_printf(s, "in_progress: %s\n", in_progress ? "yes" : "no");
> +	seq_printf(s, "phase: %s\n", ceph_reset_phase_name(phase));
>  	seq_printf(s, "trigger_count: %llu\n", trigger);
>  	seq_printf(s, "success_count: %llu\n", success);
>  	seq_printf(s, "failure_count: %llu\n", failure);
> @@ -419,6 +423,10 @@ static int reset_status_show(struct seq_file *s, voi=
d *p)
>  		   reason[0] ? reason : "(none)");
>  	seq_printf(s, "inject_error_pending: %s\n",
>  		   inject_error ? "yes" : "no");
> +	seq_printf(s, "drain_timed_out: %s\n",
> +		   drain_timed_out ? "yes" : "no");

While phase =3D=3D IDLE, drain_timed_out reflects the previous run's outcom=
e. Should
we comment it somehow?

> +	seq_printf(s, "sessions_reset: %d\n", sessions_reset);
> +	/* pending_reconnects: always 0 for manual reset (MDS-reconnect only) *=
/

Is it actual comment? The pending_reconnects can be non-zero during the
QUIESCING phase. Am I right?

>  	seq_printf(s, "pending_reconnects: %d\n", pending_reconnects);
>  	seq_printf(s, "blocked_requests: %d\n", blocked_requests);
> =20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 766744468dd6..287cee71227b 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3757,7 +3757,7 @@ int ceph_mdsc_submit_request(struct ceph_mds_client=
 *mdsc, struct inode *dir,
>  	 * If a reset is in progress, wait for it to complete.
>  	 *
>  	 * This is best-effort: a request can pass this check just
> -	 * before in_progress is set and proceed concurrently with
> +	 * before the phase leaves IDLE and proceed concurrently with
>  	 * reset.  That is acceptable because (a) such requests will
>  	 * either complete normally or fail and be retried by the
>  	 * caller, and (b) adding lock serialization here would
> @@ -5215,9 +5215,20 @@ static void ceph_mdsc_reconnect_session_done(struc=
t ceph_mds_client *mdsc,
>  		complete(&st->reconnect_done);
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
>  /*
> - * Wait for a reset to complete if one is in progress.
> - * Returns 0 if reset completed successfully or wasn't in progress.
> + * Wait for an active reset to complete.
> + * Returns 0 if reset completed successfully or no reset was active.
>   * Returns -ETIMEDOUT if we timed out waiting.
>   * Returns -ERESTARTSYS if interrupted by signal.
>   */
> @@ -5229,7 +5240,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client=
 *mdsc)
>  	int blocked_count;
>  	int ret;
> =20
> -	if (!READ_ONCE(st->in_progress))
> +	if (READ_ONCE(st->phase) =3D=3D CEPH_CLIENT_RESET_IDLE)
>  		return 0;
> =20
>  	blocked_count =3D atomic_inc_return(&st->blocked_requests);
> @@ -5238,7 +5249,8 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client=
 *mdsc)
>  	trace_ceph_client_reset_blocked(mdsc, blocked_count);
> =20
>  	ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> -					       !READ_ONCE(st->in_progress),
> +					       READ_ONCE(st->phase) =3D=3D
> +						CEPH_CLIENT_RESET_IDLE,
>  					       timeout);
> =20
>  	atomic_dec(&st->blocked_requests);
> @@ -5274,7 +5286,7 @@ static void ceph_mdsc_reset_complete(struct ceph_md=
s_client *mdsc, int ret)
>  	spin_lock(&st->lock);
>  	st->last_finish =3D jiffies;
>  	st->last_errno =3D ret;
> -	st->in_progress =3D false;
> +	st->phase =3D CEPH_CLIENT_RESET_IDLE;
>  	if (ret)
>  		st->failure_count++;
>  	else
> @@ -5295,7 +5307,7 @@ static void ceph_mdsc_reset_workfn(struct work_stru=
ct *work)
>  	struct ceph_client *cl =3D mdsc->fsc->client;
>  	struct ceph_mds_session **sessions =3D NULL;
>  	char reason[CEPH_CLIENT_RESET_REASON_LEN];
> -	int max_sessions, i, n =3D 0;
> +	int max_sessions, i, n =3D 0, torn_down =3D 0;
>  	bool inject_error;
>  	int ret =3D 0;
> =20
> @@ -5373,6 +5385,70 @@ static void ceph_mdsc_reset_workfn(struct work_str=
uct *work)
>  		goto out_complete;
>  	}
> =20
> +	spin_lock(&st->lock);
> +	st->phase =3D CEPH_CLIENT_RESET_DRAINING;
> +	spin_unlock(&st->lock);
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
> +		u64 want_flush =3D mdsc->last_cap_flush_tid;
                struct ceph_cap_flush *cf =3D
                     list_last_entry(&mdsc->cap_flush_list,                =
   =20
                                   struct ceph_cap_flush, g_list);
> +		long drain_ret;

Should we add this code here?

                 cf->wake =3D true;

The existing wait_caps_flush() first sets cf->wake =3D true on the tail ent=
ry of
cap_flush_list before waiting.

> +
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
> +
>  	/*
>  	 * Tear down each session: close the connection, remove all
>  	 * caps, clean up requests, then kick pending requests so they
> @@ -5383,6 +5459,11 @@ static void ceph_mdsc_reset_workfn(struct work_str=
uct *work)
>  	 * teardown.  We do NOT attempt send_mds_reconnect() because
>  	 * the MDS only accepts reconnects during its own RECONNECT
>  	 * phase (after MDS restart), not from an active client.
> +	 *
> +	 * Any state that did not drain (caps that didn't flush, unsafe
> +	 * requests that the MDS didn't journal) is force-dropped here.
> +	 * This is intentional: that state is stuck and is the reason
> +	 * the operator triggered the reset.
>  	 */
>  	for (i =3D 0; i < n; i++) {
>  		int mds =3D sessions[i]->s_mds;
> @@ -5415,11 +5496,16 @@ static void ceph_mdsc_reset_workfn(struct work_st=
ruct *work)
>  		kick_requests(mdsc, mds);
>  		mutex_unlock(&mdsc->mutex);
> =20
> +		torn_down++;
>  		pr_info_client(cl, "mds%d session reset complete\n", mds);
>  	}
> =20
>  	kfree(sessions);
> =20
> +	spin_lock(&st->lock);
> +	st->sessions_reset =3D torn_down;
> +	spin_unlock(&st->lock);
> +
>  out_complete:
>  	ceph_mdsc_reset_complete(mdsc, ret);
>  }
> @@ -5441,22 +5527,24 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_clie=
nt *mdsc,
>  	}
> =20
>  	spin_lock(&st->lock);
> -	if (st->in_progress) {
> +	if (st->phase !=3D CEPH_CLIENT_RESET_IDLE) {
>  		spin_unlock(&st->lock);
>  		return -EBUSY;
>  	}
> =20
> -	st->in_progress =3D true;
> +	st->phase =3D CEPH_CLIENT_RESET_QUIESCING;
>  	st->active_reset_gen++;
>  	st->last_start =3D jiffies;
>  	st->last_errno =3D 0;
> +	st->drain_timed_out =3D false;
> +	st->sessions_reset =3D 0;
>  	st->trigger_count++;
>  	strscpy(st->last_reason, msg, sizeof(st->last_reason));
>  	spin_unlock(&st->lock);
> =20
>  	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
>  		spin_lock(&st->lock);
> -		st->in_progress =3D false;
> +		st->phase =3D CEPH_CLIENT_RESET_IDLE;
>  		st->last_errno =3D -EALREADY;
>  		st->failure_count++;
>  		spin_unlock(&st->lock);
> @@ -6017,8 +6105,10 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	mdsc->reset_state.last_start =3D 0;
>  	mdsc->reset_state.last_finish =3D 0;
>  	mdsc->reset_state.last_errno =3D 0;
> -	mdsc->reset_state.in_progress =3D false;
> +	mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
>  	mdsc->reset_state.inject_error =3D false;
> +	mdsc->reset_state.drain_timed_out =3D false;
> +	mdsc->reset_state.sessions_reset =3D 0;
>  	mdsc->reset_state.active_reset_gen =3D 0;
>  	mdsc->reset_state.last_reason[0] =3D '\0';
>  	atomic_set(&mdsc->reset_state.pending_reconnects, 0);
> @@ -6558,8 +6648,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
>  	 * if cancel_work_sync() prevents the work from running.
>  	 */
>  	spin_lock(&mdsc->reset_state.lock);
> -	if (mdsc->reset_state.in_progress) {
> -		mdsc->reset_state.in_progress =3D false;
> +	if (mdsc->reset_state.phase !=3D CEPH_CLIENT_RESET_IDLE) {
> +		mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
>  		mdsc->reset_state.last_errno =3D -ESHUTDOWN;
>  		mdsc->reset_state.failure_count++;
>  	}
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index c8269df1a9e5..87302755461c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -75,9 +75,16 @@ struct ceph_cap;
> =20
>  #define MDS_AUTH_UID_ANY -1
>  #define CEPH_CLIENT_RESET_REASON_LEN	64
> -#define CEPH_CLIENT_RESET_TIMEOUT_SEC	60

Is it safe to remove this declaration in the patch? Any compilation issues?

Thanks,
Slava.

> +#define CEPH_CLIENT_RESET_DRAIN_SEC	5
>  #define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
> =20
> +enum ceph_client_reset_phase {
> +	CEPH_CLIENT_RESET_IDLE =3D 0,
> +	CEPH_CLIENT_RESET_QUIESCING,
> +	CEPH_CLIENT_RESET_DRAINING,
> +	CEPH_CLIENT_RESET_TEARDOWN,
> +};
> +
>  struct ceph_client_reset_state {
>  	spinlock_t lock;
>  	u64 trigger_count;
> @@ -86,11 +93,13 @@ struct ceph_client_reset_state {
>  	unsigned long last_start;
>  	unsigned long last_finish;
>  	int last_errno;
> -	bool in_progress;
> +	enum ceph_client_reset_phase phase;
>  	bool inject_error;
> +	bool drain_timed_out;
> +	int sessions_reset;
>  	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
> =20
> -	/* Completion tracking for session reconnects */
> +	/* Async reconnect completion (used by mds_peer_reset path) */
>  	u64 active_reset_gen;
>  	atomic_t pending_reconnects;
>  	struct completion reconnect_done;
> @@ -588,6 +597,7 @@ extern struct ceph_mds_session *
>  __ceph_lookup_mds_session(struct ceph_mds_client *, int mds);
> =20
>  extern const char *ceph_session_state_name(int s);
> +extern const char *ceph_reset_phase_name(enum ceph_client_reset_phase ph=
ase);
> =20
>  extern struct ceph_mds_session *
>  ceph_get_mds_session(struct ceph_mds_session *s);

