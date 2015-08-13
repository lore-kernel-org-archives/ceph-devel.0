From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] ceph: Using file->f_flags rather than flags check O_CREAT.
Date: Thu, 13 Aug 2015 09:01:32 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C1D19E799@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47782 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbbHMJBi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Aug 2015 05:01:38 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "zyan@redhat.com" <zyan@redhat.com>

Because flags removed the O_CREAT, so we should use file->f_flags.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8b79d87..e1347cf 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -210,7 +210,7 @@ int ceph_open(struct inode *inode, struct file *file)
        ihold(inode);

        req->r_num_caps = 1;
-       if (flags & O_CREAT)
+       if (file->f_flags & O_CREAT)
                parent_inode = ceph_get_dentry_parent_inode(file->f_path.dentry);
        err = ceph_mdsc_do_request(mdsc, parent_inode, req);
        iput(parent_inode);
--
2.4.3
