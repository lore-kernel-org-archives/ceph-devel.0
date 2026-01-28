Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779C2F2607
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634205; cv=pass; b=cwkRxqS1aqBnB8K2qGb2Hlr2G3sm46+3Xavamzr3qAvaZbmM3G8LyT+vlKCongo1ANifQm9PwkZkZOpOJ5VE4nPh4Uz+GOgYqMswjecbrHyPOWPp46Pl58ab08vcsJPGix/KuwT8icdkBhZymEak7kF3ZUu70IYyRyVZdMv8NfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634205; c=relaxed/simple;
	bh=efaf3C2hShtFbTdeBwhbV1apj9j+3ZDJPwz0ThYGHbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+YEjZGYOHLx5Bym0rW8iYktVnMlzY3RU3pQEOsnoqq3ekD7cYgbkPta7q7DBJLnR3ZMhobvExGSTi6oSvb13E73bneJaqAVGHInhICng0krZ5BbPCz6tv58aldBU7ATwV6f3HGjwhWKJeMo50hISJdvCD4ohdAFEOuYGVitGqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4qxW3un; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDH+xoRS; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4qxW3un";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDH+xoRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769634202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
	b=c4qxW3un+R5kJDal2oe1AJd1NGYwbF7tJX9gKV1yRmMTZHW2YsaXcpYuooEmJnNsGdIb9w
	kbs7bD5SxnueVlah8dFMocXaNr6ZTu45v3dVW5Vf6eGHvfs2i1hD0U9U7J4TPQj8HdKay4
	0JkFpIsW098gRKQjFzpnVy6QChCtITQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-vJ0mmdv1NI26j61_-FNusA-1; Wed, 28 Jan 2026 16:03:20 -0500
X-MC-Unique: vJ0mmdv1NI26j61_-FNusA-1
X-Mimecast-MFC-AGG-ID: vJ0mmdv1NI26j61_-FNusA_1769634199
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a39993e5fso7826816d6.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 13:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769634199; cv=none;
        d=google.com; s=arc-20240605;
        b=QsWoM/vF1f/WzbSErtsnp+++ALMfRd9rkcAA80PKrf6189fgY1S/J/be/izppCi803
         oJc6dz7LrqfufZOiRDiz8yg6UGLYuOmNMLgny/8o482L9RxcQJ4Fnehnwqub2iH/aaUN
         uV/SeEpK9pNNIrWCsnH27VPgsK42z5XojRXDVKrG7XGyJelVIo/L3F9NzgQKfajwaMHS
         kBRwgxAm1CWOY7DLnZ9RdmcUWxxJqJkxwbwXnWxPuxLn73WeQJStoUqNLYwvv9poGNPA
         EaPYe3lY5WSY79Yyn3xdfrq80AyniIQfe0GihfL4V+05/Y0GqOEfQClS+VUfQI8URwNa
         yV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
        fh=r8DUsrRk5TvuHlRrNzVMmmKiPiT38DfmXNzlQRfJk1A=;
        b=AyWoJ5QLhkf5hncMnA1f7peEAQaCTKxm9XJmqHpz8tOznAj7pfXI6fgvQKU9bq0+l4
         GEdWUdTG+2KzCoEjM3O0qE7qtuJJJosMIr9pxrQbZMgOHNJETGjqFBGa8cKI7jh6Pb0H
         QOgV9oMkcPdGU6dtD0I6O6SWfbdL9MsMtA3g4gliNgYEMH4L09U6TNZ23mGS4IO0kBnI
         GNWomqlLo7RSegFWILIpytwT/AdZ/vwQEB/UAS8ell4nmii4AxRXhLtKMlWcQYDRARbh
         SsoSLpV07g1eCtukuug7sHDlNv5Szr9twG/lBgyXgNy6t4HJkiOLFbE2uJC/IjaxWNcW
         2iNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769634199; x=1770238999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
        b=WDH+xoRSXNJabIEUxZNDQgLFxZ8u5vH+Wd1ZP+zVOhkdhhuXb/+xp3B78CkWb4vbRn
         ZHKss+d8whs6thAuqJ8UoX58YTd/vn9NJ0z31Un6wXX9XdYTYAiScdJAtSJA4j6hUh7+
         u4YD3Zl83j34gFW1AbMkFtkuIvUOAAgmZ3Svr4ufhn6zMCFCmwRDZD4idhEAxSY+j3IA
         88WMd5w2PAMuJjFAubUFLM9Cm8ACnN0RNrGkRoINj5SKaCauwd+7vU13IPrm9DSSdXHh
         d2e59vTT6b5ZIfK4IhDSTVTWmpAfglRXTT3GsxaIgy4xNpSjaD1xGGnk7s6R52k2I9px
         AiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634199; x=1770238999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
        b=IDVxwb2dwgluYrT72M7BtZcATuVev3WOPz4JcisuTfXpNcBXtG6pXX1FMzw8P72FPx
         Ku+BNj7mJXk0yw8aBnonEq9XYba4BhtMkRYSaUDZAquhsh82dxv4Ry7JeY2nowkpoHbT
         jG7UK0xZrysYED8dEevayqRgE/50C6bswSmyERAnQHaZ8G/1KWs6BBQTILM3/y80RQ+b
         GUQk+7MjiJCz4t0CleETNSpQS0IcgDJtAJLl9QrgMc8XflsWGb+tm+6WoofvIe9uw/xB
         ME6N6+7NnE8nvt+Bdc2Ww5aCeET96RN6FWVX4hHNpH46uvLMjW5zOKVmmywWnQGoupTL
         kndw==
