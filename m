From: Brian Chrisman <brchrisman@gmail.com>
Subject: patch: opening 'security.' xattr namespace
Date: Thu, 24 Mar 2011 13:12:09 -0700
Message-ID: <AANLkTimR7wJunc-oyixPv0uS5+25_CxMceEAcDOPTGdz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59179 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855Ab1CXUMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2011 16:12:10 -0400
Received: by vws1 with SMTP id 1so313321vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2011 13:12:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

used by samba to store ACLs and by others.

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 540d91c..3930604 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -5674,7 +5674,7 @@ int Client::ll_setxattr(vinodeno_t vino, const
char *name, const void *value, si
   tout << name << std::endl;

   // only user xattrs, for now
-  if (strncmp(name, "user.", 5))
+  if (strncmp(name, "user.", 5) || strncmp(name, "security.", 9))
     return -EOPNOTSUPP;

   Inode *in = _ll_get_inode(vino);
