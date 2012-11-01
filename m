From: Alex Elder <elder@inktank.com>
Subject: [PATCH] ceph: define ceph_encode_8_safe()
Date: Thu, 01 Nov 2012 08:59:10 -0500
Message-ID: <5092802E.50607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:45620 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384Ab2KAN7N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 09:59:13 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1924632iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 06:59:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's kind of a silly macro, but ceph_encode_8_safe() is the only one
missing from an otherwise pretty complete set.  It's not used, but
neither are a couple of the others in this set.

While in there, insert some whitespace to tidy up the alignment of
the line-terminating backslashes in some of the macro definitions.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/decode.h |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 4bbf2db..cd679f2 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -52,10 +52,10 @@ static inline int ceph_has_room(void **p, void *end,
size_t n)
 	return end >= *p && n <= end - *p;
 }

-#define ceph_decode_need(p, end, n, bad)		\
-	do {						\
-		if (!likely(ceph_has_room(p, end, n)))	\
-			goto bad;			\
+#define ceph_decode_need(p, end, n, bad)			\
+	do {							\
+		if (!likely(ceph_has_room(p, end, n)))		\
+			goto bad;				\
 	} while (0)

 #define ceph_decode_64_safe(p, end, v, bad)			\
@@ -99,8 +99,8 @@ static inline int ceph_has_room(void **p, void *end,
size_t n)
  *
  * There are two possible failures:
  *   - converting the string would require accessing memory at or
- *     beyond the "end" pointer provided (-E
- *   - memory could not be allocated for the result
+ *     beyond the "end" pointer provided (-ERANGE)
+ *   - memory could not be allocated for the result (-ENOMEM)
  */
 static inline char *ceph_extract_encoded_string(void **p, void *end,
 						size_t *lenp, gfp_t gfp)
@@ -217,10 +217,10 @@ static inline void ceph_encode_string(void **p,
void *end,
 	*p += len;
 }

-#define ceph_encode_need(p, end, n, bad)		\
-	do {						\
-		if (!likely(ceph_has_room(p, end, n)))	\
-			goto bad;			\
+#define ceph_encode_need(p, end, n, bad)			\
+	do {							\
+		if (!likely(ceph_has_room(p, end, n)))		\
+			goto bad;				\
 	} while (0)

 #define ceph_encode_64_safe(p, end, v, bad)			\
@@ -231,12 +231,17 @@ static inline void ceph_encode_string(void **p,
void *end,
 #define ceph_encode_32_safe(p, end, v, bad)			\
 	do {							\
 		ceph_encode_need(p, end, sizeof(u32), bad);	\
-		ceph_encode_32(p, v);			\
+		ceph_encode_32(p, v);				\
 	} while (0)
 #define ceph_encode_16_safe(p, end, v, bad)			\
 	do {							\
 		ceph_encode_need(p, end, sizeof(u16), bad);	\
-		ceph_encode_16(p, v);			\
+		ceph_encode_16(p, v);				\
+	} while (0)
+#define ceph_encode_8_safe(p, end, v, bad)			\
+	do {							\
+		ceph_encode_need(p, end, sizeof(u8), bad);	\
+		ceph_encode_8(p, v);				\
 	} while (0)

 #define ceph_encode_copy_safe(p, end, pv, n, bad)		\
-- 
1.7.9.5

