From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 1/2] ceph fscache: Introduce a routine for uncaching single no data page from fscache
Date: Thu, 19 Dec 2013 06:03:48 -0800
Message-ID: <65d023ce80c02fd37fcd2e88dc9c01f4959c574c.1387461299.git.liwang@ubuntukylin.com>
References: <cover.1387461299.git.liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1387461299.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1387461299.git.liwang@ubuntukylin.com>
References: <cover.1387461299.git.liwang@ubuntukylin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org


Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/cache.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index ba94940..da95f61 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -67,6 +67,14 @@ static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
 	return fscache_maybe_release_page(ci->fscache, page, gfp);
 }
 
+static inline void ceph_fscache_readpage_cancel(struct inode *inode,
+						struct page *page)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	if (fscache_cookie_valid(ci->fscache) && PageFsCache(page))
+		__fscache_uncache_page(ci->fscache, page);
+}
+
 static inline void ceph_fscache_readpages_cancel(struct inode *inode,
 						 struct list_head *pages)
 {
@@ -145,6 +153,11 @@ static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
 	return 1;
 }
 
+static inline void ceph_fscache_readpage_cancel(struct inode *inode,
+						struct page *page)
+{
+}
+
 static inline void ceph_fscache_readpages_cancel(struct inode *inode,
 						 struct list_head *pages)
 {
-- 
1.7.9.5
