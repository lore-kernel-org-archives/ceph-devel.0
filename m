Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF937CD2B
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602208; cv=none; b=EYLwsm1BpJx23C3Yj6RChtsRQ63rZ4h5VP1iXYC+NqY3fNYTegxHo0NpS8m2IrmUw3Hxjq8TPpjcduhT4/DBMF/47F+eUvZfcvg/6tGHN1UDbOeTcy8W+Kk7zJnp5M+KCGWKFSF5irtAD4p10OVq8Llo6wHx5OKzp3tIy9HYAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602208; c=relaxed/simple;
	bh=Sx9tVgP16+DYfMS/9DzDegCfBu4NHf8XfbDUDkdOCBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HikbQVoEPQ3WlFaQ5YJ60H34JBx26jBN4XQifi2aHws9iNLxy5NQbLRFt8gARprKeIS59KwO+TgbYTqVfzf00sQ69Qaw7zCwcsDk9unMhJMEkj0IFE+31lylq0H+Z1smNMlAKhv+iu2s6aKEUcUT5fw7NDA0KQT2B3NpO171rgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=W3m48sEt; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="W3m48sEt"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e86d46b02dso12795017b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780602206; x=1781207006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aoZKPb94EwhP9d/m//IZ4XA84AB3htmBZebjWtsLJ8=;
        b=W3m48sEt4bV1Bg/fPvz/w4erCvFZDxzt1i5OujlXC2Ronh9ZIhLeDk5o/rTakyJABr
         ES3y424CdMYG3ItXz78M+Kzbk9p2RqqD3Czdm6d3AFF/vkRl1UfdL+BOHeCfacz3hXD3
         UeUSt97Xu0IUK0IlXq5Fnk6fNLE+zduy9kELKBXuIfeq6kfAeUzN7vGFpRW225p83345
         Nh9Pv+ygDLZ/+Eeiip8tfl+xttagkjTeRL5YKEOUMkEHplOoUSMPkdyRqln7/dy/QfCa
         Z36ULVEl20T5fFn0eeN53aVDtg2CR6YV2bgVd1faLW7YwlHgBGQXRRgvvhHZZd8qoSJj
         +QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602206; x=1781207006;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aoZKPb94EwhP9d/m//IZ4XA84AB3htmBZebjWtsLJ8=;
        b=LKp0ZGK4wdzGBr/UckAEnol53eqQKrHcRyqlDFxDh3HmE2MXmjtw0EWNHkyQ3bSWOb
         oz2kwO5n25Z5A1V74Z4c6iVMUbSPIMRCNjszEktmzQAtomyB9naXM2+GXlEPFZp4c5un
         dPu7m1NAtk0fvqutOE+iJp2hjKjsBXCCA68okLHf3/WkG4LhZFF81WL5W4PtAN8TSM1A
         ACgXIBCRIdVGb5G8PQsZatvkaaynr8INhAB/WPSIH6KFEHv/TNsSyTsDj1Q78mYXK7RZ
         DgV/dU0wdhyiNOuY/K3L/ENYZImlJT7wCcQKSl8sl//fjb2fPqK8756VEmrgeoU5Dc7O
         7OWg==
X-Forwarded-Encrypted: i=1; AFNElJ/QG+Mw8Snstnd8gcuNhpeKO29h1v0Zqi2oVGwrfRZxgdJCnHRhi/gpgHcZxght8k4aZ8Aw3tzKODYJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhpoIWqZ/SpmgY5qr5YlV6vK3lVd1G+s8sfhFeN6mhVB2BDaf
	LkZdp0WlY8X/a2LrowWkJNc+XY3/XNChW/SqEn/AUFccL2y/LjWhHPKvc1tAMxILUNk=
X-Gm-Gg: Acq92OExkKHy3qGtJrhMQlUYJI62aWsDboSyUMDR3DooZnctQVvaooVXWHBRZFPAs5m
	g2knqYtbaetpudIRBKlbn06LoFetnkV/iak8n/z1iTmC4Ai9rjP83ZvFOOTt16hFJkwYpljmOwH
	Pg+iGdkse8F31jJiMg4RGfLgjPM/RxjsgThipCZvgjBzlCqO+sQKhe30ezp9ju6NA2ty/OjEfRR
	BdzeItsWUUeKdSHs8Rq7QBF3ZcKEqdwevTHoa1Lpjj8PAO+5MHcO1IFU++sBeGn2mTfnG1n9e++
	u3qZF4q6nbqZw8B7coDZVM5aCKMycpoYYjxzhnaPAemrK1u8N1XRsTKUDNQGKLRTyJpWWmqAVvg
	9oVqcvJQVcRSdpU4jFWcrut8H1owv9o9n1MMRtLjfcQd7ay0Tlfoe3HxgfJg2CWdaABcI/elGk9
	W6jWDXNGrtVLhw35QX87f1Qs2HCnNlMM1IwooAtN1p7JGudLf4L9ccN+lnYG8KzNK4AeTLO79u1
	+G+6PEDWdAFXhxwlhMhXYpMQYmCi+0X79rBl1b2J4JscLezNK2OhWOrnlHNMSvt4sM8+4w=
