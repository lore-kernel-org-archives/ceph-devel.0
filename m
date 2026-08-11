Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37C446849
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458745; cv=none; b=eO+bfbbVC+FtOrw17ZkaWPjHhU8IQi8uoOZq1VYXKNr4TmCUPH8sxaYeXOMVPNpNcKYqaE6D8Vy+Ue4QLwcjGeWLBcEVTYPpu6tVDtaIFUYySpBNZWlVEOJ2x3aafnsdTCXTWML6oDu9VkbGbyH3n5r104Avz+JVwq8WeEO9NVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458745; c=relaxed/simple;
	bh=/5vKXBbQIy8HfCWMQtMPkhxI5LLD0entCgG4lGBZ+qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0eFpRWP9qmbXLntrNzrLKZXzsa5BMWTGQ0HXv6WDGQTkUMy2MqNWU+2SVCTQs/ESkd6dFuOpYONvsD+Ar56MZW4qNX6/2WWW8NXbK9V+GaqrqSi3cbAOLwCwwqlVDyoX8diHH1QMsRfRENooBRPz2ISy2/JM7YU8WA5QKhZIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR8uVMpe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J25b5lIN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR8uVMpe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J25b5lIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786458743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW3AYMSL4CoaSJS92lMOP2IawUDQYXaHk1kuBsNT22k=;
	b=DR8uVMpe8+cfBziT5ZLLevrklFnrm35pD0yDxZnmXG97LQFHtGQ4Oz+ij7++0uB3xefGuT
	LnYUtA7468QGrOPS1/uM+DMXgZXyLTD4RKM6bjWet5VKY15Dg+rGnicm1jPMHro/FX1rh/
	Whi6KXkf0VV7CmGKoR3yzFa3s3CM2lE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-Ekt5DlKxPhGWm3730OUFqw-1; Tue, 11 Aug 2026 10:32:21 -0400
X-MC-Unique: Ekt5DlKxPhGWm3730OUFqw-1
X-Mimecast-MFC-AGG-ID: Ekt5DlKxPhGWm3730OUFqw_1786458741
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15ddb61f13so75057866b.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786458740; x=1787063540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZW3AYMSL4CoaSJS92lMOP2IawUDQYXaHk1kuBsNT22k=;
        b=J25b5lINDecdZRNXfKntl9pvAqL9xCHX91xtY3JegeFyPFeZur37BYdTeuqD2KVRvR
         H0wvbvD3jo8JQ1dTFbjX2XkiJmg8IH7CJOVzflyqOpId3E7uKsg6KwEZeeA6yBpmtBLR
         Lf09ABDIGozO0Axga1/fgiTXQb9fd1EHHB2uh2qOuzd5mFQOfqqRgw26szhTzrM8Nivw
         g6S7ouykG6gq273WPhsJpMFxt5vypSTc7I8aTzTSgkIgPTPh+nMN23DlsJV+pvpG86UB
         pVKT/yDoeqsndqzmPwpCLi8loEFdM4Jsy7BYW4wTxbNgrTgqG3zMnanrU9lAVu6bjIgC
         wv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458740; x=1787063540;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZW3AYMSL4CoaSJS92lMOP2IawUDQYXaHk1kuBsNT22k=;
        b=b0wWZBOzq18U068zith+5mL+BucNcATMgIcFU4nWpl4couyCVTp2pR71rOaqlgkWmw
         Qgk/aVDwTqs5XwszaJLWrjTcr0qPGUNIEMY3w7/F5zGe+TWN+3rGPDK4/G6mu6oY1mui
         oJ/8+oRIFV7rK+wDTwZ8H/1SPxu+zRUxh+ExrUyHp2Fvq7sFhR95fdhMsYEb8BPpEMTj
         KRauw3qfF91jVCaGmoqYYLkW4GwGiU0hIqcv/0fpK1ZemoFA6i1LksfoVmFUpSV7b9Dx
         ERBerddMeraOw4topAri2Q5y6fgSVNGl/xIzPpVOj4ZsqY3S/ZlE2y83tcXa5OTGzv0A
         SShw==
