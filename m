From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] ceph: fix ceph_flock()
Date: Tue,  4 Mar 2014 16:05:41 +0800
Message-ID: <1393920342-15913-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8711 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576AbaCDIFs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Mar 2014 03:05:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

VFS does not directly pass the flock's operation to the filesystem's
flock callback directly. It translates the flock's operation to posix
lock's command.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/locks.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ae6d14e..133e006 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -91,10 +91,10 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	dout("ceph_lock, fl_pid:%d", fl->fl_pid);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
-	if (F_SETLKW == cmd)
-		wait = 1;
-	if (F_GETLK == cmd)
+	if (IS_GETLK(cmd))
 		op = CEPH_MDS_OP_GETFILELOCK;
+	else if (IS_SETLKW(cmd))
+		wait = 1;
 
 	if (F_RDLCK == fl->fl_type)
 		lock_cmd = CEPH_LOCK_SHARED;
@@ -131,20 +131,17 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	u8 lock_cmd;
 	int err;
-	u8 wait = 1;
+	u8 wait = 0;
 
 	fl->fl_nspid = get_pid(task_tgid(current));
 	dout("ceph_flock, fl_pid:%d", fl->fl_pid);
 
-	/* set wait bit, then clear it out of cmd*/
-	if (cmd & LOCK_NB)
-		wait = 0;
-	cmd = cmd & (LOCK_SH | LOCK_EX | LOCK_UN);
-	/* set command sequence that Ceph wants to see:
-	   shared lock, exclusive lock, or unlock */
-	if (LOCK_SH == cmd)
+	if (IS_SETLKW(cmd))
+		wait = 1;
+
+	if (F_RDLCK == fl->fl_type)
 		lock_cmd = CEPH_LOCK_SHARED;
-	else if (LOCK_EX == cmd)
+	else if (F_WRLCK == fl->fl_type)
 		lock_cmd = CEPH_LOCK_EXCL;
 	else
 		lock_cmd = CEPH_LOCK_UNLOCK;
-- 
1.8.5.3

