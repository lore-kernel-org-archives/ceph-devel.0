From: Roald van Loon <roaldvanloon@gmail.com>
Subject: [PATCH] config: replace direct access with macros
Date: Sat, 15 Dec 2012 10:38:12 +0100
Message-ID: <CAN04cT40wMYBWNKAY54L59oWKfWg+tnKVG0Ncoju2xzBE-F9rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50671 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab2LOJiM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 04:38:12 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so7161452ieb.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Dec 2012 01:38:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For the new configuration framework, I need some way
to be able to move slowly between the 'old' way
(md_config_t) and the upcoming 'new' way. I suggest we
use macros for this. I've attached this patch as an
example of how I think we could accomplish this (that's
why I included multiple diffs instead of mailing them
separately).

First of all, I've included a stripped down config/config.h
with the macro definitions. I also forward-included this
header in the current common/config.h so I don't have to
touch a large number of files.

I've also changed some entries in MonMap.cc::build_initial
to show how we can use the macros.

If this is OK with you guys, I want to slowly replace access
to configuration value with these macros.

Signed-off-by: Roald van Loon <roaldvanloon@gmail.com>
---
 src/common/config.h |    2 ++
 src/config/config.h |   36 ++++++++++++++++++++++++++++++++++++
 src/mon/MonMap.cc   |   18 +++++++++---------
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/src/common/config.h b/src/common/config.h
index 86d240f..c9e2d1c 100644
--- a/src/common/config.h
+++ b/src/common/config.h
@@ -262,4 +262,6 @@ enum config_subsys_id {
   ceph_subsys_max
 };

+#include "config/config.h" // forward include this here, to allow
easy transition
+
 #endif
diff --git a/src/config/config.h b/src/config/config.h
new file mode 100644
index 0000000..3eb1c05
--- /dev/null
+++ b/src/config/config.h
@@ -0,0 +1,36 @@
+#ifndef CEPH_CONFIG_CONFIG_H
+#define CEPH_CONFIG_CONFIG_H
+
+#ifdef CEPH_USE_NEW_CONFIG
+
+
+#else /* CEPH_USE_NEW_CONFIG */
+
+#define CEPH_GLOBAL_CFG(type, paramname) \
+  g_ceph_context->_conf->paramname
+#define CEPH_GLOBAL_CFG_ID \
+  g_ceph_context->_conf->name.get_id()
+
+#define CEPH_GLOBAL_CFG_HAS(paramname) true
+#define CEPH_GLOBAL_CFG_STR(paramname) g_ceph_context->_conf->paramname
+#define CEPH_GLOBAL_CFG_UUID(paramname) CEPH_CFG(uuid_d, paramname)
+#define CEPH_GLOBAL_CFG_ADDR(paramname) CEPH_CFG(entity_addr_t, paramname)
+#define CEPH_GLOBAL_CFG_INT(paramname) CEPH_CFG(int, paramname)
+#define CEPH_GLOBAL_CFG_BOOL(paramname) CEPH_CFG(bool, paramname)
+
+#define CEPH_CFG(cct, type, paramname) \
+  cct->_conf->paramname
+#define CEPH_CFG_ID(cct) \
+  cct->_conf->name.get_id()
+
+#define CEPH_CFG_HAS(cct, paramname) true
+#define CEPH_CFG_STR(cct, paramname) cct->_conf->paramname
+#define CEPH_CFG_UUID(cct, paramname) CEPH_CFG(cct, uuid_d, paramname)
+#define CEPH_CFG_ADDR(cct, paramname) CEPH_CFG(cct, entity_addr_t, paramname)
+#define CEPH_CFG_INT(cct, paramname) CEPH_CFG(cct, int, paramname)
+#define CEPH_CFG_BOOL(cct, paramname) CEPH_CFG(cct, bool, paramname)
+
+#endif /* CEPH_USE_NEW_CONFIG */
+
+
+#endif /* CEPH_CONFIG_CONFIG_H */
diff --git a/src/mon/MonMap.cc b/src/mon/MonMap.cc
index 5a9d6ce..e444ba4 100644
--- a/src/mon/MonMap.cc
+++ b/src/mon/MonMap.cc
@@ -244,31 +244,31 @@ int MonMap::build_initial(CephContext *cct,
ostream& errout)
 {
   const md_config_t *conf = cct->_conf;
   // file?
-  if (!conf->monmap.empty()) {
+  if (!CEPH_CFG_STR(cct, monmap).empty()) {
     int r;
     try {
-      r = read(conf->monmap.c_str());
+      r = read(CEPH_CFG_STR(cct, monmap).c_str());
     }
     catch (const buffer::error &e) {
       r = -EINVAL;
     }
     if (r >= 0)
       return 0;
-    errout << "unable to read/decode monmap from " << conf->monmap
-        << ": " << cpp_strerror(-r) << std::endl;
+    errout << "unable to read/decode monmap from " << CEPH_CFG_STR(cct, monmap)
+   << ": " << cpp_strerror(-r) << std::endl;
     return r;
   }

   // fsid from conf?
-  if (!cct->_conf->fsid.is_zero()) {
-    fsid = cct->_conf->fsid;
+  if (!CEPH_CFG_UUID(cct, fsid).is_zero()) {
+    fsid = CEPH_CFG_UUID(cct, fsid);
   }

   // -m foo?
-  if (!conf->mon_host.empty()) {
-    int r = build_from_host_list(conf->mon_host, "noname-");
+  if (!CEPH_CFG_STR(cct, mon_host).empty()) {
+    int r = build_from_host_list(CEPH_CFG_STR(cct, mon_host), "noname-");
     if (r < 0) {
-      errout << "unable to parse addrs in '" << conf->mon_host << "'"
+      errout << "unable to parse addrs in '" << CEPH_CFG_STR(cct,
mon_host) << "'"
              << std::endl;
       return r;
     }
