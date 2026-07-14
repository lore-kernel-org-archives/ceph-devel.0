Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226341A913
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054535; cv=none; b=YHXEPGiMZmlGWYl9fRqdqqcsY2G9uec0ePuETBX2SajCb10bMCzV1MssVXPQxxYEumthZF7CEuRzSNueM1N1bf2Acii/P32GXJJq6sd+FN3YiloeucCbUlUarLNTKuMfaQ8IKXT4sgmMUXV9UdaNyli+K4iWi7nx2qBoa9tBEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054535; c=relaxed/simple;
	bh=7PkR0DIjN+/FYYrV4xc1ggeoOBMvd3n53GOR02+v85Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7EfsTtTTBtYrVrf7tW2UJNX0YM91/43ADkQF6QrDt0ljNtJtkES6YPG7KJ0OdWVX/MoFmBp55v3ZxSoPu6Sqz3Z/8eo7585RoTRXzkC02SgwQ3ldcPanmlpc1oyATuA2aS1mOUU7bwHR/zwyVV+lnQvW3Fbxowto8uXDWfC32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=kF39zilQ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="kF39zilQ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664db84f074so7049791d50.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784054529; x=1784659329; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xg9n8DaUKiiB4y2JDDrdxHpGs5ijHVGulxis5sbCXnM=;
        b=kF39zilQLiKzCI03ZK33TP/41s//Bomnmo5nuweT1tv7J1K7gWQLqZLAxn7gqtqAdz
         rVEClfo4JvzUvKXAXhdMKwFOluFtWtUyzqvFPsk9Fj9l9w5v22N+vrKqw/u/SY1uiAFr
         +Y2otnnz64TYk9Uta+paw9yDLbi1l9MzHJapNBZt4AVCFaG2oN46QLMkkAUj4/8DRD17
         ohxeqjc+qVrUFNLMEd6k6nLuI3895Jfl/Gf929SS5WAqueObHcdxh0ABOIECFUodr1bd
         T1vGmww9W6w+d3omma7D16UtByT3RGfo8ahUcIcFr/x8LOcbH7yg2UclhYrh+lRprMxu
         gdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054529; x=1784659329;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xg9n8DaUKiiB4y2JDDrdxHpGs5ijHVGulxis5sbCXnM=;
        b=V2nqNX82qRU1X/UX6EZBwXsG6nMqh/YP8V3Z+OQu2cF5iqweHz3mjY96H5CuvYQgD0
         xVlUv8/pVxP6cFjifUO/xRcP8JVfjdJdMSZoh379wYkSozlaXOnWyJ6vbNv8CZzVioe9
         9bmB4P2pPasCjPEN/VPrEXoBQMIqB4OUpED7mclSBzcKwAg0l/zWAmsAHMkmXLBGGi8j
         gA6BIaCTXZeX/SbNpulyuwvPJ9QGLAyoB99HaT/LlhC0ZX4fHutuCfAathF/oQHDrbcO
         cJxbs+6Fa+jate49pcAgD8FR/jIu46G1/sNdOnV84r/H+5zeO4+Lgxtfrh46CuhNLf/k
         Xbiw==
X-Gm-Message-State: AOJu0YzcT6MGDR/vylPCXMluG4bLheR+Q+tH6atYQjxrpf4mG4uY6GKM
	199juF0T0s2kj2y+ciXJQNSb1STxYGv+/jwZeD8h/4ySqJEfmAkaAz8BrOw+2l0EHc4=
