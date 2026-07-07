Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1CB221FD4
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420288; cv=none; b=mk7RfhGhpYxV88CSRs4+mwhIj2klxzsAe6QeXOuZ7bo/EgwqSVVS+ueATJT5WCToVFxiiXDJ8hs2mvRF60rGtNaZyrD487UJxXJtwP/9GBJkprO9GNwRbjvzPlriNIx2BGBeykVEQStu8y1S7Y1+4AYDLgtzdmie6Dkmcgf3Ml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420288; c=relaxed/simple;
	bh=Juojjzbn1dejT4fCnt2BXq46Kzp2k9vxL9rr92cH3yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACjGhm5KAt+aozk9DxzX/DIJ0u+rrqHVkhicDNcnQDOTE46SYTJxMLrbdUtpOf4fRswl0NHUk4/yCF5zcqQkKROkA41UxfwdydKMZOPUEjqRiB6zzkW1zima6yMrEySuVk/2eGE2ZATWlbhSzs/TiewvHVnLBewBK7okTvtZZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=PeIkycZq; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="PeIkycZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1783420283; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=Juojjzbn1dejT4fCnt2BXq46Kzp2k9vxL9rr92cH3yk=;
 b=PeIkycZqhd7tNCZ9v6LBqY2sNn6sPWSeNW+KrwB+i6GgHpst6K0PF3LNmt6CXcIVraMyl
 JiA0GJYbbAtq2H/CqYG6o8yf9YYtIAjwtuwXJYTyzFmLzH2QTRHZkqnakSrTs0XpQokodBc
 llKzvMutlihTAwEC4MTux1s9Sx+Tp92lMsF21iGahkLXyogGW/FMsDVWefUqGnGiUlFl74a
 b6BLFAoF0jiaDIdntF4XETSKDvlDWDukEgu7MZb+ObfLkGA13cOaw5Am+rnQ214lRBIK+xF
 YiBAW5ip9tjJSry8tEtuAvZEGjpRfq3dZwIz1RdZ26334SOTStJ5mpoNiCgQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id AB2CA5FCA1;
	Tue,  7 Jul 2026 12:31:23 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 734655FAE7;
	Tue,  7 Jul 2026 12:31:23 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Reject osdmaps advertising pools of unsupported types
Date: Tue,  7 Jul 2026 12:31:19 +0200
Message-ID: <20260707103119.3909051-1-raphael.zimmer@tu-ilmenau.de>
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
index f8d5621bc767..0ad2e4801294 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -818,6 +818,10 @@ static int decode_pool(void **p, void *end, struct ceph_pg_pool_info *pi)
 
 	ceph_decode_need(p, end, 4 + 4 + 4, bad);
 	pi->type = ceph_decode_8(p);
+	if (!ceph_pool_type_is_supported(pi->type)) {
+		pr_warn_ratelimited("got unsupported pool type %u\n", pi->type);
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
+			__remove_pg_pool(&map->pg_pools, pi);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.47.3

