From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 1/2] Add analogous special case for "." directory alongside ".." in _lookup
Date: Wed, 11 May 2011 22:26:46 -0700
Message-ID: <1305178007-2927-2-git-send-email-brchrisman@gmail.com>
References: <1305178007-2927-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59031 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab1ELF3F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 01:29:05 -0400
Received: by pwi15 with SMTP id 15so568133pwi.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 22:29:05 -0700 (PDT)
In-Reply-To: <1305178007-2927-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/Client.cc |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 10a6829..6ab4643 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -3267,6 +3267,11 @@ int Client::_lookup(Inode *dir, const string& dname, Inode **target)
     goto done;
   }
 
+  if (dname == ".") {
+    *target = dir;
+    goto done;
+  }
+
   if (dname.length() > NAME_MAX) {
     r = -ENAMETOOLONG;
     goto done;
-- 
1.7.1

