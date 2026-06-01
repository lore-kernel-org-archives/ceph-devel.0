Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543035202D
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340340; cv=none; b=hr2PgrfNPqnY0sffPZHEdP0dOBiMDyhmjKeWYUyRzfVfq88B/KXwfNJ5+00uV/NXc/0GON3vT2jsowtxaO6XLAPKMcLXn+PnzYkxMA2oxNW3maSZR8iNkyFqEbTk5rzzc5smseAzkE0LzSfoo1sHQoIzZMFq7+shuiMLe4YAd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340340; c=relaxed/simple;
	bh=NttjgTL0KkfxNDp9FTVR9xesgewRUBwVBrX+BvhDvf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khgb6TyZoz4AsGPdyF8DxkiFgcKDmsyB4UZYVZSooGdTq06u/6g27wN/nfPX/B46q85v7sJjjCP6pkcs/Hfkm4+e0MIsPwcgXdDd8n1jTYnNIFLoygN19+e/UKKtYNJgKukl2ZkqOO6qLk9LdtPZfl5dzmIDNxmXnbGAuVEtsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=W2CCyGUh; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="W2CCyGUh"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69de237f0a3so3481178eaf.1
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2026 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780340338; x=1780945138; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bW0FmlfQ+vNfSZLBSaLUH+ngZvp00QMDb1Rd0LqLyfw=;
        b=W2CCyGUhoUqWfB8kU6hrZocHlFfjwkMqA9DQHoBfEhCxVgH6ymPAPKCGhMKXWMecxP
         D8BXL33oyVaDuPN1o4O/Pej372zCSwpefPXz/kcSLey5tr5TjFf1CQEIXQ3lZ2adeNaj
         Q2xLpYXJdJNLCV0/9nBECGx3AGzWmklCJuuCweIXI5aBsmjVt70w3n6cXuwQ3OfnYK97
         zCa7aZvx9T0x4zrZ/TJMMW60X2NUKlsfui4GP9DJUHVAEB4gYVhVShP+fuY6VkU1mg45
         SY22Bi1adOjP5qQyLN+TDh2r18Gd1L/V53ZphwK3Oxtt0EqpiMfwlY0bGVMq8cNaGUCm
         QdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340338; x=1780945138;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW0FmlfQ+vNfSZLBSaLUH+ngZvp00QMDb1Rd0LqLyfw=;
        b=M+dgd+4eIxuHHxHY5wVoogDxSbtYt3XZxpYqCk2EL9kLzIuphudncMm0XnAwpvRZhM
         3ufJ+lEilffYFOegIcfNDWmlPbVFfaeHNG2/+6cD6COpPQxuGX084QOnrbRrUL25Zzxs
         ORIUSkfpNC5kFCVh6kQ7AMQI6hNkUT2tDGwDoBrQULqqS0Zckb+uoTjo1n1iw+31Jc74
         q0vXvJgm99KbBs2EqFMu4SyVC8soXpCZHTdbOitV+In1vrJH+fi4R1guJOAPJvzyEnXB
         AnTGGdZTxLqKRHcEck/edGdhV7jUVucbZGLf1KsYMypYdbRUew5++AAf91xbNCe3AOji
         w2PQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pSF+GJ+sMZ2Rg3BwwYbhvcdF7kpHS1aJN3vAImvD1PlvmSzlo8Eif1J7DPXBNrFfRTY055dYu1fT/@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9m0N7uRav0gNc+P5BisUbVhIbd6AP6Wd9gw9OEr3L5tySiBy
	m2qvk8J3PdWNVDLkEv06+diVdRvRoGFBNuc5ERBCScuTf21d3JU3+uZJAdV+ZE4v2frKtKu18MH
	6BKh5DDkxPA==
