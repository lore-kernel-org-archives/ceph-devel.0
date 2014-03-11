From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH v3] ceph: use fl->fl_file as owner identifier of flock and posix lock
Date: Tue, 11 Mar 2014 09:47:01 +0800
Message-ID: <1394502421-9707-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45917 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbaCKBrD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Mar 2014 21:47:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

flock and posix lock should use fl->fl_file instead of process ID
as owner identifier. (posix lock uses fl->fl_owner. fl->fl_owner
is usually equal to fl->fl_file, but it also can be a customized
value). The process ID of who holds the lock is just for F_GETLK
fcntl(2).

The fix is rename the 'pid' fields of struct ceph_mds_request_args
and struct ceph_filelock to 'owner', rename 'pid_namespace' fields
to 'pid'. Assign fl->fl_file to the 'owner' field of lock messages.
We also set the most significant bit of the 'owner' field. MDS can
use that bit to distinguish between old and new clients.

The MDS counterpart of this patch modifies the flock code to not
take the 'pid_namespace' into consideration when checking conflict
locks.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/locks.c              | 61 +++++++++++++++++++++++++++++---------------
 fs/ceph/super.c              |  1 +
 fs/ceph/super.h              |  1 +
 include/linux/ceph/ceph_fs.h |  4 +--
 4 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index f91a569a..8dbae5d 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -2,11 +2,31 @@
 
 #include <linux/file.h>
 #include <linux/namei.h>
+#include <linux/random.h>
 
 #include "super.h"
 #include "mds_client.h"
 #include <linux/ceph/pagelist.h>
 
+static u64 lock_secret;
+
+static inline u64 secure_addr(void *addr)
+{
+	u64 v = (lock_secret ^ (u64)(unsigned long)addr);
+	/*
+	 * Set the most significant bit, so that MDS knows the 'owner'
+	 * is sufficient to identify the owner of lock. (old code uses
+	 * both 'owner' and 'pid')
+	 */
+	v |= (1ULL << 63);
+	return v;
+}
+
+void __init ceph_flock_init(void)
+{
+	get_random_bytes(&lock_secret, sizeof(lock_secret));
+}
+
 /**
  * Implement fcntl and flock locking functions.
  */
@@ -14,11 +34,11 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct file *file,
 			     int cmd, u8 wait, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
-	struct ceph_mds_client *mdsc =
-		ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
 	struct ceph_mds_request *req;
 	int err;
 	u64 length = 0;
+	u64 owner;
 
 	req = ceph_mdsc_create_request(mdsc, operation, USE_AUTH_MDS);
 	if (IS_ERR(req))
@@ -32,25 +52,27 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct file *file,
 	else
 		length = fl->fl_end - fl->fl_start + 1;
 
-	dout("ceph_lock_message: rule: %d, op: %d, pid: %llu, start: %llu, "
-	     "length: %llu, wait: %d, type: %d", (int)lock_type,
-	     (int)operation, (u64)fl->fl_pid, fl->fl_start,
-	     length, wait, fl->fl_type);
+	if (lock_type == CEPH_LOCK_FCNTL)
+		owner = secure_addr(fl->fl_owner);
+	else
+		owner = secure_addr(fl->fl_file);
+
+	dout("ceph_lock_message: rule: %d, op: %d, owner: %llx, pid: %llu, "
+	     "start: %llu, length: %llu, wait: %d, type: %d", (int)lock_type,
+	     (int)operation, owner, (u64)fl->fl_pid, fl->fl_start, length,
+	     wait, fl->fl_type);
 
 	req->r_args.filelock_change.rule = lock_type;
 	req->r_args.filelock_change.type = cmd;
+	req->r_args.filelock_change.owner = cpu_to_le64(owner);
 	req->r_args.filelock_change.pid = cpu_to_le64((u64)fl->fl_pid);
-	/* This should be adjusted, but I'm not sure if
-	   namespaces actually get id numbers*/
-	req->r_args.filelock_change.pid_namespace =
-		cpu_to_le64((u64)(unsigned long)fl->fl_nspid);
 	req->r_args.filelock_change.start = cpu_to_le64(fl->fl_start);
 	req->r_args.filelock_change.length = cpu_to_le64(length);
 	req->r_args.filelock_change.wait = wait;
 
 	err = ceph_mdsc_do_request(mdsc, inode, req);
 
