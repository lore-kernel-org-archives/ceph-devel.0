From: Janne Grunau <j@jannau.net>
Subject: [PATCH 2/3] ec: make use of added aligned buffers
Date: Mon, 15 Sep 2014 17:55:07 +0200
Message-ID: <1410796508-28711-2-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:60149 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbaIOQBS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 12:01:18 -0400
Received: from coburn.home.jannau.net (55d46944.access.ecotel.net [85.212.105.68])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 3327F3E1958
	for <ceph-devel@vger.kernel.org>; Mon, 15 Sep 2014 17:55:12 +0200 (CEST)
In-Reply-To: <1410796508-28711-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Requiring page aligned buffers and realigning the input if necessary
creates measurable oberhead. ceph_erasure_code_benchmark is ~30% faster
with this change for technique=reed_sol_van,k=2,m=1.

Also prevents a misaligned buffer when bufferlist::c_str(bufferlist)
has to allocate a new buffer to provide continuous one. See bug #9408

Signed-off-by: Janne Grunau <j@jannau.net>
---
 src/erasure-code/ErasureCode.cc | 46 +++++++++++++++++++++++++----------------
 src/erasure-code/ErasureCode.h  |  3 ++-
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/src/erasure-code/ErasureCode.cc b/src/erasure-code/ErasureCode.cc
index 5953f49..078f60b 100644
--- a/src/erasure-code/ErasureCode.cc
+++ b/src/erasure-code/ErasureCode.cc
@@ -54,22 +54,38 @@ int ErasureCode::minimum_to_decode_with_cost(const set<int> &want_to_read,
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
+
+  bufferlist prepared = raw;
+
+  if (!prepared.is_aligned()) {
+    prepared.rebuild_aligned();
+  }
+
+  for (unsigned int i = 0; i < k - !!pad_len; i++) {
+    int chunk_index = chunk_mapping.size() > 0 ? chunk_mapping[i] : i;
+    bufferlist &chunk = encoded[chunk_index];
+    chunk.substr_of(prepared, i * blocksize, blocksize);
+  }
+  if (pad_len > 0) {
+    int chunk_index = chunk_mapping.size() > 0 ? chunk_mapping[k - 1] : k - 1;
+    bufferlist &chunk = encoded[chunk_index];
+    bufferptr padded(buffer::create_aligned(blocksize));
+    raw.copy((k - 1) * blocksize, blocksize - pad_len, padded.c_str());
+    padded.zero(blocksize - pad_len, pad_len);
+    chunk.push_back(padded);
   }
-  unsigned coding_length = blocksize * m;
-  bufferptr coding(buffer::create_page_aligned(coding_length));
-  prepared->push_back(coding);
-  prepared->rebuild_page_aligned();
+  for (unsigned int i = k; i < k + m; i++) {
+    int chunk_index = chunk_mapping.size() > 0 ? chunk_mapping[i] : i;
+    bufferlist &chunk = encoded[chunk_index];
+    chunk.push_back(buffer::create_aligned(blocksize));
+  }
+
   return 0;
 }
 
@@ -80,15 +96,9 @@ int ErasureCode::encode(const set<int> &want_to_encode,
   unsigned int k = get_data_chunk_count();
   unsigned int m = get_chunk_count() - k;
   bufferlist out;
-  int err = encode_prepare(in, &out);
+  int err = encode_prepare(in, *encoded);
   if (err)
     return err;
-  unsigned blocksize = get_chunk_size(in.length());
-  for (unsigned int i = 0; i < k + m; i++) {
-    int chunk_index = chunk_mapping.size() > 0 ? chunk_mapping[i] : i;
-    bufferlist &chunk = (*encoded)[chunk_index];
-    chunk.substr_of(out, i * blocksize, blocksize);
-  }
   encode_chunks(want_to_encode, encoded);
   for (unsigned int i = 0; i < k + m; i++) {
     if (want_to_encode.count(i) == 0)
diff --git a/src/erasure-code/ErasureCode.h b/src/erasure-code/ErasureCode.h
index 7aaea95..62aa383 100644
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
2.1.0

