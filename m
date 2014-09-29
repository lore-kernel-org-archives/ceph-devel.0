From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 2/4] erasure code: use a function for the chunk mapping index
Date: Mon, 29 Sep 2014 14:34:30 +0200
Message-ID: <1411994072-18850-3-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411994072-18850-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:42037 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbaI2Mek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 08:34:40 -0400
Received: from coburn.home.jannau.net (55d46691.access.ecotel.net [85.212.102.145])
	by soltyk.jannau.net (Postfix) with ESMTPSA id E0DE03E1A19
	for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 14:34:38 +0200 (CEST)
In-Reply-To: <1411994072-18850-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 src/erasure-code/ErasureCode.cc | 14 ++++++++------
 src/erasure-code/ErasureCode.h  |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/erasure-code/ErasureCode.cc b/src/erasure-code/ErasureCode.cc
index 5953f49..8b6c57f 100644
--- a/src/erasure-code/ErasureCode.cc
+++ b/src/erasure-code/ErasureCode.cc
@@ -22,6 +22,11 @@
 #include "common/strtol.h"
 #include "ErasureCode.h"
 
+int ErasureCode::chunk_index(unsigned int i) const
+{
+  return chunk_mapping.size() > i ? chunk_mapping[i] : i;
+}
+
 int ErasureCode::minimum_to_decode(const set<int> &want_to_read,
                                    const set<int> &available_chunks,
                                    set<int> *minimum)
@@ -85,8 +90,7 @@ int ErasureCode::encode(const set<int> &want_to_encode,
     return err;
   unsigned blocksize = get_chunk_size(in.length());
   for (unsigned int i = 0; i < k + m; i++) {
-    int chunk_index = chunk_mapping.size() > 0 ? chunk_mapping[i] : i;
-    bufferlist &chunk = (*encoded)[chunk_index];
+    bufferlist &chunk = (*encoded)[chunk_index(i)];
     chunk.substr_of(out, i * blocksize, blocksize);
   }
   encode_chunks(want_to_encode, encoded);
@@ -223,15 +227,13 @@ int ErasureCode::decode_concat(const map<int, bufferlist> &chunks,
   set<int> want_to_read;
 
   for (unsigned int i = 0; i < get_data_chunk_count(); i++) {
-    int chunk = chunk_mapping.size() > i ? chunk_mapping[i] : i;
-    want_to_read.insert(chunk);
+    want_to_read.insert(chunk_index(i));
   }
   map<int, bufferlist> decoded_map;
   int r = decode(want_to_read, chunks, &decoded_map);
   if (r == 0) {
     for (unsigned int i = 0; i < get_data_chunk_count(); i++) {
-      int chunk = chunk_mapping.size() > i ? chunk_mapping[i] : i;
-      decoded->claim_append(decoded_map[chunk]);
+      decoded->claim_append(decoded_map[chunk_index(i)]);
     }
   }
   return r;
diff --git a/src/erasure-code/ErasureCode.h b/src/erasure-code/ErasureCode.h
index 7aaea95..ab00120 100644
--- a/src/erasure-code/ErasureCode.h
+++ b/src/erasure-code/ErasureCode.h
@@ -85,6 +85,9 @@ namespace ceph {
 
     virtual int decode_concat(const map<int, bufferlist> &chunks,
 			      bufferlist *decoded);
+
+  private:
+    int chunk_index(unsigned int i) const;
   };
 }
 
-- 
2.1.1

