From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/12] ceph: handle -ESTALE reply
Date: Fri,  6 Dec 2013 16:46:37 +0800
Message-ID: <1386319603-2610-7-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23366 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195Ab3LFIqw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:52 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Send requests that operate on path to directory's auth MDS if
mode == USE_AUTH_MDS. Always retry using the auth MDS if got
-ESTALE reply from non-auth MDS. Also clean up the code that
handles auth MDS change.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 03240de..46aac75 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -713,14 +713,15 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			struct dentry *dn = get_nonsnap_parent(parent);
 			inode = dn->d_inode;
 			dout("__choose_mds using nonsnap parent %p\n", inode);
-		} else if (req->r_dentry->d_inode) {
+		} else {
 			/* dentry target */
 			inode = req->r_dentry->d_inode;
-		} else {
-			/* dir + name */
-			inode = dir;
-			hash = ceph_dentry_hash(dir, req->r_dentry);
-			is_hash = true;
+			if (!inode || mode == USE_AUTH_MDS) {
+				/* dir + name */
+				inode = dir;
+				hash = ceph_dentry_hash(dir, req->r_dentry);
+				is_hash = true;
+			}
 		}
 	}
 
@@ -2161,26 +2162,16 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	 */
 	if (result == -ESTALE) {
 		dout("got ESTALE on request %llu", req->r_tid);
-		if (!req->r_inode) {
-			/* do nothing; not an authority problem */
-		} else if (req->r_direct_mode != USE_AUTH_MDS) {
+		if (req->r_direct_mode != USE_AUTH_MDS) {
 			dout("not using auth, setting for that now");
 			req->r_direct_mode = USE_AUTH_MDS;
 			__do_request(mdsc, req);
 			mutex_unlock(&mdsc->mutex);
 			goto out;
 		} else  {
-			struct ceph_inode_info *ci = ceph_inode(req->r_inode);
-			struct ceph_cap *cap = NULL;
-
-			if (req->r_session)
-				cap = ceph_get_cap_for_mds(ci,
-						   req->r_session->s_mds);
-
-			dout("already using auth");
-			if ((!cap || cap != ci->i_auth_cap) ||
-			    (cap->mseq != req->r_sent_on_mseq)) {
-				dout("but cap changed, so resending");
+			int mds = __choose_mds(mdsc, req);
+			if (mds >= 0 && mds != req->r_session->s_mds) {
+				dout("but auth changed, so resending");
 				__do_request(mdsc, req);
 				mutex_unlock(&mdsc->mutex);
 				goto out;
-- 
1.8.1.4

