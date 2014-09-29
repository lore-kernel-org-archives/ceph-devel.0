From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 3/4] erasure code: use 32-byte aligned buffers
Date: Mon, 29 Sep 2014 14:34:31 +0200
Message-ID: <1411994072-18850-4-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411994072-18850-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:42038 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbaI2Mel (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 08:34:41 -0400
Received: from coburn.home.jannau.net (55d46691.access.ecotel.net [85.212.102.145])
	by soltyk.jannau.net (Postfix) with ESMTPSA id D83203E1989
	for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 14:34:39 +0200 (CEST)
In-Reply-To: <1411994072-18850-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Requiring page aligned buffers and realigning the input if necessary
creates measurable oberhead. ceph_erasure_code_benchmark is between
10-20% faster depending on the workload.

Also prevents a misaligned buffer when bufferlist::c_str(bufferlist)
has to allocate a new buffer to provide continuous one. See bug #9408

Signed-off-by: Janne Grunau <j@jannau.net>
---
 src/erasure-code/ErasureCode.cc | 59 ++++++++++++++++++++++++++++-------------
 src/erasure-code/ErasureCode.h  |  3 ++-
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/src/erasure-code/ErasureCode.cc b/src/erasure-code/ErasureCode.cc
index 8b6c57f..7087f51 100644
--- a/src/erasure-code/ErasureCode.cc
+++ b/src/erasure-code/ErasureCode.cc
@@ -22,6 +22,8 @@
 #include "common/strtol.h"
 #include "ErasureCode.h"
 
+static const unsigned SIMD_ALIGN = 32;
+
 int ErasureCode::chunk_index(unsigned int i) const
 {
   return chunk_mapping.size() > i ? chunk_mapping[i] : i;
@@ -59,22 +61,46 @@ int ErasureCode::minimum_to_decode_with_cost(const set<int> &want_to_read,
 }
 
 int ErasureCode::encode_prepare(const bufferlist &raw,
-                                bufferlist *prepared) const
+                                map<int, bufferlist> &encoded) const
 {
   unsigned int k = get_data_chunk_count();
   unsigned int m = get_chunk_count() - k;
   unsigned blocksize = get_chunk_size(raw.length());
-  unsigned padded_length = blocksize * k;
-  *prepared = raw;
-  if (padded_length - raw.length() > 0) {
-    bufferptr pad(padded_length - raw.length());
-    pad.zero();
-    prepared->push_back(pad);
+  unsigned pad_len = blocksize * k - raw.length();
+  unsigned padded_chunks = k - raw.length() / blocksize;
+  bufferlist prepared = raw;
+
+  if (!prepared.is_aligned(SIMD_ALIGN)) {
+    // splice padded chunks off to make the rebuild faster
+    if (padded_chunks)
+      prepared.splice((k - padded_chunks) * blocksize,
+                      padded_chunks * blocksize - pad_len);
+    prepared.rebuild_aligned(SIMD_ALIGN);
+  }
+
+  for (unsigned int i = 0; i < k - padded_chunks; i++) {
+    bufferlist &chunk = encoded[chunk_index(i)];
+    chunk.substr_of(prepared, i * blocksize, blocksize);
+  }
+  if (padded_chunks) {
+    unsigned remainder = raw.length() - (k - padded_chunks) * blocksize;
+    bufferptr buf(buffer::create_aligned(blocksize, SIMD_ALIGN));
+
+    raw.copy((k - padded_chunks) * blocksize, remainder, buf.c_str());
+    buf.zero(remainder, blocksize - remainder);
+    encoded[chunk_index(k-padded_chunks)].push_back(buf);
+
+    for (unsigned int i = k - padded_chunks + 1; i < k; i++) {
+      bufferptr buf(buffer::create_aligned(blocksize, SIMD_ALIGN));
+      buf.zero();
+      encoded[chunk_index(i)].push_back(buf);
+    }
+  }
+  for (unsigned int i = k; i < k + m; i++) {
+    bufferlist &chunk = encoded[chunk_index(i)];
+    chunk.push_back(buffer::create_aligned(blocksize, SIMD_ALIGN));
   }
-  unsigned coding_length = blocksize * m;
-  bufferptr coding(buffer::create_page_aligned(coding_length));
-  prepared->push_back(coding);
-  prepared->rebuild_page_aligned();
+
   return 0;
 }
 
@@ -85,14 +111,9 @@ int ErasureCode::encode(const set<int> &want_to_encode,
   unsigned int k = get_data_chunk_count();
   unsigned int m = get_chunk_count() - k;
   bufferlist out;
-  int err = encode_prepare(in, &out);
+  int err = encode_prepare(in, *encoded);
   if (err)
     return err;
-  unsigned blocksize = get_chunk_size(in.length());
-  for (unsigned int i = 0; i < k + m; i++) {
-    bufferlist &chunk = (*encoded)[chunk_index(i)];
-    chunk.substr_of(out, i * blocksize, blocksize);
-  }
   encode_chunks(want_to_encode, encoded);
   for (unsigned int i = 0; i < k + m; i++) {
     if (want_to_encode.count(i) == 0)
@@ -132,11 +153,11 @@ int ErasureCode::decode(const set<int> &want_to_read,
   unsigned blocksize = (*chunks.begin()).second.length();
   for (unsigned int i =  0; i < k + m; i++) {
     if (chunks.find(i) == chunks.end()) {
-      bufferptr ptr(buffer::create_page_aligned(blocksize));
+      bufferptr ptr(buffer::create_aligned(blocksize, SIMD_ALIGN));
       (*decoded)[i].push_front(ptr);
     } else {
       (*decoded)[i] = chunks.find(i)->second;
-      (*decoded)[i].rebuild_page_aligned();
+      (*decoded)[i].rebuild_aligned(SIMD_ALIGN);
     }
   }
   return decode_chunks(want_to_read, chunks, decoded);
diff --git a/src/erasure-code/ErasureCode.h b/src/erasure-code/ErasureCode.h
index ab00120..11c3491 100644
--- a/src/erasure-code/ErasureCode.h
+++ b/src/erasure-code/ErasureCode.h
@@ -46,7 +46,8 @@ namespace ceph {
                                             const map<int, int> &available,
                                             set<int> *minimum);
 
-    int encode_prepare(const bufferlist &raw, bufferlist *prepared) const;
+    int encode_prepare(const bufferlist &raw,
+                       map<int, bufferlist> &encoded) const;
 
     virtual int encode(const set<int> &want_to_encode,
                        const bufferlist &in,
-- 
2.1.1

