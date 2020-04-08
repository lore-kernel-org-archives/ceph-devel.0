From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 2/2] ceph: initialize base and pathlen variables in async dirops cb's
Date: Wed,  8 Apr 2020 10:21:25 -0400
Message-ID: <20200408142125.52908-3-jlayton@kernel.org>
References: <20200408142125.52908-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgDHOV3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:21:29 -0400
In-Reply-To: <20200408142125.52908-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, dan.carpenter@oracle.com, sage@redhat.com

Ensure that the pr_warn messages look sane even if ceph_mdsc_build_path
fails.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c  | 4 ++--
 fs/ceph/file.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 10d528a455d5..93476d447a4b 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1057,8 +1057,8 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 
 	/* If op failed, mark everyone involved for errors */
 	if (result) {
-		int pathlen;
-		u64 base;
+		int pathlen = 0;
+		u64 base = 0;
 		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
 						  &base, 0);
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3a1bd13de84f..160644ddaeed 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -529,8 +529,8 @@ static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
 
 	if (result) {
 		struct dentry *dentry = req->r_dentry;
-		int pathlen;
-		u64 base;
+		int pathlen = 0;
+		u64 base = 0;
 		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
 						  &base, 0);
 
-- 
2.25.2
