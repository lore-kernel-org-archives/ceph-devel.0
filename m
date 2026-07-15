Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEA4398E1
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141589; cv=none; b=grZhLx3nj4audbWzzNo3VHGDN3tSFIwLzm1TFZSiPE9OsZMZUJABIdXRHN1l8mRcblcdVC4vt5o424H+yqSAIxDlkTQlbYRLpt5hx/R10X6Abm/x6zxRSo/Oiv26CaeZ81BS7neZUT8lS6F0e7nYkNax/a5dqlskWdLcgavK2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141589; c=relaxed/simple;
	bh=nEgYEqcTHEbRoqb9+c6GdM812W2jAXOQxH2BsJegGeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVpQHwnXk7xCKKCVX7yJUIu5uSKhaZ6BMKvpAqMA7iLxust1arUjx5UB8SbTM0LkrRVgi8j+cEcYD4LlRNBn+GLXvwyBjQFuqz+m1u0QK4mcZ0KzCzLzkXL66jo/tDiYmI+AbJi5fX1NaZH6dPzhoRm/pDbjU49vk0lj0bxs7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qKy85Gfs; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qKy85Gfs"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e83f1f15aso35920607b3.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784141584; x=1784746384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=alfiDX7CYs6WFqoYlpG8kxjbkp7ZuVJOaBWU1rXmK8A=;
        b=qKy85Gfspib0hJEODGut4vjHMWi446NOeGCU0GIJ103KT+XqG5ujIrg134VUiFyiAV
         Z+m1cwBaa5aJH90rk4su+qX99Vap/h9cdYf9YaP4XofGLBNPLwSkFyyRqEXtt+VsnN5Y
         T5+Zq6FClKIZYiI5UDmClVrCx2tsO7Gvc6pOjPA+nPVRhIsvbCRt/k76NHSkY7qUcL3y
         XZY6/vjXjlVqjnmwwpIPIeDFPzSPs8jetDVnG5gYO64rtEuEBwBQXWuEm0L2Aee2r3Gm
         YYCZoGp2OebE3mdXx1e1cNWin0XM49yUgzKQT2NY2nZbTHMS9OJ1NYBEvaMfxRWKVBCz
         0D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141584; x=1784746384;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=alfiDX7CYs6WFqoYlpG8kxjbkp7ZuVJOaBWU1rXmK8A=;
        b=dXhWxZTUP1Sp9zl4awuhRKU2pHdIIWsdSHXNnYkGzbGj0Fq8d/snX0uuZbBtefv6Md
         8vV+dsuYp4Px6+WRzcALEVoD8W20iTSTwFBCcRkqZULOnQw5K3j/qXNYhaxpf8xM1LmD
         6UUr8fdUpsB3EB9xE+aRi8gzLDklDe0TY1CfPBObGkmBIQoRHVdJLpTctIZojUIBAXHH
         A3RTPr8qyIRlGCMXWVRYF/JoCB+uHam36N99mm9i2AbY3zRj9l1ejSLTIUVEVFQgxCLd
         2RKvWHHRLoLe36/qUrHP1sNT7V+QLemudHmjx3R1sYCuYOqkC7YHhi+u96W5m8FpYgp0
         CYdA==
X-Gm-Message-State: AOJu0YzIEA4xQSpFB/yrZOVaBylpDv0A+3FQ3UKuBPWPDSqrytyF2CVD
	rRirzvWjqRBX8APpXxarslrK6UahwRvt9JJ3D/oyUp7jKWv3EZLP1SqK1z1dbmeZBmU=
