From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH] cfuse recognizing same xattr subset as kernel client
Date: Fri, 8 Apr 2011 15:42:16 -0700
Message-ID: <BANLkTikZKszEiZqUNygTx+BxbAy8j3b_LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45490 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab1DHWmR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 18:42:17 -0400
Received: by vws1 with SMTP id 1so3041995vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2011 15:42:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hopefully this patch is formatted/signed off correctly.

Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/Client.cc |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index aa50452..95f102a 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -5715,8 +5715,8 @@ int Client::ll_setxattr(vinodeno_t vino, const
char *name, const void *value, si
   tout << vino.ino.val << std::endl;
   tout << name << std::endl;

-  // only user xattrs, for now
-  if (strncmp(name, "user.", 5))
+  // same xattrs supported by kernel client
+  if (strncmp(name, "user.", 5) && strncmp(name, "security.", 9) &&
strncmp(name, "trusted.", 8))
     return -EOPNOTSUPP;

   Inode *in = _ll_get_inode(vino);
--
1.7.1
