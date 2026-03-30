Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD13DD525
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892664; cv=none; b=MH2wm4U3PTIu7tsehANWyJCfWq4KMrIxzdGb7YrCrlNurw5AjFtBVvpxMw13Qr6U1S2I73JBcVma51U6cC/8ZVPOa/Vk4ntoqGnheAbR5X4vdH16ZjPHeR96WMWDhNPbEIAAlGPGJrAlHW+CAeJZhw2zvztdlDQExTGRcrZHc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892664; c=relaxed/simple;
	bh=6c8LiVDZmZfwjkw1bIdFCJVv3kG4O5DWBteSv6eAjZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkkJkz35T4GD9VpkAbXjupW3BEigkm8maPa23aavTAKGcqoirPc3hoZBd7CpmJzUw2ICqq+B8x1uxWHZRTauxYSXDx12vdsDdamNjIQagrCvZxPjmzCyV9+wPNWIdnFtkhKuz1U1mu/trR3Xbv3G2gGT8+YXrhUhjOevj/lRO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEv2anuU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nGcl02KL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEv2anuU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nGcl02KL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774892662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpkaZQtteamykgvTVRt0q7cxvF2H6rsfMzPLTEUsazM=;
	b=SEv2anuUh7gEgOmki7NEy3HEfaAquLzYSOPU27EYnlyPfMh2WGDoXKuulNhaPa25Kxpv9+
	54v6x3m7VWILJz94cF2HfRj72sQhg8Y1RNgNMygDd7ISw41SQn60xwcC76dioGDDj9gojE
	/ZAqF9cJFVtCVa3UX/MWD/L5eA90iR8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-zHelwk40Od6fnLHFCOJPwA-1; Mon, 30 Mar 2026 13:44:20 -0400
X-MC-Unique: zHelwk40Od6fnLHFCOJPwA-1
X-Mimecast-MFC-AGG-ID: zHelwk40Od6fnLHFCOJPwA_1774892660
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b781542c1so113412541cf.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774892660; x=1775497460; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wpkaZQtteamykgvTVRt0q7cxvF2H6rsfMzPLTEUsazM=;
        b=nGcl02KLOIsyHIDcxOQqk0qVkNZ/ixvkKNJm73RLLXrbJ/YraDbxTGTuH/hSX5yOX+
         x+E5K3KY6bqo/G98R22JXXHOkLszA7VtyEsxGsXBRnzf04MReJLLbyYrgdWG/eL+CRCk
         HbDO/eWa5JQwJOgf6Imy8HYMlBET6PHZtqR33MH0izLvHGuyIdNW8GWNy31SEF8WU1W/
         6Qi17OnQJoOn2yXw9v3qFwm5FmQ1vXaJ4xoFRko92siP1ZVRMrTmuDrmpvlhuIrPTW1G
         THEUFL3FnAp6LGXCVG3V4GiJJhjDZa2Nq6/X2Y6aAZae/1SYLsulJaSS3/PnsdnxISJr
         NZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892660; x=1775497460;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpkaZQtteamykgvTVRt0q7cxvF2H6rsfMzPLTEUsazM=;
        b=PdPA2e6Wj2IZaSir0eg9nn8mADvNqLjcFGZvzZ8vBxOxQzC7a4ZsR7ul7DtilH3MIQ
         dG52PZNmvCrMKOk5ZWTkDMWfjRq7x5ZWfZzr1JCeNTzqnwi50YjRXU7OetU0C3pOGUiT
         Di47FGG5mPkANbSJqcZc6rVSo2vv2Q8eFNBKl4+o2DNjwJZkuNZDLPvwZ4UUEJxxLusX
         y6EbHCviaWLHIPfazV0vdSEhApcKVaPqRP5mvKseLQg+x/dVIgJxC+uXxDGntD3Ie/vt
         EWgPTHTtW4QLPfJo+E70WROyYKt7RiOTwThvTkZaZmRimjEfGhUBJPZsCwHyEcVNACJ9
         ozBg==
X-Forwarded-Encrypted: i=1; AJvYcCWbt5OVsKM1enpRsLiXF6NtiWGu8AGGidQ72gV0xLlRBByJcat1HMEgUpca9jA3BUQQ1A3Z4TBzLIEp@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtN7kvUabnkifLc9YmMye9Y+sG/8Ev/xdA9IZDH5SUBmjxQd5
	KSMKAZgfEh9D6jWu5tWdhZpbwucZxshf/0MrpLo2Oy4hK4NqeTAMlnUd8MHHS+XGe30pGM/9TZL
	ubrFwhhKBDw7TZTjKYRf6bBNxaLeTfbjuEg6JSxhiWXHcCgoCI2q53KAoYW6BKh8=
