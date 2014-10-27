From: Janne Grunau <j@jannau.net>
Subject: [PATCH 2/5] autotools: ARM/AArch64 NEON detection similar to x86
Date: Mon, 27 Oct 2014 19:20:33 +0100
Message-ID: <1414434036-29313-3-git-send-email-j@jannau.net>
References: <1414434036-29313-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59342 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaJ0SUm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:20:42 -0400
Received: from coburn.home.jannau.net (55d44062.access.ecotel.net [85.212.64.98])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 8A35D3E1ADD
	for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 19:20:41 +0100 (CET)
In-Reply-To: <1414434036-29313-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 configure.ac |  7 +++----
 m4/ax_arm.m4 | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)
 create mode 100644 m4/ax_arm.m4

diff --git a/configure.ac b/configure.ac
index d994712..feb85a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -141,9 +141,6 @@ AC_DEFUN([AC_CHECK_CC_FLAG],
 AC_CHECK_CC_FLAG([-Wtype-limits], [WARN_TYPE_LIMITS])
 AC_CHECK_CC_FLAG([-Wignored-qualifiers], [WARN_IGNORED_QUALIFIERS])
 
-# Checks for architecture stuff
-AM_CONDITIONAL([ENABLE_FPU_NEON], [case $target_cpu in arm*) true;; *) false;; esac])
-
 # Check for compiler VTA support
 AX_CHECK_COMPILE_FLAG([-fvar-tracking-assignments], [HAS_VTA_SUPPORT=1], [HAS_VTA_SUPPORT=0])
 AM_CONDITIONAL(COMPILER_HAS_VTA, [test "$HAS_VTA_SUPPORT" = 1])
@@ -537,7 +534,9 @@ AC_LANG_PUSH([C++])
 AC_CHECK_HEADER([leveldb/filter_policy.h], [AC_DEFINE([HAVE_LEVELDB_FILTER_POLICY], [1], [Defined if LevelDB supports bloom filters ])])
 AC_LANG_POP([C++])
 
-# Find supported SIMD / SSE extensions supported by the compiler
+# Find supported SIMD / NEON / SSE extensions supported by the compiler
+AX_ARM_FEATURES()
+AM_CONDITIONAL(HAVE_NEON, [ test "x$ax_cv_support_neon_ext" = "xyes"])
 AX_INTEL_FEATURES()
 AM_CONDITIONAL(HAVE_SSSE3, [ test "x$ax_cv_support_ssse3_ext" = "xyes"])
 AM_CONDITIONAL(HAVE_SSE4_PCLMUL, [ test "x$ax_cv_support_pclmuldq_ext" = "xyes"])
diff --git a/m4/ax_arm.m4 b/m4/ax_arm.m4
new file mode 100644
index 0000000..2ccc9a9
--- /dev/null
+++ b/m4/ax_arm.m4
@@ -0,0 +1,27 @@
+AC_DEFUN([AX_ARM_FEATURES],
+[
+  AC_REQUIRE([AC_CANONICAL_HOST])
+
+  case $target_cpu in
+    arm*)
+      AX_CHECK_COMPILE_FLAG(-mfpu=neon, ax_cv_support_neon_ext=yes, [])
+      if test x"$ax_cv_support_neon_ext" = x"yes"; then
+        ARM_NEON_FLAGS="-mfpu=neon -DARM_NEON"
+        AC_SUBST(ARM_NEON_FLAGS)
+        ARM_FLAGS="$ARM_FLAGS $ARM_NEON_FLAGS"
+        AC_DEFINE(HAVE_NEON,,[Support NEON instructions])
+      fi
+    ;;
+    aarch64*)
+      AX_CHECK_COMPILE_FLAG(-march=armv8-a+simd, ax_cv_support_neon_ext=yes, [])
+      if test x"$ax_cv_support_neon_ext" = x"yes"; then
+        ARM_NEON_FLAGS="-march=armv8-a+simd -DARCH_AARCH64 -DARM_NEON"
+        AC_SUBST(ARM_NEON_FLAGS)
+        ARM_FLAGS="$ARM_FLAGS $ARM_NEON_FLAGS"
+        AC_DEFINE(HAVE_NEON,,[Support NEON instructions])
+      fi
+    ;;
+  esac
+
+  AC_SUBST(ARM_FLAGS)
+])
-- 
2.1.2

