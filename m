Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F533031C
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150045; cv=none; b=LTGRGj0P19RrbxAnBm2Yxnm6wU80nwLKaqyvUy9SCyuXMG+9kIurwoKiop8w770gpeyu8vLuLLgc7o68rmzretVPbf/5fYe5/JVBQ2XCGrymfmJ8sab+NWP/uC1Mn+SUzv/LkohbZ5K+ob0D+5lG+nOiSwZuD6ZvEkyTYyJYlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150045; c=relaxed/simple;
	bh=HsYXyr97aMfIGCAg5+F0XlMxux8Zlm88WeIZnjXKiaM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itJFxjZfV5AJWObIUvjhq6REP0os//WFErM8glXyqVvm0KaKTP9xugXYcAD78Q0/WhFd+JZN+YJIlQlHPNE+TA3VEutoTXiFndZkiXx8k0IUmd1P0bQS4IrmfqUhwOjgyaxmaU8wcm5mz2BUpTA934feYvDaw0ljXMPenOE8A8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Ei/Uk/HQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Ei/Uk/HQ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso456902e87.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 20:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781150042; x=1781754842; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sr6xKM1BGqM/0jr/zsmBcQeY1xQizRY74CdLHDiuQ00=;
        b=Ei/Uk/HQBEjc2HOV/ywh5Yh7o0qItX14NXb2qZ7hiv+5BAXOkxKyUzYSS7tA0Op0gK
         AsQ1nf3WoQPPWaV72/U2ikHIMGYjigSZM/vEdXDe08zV0ByADFmTTSVb51k/Uo0TMnhj
         QlmYJ8bK0Clu2kIvOJX3sQWAG/qyZyjrSgv1WiJpLEHMaZUam9hwtq59wGvhBMGBMIY2
         kgnZYPk+ld60QAcMqxsnnsNIVHzJhMxR91O/VUZNwZLJ9WcuxRGPXGttVEU0kbqJFiLq
         roCijDaaAndZQZuFgCTAm1yJLMYM25uQpgMswgtdt8skdhquYONWTAdo/SWkFtwsmfMH
         JWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150042; x=1781754842;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr6xKM1BGqM/0jr/zsmBcQeY1xQizRY74CdLHDiuQ00=;
        b=WlHdB7ny9JStIWmLKM/9jZgA6lVv1C26vRD2RJy6mcrxgSrR2BimiFAlPCiHEuboeD
         nQejH6bKC7mRuvAo8QA47a0DzfPo/NMexecHPTv1KE9HsNWvA60JJuX5YIxhLBj7R3II
         bcWY21kI2yhTC4U6qf1eVJNI++gvusoFx7HaBxQ4YsUOSjB3IVDDjumMM6ocAlT9Maby
         N1WEfGVEQRABCCx5mTrmVT8le4qp7zKTkjnvGoTccblxjsMfWxvMqgzg5gj7KPKAH+UG
         Vpr9BAfY5Id5QJ0RX1Vx5b80MpEZUouMbzXQkLF61veHP+WMl8Li1uxf1ScWSTqF0y+Q
         OpTg==
X-Gm-Message-State: AOJu0YyjI77v7U00tVtho5K10sfI+vmu5bojeVz5paS4CDfEnE40JKR3
	ywPVRdzF10JD+a+roRrbtJyHLhobsAJjYQp7trbmg9UJF5KDDjTzDmsLloypKWNQycBwSe1aDOh
	7lbI1R4pCRQ==
X-Gm-Gg: Acq92OGOo3TNnDKZTYvQZYhlPQrwFD2QBLB9mVwdPd52MFxG+e68fKzVZmvK3DrMqEL
	w7yASmLvO5TcC61HpczWjXac3nUo8mH0l9qAjUlucxT1XclPx9HwAH4Uca1YkMdnN6J1ezylRVJ
	xPpmlbgRRy4ml8tnSoph1WbEx+Nbpe8DoYFJcSaxcULouJk8jjAfq41viMF+D+D5wLVkgthg6WF
	16wegrINe5WhO0yVeJ6sTm8z2ayfB8lDUIph+6Xcg2ZjbkWeFEJVlZgOtFilHHC+wDk3fzU6t0a
	4mj+iNKu+YS1g9UfLFZrjb5O0/HaM4fFMezBOlqVdDKJi9z9yQOV6sxyFZRbiqAexGfUWZ/fAeu
	F069KhQ+Wf66HCXAW2oGdKxsMWa7YsFMUiYLQOLf/ys3G2zfMBcxCW79ZAQijG33FUwuX6KHEEL
	jDJTojv6msSTLVxIe5coP9KKhHM9zRGk4l6k7DpRTtPz85A0cH+pdCFSiwRdRHnSyJw95NVSnGV
	eZOFfjuHTUxmQ9QCrjqWYCAcAolzAyPThnRKR5ovlCUomUpdfZG5NLqk/PWFjBL95E=
