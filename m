Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE093B19A9
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467336; cv=none; b=dNsZFCG/+2hoccem3Qz5PWwgHN2RvuG4fRMyzrrdOTgiGFeo0sUxC2jc2W1tSGBjrBnadWSH7x82XDe1scQVwpUm4ptR1vri6k2a1aJuFCLU2x2joBy7VfLyY3te47gc1pthNH1aJ4vPTHVGdlmgU5NO4klZv+Rujyu/IqKr9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467336; c=relaxed/simple;
	bh=RGKwYwBvRu5aIqF3w/L4zAxiMoTQTO0PgieGnaNr5U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaGS1ZadOM5KGvtEFhXTq4tzqbTfJldHvY1HUVzhk0pNb9MPDaA2JjUBb8aeW58jxDkj1M3KTjSVRKioDOxi0sIdycQkos1yHd88ImznkaMg0Osnk0N8R0xJ70kSmBey7P0OAbH3cMN9VlInKbl2Wa4WTZv/tLWASeZSq5sKojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7KBD6aq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzCl04fW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7KBD6aq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzCl04fW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786467334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGKwYwBvRu5aIqF3w/L4zAxiMoTQTO0PgieGnaNr5U8=;
	b=H7KBD6aqD1QYPbrwbT20U4dGCh/zUP5SjrM392t6elN8WpxvbZ284++fhLqI0PKgIe1bwG
	kkkUg1SMf8YiVesXQBPWdidZvp/UEVeEvKoj6PFn157W2w4jNYqs4Om5qkr4RbzyrydyJo
	HFy5gADwF8CdTXGJNdColVOH3IXLqa4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-DHw71nU1PdenidffWKnN0g-1; Tue, 11 Aug 2026 12:55:04 -0400
X-MC-Unique: DHw71nU1PdenidffWKnN0g-1
X-Mimecast-MFC-AGG-ID: DHw71nU1PdenidffWKnN0g_1786467304
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9e2db9914so1438247a34.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786467304; x=1787072104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RGKwYwBvRu5aIqF3w/L4zAxiMoTQTO0PgieGnaNr5U8=;
        b=OzCl04fWS7EhApITmZ9BryQyljDjVF9iYAC1UPMFkewMSuJE7Ii4moM5nDg41nomeL
         p5BPxiaDNnBG64uIbl3jhO7vxFOquId4m8jBntkt9z7ifaFOtCkVbcw9p47pbKV4aLkB
         BJik4ZlL2n+L4jPclKpwioFe5cJW0gxQAIxtvCfEWmVwWPNEgao0ri4hT9ZKQ2wERw70
         pkl9K0t1lsgdujfYHpMx+3xZVVQugVgeQ/MYs1IMdO/a31RMSrrkOxlxgePegY5fY2tD
         elFeirJ//H1rl8kzzGHiwhirwywoSihuGWju2uKhtxS0Uzrvoh/GzB9W7JeW03Fp2KCF
         D6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467304; x=1787072104;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGKwYwBvRu5aIqF3w/L4zAxiMoTQTO0PgieGnaNr5U8=;
        b=oBIFDiyzXQWvR1653c5/KZ043IIB7HFMkzjFEOaXcNK+EYTzkLqrl39bnOfBiZGxlL
         I1jYd9ba1UOlAEdRBlyLfUih5lQ18AIPtZrzG+N7kdeNb3k2OIrH4ngH7DcOnIPhCSCh
         3S6CLeTn7a+HEDi6KYM6SG+TdlRFkWLiz8ErQEq3nsuu0GB6lrK928sU1+dvGITwqAlo
         O6hU9FwVJIcig5dIn38Nch9X2Rhsv83gYbTRoBZjo2s+mLSbVU//bfwb1UESOhtkZtK8
         Tb0WmR5f64GkXFqiSLVbRkxFT82f5ZEbHA3usMZMWmuKPZI3EpDHH6PhYLJIiSmG7i8M
         JpVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0qfwk//m/0ba457zJkg0q2w0P3SAyth5Nj+3Hhg/PDyBld70JVAm1gSWfOW7pT4fN5ZYa/QfHT1km@vger.kernel.org
X-Gm-Message-State: AOJu0YydMd/Uycfi7wZ2QPiJ21x9Z+2KcudqHoAjuNtKx91suS2kDkjU
	8VHmPrMKBuWYajektuch8kYt6Vr/mjS9k83Q4uX5i2pOLSHKnlUZzAPxOURqfGjLTmspPZLctpX
	GXwTiRhaR6ZPpGQtL7mV8qdhduDmQRBTC0+z9rks1+2PQZjMH0XMumejmX2ePZcI=
X-Gm-Gg: AR+sD106CNBX5xPk8uoHI1pGxeeWaK5nGotIVSS8S4ptmnbluX4h8fK9DWm16PfyZNt
	SdxJ1/bkZ+xGP1IwcQdJPSbfVrnq65XXdphJt/meqb84zAByQpNzLW3P1t6j6CwUMOd3mAAz0od
	pB7d2FMXMYu3JyHkW2UXo/ONlJPWRE7d/GNjX10FDTX7c5krc6LMLqvj3qyk8zrmRmFIwDZRWNo
	aW5LXm55Oo7uWm3Oz1dfwIkzfaD6PXVt4hdC0r1atUoArsIIBaUOO88UkcpxjFrh2s4/xpaL1xK
	EGhHt22aGsr8VdMFSu3ShMHv8G2ve2HrPWE8NMhOZTr9nhAgZ76ZeQrKS+QIu2+yYlt7Ng==
X-Received: by 2002:a05:6820:1987:b0:6a1:8132:cb27 with SMTP id 006d021491bc7-6b0ac504d87mr829996eaf.9.1786467303797;
        Tue, 11 Aug 2026 09:55:03 -0700 (PDT)
X-Received: by 2002:a05:6820:1987:b0:6a1:8132:cb27 with SMTP id 006d021491bc7-6b0ac504d87mr829969eaf.9.1786467303375;
        Tue, 11 Aug 2026 09:55:03 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad27cd00sm230378eaf.0.2026.08.11.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:55:03 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: xiubo.li@clyso.com
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] ceph: use GFP_KERNEL consistently in __ceph_pool_perm_get()
Date: Tue, 11 Aug 2026 16:54:56 +0000
Message-Id: <20260811165456.2765891-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723-b4-gfp_nofs-v1-2-c06b40354ec9@clyso.com>
References: <20260723-b4-gfp_nofs-v1-2-c06b40354ec9@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiubo,

The patch misses one allocation. `rd_req = ceph_osdc_alloc_request()` at
addr.c:2468 still passes GFP_NOFS — only the three calls below it
(alloc_messages(rd_req,...), alloc_request(wr_req,...),
alloc_messages(wr_req,...)) were converted. The commit message says "three
of which used GFP_NOFS" but there are actually four.

Could you respin with that fixed?

--
Alex Markuze

