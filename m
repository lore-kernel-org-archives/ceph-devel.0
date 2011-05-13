From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 1/2] fix null deref when callback invoked en route from readdir_r rather than readdirplus_r
Date: Thu, 12 May 2011 23:39:37 -0700
Message-ID: <1305268778-18691-2-git-send-email-brchrisman@gmail.com>
References: <1305268778-18691-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54628 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159Ab1EMGjy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 02:39:54 -0400
Received: by pzk9 with SMTP id 9so1043834pzk.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 23:39:54 -0700 (PDT)
In-Reply-To: <1305268778-18691-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/Client.cc |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 8b8fcf1..dbac2c9 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -4330,8 +4330,12 @@ static int _readdir_single_dirent_cb(void *p, struct dirent *de, struct stat *st
     return -1;
 
   *c->de = *de;
-  *c->st = *st;
-  *c->stmask = stmask;
+  if (c->st) {
+    *c->st = *st;
+  }
+  if (c->stmask) {
+    *c->stmask = stmask;
+  }
   c->full = true;
   return 0;  
 }
-- 
1.7.1

