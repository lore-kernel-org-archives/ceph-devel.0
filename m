Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035973C0605
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596556; cv=none; b=S/0qDnM/QNbvW21dIJMaymfjwJ//3mlCi7/oi0l5a+94BImHlGPpjXo3L/ujDwsMf2D70n27lci/OdZlIO6ZWJo5ZKUZCCbsSKJSpoHeIHwb0GJNNxipCDnzHlJY1SGcpv5BNYLGzLAPxuMgRM9RjAQxGFIGFaFStPKUb26Pbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596556; c=relaxed/simple;
	bh=iRGl+Zcv8CCCaVj7l7eFQI316DRL7nx4+17jWOdN+ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwWEk9ZMLvM8U0Y9a0OZICMAXmksWVnevhombMwpoNiNjplgOuy6Wwm2DX+wo7y4S043Z4dV/qx+6+M4zISsZ//38D5LjiG9NUlU5OqQxm0mkITb70Caha19+v9FTKn2ky8/Q5kT60FOyAnbPRXM6Tx1HM0q+e+1i3IpSJd3F1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiXwoAM8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiXwoAM8"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5177945a279so10284451cf.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596554; x=1781201354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyP4o+dWT8qg11HXzsRqDPlFSQhGfJVHTkPwzcA0P6E=;
        b=kiXwoAM8Zf0OUn66TNmFK+ONm02GJHbG/GIgTMf14eIh6uH35dJOW9WA6q2UW8gPgy
         qK5PBwLhydAH8NBt7QRmZS+GE7zSCrWGHNGOdxtdwyXazCRrhSkwaHy0R3jOwuFbJ0ZW
         BqjFFaiJfy4z64pg0N/LR1kBGAuXGo1myq5qJc8kyAsMv1B4ELmgb9aZdFvwvo7pNh8u
         s6sWYHkgfQ3bgYqr8im6w1RCiyo5nEtRWYygRWjyeBzansWyVEkgRy7Z/b0gCiSQmzAq
         zg+Px0tXcI42sh9G5aNwUinzzT7qhpA7ldMMLkaEgwZ4UCP+ny4fvBujQdLS+qvf8FQC
         X85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596554; x=1781201354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MyP4o+dWT8qg11HXzsRqDPlFSQhGfJVHTkPwzcA0P6E=;
        b=E/PnFzA11caRj0mdv1zz4wVa2oxV/PnGxxR0ybW3nL9XIW1yp/1PRkEKOevyd1avAB
         SECl/U7EE0ScM+DIGLLn33DxKlszbfgQAsfBd3gmuSSOEM0pGW7GhB3l+alj3cmX1gA2
         V+yN0d0GJ8B/Nse1b7xDH2myBb68i1yWDoAEC6knT725Uxx9zpBOutElqk633OJJ2uJd
         8V6Hay4yoOD3xsu0Brt/w2POsGt5FMpRCFdltaBE2Ut2EwhMbLfjyyzYcknWMzE3Sh2P
         iOkXd2I55Em5mLD3Dx5mtBkFL+E2DRk07KDCMVgHtwCQ+oj/frkY6nplcoZC39FytE0G
         pswQ==
X-Gm-Message-State: AOJu0YxduZUarf0Ax9xgUjozV/0EqnKEvvwajlGf0N1tjI5wFCEY8VC4
	lFUwDb9tF2ZCoRkrdYd2O4tbsnbIYs4hOh9rs0iZ17KRFdJMjy7w01am
X-Gm-Gg: Acq92OEWKyUVEgMWqfPiYfo6+NpYJEeYGd6eIDcG3Dz0I5hGlWRJfkGGJEIwmS9FDXk
	Iy3Ibz0OHeGSxH1NVquZnsxY+VRbj5PaFiBEnv9WbCzbQuZzGqtu+WBwCdC62tkh+FafGhm8JVz
	eyfAb2eUvRYckQQFcJZU45qnZlAVZ7TWnGH6gtfExONYeLJ5MFczaqJmVvgPnYVfMahW1dY71Ck
	qPZPpKn/VpNLCzGCe6Sf7J15UFiGG0c+nS+AejW7MKa07cLp6pFDhHuh6NMq8GWGDyT6mrriytb
	ZGOHnpfKlx2pEUMNTvNNj4Dn7tFQYlsT8HCoQcUpW1iOAx/jjGiWjGO7oQCI7NgRV5t94wtd/j4
	E9yBjv8xDvgVQ2hZQP0zqFZm/tGcU0e6Dszc5CTJQiodN6vIyJ1234Olbfn8kEsA6UDptm9s0vu
	LRSDE7tlb3PyfNzU70bcQWe80Y6mrVqwj8AJTey03FD0SyQHUkTBUhq8PIl2Aepua8NrC1NOexN
	EqhkplRUPFX6A5LtmYbP9QK2GpbA/k=
X-Received: by 2002:a05:622a:d17:b0:517:61d5:2f85 with SMTP id d75a77b69052e-517786c8788mr115781731cf.33.1780596553790;
        Thu, 04 Jun 2026 11:09:13 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dbd2c9sm59020961cf.23.2026.06.04.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:09:12 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ceph: bound num_export_targets array for mds info v2/v3
Date: Thu,  4 Jun 2026 14:08:59 -0400
Message-ID: <4ac3b57dcf0fba1dc5cc08bfb9a453be55cc465d.1780596023.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ceph_mdsmap_decode() in fs/ceph/mdsmap.c reads num_export_targets from
each per-mds info record and advances the decode cursor by
num_export_targets * sizeof(u32) without first checking that many bytes
remain. The only upper-bound check that catches a runaway cursor
(*p > info_end) is gated on info_v >= 4, because info_end is left NULL
for info_v 2 and 3. When the monitor sends an MDS map whose per-mds
info version is 2 or 3 with an oversized num_export_targets, the cursor
moves past the message front buffer and the later export-targets loop
calls the unchecked ceph_decode_32() on out-of-bounds memory.

A kernel client processes CEPH_MSG_MDS_MAP from its monitor session
(net/ceph/mon_client.c dispatches it; fs/ceph/super.c routes it to
ceph_mdsc_handle_mdsmap(), which sets end to the front buffer bound and
calls ceph_mdsmap_decode()). A malicious or compromised monitor, or an
on-path attacker on an unsigned/unencrypted messenger session, can
therefore drive an out-of-bounds read in the client kernel; on x86_64
with KASAN it is reported as a slab-out-of-bounds read in
ceph_mdsmap_decode(). The decoded values land in the internal
info->export_targets[] array, so the consequence is a kernel
out-of-bounds read, not an information leak to the attacker.

Impact: a malicious or compromised Ceph monitor sending an MDS map with
a per-mds info version of 2 or 3 and an oversized num_export_targets
field triggers an out-of-bounds read in the CephFS client kernel.

Add a ceph_decode_need() for num_export_targets * sizeof(u32) before
advancing the cursor, so the bound is enforced for every info_v >= 2,
not only info_v >= 4. This mirrors the count-then-need idiom already
used for m_data_pg_pools later in the same function.

Fixes: d463a43d69f4 ("ceph: CEPH_FEATURE_MDSENC support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/ceph/mdsmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index d8e46eb7e5eb5..7cb65f9f4783c 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -224,6 +224,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		*p += namelen;
 		if (info_v >= 2) {
 			ceph_decode_32_safe(p, end, num_export_targets, bad);
+			ceph_decode_need(p, end,
+					 num_export_targets * sizeof(u32), bad);
 			pexport_targets = *p;
 			*p += num_export_targets * sizeof(u32);
 		} else {
-- 
2.53.0

