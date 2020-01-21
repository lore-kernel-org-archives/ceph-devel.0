From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH v3 06/10] ceph: add flag to designate that a request is asynchronous
Date: Tue, 21 Jan 2020 14:29:24 -0500
Message-ID: <20200121192928.469316-7-jlayton@kernel.org>
References: <20200121192928.469316-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbgAUT3f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:29:35 -0500
In-Reply-To: <20200121192928.469316-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idridryomov@gmail.com, sage@redhat.com, zyan@redhat.com

The MDS has need to know that a request is asynchronous.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c                | 1 +
 fs/ceph/inode.c              | 1 +
 fs/ceph/mds_client.c         | 2 ++
 fs/ceph/mds_client.h         | 1 +
 include/linux/ceph/ceph_fs.h | 5 +++--
 5 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 9d2eca67985a..0d97c2962314 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1116,6 +1116,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	    get_caps_for_async_unlink(dir, dentry)) {
 		dout("ceph: Async unlink on %lu/%.*s", dir->i_ino,
 		     dentry->d_name.len, dentry->d_name.name);
+		set_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags);
 		req->r_callback = ceph_async_unlink_cb;
 		req->r_old_inode = d_inode(dentry);
 		ihold(req->r_old_inode);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 79bb1e6af090..4056c7968b86 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1317,6 +1317,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
+				 !test_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags) &&
 				 rinfo->head->result == 0) ?  req->r_fmode : -1,
 				&req->r_caps_reservation);
 		if (err < 0) {
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d0ceb3f46570..4ca43348bfd7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2620,6 +2620,8 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 	rhead->oldest_client_tid = cpu_to_le64(__get_oldest_tid(mdsc));
 	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 		flags |= CEPH_MDS_FLAG_REPLAY;
+	if (test_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags))
+		flags |= CEPH_MDS_FLAG_ASYNC;
 	if (req->r_parent)
 		flags |= CEPH_MDS_FLAG_WANT_DENTRY;
 	rhead->flags = cpu_to_le32(flags);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 54df093a7db0..31f68897bc87 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -258,6 +258,7 @@ struct ceph_mds_request {
 #define CEPH_MDS_R_GOT_RESULT		(5) /* got a result */
 #define CEPH_MDS_R_DID_PREPOPULATE	(6) /* prepopulated readdir */
 #define CEPH_MDS_R_PARENT_LOCKED	(7) /* is r_parent->i_rwsem wlocked? */
+#define CEPH_MDS_R_ASYNC		(8) /* async request */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index a099f60feb7b..91d09cf37649 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -444,8 +444,9 @@ union ceph_mds_request_args {
 	} __attribute__ ((packed)) lookupino;
 } __attribute__ ((packed));
 
-#define CEPH_MDS_FLAG_REPLAY        1  /* this is a replayed op */
-#define CEPH_MDS_FLAG_WANT_DENTRY   2  /* want dentry in reply */
+#define CEPH_MDS_FLAG_REPLAY		1 /* this is a replayed op */
+#define CEPH_MDS_FLAG_WANT_DENTRY	2 /* want dentry in reply */
+#define CEPH_MDS_FLAG_ASYNC		4 /* request is asynchronous */
 
 struct ceph_mds_request_head {
 	__le64 oldest_client_tid;
-- 
2.24.1
