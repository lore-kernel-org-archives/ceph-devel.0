From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 32/85] ceph: fix listxattr vxattr buffer length calculation
Date: Fri, 26 Jul 2019 09:38:42 -0400
Message-ID: <20190726133936.11177-32-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit 2b2abcac8c251d1c77a4cc9d9f248daefae0fb4e ]

ceph_listxattr() incorrectly returns a length based on the static
ceph_vxattrs_name_size() value, which only takes into account whether
vxattrs are hidden, ignoring vxattr.exists_cb().

When filling the xattr buffer ceph_listxattr() checks VXATTR_FLAG_HIDDEN
and vxattr.exists_cb(). If both are false, we return an incorrect
(oversize) length.

Fix this behaviour by always calculating the vxattrs length at runtime,
taking both vxattr.hidden and vxattr.exists_cb() into account.

This bug is only exposed with the new "ceph.snap.btime" vxattr, as all
other vxattrs with a non-null exists_cb also carry VXATTR_FLAG_HIDDEN.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/xattr.c | 54 +++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 0cc42c8879e9..b9df49e13d9c 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -897,10 +897,9 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	struct inode *inode = d_inode(dentry);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_vxattr *vxattrs = ceph_inode_vxattrs(inode);
-	u32 vir_namelen = 0;
+	bool len_only = (size == 0);
 	u32 namelen;
 	int err;
-	u32 len;
 	int i;
 
 	spin_lock(&ci->i_ceph_lock);
@@ -919,38 +918,45 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	err = __build_xattrs(inode);
 	if (err < 0)
 		goto out;
-	/*
-	 * Start with virtual dir xattr names (if any) (including
-	 * terminating '\0' characters for each).
-	 */
-	vir_namelen = ceph_vxattrs_name_size(vxattrs);
 
-	/* adding 1 byte per each variable due to the null termination */
+	/* add 1 byte for each xattr due to the null termination */
 	namelen = ci->i_xattrs.names_size + ci->i_xattrs.count;
-	err = -ERANGE;
-	if (size && vir_namelen + namelen > size)
-		goto out;
-
-	err = namelen + vir_namelen;
-	if (size == 0)
-		goto out;
+	if (!len_only) {
+		if (namelen > size) {
+			err = -ERANGE;
+			goto out;
+		}
+		names = __copy_xattr_names(ci, names);
+		size -= namelen;
+	}
 
-	names = __copy_xattr_names(ci, names);
 
 	/* virtual xattr names, too */
-	err = namelen;
 	if (vxattrs) {
 		for (i = 0; vxattrs[i].name; i++) {
-			if (!(vxattrs[i].flags & VXATTR_FLAG_HIDDEN) &&
-			    !(vxattrs[i].exists_cb &&
-			      !vxattrs[i].exists_cb(ci))) {
-				len = sprintf(names, "%s", vxattrs[i].name);
-				names += len + 1;
-				err += len + 1;
+			size_t this_len;
+
+			if (vxattrs[i].flags & VXATTR_FLAG_HIDDEN)
+				continue;
+			if (vxattrs[i].exists_cb && !vxattrs[i].exists_cb(ci))
+				continue;
+
+			this_len = strlen(vxattrs[i].name) + 1;
+			namelen += this_len;
+			if (len_only)
+				continue;
+
+			if (this_len > size) {
+				err = -ERANGE;
+				goto out;
 			}
+
+			memcpy(names, vxattrs[i].name, this_len);
+			names += this_len;
+			size -= this_len;
 		}
 	}
-
+	err = namelen;
 out:
 	spin_unlock(&ci->i_ceph_lock);
 	return err;
-- 
2.20.1
