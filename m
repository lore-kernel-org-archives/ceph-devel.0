Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135D47D952
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992456; cv=none; b=US3C++ra7TNqwYg/SPKqgYqXjXPs+jgzgveo7gWzRUHzG25hEoDZIdn9BZjAeHOAfM1d0BNitcrCRA/qQuJWBTs9fkhG//X/sBSz3uKjLudxBXqsXlcaYAUHjSNajAfAl7Ib3ZziihJRdcDZwDRQXkR/bEgLSljXUTUEIbxn/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992456; c=relaxed/simple;
	bh=923ZLYzHo8M4B5X6fglCDt/cJDhF8YsCoRSwemvzH6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CRkTr+NvSjUp0zfnL6QmiNm4SRvd1RKGM7fJhngFqfq+Xt0u+Py0HJ3sEM8UhZDsJDEdO5Bynbqw9pZuMmpogkgZdikSLnID9tXSkPRPy0KHfMkKJQRmzKr2QCIyqv4JRSAe4ngZFT2fVRWAyMxOez8lbHyv9F4dMiht6Pg+9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRPoD9sk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgHVtiT8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRPoD9sk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgHVtiT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiqPwqDr/dUBGMEbPhNSmN+YJdXAuUXBk9FgQ7jSdXQ=;
	b=QRPoD9skuIuOoJP6MaGVnrfFXthgo1AG9UY84LcyXjCaI98FWwX/IDZ2v42qv6s2QkI9mt
	BNFdcRn/q4CbCIHwovYvPTMpeeXkwTPEdll+ghpt3iHaGUw8k+SiiRQk+Ho//XzjWnVyWy
	jWzVyPF6gos7sdTgvC1VqActGJkR1CQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-TZOgS34gNsCeMfR1Wod-TA-1; Thu, 02 Jul 2026 07:40:52 -0400
X-MC-Unique: TZOgS34gNsCeMfR1Wod-TA-1
X-Mimecast-MFC-AGG-ID: TZOgS34gNsCeMfR1Wod-TA_1782992452
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9f21d9e57so1367500a34.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992452; x=1783597252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiqPwqDr/dUBGMEbPhNSmN+YJdXAuUXBk9FgQ7jSdXQ=;
        b=fgHVtiT8Z16rTugjap8bmyUrLHYjoEKbJLwV69kZO2D5y52h4GfGyP3EavmDhdaIH2
         2uEclbcJJxuS5hyP2qT9VazhkhhF8bYSJOGmo+pOHqb0kyQpXKjT7H3/azW4mf8rskMU
         fmyT9vVZCv2g8VzaQGAC2dnv0qRb1vBfJkLXQNG55GwOsXaniwdq8FjNLjzsYvpmBi0M
         QI3RPEqqpoDM+XivUbrAYb/Fh84abzF3Uq+8AM83uwFdFQOTHQ3S0bV8yBzWGddvDneY
         j4dlNeiQTo9Qczf7dM6FPgvDc0yvod0qdJ564f1+j4vZJeYxP69F6X6UVHW6Waiq8drn
         Tppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992452; x=1783597252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SiqPwqDr/dUBGMEbPhNSmN+YJdXAuUXBk9FgQ7jSdXQ=;
        b=bslbxQyz2bpRM66W3VbWSJ7ttjQNPwRnf+0V8g+bPHcN25DNLUyMHsMiLudn9kWgcE
         8e7Y1TC1DM0YCvdp7KqrlNr1uGLO+df/ju7/aZ9GILppwmacQU7sejmwiidNkLbEyuNN
         hBD0zqM7r4JBsLava8aHim6mXRtCnL7iEfYOq6JVRq5hMnz/2waw0oUpE4fDPOsf3rc1
         jINmdc7UuQf9563Lj/WAxOTpOMok2fw/WD0295li4MBnM/MBzajG5HhbQf/Jv31XdJKM
         6u6jqJuiQGosxGlZ7Z3ikSyDPOWl/sg1ckV1q3OZQB5U8VC0FcShTcWaiilQJOGDVftS
         lKSA==
X-Forwarded-Encrypted: i=1; AFNElJ8UXPvBL7gc1IJvAwTsD13WHL9eidPMk9d2fo5DvAgcRA7o1I6gD3K/kKP3VTKirjNMTNzYmtdO3oNS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn94Y9NYpTY618QmWFLCky2mKkgTaCaR/qDjjRBn+KxDs8fboF
	uYKhdh9bXTvulyMnezyXuxzUPT+A4ycZJvpGdSddMzbm7pk9c9Jg43R232HvkGkeQwRA0I9JnkG
	FATDsS490Ipd2hK+PIIn+am/B4TFyGPUK7d7Vgw2R5x2XkNb2mc+vCiDx+m/sMfkyGSq2L7YdHQ
	==
X-Gm-Gg: AfdE7ckUKKrCdWngrNHk4147lIJOb6v4wPTYdXCbdFSAIHSzb+M79in0f7HNRSOl+y+
	a7w0NIRsK+2S8cjDUgMnzVrqDGgCfCXryuMg7gYhU4F0xDm1Dq3KcWkdmy184SXCfbFgia1h05F
	WARnB6YcXBjeEmlBNn30hQMlBcbrCcwth6NonhFQD7l2MxI3YaL4OxM85Xu49vPARDIVTRrFYW4
	GWjK9bl21Jh9IpHGvs7LuuejJwAS55iFcCjfPWd6bEllTbZdTUW8adTpWPmrKuffPIXl7PEf6SN
	y/HCfgQq1Pr2TgNbhxviHmbPyWcHYRmH7GdbFUqXXNh+kah50UMQFMEpGtciVjAJsryDrDEsT8s
	yUDMI
X-Received: by 2002:a05:6830:411b:b0:7e9:e3cb:29a9 with SMTP id 46e09a7af769-7eb4cc5faffmr3298310a34.28.1782992452041;
        Thu, 02 Jul 2026 04:40:52 -0700 (PDT)
X-Received: by 2002:a05:6830:411b:b0:7e9:e3cb:29a9 with SMTP id 46e09a7af769-7eb4cc5faffmr3298298a34.28.1782992451692;
        Thu, 02 Jul 2026 04:40:51 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Thu,  2 Jul 2026 11:40:28 +0000
Message-Id: <20260702114034.917507-7-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629195540.2892415-1-max.kellermann@ionos.com>
References: <20260629195540.2892415-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [critical] net/ceph/messenger.c:1251: NULL pointer dereference via ceph_dns_resolve_name
  2. [major] net/ceph/messenger.c:1251: IPv4 port parsing regression
  3. [major] net/ceph/messenger.c:1243: Scope resolution uses init_net instead of caller's namespace


-- 
Alex Markuze

