Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52563A7D6E
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jun 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686209; cv=none; b=X5VFv39N6GU+B2fK3nK/78sh+aUvv8cVD8pmuCYwDqBUaTWR9rBlH8X6YTQXnrHZHKLzEBT97mh+cMLACyPHYiqt2hX1YcaDqS5uYTL1o1QlvAPCEJwWyZbmssfVN/TaBm/RnQDSrUFjiHA0NnXrLpwGUdD1n+Y2SmxJlOilxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686209; c=relaxed/simple;
	bh=WUpgMGcs5GKL8oGHqdHhFZf5sK1v9fdZ9KukeG7seOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTxAtjOvm0w70KYOWRVgWwPKR4vyRWt3yb+PF8WUpJBvnD5Ff5FTRLMacJnsRYA5YlKRDP/RmF2b6MbCI6hiqNcE6XbhlTKBDElz7WkcAexRqCYmuF4SNN/g7y+jtsQUk0klu1vDxxqJY54tCGf5Mgpq7CSSZVVWpcKdrt1ge1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=kkPp3vgU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="kkPp3vgU"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e2fa3062easo24032407b3.2
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jun 2026 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780686207; x=1781291007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/qccpb3ejwQbIEdE96mwfBDplf3D7yvom8f5FV6n5Bk=;
        b=kkPp3vgUHV4ajPGuqT8mPFd8qLeBo4HUKKT8Fd6Aswv7IHPO6bM/HgVpgNpaWTbFo2
         A8DeYJDcPZqnwVEJRn7a21XSc5SMGgm2Ub+zEOhFqDn3TiGnEYuVGcumSwPWLzwT8/50
         q+36uuw8qezWu8graj54B++BPSXO5sv4rI/juXX4v/n8Mdz9uWfRf24uYoiCfw++TEAp
         UP2yJDFfYOgj7Im3FsveY6YX5V5xOqRdJqT5QsVTE+YJBHN4pRL2bEQrZ6aH5Rs1WbBe
         4hACbr1puTEqCOYuPDgUWbpdMuiecX71Z+mDOENqvXH9I3t9y9Cmcz2VKKXHbE1Qqtzs
         Pdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686207; x=1781291007;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qccpb3ejwQbIEdE96mwfBDplf3D7yvom8f5FV6n5Bk=;
        b=rSc2xzFzL87AnmJqxV/A6blUwGnQ4Lm06b8OPNNPlc5mPvdTQRbjAb9DkTuyvzKQLd
         bZsySi3WopeIb2Sq9fR8I9Hyd/JZMgwiyUKAqTY6IeFSGG1EgA8O5hhBCoOjJHFlX7Mo
         1B1nN/sC4BmNfpC0bLAl/MmcLZF0D1++klO5tejFNuTnwJ5PK+pyTfbuvmu/0PneEUkv
         5H0Et7gB3zM89bJebNKUjfCh7EQ7+kFDOvUk9eIujt6yPyAxFY627Mu4EE7jHw28hs8M
         zfu8mGKAIfU8OuBa+7HRabSkeXsNRo9vi5fQXvHptiANGYep6agVVwICr2ZcwfD9wqr0
         xGtg==
X-Forwarded-Encrypted: i=1; AFNElJ/SoGfFsY3zstsrYD83ruAho4GdOvIwExxo1dJaoDCWGorY6IyM//R3ppk0a2jt7V15ur3DgN/sGYqx@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBFxSMxFXOiiG5KPcJpkR1BQaJyr+FYKfzzeTH0S/7Dw+y44c
	Vnl9mpXQ5oq2BuIi4j3ZjNsojie9hv+aX0vVDTrHXfgRHhZJosdVp8sjF6UI5OpC4Ac=
X-Gm-Gg: Acq92OGzT6q0Q8pgunHk0/V54P/QZgYs5VgLVN7oelT7vwOjaeSqEfdEoFhK/1iZpKe
	RaKq2eBMeNDjwKwxMJ/95LAoyQMQfNTS1ak29HhnIPM+t16BTeBCBzc1zXsqRxmX00KiynReI52
	35giWtcLzkcpzyB0NC4V1DCqS+QzuilOq4MfU9Wo/V/SAqrenmvjgluH9vS6ybzS3IUz/1qVb13
	Tq3bp0YEGDZ2PJgFPBRMA/+XYOLR4DCPyqqzTRdYUGwTzzZNSEr39LTZK9GWUrP7Yr9gdhHX3hS
	AgkrL4F1G55M3Qtbg7Kd7FdZAdS3+nIFs7sjk6QURypvLRehAyrzu1hkBxXdD+Gz6qF3zM23TdQ
	LhodWIUUclDKY+ZoeJArx9oQckP1d9+84lRIz6Ur10yJXzD0y2TjLSGgcbuuHO3bwCvAUevVBFb
	q17/JgqbdKGjrlkbJtqYb2vmWNJgMfpgGju4vd60Ki+VZ2eKsFnAiUZ/lZWP2/PHXMk40W61BzM
	9BziT6MwMXW+pU2XxyixP5B9YipZrtT9ywkpXkUvpjympnMOfiikDU7drUym4bxsAi3
