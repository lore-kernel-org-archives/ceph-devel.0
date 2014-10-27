From: Janne Grunau <j@jannau.net>
Subject: [PATCH 4/5] erasure-code: switch gf-complete's submodule branch to master
Date: Mon, 27 Oct 2014 19:20:35 +0100
Message-ID: <1414434036-29313-5-git-send-email-j@jannau.net>
References: <1414434036-29313-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59344 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaJ0SUp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:20:45 -0400
Received: from coburn.home.jannau.net (55d44062.access.ecotel.net [85.212.64.98])
	by soltyk.jannau.net (Postfix) with ESMTPSA id DF4E33E19D7
	for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 19:20:43 +0100 (CET)
In-Reply-To: <1414434036-29313-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The master branch of gf-complete has NEON optimisations for ARMv7 and
64-bit ARMv8 the jerasure erasure code plugin can use.
---
 .gitmodules                           | 2 +-
 src/erasure-code/jerasure/gf-complete | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index 54fe238..6108802 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -14,7 +14,7 @@
 [submodule "src/erasure-code/jerasure/gf-complete"]
 	path = src/erasure-code/jerasure/gf-complete
 	url = https://github.com/ceph/gf-complete.git
-	branch = v1-ceph
+	branch = master
 [submodule "src/rocksdb"]
 	path = src/rocksdb
 	url = git://github.com/ceph/rocksdb
diff --git a/src/erasure-code/jerasure/gf-complete b/src/erasure-code/jerasure/gf-complete
index 191e710..70dd94a 160000
--- a/src/erasure-code/jerasure/gf-complete
+++ b/src/erasure-code/jerasure/gf-complete
@@ -1 +1 @@
-Subproject commit 191e7105b2b75f7f48ef23dfab9ae72275363168
+Subproject commit 70dd94ae38f2d20dd78532a6dfd1310fdfb4a884
-- 
2.1.2

