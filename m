From: Sergiy Kibrik <sakib@meta.ua>
Subject: [PATCH] ceph: fix xattr search while getxattr
Date: Fri, 14 Jan 2011 01:07:02 +0200
Message-ID: <201101140107.02627.sakib@meta.ua>
Reply-To: sakib@meta.ua
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.meta.ua ([194.0.131.41]:38571 "EHLO smtp.meta.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756883Ab1AMXZv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 Jan 2011 18:25:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Reproducible: always
How to reproduce:
 $ touch file
 $ setfattr -n user.bare -v bare file
 $ setfattr -n user.bar -v bar
 $ getfattr -d file

 user.bar="bar"
 user.bare="bar"

This is because one xattr name is a sub-string of another,
so search picks up first matching name -- a shorter one.
Patch fixes search routine to do full-length string comparison.

Signed-off-by: Sergiy Kibrik <sakib@meta.ua>
---
 fs/ceph/xattr.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 6e12a6b..3d1d1d5 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -219,13 +219,15 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct ceph_inode_xattr *xattr = NULL;
-	int c;
+	int c, name_len = strlen(name);
 
 	p = &ci->i_xattrs.index.rb_node;
 	while (*p) {
 		parent = *p;
 		xattr = rb_entry(parent, struct ceph_inode_xattr, node);
-		c = strncmp(name, xattr->name, xattr->name_len);
+		c = name_len - xattr->name_len;
+		if (!c)
+			c = strncmp(name, xattr->name, xattr->name_len);
 		if (c < 0)
 			p = &(*p)->rb_left;
 		else if (c > 0)
-- 
1.7.1

