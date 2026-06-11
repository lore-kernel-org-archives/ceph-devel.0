Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039933B6D6
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150002; cv=none; b=cEJlD/6AWb69K1LJPum4C9yrrlggUnxNlAiv4Vk+k1+5Frg9G+dgqQfL46Pk9twMmWPrBOWBgLugTffKfns7W25jLu1CkVY/0VoH5LmE7BqaHk7uBQYZXJxUKERR0MEMzZE3rdME9mv+rUUyzalp3VwHQJN2lht2PNwhDkjrJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150002; c=relaxed/simple;
	bh=1cxrHD9W9r3yzWHMFyoEXkIaC57zZvqlyAqy7ySJskk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ew891iIsLGnjFSs7YlYaBMYEnBSgtOBxISTP+B3Bqghb4zG60a9xFhy6FgMPi0KkwjHcOgIZS3phEiDctYDlveDM5xr/7DIpuUbLz03LidhtLF0Np9FgUMicdgecBzG3D4u7sVfFEGQ/tXhPtrLcALWo5dCXqG6zCmxd1v3A/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=P6rADXNi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="P6rADXNi"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa612bf6efso7533900e87.3
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781149999; x=1781754799; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1cxrHD9W9r3yzWHMFyoEXkIaC57zZvqlyAqy7ySJskk=;
        b=P6rADXNiHELOJ8BRuEY+3+49LLLPiDZDMdw0DK3dOQfp9ylFPv+1EI+/v5c+9yY0iv
         kzr8fZYEFo0+yvEUzbm/pRtYX2AOot4DE9Oo2czeu8gZ8bXenGUNIBXejDB1Kz5j3Pdn
         BpfRRSlXL9TH+nD2B9Jem8vjaJ0ZYFfSuRNWsleGrjr5Wy9/MB+4u+QtmL582qvFFTLw
         mNBzRVTieEG0NatJCRhLAGYi/WiEaXBi5hGDR5rMj0b72Rvik35APhLqdLalSqF7Clvt
         rXUt/wP7ZJOTez3hC1UXM7kLWqHhltMlQKh79I3VCXRJz1ithpExj0CYLSWbUSTubEFQ
         MHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149999; x=1781754799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cxrHD9W9r3yzWHMFyoEXkIaC57zZvqlyAqy7ySJskk=;
        b=CwBeZDfTbHeOtxr+ok1gKbH2S2UXp7lVGRbzZ0TYP1FX5pZOuUmWOn8ZoWB8bg9RNO
         rTzjy6cmeIaoRcG5IGs0t4uct4O5zN6Q2NfIWgvlqwglU/+AR1qRiBgs6XtB5cLLqHHn
         8UgPJrDcVT7T9rVqOxfWfUCUQTSrRY7iaWM7fxh4rJyzkFdUY8QE+YtxKaCNdUzoHpxP
         GQNeAdyxiH4QF2IDOHkYBHOTGS356td9nekZzpgi3zR8bATPViPbYxs8C6plxi2OnDQP
         hpAfeN9Cq0dg9klQP8OGeUPe26bvbQQ++a0NP7FIFRsXSs5saPXVJYx5/mu9g1duGhLQ
         nPlA==
X-Gm-Message-State: AOJu0YzS/sRHQ0KfP3mCrG8f8hEWE3DTUOsIiDNIXDDTlNr92iSjl7X4
	AEEoyP8GlExA0/fOfL6+f1sIKVCtrmYGd3kMoJ3aV60Rkpj8/EN5R1GX/KMhFqszMeM=
X-Gm-Gg: Acq92OFtDo5qFqYAIxCwQ6P+FWCKjQ2MS5A1ULCHxXpnSEohhCfLe1mBDwb/N7Vju3I
	9WLBWs8LtvdZgIgx8Vx6rK1Gm/K+YWGVFr9qTDyXLfzGaf9u6glpaYCsRC2Ekua674PeiVxr9p+
	Ax8y1oQzZpsn07zi0alZFxVJMeW8SbWvsxva83OqcWCBh6F+buVk08qutOPS/x4uJSuxHSZ+sZp
	4HQ7mOm4at6PeJzFACPDnUE8KY0WazmraeZsb1GVbP7m6nJHiyhY1P0WEkpDIiGzk8aUcSet9qm
	kFNsDH9qit47BZV6394vR/OvvDQyC4d6Q5YJMuSoxYuo7QfXXgekjJCfaKjJfyxdEsHYCKh1/xm
	tZcKS7M6Sz5ayLf5EJMPndr7xPlYryYuqNuHmdGxKjCqGCYiqJvvY1F6y8iXd5B1dHpUhtkrPUt
	3nEx57CBiNiQp2KCXuclZANPwTm+kVATT6ZDqvBLCRWgTnnuXBd0nwEHaX6tdOkg8FzMLz+JE/q
	mqbb6mFJ5VdEPrz2nJmVPJDYYF3cMyUjNwt9G13ocBcn27y8azXEb8KZANPOASSR2Fooe4Qsqyj
	Aw==
X-Received: by 2002:a05:6512:1243:b0:5aa:7653:49b3 with SMTP id 2adb3069b0e04-5ad27fb3734mr307807e87.32.1781149999229;
        Wed, 10 Jun 2026 20:53:19 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b98f0e1sm5943049e87.61.2026.06.10.20.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:18 -0700 (PDT)
Message-ID: <74dcfda9008fa571eed181d83238000759bf049f.camel@dubeyko.com>
Subject: Re: [bug report] libceph: BUG() assertion in ceph_can_shift_osds()
 triggerable
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Wed, 10 Jun 2026 20:53:16 -0700
In-Reply-To: <07595980-b8aa-432b-bf1e-e21cb036bfb8@tu-ilmenau.de>
References: <07595980-b8aa-432b-bf1e-e21cb036bfb8@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CC: ceph-devel@vger.kernel.org

On Mon, 2026-06-08 at 17:12 +0200, Raphael Zimmer wrote:
> Hi,
>=20
> I encountered a triggerable BUG() assertion in the libceph module in
> ceph_can_shift_osds() (net/ceph/osdmap.h).
>=20
> osdmaps are received over the network from a Ceph monitor or OSD with
> messages of type CEPH_MSG_OSD_MAP. Such an incoming osdmap typically
> contains information about existing pools. If pools exist,
> information
> about each is decoded in decode_pool(). A pool is either replicated
> or
> erasure coded, which is encoded in the type field as an 8-bit value
> representing these pool types. Currently, any value in this field is
> treated as valid even though only two values have an actual meaning.
> If
> this field contains to a value other than CEPH_POOL_TYPE_REP or
> CEPH_POOL_TYPE_EC, a BUG() assertion can be triggered subsequently.
> This
> happens the next time calc_target() is called for a request in this
> pool. From calc_target(), ceph_pg_to_up_acting_osds() and eventually
> ceph_can_shift_osds() is called. The switch statement on pool->type
> triggers a BUG() assertion if pool->type matches neither
> CEPH_POOL_TYPE_REP nor CEPH_POOL_TYPE_EC.
>=20
> This behavior can be prevented by directly checking the pool type
> against the supported types when receiving an osdmap and rejecting
> maps
> that contain invalid values.
> I will send a proposed patch in reply to this email.
>=20
> Best regards,
> Raphael
