Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6738D687
	for <ceph-devel@vger.kernel.org>; Wed, 13 May 2026 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690420; cv=none; b=Iny5CYJOToxvCesknlmzR71wBBgMSp/gXRIQTR4i3ykY6cP6p94hbKWDxCfRVI7LFw/YEnNEuEX162FrsoWIkkbJDyJzt9DDgA7LAbHMz+FNvHN9C5XU+i/moqynE9mYJL9GRUPXdiHqcNPNTym03YafN4LEfQFs6HBnDOFsDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690420; c=relaxed/simple;
	bh=H9yTeOTXGM0jMDI0rQK+xMdSOwwOoKn5jIxtu2BRMs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tTGtuz7mOtNHN4b92pGuNa7kztMqa6WHetc3oMJ4LsZGemQDrrEQ3RekJI1X3yE7RpRsrFkQunenE5qveT4sqyuxljKemd7NPL2/L9jXBQMq+xk6ry9CC1H3Pp07BHi1zCZCa7jHP4E4xsHI/pxrvPhtf5INHbUMAc+rD+IB1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=k6oHRUFf; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="k6oHRUFf"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so7083403d50.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 May 2026 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778690418; x=1779295218; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lslwSwUB8ihFK26su81DjZjl8eRHYRjgvwVFE2LcKS8=;
        b=k6oHRUFfOIIICKX6OnRdj2bsUmXzH0fBExTJNRSrPk6E6lPUehlY2aHnyG7ESKdO+D
         jXwqDKvKb2HL7fXmnQWUwcMJYm53eL/G1PRLUSm8ZrmrzTRmph37kpNaS0i1pb4KmIZs
         Ig9VH0GpRnD8zgeMTe9GeMXEsyJ50fFfBJyF1TwTIdbcaewtdKl/F3kPuLJyBzgHcDLB
         pSKJHnOwYVv6ROpIlRsSM8tL9Qh1BPsrKdxm/AZxlcxjo/iPbbMclxxbBZkAkaqlS7Ap
         pzK+M9ConSDUMwMYHabgVhGQoJb02vCOnt4B/fXJPq8cbb/FTSwCbwwMdp+JmDtt0Wg4
         STOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690418; x=1779295218;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lslwSwUB8ihFK26su81DjZjl8eRHYRjgvwVFE2LcKS8=;
        b=FyCobW/r9vVNSxk0GLi2ALuWSDmBphXorbmQN/jRA4kQM396VzvEENzeh3PdTAGddW
         UBcUq5eIplOQqHxlz1rh9ulBBjawshaZ8dZneNvRyT2GSvkl/SLOlA95TDFKlyviEOLo
         0dUBibNIvzi/K+tavM6Eei0AyicFpGc8ofCSEqJM9+xiWfYgeF/ri9+GIg6GkKnQ3p4u
         RcL7VAf27F9RgS5Ug3emVjb/P3f5VjlzyXljTX1HxhYjmGdo7Eh9cqrxuddX9TiI+exy
         yqSAmrxaZ8Me/JNKvUsHYgVBwlM+D9T3nr81ncH+rKDIq+sLRASIP1uIBNbDotTayvHm
         ke1A==
X-Forwarded-Encrypted: i=1; AFNElJ/kTfTimyySaJku8fVgIzJg788j2KQIlK6SCrEVLpNVqRBpf+6aYQ9QOH8Mfkj7qcE7kBL2/bP7HgPS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz74A95non3sDAUK+A+1sju3Zuz/D4fCXyx+2eJMQceO3fJAEu
	nyoaIKNsHgcaUC+QTI1g52+8w7+I4v4iK/bnaKHi4fzRHB2caMnKCMEPcUynYJh7PRXpSCOM7Bz
	bMgV1gpc=
X-Gm-Gg: Acq92OG+ZxC4wI9+TLxDb9PFImZS8HmERXu2V2VSeLSmyb4kg4V6DzmVDTEy03Rj0gO
	ZU4VBYP6FG4kGriC9nlPRQhc7Ca+l+4rqGUSF3DqEpLW7HJHcI3MrQnYNgzZLqxYx5JrYn8ODz4
	kqUgTTKpPHTBLqsmj/o17wUUE6o9RsGyQVq5qOUzOwRQOQxVLfqUrgW1JBiMVcnaA6P0R08a4OG
	IMyCxpRyGe/ZhIles9BDaqcnPZilQWxjjhKwSMkYWg/2y5g8j6TZMUkOLUGgfbJSDpvDp+XtzPY
	NtzO3g6GEUlfANPNjVnvMSBj0+sKoCbqDsg8/egpU7STfRrVeEZRs66yAhohK+uvXyML0+Ek07A
	LPMoHUDNd8eSt5TOtfvlC5NUZ43yqSg9joP755vYCq6DhKMfLJgoqjRJcDdHwm9ZyMPC0zZCcaG
	IiGXs+Voxpd4SZOjaJrOSI49+v7hJacAmyr55uEmMnjvtdnhLJttb9UOJNWqa/wXi+fHNmAeSmM
	CKWnI/J4915jkN0AJQs3lccAn3vyDmg6YkI6qo6xKZRAuPRZWkUEVfftYh7
X-Received: by 2002:a05:690e:4004:b0:651:daf6:3d85 with SMTP id 956f58d0204a3-65df62e45fbmr4181229d50.30.1778690417703;
        Wed, 13 May 2026 09:40:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9ff5:f08a:b03d:3394? ([2600:1700:6476:1430:9ff5:f08a:b03d:3394])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65de4126710sm2976121d50.12.2026.05.13.09.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:40:17 -0700 (PDT)
Message-ID: <a9e24eba42be211967a5342550561250c5894dea.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: security@kernel.org, ceph-devel@vger.kernel.org
Date: Wed, 13 May 2026 09:40:15 -0700
In-Reply-To: <20260513081425.1477060-1-raphael.zimmer@tu-ilmenau.de>
References: <8edcef9c-0b7c-46dc-8094-dc55b62567d3@tu-ilmenau.de>
	 <20260513081425.1477060-1-raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

cc: ceph-devel@vger.kernel.org

On Wed, 2026-05-13 at 10:14 +0200, Raphael Zimmer wrote:
> A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
> contains a pg_upmap part at its end. When decoding this part in
> __decode_pg_upmap_items(), a len value is decoded from the message to
> determine the number of items and the size of the allocation needed
> for
> them. If the len value is greater than or equal to 2^31, an overflow
> occurs in the multiplication that is performed to determine the
> needed
> size of the incoming buffer to decode, as well as for the length of
> the
> allocation for the ceph_pg_mapping struct. Subsequently, this results
> in
> out-of-bounds writes (and reads) when decoding the incoming message
> fields into the ceph_pg_mapping struct.
>=20
> This patch fixes the issue by adding a UL suffix to the literal in
> the
> multiplication to perform it as an unsigned long multiplication.
>=20
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/osdmap.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cf..42b7b5300901 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1620,8 +1620,8 @@ static struct ceph_pg_mapping
> *__decode_pg_upmap_items(void **p, void *end,
> =C2=A0	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 *
> sizeof(u32)))
> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0
> -	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
> -	pg =3D alloc_pg_mapping(2 * len * sizeof(u32));
> +	ceph_decode_need(p, end, 2UL * len * sizeof(u32), e_inval);
> +	pg =3D alloc_pg_mapping(2UL * len * sizeof(u32));
> =C2=A0	if (!pg)
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0
