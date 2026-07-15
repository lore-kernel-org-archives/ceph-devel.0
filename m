Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A2443E4C
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140219; cv=none; b=OxrS6n9GobnmDExk1zaJTrv4ysRSca3IbNspHzAyEULHo2xcBi+qz9bY+kKccvt8gKrlY9y7MXjHFuHWOf0TwxSd6YwN4PLj99RPGVVpRgdeFY/WBMj18JCrwBhpAMu9m4+hwu/j8YAf96+0QRr5qDdEgG6SDI1CavFjwip39pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140219; c=relaxed/simple;
	bh=11OYtcDGfLnG/VQ/E+WxUF5aUuKIbQwTvf6tt0ZLqjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtXslBB1n3bVOR12YyOFYGA/YXCmhXPga2O+1/HCqLpz9rOVc2cIHuQcvJYfcv4ofUwn7rKl8ZQgWaYjZRMdyDUDWypGhforgFADJsSemaaiqsEmeRBkCXgJ4hWLfQNreQ6/4NG/eALRUvG9KUabp1l6XFPP7gt0ky8goNsGbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=TdxtwZvM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="TdxtwZvM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8114a4542b2so89826357b3.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784140206; x=1784745006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nHXXFdrHNxLsvhS9dD8/+8GnqQPQqrh1h4/Frqg1eHM=;
        b=TdxtwZvMH45b6W7mO3WbJvshNyEFV4n7XTG+VGaI8zeN4GPX0ekJHeNGNm3f8zJh2Y
         THJ2IvXk8td4oaJaDVSkSO0ck6rCz6gARI47S7a8UUsVqa0y3DdefOYydep7dvQuwD6I
         TwsCq8Tf2EqBwZef9cDyRLO2+WS7vkPARcKaHu5g2CShqOylljNokShiUtyyqEWhSnj5
         g5xj3Nj+7ce2BVHMxU/PL+CRA5vMbSqCN9h4e7FU759rKrilcXmv0I+8M8DQeQK2Oc1g
         9YYg4KbPcqXAso6XWMveIK5kJN2Q7yDIACPz+7wZ8dj9wOO81FeDTX2LH/RpDDKciRZ3
         X0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784140206; x=1784745006;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nHXXFdrHNxLsvhS9dD8/+8GnqQPQqrh1h4/Frqg1eHM=;
        b=NDUDse+1rU3E3xVq1F90WlyeAQBcxgvibxLSEfnj5fXUsHAvtjyp7igeuPxFxmwIFz
         QhfxhFMOUbetdSET4/gzi2LNzqawt/H3sJNYc6bImxbIAKYJSWKnI5P+xWVy/Fi34V5b
         PzAuWN0n1qkju9mpG1m2ywYcBcjSVvo//jXi+QV1wdVV88S4e3t8xb4/3EOTJYJ8BAtU
         xrQdspDhx1I3ObsdsvN6K8MUSrfjQfGND6lRMBtykze1Id7gaOmrYsxw9c98tfUJQaSk
         AehdmC3m3hDuzxbXTl47/0t/RTfDK89VJRrtSWCDGbwPG/5wRLE3VFFAAXrydaHjXd3h
         WbDg==
X-Gm-Message-State: AOJu0YxeVcKyIsMtuLAyafvK1FaH7FHRmF/rNHfoj4dpL94uZuapkv7g
	9dg5viCCUaEokbmf2wW2M69zcLj1GOMfUDQ6MceAKb0BzPO4e4OxW+0a5D9lxY5a/ZQ2d7KR0VC
	xF2lcIteu5g==
X-Gm-Gg: AfdE7clHnXzpoXEVOuGjRds/1MsOQa31xZOgTyScIUm8gwd0ABHWongj61zKyUcSELk
	JngNksKAPfm0C9/V4WHsUMHCq+1QbaGdqFOKvGJ8ReuPDZ/83JknUnV8X5BrWaWHl44f/yRIJBu
	AcUZJrFklMQQI8+L4g1phroPxHYv+Yb2qlnkkJqSJGKv98WRQqauW+tsG+228eazdeK5WjTzR7a
	r9JoyDOObLZR15fbtDaaRH6vi2aO1pr3w/yy13KQ6gEn4xai48hwuoBbncPt/5hN64EwG7UI+Hk
	BFdoYkCW4MUU6T3R3AtUzos7lo7QmVulaV+3KjO1UTkTCI2egqH/6KE4JIo2WnQrj7Hgxrvf6Li
	9GAkD0tTfFdcvbRthqhWNR0mzHnpx1wBRoL4G2lloWDFR65iF+DZidM9MB35RN6VVJK51xubhJQ
	dEYYx09RJiQz6NxQiHq7eV8lJe54bcP3e+zpxMJqjyYYiwSN8fOn98FNnBHaRptIhfEfhinqKgC
	HRoEmwKaCaRbASLvqG86PQlsBtsiA7z4atCN3lfylUlszo6aFmXwtiRhyX3/IJ+pyORXirfs25U
	ocM=
X-Received: by 2002:a05:690c:6184:b0:81e:b980:3718 with SMTP id 00721157ae682-81ecf7d0646mr29753537b3.20.1784140206021;
        Wed, 15 Jul 2026 11:30:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:393f:38b4:2407:391? ([2600:1700:6476:1430:393f:38b4:2407:391])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bea2114sm175892237b3.3.2026.07.15.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:30:05 -0700 (PDT)
Message-ID: <2d940ebd58b730d06bbc262aa1dab6011d65110d.camel@dubeyko.com>
Subject: Re: [PATCH v2 3/5] ceph: add wait_list_lock for wait-list
 serialization
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 15 Jul 2026 11:30:03 -0700
In-Reply-To: <20260715-ceph-mdsc-mutex-optimization-v2-3-90e81b726724@clyso.com>
References: 
	<20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
	 <20260715-ceph-mdsc-mutex-optimization-v2-3-90e81b726724@clyso.com>
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
> index 239ed34886f9..a250938f32d3 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3669,7 +3669,9 @@ static void __do_request(struct ceph_mds_client
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
> @@ -3692,7 +3694,9 @@ static void __do_request(struct ceph_mds_client
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
> @@ -3740,9 +3744,12 @@ static void __do_request(struct
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

Do we really need to add the curly brackets here?

Thanks,
Slava.

> =C2=A0			goto out_session;
> =C2=A0		}
> =C2=A0
> @@ -3757,7 +3764,9 @@ static void __do_request(struct ceph_mds_client
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
> @@ -3850,7 +3859,9 @@ static void __wake_requests(struct
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
> @@ -3892,7 +3903,9 @@ static void kick_requests(struct
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
> @@ -6359,6 +6372,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
> =C2=A0	mdsc->snap_realms =3D RB_ROOT;
> =C2=A0	INIT_LIST_HEAD(&mdsc->snap_empty);
> =C2=A0	spin_lock_init(&mdsc->snap_empty_lock);
> +	spin_lock_init(&mdsc->wait_list_lock);
> =C2=A0#if BITS_PER_LONG =3D=3D 64
> =C2=A0	xa_init(&mdsc->request_tree);
> =C2=A0#else
> @@ -6445,7 +6459,9 @@ static void wait_requests(struct
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
> index c2de551607e3..0a9f89498604 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -534,6 +534,9 @@ struct ceph_mds_client {
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