X-Received: by 2002:a05:6512:1108:b0:5aa:6a11:3a29 with SMTP id 2adb3069b0e04-5ad28509a4bmr235210e87.3.1781150042135;
        Wed, 10 Jun 2026 20:54:02 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97b9c4sm5963291e87.48.2026.06.10.20.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:54:01 -0700 (PDT)
Message-ID: <a4b07ea74167dfb681c481bc21243b5e7e652472.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Reject osdmaps advertising pools of
 unsupported types
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Wed, 10 Jun 2026 20:53:57 -0700
In-Reply-To: <20260608151310.1061874-1-raphael.zimmer@tu-ilmenau.de>
References: <07595980-b8aa-432b-bf1e-e21cb036bfb8@tu-ilmenau.de>
	 <20260608151310.1061874-1-raphael.zimmer@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CC: ceph-devel@vger.kernel.org

On Mon, 2026-06-08 at 17:13 +0200, Raphael Zimmer wrote:
> osdmaps are received over the network and typically contain
> information
> about existing pools. Information about each pool is decoded in
> decode_pool(). A pool is either replicated or erasure coded, which is
> encoded in the type field as an 8-bit value. Currently, any value in
> this field is treated as valid even though only two values have an
> actual meaning. If this field contains a value other than
> CEPH_POOL_TYPE_REP or CEPH_POOL_TYPE_EC, a BUG() assertion in
> ceph_can_shift_osds() can be triggered subsequently. This happens the
> next time calc_target() is called for a request in this pool.
>=20
> This patch fixes the issue by adding a check that verifies the pool
> type
> directly during decoding and rejecting osdmaps that contain invalid
> values.
>=20
> Fixes: 4f6a7e5ee139 ("ceph: update support for PGID64, PGPOOL3,
> OSDENC protocol features")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0include/linux/ceph/rados.h | 5 +++++
> =C2=A0net/ceph/osdmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4 ++++
> =C2=A02 files changed, 9 insertions(+)
>=20
> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> index 73c3efbec36c..5b5c33845301 100644
> --- a/include/linux/ceph/rados.h
> +++ b/include/linux/ceph/rados.h
> @@ -86,6 +86,11 @@ struct ceph_pg_v1 {
> =C2=A0#define CEPH_POOL_TYPE_RAID4=C2=A0=C2=A0 2 /* never implemented */
> =C2=A0#define CEPH_POOL_TYPE_EC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
> =C2=A0
> +static inline bool ceph_pool_type_is_supported(__u8 type)
> +{
> +	return type =3D=3D CEPH_POOL_TYPE_REP || type =3D=3D
> CEPH_POOL_TYPE_EC;
> +}
> +
> =C2=A0/*
> =C2=A0 * stable_mod func is used to control number of placement groups.
> =C2=A0 * similar to straight-up modulo, but produces a stable mapping as =
b
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index f8d5621bc767..e440f6019d58 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -818,6 +818,10 @@ static int decode_pool(void **p, void *end,
> struct ceph_pg_pool_info *pi)
> =C2=A0
> =C2=A0	ceph_decode_need(p, end, 4 + 4 + 4, bad);
> =C2=A0	pi->type =3D ceph_decode_8(p);
> +	if (!ceph_pool_type_is_supported(pi->type)) {
> +		pr_warn_ratelimited("got unsupported pool type %u",
> pi->type);
> +		return -EINVAL;
> +	}
> =C2=A0	pi->size =3D ceph_decode_8(p);
> =C2=A0	pi->crush_ruleset =3D ceph_decode_8(p);
> =C2=A0	pi->object_hash =3D ceph_decode_8(p);
