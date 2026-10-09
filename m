Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C363CB55C
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581294; cv=none; b=sREyMbe8+RHLpj5uXkL45SftwCVlbVd45bvuyrjWqNDd0eWabGVbc4gN6tgu8Ik2Xt2AnZUkmigeY0hb+vXqo3gB9q+OHQ1a5w51o5DvQUuHhlNBO7MTiYtIU0flHZg9/Fz5QUs3E+5J/8kemnis/O9pJIFdP9hz+STdHWBgri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581294; c=relaxed/simple;
	bh=c7dVmUOHRRQdq+y8uJdt5ZzUgLmvGysOTMR8sQ17MDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IPyfrr2pYV8+KijAYUIMqHAbp29th92j/fQRDrEk1GUH78iaMt+c9gowFIQzNGQqNeKt4srKnzdQxUiTrZ6mqL6OTUaFZip+KeMYGkBt/zzYBIWrCLOdH7P4t+eKKhQ0PqQiX32YV23pdjtF2yMFTgSOEN3I7X0kOrumhntcd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=eAl5Miki; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="eAl5Miki"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6768ced47aeso130696d50.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791581290; x=1792186090; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJXewPYw8pbo3C9s2Rsn0kEPlBvxG+xIjSSh1bPBSYY=;
        b=eAl5Miki/iTl6VIy0VbhjrdxELmCu36Qnkx0xwjP53pgnauwPA8LNg1Gz2+myztouG
         BmElT8u1A3UdfAqJjvFSs6mwxX2ZqWtSvkr7bLNI2gNW68cJs+iLmraaOPSPBBE3CIl5
         B2R3KlG5GgKDhQHb4wJAUzJi1Knhwo6Wob46Z69NF9JcGESWF3W7umN/TR+pxNGzbc/S
         L5tq08V5gzgm9xqgUkJw31MNi/hwg0oRgAkt+If7CVCKJNTHwnKNG1cZw+ZeUY8a2QRs
         qulct73Lvqb8OI3+eBcyZB9o8yn7SZMyVOdWZxAxsDE+gcHRlbvq4EMNoAks1JxI1YK9
         xC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581290; x=1792186090;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qJXewPYw8pbo3C9s2Rsn0kEPlBvxG+xIjSSh1bPBSYY=;
        b=OhvEqaS34pfexiYq2FKPovgUuurZDjvMBY3UTYMPmw++8fc6C3UuSViMHYNGu4fALe
         y3JKdiNRpIi5R0hEkXx9FWbZVlbRgj2TN4wpE9YVHMBHXP55NGlx1uZUwtiVIcx1pZDu
         WnkD/FbHoog8Oje0Y/Qdjp2P39/4yWp1ciSl0bVj9qVvr7HJGGrfw+fOrIHx1vjoH79N
         KC2vQrMF6WrkDvKQiz8X7rIzhoVIp5iwUSzp43vSHkHk4fOHajSOs4/e4HsvBNah8u+I
         LOuado0RMJMfJ2rhCEZZsbirXPi+425ATCrX2kQSnYKkugK91KUyOxLIdAncWQjORQ80
         4zow==
X-Gm-Message-State: AFq9FYJk7wASeHf40fbYaYmRj4e1tVM091M+DWxc9THjXYILWFlVkJUa
	TJSyCGNB1Sk34qoBiZp3Z6ZXzYrMpzScLgd607P3nKLVbPVj+pMtY7HmWF9bmoVwXto=
X-Gm-Gg: AYBFou01Oe7vsgSB6eOLsBIw2n5R5q+g7n/geDDSl4FrTKeIeSfbz1V2hm2KQ5TdeCI
	jSyHgZCkwH9tEseLJOh/Y5JUlaYvxGD5SlYXhPFzpoin76pFVuIp4ZGxU9+NZKbY2aWd6qqdqvW
	cvZEuQAQEiid7gkzLeJEkqoh9VcTvXn+CL1zmKXUc2ZQ1s+5kSC94OW9AL1Di/6B9Aa3+FV9Pxz
	N2KHvfVGKREESWluwmjZfvI5JxGeR2LnDVYhbm7r6AdsgxAvou/oREwWJB6P0PtfO/F3VTYsQMf
	XEmRl3fGNfTntaiEM/besV2dsv7AszpofjMDlD5xJ3dc/sgszaM1FQcIoM8SJNBZth0j0qrI9ON
	AYrcdpjT/3/5QgDORHJ4uVSjdp5HCcWyt45x6vmZNJXf3GDzk3lY3SSSrfsKYQaIjiytp8e6Qh7
	jd7MeiSwIX3Mc8ea1UUgfTNq8I0PK2Le9yG3yKvVfd2RjdnKL7EemjRvwgBq1fK8hoSQQlkuTIc
	2DL+4ETicfEOt0292HdQWRoeK7ut/xGaRRphE7fnZh/979paw9pUI9xyCQwuRaAGVlyFl2rtFUz
	iIR3mshuw7TqqINwIeGctA==
X-Received: by 2002:a53:ac9a:0:b0:677:ac2d:8aec with SMTP id 956f58d0204a3-6793606668dmr1132001d50.68.1791581290544;
        Fri, 09 Oct 2026 14:28:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::48? ([2600:1700:6476:1430::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1b7483sm12271467b3.11.2026.10.09.14.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:28:08 -0700 (PDT)
Message-ID: <c6805683f4ceeca80f3129043c4359a45cbe41c6.camel@dubeyko.com>
Subject: Re: [PATCH] MAINTAINERS: update ceph and libceph maintainers
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 14:28:06 -0700
In-Reply-To: <20261009-ceph-maintainers-v1-1-298e8158087f@clyso.com>
References: <20261009-ceph-maintainers-v1-1-298e8158087f@clyso.com>
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

On Fri, 2026-10-09 at 04:04 +0200, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> Add myself as a maintainer for the CephFS kernel client and the
> libceph common code, and move Viacheslav Dubeyko from maintainer to
> reviewer for both.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0MAINTAINERS | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d4b913f26c..d197c6928b08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5892,7 +5892,8 @@
> F:	drivers/power/supply/cw2015_battery.c
> =C2=A0CEPH COMMON CODE (LIBCEPH)
> =C2=A0M:	Ilya Dryomov <idryomov@gmail.com>
> =C2=A0M:	Alex Markuze <amarkuze@redhat.com>
> -M:	Viacheslav Dubeyko <slava@dubeyko.com>
> +M:	Xiubo Li <xiubo.li@clyso.com>
> +R:	Viacheslav Dubeyko <slava@dubeyko.com>
> =C2=A0L:	ceph-devel@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	http://ceph.com/
> @@ -5905,7 +5906,8 @@ F:	net/ceph/
> =C2=A0CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
> =C2=A0M:	Ilya Dryomov <idryomov@gmail.com>
> =C2=A0M:	Alex Markuze <amarkuze@redhat.com>
> -M:	Viacheslav Dubeyko <slava@dubeyko.com>
> +M:	Xiubo Li <xiubo.li@clyso.com>
> +R:	Viacheslav Dubeyko <slava@dubeyko.com>
> =C2=A0L:	ceph-devel@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	http://ceph.com/
>=20
> ---
> base-commit: b5650e70565c380d52c36f6bd0e1a4b1bdb385cd
> change-id: 20261008-ceph-maintainers-058bf128d126
>=20
> Best regards,
> --=C2=A0=20
> Xiubo Li <xiubo.li@clyso.com>
>=20

Acked-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
