Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E138F239
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826682; cv=none; b=gqfNUnHaXZ7aA7eDJdlOuSQSpmGu6yYdA0Y+6UtluKgbFFcp03ywCa12tH8Xvtq7wlHRf2WpIFVixt+KmjhVyXYWq5VZgJZRePF/Cz2F6tUxCcZijR69QiCCKg2JjkMlJ07WLPruhfeTt1VW3axMD/k/mATwCYCHjDQoxhPdUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826682; c=relaxed/simple;
	bh=Z7DDk0g4P9zYW6y19aHVOoIAtslOiynYnFGQh2M/D8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtPoz1v61mWHDo2jKzHT1M7C/79zjfTPGvjTDExRQwNqYUYXeM1P1NIKZqwjT4R8faxXaLwyRaZCEHFIa8OUEeuHsZwrRzFNaEiCMnVJ8SnSTIkSbjSTP2LFliFHsA0gZbwTRVzdEedjxzEG1pt/Xj1p6hhTND8VDb4uk8BEiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=i8uUGlpQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="i8uUGlpQ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81e6f2ee60bso5611117b3.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784826673; x=1785431473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4kthdTehAmvC+C2ux71FfIfqArWCpYYj3jAIMqnIW8=;
        b=i8uUGlpQKumY85pwQcjebvgZm0KKiFc4732BruxrQwMKmDP6B3mS0dvignNUftwakz
         ywPIMixX2nki3/sAPrxdQpiXqTqEjRBpGZupU5lI6ivSuwF9ReOcyq711aY4gF2Ua8hs
         ixR+yxVQw3jKbC2tyPuvgTxDxi1sWZSTMA1KDgfid4OI2Tapfs9AWvvBWBa4DRUkckco
         hPJo+57ExtjCmqRIq7+Ger46W05YK62YDZYVUlJ6Kv5JPcPMeYz2ydNsvovs7QlIKPSW
         lJj8dVqN7WtTLFPuTb0jZIMSZ1D/k6sHZe3DFKsivbUuYgJGyz5iVpLUxlkZjQfaLbDL
         54qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826673; x=1785431473;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X4kthdTehAmvC+C2ux71FfIfqArWCpYYj3jAIMqnIW8=;
        b=mWv9QF+siR4YYFaY7+haZHUtjwnFzzhAHX7JAXb9u5bQrUrPy4NF4GWaW9V/C6Q38n
         axAIu6FVdkxvP4qLuSMTfWsVbpmJOatDDvDuYNgNR3xdOz5LC+PR4Is8Kor4zm2od9LX
         0/qZQXjDA5Wprzb1js3sbb2D8HlcLYN1DWVD05u8GKTQg87IF5jG7UqRHRHhkvWh4mSg
         btPXdkaUL82AJ3G9ejXmxyFMdBkpy28RQ/hv82kC/9y5u7lHyuVzf+VneokXVs1QFe7L
         r7wnUS7r2GaZXLe01UOHCwZVk9oULg4IZ74EfYjnt1t3JqHfw7xGFhaplGhb+TWZh9zt
         zi1Q==
X-Gm-Message-State: AOJu0YwXbkIO4eg/irNVHRU9XkF0Z8ZoauQsnkAB6HtYJKihCLXA7yko
	fbdJR9TILreHjXRiJZwSYXt4CexbA5u8I5RFW2DVBCIzSNwRtZ2hztNiT4LGOwSClMs=
X-Gm-Gg: AR+sD12NFPN0OoGlf+WkCQaynMDOdDpGmJLjGmuX6ZBC7UiThCW9oqUfEmyPyg9Sm4c
	KMgsP6N30uTk33L6WjBaWhW+LRF2i92aJNpTlSj0RmpPACbUG5uIL5euuQVmcHZQyDrTniGvxWt
	Cek0gaZQjNYuuyRGAa0glSkKWURPAQsYrDRir5n+1fhptBv5xSsjIE8Zp85HDEmhoMjHzUB5OE4
	tWEvra1aUJbRpsQAQ4FS3droCMm4oYASPrmgVl66KTukYNe5et84l5a1IFIylumO0PzIcfq4Dkx
	uX72/2gIwbrOtoTGfcapIBB8nJPV+zs9o1PfP2k6LtBSzCy0W0IUpx9xgL0VXN9hWL1q6jKn6ZB
	tZdB/jtWb59fQCvam8qmUOnLI4fAX734B429HvRf2aVQm0bAzJHR9TplkeQ95UG/kKZTDkkVIwN
	GftLizDDcKBdOhsxOkVrP5vhgSSFnObvAiZ0UnUEMvooRcPmdtMxygtCeODprPToF31BvQduj9O
	ZfXJDb+9ndt78yUs9G4cDmlbHZsFSp7oaengT2NSwMFsimcZEJp6xTXKvcbePWPAfsUcxE=
