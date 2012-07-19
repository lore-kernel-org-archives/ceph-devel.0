From: Alex Elder <elder@inktank.com>
Subject: [PATCH 04/12] ceph: define snap counts as u32 everywhere
Date: Thu, 19 Jul 2012 16:08:31 -0500
Message-ID: <5008774F.8050806@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52993 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2GSVId (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:08:33 -0400
Received: by yhmm54 with SMTP id m54so3293293yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:08:33 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are two structures in which a count of snapshots are
maintained:

    struct ceph_snap_context {
	...
        u32 num_snaps;
	...
    }
and
    struct ceph_snap_realm {
	...
        u32 num_prior_parent_snaps;   /*  had prior to parent_since */
	...
        u32 num_snaps;
	...
    }

These fields never take on negative values (e.g., to hold special
meaning), and so are really inherently unsigned.  Furthermore they
take their value from over-the-wire or on-disk formatted 32-bit
values.

So change their definition to have type u32, and change some spots
elsewhere in the code to account for this change.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/snap.c               |   18 ++++++++++--------
 fs/ceph/super.h              |    4 ++--
 include/linux/ceph/libceph.h |    2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index e5206fc..cbb2f54 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -296,8 +296,7 @@ static int build_snap_context(struct ceph_snap_realm
*realm)
 	struct ceph_snap_realm *parent = realm->parent;
 	struct ceph_snap_context *snapc;
 	int err = 0;
-	int i;
-	int num = realm->num_prior_parent_snaps + realm->num_snaps;
+	u32 num = realm->num_prior_parent_snaps + realm->num_snaps;

 	/*
 	 * build parent context, if it hasn't been built.
@@ -321,11 +320,11 @@ static int build_snap_context(struct
ceph_snap_realm *realm)
 	    realm->cached_context->seq == realm->seq &&
 	    (!parent ||
 	     realm->cached_context->seq >= parent->cached_context->seq)) {
-		dout("build_snap_context %llx %p: %p seq %lld (%d snaps)"
+		dout("build_snap_context %llx %p: %p seq %lld (%u snaps)"
 		     " (unchanged)\n",
 		     realm->ino, realm, realm->cached_context,
 		     realm->cached_context->seq,
-		     realm->cached_context->num_snaps);
+		     (unsigned int) realm->cached_context->num_snaps);
 		return 0;
 	}

@@ -342,6 +341,8 @@ static int build_snap_context(struct ceph_snap_realm
*realm)
 	num = 0;
 	snapc->seq = realm->seq;
 	if (parent) {
+		u32 i;
+
 		/* include any of parent's snaps occurring _after_ my
 		   parent became my parent */
 		for (i = 0; i < parent->cached_context->num_snaps; i++)
@@ -361,8 +362,9 @@ static int build_snap_context(struct ceph_snap_realm
*realm)

 	sort(snapc->snaps, num, sizeof(u64), cmpu64_rev, NULL);
 	snapc->num_snaps = num;
-	dout("build_snap_context %llx %p: %p seq %lld (%d snaps)\n",
-	     realm->ino, realm, snapc, snapc->seq, snapc->num_snaps);
+	dout("build_snap_context %llx %p: %p seq %lld (%u snaps)\n",
+	     realm->ino, realm, snapc, snapc->seq,
+	     (unsigned int) snapc->num_snaps);

 	if (realm->cached_context)
 		ceph_put_snap_context(realm->cached_context);
@@ -402,9 +404,9 @@ static void rebuild_snap_realms(struct
ceph_snap_realm *realm)
  * helper to allocate and decode an array of snapids.  free prior
  * instance, if any.
  */
-static int dup_array(u64 **dst, __le64 *src, int num)
+static int dup_array(u64 **dst, __le64 *src, u32 num)
 {
-	int i;
+	u32 i;

 	kfree(*dst);
 	if (num) {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index fc35036..3ea48b7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -612,9 +612,9 @@ struct ceph_snap_realm {
 	u64 parent_since;   /* snapid when our current parent became so */

 	u64 *prior_parent_snaps;      /* snaps inherited from any parents we */
-	int num_prior_parent_snaps;   /*  had prior to parent_since */
+	u32 num_prior_parent_snaps;   /*  had prior to parent_since */
 	u64 *snaps;                   /* snaps specific to this realm */
-	int num_snaps;
+	u32 num_snaps;

 	struct ceph_snap_realm *parent;
 	struct list_head children;       /* list of child realms */
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 98ec36a..0b72295 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -160,7 +160,7 @@ struct ceph_client {
 struct ceph_snap_context {
 	atomic_t nref;
 	u64 seq;
-	int num_snaps;
+	u32 num_snaps;
 	u64 snaps[];
 };

-- 
1.7.5.4

