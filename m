From: Yanhu Cao <gmayyyha@gmail.com>
Subject: [PATCH] ceph: check set quota operation support before syncing setxattr.
Date: Wed,  4 Dec 2019 11:10:05 +0800
Message-ID: <20191204031005.2638-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Environment
-----------
ceph version: 12.2.*
kernel version: 4.19+

setfattr quota operation actually sends op to MDS, and settings
effective. but kclient outputs 'Operation not supported'. This may confuse
users' understandings.

If the kernel version and ceph version are not compatible, should check
quota operations are supported first, then do sync_setxattr.

reference: https://docs.ceph.com/docs/master/cephfs/quota/

Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
---
 fs/ceph/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index cb18ee637cb7..189aace75186 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1132,8 +1132,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 				    "during filling trace\n", inode);
 		err = -EBUSY;
 	} else {
-		err = ceph_sync_setxattr(inode, name, value, size, flags);
-		if (err >= 0 && check_realm) {
+		err = 0;
+		if (check_realm) {
 			/* check if snaprealm was created for quota inode */
 			spin_lock(&ci->i_ceph_lock);
 			if ((ci->i_max_files || ci->i_max_bytes) &&
@@ -1142,6 +1142,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 				err = -EOPNOTSUPP;
 			spin_unlock(&ci->i_ceph_lock);
 		}
+		if (err == 0)
+			err = ceph_sync_setxattr(inode, name, value, size, flags);
 	}
 out:
 	ceph_free_cap_flush(prealloc_cf);
-- 
2.21.0 (Apple Git-122.2)