X-Received: by 2002:a05:690c:4a13:b0:7bd:5d03:dc18 with SMTP id 00721157ae682-7ed0c80a122mr55432837b3.29.1780686206652;
        Fri, 05 Jun 2026 12:03:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:80ee:99ae:6c1:509d? ([2600:1700:6476:1430:80ee:99ae:6c1:509d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2409db52sm53787897b3.44.2026.06.05.12.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:03:26 -0700 (PDT)
Message-ID: <ebf03d8a397f9ff3b23c1d88af3ef3c3cd796cf9.camel@dubeyko.com>
Subject: Re: [PATCH v5 1/2] libceph: reject zero bucket types in crush_decode
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <n05ec@lzu.edu.cn>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@newdream.net, 
	Slava.Dubeyko@ibm.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, 	ldy3087146292@gmail.com
Date: Fri, 05 Jun 2026 12:03:24 -0700
In-Reply-To: <b2e69ef787190350.1780640154.git.ldy3087146292@gmail.com>
References: <cover.1780640154.git.ldy3087146292@gmail.com>
	 <b2e69ef787190350.1780640154.git.ldy3087146292@gmail.com>
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

On Fri, 2026-06-05 at 16:43 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> CRUSH bucket type 0 is reserved for devices.=C2=A0 The mapper relies on
> that invariant and uses type 0 to identify leaf devices.
>=20
> If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
> can make the mapper treat a negative bucket ID as a device and pass
> it
> to is_out(), causing an out-of-bounds access when indexing the OSD
> weight array with a negative value.
>=20
> Reject zero bucket types while decoding the CRUSH map so the invalid
> state never reaches the mapper.
>=20
> Define the reserved device type in a separate enum instead of mixing
> it
> into the bucket algorithm enum.
>=20
> Fixes: f24e9980eb86 ("ceph: OSD client")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>=20
> ---
> Changes in v5:
> - add a cover letter for the two-patch series
> - define CRUSH_ITEM_TYPE_DEVICE in a separate enum as suggested
> - v4 Link:
> https://lore.kernel.org/all/8fbe4d61ba313a26.1780473720.git.ldy3087146292=
@gmail.com/
>=20
> Changes in v4:
> - define CRUSH_ITEM_TYPE_DEVICE as a standalone constant instead of
> =C2=A0 putting it in the bucket algorithm enum
> - move the remaining type-0-to-constant cleanups into a separate
> patch
> - v3 Link:
> https://lore.kernel.org/all/d21e2f97dfe6f250.1780369814.git.ldy3087146292=
@gmail.com/
>=20
> Changes in v3:
> - use CRUSH_BUCKET_DEVICE instead of CRUSH_ITEM_TYPE_DEVICE
> - v2 Link:
> https://lore.kernel.org/all/3200151429f33554f06ced8a.1780197742.git.ldy30=
87146292@gmail.com/
>=20
> Changes in v2:
> - use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
> - v1 Link:
> https://lore.kernel.org/all/4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779=
949116.git.ldy3087146292@gmail.com/
>=20
> ---
> =C2=A0include/linux/crush/crush.h | 6 +++++-
> =C2=A0net/ceph/osdmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 ++
> =C2=A02 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/crush/crush.h
> b/include/linux/crush/crush.h
> index
> 30dba392b7302de3e14861f8b769242cd8cbac9e..770b172903f3ab268226296043a
> 909861582bcb1 100644
> --- a/include/linux/crush/crush.h
> +++ b/include/linux/crush/crush.h
> @@ -110,6 +110,10 @@ struct crush_rule {
> =C2=A0 *=C2=A0 straw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 O(n)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 better=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 better
> =C2=A0 *=C2=A0 straw2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 O(n)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optimal=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 optimal
> =C2=A0 */
> +enum {
> +	CRUSH_ITEM_TYPE_DEVICE =3D 0,
> +};
> +
> =C2=A0enum {
> =C2=A0	CRUSH_BUCKET_UNIFORM =3D 1,
> =C2=A0	CRUSH_BUCKET_LIST =3D 2,
> @@ -130,7 +134,7 @@ extern const char *crush_bucket_alg_name(int
> alg);
> =C2=A0
> =C2=A0struct crush_bucket {
> =C2=A0	__s32 id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* this'll be =
negative */
> -	__u16 type;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* non-zero; type=3D0 is rese=
rved for devices
> */
> +	__u16 type;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* non-zero; CRUSH_ITEM_TYPE_=
DEVICE is
> reserved */
> =C2=A0	__u8 alg;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* one of CRUS=
H_BUCKET_* */
> =C2=A0	__u8 hash;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* which hash funct=
ion to use, CRUSH_HASH_*
> */
> =C2=A0	__u32 weight;=C2=A0=C2=A0=C2=A0 /* 16-bit fixed point */
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index
> 8b5b0587a0cfa2c437b76c8c87251199efe20291..21cdd33f2945e0c1f45277ac05f
> da373bf217586 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -518,6 +518,8 @@ static struct crush_map *crush_decode(void
> *pbyval, void *end)
> =C2=A0		ceph_decode_need(p, end, 4*sizeof(u32), bad);
> =C2=A0		b->id =3D ceph_decode_32(p);
> =C2=A0		b->type =3D ceph_decode_16(p);
> +		if (b->type =3D=3D CRUSH_ITEM_TYPE_DEVICE)
> +			goto bad;
> =C2=A0		b->alg =3D ceph_decode_8(p);
> =C2=A0		if (b->alg !=3D alg) {
> =C2=A0			b->alg =3D 0;


Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.
