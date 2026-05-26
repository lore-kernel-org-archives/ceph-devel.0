Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A53AEF50
	for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813226; cv=none; b=lKBQKgqWF0dLoBuUQlVllrP7lK4Soi6Uu0hHA4iCEwN95MC0hQfcNSmSQSau44cl2xzTlQYyUwS4pTsszL4n2h2d6lMxqYDbGm5jVz4Y1kKCq8OZwu4x3J88/8HCyxPsDI9W1oBTeziKnB9wQlr4JA0vjo6tQvTTNoK9iXn4OJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813226; c=relaxed/simple;
	bh=RBf7gEGkQ8IVe0/2TfFpMkSN+PGlwMrYNfOXmVMqfi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rb49iVVzpVJEGmpF7me3l1+sZ5sOeqP2w1CfH3V4tqcWl/G+rMQFqSSp9HkpiZa3l5r1bXDWoF3kmBu3XUwb6lNFDG6BBJnPwm4oSYyBrySb+LsHiJPyGeHvlhxvlM0EYtpMQ31LWTj774DhnpA8QtuWT6glf3l160Wc1wehtEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=0j//doZf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="0j//doZf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bde9d73678so110387817b3.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1779813222; x=1780418022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2D/WCc7wIW1+upgEMQvlsg5VTwxMfKIs5SXS6cc8+e0=;
        b=0j//doZfMAWZJ/fR/4PdwSU0FKQhNX+iQ7uRrrKsFWPvYi7IaKv39/vHlG3GFbI+hC
         K5Kmr1XP2/NnfzZ5VvkfahiVSi39t0UxT1iMQ4PgFKt3JIrIWiRjQLH6NKSagPEu1KPq
         NsOeBtM6E1m+m3S3ONp4kmwoIljusCDUEGd+S6DyU4/b19rKAw516zFGpH35obiE10OJ
         K56BaF+gdDN73IEv+fboGVTyRQ3jVV4u0w1lcEc1F8ed4908pjoqa1E2wuyDlej2xqd1
         5w8Y+2Oy4OjfAqemBoWG5584qwO6Rc3dil2JuUeb7YjxAQshxroGmWc8W4QXQmU1MzJJ
         QX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813222; x=1780418022;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2D/WCc7wIW1+upgEMQvlsg5VTwxMfKIs5SXS6cc8+e0=;
        b=iv9snbw5GhzFjh9Klac57d1bJEne4ejMvogpibP/EfPowkfEvHpojS4Ikyh5bQiUn+
         CcMCpZsDZBsMoT1AaoIKfCcXa6OAVL5PKWffMTDr977EX58J1LsMQrg9JiFUecVtIGvW
         nNLUWhZwXZrS6w9nVV+4jg5KYFtRBzihpiNnsWlRTEvVrkRevD9za73tPh7FClmik03m
         n9TM67tJ3D5lTFccyI2N7sySsG1ztr7jA637O6vltbRJ+dmqPzL9mYjgfIvlyRUf8URX
         /HvrOgaQXn1w5B5b9Q1p36MgTV3OhDi43uq+cpI0w3bglqqr7LjJzGuUu0C/moQ+KZt8
         ZdlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5a+OCk2p7Td5CxhijMxat9PZ5HheWVlVHSPaW5mtu1bPLJTfwMgScFvxEfHvhqUen/40agSUapT3M@vger.kernel.org
X-Gm-Message-State: AOJu0YwXC4RD6MnWgh56+Ib3eiakaqLPyveoexikC/B5Pvzzf/tIp128
	BE4ayJZiNh475LIidrKFaKcRiJDnR/hpR0YMN9zpYl7N6QQr3H+QNFndS/INEopMt8A=
X-Gm-Gg: Acq92OEiitNmUx/qoFfI1Mou1KK7NE0ThtStrHgEoGcpv6rNAGSf+9pByCE53IFRSBG
	04UfhCccBczVxSrYCDzHvxFVx+lMwrJ16wIGNlMDD9Boz6fuOgGs798LCq4QGfUoxuMWb1Poc87
	I4NHS+CBAqgH0iLqf+1xCmqlRwMqmT0f7Q8lYnz6Bvj1RLGZ5QMB+kPaQw1OL42Dd7RLH9kQg6z
	gPZbGNtcnps4C2+V+Y77Jd+nvqjsSmW9fm5tfeCDBedP4NMGKrlajz547Fp2oK8FALkYcvkRbTG
	0ky/IORMiLt2EMgy9lJLeuhscyXNdDNQ9eAE+K7BZB5RiYdHRp95Y9vHR8v/FTqtQ0Pq7DcAzzv
	R+FkVC3kQ4JWCpDhduX1Q4RuYQB0nqzQ5HJT/XXQuRH2m5dpAlvn7wAP0MRrI7May8eTfAc/kOR
	wz7cpogSUH3NPvdKP2JT8jmisN5boMDXURE99BXJR2Jrj3CStHbTCIg16aLQtkmsJiWmqsdSagD
	fUrE6cyplDTwfTwE8iuhI9HAiOruVccMv5SW7cLl38hWYEgoj6psJYkfzZx
X-Received: by 2002:a05:690c:82:b0:7bd:9a25:f39f with SMTP id 00721157ae682-7d20b27c60cmr184227867b3.4.1779813222326;
        Tue, 26 May 2026 09:33:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:569d:a84b:2a39:6537? ([2600:1700:6476:1430:569d:a84b:2a39:6537])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be313c9sm63634007b3.30.2026.05.26.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:33:41 -0700 (PDT)
Message-ID: <a1588473555d3b8887ad755fa7c3ddaeac508675.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Use u32 for decoding osd indices in
 decode_new_up_state_weight()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: security@kernel.org, ceph-devel@vger.kernel.org
