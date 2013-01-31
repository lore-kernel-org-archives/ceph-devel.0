From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] ceph-filestore-dump.cc: don't use po::value<string>()->required()
Date: Thu, 31 Jan 2013 15:41:19 +0100
Message-ID: <1359643279-1370-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58349 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab3AaOlZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Jan 2013 09:41:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, David Zafman <david.zafman@inktank.com>

Don't use po::value<string>()->required() since this breaks build on
RHEL/CentOs6. Check if the options are set as in the code of other
ceph parts.

Move some checks up in the code to validate options as soon
as possible. Remove printing 'help' twice.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/tools/ceph-filestore-dump.cc | 57 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/src/tools/ceph-filestore-dump.cc b/src/tools/ceph-filestore-dump.cc
index d470468..d967c12 100644
--- a/src/tools/ceph-filestore-dump.cc
+++ b/src/tools/ceph-filestore-dump.cc
@@ -53,13 +53,13 @@ int main(int argc, char **argv)
   po::options_description desc("Allowed options");
   desc.add_options()
     ("help", "produce help message")
-    ("filestore-path", po::value<string>(&fspath)->required(),
+    ("filestore-path", po::value<string>(&fspath),
      "path to filestore directory, mandatory")
-    ("journal-path", po::value<string>(&jpath)->required(),
+    ("journal-path", po::value<string>(&jpath),
      "path to journal, mandatory")
-    ("pgid", po::value<string>(&pgid)->required(),
+    ("pgid", po::value<string>(&pgid),
      "PG id, mandatory")
-    ("type", po::value<string>(&type)->required(),
+    ("type", po::value<string>(&type),
      "Type which is 'info' or 'log'")
     ("debug", "Enable diagnostic output to stderr")
     ;
@@ -72,13 +72,39 @@ int main(int argc, char **argv)
     po::notify(vm);
   }
   catch(...) {
-    cout << desc << "\n";
+    cout << desc << std::endl;
     exit(1);
   }
      
-  //Never get here with required() options
+  if (!vm.count("filestore-path")) {
+    cout << "Must provide filestore-path" << std::endl
+	 << desc << std::endl;
+    return 1;
+  } 
+  if (!vm.count("journal-path")) {
+    cout << "Must provide journal-path" << std::endl
+	 << desc << std::endl;
+    return 1;
+  } 
+  if (!vm.count("pgid")) {
+    cout << "Must provide pgid" << std::endl
+	 << desc << std::endl;
+    return 1;
+  } 
+  if (!vm.count("type")) {
+    cout << "Must provide type ('info' or 'log')" << std::endl
+	 << desc << std::endl;
+    return 1;
+  } 
+  
   if (vm.count("help")) {
-    cout << desc << "\n";
+    cout << desc << std::endl;
+    return 1;
+  }
+
+  if (fspath.length() == 0 || jpath.length() == 0 || pgid.length() == 0 ||
+    (type != "info" && type != "log")) {
+    cerr << "Invalid params" << std::endl;
     exit(1);
   }
 
@@ -106,23 +132,6 @@ int main(int argc, char **argv)
   g_ceph_context->_conf->apply_changes(NULL);
   g_conf = g_ceph_context->_conf;
 
-  if (!vm.count("filestore-path") || !vm.count("journal-path")) {
-    cout << "Must provide filestore-path and journal-path" << std::endl
-	 << desc << std::endl;
-    return 1;
-  }
-
-  if (vm.count("help")) {
-    cout << desc << std::endl;
-    return 1;
-  }
-
-  if (fspath.length() == 0 || jpath.length() == 0 || pgid.length() == 0 ||
-    (type != "info" && type != "log")) {
-    cerr << "Invalid params" << std::endl;
-    exit(1);
-  }
-
   //Verify that fspath really is an osd store
   struct stat st;
   if (::stat(fspath.c_str(), &st) == -1) {
-- 
1.8.1.1

