From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC v2 PATCH 1/4] ceph: add seqlock for snaprealm hierarchy change detection
Date: Mon, 18 Dec 2017 15:38:59 +0000
Message-ID: <20171218153902.7455-2-lhenriques@suse.com>
References: <20171218153902.7455-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753083AbdLRPjN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Dec 2017 10:39:13 -0500
In-Reply-To: <20171218153902.7455-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

It is possible to receive an update to the snaprealms hierarchy from an
MDS while walking through this hierarchy.  This patch adds a mechanism
similar to the one used in dcache to detect renames in lookups.  A new
seqlock is used to allow a retry in case a change has occurred while
walking through the snaprealms.

Link: http://tracker.ceph.com/issues/22372
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/snap.c  | 45 +++++++++++++++++++++++++++++++++++++++------
 fs/ceph/super.h |  2 ++
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 8a2ca41e4b97..8b9d6c7c0df4 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -54,6 +54,25 @@
  * console).
  */
 
+/*
+ * While walking through the snaprealm hierarchy it is possible that
+ * this hierarchy is updated (for ex, when a different client moves
+ * directories around).  snaprealm_lock isn't supposed to prevent this
+ * but, just like the rename_lock in dcache, to detect that this has
+ * happen so that a lookup can be retried.
+ *
+ * Here's a typical usage pattern for this lock:
+ *
+ * retry:
+ * 	seq = read_seqbegin(&snaprealm_lock);
+ *	realm = ci->i_snap_realm;
+ *	ceph_get_snap_realm(mdsc, realm);
+ *	... do stuff ...
+ *	ceph_put_snap_realm(mdsc, realm);
+ *	if (read_seqretry(&snaprealm_lock, seq))
+ *		goto retry;
+ */
+DEFINE_SEQLOCK(snaprealm_lock);
 
 /*
  * increase ref count for the realm
@@ -81,10 +100,12 @@ void ceph_get_snap_realm(struct ceph_mds_client *mdsc,
 static void __insert_snap_realm(struct rb_root *root,
 				struct ceph_snap_realm *new)
 {
-	struct rb_node **p = &root->rb_node;
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct ceph_snap_realm *r = NULL;
 
+	write_seqlock(&snaprealm_lock);
+	p  = &root->rb_node;
 	while (*p) {
 		parent = *p;
 		r = rb_entry(parent, struct ceph_snap_realm, node);
@@ -98,6 +119,7 @@ static void __insert_snap_realm(struct rb_root *root,
 
 	rb_link_node(&new->node, parent, p);
 	rb_insert_color(&new->node, root);
+	write_sequnlock(&snaprealm_lock);
 }
 
 /*
@@ -136,9 +158,14 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
 						   u64 ino)
 {
-	struct rb_node *n = mdsc->snap_realms.rb_node;
-	struct ceph_snap_realm *r;
-
+	struct rb_node *n;
+	struct ceph_snap_realm *realm, *r;
+	unsigned seq;
+
+retry:
+	realm = NULL;
+	seq = read_seqbegin(&snaprealm_lock);
+	n = mdsc->snap_realms.rb_node;
 	while (n) {
 		r = rb_entry(n, struct ceph_snap_realm, node);
 		if (ino < r->ino)
@@ -147,10 +174,14 @@ static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
 			n = n->rb_right;
 		else {
 			dout("lookup_snap_realm %llx %p\n", r->ino, r);
-			return r;
+			realm = r;
+			break;
 		}
 	}
-	return NULL;
+
+	if (read_seqretry(&snaprealm_lock, seq))
+		goto retry;
+	return realm;
 }
 
 struct ceph_snap_realm *ceph_lookup_snap_realm(struct ceph_mds_client *mdsc,
@@ -174,7 +205,9 @@ static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
 {
 	dout("__destroy_snap_realm %p %llx\n", realm, realm->ino);
 
+	write_seqlock(&snaprealm_lock);
 	rb_erase(&realm->node, &mdsc->snap_realms);
+	write_sequnlock(&snaprealm_lock);
 
 	if (realm->parent) {
 		list_del_init(&realm->child_item);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 2beeec07fa76..6474e8d875b7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -760,6 +760,8 @@ static inline int default_congestion_kb(void)
 
 
 /* snap.c */
+extern seqlock_t snaprealm_lock;
+
 struct ceph_snap_realm *ceph_lookup_snap_realm(struct ceph_mds_client *mdsc,
 					       u64 ino);
 extern void ceph_get_snap_realm(struct ceph_mds_client *mdsc,
