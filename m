Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27A13A86C
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412526; cv=none; b=VAti20/SUFCqPkTb5IwHswMAK27A5S37jx3nm3uu/BwwfRkPgin+d71HzV08cXDEDueWcE3ferLJ3tish9VrcP6H/B/qHE2YpTKFHzAExnzfS8/vKyPaVvYRSjl4uWjDOyiAf8sCGxzvQlJzh0rwAvRQr7sKKzNwaN90LijqfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412526; c=relaxed/simple;
	bh=nM1R/NS4DxlJccV1b2vBzN6xsm+J0g6K3GfI0Vk33R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLE63I58MIKpZmsiOKCFJn0FjEvD18bYhTfk0pefhCZzkJxrjyj/XBJII6mi3bxxtXSqGyeQxoD6AFEL7p5EFXfohHF3rhIV9RlJ8QL0Z7l4rFyL5aIPByBszRblrEb3OGVQZWDWoolTiSrlWnBN+UsaGjkRXq8BrifRcJzFYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=cOOC92KR; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="cOOC92KR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1783412523; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=nM1R/NS4DxlJccV1b2vBzN6xsm+J0g6K3GfI0Vk33R4=;
 b=cOOC92KRk9LRqIg6qhZCbHNvlbEOx2lzR7xHbaYEeWyRBLsEnbgmjB/omcPan5vUWZ6DI
 wQ4bdRnMINH6KNVmlW9a/OQzCnuvO0dJ7c9mhQ/mTYWhKnq9VJwkp6KQkZmVfS9kXuxWd2K
 8fHJh59HBsKV2jfcE8ZCQMXIjbXl/I/JcwHAMjeY8hcUVY+0C0nCTb79eZI6g7RBbAFsrvj
 uFDtn+N8uVl8w7OPq7tnfqz2E8gJubMLpQwWX1rVgtLdhc5mSOcD4aLc1EnhnDlzG9qO0pe
 EPh2vBsWzaDFO1Gbn4/ek6J718XOtvpoSckzFslP9R/8Ly0/PPWdJy56CWNg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id F073E5FB4F;
	Tue,  7 Jul 2026 10:22:02 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id D116E5FAD6;
	Tue,  7 Jul 2026 10:22:02 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Reject osdmaps advertising pools of unsupported types
Date: Tue,  7 Jul 2026 10:21:35 +0200
Message-ID: <20260707082135.3901920-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

osdmaps are received over the network and typically contain information
about existing pools. Information about each pool is decoded in
decode_pool(). A pool is either replicated or erasure coded, which is
encoded in the type field as an 8-bit value. Currently, any value in
this field is treated as valid even though only two values have an
actual meaning. If this field contains a value other than
CEPH_POOL_TYPE_REP or CEPH_POOL_TYPE_EC, a BUG() assertion in
ceph_can_shift_osds() can be triggered subsequently. This happens the
next time calc_target() is called for a request in this pool.

This patch fixes the issue by adding a check that verifies the pool type
directly during decoding and rejecting osdmaps that contain invalid
values. To also account for incremental maps that are updated in-place,
the corrupted pool is removed from the osdmap if its decoding fails.

Fixes: 4f6a7e5ee139 ("ceph: update support for PGID64, PGPOOL3, OSDENC protocol features")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 include/linux/ceph/rados.h | 5 +++++
 net/ceph/osdmap.c          | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 73c3efbec36c..5b5c33845301 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -86,6 +86,11 @@ struct ceph_pg_v1 {
 #define CEPH_POOL_TYPE_RAID4   2 /* never implemented */
 #define CEPH_POOL_TYPE_EC      3
 
+static inline bool ceph_pool_type_is_supported(__u8 type)
+{
+	return type == CEPH_POOL_TYPE_REP || type == CEPH_POOL_TYPE_EC;
+}
+
 /*
  * stable_mod func is used to control number of placement groups.
  * similar to straight-up modulo, but produces a stable mapping as b
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index f8d5621bc767..b243cafe171f 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -818,6 +818,10 @@ static int decode_pool(void **p, void *end, struct ceph_pg_pool_info *pi)
 
 	ceph_decode_need(p, end, 4 + 4 + 4, bad);
 	pi->type = ceph_decode_8(p);
+	if (!ceph_pool_type_is_supported(pi->type)) {
+		pr_warn_ratelimited("got unsupported pool type %u", pi->type);
+		return -EINVAL;
+	}
 	pi->size = ceph_decode_8(p);
 	pi->crush_ruleset = ceph_decode_8(p);
 	pi->object_hash = ceph_decode_8(p);
@@ -1363,8 +1367,10 @@ static int __decode_pools(void **p, void *end, struct ceph_osdmap *map,
 		}
 
 		ret = decode_pool(p, end, pi);
-		if (ret)
+		if (ret) {
+			erase_pg_pool(&map->pg_pools, pi);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.47.3

