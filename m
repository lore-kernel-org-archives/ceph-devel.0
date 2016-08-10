From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH] client: don't use special inode for /..
Date: Wed, 10 Aug 2016 12:30:30 -0400
Message-ID: <1470846630-830-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45772 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932604AbcHJS4d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Aug 2016 14:56:33 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9081EA0C51
	for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 16:30:31 +0000 (UTC)
Received: from tlielax.poochiereds.net (ovpn-116-46.rdu2.redhat.com [10.10.116.46])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7AGUU58003351
	for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 12:30:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The CEPH_INO_DOTDOT thing is quite strange. Under most OS (Linux
included), the parent of the root is itself. IOW, at the root, '.' and
'..' refer to the same inode.

Change the ceph client to do the same, as this allows users to get
valid stat info for '..', as well as elimnating some special-casing.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 src/client/Client.cc  | 13 +++----------
 src/include/ceph_fs.h |  1 -
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 2df632fc0e08..77f464ad76ae 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -7244,9 +7244,9 @@ int Client::readdir_r_cb(dir_result_t *d, add_dirent_cb_t cb, void *p)
       fill_stat(in, &st);
       fill_dirent(&de, "..", S_IFDIR, st.st_ino, next_off);
     } else {
-      /* must be at the root (no parent),
-       * so we add the dotdot with a special inode (3) */
-      fill_dirent(&de, "..", S_IFDIR, CEPH_INO_DOTDOT, next_off);
+      /* must be at the root (no parent), so fill out with same info as "." */
+      fill_stat(diri, &st);
+      fill_dirent(&de, "..", S_IFDIR, st.st_ino, next_off);
     }
 
 
@@ -9684,13 +9684,6 @@ int Client::ll_getattr(Inode *in, struct stat *attr, int uid, int gid)
   tout(cct) << "ll_getattr" << std::endl;
   tout(cct) << vino.ino.val << std::endl;
 
-  /* special case for dotdot (..) */
-  if (vino.ino.val == CEPH_INO_DOTDOT) {
-    attr->st_mode = S_IFDIR | 0755;
-    attr->st_nlink = 2;
-    return 0;
-  }
-
   int res;
   if (vino.snapid < CEPH_NOSNAP)
     res = 0;
diff --git a/src/include/ceph_fs.h b/src/include/ceph_fs.h
index 772e475ccc91..1610aaf17cc2 100644
--- a/src/include/ceph_fs.h
+++ b/src/include/ceph_fs.h
@@ -28,7 +28,6 @@
 
 #define CEPH_INO_ROOT   1
 #define CEPH_INO_CEPH   2       /* hidden .ceph dir */
-#define CEPH_INO_DOTDOT 3	/* used by ceph fuse for parent (..) */
 #define CEPH_INO_LOST_AND_FOUND 4	/* reserved ino for use in recovery */
 
 /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
-- 
2.7.4

