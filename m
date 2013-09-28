From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] ceph: check rinfo->dir_dir before dereferencing it.
Date: Sat, 28 Sep 2013 20:34:44 +0800
Message-ID: <1380371685-11577-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53954 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117Ab3I1MfP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 28 Sep 2013 08:35:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, dan.carpenter@oracle.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 49d4de0..6f0a35c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1288,7 +1288,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	u64 r_readdir_offset = req->r_readdir_offset;
 	u32 frag = le32_to_cpu(rhead->args.readdir.frag);
 
-	if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
+	if (rinfo->dir_dir &&
+	    le32_to_cpu(rinfo->dir_dir->frag) != frag) {
 		dout("readdir_prepopulate got new frag %x -> %x\n",
 		     frag, le32_to_cpu(rinfo->dir_dir->frag));
 		frag = le32_to_cpu(rinfo->dir_dir->frag);
-- 
1.8.1.4

