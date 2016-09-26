From: Alexander Graf <agraf@suse.de>
Subject: [PATCH] AArch64: Detect crc32 extension support from assembler
Date: Mon, 26 Sep 2016 14:17:38 +0200
Message-ID: <1474892258-178638-1-git-send-email-agraf@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933347AbcIZMRe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 08:17:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Nathan Cutler <ncutler@suse.com>, Yazen Ghannam <yazen.ghannam@linaro.org>, Steve Capper <steve.capper@linaro.org>

The used compiler may or may not be recent enough to recognize the
crc32 extended cpu type. However, it does not really have to know about
them either, since all we do is pass inline assembly instructions to
the assembler.

This patch moves the crc cpu extension detection from compiler based
to assembler based, so that we can build optimized code even when the
compiler does not know about the cpu type yet.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 m4/ax_arm.m4                | 15 +++++++++++----
 src/common/Makefile.am      |  2 +-
 src/common/crc32c_aarch64.c |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/m4/ax_arm.m4 b/m4/ax_arm.m4
index 37ea0aa..26b5258 100644
--- a/m4/ax_arm.m4
+++ b/m4/ax_arm.m4
@@ -26,12 +26,19 @@ AC_DEFUN([AX_ARM_FEATURES],
         AC_DEFINE(HAVE_NEON,,[Support NEON instructions])
         AC_SUBST(ARM_NEON_FLAGS)
       fi
-      AX_CHECK_COMPILE_FLAG(-march=armv8-a+crc, ax_cv_support_crc_ext=yes, [])
+
+      AC_LANG_SAVE
+      AC_LANG_CPLUSPLUS
+      AC_CACHE_CHECK(whether the assembler supports crc extensions,
+                     ax_cv_support_crc_ext, AC_TRY_COMPILE([
+          #define CRC32CX(crc, value) __asm__("crc32cx %w[c], %w[c], %x[v]":[c]"+r"(crc):[v]"r"(value))
+          asm(".arch_extension crc");
+          unsigned int foo(unsigned int ret) {
+              CRC32CX(ret, 0);
+              return ret;
+          }],[ foo(0); ], ax_cv_support_crc_ext=yes, []))
       if test x"$ax_cv_support_crc_ext" = x"yes"; then
-        ARM_ARCH_FLAGS="$ARM_ARCH_FLAGS+crc"
-        ARM_CRC_FLAGS="-march=armv8-a+crc -DARCH_AARCH64"
         AC_DEFINE(HAVE_ARMV8_CRC,,[Support ARMv8 CRC instructions])
-        AC_SUBST(ARM_CRC_FLAGS)
       fi
         ARM_FLAGS="$ARM_ARCH_FLAGS $ARM_DEFINE_FLAGS"
     ;;
diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index 8b30eea..e92e51c 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -144,7 +144,7 @@ noinst_LTLIBRARIES += libcommon_crc.la
 
 if HAVE_ARMV8_CRC
 libcommon_crc_aarch64_la_SOURCES = common/crc32c_aarch64.c
-libcommon_crc_aarch64_la_CFLAGS = $(AM_CFLAGS) $(ARM_CRC_FLAGS)
+libcommon_crc_aarch64_la_CFLAGS = $(AM_CFLAGS) $(ARM_ARCH_FLAGS)
 LIBCOMMON_DEPS += libcommon_crc_aarch64.la
 noinst_LTLIBRARIES += libcommon_crc_aarch64.la
 endif
diff --git a/src/common/crc32c_aarch64.c b/src/common/crc32c_aarch64.c
index d33827d..d2be6dd 100644
--- a/src/common/crc32c_aarch64.c
+++ b/src/common/crc32c_aarch64.c
@@ -2,6 +2,9 @@
 #include "include/int_types.h"
 #include "common/crc32c_aarch64.h"
 
+/* Request crc extension capabilities from the assembler */
+asm(".arch_extension crc");
+
 #define CRC32CX(crc, value) __asm__("crc32cx %w[c], %w[c], %x[v]":[c]"+r"(crc):[v]"r"(value))
 #define CRC32CW(crc, value) __asm__("crc32cw %w[c], %w[c], %w[v]":[c]"+r"(crc):[v]"r"(value))
 #define CRC32CH(crc, value) __asm__("crc32ch %w[c], %w[c], %w[v]":[c]"+r"(crc):[v]"r"(value))
-- 
1.8.5.6

