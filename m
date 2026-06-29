Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EB277C96
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754209; cv=none; b=ZpHr8xJkZmxlek+wO0+klPMRnLzRnc/u2+W054+hHluNtF2k2Ly5mJYYHzr9uaswHrk9iddGPUrLXY9A1yIjNVOhQOEUpcSVOWD/RqbHpaey5KI896K733IXSqzW2Yo9pGRwVk2NtzsE9fmcVxRg9iLLOwN6PDor1WdbQpJvqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754209; c=relaxed/simple;
	bh=IdweaFNEYfKzGZjv/GcCNnov7SqAEdrY+m6OxCZ0A2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yb6GOWi3zLhCvlTeKndcRQ/EQ6GTWQEfpic5GJgHEtv8rcxoMeOmb59TPn9GSWRM1owt5tT54tUNO3oZVuEfs98UVU9tzea+ZwCuJGGDu8jsscCCpxW8IbVhMu1EQp5qhB5+dxdjxeO5YhOzpIfh4T0mWx6jXyuZO4+L18NCxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=jaktLP3C; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="jaktLP3C"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81062fdeaf5so5846117b3.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782754206; x=1783359006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h4UL2cbD1Zc05itgwmJ0DZCBmEPiOQqBWr3h0EK8qFo=;
        b=jaktLP3C87xtc6Mtz613zVhl0EH/RLGyuNQTAhN1PKqrQWv6RSVquFtojELEwJ9h9j
         pu9/ehPEO4euF62X/nkGqjQEDRSZcpzMonje+SuPZru005WOX9b1Qhh+PoL4kQB6q526
         w/ECTJg01uZ11bKSV7xW7+i4Qfbhyll54K93esc2N/BHVYsCMD7A15E1Z/ZrBMCSBSHi
         1ZOAYeebukqlohpptNPhAseRKWEwi/eEZNSWgZKnGF3XR6Pk5YgCRT+PMqlqbixEv3fQ
         V10GO9656rdvTPpbGv8YXn1zN/DxA7Na9u1CyUptowaT6SVo1tAI68WuMUMhmZboTT6L
         MrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754206; x=1783359006;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4UL2cbD1Zc05itgwmJ0DZCBmEPiOQqBWr3h0EK8qFo=;
        b=X2yWsBBpWnrlkNhuiTmuLAedvePfEgrHT/PvIa1jkzOnXFFQDhUxNHi9XXbp7Jz9Af
         fkSh4s0ATSbbsOduyAmW8wS388/CxbuGemtDamovFUmkvnkjDNttJ/UJXaV1f4SKQRRD
         znMoVODJlXxqwBl6QSEE7IIO/e94Aan5G8BeLXJSS4PyME8cTBMLpsGUhy0o+tZeaN8h
         7vu22qW6julicYsh1uQlcxz+LxR8j4j8eXAbFhJKitmbrIGUXEH/yMetZutjFUL4sRES
         VSDQLdDdWaTIEa4sEneRf3kFOIfhHfmyddzw9FfIMrRe7eKTfSWcw6AFXD06wZy+tUh1
         yR/A==
X-Gm-Message-State: AOJu0YxTiqs3MtuYIDHBcxF8DzSxT8tCPt8BGdLKSb6Wkq8Xu3XE1ReQ
	f99mf62ukc+RoqsK9nQUNGmWUJu9c55/QDz+eFpGtPapkfD94rEXZBOCoXaCnY30iPA=
X-Gm-Gg: AfdE7clwxmHdtEUDf4NOX1wvBceCeX4CkmbUNuU2ZkFKjVNK+rLZA5RKmntu/ffqYNR
	VGN9XbviTPpkmKtHYbBl7RLGxg3DW8nU0byQSqOzhs2fEutOnPvgSTw6pcPBa7a3Tt2Z6phVnEt
	5GZ3sZam+OofEG962+oTIkzDY4faMiRMrCR96YVdhSzn309fw+EhO4BKYMMyCwad48JDIOzSyZm
	NQhz3qHcSc80lbtOJ+0CHbQzhvg74W6ljTg/d96r1ZnhuXT6KLIxw4/AuVcmPUAhbXXVtGJfgTK
	X7b07ICW358mRLHKKkvUywpq0QySwUmNLW0O6m3fgS2wwl3HMyiLvtYkGDSJo1gUqWTVUbdDabO
	XH+mxFOU0NTuaxEUh+wHmpGTPRMhDVyR6S5503vl8UmpbsD45z5yX/YK7DOME1Pz0shNd4b1iQV
	lQYygE0QbYWjE0TG2EVJwx2/GExHlh8BudA/0jNUDXIQEVrT3juqrDJ70P3mIdo0VnGcFv8MlG3
	VraR6dY/9dlDg3UIbbBrAl/xC3BWkF1XeXQWkzrNoQmtRIQYBseWImPBG9gd2yukNm4EPcfdnXr
	jEdkAaZ++CehG1Eycg==
