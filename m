From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 3/3] ceph: fix unsafe dcache access in ceph_encode_dentry_release
Date: Tue, 13 Dec 2016 13:04:13 -0500
Message-ID: <1481652253-14780-4-git-send-email-jlayton@redhat.com>
References: <1481652253-14780-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1481652253-14780-1-git-send-email-jlayton@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, linux-fsdevel@vger.kernel.org, dhowells@redhat.com, viro@ZenIV.linux.org.uk
List-Id: ceph-devel.vger.kernel.org

Accessing d_parent requires some sort of locking or it could vanish
out from under us. Since we take the d_lock anyway, use that to fetch
d_parent and take a reference to it, and then use that reference to
call ceph_encode_inode_release.

Link: http://tracker.ceph.com/issues/18148
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 16e6ded0b7f2..6bc5c1efbb26 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3834,7 +3834,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       int mds, int drop, int unless)
 {
-	struct inode *dir = d_inode(dentry->d_parent);
+	struct dentry *parent;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int force = 0;
@@ -3849,9 +3849,12 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (di->lease_session && di->lease_session->s_mds == mds)
 		force = 1;
+	parent = dget(dentry->d_parent);
 	spin_unlock(&dentry->d_lock);
 
-	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
+	ret = ceph_encode_inode_release(p, d_inode(parent), mds, drop,
+					unless, force);
+	dput(parent);
 
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
-- 
2.7.4