X-Forwarded-Encrypted: i=1; AJvYcCWK6sZNhuVVfn7Xn6RxRaa3TKFlecA/ArOufJouZWnEOo5TPf7aMSgnQ+kn6PlgiQKF/ZOktVCAG6Zn@vger.kernel.org
X-Gm-Message-State: AOJu0YxHg/yWq9cyYXHX8OPKx2ZTuKSilohC4WT8PXqoz2iDrJXg5omN
	PZpNivRHovsrgEVAulHyLx/KOkmuZS3e9vEwEslZ8SLM9FR9R49drUfey2vwALiiBRrCWFCrtZG
	VOg7FSQQ51kfVANgp6p/KRxAQnD7pYJydFp8OyS0/ul5RgQCWM+bD+h3FFpxYlDd/dAdX9ByA7j
	2hVjhi9DGr7PLjyyqCsAsPstYngqCjFxFqHokriw==
X-Gm-Gg: AZuq6aK8NYnVBEWE22C83ZiKpuYxtj/PdcqovTK9BY7zGOXO1RudFH8ZAtiPMyi9ktS
	xClAV75CDTXNkPbEtRS++A/Ztz4vJeZNv+BhWfbcSKrKCPJ7SOMkO4LVN5e16vDNs6pw7cZz34E
	2NU3mRKmlnftT2dcWVREfNTP2wjNjk3jjtphOyqC2XjgHMfEUec8vrif3Luu5yRnptQDpUwqNIZ
	1w8F0ymU9zVaDLkZwSAAb6vPg==
X-Received: by 2002:ac8:5fd3:0:b0:501:4e7f:fcfb with SMTP id d75a77b69052e-5032f8d9a43mr77513441cf.42.1769634199414;
        Wed, 28 Jan 2026 13:03:19 -0800 (PST)
X-Received: by 2002:ac8:5fd3:0:b0:501:4e7f:fcfb with SMTP id
 d75a77b69052e-5032f8d9a43mr77512961cf.42.1769634199035; Wed, 28 Jan 2026
 13:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
 <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
 <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com> <408b497e5c20549882dbe34b40adcd13b0a5df11.camel@redhat.com>
In-Reply-To: <408b497e5c20549882dbe34b40adcd13b0a5df11.camel@redhat.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 16:02:52 -0500
X-Gm-Features: AZwV_Qg3221sHh9KIWXdQ6dd65dyypKxSFKvDdY8AJ_tANL9DjzAX4V1UFOvC9g
Message-ID: <CA+2bHPbRD9gZyH4w18-VshWCGn5MBe1gi0-0fmAnaDMUYjXA5w@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 3:20=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Wed, 2026-01-28 at 12:16 -0500, Patrick Donnelly wrote:
> > On Mon, Jan 26, 2026 at 8:02=E2=80=AFAM Ilya Dryomov <idryomov@gmail.co=
m> wrote:
> > > Hi Patrick,
> > >
> > > Has your
> > >
> > >     > > I think we agreed that the "*" wildcard should have _no_ spec=
ial
> > >     > > meaning as a glob for fsopt->mds_namespace?
> > >     >
> > >     > Frankly speaking, I don't quite follow to your point. What do
> > > you mean here? :)
> > >
> > >     --mds_namespace=3D* is invalid.
> > >
> > >     vs.
> > >
> > >     And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.
> > >
> > > stance [1] changed?  I want to double check because I see your
> > > Reviewed-by, but this patch _does_ apply the special meaning to "*" f=
or
> > > fsopt->mds_namespace by virtue of having namespace_equals() just
> > > forward to ceph_namespace_match() which is used for the MDS auth cap.
> > > As a result, all checks (including the one in ceph_mdsc_handle_fsmap(=
)
> > > which is responsible for filtering filesystems on mount) do the MDS
> > > auth cap thing and "-o mds_namespace=3D*" would mount the filesystem =
that
> > > happens to be first on the list instead of failing with ENOENT.
> > >
> > > [1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvmWd=
3j+co6Sq0gZ+421p8KYMEnQ@mail.gmail.com/
> >
> > Sigh, yes this is still a problem. Slava, `--mds_namespace=3D*` should
> > not be treated as a glob.
>
> OK. So, what's the modification the patch finally requires?

It needs to be restructured so that CEPH_NAMESPACE_WILDCARD is only
treated specially (i.e. not literally) for MDS auth caps.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

