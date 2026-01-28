Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492642D0615
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634465; cv=none; b=RnLnQHSmrKn+nvx7Quv29jtpERmcUggLApNVAB56kIJ+8BmlnUtpCfarNSO10PFNDa4vuN8tAlIqpmqz/3tISkGSP+zmjOp/AScsdKhVWFcip2ROthVSNqefgo/bthiuLlEXY0WJ1xvbtMjK6GyqJjnMspSVbyjZNI+glHXLpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634465; c=relaxed/simple;
	bh=Ut1/itAwhlO9UBoESOm9Vf4uBx8IvUweGHYSC0vuSdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEDr+t7ufl8uTXnlXxoSVpLhpFOsEaDX36S3EFOWnCuS42QV4URPEpUAHxy/9e89mifjRtz67dXu1/2Kz4+ngOlh/cndbQ8r9WOk13qQgZwcFDILFsfZof5TKXu7W91vge60/7enpFROs4IHKEoA5cY0fj6FJRqQQHITgTQNVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcT0/6L4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g18ddmGA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcT0/6L4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g18ddmGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769634463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze/vQjanf4mM8k1KsBxop77QFvRDTemXHbM9CU2xNzA=;
	b=WcT0/6L4t9Tsxagh5kRCS+zguc10lEyugIHQxVf8JR3u2RGSKH4l8bdmTdSqhmB87bUUjH
	oL0E2KNtX+c8mcFAmfeJD7+go+FMQFvVg4iqbE0k1T9mYMzPVpBjM0xm5cOo+Zkyxc9O+o
	4ixrpUC4BQr3y7bimhZLfW3SrfZ6KDk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-W-ydz0tXPiuG2sU7aZptyg-1; Wed, 28 Jan 2026 16:07:42 -0500
X-MC-Unique: W-ydz0tXPiuG2sU7aZptyg-1
X-Mimecast-MFC-AGG-ID: W-ydz0tXPiuG2sU7aZptyg_1769634461
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-793b9a4787cso4162907b3.2
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 13:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769634461; x=1770239261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ze/vQjanf4mM8k1KsBxop77QFvRDTemXHbM9CU2xNzA=;
        b=g18ddmGA55cZQo+Z1jag+2AkJf1hhwtncTIl3sQWH/2cGrMPbPQUpgApVnNTlJAINC
         o6y4gIhlj86JPTzzosGJCf/bULbYArNwvxhPnOD4iya54QnRODYxbs/MMCMEOM0mtvyT
         89RxsmBn8/zjz61HpkIMZZaBfn+QGoK6cLmcfzyAECYxzF5uR0zbUDoKYG4M9bt/uDp5
         S9yDDViP0PwswHnoPJGmTOlWbso0SJnkGYrXR0Iwd0p2mD36S1nHoJA4oYFyH+DcITmB
         cexIYzSw+Fp+2GrlDWTc3B3gUyrSHwxiXX0M+JsrfbVUPLDC0Xg3OxtsA3eJRCJ9nTYf
         tpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634461; x=1770239261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze/vQjanf4mM8k1KsBxop77QFvRDTemXHbM9CU2xNzA=;
        b=l8rkGFthjY1fVlPP9hP1OZFGVJPbEun68nbP1CtsJfw31VQfzOZdhyaj15W7ejCuJ4
         NMwCHj7+iStblik7ctzATKx92VDsee/wES6e4JTVNB/MvOSUv5O4zouwkANKTfdyUVvR
         rxa8sDbn8ItAbF/i/Fc+83r1vvZJlxn1N/kDT6FBX611ResTS+J/HsLLit2V6/jd0LB1
         GATYjMSTd1Kvs0XQwEmfL5YJrCXStu6OvfCBepjbtWVe5opXg66KJD1Jcb0Rg0N4NTmX
         LRcgA8T2iLNrOMT+ln5QQrUBCecmLf49aCl59l/0C4aBwv8FhhyoqRfzXs5d3I8DgkbZ
         XdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxhc/IpNTi8kyDn/4LzoLokhSd/Pt8+hFeu9Q2O73zMgkN4IOJUTiOP0qX5CAeKM+5+sNGIm96MQnq@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtrUXcXoW1dmhiw4uxzj6rjrgAnThVlkwmWL1VUYly3nA51bz
	fsI037CO6wMd5tCX8M2MtQ3qNNGKXTzAzQ8CdMuBQbVWDpEzkR+5WRvn041jO2dm0ZOcpL+O9O5
	eDKnicy8HeeN3FTzrTAv82iX4AKv98itzRUeQMYxNR1SHj5+CpzttKpNR+BlLc+I=
