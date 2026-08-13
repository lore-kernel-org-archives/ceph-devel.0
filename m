Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1437F314
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620038; cv=none; b=Gt8KHSSvpBPH/z7hcY9hHarrNDiFNB0cUpznapCENRxjjv3QkrMKnZMMr5Vh5guYai4bukxGhgqNhJIcacYo/ggvv3eQJV/uqQrKVxnX5nlS998CMIe9cLr53iO+boY73+0S9geP163M11wc3014s8E52JFEBBvA+pg9qimjmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620038; c=relaxed/simple;
	bh=gaAj9Jwx0O6CUGuqMrbrOJthM2w2AwAnw8Q0fuUttCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDL9ZJ+iR3BVjWMXXekd05+h44NBXD28r89Bi+sJ1cFcUXxDGa2G52Fzkc7Y5nQOH6OqiO8l3sQq2NcpxtYfDYVxgZG6APWzxrGKL6VNKotkDm4PgOG6ESQQUO1z+ZET/N9teWhc+hzu5nBawaq/2TYItV8YqmHKINER52E3Ohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgIe6glX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kDyOu19a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgIe6glX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kDyOu19a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786620033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaAj9Jwx0O6CUGuqMrbrOJthM2w2AwAnw8Q0fuUttCE=;
	b=BgIe6glX3btNBy2NltN4RepZnVVcCjhkmehujSWAPvPFrcMs/ag3uuQ74X6jMB3NsZWZyk
	Am8D/1KdpVl86rXrN5D532XOxZtIh+t8cNMqLDgMKw5B49IkguL8k+183YQfmTpxtRMIxR
	tnomZtKy1MsL+n/bxAK6Q6Fk7biGZcw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-mUPh9_CpOnG2UFZpvyMD5g-1; Thu, 13 Aug 2026 07:20:32 -0400
X-MC-Unique: mUPh9_CpOnG2UFZpvyMD5g-1
X-Mimecast-MFC-AGG-ID: mUPh9_CpOnG2UFZpvyMD5g_1786620031
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a18f14a076so2389301a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786620031; x=1787224831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gaAj9Jwx0O6CUGuqMrbrOJthM2w2AwAnw8Q0fuUttCE=;
        b=kDyOu19aWE8r4pds9+RHR7qEZh4a6vCM5vFLx1zhc4qeP9qV2NQac0EXbmlfkr/pG1
         tYrhoJYSrp8e+kzttHSKZGGTm7o8P6LNnSyd1ROVngzRqR5Atz1OnsUB9xrtXyMb2rLF
         Wg+dRjc678JzNVpmFXtwqLxml2maivrrzXfXKS0XzRxt60Oo9TXTXEKIc9Te0KUwsi7L
         1seaWEd/Srd3xeAHyzKtQXx1UmWedXBsdINNv/2zJ0DYfy7BIlMaTdz3MrZq312lgohE
         pNXxl/Uo+i9SV3wtEeQp6kYCVKdH4wRNEfr9nHaKl1Eb0f6lj58Pu0lDVxjOCwoRiSmY
         OHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620031; x=1787224831;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaAj9Jwx0O6CUGuqMrbrOJthM2w2AwAnw8Q0fuUttCE=;
        b=ISg9L3+xKk36XyzHspQ05pF8BMaUqh6SucpYN7pcAgjlMcVvOO9xCQ9o1/hNmHm52s
         AsQ7oBEu0iF8LqjwDXm0VbSSQZMCXn6zYS7JvYL0FSBIdmjymTuggByKGkNDsUgbiOTR
         Yk4aNXdCRoYXekD/DswDSaXR2CXporkVZzBOwPMUFRgW0wIrr22X1AtSXjFZwHpwDmkK
         55DZs2LaUl/rSL9D9EMNOYtIXoODdpX2XZT51ZAAwzooBP8JSd49Lb2oi6gXvwVxbt86
         AqK/Cd9UTW60rMlG0iY3LwZ8XTitWBzZ6tjV4XnWfWnwYJAWsdZZoaJ0tKVK35riEJo7
         8WlQ==
X-Forwarded-Encrypted: i=1; AHgh+RphRft3sbDnW3joahyMs7P5tL/3GpVbnrR+Daat7kfqlERnRG5ndVgeXgS4cwlmQGJi2X22heJ9apUX@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXSekVwmLOm17xrm/wMvVY7fFERznLtyAECA4PPfLbPHBy+wI
	YTvzkXJSByOfi12/gsMfTTbiKMenb41ZrExRDxW4wcgzkaGwPPlVj6wzIWcFih0M+FHxWGngOvm
	9f7AGdZTruDKX1g1hS9BSqOYDNP3mSAY9+Rlr6RyYhQiOVKjnjSeoYVNk+YqJUVo=
X-Gm-Gg: AR+sD10c6jyteAgEdlryMXIudAkUnxDRKjdnqyF1FewYDECtxVAjB0QQuzCj8d4HZE2
	hrf3B3nJPq0fifWb5Sg7mjI7li+C3IqbwKaMJK1mxSjdJlXJn5MGiaP2/tJTJsS/lkgsTO5LSKJ
	VPPHprqK8yrfeAYZYvGTRGqBuXRm3TqaWRsMWpNSC6FF9r1tFYJo5/Olp78or5CGsDrXG7n2QVE
	6QhQPFOvZ86ZJOQWGK4cE1oBxoTQ6FFJyOXlInjTIAIrr9r/yorO/HQ5h7WVGFF1MGz8qVAGyuo
	ExW/2FNGBr1NQm+SQpNJYukReInUqeiYXuqYUroF8t+kT8EtprsCvvrG9mcU1XTENdw3LFO6PP1
	lVhyuuozlr/MPIWAR6kQrMbL0faHTCfIl3g==
X-Received: by 2002:a17:907:9614:b0:c21:180c:d82d with SMTP id a640c23a62f3a-c21180cd916mr43129466b.20.1786620030912;
        Thu, 13 Aug 2026 04:20:30 -0700 (PDT)
X-Received: by 2002:a17:907:9614:b0:c21:180c:d82d with SMTP id a640c23a62f3a-c21180cd916mr43127166b.20.1786620030515;
        Thu, 13 Aug 2026 04:20:30 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c211aa04446sm3249166b.26.2026.08.13.04.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:20:30 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: tz2294@columbia.edu
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] ceph: convert writeback path to folios
Date: Thu, 13 Aug 2026 11:20:28 +0000
Message-Id: <20260813112028.3989422-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810-remove-wait-on-page-writeback-v3-1-dd7531704f26@columbia.edu>
References: <20260810-remove-wait-on-page-writeback-v3-1-dd7531704f26@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tal,

Patches 5 and 8 remove wait_on_page_writeback(), thp_size() and
thp_order() from mm/, but those helpers are still used by f2fs,
mm/filemap.c, and mm/folio-compat.c — removing them would break those
users.

Could you split this into two series? The ceph-only conversion (patches
1-4, 6-7, 9-12) can go through the ceph tree once we drop those two
patches. The mm/ helper removal is a separate effort that needs to
coordinate with f2fs and the mm maintainers after all other users are
converted.

--
Alex Markuze

