Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E13ACA70
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354699; cv=none; b=Gqr+o3eMwcvUs24/+pzIj/zlzrrWh6vrfNXPLlYdoH600CVe3EQoCR6LHjIWzrrxs0LDiANHnJV3zU3P4QYM3wOLEtKmWgSSUAvmfKiAuv0Nmn/zhuGhtX0RYuBbQjVq+EWmJpxPMMi03T0Yxb86OCD7dHZmRLmJLHl1CIo4oSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354699; c=relaxed/simple;
	bh=3Jdx0m/PVKztJ1BjQRf7/ruhFRoVzdvTceFvJBmFXTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRQsoAd2U8b+MlMuGZZbe+6kR8fUQSbZUiVDm5k+GImilN3hC1OF4UJjN1LrIUpHu7O2FQljhJX9DLBUddPK/eR9eSMDRlb4vy3YsT6fKGOqN1gyolperDgBNREJ2f4lN4ZDjeFEh9vfqxWC6yv04f+W1yX7cmZWO/ngBGFUPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XI6rp/5v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6Oe7vUj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI6rp/5v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6Oe7vUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783354696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UG44r9/VRKV59jwr7aVIzEumeCeyyRuKxMCf/s0BFE=;
	b=XI6rp/5v+nlJdas++2JxOtte0Nnx5bFalL3B6JBbxIl9XPpkQdEFrDa8quAuXVKnLhhvuj
	pq9slc23oAgBbtAJx26bNXsKg7PQqNyBPimnGSXAlQc5xrnbK/LfE1uHFJ8QGU8OUl5EGQ
	zKPETbWMoNyzhaYaUkHpLewsDCqzcfA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Gglp7r_FOz26IWzKsBK1Gg-1; Mon, 06 Jul 2026 12:18:15 -0400
X-MC-Unique: Gglp7r_FOz26IWzKsBK1Gg-1
X-Mimecast-MFC-AGG-ID: Gglp7r_FOz26IWzKsBK1Gg_1783354694
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698accdb6beso2629183a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783354694; x=1783959494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UG44r9/VRKV59jwr7aVIzEumeCeyyRuKxMCf/s0BFE=;
        b=R6Oe7vUj6VjIjeoCRngZSvMjOGuaDNYt9T2rtrx8yNU6JqXvLZS+J3JD88DINq/oom
         4zGTtqG7R6AxFxaUySgkHFMe4TxuiHuqzkK3Y5J4+ptbBI3XF/y2Tnawb/9bxTmJspPf
         qyHWiHYkwN5NMgwvMCAmJkNoYn8bpe61zbbDHlcg/kPKWkhl81zjla8KG0J7fFtTPmp8
         K5qcB9AWboTo20b6KDIWxmOLbT8Cjwgxb5Yl/Q5RGCrSDajrxy9gnpnRG2zniKcoiKkQ
         Ud5U6ZhE8sBeCHe8XlA98f4TKkx2rcrSfkkOHQwMRQS8Cb9itst5kz5SZeCrEx/Poaix
         IyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354694; x=1783959494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4UG44r9/VRKV59jwr7aVIzEumeCeyyRuKxMCf/s0BFE=;
        b=bpUgGhcDarJmFcZrv9KJhbmTzngysVEVjl8ajL2ModpOzLMUqzpLxEMUyZTo4ttzgt
         531aNCVeK6TyZW2M5D7kGKehGp3QZeAsV1svw1FN53EsW1Z0cyqKhFTHDn5fH7SIain0
         +s88h25sARpcjb/QVNQk9J8hxpZlpkXT4TvehrIGq3EjS65ounlooDwclhTJfYSBIe4q
         0jdqAWnQksJhAII36qpKfJl/OJ09ARCcuSXw34y39PkgYbZUXLAdxK7NuzeGWCd1OS9D
         2E5iItoJnULI/RYB62EClJD9Mpq/dnVmMCpt3Zff76//CWgeUPbUcJCCVng7ElrycUfn
         XUPQ==
