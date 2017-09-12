From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/5] ceph: optimize flock encoding during reconnect
Date: Tue, 12 Sep 2017 10:53:49 +0800
Message-ID: <20170912025351.42147-4-zyan@redhat.com>
References: <20170912025351.42147-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdILCyX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 Sep 2017 22:54:23 -0400
In-Reply-To: <20170912025351.42147-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

don't malloc if there is no flock

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/locks.c      | 17 ++++++++++-------
 fs/ceph/mds_client.c | 34 ++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 33e091e6e8d3..4addd18ac6f9 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -430,19 +430,22 @@ int ceph_locks_to_pagelist(struct ceph_filelock *flocks,
 	if (err)
 		goto out_fail;
 
-	err = ceph_pagelist_append(pagelist, flocks,
-				   num_fcntl_locks * sizeof(*flocks));
-	if (err)
-		goto out_fail;
+	if (num_fcntl_locks > 0) {
+		err = ceph_pagelist_append(pagelist, flocks,
+					   num_fcntl_locks * sizeof(*flocks));
+		if (err)
+			goto out_fail;
+	}
 
 	nlocks = cpu_to_le32(num_flock_locks);
 	err = ceph_pagelist_append(pagelist, &nlocks, sizeof(nlocks));
 	if (err)
 		goto out_fail;
 
-	err = ceph_pagelist_append(pagelist,
-				   &flocks[num_fcntl_locks],
-				   num_flock_locks * sizeof(*flocks));
+	if (num_flock_locks > 0) {
+		err = ceph_pagelist_append(pagelist, &flocks[num_fcntl_locks],
+					   num_flock_locks * sizeof(*flocks));
+	}
 out_fail:
 	return err;
 }
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 6146af4ed03c..817ea438aa19 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2895,26 +2895,32 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 
 	if (recon_state->msg_version >= 2) {
 		int num_fcntl_locks, num_flock_locks;
-		struct ceph_filelock *flocks;
+		struct ceph_filelock *flocks = NULL;
 		size_t struct_len, total_len = 0;
 		u8 struct_v = 0;
 
 encode_again:
 		ceph_count_locks(inode, &num_fcntl_locks, &num_flock_locks);
-		flocks = kmalloc((num_fcntl_locks+num_flock_locks) *
-				 sizeof(struct ceph_filelock), GFP_NOFS);
-		if (!flocks) {
-			err = -ENOMEM;
-			goto out_free;
-		}
-		err = ceph_encode_locks_to_buffer(inode, flocks,
-						  num_fcntl_locks,
-						  num_flock_locks);
-		if (err) {
+		if (num_fcntl_locks + num_flock_locks > 0) {
+			flocks = kmalloc((num_fcntl_locks + num_flock_locks) *
+					 sizeof(struct ceph_filelock), GFP_NOFS);
+			if (!flocks) {
+				err = -ENOMEM;
+				goto out_free;
+			}
+			err = ceph_encode_locks_to_buffer(inode, flocks,
+							  num_fcntl_locks,
+							  num_flock_locks);
+			if (err) {
+				kfree(flocks);
+				flocks = NULL;
+				if (err == -ENOSPC)
+					goto encode_again;
+				goto out_free;
+			}
+		} else {
 			kfree(flocks);
-			if (err == -ENOSPC)
-				goto encode_again;
-			goto out_free;
+			flocks = NULL;
 		}
 
 		if (recon_state->msg_version >= 3) {
-- 
2.13.5

