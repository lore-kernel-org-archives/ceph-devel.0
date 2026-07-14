Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF72F12AB
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055126; cv=none; b=Do5u+IL7H1VelVk04IvqiUjueIFccUSZRIEDwZt/wG68uW0hwJsh6FmJtrgPP0nElrZjR1jLvMTVou+flnMqAsUFkrm2lWC/tZDINZGtTfojZ/mvLy9IyWl+FWBnyCYOEocroJ+Usq7ZNZz/ob8DRZ566cZUNJtbeSuIVzRUb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055126; c=relaxed/simple;
	bh=uRFZYWEvhnfqHPz2HnffjSQ3nQC668QQT3Z8nNSowfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gSPUnmkI/J/3TE8tngliifB1ytr4seR4FV/xlikOyDKoSjqbYR7K6od3yaqZ7i2qfG86JMsvLWqUJAR9xsvjOVWoEBkcea/ZL1MhKIDNghYjqMftmgHbjENH9mPX3Iiui9lZlbfANBQSZlJL8W+S00s5/IrHUnof2z2RL1BZVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=dYMQQ0Gk; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="dYMQQ0Gk"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81e83f1f15aso20219177b3.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784055123; x=1784659923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8O00T+T6qrc/VzBMykisVzuRKe/5fAUB+g2qWW0cHM=;
        b=dYMQQ0Gk/wPsJpW8FDb29HkcfchImnNMjdTDZrSQx2F5HK3PzcMtPfPIKP24xrKSng
         GQHHlw6KQaZeMTrdFpkjHsFX6ITYGWJ5gP6joP0ZA293d0t3WytTqIUSHDS6XBHEEhwm
         JoaFF0VrHue6jxBUsE8/Dsn8XSXDVFf18E5qoYLCXZ+6w2Koui4vCUUNuZkYjJ6MIbut
         ORyECFIEcUTzwugzP2EJuuet3LDdc3GnEQStAhxf4LUYdu+NGxgGu3PA7aXmUHmvmhAG
         VEF5poP/sSh6TDYysB4o8JoG8wrFnoX7MfRALFwvHksBtjJE5NZHOYb5QVJqv5SUTIUz
         S73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055123; x=1784659923;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z8O00T+T6qrc/VzBMykisVzuRKe/5fAUB+g2qWW0cHM=;
        b=GgSqvhh7JARXHSp4IJdNsJHeNtTVYySFQV2ZnmGPZAp0Qlj3a3VDOSpwZQ8Elof34U
         PogQlNIKMpieVurv4ZvCcLut4qtWlUu327KRXLviVtRoPnSmt/Cmu16OwLWAl9ah6h6W
         NlVfBWr0c8YRBUBsPXtaf4Tqsxh952wuySSDOC+ChRZKFnExDTwl2zviZ1X91buD7PiI
         Ok2Wnx9sljeAD+jwOZ3hIbLqnScoHbVY0MaZonThDHZzk9R9yp/GU9FCa/81VCH+kGuo
         CtnOh+uRWCbxlNM3v/JSuDORAZDMfWHqqDjbjqEJKeqnTsCbAnJNwtQ/vFZJ+mAt3EZx
         Yrpw==
X-Gm-Message-State: AOJu0YxljjanStZUZ3YquV2zNx4G+VcJ99kdoBzj1gtduv1bY4Q0oYG2
	KNK6UcmcD3Opr67Foy37F0/hhTPmbR3yiQshXgT77VSWtrdUwRrg4H9HgXAC1HUU0W8=
X-Gm-Gg: AfdE7ckFS4uJzSXf5TYxl9Gdqpd0qCxT2xsie6+CqMakUx/2gO064+Pp4/BtTcOBe2P
	lE7KgXHh3KPYRrJEwDmJPX8Z32s33uAFDLWW1uV3IQqymjoG4Mv48II5jcWYVLWpQ3L0eb7TPMi
	gaZ4s56taYdBma+07q8N59ld1fuZuZoQFfcsRW8uxS6b/7i4QmRILYLck5snDej4nZUSB9TOxVk
	8npEqWOE+tUocttVgMncvNn3hLeucwBE0eJjhzJqxrhYRSsnw++ghGtzwihzzSwNjIOdq8MbEoy
	bVm7tbkJaFj0jTAS05yjblL4zdIzSA+vpKG0DxPxPy+jm4eyF44QAv5FgN44tc0+ks8H4xF8qcB
	raIck0/xWaUSaTlY0RGOaaI+Qzk/CPN1sH6K7zMNYn9OBvtYVdRknG75x8fKiH3t5AA3pVNBmKt
	KyGhw0z9YPkId/UODivbZZKN5ww9pdjSEbLbnahmWJm8IocvrYVyusgfouc/4akI3akh6qm/TM+
	VqCPNmVpfclTn5VpCd3RUVI6uK7DirBOpvydZMI+wtX0vvtlULeIM1rnLWumMxAeWvgQl2YWXrX
	nficiw==
