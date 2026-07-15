Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD241A577
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142751; cv=none; b=fNBfzWNETgk2Y8y9CdmVpkWqNgMno4ins9v0PLAmarnqYmIvPC5h+/aPnu0rDfCHCskltpsswK97UFUuLrYIQyP2KDQqY7C9ps2oPAKBYE2zC9agrhbQDioLxFdgAQiKQ5WSnA4dx94HhsMZlvYAi8y1lnDNcCUQ3lm/QnZIiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142751; c=relaxed/simple;
	bh=1IMwiKrJJSZcShW8M3ZHXZKwLMY6moLmvhNLKw12MbE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oESNSYreXXLbSiTz/NHSe5NStmfhv4eCwVeq+S3MIMdIJPmDUIW2iMgPg/Mur5qvfHvdXI3FzJfRfGuOITEJl9ikaT3FjMTFxOSjcw5Un4K9Wi4PR4WjlzseRCA3hCrwwQS9IuGNRB3VwfGIcYKOgqX24HwxMK7Dfdk8+trOuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=vpvUiWg+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="vpvUiWg+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81dfdbd86d1so24563987b3.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784142724; x=1784747524; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tSOOtcg6Khdn/UeRGfyRSZMYadf/ex8ooJ+XLxSuMI4=;
        b=vpvUiWg+u5RpSHVbD7j8XAUyblLSI2bCkB/BlbQqcimUrvRmW8aBI9toitDLh2GYtw
         Oh29h1xfzZjjfkr7RBpRxMtIcBzn+Y89BFWDDMuUGz+TsvMxfArySlJ9qaOCLDRY8qED
         nntLmYZxCDtdk4o15WF0lCCxuoVaMj8/C8wMHHJCuzzcN+rTZALvpF89gFF0iEjvpbrx
         r6C4QOd6Mp9fJCLjeiIBdvyUb7XYi+ofC1HVTBEQcRnK2ULA111xZLZ9Lk7Mt+dEfU07
         0DqAn46NNrILIvJ0Kg963Q3OMK34yaW9rT2wdFPxJPwwitD04I49VhC7NNimfVXiP7X2
         GfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784142724; x=1784747524;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tSOOtcg6Khdn/UeRGfyRSZMYadf/ex8ooJ+XLxSuMI4=;
        b=bRgPMcvZRBuoZJdLJ3WEnA45gsEN7cfcD/9h+fT3smpKuWkg6sQq4qrPpWseauoF/K
         kXQMibRmhDM3G16YJB3mE1Jt5FiXUA28Hcu/lHnzDnOyrV6DZGmfq1IzNhC5UjGXTIZD
         XmJUxMT8TxqDcDADzNy5sZMPJ3KSpiheYC9hyGgWIjdahGTKiFu8U53Bj7NM9I7ISp4L
         jhXrcC7sHAUBfm7Pi4hVKXtDrbxizPnBEQSsGR7su26pL1FK0QWhg7AYgJnPue9M+hdy
         UN+IVetLcufhUp4ov/rbbJJ0V+O5uF9U/lC/4ABEqArEJjkkAeNHt6gTXxpkcpRbAeht
         Hw4Q==
X-Gm-Message-State: AOJu0YzvCgZ7p8rRh42dCKtzHvtgyY7Fy/UdAAWtBducMe+iA7ImPPO5
	+M4lZTN3pc38o3pNdO4JoskI7M+RgTqcsM2/Xf3l38HjTQ2q97rFcTktLZRedGR6gOCRfsNyEqH
	S8yV5IJY=
X-Gm-Gg: AfdE7cnG0CPz8X7XF/d1Ls6vr1sdrLTSG0iCzaUsOJiCx2p4ta2Pz6yWU6xzfXR6ELJ
	k+HUZdCWIKQfxRGVyplHIKakgNpG9+gALU6bpiFH8zYqCwqTU1r/o6qIBEDd/x4me6rt4nydChw
	yKTfM6qR8H16GELN3Lg0foaOhZn3W36T7M7WuRkxZZmceZ1GP55nNLgdLZ4VQGfOuUuTnKubVCL
	Nr0/3OKdBgL1DFfE3qFA7IxVbojSUSx0EiT2vDo38cwDK6UQyEI0H+UCnkE6h4Qjbh9cmxQCd3F
	zNoHW+TK9GFzZgV1zb8tgCjZABv0SxypfmZa6GWkj8DqqiNyHyIBR7fj4kjILjdApjWe76XapSM
	IIWtaFK/xEdS3JQ62bT1EQr70GK8GqiB8CE0nXPO5Wn5VehGRBcWwaivVWAUAfZ33NVMiCAOVxm
	Bzt3m9+GebHhZNiGdLy0EgtEn/Gkoz4/gWOgR+b9zbIa+X/rtRLqbuzry9S4hoORm9GeiEBAD6U
	ugkWGR3iT9uwFc0tnmN0IiywtvDJKuc1v7rPIGNdz5U
X-Received: by 2002:a05:690c:82:b0:81e:45a6:bd5a with SMTP id 00721157ae682-81e8fe8b6c2mr141479867b3.0.1784142723767;
        Wed, 15 Jul 2026 12:12:03 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:393f:38b4:2407:391])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1eea67sm178331807b3.37.2026.07.15.12.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:12:03 -0700 (PDT)
