From: Janne Grunau <j@jannau.net>
Subject: [PATCH 3/5] aarch64: add support for HW_CAP based neon runtime detection
Date: Mon, 27 Oct 2014 19:20:34 +0100
Message-ID: <1414434036-29313-4-git-send-email-j@jannau.net>
References: <1414434036-29313-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59343 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaJ0SUn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:20:43 -0400
Received: from coburn.home.jannau.net (55d44062.access.ecotel.net [85.212.64.98])
	by soltyk.jannau.net (Postfix) with ESMTPSA id B444E3E1ADE
	for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 19:20:42 +0100 (CET)
In-Reply-To: <1414434036-29313-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 src/arch/neon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/arch/neon.c b/src/arch/neon.c
index 32c1f62..aa46595 100644
--- a/src/arch/neon.c
+++ b/src/arch/neon.c
@@ -10,7 +10,7 @@ int ceph_arch_neon = 0;
 #include <elf.h>
 #include <link.h> // ElfW macro
 
-#if __arm__
+#if __arm__ || __aarch64__
 #include <asm/hwcap.h>
 #endif // __arm__
 
@@ -42,6 +42,8 @@ int ceph_arch_neon_probe(void)
 {
 #if __arm__ && __linux__
 	ceph_arch_neon = (get_hwcap() & HWCAP_NEON) == HWCAP_NEON;
+#elif __aarch64__ && __linux__
+	ceph_arch_neon = (get_hwcap() & HWCAP_ASIMD) == HWCAP_ASIMD;
 #else
 	if (0)
 		get_hwcap();  // make compiler shut up
-- 
2.1.2

