From: Jia Yang <jiayang5@huawei.com>
Subject: [PATCH V2] fs:ceph: Remove unused variables in ceph_mdsmap_decode()
Date: Wed, 22 Jul 2020 21:46:04 +0800
Message-ID: <20200722134604.3026-1-jiayang5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbgGVNjN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:39:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, jiayang5@huawei.com

Fix build warnings:

fs/ceph/mdsmap.c: In function ‘ceph_mdsmap_decode’:
fs/ceph/mdsmap.c:192:7: warning:
variable ‘info_cv’ set but not used [-Wunused-but-set-variable]
fs/ceph/mdsmap.c:177:7: warning:
variable ‘state_seq’ set but not used [-Wunused-but-set-variable]
fs/ceph/mdsmap.c:123:15: warning:
variable ‘mdsmap_cv’ set but not used [-Wunused-but-set-variable]

Use ceph_decode_skip_* instead of ceph_decode_*, because p is
increased in ceph_decode_*.

Signed-off-by: Jia Yang <jiayang5@huawei.com>
---
 fs/ceph/mdsmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 889627817e52..7455ba83822a 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -120,7 +120,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 	const void *start = *p;
 	int i, j, n;
 	int err;
-	u8 mdsmap_v, mdsmap_cv;
+	u8 mdsmap_v;
 	u16 mdsmap_ev;
 
 	m = kzalloc(sizeof(*m), GFP_NOFS);
@@ -129,7 +129,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 
 	ceph_decode_need(p, end, 1 + 1, bad);
 	mdsmap_v = ceph_decode_8(p);
-	mdsmap_cv = ceph_decode_8(p);
+	ceph_decode_skip_8(p, end, bad);
 	if (mdsmap_v >= 4) {
 	       u32 mdsmap_len;
 	       ceph_decode_32_safe(p, end, mdsmap_len, bad);
@@ -174,7 +174,6 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 		u64 global_id;
 		u32 namelen;
 		s32 mds, inc, state;
-		u64 state_seq;
 		u8 info_v;
 		void *info_end = NULL;
 		struct ceph_entity_addr addr;
@@ -189,9 +188,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 		info_v= ceph_decode_8(p);
 		if (info_v >= 4) {
 			u32 info_len;
-			u8 info_cv;
 			ceph_decode_need(p, end, 1 + sizeof(u32), bad);
-			info_cv = ceph_decode_8(p);
+			ceph_decode_skip_8(p, end, bad);
 			info_len = ceph_decode_32(p);
 			info_end = *p + info_len;
 			if (info_end > end)
@@ -210,7 +208,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 		mds = ceph_decode_32(p);
 		inc = ceph_decode_32(p);
 		state = ceph_decode_32(p);
-		state_seq = ceph_decode_64(p);
+		ceph_decode_skip_64(p, end, bad);
 		err = ceph_decode_entity_addr(p, end, &addr);
 		if (err)
 			goto corrupt;
-- 
2.26.0.106.g9fadedd
