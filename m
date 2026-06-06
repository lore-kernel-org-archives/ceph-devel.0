Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F082F49F6
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772462; cv=none; b=RKdjOVdnjnLuA3PRCuKPAcqahAAOCtkeQFmY0EUfCeveP4KS+ip6LDTfdnXhHQoyqPJ3sEflWlU2IuQ92pAEGIfXWECFf7DDVR0qNWXA7S1Z39AKjeu3LVsPQePg3PuSwTOnTwUkDZW/RDdfalMOhR2uUjAkAfsHWCZRWQyx4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772462; c=relaxed/simple;
	bh=BW2BrX08wC02nhzpIAaJjo2SaZf8rRBP097fOQ4cghg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3Fz8YukpdB5DSFZsBZInYm1ttHINgvGTvjdVY5etRVy45rUAu5dUt63ROK9/eznIo56lP6kE5HGIogjMmAMfDAd3zdLbAjgt4ox+/qbFw72Br5/ZQOs3ZV/0DasBGiPRgKpJV/xlfPnG3sJhOS+FOmX/etdc7LWBmqW5JKAg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OogKPP/J; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OogKPP/J"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51776b4de37so24618781cf.1
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2026 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780772460; x=1781377260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlGP8cAl6M3KGH4/UHsP3eZyZ7kf3DnixlYL4kMyqao=;
        b=OogKPP/J7QOu2R4KoneW2nPmTaLHMjJMgIxX+U5NZxAf7cukwgbFO1B2/X+G5qBoFh
         5agYWlB/9KW1wR5PWahlbcNL8Tvo5WuylzdK5ET/2IJs02HiOzKT770B3nVR/dr6qPJi
         4RI6sbvMaGABp+53jyCVX/XqHoOzOuv2kToUtgu7T4ShXapfrwL+LSquYEXWXwhMiqOH
         ysyXXTsLlp04pS3JJ8+QjnYGW697Vr4i63j2Oy07p6px07SRKnmzEVsOcflrAuunMbOo
         EsdLqI25Q0VI9yyfPJmvgvwWOplq3cjxsExCyXSbkCLL6oZ98U2hzy9+p2sVoeWJ7KwA
         FaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780772460; x=1781377260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DlGP8cAl6M3KGH4/UHsP3eZyZ7kf3DnixlYL4kMyqao=;
        b=N3CwnbRWabxRfZQX0oi04crLbLimYRIIlJP6lXjyB2huL6BMtJyHsnZeX3n6b/VPlQ
         Tc/KDY0DBSYMu/iz06lMtAsMCIPVfSmZiBH/LSOxIO9Wciiae0KxGrolELjVjFlJuPJB
         klSSo9l1lP+tmfBorEx8kDE3sc1FO0IRS10mOHBxySo8Qezet/NYSOR9B76NwrykczN9
         aPMaR/c2WW3yie8xoCBnARYPU5IKmCVJRwRw6ckw/6cfzEuYmqoF9WzpQJOk9tjKn27W
         zvsIehu6A6oC2dfyeiFOiJkTRRqT9a1mJD+dV7r2eTbdO5dS5j+yEpjEdrEhGOPrLOuP
         zgpw==
X-Gm-Message-State: AOJu0YweouzLzsaMlJZfwgrtrBp5wofCIf8M5CMF8DoVXC6z/qKIOmSv
	26RqgPPrgzwtU33MUgCJul7NVWBUwaDUKcy8AweRn4c/f5SZPcUD0od/t4yy1Xc1H24=
X-Gm-Gg: Acq92OEEjs0VjthKBReVTtvbLZLQyiGHasoGdlO5AFz59XXaGFja3I/Nr1rUxPoeSfh
	XiUIAqHK/lFGQpl64csb7OTpfVSN1nY44IESPdKgHk67OViYsjlXOe6Vve7R3TmiqY4Vfe82PIz
	j/qdlk1pPXL1mw0ogg015rlD5ROqa5WgKpkwIS8frRqV9V+dFluJ9y7/4o1gzlfDEc3scrdcpS/
	aUo2U+hXjc4ckdo4r4kCy6jU8nWnYSg3LDOVfULEYHLKPNrNgbn+SUmpFdaWbAmpSK/F2yRtBL3
	Era4ILXN0uy+wI+VNvHVU/uiYFvuz9hcTRBU7bsCKJrPQCFztdnB2UrbB1TrAC3AVVHG57hnVsD
	yRiuUh2Oel3svieTFi4wbdPUboEBoKZ5O5/oYp4UxkMvwzrggWrra94N0+4j8TgrGEBoTkGgJMq
	p6Fa5649CUUeeF5uRh/VTXVo9IQSwchAnRTDkKKsuN23jNueVBYRjogU3QTC6kyBvaqmq28n7VG
	bEZUpTnhJenFGe3XzSLatL4zuqnH0w=
X-Received: by 2002:a05:622a:1481:b0:517:6378:e671 with SMTP id d75a77b69052e-51795c640d5mr128065961cf.55.1780772448978;
        Sat, 06 Jun 2026 12:00:48 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5179dd9d908sm40084581cf.15.2026.06.06.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:00:48 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ceph: bound num_export_targets array for mds info v2/v3
Date: Sat,  6 Jun 2026 15:00:24 -0400
Message-ID: <9d77173c026185448a9a7fc9b22c18f0a915d161.1780766417.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766417.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com> <cover.1780766417.git.michael.bommarito@gmail.com>
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

Add a ceph_decode_need() for the export-targets array before advancing
the cursor, so the bound is enforced for every info_v >= 2, not only
info_v >= 4. This mirrors the count-then-need idiom already used for
m_data_pg_pools later in the same function.

Compute the export-targets byte count with size_mul() and reuse that
checked length when advancing the cursor, so the attacker-controlled
num_export_targets multiplication fails closed on overflow rather than
relying on the later kcalloc() guard.

Fixes: d463a43d69f4 ("ceph: CEPH_FEATURE_MDSENC support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Compute the export-targets byte count with size_mul() and reuse the
  checked length when advancing the cursor.

 fs/ceph/mdsmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index d8e46eb7e5eb5..c0f63f0460f67 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -3,6 +3,7 @@
 
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -126,6 +127,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	u8 mdsmap_v;
 	u16 mdsmap_ev;
 	u32 target;
+	size_t export_targets_len;
 
 	m = kzalloc_obj(*m, GFP_NOFS);
 	if (!m)
@@ -224,8 +226,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		*p += namelen;
 		if (info_v >= 2) {
 			ceph_decode_32_safe(p, end, num_export_targets, bad);
+			export_targets_len = size_mul(num_export_targets,
+						      sizeof(u32));
+			ceph_decode_need(p, end, export_targets_len, bad);
 			pexport_targets = *p;
-			*p += num_export_targets * sizeof(u32);
+			*p += export_targets_len;
 		} else {
 			num_export_targets = 0;
 		}
-- 
2.53.0
