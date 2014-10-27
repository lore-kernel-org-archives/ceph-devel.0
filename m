From: Janne Grunau <j@jannau.net>
Subject: [PATCH 1/5] erasure-code: conditionally build jerasure sse3/sse4 plugins
Date: Mon, 27 Oct 2014 19:20:32 +0100
Message-ID: <1414434036-29313-2-git-send-email-j@jannau.net>
References: <1414434036-29313-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59340 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbaJ0SUm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:20:42 -0400
Received: from coburn.home.jannau.net (55d44062.access.ecotel.net [85.212.64.98])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 706AF3E1A21
	for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 19:20:40 +0100 (CET)
In-Reply-To: <1414434036-29313-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 configure.ac                          | 2 ++
 src/erasure-code/jerasure/Makefile.am | 4 ++++
 src/test/erasure-code/Makefile.am     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index 7a0691d..d994712 100644
--- a/configure.ac
+++ b/configure.ac
@@ -539,6 +539,8 @@ AC_LANG_POP([C++])
 
 # Find supported SIMD / SSE extensions supported by the compiler
 AX_INTEL_FEATURES()
+AM_CONDITIONAL(HAVE_SSSE3, [ test "x$ax_cv_support_ssse3_ext" = "xyes"])
+AM_CONDITIONAL(HAVE_SSE4_PCLMUL, [ test "x$ax_cv_support_pclmuldq_ext" = "xyes"])
 
 # kinetic osd backend?
 AC_ARG_WITH([kinetic],
diff --git a/src/erasure-code/jerasure/Makefile.am b/src/erasure-code/jerasure/Makefile.am
index 86763af..142c612 100644
--- a/src/erasure-code/jerasure/Makefile.am
+++ b/src/erasure-code/jerasure/Makefile.am
@@ -71,7 +71,9 @@ if LINUX
 libec_jerasure_sse3_la_LDFLAGS += -export-symbols-regex '.*__erasure_code_.*'
 endif
 
+if HAVE_SSSE3
 erasure_codelib_LTLIBRARIES += libec_jerasure_sse3.la
+endif
 
 libec_jerasure_sse4_la_SOURCES = ${jerasure_sources}
 libec_jerasure_sse4_la_CFLAGS = ${AM_CFLAGS}  \
@@ -98,7 +100,9 @@ if LINUX
 libec_jerasure_sse4_la_LDFLAGS += -export-symbols-regex '.*__erasure_code_.*'
 endif
 
+if HAVE_SSE4_PCLMUL
 erasure_codelib_LTLIBRARIES += libec_jerasure_sse4.la
+endif
 
 libec_jerasure_la_SOURCES = \
 	erasure-code/jerasure/ErasureCodePluginSelectJerasure.cc
diff --git a/src/test/erasure-code/Makefile.am b/src/test/erasure-code/Makefile.am
index 60f6ee1..958ae4d 100644
--- a/src/test/erasure-code/Makefile.am
+++ b/src/test/erasure-code/Makefile.am
@@ -74,7 +74,9 @@ libec_test_jerasure_sse4_la_CFLAGS = ${AM_CFLAGS}
 libec_test_jerasure_sse4_la_CXXFLAGS= ${AM_CXXFLAGS}
 libec_test_jerasure_sse4_la_LIBADD = $(PTHREAD_LIBS) $(EXTRALIBS)
 libec_test_jerasure_sse4_la_LDFLAGS = ${AM_LDFLAGS} -export-symbols-regex '.*__erasure_code_.*'
+if HAVE_SSE4_PCLMUL
 erasure_codelib_LTLIBRARIES += libec_test_jerasure_sse4.la
+endif
 
 libec_test_jerasure_sse3_la_SOURCES = test/erasure-code/TestJerasurePluginSSE3.cc
 test/erasure-code/TestJerasurePluginSSE3.cc: ./ceph_ver.h
@@ -82,7 +84,9 @@ libec_test_jerasure_sse3_la_CFLAGS = ${AM_CFLAGS}
 libec_test_jerasure_sse3_la_CXXFLAGS= ${AM_CXXFLAGS}
 libec_test_jerasure_sse3_la_LIBADD = $(PTHREAD_LIBS) $(EXTRALIBS)
 libec_test_jerasure_sse3_la_LDFLAGS = ${AM_LDFLAGS} -export-symbols-regex '.*__erasure_code_.*'
+if HAVE_SSSE3
 erasure_codelib_LTLIBRARIES += libec_test_jerasure_sse3.la
+endif
 
 libec_test_jerasure_generic_la_SOURCES = test/erasure-code/TestJerasurePluginGeneric.cc
 test/erasure-code/TestJerasurePluginGeneric.cc: ./ceph_ver.h
-- 
2.1.2

