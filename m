From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/6] ceph: introduce ceph_fill_fragtree()
Date: Fri, 18 Apr 2014 22:48:41 +0800
Message-ID: <1397832522-9557-5-git-send-email-zheng.z.yan@intel.com>
References: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65054 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202AbaDROtR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Apr 2014 10:49:17 -0400
In-Reply-To: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Move the code that update the i_fragtree into a separate function.
Also add simple probabilistic test to decide whether the i_fragtree
should be updated

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 129 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 45 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 65462ad..80528ff 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -10,6 +10,7 @@
 #include <linux/writeback.h>
 #include <linux/vmalloc.h>
 #include <linux/posix_acl.h>
+#include <linux/random.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -179,9 +180,8 @@ struct ceph_inode_frag *__ceph_find_frag(struct ceph_inode_info *ci, u32 f)
  * specified, copy the frag delegation info to the caller if
  * it is present.
  */
-u32 ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
-		     struct ceph_inode_frag *pfrag,
-		     int *found)
+static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
+			      struct ceph_inode_frag *pfrag, int *found)
 {
 	u32 t = ceph_frag_make(0, 0);
 	struct ceph_inode_frag *frag;
@@ -191,7 +191,6 @@ u32 ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 	if (found)
 		*found = 0;
 
-	mutex_lock(&ci->i_fragtree_mutex);
 	while (1) {
 		WARN_ON(!ceph_frag_contains_value(t, v));
 		frag = __ceph_find_frag(ci, t);
@@ -220,10 +219,19 @@ u32 ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 	}
 	dout("choose_frag(%x) = %x\n", v, t);
 
-	mutex_unlock(&ci->i_fragtree_mutex);
 	return t;
 }
 
+u32 ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
+		     struct ceph_inode_frag *pfrag, int *found)
+{
+	u32 ret;
+	mutex_lock(&ci->i_fragtree_mutex);
+	ret = __ceph_choose_frag(ci, v, pfrag, found);
+	mutex_unlock(&ci->i_fragtree_mutex);
+	return ret;
+}
+
 /*
  * Process dirfrag (delegation) info from the mds.  Include leaf
  * fragment in tree ONLY if ndist > 0.  Otherwise, only
@@ -286,6 +294,75 @@ out:
 	return err;
 }
 
+static int ceph_fill_fragtree(struct inode *inode,
+			      struct ceph_frag_tree_head *fragtree,
+			      struct ceph_mds_reply_dirfrag *dirinfo)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_inode_frag *frag;
+	struct rb_node *rb_node;
+	int i;
+	u32 id, nsplits;
+	bool update = false;
+
+	mutex_lock(&ci->i_fragtree_mutex);
+	nsplits = le32_to_cpu(fragtree->nsplits);
+	if (nsplits) {
+		i = prandom_u32() % nsplits;
+		id = le32_to_cpu(fragtree->splits[i].frag);
+		if (!__ceph_find_frag(ci, id))
+			update = true;
+	} else if (!RB_EMPTY_ROOT(&ci->i_fragtree)) {
+		rb_node = rb_first(&ci->i_fragtree);
+		frag = rb_entry(rb_node, struct ceph_inode_frag, node);
+		if (frag->frag != ceph_frag_make(0, 0) || rb_next(rb_node))
+			update = true;
+	}
+	if (!update && dirinfo) {
+		id = le32_to_cpu(dirinfo->frag);
+		if (id != __ceph_choose_frag(ci, id, NULL, NULL))
+			update = true;
+	}
+	if (!update)
+		goto out_unlock;
+
+	dout("fill_fragtree %llx.%llx\n", ceph_vinop(inode));
+	rb_node = rb_first(&ci->i_fragtree);
+	for (i = 0; i < nsplits; i++) {
+		id = le32_to_cpu(fragtree->splits[i].frag);
+		frag = NULL;
+		while (rb_node) {
+			frag = rb_entry(rb_node, struct ceph_inode_frag, node);
+			if (ceph_frag_compare(frag->frag, id) >= 0) {
+				if (frag->frag != id)
+					frag = NULL;
+				else
+					rb_node = rb_next(rb_node);
+				break;
+			}
+			rb_node = rb_next(rb_node);
+			rb_erase(&frag->node, &ci->i_fragtree);
+			kfree(frag);
+			frag = NULL;
+		}
+		if (!frag) {
+			frag = __get_or_create_frag(ci, id);
+			if (IS_ERR(frag))
+				continue;
+		}
+		frag->split_by = le32_to_cpu(fragtree->splits[i].by);
+		dout(" frag %x split by %d\n", frag->frag, frag->split_by);
+	}
+	while (rb_node) {
+		frag = rb_entry(rb_node, struct ceph_inode_frag, node);
+		rb_node = rb_next(rb_node);
+		rb_erase(&frag->node, &ci->i_fragtree);
+		kfree(frag);
+	}
+out_unlock:
+	mutex_unlock(&ci->i_fragtree_mutex);
+	return 0;
+}
 
 /*
  * initialize a newly allocated inode.
@@ -584,12 +661,8 @@ static int fill_inode(struct inode *inode,
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct ceph_mds_reply_inode *info = iinfo->in;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	int i;
 	int issued = 0, implemented, new_issued;
 	struct timespec mtime, atime, ctime;
-	u32 nsplits;
-	struct ceph_inode_frag *frag;
-	struct rb_node *rb_node;
 	struct ceph_buffer *xattr_blob = NULL;
 	struct ceph_cap *new_cap = NULL;
 	int err = 0;
@@ -804,42 +877,8 @@ static int fill_inode(struct inode *inode,
 		ceph_queue_vmtruncate(inode);
 
 	/* populate frag tree */
-	/* FIXME: move me up, if/when version reflects fragtree changes */
-	nsplits = le32_to_cpu(info->fragtree.nsplits);
-	mutex_lock(&ci->i_fragtree_mutex);
-	rb_node = rb_first(&ci->i_fragtree);
-	for (i = 0; i < nsplits; i++) {
-		u32 id = le32_to_cpu(info->fragtree.splits[i].frag);
-		frag = NULL;
-		while (rb_node) {
-			frag = rb_entry(rb_node, struct ceph_inode_frag, node);
-			if (ceph_frag_compare(frag->frag, id) >= 0) {
-				if (frag->frag != id)
-					frag = NULL;
-				else
-					rb_node = rb_next(rb_node);
-				break;
-			}
-			rb_node = rb_next(rb_node);
-			rb_erase(&frag->node, &ci->i_fragtree);
-			kfree(frag);
-			frag = NULL;
-		}
-		if (!frag) {
-			frag = __get_or_create_frag(ci, id);
-			if (IS_ERR(frag))
-				continue;
-		}
-		frag->split_by = le32_to_cpu(info->fragtree.splits[i].by);
-		dout(" frag %x split by %d\n", frag->frag, frag->split_by);
-	}
-	while (rb_node) {
-		frag = rb_entry(rb_node, struct ceph_inode_frag, node);
-		rb_node = rb_next(rb_node);
-		rb_erase(&frag->node, &ci->i_fragtree);
-		kfree(frag);
-	}
-	mutex_unlock(&ci->i_fragtree_mutex);
+	if (S_ISDIR(inode->i_mode))
+		ceph_fill_fragtree(inode, &info->fragtree, dirinfo);
 
 	/* update delegation info? */
 	if (dirinfo)
-- 
1.9.0

