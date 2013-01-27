From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/2] utime: fix narrowing conversion compiler warning in sleep()
Date: Sun, 27 Jan 2013 21:57:31 +0100
Message-ID: <1359320252-2445-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:60518 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756118Ab3A0U5f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 15:57:35 -0500
In-Reply-To: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix compiler warning:
./include/utime.h: In member function 'void utime_t::sleep()':
./include/utime.h:139:50: warning: narrowing conversion of
 '((utime_t*)this)->utime_t::tv.utime_t::<anonymous struct>::tv_sec' from
 '__u32 {aka unsigned int}' to '__time_t {aka long int}' inside { } is
 ill-formed in C++11 [-Wnarrowing]
./include/utime.h:139:50: warning: narrowing conversion of
 '((utime_t*)this)->utime_t::tv.utime_t::<anonymous struct>::tv_nsec' from
 '__u32 {aka unsigned int}' to 'long int' inside { } is
 ill-formed in C++11 [-Wnarrowing]

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/include/utime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/include/utime.h b/src/include/utime.h
index 526dec5..f433fff 100644
--- a/src/include/utime.h
+++ b/src/include/utime.h
@@ -136,7 +136,7 @@ public:
   }
 
   void sleep() {
-    struct timespec ts = { tv.tv_sec, tv.tv_nsec };
+    struct timespec ts = { (__time_t)tv.tv_sec, (long)tv.tv_nsec };
     nanosleep(&ts, &ts);
   }
 
-- 
1.8.1.1

