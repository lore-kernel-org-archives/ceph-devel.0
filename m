From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v4 6/6] ceph: when seeing write errors on an inode, switch to sync writes
Date: Thu,  9 Feb 2017 09:48:36 -0500
Message-ID: <20170209144836.12525-7-jlayton@redhat.com>
References: <20170209144836.12525-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbdBIOsr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 09:48:47 -0500
In-Reply-To: <20170209144836.12525-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Currently, we don't have a real feedback mechanism in place for when we
start seeing buffered writeback errors. If writeback is failing, there
is nothing that prevents an application from continuing to dirty pages
that aren't being cleaned.

In the event that we're seeing write errors of any sort occur on an
inode, have the callback set a flag to force further writes to be
synchronous. When the next write succeeds, clear the flag to allow
buffered writeback to continue.

Since this is just a hint to the write submission mechanism, we only
take the i_ceph_lock when a lockless check shows that the flag needs to
be changed.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/addr.c  |  6 +++++-
 fs/ceph/file.c  | 46 +++++++++++++++++++++++++++++++++-------------
 fs/ceph/super.h | 26 ++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 040d05c8f4a2..596f782fd35e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -670,8 +670,12 @@ static void writepages_finish(struct ceph_osd_request *req)
 
 
 	dout("writepages_finish %p rc %d\n", inode, rc);
-	if (rc < 0)
+	if (rc < 0) {
 		mapping_set_error(mapping, rc);
+		ceph_set_error_write(ci);
+	} else {
+		ceph_clear_error_write(ci);
+	}
 
 	/*
 	 * We lost the cache cap, need to truncate the page before
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 987dcb9b566f..7dbc0236e277 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -758,9 +758,24 @@ static void ceph_sync_write_unsafe(struct ceph_osd_request *req, bool unsafe)
 		list_del_init(&req->r_unsafe_item);
 		spin_unlock(&ci->i_unsafe_lock);
 		ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
+		if (req->r_result < 0)
+			ceph_set_error_write(ci);
+		else
+			ceph_clear_error_write(ci);
 	}
 }
 
+static void ceph_sync_write_safe(struct ceph_osd_request *req)
+{
+	struct ceph_inode_info *ci = ceph_inode(req->r_inode);
+
+	if (req->r_result < 0)
+		ceph_set_error_write(ci);
+	else
+		ceph_clear_error_write(ci);
+	complete_all(&req->r_completion);
+}
+
 /*
  * Wait on any unsafe replies for the given inode.  First wait on the
  * newest request, and make that the upper bound.  Then, if there are
@@ -1101,6 +1116,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 		/* get a second commit callback */
 		req->r_unsafe_callback = ceph_sync_write_unsafe;
+		req->r_callback = ceph_sync_write_safe;
 		req->r_inode = inode;
 
 		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
@@ -1114,19 +1130,21 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 out:
 		ceph_osdc_put_request(req);
-		if (ret == 0) {
-			pos += len;
-			written += len;
-
-			if (pos > i_size_read(inode)) {
-				check_caps = ceph_inode_set_size(inode, pos);
-				if (check_caps)
-					ceph_check_caps(ceph_inode(inode),
-							CHECK_CAPS_AUTHONLY,
-							NULL);
-			}
-		} else
+		if (ret != 0) {
+			ceph_set_error_write(ci);
 			break;
+		}
+
+		pos += len;
+		written += len;
+		if (pos > i_size_read(inode)) {
+			check_caps = ceph_inode_set_size(inode, pos);
+			if (check_caps)
+				ceph_check_caps(ceph_inode(inode),
+						CHECK_CAPS_AUTHONLY,
+						NULL);
+		}
+
 	}
 
 	if (ret != -EOLDSNAPC && written > 0) {
@@ -1332,6 +1350,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 retry_snap:
+	/* FIXME: not complete since it doesn't account for being at quota */
 	if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL)) {
 		err = -ENOSPC;
 		goto out;
@@ -1353,7 +1372,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
-	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC)) {
+	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
+	    (ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
 		struct ceph_snap_context *snapc;
 		struct iov_iter data;
 		inode_unlock(inode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 950170136be9..3b987da37dcd 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -474,6 +474,32 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_CAP_DROPPED	(1 << 8)  /* caps were forcibly dropped */
 #define CEPH_I_KICK_FLUSH	(1 << 9)  /* kick flushing caps */
 #define CEPH_I_FLUSH_SNAPS	(1 << 10) /* need flush snapss */
+#define CEPH_I_ERROR_WRITE	(1 << 11) /* have seen write errors */
+
+/*
+ * We set the ERROR_WRITE bit when we start seeing write errors on an inode
+ * and then clear it when they start succeeding. Note that we do a lockless
+ * check first, and only take the lock if it looks like it needs to be changed.
+ * The write submission code just takes this as a hint, so we're not too
+ * worried if a few slip through in either direction.
+ */
+static inline void ceph_set_error_write(struct ceph_inode_info *ci)
+{
+	if (!(ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
+		spin_lock(&ci->i_ceph_lock);
+		ci->i_ceph_flags |= CEPH_I_ERROR_WRITE;
+		spin_unlock(&ci->i_ceph_lock);
+	}
+}
+
+static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
+{
+	if (ci->i_ceph_flags & CEPH_I_ERROR_WRITE) {
+		spin_lock(&ci->i_ceph_lock);
+		ci->i_ceph_flags &= ~CEPH_I_ERROR_WRITE;
+		spin_unlock(&ci->i_ceph_lock);
+	}
+}
 
 static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
 					   long long release_count,
-- 
2.9.3