X-Gm-Gg: ATEYQzzrANrq0w13ua+AaaHlLcL0JNOBdvmeyf6MQwMwakFamxSJai3bkCm0TGHIQJ2
	upp0WdDcEtHPOffV0BLHbZwaA4Nic7OsEnG+mO8Ym3tkSIaR6iwU/x3vr2P3eaajI/TmHjWwLHu
	kTl+gq6/+3Jv9Bm556LTEqNLkBAl44Es5mJ0lAndsjPMAK6mUbRhlsVzjUK8bgVNZRbYaFxYIjT
	hHwNbS0sw8LZKVPbC5QUe3p3Ke8QMvmmoZnIibSvMGy/mLbQAKfTN0DZ7LI9kYINPzu/2adf5fY
	5UaWwU9z2buDz3O8l+W1qSU8DFm92jyODwQDAQs3yI2Pem/FZhzvYc9cEnAoJC4quaMYi9Jev/2
	gUNzyVwyiAxsgMuXf9AA1TJA4MB2nZFVfYyZ3iLOD0AX89yOVGJsA
X-Received: by 2002:a05:690c:3489:b0:79b:f4e1:a5b8 with SMTP id 00721157ae682-79bf4e1a918mr133518727b3.8.1774892660113;
        Mon, 30 Mar 2026 10:44:20 -0700 (PDT)
X-Received: by 2002:a05:690c:3489:b0:79b:f4e1:a5b8 with SMTP id 00721157ae682-79bf4e1a918mr133518337b3.8.1774892659541;
        Mon, 30 Mar 2026 10:44:19 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7135d8asm38373587b3.4.2026.03.30.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:44:19 -0700 (PDT)
