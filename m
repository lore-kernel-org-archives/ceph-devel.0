From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH] include: ceph: Fix encode and decode type conversions
Date: Sun, 14 Feb 2016 19:01:53 -0800
Message-ID: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33186 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbcBODC2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Feb 2016 22:02:28 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so79425533pfb.0
        for <ceph-devel@vger.kernel.org>; Sun, 14 Feb 2016 19:02:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org

long/ kernel_time_t is 32 bit on a 32 bit system and
64 bit on a 64 bit system.

ceph_encode_timespec() encodes only the lower 32 bits on
a 64 bit system and encodes all of 32 bits on a 32bit
system.

ceph_decode_timespec() decodes 32 bit tv_sec and tv_nsec
into kernel_time_t/ long.

The encode and decode functions do not match when the
values are negative:

Consider the following scenario on a 32 bit system:
When a negative number is cast to u32 as encode does, the
value is positive and is greater than INT_MAX. Decode reads
back this value. And, this value cannot be represented by
long on 32 bit systems. So by section 6.3.1.3 of the
C99 standard, the result is implementation defined.

Consider the following scenario on a 64 bit system:
When a negative number is cast to u32 as encode does, the
value is positive. This value is later assigned by decode
function by a cast to long. Since this value can be
represented in long data type, this becomes a positive
value greater than INT_MAX. But, the value encoded was
negative, so the encode and decode functions do not match.

Change the decode function as follows to overcome the above
bug:
The decode should first cast the value to a s64 this will
be positive value greater than INT_MAX(in case of a negative
encoded value)and then cast this value again as s32, which
drops the higher order 32 bits.
On 32 bit systems, this is the right value in kernel_time_t/
long.
On 64 bit systems, assignment to kernel_time_t/ long
will sign extend this value to reflect the signed bit encoded.

Assume ceph timestamp ranges permitted are 1902..2038.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/ceph/decode.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index a6ef9cc..e777e99 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -137,8 +137,8 @@ bad:
 static inline void ceph_decode_timespec(struct timespec *ts,
 					const struct ceph_timespec *tv)
 {
-	ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
-	ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
+	ts->tv_sec = (s32)(s64)le32_to_cpu(tv->tv_sec);
+	ts->tv_nsec = (s32)(s64)le32_to_cpu(tv->tv_nsec);
 }
 static inline void ceph_encode_timespec(struct ceph_timespec *tv,
 					const struct timespec *ts)
-- 
1.9.1