X-Gm-Message-State: AOJu0YxUh06UmZkfeFL4xraQPGplZIXLrQhLPmFrr0eDVkLzr/rhwBtS
	DmG70P5Fanu2j1ry9sJvC+cehnPDaVNOpZ9IoZTRHmbn9eTlcvXapUND0QvDqOXER2KXgji+dIb
	kcw4CSfsncNJdmwf7dSRrQn+T3x+eDZIVNZrwL9j5hMrm6GWWIn+zWFvIsV4Uze9i60BScOPDTw
	==
X-Gm-Gg: AfdE7cmxnZ27FlBpe5gGgC3uUQARQIuQnHIqqqNwdUsvi4IQOM74AYnJfP1OtwKkOVi
	/xYmmIMidunNnW4bLn96CJiko8ejst2hOIDmFsEVcgzLo4mRUCW6tigQB3tnRchEEw9W02L0oGW
	kH/5wAkGZgXJc5OMpyo7mqsVs4RIJGW8DiX++/2KNVj/d0XiPtsXllgUmSUMwuzew2xy9Le5MBS
	WAafoUD7UwxBm4RmoLL4HeN35MGZgPXmWsis42YZbIbUvIf5PLQBNZi2DVuUu776vxmHGLJb+9z
	QQ755fyS3/0BaIzkpGICIcKgCB/crr6rrEosUY9CFSKCY4OeL0KLXva+SO+vm2BdUupqvuN+rxD
	uYTsxVFsYV6Gg+ogwuLaBcL15H0nurAE8OAyGH2khPZ5l
X-Received: by 2002:a05:6402:430e:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-69a85b9b0d2mr662363a12.15.1783354694371;
        Mon, 06 Jul 2026 09:18:14 -0700 (PDT)
X-Received: by 2002:a05:6402:430e:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-69a85b9b0d2mr662342a12.15.1783354693905;
        Mon, 06 Jul 2026 09:18:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19db05ecsm4225243a12.28.2026.07.06.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:18:13 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Mon,  6 Jul 2026 16:18:11 +0000
Message-Id: <20260706161811.1998210-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706074402.3927113-1-max.kellermann@ionos.com>
References: <20260706074402.3927113-1-max.kellermann@ionos.com>
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

  1. [critical] net/ceph/messenger.c:1241: IPv4 addresses with explicit ports no longer parse correctly
     `ceph_pton()` now sets `*ipend = str + len`, where `len` extends to
     the list delimiter (comma/end-of-string). For
     `10.0.0.1:7001,10.0.0.2:7001`, `ipend` lands on the comma, not the
     colon. The caller `ceph_parse_ips()` (line 1350) checks `*ipend ==
     ':'` to find the port — it never will. Depending on how
     `inet_pton_with_scope()` handles the trailing `:7001` in the
     address string, this either silently defaults every monitor to
     `CEPH_MON_PORT` or fails the parse entirely. Either way, existing
     mount strings with explicit ports regress.
     Suggested fix: Split the address from the port before passing to
     `inet_pton_with_scope()`, or set `*ipend` to where the address
     portion actually ends (before the colon) so the caller's
     port-parsing logic still works.
  2. [major] net/ceph/messenger.c:1241: init_net instead of caller's network namespace
     The patch passes `&init_net` to `inet_pton_with_scope()`. The rest
     of the file uses the caller's namespace: `ceph_messenger_init()`
     saves `current->nsproxy->net_ns` into `msgr->net` (line 1695),
     `sock_create_kern()` uses `read_pnet(&con->msgr->net)` (line 448),
     and `dns_query()` uses `current->nsproxy->net_ns` (line 1271).
     Resolving `%eth0` scope identifiers against `init_net` will
     silently break in containers where the interface only exists in the
     container's namespace — exactly where link-local addresses are most
     commonly used.
     Suggested fix: Use `current->nsproxy->net_ns` instead of
     `&init_net`.
  3. [nit] net/ceph/messenger.c:1252: Spaces instead of tab indentation
     Line is indented with spaces instead of tabs. Kernel coding style
     requires tabs.
     Suggested fix: Replace the 4 spaces with a tab.

New ipend placement breaks IPv4 port parsing (regression); init_net wrong namespace for container use.


-- 
Alex Markuze

