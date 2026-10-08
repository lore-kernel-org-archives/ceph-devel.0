Received: from mvsmtppost28.nm.naver.com (mvsmtppost28.nm.naver.com [61.247.196.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413B3BED56
	for <ceph-devel@vger.kernel.org>; Thu,  8 Oct 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.247.196.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440252; cv=none; b=lmxLercoMOPe/w9SGj8B9H/cJZiX7q8hx1RDQRrKqiW8HPl0ne/slHAJL0XTg+OHNzxOlEqJCCGuc2EyDSY3oU0h1emvRJVatyC2XdJZM4DwAzcwDTc3neC2l/iyt+S+JGbbsf2AUJgzJX3956l/P7plx/ESEXfNHy+sbW6QAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440252; c=relaxed/simple;
	bh=VhDitJgCy7Mj/SSOwupcCv1OS3f4FZwihJJoOxw90J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umsuuzIGKFs2qWNoIg+k5AEfHIABVc20+sYRXRSsit5nDhIxrGZmxBUEVacskdHlLpcn9L+1tgmysWQwCN0B5TsphVxJ7R2Y/QtXjXLkv99gzxaxijeh0MwWr2h6A8VrvVPOLIDeD+yETJF/AOgHyt2iD1IfhVH9vik5+1/MTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=Fqq3ZiQy; arc=none smtp.client-ip=61.247.196.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="Fqq3ZiQy"
Received: from cvsendbo020.nm ([10.112.24.40])
  by mvsmtppost28.nm.naver.com with ESMTP id PfWfcGjaQHyrw6jyvIKEwg
  for <ceph-devel@vger.kernel.org>;
  Thu, 08 Oct 2026 06:07:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791439640; bh=VhDitJgCy7Mj/SSOwupcCv1OS3f4FZwihJJoOxw90J0=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Fqq3ZiQyUdfDFFhbLsSBcr0xytZEGmZmxfMuJ+Y7p5uCGCdz31bOVqfi9BDKVCMV3
	 r9S+MMkD5WH0zh5tXTNAN4UmSLTfEH4nbCzrHgg86R9B8SvdcljF1hfn6rLw9ZYxOb
	 idWYZs3ez4xU/sLSbUaHyRRymjABebgfTWvpdVIT0raVe6h0ZeSV0pTpp5zP3NQuXr
	 8JTQhE2VP1/DTDIQjkjv4zteXQ1NYgwH4NLZdrkA/SzhzTrz3mkXDpZWO11qq5wZGw
	 F/6jc2FKQ9RHRAEZEX1O5gjLEet+2NHsNHzaNwivvuXPjvzIHA1X4gGRoSOeOSX6aR
	 MvItzeiTInFxw==
X-Session-ID: 70Hx9F0CQgq0vglQtmWbfQ
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKHmdjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rZbmFAulFqJZ+HmmFAUX+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp002.nm.naver.com with ESMTP id 70Hx9F0CQgq0vglQtmWbfQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 06:07:20 -0000
From: sung byeongchan <tjdqudcks0424@naver.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: bound MDSMap name skips by the message end
Date: Thu,  8 Oct 2026 15:07:14 +0900
Message-ID: <20261008060714.182511-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_mdsmap_decode() reads two remote u32 name lengths and advances its
parser cursor without checking that either string remains in the message.
On a 32-bit client, a sufficiently large length can wrap the cursor below
`end`.  The following numerical bounds check then succeeds and dereferences
the wrapped address.

Use ceph_decode_skip_n() for both names so the remaining bytes are checked
before the cursor advances.

The issue produced a page fault in ceph_mdsmap_decode twice on the tested
i386 baseline.  The same frame was rejected without a fault twice after
this change, while a normal MDSMap continued to be accepted.

Fixes: 2f2dc053404f ("ceph: MDS client")
Assisted-by: LLM
Signed-off-by: sung byeongchan <tjdqudcks0424@naver.com>
---
 fs/ceph/mdsmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 53079ef34c3a1..7e0c3cf985b46 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -205,7 +205,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		ceph_decode_need(p, end, sizeof(u64) + sizeof(u32), bad);
 		*p += sizeof(u64);
 		namelen = ceph_decode_32(p);  /* skip mds name */
-		*p += namelen;
+		ceph_decode_skip_n(p, end, namelen, bad);
 
 		ceph_decode_32_safe(p, end, mds, bad);
 		ceph_decode_32_safe(p, end, inc, bad);
@@ -223,7 +223,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		laggy = laggy_since.tv_sec != 0 || laggy_since.tv_nsec != 0;
 		*p += sizeof(u32);
 		ceph_decode_32_safe(p, end, namelen, bad);
-		*p += namelen;
+		ceph_decode_skip_n(p, end, namelen, bad);
 		if (info_v >= 2) {
 			ceph_decode_32_safe(p, end, num_export_targets, bad);
 			export_targets_len = size_mul(num_export_targets,
-- 
2.43.0

