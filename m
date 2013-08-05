From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/3] ceph: fix request max size
Date: Mon,  5 Aug 2013 14:10:29 +0800
Message-ID: <1375683030-28305-9-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63899 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab3HEGKm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:42 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

ceph_check_caps() requests new max size only when there is Fw cap.
If we call check_max_size() while there is no Fw cap. It updates
i_wanted_max_size and calls ceph_check_caps(), but ceph_check_caps()
does nothing. Later when Fw cap is issued, we call check_max_size()
again. But i_wanted_max_size is equal to 'endoff' at this time, so
check_max_size() doesn't call ceph_check_caps() and we end up with
waiting for the new max size forever.

The fix is duplicate ceph_check_caps()'s "request max size" code in
check_max_size(), and make try_get_cap_refs() wait for the Fw cap
before retry requesting new max size.

This patch also removes the "endoff > (inode->i_size << 1)" check
in check_max_size(). It's useless because there is no corresponding
logical in ceph_check_caps().

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 0e94d27..49590a0 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2076,11 +2076,13 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 		spin_lock(&ci->i_ceph_lock);
 	}
 
-	if (need & CEPH_CAP_FILE_WR) {
+	have = __ceph_caps_issued(ci, &implemented);
+
+	if (have & need & CEPH_CAP_FILE_WR) {
 		if (endoff >= 0 && endoff > (loff_t)ci->i_max_size) {
 			dout("get_cap_refs %p endoff %llu > maxsize %llu\n",
 			     inode, endoff, ci->i_max_size);
-			if (endoff > ci->i_wanted_max_size) {
+			if (endoff > ci->i_requested_max_size) {
 				*check_max = 1;
 				ret = 1;
 			}
@@ -2095,7 +2097,6 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 			goto out;
 		}
 	}
-	have = __ceph_caps_issued(ci, &implemented);
 
 	if ((have & need) == need) {
 		/*
@@ -2137,14 +2138,17 @@ static void check_max_size(struct inode *inode, loff_t endoff)
 
 	/* do we need to explicitly request a larger max_size? */
 	spin_lock(&ci->i_ceph_lock);
-	if ((endoff >= ci->i_max_size ||
-	     endoff > (inode->i_size << 1)) &&
-	    endoff > ci->i_wanted_max_size) {
+	if (endoff >= ci->i_max_size && endoff > ci->i_wanted_max_size) {
 		dout("write %p at large endoff %llu, req max_size\n",
 		     inode, endoff);
 		ci->i_wanted_max_size = endoff;
-		check = 1;
 	}
+	/* duplicate ceph_check_caps()'s logical */
+	if (ci->i_auth_cap &&
+	    (ci->i_auth_cap->issued & CEPH_CAP_FILE_WR) &&
+	    ci->i_wanted_max_size > ci->i_max_size &&
+	    ci->i_wanted_max_size > ci->i_requested_max_size)
+		check = 1;
 	spin_unlock(&ci->i_ceph_lock);
 	if (check)
 		ceph_check_caps(ci, CHECK_CAPS_AUTHONLY, NULL);
-- 
1.8.1.4

