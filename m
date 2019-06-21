From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 2/2] ceph: fix return of ceph_vxattrcb_layout
Date: Fri, 21 Jun 2019 10:18:33 -0400
Message-ID: <20190621141833.17551-3-jlayton@kernel.org>
References: <20190621141833.17551-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621141833.17551-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com, joe@perches.com, geert+renesas@glider.be, andriy.shevchenko@linux.intel.com
List-Id: ceph-devel.vger.kernel.org

Currently it returns -ERANGE if it thinks that the buffer won't fit, but
the function returns size_t which is unsigned. Fix it to just return the
length in this case like the other xattrs do, and rely on the caller to
handle the case where it won't fit in the destination buffer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/xattr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 359d3cbbb37b..23687e3819f5 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -62,8 +62,7 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	const char *pool_name;
 	const char *ns_field = " pool_namespace=";
 	char buf[128];
-	size_t len, total_len = 0;
-	int ret;
+	size_t ret, len, total_len = 0;
 
 	pool_ns = ceph_try_get_string(ci->i_layout.pool_ns);
 
@@ -87,11 +86,8 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	if (pool_ns)
 		total_len += strlen(ns_field) + pool_ns->len;
 
-	if (!size) {
-		ret = total_len;
-	} else if (total_len > size) {
-		ret = -ERANGE;
-	} else {
+	ret = total_len;
+	if (size >= total_len) {
 		memcpy(val, buf, len);
 		ret = len;
 		if (pool_name) {
-- 
2.21.0
