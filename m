From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 3/6] ceph: allow revoking duplicated caps issued by non-auth
 MDS
Date: Sun, 06 Jan 2013 16:49:18 +0800
Message-ID: <50E93A8E.7040102@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-4-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301052208200.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45221 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab3AFItV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 6 Jan 2013 03:49:21 -0500
In-Reply-To: <alpine.DEB.2.00.1301052208200.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

how about below patch, I also rebased git://github.com/ukernel/ceph-client.git wip-ceph

----
From 19f0e26cb90c29bb22ad09769bfc0df03b3d07be Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Fri, 4 Jan 2013 14:37:57 +0800
Subject: [PATCH 3/5] ceph: allow revoking duplicated caps issued by non-auth
 MDS

Allow revoking duplicated caps issued by non-auth MDS if these caps
are also issued by auth MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a9fe2d5..76b1923 100644
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
@@ -1571,9 +1571,14 @@ retry_locked:
 
 		/* NOTE: no side-effects allowed, until we take s_mutex */
 
+		cap_used = used;
+		if (ci->i_auth_cap && cap != ci->i_auth_cap)
+			cap_used &= ~ci->i_auth_cap->issued;
+
 		revoking = cap->implemented & ~cap->issued;
-		dout(" mds%d cap %p issued %s implemented %s revoking %s\n",
+		dout(" mds%d cap %p used %s issued %s implemented %s revoking %s\n",
 		     cap->mds, cap, ceph_cap_string(cap->issued),
+		     ceph_cap_string(cap_used),
 		     ceph_cap_string(cap->implemented),
 		     ceph_cap_string(revoking));
 
@@ -1601,7 +1606,7 @@ retry_locked:
 		}
 
 		/* completed revocation? going down and there are no caps? */
-		if (revoking && (revoking & used) == 0) {
+		if (revoking && (revoking & cap_used) == 0) {
 			dout("completed revocation of %s\n",
 			     ceph_cap_string(cap->implemented & ~cap->issued));
 			goto ack;
@@ -1678,8 +1683,8 @@ ack:
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

