Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF273D967A
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966239; cv=none; b=uBPHRlNYpTcMvj3TiQNquKgtCH4hX3WKnDQUq76piJhfzSsJ6466VUNRoTmVCHDQI5u13rVs8sZfIEFoFqmlh/oGk5vsAB8E5w8eogYhQRTgAhaxHhhFktqar2nJyjJyrqmcxgpFT2dymCpGxqcXCCVIwTHBgjbdNC+w/7QXAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966239; c=relaxed/simple;
	bh=0N0NwnJ5Pg25F/ZtRCZocSLgQdAE9fwunZiiofJVc1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lr2cJ0SQlnAq4NNzMvnWEdV/bpa35uYuTkdaI+6oydicade7Dr9AxzHYO0yG6j/XADJMTMYL3w1S8G7T6sj5pk71LTVbLTV4laH8UxAvHFycf2rCDMdeMnCkBn1TiP/V6EKTdWp1qTgVmImmSBeopSNrJItexEH/JwNXo2A6H/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=dwzNC7F4; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="dwzNC7F4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1788966235; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=0N0NwnJ5Pg25F/ZtRCZocSLgQdAE9fwunZiiofJVc1o=;
 b=dwzNC7F49PijEbR5HpQ54XKq+8O3e0Sc/hoa+9sy7AFV69nXlHakgPkTFMhIXl94/bUiK
 Ez55VeqlU9J80Yp1n12hIXB4jUDMROQLEmFKrqa2XUay0jse0+/lcR0WJMvLwnhBue3cNuL
 dlZqSz91MNfb1u1mP+zVOZhbiP8e5Z/i8erM0d49S5OaXMir7tn+B0G95J3e3GfnLZG/zx8
 0egB/fMAyNVIZHAtAsjgS/5+hKj6/J1z3cihX9EL6DG/NujyQy0WA06eqeWdIgVn4IYPXcS
 uRXNnzCsWLfuiZ4Pl2GMxNTjT7qndjC4GalSyIXZJHqNhdCuio5goVxS3QdQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id F0F235FC75;
	Wed,  9 Sep 2026 17:03:54 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DA5865FB4B;
	Wed,  9 Sep 2026 17:03:54 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Fix multiple unsafe decodes in ceph_oloc_decode()
Date: Wed,  9 Sep 2026 17:03:53 +0200
Message-ID: <20260909150353.1164805-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_oloc_decode handles unchecked data received over the network from
an OSD. Currently, there are multiple decode operations that aren't
covered by any bounds check. Decoding these fields can therefore result
in out-of-bounds reads if a corrupted message is received.

This patch fixes the issue by adding bounds checks covering all
previously uncovered decode operations.

Fixes: 205ee1187a67 ("libceph: follow redirect replies from osds")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osd_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 95219e16519e..c9fb1f1ff166 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3570,6 +3570,7 @@ static int ceph_oloc_decode(void **p, void *end,
 	ceph_decode_need(p, end, len, e_inval);
 	struct_end = *p + len;
 
+	ceph_decode_need(p, end, 8 + 4 + 4, e_inval);
 	oloc->pool = ceph_decode_64(p);
 	*p += 4; /* skip preferred */
 
@@ -3582,7 +3583,7 @@ static int ceph_oloc_decode(void **p, void *end,
 	if (struct_v >= 5) {
 		bool changed = false;
 
-		len = ceph_decode_32(p);
+		ceph_decode_32_safe(p, end, len, e_inval);
 		if (len > 0) {
 			ceph_decode_need(p, end, len, e_inval);
 			if (!oloc->pool_ns ||
@@ -3601,6 +3602,7 @@ static int ceph_oloc_decode(void **p, void *end,
 	}
 
 	if (struct_v >= 6) {
+		ceph_decode_need(p, end, sizeof(s64), e_inval);
 		s64 hash = ceph_decode_64(p);
 		if (hash != -1) {
 			pr_warn("ceph_object_locator::hash is set\n");
-- 
2.47.3

