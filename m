From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] ceph: Fix warnings
Date: Wed, 25 Aug 2010 13:26:32 +0100
Message-ID: <20100825122610.17899.91326.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21208 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab0HYNGL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Aug 2010 09:06:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@newdream.net

Just scrubbing some warnings so I can see real problem ones in the build
noise. For 32bit we need to coax gcc politely into believing we really
honestly intend to the casts. Using (u64)(unsigned long) means we cast from
a pointer to a type of the right size and then extend it. This stops the
warning spew.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 fs/ceph/locks.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)


diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ae85af0..4c7b090 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -82,7 +82,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		length = fl->fl_end - fl->fl_start + 1;
 
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, file,
-				(u64)fl->fl_pid, (u64)fl->fl_nspid,
+				(u64)fl->fl_pid, 
+				(u64)(unsigned long)fl->fl_nspid,
 				lock_cmd, fl->fl_start,
 				length, wait);
 	if (!err) {
@@ -92,7 +93,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 			/* undo! This should only happen if the kernel detects
 			 * local deadlock. */
 			ceph_lock_message(CEPH_LOCK_FCNTL, op, file,
-					  (u64)fl->fl_pid, (u64)fl->fl_nspid,
+					  (u64)fl->fl_pid,
+					  (u64)(unsigned long)fl->fl_nspid,
 					  CEPH_LOCK_UNLOCK, fl->fl_start,
 					  length, 0);
 			dout("got %d on posix_lock_file, undid lock", err);
@@ -132,7 +134,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 		length = fl->fl_end - fl->fl_start + 1;
 
 	err = ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
-				file, (u64)fl->fl_pid, (u64)fl->fl_nspid,
+				file, (u64)fl->fl_pid, 
+				(u64)(unsigned long)fl->fl_nspid,
 				lock_cmd, fl->fl_start,
 				length, wait);
 	if (!err) {
@@ -141,7 +144,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 			ceph_lock_message(CEPH_LOCK_FLOCK,
 					  CEPH_MDS_OP_SETFILELOCK,
 					  file, (u64)fl->fl_pid,
-					  (u64)fl->fl_nspid,
+					  (u64)(unsigned long)fl->fl_nspid,
 					  CEPH_LOCK_UNLOCK, fl->fl_start,
 					  length, 0);
 			dout("got %d on flock_lock_file_wait, undid lock", err);
@@ -235,7 +238,8 @@ int lock_to_ceph_filelock(struct file_lock *lock,
 	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
 	cephlock->client = cpu_to_le64(0);
 	cephlock->pid = cpu_to_le64(lock->fl_pid);
-	cephlock->pid_namespace = cpu_to_le64((u64)lock->fl_nspid);
+	cephlock->pid_namespace = 
+	        cpu_to_le64((u64)(unsigned long)lock->fl_nspid);
 
 	switch (lock->fl_type) {
 	case F_RDLCK:

