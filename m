Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520061;
	b=eLG4XblqebwseLEwHiNds5JpBjzRkJk7X2Yvv+p1mPr2v98OMApY/GuvfZWho8g2LVhd
	 ApwznKH5y14P+jJdhWibNu3UQl7E8lOIUGzSAoFYww4+75KLKpQDzBs0F4fhgnXInPNxN
	 KGPs4eUoR12i8TuhJouRlgNC3Ki2kXh1+sLbyD49mgf5d9lB32EuKo1GFwRPkmkFCQIxD
	 4q29LGe+y5Utoi3Kz3GGktG2FdksegqJ1ubt3JO7/Knwb84Ux13LQAr6DvOU+hmlzokBU
	 FtHSyWPgkm1Jr3vy5dOzjpJv8F77ay8ZMnMZJNRE/NPXheLSTmVu99hoUcJ4lhrs25w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520061;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
	b=s4ts/apUTVAV1VIbLl94yG0vfP/3AGXy513PUw0BbxvywiPVuil6d4YEJM/QAlC4X4pf
	 6GXvTVokHUMdkmgUQKV4/V/5tsR2k9BHOidMeRwfUXpH8j0sIrH5wzeBKQvKnKgazySk1
	 pzZBO5cNggEaIfmMk3eo/q8Esbhnb2hjcJjCmKSvYZz+Sfo75YERRIyugYV98Ue1jxk1i
	 dn5bSNEP4XIy+4xjHDGVmez+1PGqm6zBkdwQkETBcu28GvAIrv+RxX819I0P/d/1bJc9c
	 Ppls3bpAlw4SAGhBldjyzdVYiYjuTgXK9nLDKHSm4PkxwrQagG8LkIYBBLIGDN6v5Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CdRjt4Cd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XRkdCCuw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D8606A31E
	for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 11:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF4D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CdRjt4Cd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XRkdCCuw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795520059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
	b=CdRjt4CdmQdWlAg6g7HNKf1gLHn9OgPZAP/PIns1K/xoukXPXsL1EDBZzEIkYEHuCTX0pG
	9Ip2onwYdbqwgSPqy1Vh/TXVXkl5I25XvGZ1VV6mbkGbKen1ddALsGtU4cnOYh/dDOkw6Q
	2ExksMjLFQYD+SG/5t3qljGvjk9zxvs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-W4_29NIxN-ay8MupbxPKQg-1; Tue, 24 Nov 2026 11:34:17 +0000
X-MC-Unique: W4_29NIxN-ay8MupbxPKQg-1
X-Mimecast-MFC-AGG-ID: W4_29NIxN-ay8MupbxPKQg_1795520057
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so913404485a.2
        for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 03:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795520057; x=1796124857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
        b=XRkdCCuw87EOb9837lr8iXSna20nBlqrT/MVq2g54ZVKvApYDUwAGeIiPhrEfdfNr3
         RU1FDILE8sjV2+5vby+0m92Ztw49gS+8N+1YjghSmIcOSCu/ut7V39UxuO7gtj/2Q37n
         KHAGb00FTSyni6sYGyukaMkUg0R/S+ZNzBXV23RdAUBlDiw8BFDaLZYAXYJtJ9rLpbL2
         4UuZcVZ6b1gn3ZtmLcto/eSQsCdfbA22yxQSiocCKwKp60JxnFPpqVa8D8AXN+Mt0t/2
         kC2Tq3o9fokFYjM1XAQ5b91o911tqe97toZbSzM1ZWNT46xHG8TzxFMPHVsnKWzt02jq
         k2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520057; x=1796124857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
        b=hyMpZwSui4pRnRZDKvuQDpnkN5XdFqXFjEPSnRgASLzBrpi/Jn0exQDV5l1yLKGuxF
         2tp5qx2iWa6TwGQDGHt15LV7Xx8V3iwrUTlQGlfuiwA5G1gcGuRk+lirMNJ87DokISUJ
         Ctxs0WPME9g6Gsj8yjtxvYqMHALoaFdDk7jXDuAMkKu8A1M+wyE7ODty3WMv92IHx0T3
         97rjFwNeTYvzksWRoXWFBFXXmjPtZPvTYOy9nC+0p+tXGduYpbQAjy+ZWEqEZD47Krw5
         Mcp1XbP+IZVti37wnhn3FREplmphpqZXW0tyLKlq/cKNUMgsimMLBQiP2PwYNhEVDSTt
         oaew==
