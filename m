From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/2] ceph: Fix return value of encode_fh function
Date: Tue,  5 Oct 2010 16:03:41 +0530
Message-ID: <1286274822-27738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:58727 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864Ab0JEKds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 06:33:48 -0400
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o95AXlKi029412
	for <ceph-devel@vger.kernel.org>; Tue, 5 Oct 2010 21:33:47 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o95AXkVA2199794
	for <ceph-devel@vger.kernel.org>; Tue, 5 Oct 2010 21:33:46 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o95AXkGk006060
	for <ceph-devel@vger.kernel.org>; Tue, 5 Oct 2010 21:33:46 +1100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@newdream.net
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

encode_fh function should return 255 on error as done by other file
system to indicate EOVERFLOW. Also max_len is in sizeof(u32) units
and not in bytes.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 fs/ceph/export.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 4480cb1..387c582 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -42,32 +42,34 @@ struct ceph_nfs_confh {
 static int ceph_encode_fh(struct dentry *dentry, u32 *rawfh, int *max_len,
 			  int connectable)
 {
+	int type;
 	struct ceph_nfs_fh *fh = (void *)rawfh;
 	struct ceph_nfs_confh *cfh = (void *)rawfh;
 	struct dentry *parent = dentry->d_parent;
 	struct inode *inode = dentry->d_inode;
-	int type;
+	int connected_handle_length = sizeof(*cfh)/4;
+	int handle_length = sizeof(*fh)/4;
 
 	/* don't re-export snaps */
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EINVAL;
 
-	if (*max_len >= sizeof(*cfh)) {
+	if (*max_len >= connected_handle_length) {
 		dout("encode_fh %p connectable\n", dentry);
 		cfh->ino = ceph_ino(dentry->d_inode);
 		cfh->parent_ino = ceph_ino(parent->d_inode);
 		cfh->parent_name_hash = parent->d_name.hash;
-		*max_len = sizeof(*cfh);
+		*max_len = connected_handle_length;
 		type = 2;
-	} else if (*max_len > sizeof(*fh)) {
+	} else if (*max_len >= handle_length) {
 		if (connectable)
-			return -ENOSPC;
+			return 255;
 		dout("encode_fh %p\n", dentry);
 		fh->ino = ceph_ino(dentry->d_inode);
-		*max_len = sizeof(*fh);
+		*max_len = handle_length;
 		type = 1;
 	} else {
-		return -ENOSPC;
+		return 255;
 	}
 	return type;
 }
-- 
1.7.0.4

