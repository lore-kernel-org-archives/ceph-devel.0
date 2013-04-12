From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/4] ceph: add osd request to inode unsafe list in advance
Date: Fri, 12 Apr 2013 16:11:08 +0800
Message-ID: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54081 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835Ab3DLILQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Apr 2013 04:11:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: greg@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Right now we add osd requests to inode unsafe list after starting them.
The problem here is osd request may have already finished when adding
it to inode unsafe list.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 14 ++++++++++----
 fs/ceph/file.c | 30 ++++++++++++------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 124e8a1..0da2e94 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1806,10 +1806,16 @@ static void sync_write_wait(struct inode *inode)
 	if (list_empty(head))
 		goto out;
 
-	/* set upper bound as _last_ entry in chain */
-	req = list_entry(head->prev, struct ceph_osd_request,
-			 r_unsafe_item);
-	last_tid = req->r_tid;
+	/* set upper bound as last started request */
+	last_tid = (u64)-1;
+	list_for_each_entry_reverse(req, head, r_unsafe_item) {
+		if (req->r_tid != (u64)-1) {
+			last_tid = req->r_tid;
+			break;
+		}
+	}
+	if (last_tid == (u64)-1)
+		goto out;
 
 	do {
 		ceph_osdc_get_request(req);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b7e6caa..546a705 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -571,7 +571,14 @@ more:
 		if ((file->f_flags & O_SYNC) == 0) {
 			/* get a second commit callback */
 			req->r_safe_callback = sync_write_commit;
+			req->r_inode = inode;
+			req->r_tid = (u64)-1;
 			own_pages = true;
+			spin_lock(&ci->i_unsafe_lock);
+			list_add_tail(&req->r_unsafe_item,
+				      &ci->i_unsafe_writes);
+			spin_unlock(&ci->i_unsafe_lock);
+			ceph_get_cap_refs(ci, CEPH_CAP_FILE_WR);
 		}
 	}
 	osd_req_op_extent_osd_data_pages(req, 0, true, pages, len,
@@ -582,25 +589,12 @@ more:
 
 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!ret) {
-		if (req->r_safe_callback) {
-			/*
-			 * Add to inode unsafe list only after we
-			 * start_request so that a tid has been assigned.
-			 */
-			spin_lock(&ci->i_unsafe_lock);
-			list_add_tail(&req->r_unsafe_item,
-				      &ci->i_unsafe_writes);
-			spin_unlock(&ci->i_unsafe_lock);
-			ceph_get_cap_refs(ci, CEPH_CAP_FILE_WR);
-		}
-		
 		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
-		if (ret < 0 && req->r_safe_callback) {
-			spin_lock(&ci->i_unsafe_lock);
-			list_del_init(&req->r_unsafe_item);
-			spin_unlock(&ci->i_unsafe_lock);
-			ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
-		}
+	} else if (req->r_safe_callback) {
+		spin_lock(&ci->i_unsafe_lock);
+		list_del_init(&req->r_unsafe_item);
+		spin_unlock(&ci->i_unsafe_lock);
+		ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
 	}
 
 	if (file->f_flags & O_DIRECT)
-- 
1.7.11.7

