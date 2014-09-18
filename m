From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 3/3] ceph_erasure_code_benchmark: align the encoding input
Date: Thu, 18 Sep 2014 12:33:55 +0200
Message-ID: <1411036435-18860-4-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411036435-18860-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:44984 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379AbaIRKeG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 06:34:06 -0400
Received: from coburn.home.jannau.net (55d4585a.access.ecotel.net [85.212.88.90])
	by soltyk.jannau.net (Postfix) with ESMTPSA id AD2F93E14AF
	for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 12:34:04 +0200 (CEST)
In-Reply-To: <1411036435-18860-1-git-send-email-j@jannau.net>
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
index c6a4228..3fedcd5 100644
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

