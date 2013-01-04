From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/6] ceph: allow revoking duplicated caps issued by non-auth MDS
Date: Fri,  4 Jan 2013 19:34:18 +0800
Message-ID: <1357299261-20591-4-git-send-email-zheng.z.yan@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab3ADLeb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 06:34:31 -0500
In-Reply-To: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Allow revoking duplicated caps issued by non-auth MDS if these caps
are also issued by auth MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a9fe2d5..c90b245 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1468,7 +1468,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct inode *inode = &ci->vfs_inode;
 	struct ceph_cap *cap;
-	int file_wanted, used;
+	int file_wanted, used, cap_used;
 	int took_snap_rwsem = 0;             /* true if mdsc->snap_rwsem held */
 	int issued, implemented, want, retain, revoking, flushing = 0;
 	int mds = -1;   /* keep track of how far we've gone through i_caps list
@@ -1577,6 +1577,10 @@ retry_locked:
 		     ceph_cap_string(cap->implemented),
 		     ceph_cap_string(revoking));
 
+		cap_used = used;
+		if (ci->i_auth_cap && cap != ci->i_auth_cap)
+			cap_used &= ~ci->i_auth_cap->issued;
+
 		if (cap == ci->i_auth_cap &&
 		    (cap->issued & CEPH_CAP_FILE_WR)) {
 			/* request larger max_size from MDS? */
@@ -1601,7 +1605,7 @@ retry_locked:
 		}
 
 		/* completed revocation? going down and there are no caps? */
-		if (revoking && (revoking & used) == 0) {
+		if (revoking && (revoking & cap_used) == 0) {
 			dout("completed revocation of %s\n",
 			     ceph_cap_string(cap->implemented & ~cap->issued));
 			goto ack;
@@ -1678,8 +1682,8 @@ ack:
 		sent++;
 
 		/* __send_cap drops i_ceph_lock */
-		delayed += __send_cap(mdsc, cap, CEPH_CAP_OP_UPDATE, used, want,
-				      retain, flushing, NULL);
+		delayed += __send_cap(mdsc, cap, CEPH_CAP_OP_UPDATE, cap_used,
+				      want, retain, flushing, NULL);
 		goto retry; /* retake i_ceph_lock and restart our cap scan. */
 	}
 
-- 
1.7.11.7

