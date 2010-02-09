From: Sage Weil <sage@newdream.net>
Subject: [PATCH] ceph: fix up async vmtruncate race
Date: Tue,  9 Feb 2010 15:26:08 -0800
Message-ID: <1265757968-29999-1-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sf.net
Cc: Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

Use a helper to ensure that we properly maintain the i_truncate_pending
counter when we queue an async truncation.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/caps.c  |    4 +---
 fs/ceph/inode.c |   25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 7f4841c..726f7c8 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2479,9 +2479,7 @@ static void handle_cap_trunc(struct inode *inode,
 	spin_unlock(&inode->i_lock);
 
 	if (queue_trunc)
-		if (queue_work(ceph_client(inode->i_sb)->trunc_wq,
-			       &ci->i_vmtruncate_work))
-			igrab(inode);
+		__ceph_queue_vmtruncate(inode);
 }
 
 /*
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e75847d..37f9be8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -675,9 +675,7 @@ no_change:
 
 	/* queue truncate if we saw i_size decrease */
 	if (queue_trunc)
-		if (queue_work(ceph_client(inode->i_sb)->trunc_wq,
-			       &ci->i_vmtruncate_work))
-			igrab(inode);
+		__ceph_queue_vmtruncate(inode);
 
 	/* populate frag tree */
 	/* FIXME: move me up, if/when version reflects fragtree changes */
@@ -1321,6 +1319,27 @@ void ceph_vmtruncate_work(struct work_struct *work)
 }
 
 /*
+ * Queue an async vmtruncate.  If we fail to queue work, decrement the
+ * pending counter (which the caller incremented when we decided to
+ * try to queue).
+ */
+void __ceph_queue_vmtruncate(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	if (queue_work(ceph_client(inode->i_sb)->trunc_wq,
+		       &ci->i_vmtruncate_work)) {
+		igrab(inode);
+	} else {
+		spin_lock(&inode->i_lock);
+		ci->i_truncate_pending--;
+		spin_unlock(&inode->i_lock);
+		dout("__ceph_queue_vmtruncate failed to queue, pending=%d\n",
+		     ci->i_truncate_pending);
+	}
+}
+
+/*
  * called with i_mutex held.
  *
  * Make sure any pending truncation is applied before doing anything
-- 
1.5.6.5


------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