X-Gm-Gg: AfdE7cmoxoA9KzdxL1neVPNr6AuOF6329Wga7xJJOUMO5I93YkXUKV/m5ux5uvdXkvZ
	TxUQL1ksg3/dSawRoumkR3Y1g26pmFdRlt/NCipB9l/cqMDJu23c6aBya/q/6vAyy1vXcJ/WnPr
	lQqIgdvLkkyE5tRpdM0J2ITe024WzNl3uw0+YdDuzcyc9wkrdz305sUmzH+b5lGWDrG2e7BBmJK
	WdcwOp/ZADcKM7/fwnhDaDzkaifTCsE4JKWOlYo5X48X/oD9PyDasxPrNMoi7QX9iqf0/7thv/l
	F57ZwQprscuDgwosS24lpNBR74QnFeDX6ktLfj838ZVKcDF2K3XwtfxqbOq61qD5sk1jVC0P5xB
	Jkm8Qc+98ZPfCtLdLsPr/wIuFqm92qpQQREMM2QWD0Bhiz8/ZdoH+fO5AMM1yof6aTRh1ogPqHo
	WfgJ03++B6GLi1XFZc5EpN+gDN6UqpJRoCK5W3nb7+yA69OrDaLNjB6/1pA5PyC/dQ1PV0j0d6f
	P/ZzLVUeqLPUBD9r8S0jCJuqPJ7aDHLzD78wW8IVs9g
X-Received: by 2002:a05:690c:3489:b0:7f0:38f7:6ca6 with SMTP id 00721157ae682-81ede3c4e3fmr5008117b3.5.1784141583555;
        Wed, 15 Jul 2026 11:53:03 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:393f:38b4:2407:391])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1a44d6sm177708937b3.31.2026.07.15.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:53:02 -0700 (PDT)
Message-ID: <e341fc3bd013ffdb5252740ad9e0686544d239c4.camel@dubeyko.com>
Subject: Re: [PATCH v2 4/5] ceph: move mdsc->mutex into __do_request()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 15 Jul 2026 11:53:01 -0700
In-Reply-To: <20260715-ceph-mdsc-mutex-optimization-v2-4-90e81b726724@clyso.com>
References: 
	<20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
	 <20260715-ceph-mdsc-mutex-optimization-v2-4-90e81b726724@clyso.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 11:58 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> __do_request() now acquires mdsc->mutex on entry and unlocks at
> every exit point, so callers no longer need to hold it.=C2=A0 As a
> result kick_requests() is now completely free of mdsc->mutex:
> xa_for_each() is internally locked, list_del_init() is guarded by
> wait_list_lock, and __do_request() manages its own serialization.
>=20
> Remove the no-longer-needed mutex_lock/unlock around __do_request()
> in ceph_mdsc_submit_request() and handle_forward().=C2=A0 The do_request(=
)
> wrapper introduced in the previous commit is no longer necessary
> and is dropped.

Which do_request() wrapper do you mean here? Maybe, I am missing
something.