Message-ID: <c9ce608055763b943837451367b90716a343845f.camel@dubeyko.com>
Subject: Re: [PATCH v2 5/5] ceph: narrow mdsc->mutex scope in
 replay_unsafe_requests
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 15 Jul 2026 12:12:01 -0700
In-Reply-To: <20260715-ceph-mdsc-mutex-optimization-v2-5-90e81b726724@clyso.com>
References: 
	<20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
	 <20260715-ceph-mdsc-mutex-optimization-v2-5-90e81b726724@clyso.com>
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
> __send_request() is lockless so holding mdsc->mutex across the
> replay loop only serializes the list iteration itself.=C2=A0 Collect
> the unsafe list entries under the mutex, then replay them without
> it.=C2=A0 The old-request tree walk uses xa_for_each() which is
> internally locked.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/mds_client.c | 51
> ++++++++++++++++++++++++++++++++++++++++++++-------
> =C2=A01 file changed, 44 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index be0dae919d69..c313574def74 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4744,30 +4744,66 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0#else
> =C2=A0	struct rb_node *p;
> =C2=A0#endif
> +	LIST_HEAD(replay_list);
> =C2=A0
> =C2=A0	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
> =C2=A0
> +#if BITS_PER_LONG =3D=3D 64
> +	/* collect unsafe requests under the mutex */
> =C2=A0	mutex_lock(&mdsc->mutex);
> -	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> r_unsafe_item)
> +	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> +				 r_unsafe_item) {
> +		ceph_mdsc_get_request(req);
> +		list_move(&req->r_unsafe_item, &replay_list);
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +
> +	/* replay unsafe requests (local list, no mutex needed) */
> +	list_for_each_entry_safe(req, nreq, &replay_list,
> r_unsafe_item) {
> =C2=A0		__send_request(session, req, true);
> +		list_del_init(&req->r_unsafe_item);
> +		ceph_mdsc_put_request(req);
> +	}
> =C2=A0
> =C2=A0	/*
> -	 * also re-send old requests when MDS enters reconnect
> stage. So that MDS
> -	 * can process completed request in clientreplay stage.
> +	 * also re-send old requests when MDS enters reconnect
> stage.
> +	 * xa_for_each() is internally locked.
> =C2=A0	 */
> -#if BITS_PER_LONG =3D=3D 64
> =C2=A0	idx =3D 0;
> =C2=A0	xa_for_each(&mdsc->request_tree, idx, req) {
> -#else
> +		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> >r_req_flags))
> +			continue;
> +		if (req->r_attempts =3D=3D 0)
> +			continue;
> +		if (!req->r_session)
> +			continue;
> +		if (req->r_session->s_mds !=3D session->s_mds)
> +			continue;
> +
> +		ceph_mdsc_release_dir_caps_async(req);
> +
> +		ceph_mdsc_get_request(req);
> +		__send_request(session, req, true);
> +		ceph_mdsc_put_request(req);
> +	}
> +#else /* BITS_PER_LONG !=3D 64 =E2=80=94 keep mutex for rb-tree iteratio=
n */
> +	mutex_lock(&mdsc->mutex);
> +	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> +				 r_unsafe_item)
> +		__send_request(session, req, true);
> +
> +	/*
> +	 * also re-send old requests when MDS enters reconnect
> stage.
> +	 * Must hold mutex for rb_first()/rb_next().
> +	 */
> =C2=A0	p =3D rb_first(&mdsc->request_tree);
> =C2=A0	while (p) {
> =C2=A0		req =3D rb_entry(p, struct ceph_mds_request, r_node);
> =C2=A0		p =3D rb_next(p);
> -#endif
> =C2=A0		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> >r_req_flags))
> =C2=A0			continue;
> =C2=A0		if (req->r_attempts =3D=3D 0)
> -			continue; /* only old requests */
> +			continue;
> =C2=A0		if (!req->r_session)
> =C2=A0			continue;
> =C2=A0		if (req->r_session->s_mds !=3D session->s_mds)
> @@ -4778,6 +4814,7 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0		__send_request(session, req, true);
> =C2=A0	}
> =C2=A0	mutex_unlock(&mdsc->mutex);
> +#endif
> =C2=A0}
> =C2=A0
> =C2=A0static int send_reconnect_partial(struct ceph_reconnect_state
> *recon_state)

I believe we have problem in the patch.

Once mdsc->mutex is dropped in the new code, a concurrent "safe" reply
for one of the unsafe requests currently sitting on the private
replay_list can call __unregister_request() =E2=86=92 list_del_init(&req-
>r_unsafe_item) on a node that Thread A (running
replay_unsafe_requests()) is simultaneously iterating and unlinking via
its own unlocked list_for_each_entry_safe(...) { ...;
list_del_init(&req->r_unsafe_item); ... }.

Two threads mutating the same prev/next pointers with no shared lock is
a linked-list corruption =E2=80=94 it can skip or duplicate entries in
replay_list, dereference a pointer clobbered mid-update, or trigger a
list_del corruption BUG() if that's enabled.

What do you think?

Thanks,
Slava.
