Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AC313283
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150857; cv=none; b=F2KWJJa+a5IoxHdWXZRRmcuno/6DumoYSSLfTbNnINCx7/1yDG91wMjFiyikdowtO86WHX6OiIe68CrQGIWTgdyaS3bSR+/SKn53C8g/5z7+1+7e91uXliGK2zJRV1icCqGCOGILcBaDkzbvYpspN8EAulbMrsvhceV9EPGt/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150857; c=relaxed/simple;
	bh=O7Zs2t/rymx0PC/mUOBcqCw8LZd+9yySCb20tLRjC9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HurGLo4kxHeBtfLv9CW5Rv4npfKgGkZk2tmVUBXFdsgIw3DPEGoj0bB4aZmr78f4jW9B+1XHocej032IDHl7aM998RUV0t7sMeWp+dfEqCJIoyaK8sh36o0TnNgBvegCFJ3wF/q9eCNXJgmeguolSAskU9RqUfEFITZANNMT9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=SUxui3xZ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="SUxui3xZ"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39677234558so76071001fa.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781150853; x=1781755653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wTW2U8qA4d7bApWNoE2TUnXLsvYOXk2BYgziQGy35yg=;
        b=SUxui3xZqyhMx0JEuhCdAdZ7uptEK+ofF0Qpfb2yrsYUOjO7k0HoD56Ar5bOvbQnfD
         c6Eckh3Jw2eSgPSeUC/c8t9ZS+1tVsB89PBso/SzDV4yL/SKO7q6JAN/kNAbzgKBY3Cx
         GtloGVUlYXvw5hvMPqGQydu89s+V4RsN0H4BM7QetnxbPSLgAut7thr7+2bMQkrfgehu
         ZDjxSGvgqHSGaGV1+K/Gr3KT7T8V1Z0l3nnNklPi75P2qdX3nZlGJnEc0+jm3th3El8L
         tsch5kH5l4FHpOHL+jUGoVANsUC5ia56Pq0mS1LOhTwdQJ6wvUCC7nEsO+5BTLF9tDKt
         brpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150853; x=1781755653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTW2U8qA4d7bApWNoE2TUnXLsvYOXk2BYgziQGy35yg=;
        b=jmxtbeV4Gwpu/1ebZTxanZU5A/ZfhkSGh60V9d4TJsxu/y5IubbQPNrH3p2NaQh8PF
         3FWFuSIV3mrIwy/TliB+SlvG1LhfVxRAgahAkzQe5Y3jFgY7nwi3Y8YrdOjd2NT9CLcW
         uLPEt8sHMBITZOigOJtG95ZPp+GQWgrmc8ArAqU7QIDVVnD2MZeMGVbQFqUsuB6dLslH
         G/U9AKBgoaOAOoUMNPRaGEFhMb+CaBHSOAg2GWnoUyttRuG/7SuDA31g36KdEINSFAgy
         VNMoDKr2YvC4yy0+HC2rRmEI9jKnMXt3l20NhRwpRWvJQj6Bjkf3W1i2/01zw8WNJH52
         GPdg==
X-Gm-Message-State: AOJu0Yz4anL3JxUO9yxxgORRHm04JgEz5rvmpKkqF7NJQNL8oHJ7bchZ
	ORG9TgIunh12zlqjiaRDZymLD6ztLlBo9XbdRgnu9DiG9y87/6uv7dU2Pgw1rDhbSyA=
X-Gm-Gg: Acq92OH3Z5mMUUZWMueVaevA5JA4eHuytaEvT+UFomklTtXwAtlpB1ZcnWEx60lw5XZ
	m7TYNgpR9o10Tcx9YjXqU8DOBR0c5HYoHlP0M+Rw9GsYUOiF6R4IPQTF6tsB5ogVdNmZfzguDgj
	psI3N2IA2d4ahI4hGj9NxFdI7cS5Jn2P0/+VQiSVxcxgwW0aA/fAkgJYB4VjIcwlZUZffMxHyQN
	Tc+6aZ8r+3irHxFIX5vGfctPghIDWA+2NndiezX8s0jAbkDVSECuRFOjNBuPnzqSw7+YzvZRAfE
	C3gyhJANdKjfNU4IHh/gkEkbizPBd5gwwFwvToVgdeDnAXQl+iCT3MaxPDuk14beeKC5aLZSK01
	YO2Y9dMICcM0iokhXKe6+fgvmjtP81BMLgG4rMSx53IlX7Ckgh4HiHZvXV/1+RpP6SM8W5sK38d
	1pKUkB2ENo30EvkrQqjaZEpfHhQwTDv57CWTmkh1SwYrhAjpn1uzNwi1ezti+EzEv14pjWJosIw
	pfgV/5OEB4RICu/f5vFTlhcR0+fZqG/DxPkfeSKV+uP9s7cNSTW/nzZp2wbcXcqTyuXGLH5L5m2
	hg==
