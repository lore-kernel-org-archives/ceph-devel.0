From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Don't crash during initialization when working without an osd journal.
Date: Thu, 07 Apr 2011 10:49:49 -0300
Message-ID: <ortyeayxvm.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:54748 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751087Ab1DGN7N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 09:59:13 -0400
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p37DnqBF025533
	for <ceph-devel@vger.kernel.org>; Thu, 7 Apr 2011 10:49:54 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p37DnpWo005873
	for <ceph-devel@vger.kernel.org>; Thu, 7 Apr 2011 10:49:51 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/os/FileStore.cc |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index 940662c..0fb99e6 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -1471,7 +1471,8 @@ void FileStore::start_logger(int whoami, utime_t tare)
   char name[80];
   snprintf(name, sizeof(name), "osd.%d.fs.log", whoami);
   logger = new ProfLogger(name, (ProfLogType*)&fs_logtype);
-  journal->logger = logger;
+  if (journal)
+    journal->logger = logger;
   logger_add(logger);  
   logger_tare(tare);
   logger_start();
@@ -1481,7 +1482,8 @@ void FileStore::stop_logger()
 {
   dout(10) << "stop_logger" << dendl;
   if (logger) {
-    journal->logger = NULL;
+    if (journal)
+      journal->logger = NULL;
     logger_remove(logger);
     delete logger;
     logger = NULL;
-- 
1.7.4.2


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