X-Received: by 2002:a05:690c:7305:b0:80c:a6e7:5220 with SMTP id 00721157ae682-81e90720abemr103919647b3.9.1784055123310;
        Tue, 14 Jul 2026 11:52:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b87:2209:14fb:1802? ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be90499sm149077377b3.5.2026.07.14.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:52:02 -0700 (PDT)
Message-ID: <132f81feebfc532ac55823a1238a10c3d62f5e5e.camel@dubeyko.com>
Subject: Re: [PATCH 4/5] ceph: move mdsc->mutex into __do_request()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 11:52:01 -0700
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-4-9ae5ac135c34@clyso.com>
References: 
	<20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
	 <20260713-ceph-mdsc-mutex-optimization-v1-4-9ae5ac135c34@clyso.com>
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

On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
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
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/mds_client.c | 45 +++++++++++++++++++++++++----------------=
-
> ---
> =C2=A01 file changed, 25 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 6f9049148721..ef54d19ace2a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3577,9 +3577,12 @@ static void __do_request(struct
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
> @@ -3612,6 +3615,7 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0			spin_lock(&mdsc->wait_list_lock);
> =C2=A0			list_add(&req->r_wait, &mdsc-
> >waiting_for_map);
> =C2=A0			spin_unlock(&mdsc->wait_list_lock);
> +			mutex_unlock(&mdsc->mutex);
> =C2=A0			return;
> =C2=A0		}
> =C2=A0		if (!(mdsc->fsc->mount_options->flags &
> @@ -3637,6 +3641,7 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0		spin_lock(&mdsc->wait_list_lock);
> =C2=A0		list_add(&req->r_wait, &mdsc->waiting_for_map);
> =C2=A0		spin_unlock(&mdsc->wait_list_lock);
> +		mutex_unlock(&mdsc->mutex);
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> @@ -3710,6 +3715,8 @@ static void __do_request(struct ceph_mds_client
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
> @@ -3740,6 +3747,7 @@ static void __do_request(struct ceph_mds_client
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
> @@ -3777,6 +3785,8 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0
> =C2=A0	err =3D __send_request(session, req, false);
> =C2=A0
> +	mutex_lock(&mdsc->mutex);
> +
> =C2=A0out_session:
> =C2=A0	ceph_put_mds_session(session);
> =C2=A0finish:
> @@ -3786,6 +3796,7 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0		complete_request(mdsc, req);
> =C2=A0		__unregister_request(mdsc, req);
> =C2=A0	}
> +	mutex_unlock(&mdsc->mutex);
> =C2=A0	return;
> =C2=A0}
> =C2=A0
> @@ -3900,10 +3911,11 @@ int ceph_mdsc_submit_request(struct
> ceph_mds_client *mdsc, struct inode *dir,
> =C2=A0	doutc(cl, "submit_request on %p for inode %p\n", req, dir);
> =C2=A0	mutex_lock(&mdsc->mutex);
> =C2=A0	__register_request(mdsc, req, dir);
> +	mutex_unlock(&mdsc->mutex);
> +
> =C2=A0	trace_ceph_mdsc_submit_request(mdsc, req);
> =C2=A0	__do_request(mdsc, req);
> =C2=A0	err =3D req->r_err;
> -	mutex_unlock(&mdsc->mutex);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> @@ -4276,13 +4288,14 @@ static void handle_forward(struct
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
> @@ -4606,11 +4619,9 @@ static void handle_session(struct
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
> @@ -5245,9 +5256,7 @@ static int send_mds_reconnect(struct
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
> @@ -5672,8 +5681,8 @@ static void ceph_mdsc_reset_workfn(struct
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
> @@ -5684,9 +5693,7 @@ static void ceph_mdsc_reset_workfn(struct
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
> @@ -5802,8 +5809,8 @@ static void check_new_map(struct
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
> @@ -5812,8 +5819,8 @@ static void check_new_map(struct
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
> @@ -5857,8 +5864,8 @@ static void check_new_map(struct
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
> @@ -6766,8 +6773,8 @@ void ceph_mdsc_force_umount(struct
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
> @@ -6778,11 +6785,11 @@ void ceph_mdsc_force_umount(struct
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
> @@ -6924,8 +6931,8 @@ void ceph_mdsc_handle_fsmap(struct
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
> @@ -6976,11 +6983,11 @@ void ceph_mdsc_handle_mdsmap(struct
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
> @@ -7078,8 +7085,8 @@ static void mds_peer_reset(struct
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
> @@ -7088,9 +7095,7 @@ static void mds_peer_reset(struct
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


If I am not wrong, we still have comment [1]:

/*
 * called under mdsc->mutex
 */
static void __wake_requests(struct ceph_mds_client *mdsc,
			    struct list_head *head)

Thanks,
Slava.

[1]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/ceph/mds_client.c#L3793