X-Gm-Gg: AfdE7cklVQTzHpjmLDKVNmhmAchONGBUb3rKJess5n/Bw9mPBQqtaj6C4xjWaGamNzn
	mMDFH+uNtzlvY5pGaJWrcHakIyFQivIYWcdSmTW2XuYeHmyc0woYGHjwRGO/4J62rMIO3NMKCz3
	yKcLWjMyc5PrnfDiYz9YpQaH3SzzX4rRug/eg4V8ZXcCN23Zpt1fXEfcR0jM23dwkcTlELf0i6N
	PMaH8YX9sJM+pgd5ssuag5bICNMN7+Lz1bVJLJruILfCtf0/5XGaOxnBeJw3TGhmXtzH7eXE/5+
	l1BIWT/wpWiYgTOV50dae3Jv0Nkib2uKSSWVKd9vYDc/X0KNGq2EtWsRh2dixtElWoS0FtjqWTi
	QNiKGdgFBQj/bQTfogTAH1QM9Km5HfNVHCX3JCZaLN+PU7uFwSnCc2y4vj0RpySBkuaXdqYFTWh
	HIoBGsoqzuyqkDgA4f3EOj+JPzjO7gs9qseyjpWrlEKKCBOgxvsyk7/E1KUioZ7ZGgsf+uBPvxO
	HOX3Vbj3l6hUF5HsKUhYyP8XRiceuRK/wIrGfACW0MGvN/wpHE9qJ2McYJyXpCCOdmadEo3Mux7
	hDo2/Cfy2tQaGWqB
X-Received: by 2002:a53:b3ca:0:b0:667:c2ab:e831 with SMTP id 956f58d0204a3-66813233467mr31142d50.14.1784054528650;
        Tue, 14 Jul 2026 11:42:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b87:2209:14fb:1802? ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667879cad9asm16884557d50.10.2026.07.14.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:42:08 -0700 (PDT)
