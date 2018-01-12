From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 1/2] ceph: quota: cache inode pointer in ceph_snap_realm
Date: Fri, 12 Jan 2018 17:19:28 +0000
Message-ID: <20180112171929.11791-2-lhenriques@suse.com>
References: <20180112171929.11791-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934110AbeALRTj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 12:19:39 -0500
In-Reply-To: <20180112171929.11791-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

Keep a pointer to the inode in struct ceph_snap_realm.  This allows to
optimize functions that walk the realms hierarchy (e.g. in quotas).

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/quota.c | 22 ++++------------------
 fs/ceph/snap.c  |  9 +++++++++
 fs/ceph/super.h |  1 +
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 121819baeb58..d8bd6d346324 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -83,7 +83,6 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 {
 	struct ceph_inode_info *ci = NULL;
 	struct ceph_snap_realm *realm, *next;
-	struct ceph_vino vino;
 	struct inode *in;
 	bool has_quota;
 
@@ -96,14 +95,8 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 	else
 		pr_err_ratelimited("get_quota_realm: ino (%llx.%llx) "
 				   "null i_snap_realm\n", ceph_vinop(inode));
-	while (realm) {
-		vino.ino = realm->ino;
-		vino.snap = CEPH_NOSNAP;
-		in = ceph_find_inode(inode->i_sb, vino);
-		if (!in) {
-			pr_warn("Failed to find inode for %llu\n", vino.ino);
-			break;
-		}
+	while (realm && realm->inode) {
+		in = igrab(realm->inode);
 		ci = ceph_inode(in);
 		has_quota = ceph_has_quota(ci);
 		iput(in);
@@ -161,7 +154,6 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct ceph_inode_info *ci;
 	struct ceph_snap_realm *realm, *next;
-	struct ceph_vino vino;
 	struct inode *in;
 	u64 max, rvalue;
 	bool exceeded = false;
@@ -176,14 +168,8 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	else
 		pr_err_ratelimited("check_quota_exceeded: ino (%llx.%llx) "
 				   "null i_snap_realm\n", ceph_vinop(inode));
-	while (realm) {
-		vino.ino = realm->ino;
-		vino.snap = CEPH_NOSNAP;
-		in = ceph_find_inode(inode->i_sb, vino);
-		if (!in) {
-			pr_warn("Failed to find inode for %llu\n", vino.ino);
-			break;
-		}
+	while (realm && realm->inode) {
+		in = igrab(realm->inode);
 		ci = ceph_inode(in);
 		spin_lock(&ci->i_ceph_lock);
 		if (op == QUOTA_CHECK_MAX_FILES_OP) {
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 41858604c2db..e4bbd2c03c1b 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -110,6 +110,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 	u64 ino)
 {
 	struct ceph_snap_realm *realm;
+	struct ceph_vino vino;
 
 	realm = kzalloc(sizeof(*realm), GFP_NOFS);
 	if (!realm)
@@ -117,6 +118,14 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 
 	atomic_set(&realm->nref, 1);    /* for caller */
 	realm->ino = ino;
+
+	/* cache a pointer to inode */
+	vino.ino = realm->ino;
+	vino.snap = CEPH_NOSNAP;
+	realm->inode = ceph_find_inode(mdsc->fsc->sb, vino);
+	if (realm->inode)
+		/* drop ref */
+		iput(realm->inode);
 	INIT_LIST_HEAD(&realm->children);
 	INIT_LIST_HEAD(&realm->child_item);
 	INIT_LIST_HEAD(&realm->empty_item);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3e0741a47cb4..5f788350cd75 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -754,6 +754,7 @@ struct ceph_readdir_cache_control {
  */
 struct ceph_snap_realm {
 	u64 ino;
+	struct inode *inode;
 	atomic_t nref;
 	struct rb_node node;
 
