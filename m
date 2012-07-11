From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: re-phrase ceph_decode_need()
Date: Wed, 11 Jul 2012 17:00:42 -0500
Message-ID: <4FFDF78A.7050606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:36249 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030192Ab2GKWAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 18:00:44 -0400
Received: by yhpp61 with SMTP id p61so2049112yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 15:00:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For some reason, the way ceph_decode_need() is written throws
me off whenever I look at it:

	if (!likely(ceph_has_room(p, end, n)))

I read it as "not likely ceph has room," which is not what
it really means.  Despite being a double-negative, which I
normally avoid, I like this better:

	if (unlikely(!ceph_has_room(p, end, n)))

What do you think?

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/decode.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/include/linux/ceph/decode.h
===================================================================
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -51,10 +51,10 @@ static inline int ceph_has_room(void **p
 	return end >= *p && n <= end - *p;
 }

-#define ceph_decode_need(p, end, n, bad)		\
-	do {						\
-		if (!likely(ceph_has_room(p, end, n)))	\
-			goto bad;			\
+#define ceph_decode_need(p, end, n, bad)			\
+	do {							\
+		if (unlikely(!ceph_has_room(p, end, n)))	\
+			goto bad;				\
 	} while (0)

 #define ceph_decode_64_safe(p, end, v, bad)			\
