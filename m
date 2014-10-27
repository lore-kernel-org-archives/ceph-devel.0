From: Janne Grunau <j@jannau.net>
Subject: [PATCH 5/5] erasure-code: build and use a NEON jerasure variant
Date: Mon, 27 Oct 2014 19:20:36 +0100
Message-ID: <1414434036-29313-6-git-send-email-j@jannau.net>
References: <1414434036-29313-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59345 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbaJ0SUq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:20:46 -0400
Received: from coburn.home.jannau.net (55d44062.access.ecotel.net [85.212.64.98])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 263503E1A21
	for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 19:20:45 +0100 (CET)
In-Reply-To: <1414434036-29313-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 .../jerasure/ErasureCodePluginSelectJerasure.cc    |  3 +++
 src/erasure-code/jerasure/Makefile.am              | 24 +++++++++++++++++++++
 src/test/erasure-code/Makefile.am                  | 10 +++++++++
 src/test/erasure-code/TestJerasurePluginNEON.cc    | 25 ++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 src/test/erasure-code/TestJerasurePluginNEON.cc

diff --git a/src/erasure-code/jerasure/ErasureCodePluginSelectJerasure.cc b/src/erasure-code/jerasure/ErasureCodePluginSelectJerasure.cc
index 53c7026..32560b4 100644
--- a/src/erasure-code/jerasure/ErasureCodePluginSelectJerasure.cc
+++ b/src/erasure-code/jerasure/ErasureCodePluginSelectJerasure.cc
@@ -19,6 +19,7 @@
 #include "common/debug.h"
 #include "arch/probe.h"
 #include "arch/intel.h"
+#include "arch/neon.h"
 #include "erasure-code/ErasureCodePlugin.h"
 
 #define dout_subsys ceph_subsys_osd
@@ -44,6 +45,8 @@ static string get_variant() {
 	     ceph_arch_intel_sse3 &&
 	     ceph_arch_intel_sse2) {
     return "sse3";
+  } else if (ceph_arch_neon) {
+    return "neon";
   } else {
     return "generic";
   }
diff --git a/src/erasure-code/jerasure/Makefile.am b/src/erasure-code/jerasure/Makefile.am
index 142c612..de9c14a 100644
--- a/src/erasure-code/jerasure/Makefile.am
+++ b/src/erasure-code/jerasure/Makefile.am
@@ -50,6 +50,30 @@ endif
 
 erasure_codelib_LTLIBRARIES += libec_jerasure_generic.la
 
+libec_jerasure_neon_la_SOURCES = ${jerasure_sources}                                       \
+                                  erasure-code/jerasure/gf-complete/src/neon/gf_w4_neon.c  \
+                                  erasure-code/jerasure/gf-complete/src/neon/gf_w8_neon.c  \
+                                  erasure-code/jerasure/gf-complete/src/neon/gf_w16_neon.c \
+                                  erasure-code/jerasure/gf-complete/src/neon/gf_w32_neon.c \
+                                  erasure-code/jerasure/gf-complete/src/neon/gf_w64_neon.c
+libec_jerasure_neon_la_CFLAGS = ${AM_CFLAGS}  \
+	${ARM_NEON_FLAGS} \
+	-I$(srcdir)/erasure-code/jerasure/gf-complete/include \
+	-I$(srcdir)/erasure-code/jerasure/jerasure/include
+libec_jerasure_neon_la_CXXFLAGS= ${AM_CXXFLAGS} \
+	${ARM_NEON_FLAGS} \
+	-I$(srcdir)/erasure-code/jerasure/gf-complete/include \
+	-I$(srcdir)/erasure-code/jerasure/jerasure/include
+libec_jerasure_neon_la_LIBADD = $(LIBCRUSH) $(PTHREAD_LIBS) $(EXTRALIBS)
+libec_jerasure_neon_la_LDFLAGS = ${AM_LDFLAGS} -version-info 2:0:0
+if LINUX
+libec_jerasure_neon_la_LDFLAGS += -export-symbols-regex '.*__erasure_code_.*'
+endif
+
+if HAVE_NEON
+erasure_codelib_LTLIBRARIES += libec_jerasure_neon.la
+endif
+
 libec_jerasure_sse3_la_SOURCES = ${jerasure_sources}
 libec_jerasure_sse3_la_CFLAGS = ${AM_CFLAGS}  \
 	${INTEL_SSE_FLAGS} \
diff --git a/src/test/erasure-code/Makefile.am b/src/test/erasure-code/Makefile.am
index 958ae4d..7f9e27f 100644
--- a/src/test/erasure-code/Makefile.am
+++ b/src/test/erasure-code/Makefile.am
@@ -68,6 +68,16 @@ libec_fail_to_register_la_LIBADD = $(PTHREAD_LIBS) $(EXTRALIBS)
 libec_fail_to_register_la_LDFLAGS = ${AM_LDFLAGS} -export-symbols-regex '.*__erasure_code_.*'
 erasure_codelib_LTLIBRARIES += libec_fail_to_register.la
 
+libec_test_jerasure_neon_la_SOURCES = test/erasure-code/TestJerasurePluginNEON.cc
+test/erasure-code/TestJerasurePluginNEON.cc: ./ceph_ver.h
+libec_test_jerasure_neon_la_CFLAGS = ${AM_CFLAGS}
+libec_test_jerasure_neon_la_CXXFLAGS= ${AM_CXXFLAGS}
+libec_test_jerasure_neon_la_LIBADD = $(PTHREAD_LIBS) $(EXTRALIBS)
+libec_test_jerasure_neon_la_LDFLAGS = ${AM_LDFLAGS} -export-symbols-regex '.*__erasure_code_.*'
+if HAVE_NEON
+erasure_codelib_LTLIBRARIES += libec_test_jerasure_neon.la
+endif
+
 libec_test_jerasure_sse4_la_SOURCES = test/erasure-code/TestJerasurePluginSSE4.cc
 test/erasure-code/TestJerasurePluginSSE4.cc: ./ceph_ver.h
 libec_test_jerasure_sse4_la_CFLAGS = ${AM_CFLAGS}
diff --git a/src/test/erasure-code/TestJerasurePluginNEON.cc b/src/test/erasure-code/TestJerasurePluginNEON.cc
new file mode 100644
index 0000000..3060485
--- /dev/null
+++ b/src/test/erasure-code/TestJerasurePluginNEON.cc
@@ -0,0 +1,25 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
+// vim: ts=8 sw=2 smarttab
+/*
+ * Ceph distributed storage system
+ *
+ * Copyright (C) 2014 Cloudwatt <libre.licensing@cloudwatt.com>
+ * Copyright (C) 2014 Red Hat <contact@redhat.com>
+ *
+ * Author: Loic Dachary <loic@dachary.org>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ */
+
+#include "ceph_ver.h"
+
+extern "C" const char *__erasure_code_version() { return CEPH_GIT_NICE_VER; }
+
+extern "C" int __erasure_code_init(char *plugin_name, char *directory)
+{
+  return -444;
+}
-- 
2.1.2

