From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] ceph: forbid mandatory file lock
Date: Tue,  4 Mar 2014 16:05:42 +0800
Message-ID: <1393920342-15913-2-git-send-email-zheng.z.yan@intel.com>
References: <1393920342-15913-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8711 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756579AbaCDIFt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Mar 2014 03:05:49 -0500
In-Reply-To: <1393920342-15913-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/locks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 133e006..f91a569a 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -87,6 +87,12 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	u8 wait = 0;
 	u16 op = CEPH_MDS_OP_SETFILELOCK;
 
+	if (!(fl->fl_flags & FL_POSIX))
+		return -ENOLCK;
+	/* No mandatory locks */
+	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
+		return -ENOLCK;
+
 	fl->fl_nspid = get_pid(task_tgid(current));
 	dout("ceph_lock, fl_pid:%d", fl->fl_pid);
 
@@ -133,6 +139,12 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	int err;
 	u8 wait = 0;
 
+	if (!(fl->fl_flags & FL_FLOCK))
+		return -ENOLCK;
+	/* No mandatory locks */
+	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
+		return -ENOLCK;
+
 	fl->fl_nspid = get_pid(task_tgid(current));
 	dout("ceph_flock, fl_pid:%d", fl->fl_pid);
 
-- 
1.8.5.3

