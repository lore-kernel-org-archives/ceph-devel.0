From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 2/3] fs/ceph/xattr.c: Use kmemdup
Date: Sun, 17 Oct 2010 21:55:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1010172154400.394@ask.diku.dk>
References: <1287341311-11161-1-git-send-email-julia@diku.dk>
 <1287341311-11161-3-git-send-email-julia@diku.dk> <1287341657.20968.61.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1287341657.20968.61.camel@Joe-Laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Sage Weil <sage@newdream.net>, kernel-janitors@vger.kernel.org, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Convert a sequence of kmalloc and memcpy to use kmemdup.

The semantic patch that performs this transformation is:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression a,flag,len;
expression arg,e1,e2;
statement S;
@@

  a =
-  \(kmalloc\|kzalloc\)(len,flag)
+  kmemdup(arg,len,flag)
  <... when != a
  if (a == NULL || ...) S
  ...>
- memcpy(a,arg,len+1);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 fs/ceph/xattr.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -u -p a/fs/ceph/xattr.c b/fs/ceph/xattr.c
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -716,10 +716,9 @@ int ceph_setxattr(struct dentry *dentry,
 
 	/* preallocate memory for xattr name, value, index node */
 	err = -ENOMEM;
-	newname = kmalloc(name_len + 1, GFP_NOFS);
+	newname = kmemdup(name, name_len + 1, GFP_NOFS);
 	if (!newname)
 		goto out;
-	memcpy(newname, name, name_len + 1);
 
 	if (val_len) {
 		newval = kmalloc(val_len + 1, GFP_NOFS);
