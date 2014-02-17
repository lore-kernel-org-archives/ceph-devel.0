From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH] crc32: mark gnu stack non-executable
Date: Mon, 17 Feb 2014 10:40:13 +0800
Message-ID: <1392604813-12670-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50490 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbaBQCkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Feb 2014 21:40:39 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so14345771pdj.33
        for <ceph-devel@vger.kernel.org>; Sun, 16 Feb 2014 18:40:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>

https://wiki.gentoo.org/wiki/Project:Hardened/GNU_stack_quickstart
https://bugs.gentoo.org/show_bug.cgi?id=500514

Signed-off-by: Dennis Lan (dlan) <dennis.yxun@gmail.com>
---
 src/common/crc32c_intel_fast_asm.S      | 3 +++
 src/common/crc32c_intel_fast_zero_asm.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/src/common/crc32c_intel_fast_asm.S b/src/common/crc32c_intel_fast_asm.S
index 4ca5d65..68d3426 100644
--- a/src/common/crc32c_intel_fast_asm.S
+++ b/src/common/crc32c_intel_fast_asm.S
@@ -662,3 +662,6 @@ global %1_slver
 %endmacro
 ;;;       func            core, ver, snum
 slversion crc32_iscsi_00, 00,   02,  0014
+#if defined(__linux__) && defined(__ELF__)
+.section .note.GNU-stack,"",%progbits
+#endiF
diff --git a/src/common/crc32c_intel_fast_zero_asm.S b/src/common/crc32c_intel_fast_zero_asm.S
index b7246f2..9728be9 100644
--- a/src/common/crc32c_intel_fast_zero_asm.S
+++ b/src/common/crc32c_intel_fast_zero_asm.S
@@ -644,3 +644,6 @@ global %1_slver
 %endmacro
 ;;;       func            core, ver, snum
 slversion crc32_iscsi_zero_00, 00,   02,  0014
+#if defined(__linux__) && defined(__ELF__)
+.section .note.GNU-stack,"",%progbits
+#endiF
-- 
1.8.5.3