Message-ID: <64b7f622aa5f4839b9e1c4cd935223a6b2ec04c9.camel@redhat.com>
Subject: Re: [PATCH 03/10] ceph: add client reset state and request gating
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 30 Mar 2026 10:44:17 -0700
In-Reply-To: <20260327143045.1393612-4-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
	 <20260327143045.1393612-4-amarkuze@redhat.com>
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
> Add the client-side reset state tracking and the wait path used to block
> new metadata requests and new lock acquisitions while a reset is in
> progress. This wires the reset state into client init and shutdown so
> blocked callers are released cleanly when the mount is torn down.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/locks.c      | 14 ++++++++
>  fs/ceph/mds_client.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.h | 28 ++++++++++++++++
>  3 files changed, 121 insertions(+)
>=20
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 2f21574dfb99..e6f0c565e9d6 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -281,6 +281,13 @@ int ceph_lock(struct file *file, int cmd, struct fil=
e_lock *fl)
>  		return err;
>  	}
> =20
> +	/* Wait for reset to complete before acquiring new locks */
> +	if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && !lock_is_unlock(fl)) {
> +		err =3D ceph_mdsc_wait_for_reset(mdsc);

Maybe, I am missing something. But I don't see where mdsc variable has been
declared and initialized in ceph_lock(). Is it my misunderstanding?

> +		if (err)
> +			return err;
> +	}
> +
>  	if (lock_is_read(fl))
>  		lock_cmd =3D CEPH_LOCK_SHARED;
>  	else if (lock_is_write(fl))
> @@ -340,6 +347,13 @@ int ceph_flock(struct file *file, int cmd, struct fi=
le_lock *fl)
>  		return err;
>  	}
> =20
> +	/* Wait for reset to complete before acquiring new locks */
> +	if (!lock_is_unlock(fl)) {
> +		err =3D ceph_mdsc_wait_for_reset(mdsc);

Ditto. The same misunderstanding here.

Thanks,
Slava.

> +		if (err)
> +			return err;
> +	}
> +
>  	if (IS_SETLKW(cmd))
>  		wait =3D 1;
> =20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d70c0b669b75..0dd9a529850a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3742,12 +3742,69 @@ static void kick_requests(struct ceph_mds_client =
*mdsc, int mds)
>  	}
>  }
> =20
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
> +	long timeout =3D CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
> +	int blocked_count;
> +	int ret;
> +
> +	if (READ_ONCE(st->phase) =3D=3D CEPH_CLIENT_RESET_IDLE)
> +		return 0;
> +
> +	blocked_count =3D atomic_inc_return(&st->blocked_requests);
> +	doutc(cl, "request blocked during reset, %d total blocked\n",
> +	      blocked_count);
> +
> +	ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> +					       READ_ONCE(st->phase) =3D=3D
> +					       CEPH_CLIENT_RESET_IDLE,
> +					       timeout);
> +
> +	atomic_dec(&st->blocked_requests);
> +
> +	if (ret =3D=3D 0) {
> +		pr_warn_client(cl, "timed out waiting for reset to complete\n");
> +		return -ETIMEDOUT;
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	spin_lock(&st->lock);
> +	ret =3D st->last_errno;
> +	spin_unlock(&st->lock);
> +	return ret;
> +}
> +
>  int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode =
*dir,
>  			      struct ceph_mds_request *req)
>  {
>  	struct ceph_client *cl =3D mdsc->fsc->client;
>  	int err =3D 0;
> =20
> +	/*
> +	 * If a reset is in progress, wait for it to complete.
> +	 *
> +	 * This is best-effort: a request can pass this check just
> +	 * before the phase leaves IDLE and proceed concurrently with
> +	 * reset. That is acceptable because such requests will either
> +	 * complete normally or fail and be retried by the caller, and
> +	 * adding lock serialization here would penalize every request
> +	 * for a rare manual operation.
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
> @@ -5628,6 +5685,19 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	INIT_LIST_HEAD(&mdsc->dentry_leases);
>  	INIT_LIST_HEAD(&mdsc->dentry_dir_leases);
> =20
> +	spin_lock_init(&mdsc->reset_state.lock);
> +	mdsc->reset_state.trigger_count =3D 0;
> +	mdsc->reset_state.success_count =3D 0;
> +	mdsc->reset_state.failure_count =3D 0;
> +	mdsc->reset_state.last_start =3D 0;
> +	mdsc->reset_state.last_finish =3D 0;
> +	mdsc->reset_state.last_errno =3D 0;
> +	mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
> +	mdsc->reset_state.inject_error =3D false;
> +	mdsc->reset_state.last_reason[0] =3D '\0';
> +	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
> +	atomic_set(&mdsc->reset_state.blocked_requests, 0);
> +
>  	ceph_caps_init(mdsc);
>  	ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
> =20
> @@ -6153,6 +6223,15 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
>  	/* flush out any connection work with references to us */
>  	ceph_msgr_flush();
> =20
> +	spin_lock(&mdsc->reset_state.lock);
> +	if (mdsc->reset_state.phase !=3D CEPH_CLIENT_RESET_IDLE) {
> +		mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
> +		mdsc->reset_state.last_errno =3D -ESHUTDOWN;
> +		mdsc->reset_state.failure_count++;
> +	}
> +	spin_unlock(&mdsc->reset_state.lock);
> +	wake_up_all(&mdsc->reset_state.blocked_wq);
> +
>  	ceph_mdsc_stop(mdsc);
> =20
>  	ceph_metric_destroy(&mdsc->metric);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index e91a199d56fd..5cc22c109cfe 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -74,6 +74,32 @@ struct ceph_fs_client;
>  struct ceph_cap;
> =20
>  #define MDS_AUTH_UID_ANY -1
> +#define CEPH_CLIENT_RESET_REASON_LEN	64
> +#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
> +
> +enum ceph_client_reset_phase {
> +	CEPH_CLIENT_RESET_IDLE =3D 0,
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
> +	bool inject_error;
> +	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
> +
> +	/* Request blocking during reset */
> +	wait_queue_head_t blocked_wq;
> +	atomic_t blocked_requests;
> +};
> =20
>  struct ceph_mds_cap_match {
>  	s64 uid;  /* default to MDS_AUTH_UID_ANY */
> @@ -536,6 +562,7 @@ struct ceph_mds_client {
>  	struct list_head  dentry_dir_leases; /* lru list */
> =20
>  	struct ceph_client_metric metric;
> +	struct ceph_client_reset_state reset_state;
> =20
>  	spinlock_t		snapid_map_lock;
>  	struct rb_root		snapid_map_tree;
> @@ -563,6 +590,7 @@ extern const char *ceph_session_state_name(int s);
>  extern struct ceph_mds_session *
>  ceph_get_mds_session(struct ceph_mds_session *s);
>  extern void ceph_put_mds_session(struct ceph_mds_session *s);
> +int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
> =20
>  extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
>  extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);

