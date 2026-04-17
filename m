Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D18346FAE
	for <ceph-devel@vger.kernel.org>; Fri, 17 Apr 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451697; cv=none; b=WW1ZgWP5GbcCBpg2RekNjRoT31iy+UNPB1P9ALfk7LeQlgmESLx2nv5Le6ZcdjhE3arhWkj9HHp7Pvjmafb8+iYYJQ6I9UA/8kyc4IjrG4mgr/KOcuX1luCeoLKoqi8BhjPpdB+GyglGyl6iOdx8PxyDkMP1VC8EwTCAEWlMt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451697; c=relaxed/simple;
	bh=XIAHu3+9MbYsMQ0Ty15looa48Romc1dmtt6+Z922YB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXHUXq45W1DFtO6AMlEU9kyiJdQVCRNGPwZRcoQtTm+RCb9qFCuWT50kba4uaC2NaymA4AXQR6ahdvfQ7yDCItb0ngPrJW20G4+LkbYLSdt4tvdtWe0g+OjU/xpY5LuW9zR8Vy9nTOsdZYQsppEx/vW3bMMBU2prFbJoT0UaKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVHYfJHS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2h6oABS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVHYfJHS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2h6oABS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776451695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CCE+9sRGtOWBoNJsNQxVv6l/K9BhI2/XVLd6IZfIQ4=;
	b=bVHYfJHSLNlFWi9tILA0ZiWKOaAd7Kiw3lF8JA1cZ7629Fk/ozO0O36D6A4nrbtIhbB5uK
	Lln20OXoqT/vOubGEpvdYJyDeTDvOtOGvF/asoUxh5w/aW9laDQ0mcYNl5af2qhBGKS9VD
	wZdFH9PuvcBXKK84oDLTFdL1yvMx0lI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-Zol8XqXRPF2JDXBXdC_MTQ-1; Fri, 17 Apr 2026 14:48:13 -0400
X-MC-Unique: Zol8XqXRPF2JDXBXdC_MTQ-1
X-Mimecast-MFC-AGG-ID: Zol8XqXRPF2JDXBXdC_MTQ_1776451692
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-790afc07667so24767437b3.0
        for <ceph-devel@vger.kernel.org>; Fri, 17 Apr 2026 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776451692; x=1777056492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CCE+9sRGtOWBoNJsNQxVv6l/K9BhI2/XVLd6IZfIQ4=;
        b=D2h6oABSP58p01UySldDBldN9Pehth95pfxNQhoRd1aGLEVVakSHBrDhchhMzOhawO
         w1TPTgSek6ZvkO5kvHeQrusSaggFdU4O0m+ALJhRnlDljSKno+CHjIWmb0d9Cyz04lcR
         7Mm3EL1h3x1TsGehM8RbT2wS0mPvOvBMMbXazMz06fs1dL+Yr1h2S7DeI+471laC3o70
         2IsXk5YpGtjTCyuONFhOC1cmmqDc2Zr2jOWHCXuUj+Hl8G9TT2ibSitghoOJECuL/B4i
         gmyYroBkoIZVUjId3oI0+nQRk2UAqd/537aqqXLBjhNIVd1vDAraaiUyYo3eBzsfFenF
         rZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776451692; x=1777056492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CCE+9sRGtOWBoNJsNQxVv6l/K9BhI2/XVLd6IZfIQ4=;
        b=mm52S0PFKqeYbb7Luz6Nk4L8ijBSfxLt3Ql9E5crQlszgJ3uWZ1M2OfUCrXp5fnNDP
         z9Yvp9rzuXNnnRAu5a8iElCdvEEn/GHHe+xbWiUe8IhPWpuVSnGy8TGWFQFJKe7ps7eP
         KPoBCcgJ6DlIdSNInX/xa9qKcUH4N+yC431+9xXMRZHJIobabwSG0d6ewgNcYRBUtAk5
         fEMWUdVLkzvNCubHcDmMMJvbitVbXCPpwkxdltdCKbgH/Wv2woIic2qRZa0ORtrE0C1r
         OyJIiJPTbqSU8/r6awdAMg7u+9woqjhfmDEO1P3bIbd89sRLF91YoT0Mohyju1+Pg6PD
         GrlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6H5PKVQPXcaHYMQqHfu/Gt4cIqToN3N4wnSkSUYOEm5+PqTRuweK/YhOQqyryTvNhPwSTrXEmvRwk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9x/9NjbS6EcPK36k3Tcvgj8zzuAct9uc/BYZoiHKeWHFkn1jC
	3Qqc29AnDmTKXPqHJQ8zj+jN/SFLyJRP9hj/2h9RePbh1fWOfwQXaB/Nr8lEuAmVAXuIodzggjC
	4SmcgLvkNf7fWN7WnnKo11pU43ClegmcPz7mYuizk3yOULUmtYQIpR7S1CoDcqI4=
