From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 3/3] ceph: return -ERANGE if virtual xattr value didn't fit in buffer
Date: Fri, 14 Jun 2019 09:46:25 -0400
Message-ID: <20190614134625.6870-4-jlayton@kernel.org>
References: <20190614134625.6870-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614134625.6870-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: akpm@linux-foundation.org, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com
List-Id: ceph-devel.vger.kernel.org

The getxattr manpage states that we should return ERANGE if the
destination buffer size is too small to hold the value.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index a1cd9613be98..e3246c27f2da 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -805,8 +805,11 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		if (err)
 			return err;
 		err = -ENODATA;
-		if (!(vxattr->exists_cb && !vxattr->exists_cb(ci)))
+		if (!(vxattr->exists_cb && !vxattr->exists_cb(ci))) {
 			err = vxattr->getxattr_cb(ci, value, size);
+			if (size && size < err)
+				err = -ERANGE;
+		}
 		return err;
 	}
 
-- 
2.21.0
