From: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: [PATCH] fs: ceph: new helper: file_inode(file)
Date: Wed, 11 Dec 2013 13:49:11 +0800
Message-ID: <52A7FCD7.2080809@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:28633 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3LKFuS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 00:50:18 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, majianpeng <majianpeng@gmail.com>, yunchuanwen@ubuntukylin.com, liwang@ubuntukylin.com, zheng.z.yan@intel.com
Cc: ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, milosz@adfin.com


Signed-off-by: Libo Chen <clbchenlibo.chen@huawei.com>
---
 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3de8982..7549bd6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1018,7 +1018,7 @@ static long ceph_fallocate(struct file *file, int mode,
 				loff_t offset, loff_t length)
 {
 	struct ceph_file_info *fi = file->private_data;
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_client *osdc =
 		&ceph_inode_to_client(inode)->client->osdc;
-- 
1.8.2.2

