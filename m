From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 1/3] Ceph fscache: Add an interface to synchronize object store limit
Date: Thu, 26 Dec 2013 06:29:26 -0800
Message-ID: <ac5d506a62b697c2f79ac916ef4030290f94956b.1388066937.git.liwang@ubuntukylin.com>
References: <cover.1388066937.git.liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1388066937.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1388066937.git.liwang@ubuntukylin.com>
References: <cover.1388066937.git.liwang@ubuntukylin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Min Chen <minchen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

From: Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Add an interface to explicitly synchronize object->store_limit[_l]
with inode->i_size

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/cache.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index ba94940..262106b 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -48,6 +48,12 @@ void ceph_readpage_to_fscache(struct inode *inode, struct page *page);
 void ceph_invalidate_fscache_page(struct inode* inode, struct page *page);
 void ceph_queue_revalidate(struct inode *inode);
 
+static inline void ceph_fscache_update_objectsize(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	fscache_attr_changed(ci->fscache);
+}
+
 static inline void ceph_fscache_invalidate(struct inode *inode)
 {
 	fscache_invalidate(ceph_inode(inode)->fscache);
@@ -127,6 +133,10 @@ static inline void ceph_readpage_to_fscache(struct inode *inode,
 {
 }
 
+static inline void ceph_fscache_update_objectsize(struct inode *inode)
+{
+}
+
 static inline void ceph_fscache_invalidate(struct inode *inode)
 {
 }
-- 
1.7.9.5