X-Forwarded-Encrypted: i=1; AHgh+RrkCpaW1FV7qiUWjcsDN74M1YPZojMBqhLE51ekizlMJ1eNIQMnuKWYNOZvxd7RXkYh3kh5UP8/CsM2@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeP5/Wa1d7Or3/8AQCSVoCJL4n2HeiqitJagBiYXM2gK77s11
	py7YiABE0PjfLrywyfD4WCMbp4pnr9qi2IKGByEFABEFM4bm0S6H9aeLDXjXeXZWCkAXn6ulzMZ
	hH+LM1/UmaoCryClGtdwyLxNH5F7yAygenhZOn4PPPMwSo0UHe1ZVCHkZDADGcw0=
X-Gm-Gg: AR+sD11SutK/Wwuz+aJFSR3UN0B8r3ESpTA5jR5Bu1vb0BieOIH1zn1UOhmFtSAzVUz
	puMkKsi/5fVB0EqQ9ED6iZs3KLb3WJF3sDz5AqebkK9L9Z7IFLjJIQ7nJN4gckdrCpyi8JYfrxS
	rhjV3GuPvQx5Fqfwn+87G/NfG+p5M0iclWd6VU5MyXcL+fIQmWSQx0JLJ3fn2dHQZRsDLOIbHYV
	MJM3N8qkbyjoSKC0ZG9n4d/QfPzmt1ndOKLYGmVMMWrx2fXOl+PxSSGVNhMen4cv39XK5VezDbv
	fZboA6ji6J2EaLMsYMJ2dktfOzP4aC7ZtqKObEaWJbJnxxdFaJUZjs4rS5n0vDT17q+HF/5/yNK
	gQFTKtpvWS0Ane+upLLHi8dheJG9+XtPJKw==
X-Received: by 2002:a17:907:84d:b0:c19:80cf:4c75 with SMTP id a640c23a62f3a-c20ecb40d32mr39937466b.20.1786458740583;
        Tue, 11 Aug 2026 07:32:20 -0700 (PDT)
X-Received: by 2002:a17:907:84d:b0:c19:80cf:4c75 with SMTP id a640c23a62f3a-c20ecb40d32mr39934566b.20.1786458740052;
        Tue, 11 Aug 2026 07:32:20 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e435a9f0sm61837066b.44.2026.08.11.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:32:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v3] net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Tue, 11 Aug 2026 14:32:18 +0000
Message-Id: <20260811143218.2702177-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708203858.263229-1-max.kellermann@ionos.com>
References: <20260708203858.263229-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [critical] messenger.c:1259: scope_id leaks into wire identity, breaking handshake
     `inet_pton_with_scope()` stores the local interface index in
     `sin6_scope_id`. The full `sockaddr_storage` — including
     `sin6_scope_id` — is copied into `ceph_entity_addr.in_addr`, which
     is then wire-encoded and `memcmp`'d during both v1 and v2
     handshakes. The server will have `scope_id=0` in its advertised
     address, so the comparison will always fail for link-local
     addresses with a scope. The interface index is also
     namespace-local, so it won't match across hosts even if both sides
     set one.
     Suggested fix: Zero out `sin6_scope_id` in the canonical
     `ceph_entity_addr` after the `memcpy`. Keep the scope only in the
     `sockaddr` passed to `kernel_connect()`, or store it in a side
     field.
  2. [minor] messenger.c:1334: Allocation failure masked by DNS fallback
     `ceph_pton()` can return `-ENOMEM` from `kstrndup()`, but
     `ceph_parse_server_name()` treats any non-zero return as "not an IP
     literal" and falls through to `ceph_dns_resolve_name()`. This
     silently turns OOM into a spurious DNS lookup.
     Suggested fix: Fall back to DNS only on `-EINVAL`; propagate
     `-ENOMEM` directly.
  3. [nit] messenger.c:1247: GFP_NOFS in non-filesystem context
     `kstrndup(str, len, GFP_NOFS)` is used during mount option parsing
     — process context, no filesystem locks held. `GFP_KERNEL` would be
     more appropriate.

scope_id from inet_pton_with_scope() is copied into the canonical ceph_entity_addr, breaking v1 and v2 handshake identity comparisons for link-local addresses


-- 
Alex Markuze

