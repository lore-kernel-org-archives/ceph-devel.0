From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH RESEND] ceph: fix bounds checking macros
Date: Sun, 15 Jan 2012 01:06:50 -0500
Message-ID: <1326607610-6867-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44010 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2AOGMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jan 2012 01:12:10 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

The bounds check (*p + n > end) can be bypassed with a large n due to
pointer wraparound, especially when n is read from network.  Change the
check to a safer form (n > end - *p).

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 include/linux/ceph/decode.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index c5b6939..c0b1e46 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -12,6 +12,11 @@
  *   void *end    pointer to end of buffer (last byte + 1)
  */
 
+static inline int ceph_need(void **p, void *end, size_t n)
+{
+	return (end < *p) || (n > end - *p);
+}
+
 static inline u64 ceph_decode_64(void **p)
 {
 	u64 v = get_unaligned_le64(*p);
@@ -47,7 +52,7 @@ static inline void ceph_decode_copy(void **p, void *pv, size_t n)
  */
 #define ceph_decode_need(p, end, n, bad)		\
 	do {						\
-		if (unlikely(*(p) + (n) > (end))) 	\
+		if (unlikely(ceph_need(p, end, n)))	\
 			goto bad;			\
 	} while (0)
 
@@ -166,7 +171,7 @@ static inline void ceph_encode_string(void **p, void *end,
 
 #define ceph_encode_need(p, end, n, bad)		\
 	do {						\
-		if (unlikely(*(p) + (n) > (end))) 	\
+		if (unlikely(ceph_need(p, end, n)))	\
 			goto bad;			\
 	} while (0)
 
-- 
1.7.5.4

