Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3238C2C0
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419446; cv=none; b=Xgi8gkc1Ul5VVBfL1qJZMufAX2rrJAGZHRaLfuQxN/J/05SltVy2UHfGHuyE5bmO/5Z6ZR6PcZ9w5A3uOsrey+2Tx7GFB6jrSUSrJ/uVBwF1vyII5F6DZ2NhjaXNX4fw6yOFuQRzi4Y6GgAAvsiewtUQoOUKlFUrPdPrG5D+2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419446; c=relaxed/simple;
	bh=QtiYBOnywaGXGIK3J8qE+d5Q2yR9zG0izvjfEZE/b68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDg46yjaaE9fFkBeucyu98OeyQtEhoH02r7lOO8udW7kABnzY6Ice+AuBdRdoz19KxW1tc9lNZF/+Pdg2gp7NUQbUEPU2Io08XTe4CjRKBumoGvFfO2MaN4Vmh//S/r0BxjJni4fMuTYLaf9Y47aV1L79T99b8nzYkZHPZG0Ogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=aBswvo+N; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="aBswvo+N"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43bf6230cffso5682658fac.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jun 2026 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780419443; x=1781024243; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t4fV8gn7VC/KWcxzJDuPOHnzy2hHUCpvH3Iq4Xii4vw=;
        b=aBswvo+NE+OxN37GRYpze/bTj6w/J8+YtQJbjwNiIwm7+nbt2v3f8oljy/TPY+f8In
         r5l9EUl9CrJk0FTsFn61wk8m7Hc9oP7xJnSC8BEL0hgEtuc+5OSsyf2tgXnCNFX2p9+t
         t2TUWzwgmJ+YIRM5v2kQ0V8GIXeR54eoIcjfJLgfGWRSIdrZGl2hm3A2/T5q3K6IxXVJ
         VPTpkcUxMTWWUZlS39B4cc8qBMys2lI19LLJY/RR8Fr7im5FSYy8sqi+ZIqJM9EOz+BR
         vbz7Zg8PHuUIIrhLuZ2KfcCSEMHUViuQzA3Th8KXPfR9Wtv+OKNRGqPr4KSbP4iHR6YK
         gABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419443; x=1781024243;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4fV8gn7VC/KWcxzJDuPOHnzy2hHUCpvH3Iq4Xii4vw=;
        b=a6AHArIJ2aWi7PU9+7fFWBqfPjRSZSBFm+o+l0M/AsQJk/LLgxorqGlusWLRhTvbC6
         KN0mdLoSKpJKZT7Cn/gNodKzkoZqKcBYkigWN8vNwA4bTnaSixrQQsgr7LANqLvOZ/ig
         Jrc/CieR8FruWUMRg6UWSZg6l4Bsptpi5xS9KB3zBKUcUGjnMD7WewozCS9qahqnNRaj
         FOasr8mV8A3Mxq2vBuFaEkgdjcG0t3VfcBRvnmE+uIDjhzLPN8Fjwz1Yp2u7xOCctz8X
         Y7CfIAM4QAfKshGzB+h3Lzj1kvHzqInVZv9sRM7shluOKdMGcl3UocoNhLfzHnO9nf8X
         N+3w==
X-Forwarded-Encrypted: i=1; AFNElJ85j1J6g4FosD0pxgwLgX9cJkbPmnu80+HxONpe5eKqlYUWMmRZ3Xql6BIR7/W1TLSqiUztF/iX4yjn@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzJCXPZhle0s+9z9V5ae3+crtciCkMfNksyifb0vHjmxPCB1E
	UhsZO7EJz8RtkCOvsSrECbVR1L9wIya/pDuEY7/Hok+aFFlPwVHdBGq/N0Q/k6XGlP8=
X-Gm-Gg: Acq92OGaKjl/aZtNY9T/i1mT6P7YMUAgr/RgnMKjVoL0D0ydnfDGXbdIiwrRhhNaPMW
	TyXogsuS9qntalAa4z8QkEVSjOqzPILW+uC5rUQHQwRhLmf7ABeEGhl9Zune5nAO2hPjcJrxvwy
	OInakbHs0AHuIohDeUYbOPaVeevbuC8ZdU/S3LDS/noKVhTECkc6oIX5Dnewkb2snT6hyoBSrlf
	O+j5soyeccK3yRaGRNL4d4GEueBsvIVrnSUv0LV4c5+N88BvFPrQOn+JUWlD0+eJr9c3o/e2NoE
	VpjwXxpaavgobkMw2Vt49/vZb+99Brr0PHibDcLSlJg8mgvI50OYGDGcxWM8kgOeKm4fwt1PLZA
	zCYQNwO8cmB1HPOLTwYi8t9u4IQR+XL8jhU7Q8H/Twr9vo16JHYxlRcpZIJ3bnSJZLGQsyEXmKn
	0P2Y+CGCgUxBPrf5vRil95sllO5g+HH1+QrAu/L5vcIV+EWGMcO2Me8B24QfmsxRuyH0T9hEJVQ
	lOkgKX2knNJDMl9a9+YpsmeR2TQjIyXs/VntCpKWPZf0oD2kO7YOoE+BRXEFFXSxM+wZTGzi0zT
	nWuf2g==
