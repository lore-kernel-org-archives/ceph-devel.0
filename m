From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: don't include ceph.{file,dir}.layout vxattr in listxattr()
Date: Mon, 24 Mar 2014 19:28:57 +0800
Message-ID: <1395660537-4972-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5166 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbaCXL3C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Mar 2014 07:29:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

This avoids 'cp -a' modifying layout of new files/directories.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 28549d5..c9c2b88 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -231,7 +231,7 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
 		.name_size = sizeof("ceph.dir.layout"),
 		.getxattr_cb = ceph_vxattrcb_layout,
 		.readonly = false,
-		.hidden = false,
+		.hidden = true,
 		.exists_cb = ceph_vxattrcb_layout_exists,
 	},
 	XATTR_LAYOUT_FIELD(dir, layout, stripe_unit),
@@ -258,7 +258,7 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
 		.name_size = sizeof("ceph.file.layout"),
 		.getxattr_cb = ceph_vxattrcb_layout,
 		.readonly = false,
-		.hidden = false,
+		.hidden = true,
 		.exists_cb = ceph_vxattrcb_layout_exists,
 	},
 	XATTR_LAYOUT_FIELD(file, layout, stripe_unit),
-- 
1.8.5.3