Date: Tue, 26 May 2026 09:33:40 -0700
In-Reply-To: <20260526154533.3467475-1-raphael.zimmer@tu-ilmenau.de>
References: <8ece78d3-8a7f-4d7c-9619-ccc41f1bdd11@tu-ilmenau.de>
	 <20260526154533.3467475-1-raphael.zimmer@tu-ilmenau.de>
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

CC: ceph-devel@vger.kernel.org

On Tue, 2026-05-26 at 17:45 +0200, Raphael Zimmer wrote:
> If a message of type CEPH_MSG_OSD_MAP contains a (maliciously)
> corrupted
> osdmap, out-of-bounds memory accesses may occur in
> decode_new_up_state_weight(). In this function, osd indices are
> decoded
> at multiple places from the incoming message into a variable of type
> s32. The subsequent check only catches values exceeding the number of
> OSDs. Negative values will pass this check and result in array
> accesses
> with negative indices.
>=20
> This patch changes the type of all three occurrences of an osd
> variable
> from s32 to u32 to prevent interpreting these as negative indices.
> Furthermore, the type of the osd parameter of set_primary_affinity()
> is
> changed from int to u32, because this function gets called from
> decode_new_up_state_weight() with the decoded osd index. This was the
> only occurrence where it was called with a signed integer value.
> Since
> all calls of this function are now performed with a value of type u32
> for the osd parameter, the parameter should also have this type.
>=20
> Fixes: 930c53286977 ("libceph: apply new_state before new_up_client
> on incrementals")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/osdmap.c | 18 +++++++++---------
> =C2=A01 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 4638df7ad231..6c572c32a22f 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1508,7 +1508,7 @@ u32 ceph_get_primary_affinity(struct
> ceph_osdmap *map, int osd)
> =C2=A0	return map->osd_primary_affinity[osd];
> =C2=A0}
> =C2=A0
> -static int set_primary_affinity(struct ceph_osdmap *map, int osd,
> u32 aff)
> +static int set_primary_affinity(struct ceph_osdmap *map, u32 osd,
> u32 aff)
> =C2=A0{
> =C2=A0	if (!map->osd_primary_affinity) {
> =C2=A0		int i;
> @@ -1875,7 +1875,7 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0	/* new_weight */
> =C2=A0	ceph_decode_32_safe(p, end, len, e_inval);
> =C2=A0	while (len--) {
> -		s32 osd;
> +		u32 osd;
> =C2=A0		u32 w;
> =C2=A0
> =C2=A0		ceph_decode_need(p, end, 2*sizeof(u32), e_inval);
> @@ -1884,7 +1884,7 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0		if (osd >=3D map->max_osd)
> =C2=A0			goto e_inval;
> =C2=A0
> -		osdmap_info(map, "osd%d weight 0x%x %s\n", osd, w,
> +		osdmap_info(map, "osd%u weight 0x%x %s\n", osd, w,
> =C2=A0			=C2=A0=C2=A0=C2=A0 w =3D=3D CEPH_OSD_IN ? "(in)" :
> =C2=A0			=C2=A0=C2=A0=C2=A0 (w =3D=3D CEPH_OSD_OUT ? "(out)" : ""));
> =C2=A0		map->osd_weight[osd] =3D w;
> @@ -1905,7 +1905,7 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0	*p =3D new_state;
> =C2=A0	len =3D ceph_decode_32(p);
> =C2=A0	while (len--) {
> -		s32 osd;
> +		u32 osd;
> =C2=A0		u32 xorstate;
> =C2=A0
> =C2=A0		osd =3D ceph_decode_32(p);
> @@ -1920,10 +1920,10 @@ static int decode_new_up_state_weight(void
> **p, void *end, u8 struct_v,
> =C2=A0			xorstate =3D CEPH_OSD_UP;
> =C2=A0		if ((map->osd_state[osd] & CEPH_OSD_UP) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (xorstate & CEPH_OSD_UP))
> -			osdmap_info(map, "osd%d down\n", osd);
> +			osdmap_info(map, "osd%u down\n", osd);
> =C2=A0		if ((map->osd_state[osd] & CEPH_OSD_EXISTS) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (xorstate & CEPH_OSD_EXISTS)) {
> -			osdmap_info(map, "osd%d does not exist\n",
> osd);
> +			osdmap_info(map, "osd%u does not exist\n",
> osd);
> =C2=A0			ret =3D set_primary_affinity(map, osd,
> =C2=A0						=C2=A0=C2=A0
> CEPH_OSD_DEFAULT_PRIMARY_AFFINITY);
> =C2=A0			if (ret)
> @@ -1939,7 +1939,7 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0	*p =3D new_up_client;
> =C2=A0	len =3D ceph_decode_32(p);
> =C2=A0	while (len--) {
> -		s32 osd;
> +		u32 osd;
> =C2=A0		struct ceph_entity_addr addr;
> =C2=A0
> =C2=A0		osd =3D ceph_decode_32(p);
> @@ -1953,9 +1953,9 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> -		dout("%s osd%d addr %s\n", __func__, osd,
> ceph_pr_addr(&addr));
> +		dout("%s osd%u addr %s\n", __func__, osd,
> ceph_pr_addr(&addr));
> =C2=A0
> -		osdmap_info(map, "osd%d up\n", osd);
> +		osdmap_info(map, "osd%u up\n", osd);
> =C2=A0		map->osd_state[osd] |=3D CEPH_OSD_EXISTS |
> CEPH_OSD_UP;
> =C2=A0		map->osd_addr[osd] =3D addr;
> =C2=A0	}
