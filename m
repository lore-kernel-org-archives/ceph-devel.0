From: Cheng Renquan <crquan@gmail.com>
Subject: [PATCH] ceph: some documentations fixes
Date: Mon, 29 Mar 2010 19:05:57 +0800
Message-ID: <1269860757-9225-1-git-send-email-crquan@gmail.com>
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
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

new documentation should have an entry in the 00-INDEX

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 Documentation/filesystems/00-INDEX |    2 ++
 Documentation/filesystems/ceph.txt |    6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
index 3bae418..4303614 100644
--- a/Documentation/filesystems/00-INDEX
+++ b/Documentation/filesystems/00-INDEX
@@ -16,6 +16,8 @@ befs.txt
 	- information about the BeOS filesystem for Linux.
 bfs.txt
 	- info for the SCO UnixWare Boot Filesystem (BFS).
+ceph.txt
+	- info for the Ceph Distributed File System
 cifs.txt
 	- description of the CIFS filesystem.
 coda.txt
diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.txt
index 523fdf0..a77073f 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.txt
@@ -8,7 +8,7 @@ Basic features include:
 
  * POSIX semantics
  * Seamless scaling from 1 to many thousands of nodes
- * High availability and reliability.  No single points of failure.
+ * High availability and reliability.  No single point of failure.
  * N-way replication of data across storage nodes
  * Fast recovery from node failures
  * Automatic rebalancing of data on node addition/removal
@@ -94,7 +94,7 @@ Mount Options
 
   wsize=X
 	Specify the maximum write size in bytes.  By default there is no
-	maximu.  Ceph will normally size writes based on the file stripe
+	maximum.  Ceph will normally size writes based on the file stripe
 	size.
 
   rsize=X
@@ -133,7 +133,7 @@ For more information on Ceph, see the home page at
 	http://ceph.newdream.net/
 
 The Linux kernel client source tree is available at
-	git://ceph.newdream.net/linux-ceph-client.git
+	git://ceph.newdream.net/ceph-client.git
 
 and the source for the full system is at
 	git://ceph.newdream.net/ceph.git
-- 
1.7.0.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
