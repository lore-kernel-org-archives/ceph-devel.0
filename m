From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/4] Revert "ceph: fix dentry leak in splice_dentry()"
Date: Fri, 28 Sep 2018 17:43:52 +0800
Message-ID: <20180928094355.6049-1-zyan@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: idryomov@redhat.com, jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This reverts commit 8b8f53af1ed9df88a4c0fbfdf3db58f62060edf3.

splice_dentry() is used by three places. For two places, req->r_dentry
is passed to splice_dentry(). In the case of error, req->r_dentry does
not get updated. So splice_dentry() should not drop reference.

Cc: stable@vger.kernel.org #4.18
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c6bbb7aa99e4..375924b2bc86 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1140,7 +1140,6 @@ static struct dentry *splice_dentry(struct dentry *dn, struct inode *in)
 	if (IS_ERR(realdn)) {
 		pr_err("splice_dentry error %ld %p inode %p ino %llx.%llx\n",
 		       PTR_ERR(realdn), dn, in, ceph_vinop(in));
-		dput(dn);
 		dn = realdn; /* note realdn contains the error */
 		goto out;
 	} else if (realdn) {
-- 
2.17.1
