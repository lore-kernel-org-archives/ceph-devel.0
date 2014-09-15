From: Janne Grunau <j@jannau.net>
Subject: [PATCH 3/3] ceph_erasure_code_benchmark: align the encoding input
Date: Mon, 15 Sep 2014 17:55:08 +0200
Message-ID: <1410796508-28711-3-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:60147 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbaIOQBS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 12:01:18 -0400
Received: from coburn.home.jannau.net (55d46944.access.ecotel.net [85.212.105.68])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 2D2663E1959
	for <ceph-devel@vger.kernel.org>; Mon, 15 Sep 2014 17:55:13 +0200 (CEST)
In-Reply-To: <1410796508-28711-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The benchmark is supposed to measure the encoding speed and not the
overhead of buffer realignments.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 src/test/erasure-code/ceph_erasure_code_benchmark.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/test/erasure-code/ceph_erasure_code_benchmark.cc b/src/test/erasure-code/ceph_erasure_code_benchmark.cc
index 84bd7da..f63fd77 100644
--- a/src/test/erasure-code/ceph_erasure_code_benchmark.cc
+++ b/src/test/erasure-code/ceph_erasure_code_benchmark.cc
@@ -144,6 +144,7 @@ int ErasureCodeBench::encode()
 
   bufferlist in;
   in.append(string(in_size, 'X'));
+  in.rebuild_aligned();
   set<int> want_to_encode;
   for (int i = 0; i < k + m; i++) {
     want_to_encode.insert(i);
-- 
2.1.0