>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/mds_client.c | 48 +++++++++++++++++++++++++----------------=
-
> ------
> =C2=A01 file changed, 25 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a250938f32d3..be0dae919d69 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3637,9 +3637,12 @@ static void __do_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	int err =3D 0;
> =C2=A0	bool random;
> =C2=A0
> +	mutex_lock(&mdsc->mutex);
> +
> =C2=A0	if (req->r_err || test_bit(CEPH_MDS_R_GOT_RESULT, &req-
> >r_req_flags)) {
> =C2=A0		if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
> =C2=A0			__unregister_request(mdsc, req);
> +		mutex_unlock(&mdsc->mutex);
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> @@ -3672,6 +3675,7 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0			spin_lock(&mdsc->wait_list_lock);
> =C2=A0			list_add(&req->r_wait, &mdsc-
> >waiting_for_map);
> =C2=A0			spin_unlock(&mdsc->wait_list_lock);
> +			mutex_unlock(&mdsc->mutex);
> =C2=A0			return;
> =C2=A0		}
> =C2=A0		if (!(mdsc->fsc->mount_options->flags &
> @@ -3697,6 +3701,7 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0		spin_lock(&mdsc->wait_list_lock);
> =C2=A0		list_add(&req->r_wait, &mdsc->waiting_for_map);
> =C2=A0		spin_unlock(&mdsc->wait_list_lock);
> +		mutex_unlock(&mdsc->mutex);
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> @@ -3770,6 +3775,8 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0		goto out_session;
> =C2=A0	}
> =C2=A0
> +	mutex_unlock(&mdsc->mutex);
> +
> =C2=A0	/* send request */
> =C2=A0	req->r_resend_mds =3D -1;=C2=A0=C2=A0 /* forget any previous mds h=
int */
> =C2=A0
> @@ -3800,6 +3807,7 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0			err =3D wait_on_bit(&di->flags,
> CEPH_DENTRY_ASYNC_CREATE_BIT,
> =C2=A0					=C2=A0 TASK_KILLABLE);
> =C2=A0			if (err) {
> +				mutex_lock(&mdsc->mutex);
> =C2=A0				mutex_lock(&req->r_fill_mutex);
> =C2=A0				set_bit(CEPH_MDS_R_ABORTED, &req-
> >r_req_flags);
> =C2=A0				mutex_unlock(&req->r_fill_mutex);
> @@ -3837,6 +3845,8 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0
> =C2=A0	err =3D __send_request(session, req, false);
> =C2=A0
> +	mutex_lock(&mdsc->mutex);
> +
> =C2=A0out_session:
> =C2=A0	ceph_put_mds_session(session);
> =C2=A0finish:
> @@ -3846,12 +3856,10 @@ static void __do_request(struct
> ceph_mds_client *mdsc,
> =C2=A0		complete_request(mdsc, req);
> =C2=A0		__unregister_request(mdsc, req);
> =C2=A0	}
> +	mutex_unlock(&mdsc->mutex);
> =C2=A0	return;
> =C2=A0}
> =C2=A0
> -/*
> - * called under mdsc->mutex
> - */
> =C2=A0static void __wake_requests(struct ceph_mds_client *mdsc,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct list_head *head)
> =C2=A0{
> @@ -3969,11 +3977,12 @@ int ceph_mdsc_submit_request(struct
> ceph_mds_client *mdsc, struct inode *dir,
> =C2=A0	doutc(cl, "submit_request on %p for inode %p\n", req, dir);
> =C2=A0	mutex_lock(&mdsc->mutex);
> =C2=A0	__register_request(mdsc, req, dir);
> +	mutex_unlock(&mdsc->mutex);
> +
> =C2=A0	trace_ceph_mdsc_submit_request(mdsc, req);
> =C2=A0	if (!req->r_err)
> =C2=A0		__do_request(mdsc, req);
> =C2=A0	err =3D req->r_err;
> -	mutex_unlock(&mdsc->mutex);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> @@ -4346,13 +4355,14 @@ static void handle_forward(struct
> ceph_mds_client *mdsc,
> =C2=A0		req->r_num_fwd =3D fwd_seq;
> =C2=A0		req->r_resend_mds =3D next_mds;
> =C2=A0		put_request_session(req);
> -		__do_request(mdsc, req);
> =C2=A0	}
> =C2=A0	mutex_unlock(&mdsc->mutex);
> =C2=A0
> =C2=A0	/* kick calling process */
> =C2=A0	if (aborted)
> =C2=A0		complete_request(mdsc, req);
> +	else if (!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
> +		__do_request(mdsc, req);
> =C2=A0	ceph_mdsc_put_request(req);
> =C2=A0	return;
> =C2=A0
> @@ -4676,11 +4686,9 @@ static void handle_session(struct
> ceph_mds_session *session,
> =C2=A0
> =C2=A0	mutex_unlock(&session->s_mutex);
> =C2=A0	if (wake) {
> -		mutex_lock(&mdsc->mutex);
> =C2=A0		__wake_requests(mdsc, &session->s_waiting);
> =C2=A0		if (wake =3D=3D 2)
> =C2=A0			kick_requests(mdsc, mds);
> -		mutex_unlock(&mdsc->mutex);
> =C2=A0	}
> =C2=A0	if (op =3D=3D CEPH_SESSION_CLOSE)
> =C2=A0		ceph_put_mds_session(session);
> @@ -5326,9 +5334,7 @@ static int send_mds_reconnect(struct
> ceph_mds_client *mdsc,
> =C2=A0
> =C2=A0	mutex_unlock(&session->s_mutex);
> =C2=A0
> -	mutex_lock(&mdsc->mutex);
> =C2=A0	__wake_requests(mdsc, &session->s_waiting);
> -	mutex_unlock(&mdsc->mutex);
> =C2=A0
> =C2=A0	up_read(&mdsc->snap_rwsem);
> =C2=A0	ceph_pagelist_release(recon_state.pagelist);
> @@ -5773,8 +5779,8 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0		}
> =C2=A0		sessions[i]->s_state =3D CEPH_MDS_SESSION_CLOSED;
> =C2=A0		__unregister_session(mdsc, sessions[i]);
> -		__wake_requests(mdsc, &sessions[i]->s_waiting);
> =C2=A0		mutex_unlock(&mdsc->mutex);
> +		__wake_requests(mdsc, &sessions[i]->s_waiting);
> =C2=A0
> =C2=A0		mutex_lock(&sessions[i]->s_mutex);
> =C2=A0		cleanup_session_requests(mdsc, sessions[i]);
> @@ -5785,9 +5791,7 @@ static void ceph_mdsc_reset_workfn(struct
> work_struct *work)
> =C2=A0
> =C2=A0		ceph_put_mds_session(sessions[i]);
> =C2=A0
> -		mutex_lock(&mdsc->mutex);
> =C2=A0		kick_requests(mdsc, mds);
> -		mutex_unlock(&mdsc->mutex);
> =C2=A0
> =C2=A0		torn_down++;
> =C2=A0		pr_info_client(cl, "mds%d session reset complete\n",
> mds);
> @@ -5903,8 +5907,8 @@ static void check_new_map(struct
> ceph_mds_client *mdsc,
> =C2=A0			/* force close session for stopped mds */
> =C2=A0			ceph_get_mds_session(s);
> =C2=A0			__unregister_session(mdsc, s);
> -			__wake_requests(mdsc, &s->s_waiting);
> =C2=A0			mutex_unlock(&mdsc->mutex);
> +			__wake_requests(mdsc, &s->s_waiting);
> =C2=A0
> =C2=A0			mutex_lock(&s->s_mutex);
> =C2=A0			cleanup_session_requests(mdsc, s);
> @@ -5913,8 +5917,8 @@ static void check_new_map(struct
> ceph_mds_client *mdsc,
> =C2=A0
> =C2=A0			ceph_put_mds_session(s);
> =C2=A0
> -			mutex_lock(&mdsc->mutex);
> =C2=A0			kick_requests(mdsc, i);
> +			mutex_lock(&mdsc->mutex);
> =C2=A0			continue;
> =C2=A0		}
> =C2=A0
> @@ -5958,8 +5962,8 @@ static void check_new_map(struct
> ceph_mds_client *mdsc,
> =C2=A0			=C2=A0=C2=A0=C2=A0 oldstate !=3D CEPH_MDS_STATE_STARTING)
> =C2=A0				pr_info_client(cl, "mds%d recovery
> completed\n",
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->s_mds);
> -			kick_requests(mdsc, i);
> =C2=A0			mutex_unlock(&mdsc->mutex);
> +			kick_requests(mdsc, i);
> =C2=A0			mutex_lock(&s->s_mutex);
> =C2=A0			mutex_lock(&mdsc->mutex);
> =C2=A0			ceph_kick_flushing_caps(mdsc, s);
> @@ -6931,8 +6935,8 @@ void ceph_mdsc_force_umount(struct
> ceph_mds_client *mdsc)
> =C2=A0
> =C2=A0		if (session->s_state =3D=3D CEPH_MDS_SESSION_REJECTED)
> =C2=A0			__unregister_session(mdsc, session);
> -		__wake_requests(mdsc, &session->s_waiting);
> =C2=A0		mutex_unlock(&mdsc->mutex);
> +		__wake_requests(mdsc, &session->s_waiting);
> =C2=A0
> =C2=A0		mutex_lock(&session->s_mutex);
> =C2=A0		__close_session(mdsc, session);
> @@ -6943,11 +6947,11 @@ void ceph_mdsc_force_umount(struct
> ceph_mds_client *mdsc)
> =C2=A0		mutex_unlock(&session->s_mutex);
> =C2=A0		ceph_put_mds_session(session);
> =C2=A0
> -		mutex_lock(&mdsc->mutex);
> =C2=A0		kick_requests(mdsc, mds);
> +		mutex_lock(&mdsc->mutex);
> =C2=A0	}
> -	__wake_requests(mdsc, &mdsc->waiting_for_map);
> =C2=A0	mutex_unlock(&mdsc->mutex);
> +	__wake_requests(mdsc, &mdsc->waiting_for_map);
> =C2=A0}
> =C2=A0
> =C2=A0static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
> @@ -7091,8 +7095,8 @@ void ceph_mdsc_handle_fsmap(struct
> ceph_mds_client *mdsc, struct ceph_msg *msg)
> =C2=A0err_out:
> =C2=A0	mutex_lock(&mdsc->mutex);
> =C2=A0	mdsc->mdsmap_err =3D err;
> -	__wake_requests(mdsc, &mdsc->waiting_for_map);
> =C2=A0	mutex_unlock(&mdsc->mutex);
> +	__wake_requests(mdsc, &mdsc->waiting_for_map);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -7143,11 +7147,11 @@ void ceph_mdsc_handle_mdsmap(struct
> ceph_mds_client *mdsc, struct ceph_msg *msg)
> =C2=A0	mdsc->fsc->max_file_size =3D min((loff_t)mdsc->mdsmap-
> >m_max_file_size,
> =C2=A0					MAX_LFS_FILESIZE);
> =C2=A0
> +	mutex_unlock(&mdsc->mutex);
> =C2=A0	__wake_requests(mdsc, &mdsc->waiting_for_map);
> =C2=A0	ceph_monc_got_map(&mdsc->fsc->client->monc, CEPH_SUB_MDSMAP,
> =C2=A0			=C2=A0 mdsc->mdsmap->m_epoch);
> =C2=A0
> -	mutex_unlock(&mdsc->mutex);
> =C2=A0	schedule_delayed(mdsc, 0);
> =C2=A0	return;
> =C2=A0
> @@ -7245,8 +7249,8 @@ static void mds_peer_reset(struct
> ceph_connection *con)
> =C2=A0		ceph_get_mds_session(s);
> =C2=A0		s->s_state =3D CEPH_MDS_SESSION_CLOSED;
> =C2=A0		__unregister_session(mdsc, s);
> -		__wake_requests(mdsc, &s->s_waiting);
> =C2=A0		mutex_unlock(&mdsc->mutex);
> +		__wake_requests(mdsc, &s->s_waiting);
> =C2=A0
> =C2=A0		mutex_lock(&s->s_mutex);
> =C2=A0		cleanup_session_requests(mdsc, s);
> @@ -7255,9 +7259,7 @@ static void mds_peer_reset(struct
> ceph_connection *con)
> =C2=A0
> =C2=A0		wake_up_all(&mdsc->session_close_wq);
> =C2=A0
> -		mutex_lock(&mdsc->mutex);
> =C2=A0		kick_requests(mdsc, s->s_mds);
> -		mutex_unlock(&mdsc->mutex);
> =C2=A0
> =C2=A0		ceph_put_mds_session(s);
> =C2=A0		break;

Maybe, I am missing something. But kick_requests() reads req-
>r_attempts [1] and req->r_session [2] with no lock at all. While
__do_request()/__prepare_send_request() can write those same fields
[3,4] from another thread without holding mdsc->mutex at the write
point either. Could it be the issue?

Thanks,
Slava.

[1]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L3832
[2]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L3834
[3]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L3658
[4]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L3475
