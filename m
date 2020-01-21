From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH v3 03/10] ceph: make dentry_lease_is_valid non-static
Date: Tue, 21 Jan 2020 14:29:21 -0500
Message-ID: <20200121192928.469316-4-jlayton@kernel.org>
References: <20200121192928.469316-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgAUT3d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:29:33 -0500
In-Reply-To: <20200121192928.469316-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idridryomov@gmail.com, sage@redhat.com, zyan@redhat.com

...and move a comment over the proper function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c   | 10 +++++-----
 fs/ceph/super.h |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 10294f07f5f0..9d2eca67985a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1477,10 +1477,6 @@ void ceph_invalidate_dentry_lease(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 }
 
-/*
- * Check if dentry lease is valid.  If not, delete the lease.  Try to
- * renew if the least is more than half up.
- */
 static bool __dentry_lease_is_valid(struct ceph_dentry_info *di)
 {
 	struct ceph_mds_session *session;
@@ -1507,7 +1503,11 @@ static bool __dentry_lease_is_valid(struct ceph_dentry_info *di)
 	return false;
 }
 
-static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
+/*
+ * Check if dentry lease is valid.  If not, delete the lease.  Try to
+ * renew if the least is more than half up.
+ */
+int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
 {
 	struct ceph_dentry_info *di;
 	struct ceph_mds_session *session = NULL;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index ec4d66d7c261..f27b2bf9a3f5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1121,6 +1121,7 @@ extern int ceph_handle_snapdir(struct ceph_mds_request *req,
 extern struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 					 struct dentry *dentry, int err);
 
+extern int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags);
 extern void __ceph_dentry_lease_touch(struct ceph_dentry_info *di);
 extern void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di);
 extern void ceph_invalidate_dentry_lease(struct dentry *dentry);
-- 
2.24.1