X-Gm-Gg: AeBDieuEY6RTg9b2UNU72eZ97A/NnimgpSgdjTXQuCRP4mNrsRyK8wOKd6HS6VecSOG
	NEkNeDweBOJUEDnJOJHdCTBDHwFh8kwqxqdWM8hJh/ywZAn+oPVNcJxelO4IIs/APHm2BPgI56D
	igLjNYZygGHeuGUstGu7qp5VsLksgZA3u0yq2xOt9kr8BYfBTOLyMXyQRga880vKE2QDCz5UKZh
	/3rl0MQYzF3U/M/W/PqnkjwJS317J3jyVI3Oliu95ePZqJ2gMob6xLnKOaTPxS2uSvF8U5Oe6cV
	ImeJyFoYJ39AQpDar88gRICOYQzTenu0WE0fN9rG92sHUL/mpb3uCFsUd/jGpJz8rFWDRWiR6AD
	WKPOuUHVOpFxH1dg+C6Fk6LwB3hBGxjC9DEDA01Ex2hmtrxMh0CrVqUxRyyr6fbk=
X-Received: by 2002:a05:690c:56c3:b0:79e:8299:7505 with SMTP id 00721157ae682-7b9ece6d5a7mr35368727b3.6.1776451692535;
        Fri, 17 Apr 2026 11:48:12 -0700 (PDT)
X-Received: by 2002:a05:690c:56c3:b0:79e:8299:7505 with SMTP id 00721157ae682-7b9ece6d5a7mr35368067b3.6.1776451691555;
        Fri, 17 Apr 2026 11:48:11 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b1f6fsm10013157b3.36.2026.04.17.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:48:11 -0700 (PDT)
Message-ID: <68b2b3eb55e7e44ae574c5caa0ef910cf088ed00.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v2 7/7] ceph: add manual reset selftests and
 validation harness
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Fri, 17 Apr 2026 11:48:09 -0700
In-Reply-To: <20260415170043.3882912-8-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
	 <20260415170043.3882912-8-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 17:00 +0000, Alex Markuze wrote:
> Add single-client selftests and a validation wrapper for manual
> client reset.
>=20
> The test set covers reset stress under concurrent metadata
> activity together with targeted corner cases for overlap,
> dirty-state handling, stale lock behavior, and unmount while reset
> is active.  A validation wrapper runs the individual stages with
> watchdog timeouts and captures the final reset status for post-run
> checks.
>=20
> The stress validator checks failure_count in addition to
> last_errno so that transient mid-run reset failures are caught
> even when a later reset succeeds.
>=20
> Keep the test scope intentionally focused on the shipped
> single-client reset behavior so the series includes a practical
> regression signal for the final design.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/filesystems/ceph/Makefile       |   7 +
>  .../selftests/filesystems/ceph/README.md      |  84 +++
>  .../filesystems/ceph/reset_corner_cases.sh    | 646 ++++++++++++++++
>  .../filesystems/ceph/reset_stress.sh          | 694 ++++++++++++++++++
>  .../filesystems/ceph/run_validation.sh        | 350 +++++++++
>  .../selftests/filesystems/ceph/settings       |   1 +
>  .../filesystems/ceph/validate_consistency.py  | 297 ++++++++
>  9 files changed, 2081 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/ceph/README.md
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner=
_cases.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress=
.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/run_validati=
on.sh
>  create mode 100644 tools/testing/selftests/filesystems/ceph/settings
>  create mode 100755 tools/testing/selftests/filesystems/ceph/validate_con=
sistency.py
>=20

The patch is really huge. I really like that we would like to add the selft=
ests
for CephFS kernel client. But it's impossible to review it. It needs to be =
split
on several patches.

Thanks,
Slava.=20

