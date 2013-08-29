From: Sage Weil <sage@inktank.com>
Subject: [PATCH] libceph: use pg_num_mask instead of pgp_num_mask for pg.seed calc
Date: Wed, 28 Aug 2013 17:19:06 -0700
Message-ID: <1377735546-8732-1-git-send-email-sage@inktank.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Fix a typo that used the wrong bitmask for the pg.seed calculation.  This
is normally unnoticed because in most cases pg_num == pgp_num.  It is, however,
a bug that is easily corrected.

CC: stable@vger.kernel.org
Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 603ddd9..dbd9a47 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1129,7 +1129,7 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 
 	/* pg_temp? */
 	pgid.seed = ceph_stable_mod(pgid.seed, pool->pg_num,
-				    pool->pgp_num_mask);
+				    pool->pg_num_mask);
 	pg = __lookup_pg_mapping(&osdmap->pg_temp, pgid);
 	if (pg) {
 		*num = pg->len;
-- 
1.8.1.2