X-Received: by 2002:a05:6820:4d06:b0:69d:5138:5540 with SMTP id 006d021491bc7-69e368628ecmr2353683eaf.9.1780419442613;
        Tue, 02 Jun 2026 09:57:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm132744fac.8.2026.06.02.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:57:21 -0700 (PDT)
Message-ID: <50a7cd9d731e96f9fcbd86628c0037be3dbc9c3a.camel@dubeyko.com>
Subject: Re: [PATCH v3 1/1] libceph: reject zero bucket types in crush_decode
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ren Wei
 <n05ec@lzu.edu.cn>,  Viacheslav Dubeyko	 <vdubeyko@redhat.com>,
 ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@newdream.net, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	ldy3087146292@gmail.com
Date: Tue, 02 Jun 2026 09:57:20 -0700
In-Reply-To: <80dbf895-2406-4695-a89a-6d0201c948ac@tu-ilmenau.de>
References: <d21e2f97dfe6f250.1780369814.git.ldy3087146292@gmail.com>
	 <80dbf895-2406-4695-a89a-6d0201c948ac@tu-ilmenau.de>
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

On Tue, 2026-06-02 at 16:37 +0200, Raphael Zimmer wrote:
> On 02.06.26 10:01 AM, Ren Wei wrote:
> > From: Douya Le <ldy3087146292@gmail.com>
> >=20
> > CRUSH bucket type 0 is reserved for devices.=C2=A0 The mapper relies on
> > that invariant and uses type 0 to identify leaf devices.
> >=20
> > If crush_decode() accepts a bucket with type 0, a malformed CRUSH
> > map
> > can make the mapper treat a negative bucket ID as a device and pass
> > it
> > to is_out(), which then indexes the OSD weight array with a
> > negative
> > value.
> >=20
> > Reject zero bucket types while decoding the CRUSH map so the
> > invalid
> > state never reaches the mapper.
> >=20
> > Fixes: f24e9980eb86 ("ceph: OSD client")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Assisted-by: Codex:GPT-5.4
> > Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >=20
> > ---
> > Changes in v3:
> > - use CRUSH_BUCKET_DEVICE instead of CRUSH_ITEM_TYPE_DEVICE
> > - v2 Link:
> > https://lore.kernel.org/all/3200151429f33554f06ced8a.1780197742.git.ldy=
3087146292@gmail.com/
> >=20
> > Changes in v2:
> > - use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
> > - v1 Link:
> > https://lore.kernel.org/all/4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.17=
79949116.git.ldy3087146292@gmail.com/
> >=20
> > ---
> > =C2=A0include/linux/crush/crush.h | 1 +
> > =C2=A0net/ceph/osdmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 ++
> > =C2=A02 files changed, 3 insertions(+)
> >=20
> > diff --git a/include/linux/crush/crush.h
> > b/include/linux/crush/crush.h
> > index
> > 30dba392b7302de3e14861f8b769242cd8cbac9e..ea0b1de2902585ba9a63566cf
> > bb2b0569846a00b 100644
> > --- a/include/linux/crush/crush.h
> > +++ b/include/linux/crush/crush.h
> > @@ -111,6 +111,7 @@ struct crush_rule {
> > =C2=A0 *=C2=A0 straw2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 O(n)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optimal=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 optimal
> > =C2=A0 */
> > =C2=A0enum {
> > +	CRUSH_BUCKET_DEVICE =3D 0,
> > =C2=A0	CRUSH_BUCKET_UNIFORM =3D 1,
> > =C2=A0	CRUSH_BUCKET_LIST =3D 2,
> > =C2=A0	CRUSH_BUCKET_TREE =3D 3,
>=20
> Hi,
>=20
> this enum contains all existing bucket algorithms. Type and algorithm
> are different things and should not be mixed up. Therefore, this is
> the
> wrong place for this definition. If necessary, I would instead
> suggest
> defining it as a single new named constant. The previous name from v2
> of
> the patch would also be more appropriate for this as CRUSH_BUCKET_*
> currently refers exclusively to bucket algorithms.
>=20
> Also, when creating this constant, it would be good to use it
> consistently rather than only for one occurrence of type 0. However,
> I
> wouldn't say that this has to be done in this specific bugfix patch.
>=20
>=20

Yeah, you are right here. I didn't double check the constant
declarations. My bad. :)

Thanks,
Slava.