X-Received: by 2002:a05:690c:4483:b0:81e:6b13:445f with SMTP id 00721157ae682-81f4d42b32amr2819477b3.23.1784826673561;
        Thu, 23 Jul 2026 10:11:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8af4:3b7a:515e:7808? ([2600:1700:6476:1430:8af4:3b7a:515e:7808])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33447e54sm31375907b3.0.2026.07.23.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:11:12 -0700 (PDT)
Message-ID: <5ad4cdfc709dbb58d17472e78d97bb8571944f98.camel@dubeyko.com>
Subject: Re: [PATCH 2/2] ceph: use GFP_KERNEL consistently in
 __ceph_pool_perm_get()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 10:11:10 -0700
In-Reply-To: <20260723-b4-gfp_nofs-v1-2-c06b40354ec9@clyso.com>
References: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
	 <20260723-b4-gfp_nofs-v1-2-c06b40354ec9@clyso.com>
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

On Thu, 2026-07-23 at 13:47 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> __ceph_pool_perm_get() has four allocations for building OSD STAT
> requests, three of which used GFP_NOFS and one (the page vector
> allocation) used GFP_KERNEL, making them inconsistent.

__ceph_pool_perm_get() has six allocation calls, not four:

2457: rd_req =3D ceph_osdc_alloc_request(..., GFP_NOFS);      // (1) NOT
touched by this patch
2471: err =3D ceph_osdc_alloc_messages(rd_req, GFP_NOFS);     // (2)
changed -> GFP_KERNEL
2475: wr_req =3D ceph_osdc_alloc_request(..., GFP_NOFS);      // (3)
changed -> GFP_KERNEL
2487: err =3D ceph_osdc_alloc_messages(wr_req, GFP_NOFS);     // (4)
changed -> GFP_KERNEL
2492: pages =3D ceph_alloc_page_vector(1, GFP_KERNEL);         // (5)
already GFP_KERNEL
2526: perm =3D kmalloc_flex(*perm, pool_ns, ..., GFP_NOFS);    // (6) NOT
touched by this patch

Should we change other places too?

Thanks,
Slava.

>=20
> The function is only called from ceph_try_get_caps() and
> __ceph_get_caps(), both of which are in the user I/O path (read,
> write, fallocate, mmap fault), not in the writeback path.=C2=A0 There is
> no risk of recursive writeback, so GFP_NOFS is unnecessarily
> restrictive.=C2=A0 Use GFP_KERNEL consistently for all four allocations.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/addr.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e2da3ab9f808..d2ac3df47e97 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -2479,12 +2479,12 @@ static int __ceph_pool_perm_get(struct
> ceph_inode_info *ci,
> =C2=A0		rd_req->r_base_oloc.pool_ns =3D
> ceph_get_string(pool_ns);
> =C2=A0	ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ci-
> >i_vino.ino);
> =C2=A0
> -	err =3D ceph_osdc_alloc_messages(rd_req, GFP_NOFS);
> +	err =3D ceph_osdc_alloc_messages(rd_req, GFP_KERNEL);
> =C2=A0	if (err)
> =C2=A0		goto out_unlock;
> =C2=A0
> =C2=A0	wr_req =3D ceph_osdc_alloc_request(&fsc->client->osdc, NULL,
> -					 1, false, GFP_NOFS);
> +					 1, false, GFP_KERNEL);
> =C2=A0	if (!wr_req) {
> =C2=A0		err =3D -ENOMEM;
> =C2=A0		goto out_unlock;
> @@ -2495,7 +2495,7 @@ static int __ceph_pool_perm_get(struct
> ceph_inode_info *ci,
> =C2=A0	ceph_oloc_copy(&wr_req->r_base_oloc, &rd_req->r_base_oloc);
> =C2=A0	ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
> =C2=A0
> -	err =3D ceph_osdc_alloc_messages(wr_req, GFP_NOFS);
> +	err =3D ceph_osdc_alloc_messages(wr_req, GFP_KERNEL);
> =C2=A0	if (err)
> =C2=A0		goto out_unlock;
> =C2=A0
