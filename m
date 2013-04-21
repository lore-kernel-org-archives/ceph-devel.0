From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/2] libceph: add signed type limits
Date: Sun, 21 Apr 2013 16:14:50 -0500
Message-ID: <517456CA.7040408@inktank.com>
References: <51745629.7080207@inktank.com> <51745656.60504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44499 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab3DUVOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:14:52 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so3920454ieb.26
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:14:52 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wn10sm12917527igb.2.2013.04.21.14.14.51
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:14:51 -0700 (PDT)
In-Reply-To: <51745656.60504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(Sorry, the subject line didn't match the content.
Please ignore the previous one--this is the right
patch.)


Flesh out the limits defined in <linux/ceph/decode.h> to include the
maximum and minimum values for signed type S8, S16, S32, and S64.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/decode.h |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 689f1df..9575a52 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -10,10 +10,20 @@

 /* This seemed to be the easiest place to define these */

-#define	U8_MAX	((u8)  (~0U))
-#define	U16_MAX	((u16) (~0U))
-#define	U32_MAX	((u32) (~0U))
-#define	U64_MAX	((u64) (~0ULL))
+#define	U8_MAX	((u8)(~0U))
+#define	U16_MAX	((u16)(~0U))
+#define	U32_MAX	((u32)(~0U))
+#define	U64_MAX	((u64)(~0ULL))
+
+#define	S8_MAX	((s8)(U8_MAX >> 1))
+#define	S16_MAX	((s16)(U16_MAX >> 1))
+#define	S32_MAX	((s32)(U32_MAX >> 1))
+#define	S64_MAX	((s64)(U64_MAX >> 1LL))
+
+#define	S8_MIN	((s8)(-S8_MAX - 1))
+#define	S16_MIN	((s16)(-S16_MAX - 1))
+#define	S32_MIN	((s32)(-S32_MAX - 1))
+#define	S64_MIN	((s64)(-S64_MAX - 1LL))

 /*
  * in all cases,
-- 
1.7.9.5

