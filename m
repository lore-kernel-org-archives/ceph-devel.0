From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ceph: remove redundant declaration
Date: Tue,  3 Mar 2015 18:57:49 +0100
Message-ID: <1425405470-9002-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

ceph_aops was already defined extern in addr.c section

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/ceph/super.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 04c8124..02ca99c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -881,7 +881,6 @@ extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
 
 /* file.c */
 extern const struct file_operations ceph_file_fops;
-extern const struct address_space_operations ceph_aops;
 
 extern int ceph_open(struct inode *inode, struct file *file);
 extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
-- 
1.7.9.5
