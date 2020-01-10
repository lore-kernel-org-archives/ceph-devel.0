From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH 2/9] ceph: print name of xattr being set in set/getxattr dout message
Date: Fri, 10 Jan 2020 15:56:40 -0500
Message-ID: <20200110205647.311023-3-jlayton@kernel.org>
References: <20200110205647.311023-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgAJU4w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:56:52 -0500
In-Reply-To: <20200110205647.311023-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/xattr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 98a9a3101cda..d58fa14c1f01 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -851,7 +851,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	req_mask = __get_request_mask(inode);
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("getxattr %p ver=%lld index_ver=%lld\n", inode,
+	dout("getxattr %p name=%s ver=%lld index_ver=%lld\n", inode, name,
 	     ci->i_xattrs.version, ci->i_xattrs.index_version);
 
 	if (ci->i_xattrs.version == 0 ||
@@ -1078,7 +1078,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		}
 	}
 
-	dout("setxattr %p issued %s\n", inode, ceph_cap_string(issued));
+	dout("setxattr %p name %s issued %s\n", inode, name,
+			ceph_cap_string(issued));
 	__build_xattrs(inode);
 
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
-- 
2.24.1
