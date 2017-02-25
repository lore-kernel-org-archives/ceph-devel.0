From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v5 6/6] ceph: when seeing write errors on an inode, switch to sync writes
Date: Sat, 25 Feb 2017 12:43:23 -0500
Message-ID: <20170225174323.20289-7-jlayton@redhat.com>
References: <20170225174323.20289-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbdBYRna (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 25 Feb 2017 12:43:30 -0500
In-Reply-To: <20170225174323.20289-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

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
 fs/ceph/file.c  | 31 ++++++++++++++++++-------------
 fs/ceph/super.h | 26 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index be3aa84188a5..ef26541247c2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -669,8 +669,12 @@ static void writepages_finish(struct ceph_osd_request *req)
 	bool remove_page;
 
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
index 9dad32d0ed0b..579a16ca0b8e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1020,19 +1020,22 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
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
+		ceph_clear_error_write(ci);
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
@@ -1238,6 +1241,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 retry_snap:
+	/* FIXME: not complete since it doesn't account for being at quota */
 	if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL)) {
 		err = -ENOSPC;
 		goto out;
@@ -1259,7 +1263,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
-	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC)) {
+	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
+	    (ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
 		struct ceph_snap_context *snapc;
 		struct iov_iter data;
 		inode_unlock(inode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index e9410bcf4113..b766823d2bb3 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -473,6 +473,32 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
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

