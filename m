From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: check buffer size in ceph_vxattrcb_layout()
Date: Mon, 24 Mar 2014 13:32:15 +0800
Message-ID: <1395639135-12840-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59471 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbaCXFc3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Mar 2014 01:32:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/xattr.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 2dbd668..28549d5 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -64,32 +64,48 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_inode_info *ci)
 }
 
 static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
-					size_t size)
+				   size_t size)
 {
 	int ret;
 	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	s64 pool = ceph_file_layout_pg_pool(ci->i_layout);
 	const char *pool_name;
+	char buf[128];
 
 	dout("ceph_vxattrcb_layout %p\n", &ci->vfs_inode);
 	down_read(&osdc->map_sem);
 	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, pool);
-	if (pool_name)
-		ret = snprintf(val, size,
-		"stripe_unit=%lld stripe_count=%lld object_size=%lld pool=%s",
+	if (pool_name) {
+		size_t len = strlen(pool_name);
+		ret = snprintf(buf, sizeof(buf),
+		"stripe_unit=%lld stripe_count=%lld object_size=%lld pool=",
 		(unsigned long long)ceph_file_layout_su(ci->i_layout),
 		(unsigned long long)ceph_file_layout_stripe_count(ci->i_layout),
-	        (unsigned long long)ceph_file_layout_object_size(ci->i_layout),
-		pool_name);
-	else
-		ret = snprintf(val, size,
+	        (unsigned long long)ceph_file_layout_object_size(ci->i_layout));
+		if (!size) {
+			ret += len;
+		} else if (ret + len > size) {
+			ret = -ERANGE;
+		} else {
+			memcpy(val, buf, ret);
+			memcpy(val + ret, pool_name, len);
+			ret += len;
+		}
+	} else {
+		ret = snprintf(buf, sizeof(buf),
 		"stripe_unit=%lld stripe_count=%lld object_size=%lld pool=%lld",
 		(unsigned long long)ceph_file_layout_su(ci->i_layout),
 		(unsigned long long)ceph_file_layout_stripe_count(ci->i_layout),
 	        (unsigned long long)ceph_file_layout_object_size(ci->i_layout),
 		(unsigned long long)pool);
-
+		if (size) {
+			if (ret <= size)
+				memcpy(val, buf, ret);
+			else
+				ret = -ERANGE;
+		}
+	}
 	up_read(&osdc->map_sem);
 	return ret;
 }
-- 
1.8.5.3