X-Forwarded-Encrypted: i=1; AL+hErFlwBPi4JTrIilCYHjMY6yg+ennjeQ7guFlNyHbWDmNRtFfKb/l3oWwDRG077YHRFF6zaVqhSZmAVdM@vger.kernel.org
X-Gm-Message-State: APuU4Z9uJzoGZvm1pk7t2H20m08ExGYJ8BzuG0xWOLhJLOtXKHcWPfsu
	4iOf9Uf1GtWa4S/WHlPlPjJaDTXtlsHoN0MekxcrxoV9pcoiFbwgChQZHF8ECrxp5NQKJkOoxYa
	Sj3pUmfl028sfqns/X2Pe6U+jMDlM7noDaWr2kCJuCWn4V//8edkKzd1rFq7nfJc=
X-Gm-Gg: AZFdTZdd1R3LFIG4WOYRx/+e9xTMdQvOS/p/ROPeDYU3dh2DZeFm7BSf+iJOK8XHP4O
	YO+gT/5kLi9fpJQa1umFiiyL6MDwOygKGCJHEPD8UVGnfg5BWum/eNFjjGXnA8jCqOjfrC/5I9W
	RHFdfmU+A/HF/uh0rjWeK5q+9EkWVkUgK1e5aC2FNK2J2ojhUgkxPUGOufm6ahZ4tjPagwAxRyp
	qSmuWHOAgyPE265a83eI6DHxie0Lzi+46eKJ56yXVXmE+aP2TZvUC4KWmP7MH+06LZRRarYzLIz
	KqG8NrKK/5/2BJLIZjYWPKbPUGTVG5eOzq8oDX25PJS+7gax0LSJ+GYDAibRCPwZ3xy1xYUwqdC
	ml140F0I3ucEZ6nv4Wv1AAdQmkNEzA6/r7jzIbsupWGB56vJjbEQpqBmmQ6eoEZDFudngfQzU8Q
	0zSFbAG2b88L62Znks+BKXi3VJT8K7JpyaYCb4gBv49tjzX8AUPzKWEaDqdwfr6PS/3UvFvOpoW
	LDn4TcocxiNA/OmjUBVlVi6IP0u+A1xUmzb7VhPfGV3E3n5kzL3
X-Received: by 2002:a05:620a:44c5:b0:949:a9b4:bd11 with SMTP id af79cd13be357-949bab4d986mr2487711585a.73.1795520057174;
        Tue, 24 Nov 2026 03:34:17 -0800 (PST)
X-Received: by 2002:a05:620a:44c5:b0:949:a9b4:bd11 with SMTP id af79cd13be357-949bab4d986mr2487708785a.73.1795520056784;
        Tue, 24 Nov 2026 03:34:16 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34d427sm999811385a.9.2026.11.24.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:34:16 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Kaho Jiang <kj2864@nyu.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+408fcc361565713f@bugs.sh
Subject: Re: [PATCH v3] ceph: Use unsigned types for snapshot split counts
Date: Tue, 24 Nov 2026 11:34:12 +0000
Message-Id: <20261124113412.2078323-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123050440.223436-2-kj2864@nyu.edu>
References: <20261123050440.223436-2-kj2864@nyu.edu>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaho,

On a malformed SPLIT, the failure path calls ceph_monc_blocklist_add()
with snap_rwsem held. If the blocklist command succeeds but the subsequent
OSD map version or map does not arrive, cached snapshot lookups can remain
blocked on that lock.

After the blocklist call returns, ceph_mdsc_close_sessions() can queue a
close request and wait for it from the MDS connection worker that is
running this handler. The worker cannot send the request or process its
reply until the handler returns, so with mount_timeout=0 the wait can be
indefinite.

Please move the blocklist/map and session-close waits out of the MDS
connection worker, and avoid holding snap_rwsem while waiting. Keep the
client fenced, prevent further stale-context submissions and account for
writes already on the wire before releasing session authority; retain the
required references until the deferred cleanup finishes.

Thanks,
Alex