X-Received: by 2002:a05:690c:4513:b0:80e:dc2:873b with SMTP id 00721157ae682-810e924f3f8mr2237567b3.16.1782754206354;
        Mon, 29 Jun 2026 10:30:06 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e9d48f01sm612397b3.25.2026.06.29.10.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:30:04 -0700 (PDT)
Message-ID: <03eb59cfbc8ccc7e1641b63ab2573b39f36a9e81.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Assign requests to homeless osd if calculated
 osd exceeds max_osd
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 10:30:02 -0700
In-Reply-To: <3e59de30e28f37adc0f8db40357134abf2cc8572.camel@dubeyko.com>
References: <2e10a5e1-14cc-4f8f-9ef5-76a7f7c0fa9e@tu-ilmenau.de>
		 <20260629084231.2892980-1-raphael.zimmer@tu-ilmenau.de>
	 <3e59de30e28f37adc0f8db40357134abf2cc8572.camel@dubeyko.com>
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

On Mon, 2026-06-29 at 09:46 -0700, Viacheslav Dubeyko wrote:
> CC: ceph-devel@vger.kernel.org
>=20
> On Mon, 2026-06-29 at 10:42 +0200, Raphael Zimmer wrote:
> > A corrupted osdmap received from a Ceph monitor or OSD may contain
> > placement groups with osd indices greater than max_osd.
> > Subsequently,
> > this may lead to calc_target() returning such an index as target
> > osd
> > for
> > a (linger) request. Because the osd_state, osd_weight, and osd_addr
> > arrays only contain max_osd entries, this leads to out-of-bounds
> > accesses when trying to read values from these arrays.
> >=20
> > This patch fixes the issue by adding a check to calc_target()
> > assigning
> > the request to the homeless osd if the target osd index read from
> > the
> > osdmap exceeds the maximum index of an osd.
> >=20
> > Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target,
> > calc_target()")
> > Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> > ---
> > =C2=A0net/ceph/osd_client.c | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index a4d3cbfd27a3..3ae7c51e2edc 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -1707,6 +1707,12 @@ static enum calc_target_result
> > calc_target(struct ceph_osd_client *osdc,
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > +	if (t->osd >=3D osdc->osdmap->max_osd) {

The t->osd is int, osdc->osdmap->max_osd is u32. In C, the signed
operand is promoted to unsigned in a mixed comparison. If t->osd =3D=3D
CEPH_HOMELESS_OSD =3D=3D -1, the comparison becomes (u32)-1 >=3D max_osd. T=
he
check fires on every homeless request. I think we need to be more
careful in this comparison:

if (t->osd >=3D 0 && (u32)t->osd >=3D osdc->osdmap->max_osd)

> > +		t->osd =3D CEPH_HOMELESS_OSD;
> > +		ct_res =3D CALC_TARGET_NO_ACTION;

I am not completely sure that CALC_TARGET_NO_ACTION is correct setting.
We set req->r_t.osd =3D=3D CEPH_HOMELESS_OSD while req->r_osd still points
to the old OSD. I assume that request will be sent to the wrong OSD and
it will never retried via the homeless path. The calc_target() has
multiple callers. Should we set ct_res to CALC_TARGET_NEED_RESEND?

Thanks,
Slava.

> > +		goto out;
> > +	}
> > +
> > =C2=A0	if (unpaused || legacy_change || force_resend || split)
> > =C2=A0		ct_res =3D CALC_TARGET_NEED_RESEND;
> > =C2=A0	else