-	if ( operation == CEPH_MDS_OP_GETFILELOCK){
+	if (operation == CEPH_MDS_OP_GETFILELOCK) {
 		fl->fl_pid = le64_to_cpu(req->r_reply_info.filelock_reply->pid);
 		if (CEPH_LOCK_SHARED == req->r_reply_info.filelock_reply->type)
 			fl->fl_type = F_RDLCK;
@@ -93,8 +115,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
 		return -ENOLCK;
 
-	fl->fl_nspid = get_pid(task_tgid(current));
-	dout("ceph_lock, fl_pid:%d", fl->fl_pid);
+	dout("ceph_lock, fl_owner: %p", fl->fl_owner);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
 	if (IS_GETLK(cmd))
@@ -111,7 +132,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, file, lock_cmd, wait, fl);
 	if (!err) {
-		if ( op != CEPH_MDS_OP_GETFILELOCK ){
+		if (op != CEPH_MDS_OP_GETFILELOCK) {
 			dout("mds locked, locking locally");
 			err = posix_lock_file(file, fl, NULL);
 			if (err && (CEPH_MDS_OP_SETFILELOCK == op)) {
@@ -145,8 +166,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
 		return -ENOLCK;
 
-	fl->fl_nspid = get_pid(task_tgid(current));
-	dout("ceph_flock, fl_pid:%d", fl->fl_pid);
+	dout("ceph_flock, fl_file: %p", fl->fl_file);
 
 	if (IS_SETLKW(cmd))
 		wait = 1;
@@ -289,13 +309,14 @@ int lock_to_ceph_filelock(struct file_lock *lock,
 			  struct ceph_filelock *cephlock)
 {
 	int err = 0;
-
 	cephlock->start = cpu_to_le64(lock->fl_start);
 	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
 	cephlock->client = cpu_to_le64(0);
-	cephlock->pid = cpu_to_le64(lock->fl_pid);
-	cephlock->pid_namespace =
-	        cpu_to_le64((u64)(unsigned long)lock->fl_nspid);
+	cephlock->pid = cpu_to_le64((u64)lock->fl_pid);
+	if (lock->fl_flags & FL_POSIX)
+		cephlock->owner = cpu_to_le64(secure_addr(lock->fl_owner));
+	else
+		cephlock->owner = cpu_to_le64(secure_addr(lock->fl_file));
 
 	switch (lock->fl_type) {
 	case F_RDLCK:
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 10a4ccb..06150fd 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1026,6 +1026,7 @@ static int __init init_ceph(void)
 	if (ret)
 		goto out;
 
+	ceph_flock_init();
 	ceph_xattr_init();
 	ret = register_filesystem(&ceph_fs_type);
 	if (ret)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 70bb183..7866cd0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -871,6 +871,7 @@ extern long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 extern const struct export_operations ceph_export_ops;
 
 /* locks.c */
+extern __init void ceph_flock_init(void);
 extern int ceph_lock(struct file *file, int cmd, struct file_lock *fl);
 extern int ceph_flock(struct file *file, int cmd, struct file_lock *fl);
 extern void ceph_count_locks(struct inode *inode, int *p_num, int *f_num);
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 35f345f..5f6db18 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -421,8 +421,8 @@ union ceph_mds_request_args {
 	struct {
 		__u8 rule; /* currently fcntl or flock */
 		__u8 type; /* shared, exclusive, remove*/
+		__le64 owner; /* owner of the lock */
 		__le64 pid; /* process id requesting the lock */
-		__le64 pid_namespace;
 		__le64 start; /* initial location to lock */
 		__le64 length; /* num bytes to lock from start */
 		__u8 wait; /* will caller wait for lock to become available? */
@@ -533,8 +533,8 @@ struct ceph_filelock {
 	__le64 start;/* file offset to start lock at */
 	__le64 length; /* num bytes to lock; 0 for all following start */
 	__le64 client; /* which client holds the lock */
+	__le64 owner; /* owner the lock */
 	__le64 pid; /* process id holding the lock on the client */
-	__le64 pid_namespace;
 	__u8 type; /* shared lock, exclusive lock, or unlock */
 } __attribute__ ((packed));
 
-- 
1.8.5.3

