From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: validate timespec conversions
Date: Sun, 21 Apr 2013 16:15:03 -0500
Message-ID: <517456D7.8090603@inktank.com>
References: <51745629.7080207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:54296 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab3DUVPG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:15:06 -0400
Received: by mail-ia0-f171.google.com with SMTP id f27so4830452iae.16
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:15:05 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id qn10sm12852697igc.6.2013.04.21.14.15.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:15:04 -0700 (PDT)
In-Reply-To: <51745629.7080207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A ceph timespec contains 32-bit unsigned values for its seconds and
nanoseconds components.  For a standard timespec, both fields are
signed, and the seconds field is almost surely 64 bits.

Add some explicit casts so the fact that this conversion is taking
place is obvious.  Also trip a bug if we ever try to put out of
range (negative or too big) values into a ceph timespec.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/decode.h |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 9575a52..379f715 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -154,14 +154,19 @@ bad:
 static inline void ceph_decode_timespec(struct timespec *ts,
 					const struct ceph_timespec *tv)
 {
-	ts->tv_sec = le32_to_cpu(tv->tv_sec);
-	ts->tv_nsec = le32_to_cpu(tv->tv_nsec);
+	ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
+	ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
 }
 static inline void ceph_encode_timespec(struct ceph_timespec *tv,
 					const struct timespec *ts)
 {
-	tv->tv_sec = cpu_to_le32(ts->tv_sec);
-	tv->tv_nsec = cpu_to_le32(ts->tv_nsec);
+	BUG_ON(ts->tv_sec < 0);
+	BUG_ON(ts->tv_sec > (__kernel_time_t)U32_MAX);
+	BUG_ON(ts->tv_nsec < 0);
+	BUG_ON(ts->tv_nsec > (long)U32_MAX);
+
+	tv->tv_sec = cpu_to_le32((u32)ts->tv_sec);
+	tv->tv_nsec = cpu_to_le32((u32)ts->tv_nsec);
 }

 /*
-- 
1.7.9.5