X-Received: by 2002:a05:690c:63c6:b0:7d0:1583:4cb3 with SMTP id 00721157ae682-7ed0fd13d79mr3430127b3.45.1780602205879;
        Thu, 04 Jun 2026 12:43:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ae19:b6b2:5990:ed2a? ([2600:1700:6476:1430:ae19:b6b2:5990:ed2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a99b72sm38606887b3.38.2026.06.04.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:43:25 -0700 (PDT)
Message-ID: <db9f3f42af6a0a1d9a65eb90b605f4f9c971f46d.camel@dubeyko.com>
Subject: Re: [PATCH v4 2/2] libceph: crush: use CRUSH_ITEM_TYPE_DEVICE for
 leaf device checks
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <n05ec@lzu.edu.cn>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@newdream.net, 
	Slava.Dubeyko@ibm.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, 	ldy3087146292@gmail.com
Date: Thu, 04 Jun 2026 12:43:23 -0700
In-Reply-To: <062971a5852907a5.1780473721.git.ldy3087146292@gmail.com>
References: <8fbe4d61ba313a26.1780473720.git.ldy3087146292@gmail.com>
	 <062971a5852907a5.1780473721.git.ldy3087146292@gmail.com>
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

On Thu, 2026-06-04 at 11:18 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> The CRUSH mapper uses type 0 to identify leaf devices in several
> paths.
>=20
> Replace those hardcoded checks with CRUSH_ITEM_TYPE_DEVICE so the
> code
> uses the named device-type constant consistently.

Usually, patchset requires a cover letter. The patch itself looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

>=20
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>=20
> ---
> =C2=A0net/ceph/crush/mapper.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
> index
> 17b041779fb9da2deb8cdbf58439392d7fa2e8ef..00e139efd54eae36f75ed7cebd7
> 9ac9b0dc27262 100644
> --- a/net/ceph/crush/mapper.c
> +++ b/net/ceph/crush/mapper.c
> @@ -530,7 +530,7 @@ static int crush_choose_firstn(const struct
> crush_map *map,
> =C2=A0				if (item < 0)
> =C2=A0					itemtype =3D map->buckets[-1-
> item]->type;
> =C2=A0				else
> -					itemtype =3D 0;
> +					itemtype =3D
> CRUSH_ITEM_TYPE_DEVICE;
> =C2=A0				dprintk("=C2=A0 item %d type %d\n", item,
> itemtype);
> =C2=A0
> =C2=A0				/* keep going? */
> @@ -588,7 +588,7 @@ static int crush_choose_firstn(const struct
> crush_map *map,
> =C2=A0
> =C2=A0				if (!reject && !collide) {
> =C2=A0					/* out? */
> -					if (itemtype =3D=3D 0)
> +					if (itemtype =3D=3D
> CRUSH_ITEM_TYPE_DEVICE)
> =C2=A0						reject =3D is_out(map,
> weight,
> =C2=A0								weig
> ht_max,
> =C2=A0								item
> , x);
> @@ -743,7 +743,7 @@ static void crush_choose_indep(const struct
> crush_map *map,
> =C2=A0				if (item < 0)
> =C2=A0					itemtype =3D map->buckets[-1-
> item]->type;
> =C2=A0				else
> -					itemtype =3D 0;
> +					itemtype =3D
> CRUSH_ITEM_TYPE_DEVICE;
> =C2=A0				dprintk("=C2=A0 item %d type %d\n", item,
> itemtype);
> =C2=A0
> =C2=A0				/* keep going? */
> @@ -796,7 +796,7 @@ static void crush_choose_indep(const struct
> crush_map *map,
> =C2=A0				}
> =C2=A0
> =C2=A0				/* out? */
> -				if (itemtype =3D=3D 0 &&
> +				if (itemtype =3D=3D
> CRUSH_ITEM_TYPE_DEVICE &&
> =C2=A0				=C2=A0=C2=A0=C2=A0 is_out(map, weight, weight_max,
> item, x))
> =C2=A0					break;
> =C2=A0