X-Received: by 2002:a05:6512:3416:b0:5aa:6649:77d1 with SMTP id 2adb3069b0e04-5ad27ab1bd6mr256809e87.13.1781150853455;
        Wed, 10 Jun 2026 21:07:33 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97a74asm5935942e87.53.2026.06.10.21.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:07:33 -0700 (PDT)
Message-ID: <de36d3583c1802a75af59da673dac65db4c878a6.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Reject osdmaps advertising pools of
 unsupported types
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Wed, 10 Jun 2026 21:07:32 -0700
In-Reply-To: <a4b07ea74167dfb681c481bc21243b5e7e652472.camel@dubeyko.com>
References: <07595980-b8aa-432b-bf1e-e21cb036bfb8@tu-ilmenau.de>
		 <20260608151310.1061874-1-raphael.zimmer@tu-ilmenau.de>
	 <a4b07ea74167dfb681c481bc21243b5e7e652472.camel@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-10 at 20:53 -0700, Viacheslav Dubeyko wrote:
> CC: ceph-devel@vger.kernel.org
>=20
> On Mon, 2026-06-08 at 17:13 +0200, Raphael Zimmer wrote:
> > osdmaps are received over the network and typically contain
> > information
> > about existing pools. Information about each pool is decoded in
> > decode_pool(). A pool is either replicated or erasure coded, which
> > is
> > encoded in the type field as an 8-bit value. Currently, any value
> > in
> > this field is treated as valid even though only two values have an
> > actual meaning. If this field contains a value other than
> > CEPH_POOL_TYPE_REP or CEPH_POOL_TYPE_EC, a BUG() assertion in
> > ceph_can_shift_osds() can be triggered subsequently. This happens
> > the
> > next time calc_target() is called for a request in this pool.
> >=20
> > This patch fixes the issue by adding a check that verifies the pool
> > type
> > directly during decoding and rejecting osdmaps that contain invalid
> > values.
> >=20
> > Fixes: 4f6a7e5ee139 ("ceph: update support for PGID64, PGPOOL3,
> > OSDENC protocol features")
> > Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> > ---
> > =C2=A0include/linux/ceph/rados.h | 5 +++++
> > =C2=A0net/ceph/osdmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4 ++++
> > =C2=A02 files changed, 9 insertions(+)
> >=20
> > diff --git a/include/linux/ceph/rados.h
> > b/include/linux/ceph/rados.h
> > index 73c3efbec36c..5b5c33845301 100644
> > --- a/include/linux/ceph/rados.h
> > +++ b/include/linux/ceph/rados.h
> > @@ -86,6 +86,11 @@ struct ceph_pg_v1 {
> > =C2=A0#define CEPH_POOL_TYPE_RAID4=C2=A0=C2=A0 2 /* never implemented *=
/
> > =C2=A0#define CEPH_POOL_TYPE_EC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
> > =C2=A0
> > +static inline bool ceph_pool_type_is_supported(__u8 type)
> > +{
> > +	return type =3D=3D CEPH_POOL_TYPE_REP || type =3D=3D
> > CEPH_POOL_TYPE_EC;
> > +}
> > +
> > =C2=A0/*
> > =C2=A0 * stable_mod func is used to control number of placement groups.
> > =C2=A0 * similar to straight-up modulo, but produces a stable mapping a=
s
> > b
> > diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> > index f8d5621bc767..e440f6019d58 100644
> > --- a/net/ceph/osdmap.c
> > +++ b/net/ceph/osdmap.c
> > @@ -818,6 +818,10 @@ static int decode_pool(void **p, void *end,
> > struct ceph_pg_pool_info *pi)
> > =C2=A0
> > =C2=A0	ceph_decode_need(p, end, 4 + 4 + 4, bad);
> > =C2=A0	pi->type =3D ceph_decode_8(p);
> > +	if (!ceph_pool_type_is_supported(pi->type)) {
> > +		pr_warn_ratelimited("got unsupported pool type
> > %u",
> > pi->type);
> > +		return -EINVAL;
> > +	}
> > =C2=A0	pi->size =3D ceph_decode_8(p);
> > =C2=A0	pi->crush_ruleset =3D ceph_decode_8(p);
> > =C2=A0	pi->object_hash =3D ceph_decode_8(p);

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
