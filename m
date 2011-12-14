From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 2/3] ceph: fix bounds check macros ceph_decode_need and ceph_encode_need
Date: Wed, 14 Dec 2011 15:24:32 -0500
Message-ID: <1323894273-13904-3-git-send-email-xi.wang@gmail.com>
References: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:36907 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494Ab1LNU0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 15:26:12 -0500
Received: by qadb15 with SMTP id b15so829784qad.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 12:26:09 -0800 (PST)
In-Reply-To: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

Given a large n, the bounds check (*p + n > end) can be bypassed due to
pointer wraparound.  A safer check is (n > end - *p).

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 include/linux/ceph/decode.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index c5b6939..ea6db7b 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -12,6 +12,11 @@
  *   void *end    pointer to end of buffer (last byte + 1)
  */
 
+static inline int ceph_need(void **p, void *end, size_t n)
+{
+	return ((end < *p) || (n > end - *p));
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

