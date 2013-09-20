From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/2] CacheFiles: Fix memory leak in cachefiles_check_auxdata
 error paths
Date: Fri, 20 Sep 2013 14:17:52 +0100
Message-ID: <20130920131752.24001.87500.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: Josh Boyer <jwboyer@fedoraproject.org>, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, Milosz Tanski <milosz@adfin.com>, ceph-devel@vger.kernel.org, Hongyi Jia <jiayisuse@gmail.com>
List-Id: ceph-devel.vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

In cachefiles_check_auxdata(), we allocate auxbuf but fail to free it if we
determine there's an error or that the data is stale.

Further, assigning the output of vfs_getxattr() to auxbuf->len gives problems
with checking for errors as auxbuf->len is a u16.  We don't actually need to
set auxbuf->len, so keep the length in a variable for now.  We shouldn't need
to check the upper limit of the buffer as an overflow there should be
indicated by -ERANGE.

Whilst we're at it, fscache_check_aux() returns an enum value, not an int, so
assign it to an appropriately typed variable rather than to ret.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Hongyi Jia <jiayisuse@gmail.com>
cc: Milosz Tanski <milosz@adfin.com>
---

 fs/cachefiles/xattr.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 34c88b8..12b0eef 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -162,8 +162,9 @@ int cachefiles_update_object_xattr(struct cachefiles_object *object,
 int cachefiles_check_auxdata(struct cachefiles_object *object)
 {
 	struct cachefiles_xattr *auxbuf;
+	enum fscache_checkaux validity;
 	struct dentry *dentry = object->dentry;
-	unsigned int dlen;
+	ssize_t xlen;
 	int ret;
 
 	ASSERT(dentry);
@@ -174,22 +175,22 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 	if (!auxbuf)
 		return -ENOMEM;
 
-	auxbuf->len = vfs_getxattr(dentry, cachefiles_xattr_cache,
-				   &auxbuf->type, 512 + 1);
-	if (auxbuf->len < 1)
-		return -ESTALE;
-
-	if (auxbuf->type != object->fscache.cookie->def->type)
-		return -ESTALE;
+	xlen = vfs_getxattr(dentry, cachefiles_xattr_cache,
+			    &auxbuf->type, 512 + 1);
+	ret = -ESTALE;
+	if (xlen < 1 ||
+	    auxbuf->type != object->fscache.cookie->def->type)
+		goto error;
 
-	dlen = auxbuf->len - 1;
-	ret = fscache_check_aux(&object->fscache, &auxbuf->data, dlen);
+	xlen--;
+	validity = fscache_check_aux(&object->fscache, &auxbuf->data, xlen);
+	if (validity != FSCACHE_CHECKAUX_OKAY)
+		goto error;
 
+	ret = 0;
+error:
 	kfree(auxbuf);
-	if (ret != FSCACHE_CHECKAUX_OKAY)
-		return -ESTALE;
-
-	return 0;
+	return ret;
 }
 
 /*