X-Gm-Gg: AZuq6aIXcskIQnetYMzpzOI3gkCWpW2r29RNnBMYwdFefTjxqgJnLEtZ2NiywHnIteY
	43yzU8CZOOI67bIbR+lpZRAxChGgokAau/VWQzZxSRrNw0kyF0vubJpZHDFhHxazPo7Je4H8czJ
	Jnn9dd2/loQpxl0UqiKjm7QKSXy4qs8rSagBPlIAE9BzFSwxjV4eoIA474wl9ds+aAJ5RqG37D2
	LHSJpxKDyHVruCNUvP6ym2Rltsh/y7dxk/7PyYfciwKcS9/RXw34tXaVefgFJPLoNiL27NRQb8o
	LzyG4sc+A3ENIKEVy2wdoD6jnFZgUa7nXhJamOrF7d7zOTRjQ1GjaZTzHaUJSvVzHXK6Z0iYefI
	hIXNVSTdHGKjLC3m/g7h517odOrsDOal3POOoDo2Q
X-Received: by 2002:a05:690c:6610:b0:78f:8666:4ba7 with SMTP id 00721157ae682-7947ac46612mr56610157b3.49.1769634461387;
        Wed, 28 Jan 2026 13:07:41 -0800 (PST)
X-Received: by 2002:a05:690c:6610:b0:78f:8666:4ba7 with SMTP id 00721157ae682-7947ac46612mr56609857b3.49.1769634461031;
        Wed, 28 Jan 2026 13:07:41 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828ad9bbsm15927387b3.32.2026.01.28.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:07:40 -0800 (PST)
Message-ID: <8d39e5919e569b2931f12edc720d230af4fa3ab7.camel@redhat.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, 	ceph-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, 	khiremat@redhat.com,
 Pavan.Rallabhandi@ibm.com
Date: Wed, 28 Jan 2026 13:07:38 -0800
In-Reply-To: <CA+2bHPbRD9gZyH4w18-VshWCGn5MBe1gi0-0fmAnaDMUYjXA5w@mail.gmail.com>
References: <20260114195524.1025067-2-slava@dubeyko.com>
	 <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
	 <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
	 <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com>
	 <408b497e5c20549882dbe34b40adcd13b0a5df11.camel@redhat.com>
	 <CA+2bHPbRD9gZyH4w18-VshWCGn5MBe1gi0-0fmAnaDMUYjXA5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-28 at 16:02 -0500, Patrick Donnelly wrote:
> On Wed, Jan 28, 2026 at 3:20=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redh=
at.com> wrote:
> >=20
> > On Wed, 2026-01-28 at 12:16 -0500, Patrick Donnelly wrote:
> > > On Mon, Jan 26, 2026 at 8:02=E2=80=AFAM Ilya Dryomov <idryomov@gmail.=
com> wrote:
> > > > Hi Patrick,
> > > >=20
> > > > Has your
> > > >=20
> > > >     > > I think we agreed that the "*" wildcard should have _no_ sp=
ecial
> > > >     > > meaning as a glob for fsopt->mds_namespace?
> > > >     >
> > > >     > Frankly speaking, I don't quite follow to your point. What do
> > > > you mean here? :)
> > > >=20
> > > >     --mds_namespace=3D* is invalid.
> > > >=20
> > > >     vs.
> > > >=20
> > > >     And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.
> > > >=20
> > > > stance [1] changed?  I want to double check because I see your
> > > > Reviewed-by, but this patch _does_ apply the special meaning to "*"=
 for
> > > > fsopt->mds_namespace by virtue of having namespace_equals() just
> > > > forward to ceph_namespace_match() which is used for the MDS auth ca=
p.
> > > > As a result, all checks (including the one in ceph_mdsc_handle_fsma=
p()
> > > > which is responsible for filtering filesystems on mount) do the MDS
> > > > auth cap thing and "-o mds_namespace=3D*" would mount the filesyste=
m that
> > > > happens to be first on the list instead of failing with ENOENT.
> > > >=20
> > > > [1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvm=
Wd3j+co6Sq0gZ+421p8KYMEnQ@mail.gmail.com/
> > >=20
> > > Sigh, yes this is still a problem. Slava, `--mds_namespace=3D*` shoul=
d
> > > not be treated as a glob.
> >=20
> > OK. So, what's the modification the patch finally requires?
>=20
> It needs to be restructured so that CEPH_NAMESPACE_WILDCARD is only
> treated specially (i.e. not literally) for MDS auth caps.

And what does it mean in practical sense? :)

Thanks,
Slava.