Message-ID: <5eb05a4968ce92b13c6727811692b97b31273b4c.camel@dubeyko.com>
Subject: Re: [PATCH 3/5] ceph: add wait_list_lock for wait-list serialization
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 11:42:06 -0700
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-3-9ae5ac135c34@clyso.com>
References: 
	<20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
	 <20260713-ceph-mdsc-mutex-optimization-v1-3-9ae5ac135c34@clyso.com>
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
> Add a dedicated spinlock to protect the waiting_for_map and
> s_waiting lists, which are currently serialized by mdsc->mutex.
> This is a preparatory step for removing mdsc->mutex from the
> kick_requests() path: xa_for_each() is internally locked and the
> per-request filter checks are lockless, so only list_del_init()
> needs external protection.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/mds_client.c | 18 +++++++++++++++++-
> =C2=A0fs/ceph/mds_client.h |=C2=A0 3 +++
> =C2=A02 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 909f909b64ed..6f9049148721 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3609,7 +3609,9 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0			doutc(cl, "no mdsmap, waiting for map\n");
> =C2=A0			trace_ceph_mdsc_suspend_request(mdsc,
> session, req,
> =C2=A0							ceph_mdsc_su
> spend_reason_no_mdsmap);
> +			spin_lock(&mdsc->wait_list_lock);
> =C2=A0			list_add(&req->r_wait, &mdsc-
> >waiting_for_map);
> +			spin_unlock(&mdsc->wait_list_lock);
> =C2=A0			return;
> =C2=A0		}
> =C2=A0		if (!(mdsc->fsc->mount_options->flags &
> @@ -3632,7 +3634,9 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0		doutc(cl, "no mds or not active, waiting for
> map\n");
> =C2=A0		trace_ceph_mdsc_suspend_request(mdsc, session, req,
> =C2=A0						ceph_mdsc_suspend_re
> ason_no_active_mds);
> +		spin_lock(&mdsc->wait_list_lock);
> =C2=A0		list_add(&req->r_wait, &mdsc->waiting_for_map);
> +		spin_unlock(&mdsc->wait_list_lock);
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> @@ -3680,9 +3684,12 @@ static void __do_request(struct
> ceph_mds_client *mdsc,
> =C2=A0			if (ceph_test_mount_opt(mdsc->fsc,
> CLEANRECOVER)) {
> =C2=A0				trace_ceph_mdsc_suspend_request(mdsc
> , session, req,
> =C2=A0								ceph
> _mdsc_suspend_reason_rejected);
> +				spin_lock(&mdsc->wait_list_lock);
> =C2=A0				list_add(&req->r_wait, &mdsc-
> >waiting_for_map);
> -			} else
> +				spin_unlock(&mdsc->wait_list_lock);
> +			} else {
> =C2=A0				err =3D -EACCES;
> +			}
> =C2=A0			goto out_session;
> =C2=A0		}
> =C2=A0
> @@ -3697,7 +3704,9 @@ static void __do_request(struct ceph_mds_client
> *mdsc,
> =C2=A0		}
> =C2=A0		trace_ceph_mdsc_suspend_request(mdsc, session, req,
> =C2=A0						ceph_mdsc_suspend_re
> ason_session);
> +		spin_lock(&mdsc->wait_list_lock);
> =C2=A0		list_add(&req->r_wait, &session->s_waiting);
> +		spin_unlock(&mdsc->wait_list_lock);
> =C2=A0		goto out_session;
> =C2=A0	}
> =C2=A0
> @@ -3790,7 +3799,9 @@ static void __wake_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0	struct ceph_mds_request *req;
> =C2=A0	LIST_HEAD(tmp_list);
> =C2=A0
> +	spin_lock(&mdsc->wait_list_lock);
> =C2=A0	list_splice_init(head, &tmp_list);
> +	spin_unlock(&mdsc->wait_list_lock);
> =C2=A0
> =C2=A0	while (!list_empty(&tmp_list)) {
> =C2=A0		req =3D list_entry(tmp_list.next,
> @@ -3823,7 +3834,9 @@ static void kick_requests(struct
> ceph_mds_client *mdsc, int mds)
> =C2=A0		if (req->r_session &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 req->r_session->s_mds =3D=3D mds) {
> =C2=A0			doutc(cl, " kicking tid %llu\n", req-
> >r_tid);
> +			spin_lock(&mdsc->wait_list_lock);
> =C2=A0			list_del_init(&req->r_wait);
> +			spin_unlock(&mdsc->wait_list_lock);
> =C2=A0			trace_ceph_mdsc_resume_request(mdsc, req);
> =C2=A0			__do_request(mdsc, req);
> =C2=A0		}
> @@ -6258,6 +6271,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
> =C2=A0	mdsc->snap_realms =3D RB_ROOT;
> =C2=A0	INIT_LIST_HEAD(&mdsc->snap_empty);
> =C2=A0	spin_lock_init(&mdsc->snap_empty_lock);
> +	spin_lock_init(&mdsc->wait_list_lock);
> =C2=A0	xa_init(&mdsc->request_tree);
> =C2=A0	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
> =C2=A0	mdsc->last_renew_caps =3D jiffies;
> @@ -6340,7 +6354,9 @@ static void wait_requests(struct
> ceph_mds_client *mdsc)
> =C2=A0		mutex_lock(&mdsc->mutex);
> =C2=A0		while ((req =3D __get_oldest_req(mdsc))) {
> =C2=A0			doutc(cl, "timed out on tid %llu\n", req-
> >r_tid);
> +			spin_lock(&mdsc->wait_list_lock);
> =C2=A0			list_del_init(&req->r_wait);
> +			spin_unlock(&mdsc->wait_list_lock);
> =C2=A0			__unregister_request(mdsc, req);
> =C2=A0		}
> =C2=A0	}
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 00ca993ed583..cd5dacfb42bd 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -529,6 +529,9 @@ struct ceph_mds_client {
> =C2=A0	struct list_head=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snap_em=
pty;
> =C2=A0	int			num_snap_realms;
> =C2=A0	spinlock_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 snap_empty_lock;=C2=A0 /* protect
> snap_empty */
> +	spinlock_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 wait_list_lock;=C2=A0=C2=A0 /* protect
> waiting_for_map
> +						=C2=A0=C2=A0 * and s_waiting
> lists
> +						=C2=A0=C2=A0 */
> =C2=A0
> =C2=A0	u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_tid;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* most recent mds
> request */
> =C2=A0	atomic64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 oldest_tid;=C2=A0=C2=A0=C2=A0 /* oldest incomplete
> mds request,

I don't see any issues in the patch. Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