X-Gm-Gg: Acq92OHOz1zSNpmo/AWiKWVREBRDXm/VhUw/Y/OrqVS571zhgMa3TQB94LsqP+BXuSK
	/g2j9r2BvxhkVlv1UfarDIcGln0UGVOzHGbb9wQKAvJJsgEvDWoIPVM+abwfSlHNj1skLev24WY
	QFDaQHgBH/i3nD7u1FNFNLnzJUhG/52KVNlrY99A5REwK/sSrMMf+ABhfXOLqhN7DvOUbcBpsQF
	NznrGeUkDCeMpZrmuzCdKdg2zkSBZDSJHHLXozbrPbAQ3NqYa8fO8/BpJwfT0fhY65M/opOaIAi
	JquLaGm6pZBmtG6nKPcqnp9Ykiq/i6T18MocBg9/2OvgNeNBfPMTc4ldkilcsxKKJxX8kXme+HT
	q/tPsgdILePPx0/TIPagiAdktG/ZMUIb6Bx9725e2Bygj8BfaMe1d02AiwpwTsqkCreQUEwUdHW
	hVx+RkGJ6asoexbocHW1cMhmPYPhij5d+R+Tk6ddO9Mg6a0RO1ULBmcgJaVYEXgl2Y+bsPohgQn
	bV9QJ6frrLpANwMwK/Y7xr8SrJikJ0AY7fUYKYfLt64UldmQKJr3aRlo5MiyCXPe5L7if4=
X-Received: by 2002:a05:6820:5716:10b0:69e:264b:ccd9 with SMTP id 006d021491bc7-69e264bd199mr2239800eaf.39.1780340337703;
        Mon, 01 Jun 2026 11:58:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e069ba3c6sm7321172eaf.14.2026.06.01.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:58:57 -0700 (PDT)
Message-ID: <5d664a6f05db3559a85e4da4c482888dfcb930f5.camel@dubeyko.com>
Subject: Re: [PATCH v2 1/1] libceph: reject zero bucket types in crush_decode
From: slava@dubeyko.com
To: Ren Wei <n05ec@lzu.edu.cn>, ceph-devel@vger.kernel.org,
 vdubeyko@redhat.com
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@newdream.net, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	ldy3087146292@gmail.com
Date: Mon, 01 Jun 2026 11:58:55 -0700
In-Reply-To: <3200151429f33554f06ced8a.1780197742.git.ldy3087146292@gmail.com>
References: 
	<3200151429f33554f06ced8a.1780197742.git.ldy3087146292@gmail.com>
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

On Sun, 2026-05-31 at 18:02 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> CRUSH bucket type 0 is reserved for devices.=C2=A0 The mapper relies on
> that invariant and uses type 0 to identify leaf devices.
>=20
> If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
> can make the mapper treat a negative bucket ID as a device and pass
> it
> to is_out(), which then indexes the OSD weight array with a negative
> value.
>=20
> Reject zero bucket types while decoding the CRUSH map so the invalid
> state never reaches the mapper.=20
>=20
> Fixes: f24e9980eb86 ("ceph: OSD client")
> Cc: stable@vger.kernel.org
> To: Viacheslav Dubeyko <vdubeyko@redhat.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>=20
> ---
> Changes in v2:
> - use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
> - v1 Link:
> https://lore.kernel.org/all/1cab97763b0564d03a583deb7eed485b68be6182.came=
l@redhat.com/
>=20
> ---
> =C2=A0include/linux/crush/crush.h | 1 +
> =C2=A0net/ceph/osdmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 ++
> =C2=A02 files changed, 3 insertions(+)
>=20
> diff --git a/include/linux/crush/crush.h
> b/include/linux/crush/crush.h
> index 30dba392b..eb469972f 100644
> --- a/include/linux/crush/crush.h
> +++ b/include/linux/crush/crush.h
> @@ -111,6 +111,7 @@ struct crush_rule {
> =C2=A0 *=C2=A0 straw2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 O(n)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optimal=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 optimal
> =C2=A0 */
> =C2=A0enum {
> +	CRUSH_ITEM_TYPE_DEVICE =3D 0,

Let's be consistent with other declarations. What's about
CRUSH_BUCKET_DEVICE?

Thanks,
Slava.

> =C2=A0	CRUSH_BUCKET_UNIFORM =3D 1,
> =C2=A0	CRUSH_BUCKET_LIST =3D 2,
> =C2=A0	CRUSH_BUCKET_TREE =3D 3,
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a..21cdd33f2 100644
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
