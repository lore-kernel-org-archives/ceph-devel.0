From: Stratos Psomadakis <psomas@grnet.gr>
Subject: [PATCH] rbd: Add --json flag for the showmapped command
Date: Thu, 13 Dec 2012 17:37:12 +0200
Message-ID: <1355413032-18095-1-git-send-email-psomas@grnet.gr>
References: <50A6748C.7040303@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from worf.dev.grnet.gr ([62.217.125.132]:49046 "EHLO
	worf.dev.grnet.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab2LMPrK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 10:47:10 -0500
In-Reply-To: <50A6748C.7040303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com, Stratos Psomadakis <psomas@grnet.gr>

Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
---
Hi Josh,

This patch adds the '--json' flag to enable dumping the showmapped output in
json format (as you suggested). I'm not sure if any other rbd subcommands could
make use of this flag (so the patch is showmapped-specific atm).

Comments?

Thanks,
Stratos

 man/rbd.8  |    5 +++++
 src/rbd.cc |   54 +++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/man/rbd.8 b/man/rbd.8
index 6004244..7bf4c39 100644
--- a/man/rbd.8
+++ b/man/rbd.8
@@ -132,6 +132,11 @@ be open from more than one client at once, like during
 live migration of a virtual machine, or for use underneath
 a clustered filesystem.
 .UNINDENT
+.INDENT 0.0
+.TP
+.B \-\-json
+Dump output in json format (currently used only by showmapped).
+.UNINDENT
 .SH COMMANDS
 .INDENT 0.0
 .TP
diff --git a/src/rbd.cc b/src/rbd.cc
index 3db8978..82a72ba 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -47,6 +47,8 @@
 #include "include/rbd_types.h"
 #include "common/TextTable.h"
 
+#include "common/Formatter.h"
+
 #if defined(__linux__)
 #include <linux/fs.h>
 #endif
@@ -126,7 +128,8 @@ void usage()
 "                               format 2 supports cloning\n"
 "  --id <username>              rados user (without 'client.' prefix) to authenticate as\n"
 "  --keyfile <path>             file containing secret key for use with cephx\n"
-"  --shared <tag>               take a shared (rather than exclusive) lock\n";
+"  --shared <tag>               take a shared (rather than exclusive) lock\n"
+"  --json                       dump output in json format (currently used only by showmapped)\n";
 }
 
 static string feature_str(uint64_t features)
@@ -1198,7 +1201,7 @@ void do_closedir(DIR *dp)
     closedir(dp);
 }
 
-static int do_kernel_showmapped()
+static int do_kernel_showmapped(bool dump_json)
 {
   int r;
   bool have_output = false;
@@ -1220,12 +1223,18 @@ static int do_kernel_showmapped()
     return r;
   }
 
+  JSONFormatter jsf(false);
   TextTable tbl;
-  tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
+  if(dump_json == false) {
+    tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
+  }
+  else {
+    jsf.open_object_section("devices");
+  }
 
   do {
     if (strcmp(dent->d_name, ".") == 0 || strcmp(dent->d_name, "..") == 0)
@@ -1262,13 +1271,30 @@ static int do_kernel_showmapped()
 	   << cpp_strerror(-r) << std::endl;
       continue;
     }
-
-    tbl << dent->d_name << pool << name << snap << dev << TextTable::endrow;
+    
+    if (dump_json == false) {
+      tbl << dent->d_name << pool << name << snap << dev << TextTable::endrow;
+    }
+    else {
+      jsf.open_object_section(dent->d_name);
+      jsf.dump_string("pool", pool);
+      jsf.dump_string("name", name);
+      jsf.dump_string("snap", snap);
+      jsf.dump_string("device", dev);
+      jsf.close_section();
+    }
     have_output = true;
 
   } while ((dent = readdir(device_dir.get())));
-  if (have_output)
-    cout << tbl;
+
+  if (dump_json == false) {
+    if (have_output)
+      cout << tbl;
+  }
+  else {
+    jsf.close_section();
+    jsf.flush(cout);
+  }
 
   return 0;
 }
@@ -1505,7 +1531,7 @@ int main(int argc, const char **argv)
   const char *poolname = NULL;
   uint64_t size = 0;  // in bytes
   int order = 0;
-  bool format_specified = false;
+  bool format_specified = false, dump_json = false;
   int format = 1;
   uint64_t features = RBD_FEATURE_LAYERING;
   const char *imgname = NULL, *snapname = NULL, *destname = NULL,
@@ -1579,6 +1605,8 @@ int main(int argc, const char **argv)
       imgname = strdup(val.c_str());
     } else if (ceph_argparse_witharg(args, i, &val, "--shared", (char *)NULL)) {
       lock_tag = strdup(val.c_str());
+    } else if (ceph_argparse_flag(args, i, "--json", (char *) NULL)) {
+      dump_json = true;
     } else {
       ++i;
     }
@@ -2130,7 +2158,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
     break;
 
   case OPT_SHOWMAPPED:
-    r = do_kernel_showmapped();
+    r = do_kernel_showmapped(dump_json);
     if (r < 0) {
       cerr << "rbd: showmapped failed: " << cpp_strerror(-r) << std::endl;
       return EXIT_FAILURE;
-- 
1.7.10.4

