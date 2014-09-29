From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 4/4] ceph_erasure_code_benchmark: use 32-byte aligned input
Date: Mon, 29 Sep 2014 14:34:32 +0200
Message-ID: <1411994072-18850-5-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411994072-18850-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:42039 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbaI2Mem (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 08:34:42 -0400
Received: from coburn.home.jannau.net (55d46691.access.ecotel.net [85.212.102.145])
	by soltyk.jannau.net (Postfix) with ESMTPSA id D32573E1A18
	for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 14:34:40 +0200 (CEST)
In-Reply-To: <1411994072-18850-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The benchmark is supposed to measure the encoding/decoding speed and
not the overhead of buffer realignments.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 src/test/erasure-code/ceph_erasure_code_benchmark.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/test/erasure-code/ceph_erasure_code_benchmark.cc b/src/test/erasure-code/ceph_erasure_code_benchmark.cc
index c6a4228..71d22a7 100644
--- a/src/test/erasure-code/ceph_erasure_code_benchmark.cc
+++ b/src/test/erasure-code/ceph_erasure_code_benchmark.cc
@@ -144,6 +144,7 @@ int ErasureCodeBench::encode()
 
   bufferlist in;
   in.append(string(in_size, 'X'));
+  in.rebuild_aligned(32);
   set<int> want_to_encode;
   for (int i = 0; i < k + m; i++) {
     want_to_encode.insert(i);
@@ -183,6 +184,7 @@ int ErasureCodeBench::decode()
   }
   bufferlist in;
   in.append(string(in_size, 'X'));
+  in.rebuild_aligned(32);
 
   set<int> want_to_encode;
   for (int i = 0; i < k + m; i++) {
-- 
2.1.1

