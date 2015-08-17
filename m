From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] fs/ceph: No need get inode of parent in ceph_open.
Date: Mon, 17 Aug 2015 08:43:26 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C1D19FBFC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30852 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbbHQIni convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 04:43:38 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "zyan@redhat.com" <zyan@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

For ceph_open, it already get the parent inode. So no need to get again.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 fs/ceph/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8b79d87..5ecd3dc 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -210,10 +210,7 @@ int ceph_open(struct inode *inode, struct file *file)
        ihold(inode);

        req->r_num_caps = 1;
-       if (flags & O_CREAT)
-               parent_inode = ceph_get_dentry_parent_inode(file->f_path.dentry);
        err = ceph_mdsc_do_request(mdsc, parent_inode, req);
-       iput(parent_inode);
        if (!err)
                err = ceph_init_file(inode, file, req->r_fmode);
        ceph_mdsc_put_request(req);
--
2.4.3

