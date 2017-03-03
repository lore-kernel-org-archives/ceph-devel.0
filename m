From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 2/2] fs, ceph: convert ceph_cap_snap.nref from atomic_t to refcount_t
Date: Fri,  3 Mar 2017 11:15:07 +0200
Message-ID: <1488532507-27863-3-git-send-email-elena.reshetova@intel.com>
References: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: ceph-devel.vger.kernel.org

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/ceph/caps.c  | 4 ++--
 fs/ceph/snap.c  | 2 +-
 fs/ceph/super.h | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index cd966f2..99a77c2c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1389,7 +1389,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		first_tid = cf->tid + 1;
 
 		capsnap = container_of(cf, struct ceph_cap_snap, cap_flush);
-		atomic_inc(&capsnap->nref);
+		refcount_inc(&capsnap->nref);
 		spin_unlock(&ci->i_ceph_lock);
 
 		dout("__flush_snaps %p capsnap %p tid %llu %s\n",
@@ -2202,7 +2202,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			     inode, capsnap, cf->tid,
 			     ceph_cap_string(capsnap->dirty));
 
-			atomic_inc(&capsnap->nref);
+			refcount_inc(&capsnap->nref);
 			spin_unlock(&ci->i_ceph_lock);
 
 			ret = __send_flush_snap(inode, session, capsnap, cap->mseq,
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 8f8b41c..dab5d67 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -519,7 +519,7 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	     capsnap->need_flush ? "" : "no_flush");
 	ihold(inode);
 
-	atomic_set(&capsnap->nref, 1);
+	refcount_set(&capsnap->nref, 1);
 	INIT_LIST_HEAD(&capsnap->ci_item);
 
 	capsnap->follows = old_snapc->seq;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index fe6b9cf..c68e6a0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -14,6 +14,7 @@
 #include <linux/writeback.h>
 #include <linux/slab.h>
 #include <linux/posix_acl.h>
+#include <linux/refcount.h>
 
 #include <linux/ceph/libceph.h>
 
@@ -162,7 +163,7 @@ struct ceph_cap_flush {
  * data before flushing the snapped state (tracked here) back to the MDS.
  */
 struct ceph_cap_snap {
-	atomic_t nref;
+	refcount_t nref;
 	struct list_head ci_item;
 
 	struct ceph_cap_flush cap_flush;
@@ -191,7 +192,7 @@ struct ceph_cap_snap {
 
 static inline void ceph_put_cap_snap(struct ceph_cap_snap *capsnap)
 {
-	if (atomic_dec_and_test(&capsnap->nref)) {
+	if (refcount_dec_and_test(&capsnap->nref)) {
 		if (capsnap->xattr_blob)
 			ceph_buffer_put(capsnap->xattr_blob);
 		kfree(capsnap);
-- 
2.7.4
