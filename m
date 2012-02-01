From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 4/6] common/Throttle: FIFO throttler doesn't need to
 signal waiters when max changes
Date: Wed,  1 Feb 2012 08:54:26 -0700
Message-ID: <1328111668-10068-5-git-send-email-jaschut@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:39000 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601Ab2BAQMg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:12:36 -0500
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1A1B217A6B4
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 08:55:19 -0700 (MST)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 08:55:02 -0700
In-Reply-To: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Only wait() and get() change the throttle max.

If there are no current waiters, the thread calling wait()/get()
doesn't need to signal itself.

If there are current waiters, the thread calling wait()/get() will
signal the oldest waiter in _wait() before sleeping, so the oldest
waiter always sees the new throttle limit immediately.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/Throttle.h |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index ca72060..2f74f4a 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -25,11 +25,6 @@ public:
   }
 
 private:
-  void _reset_max(int64_t m) {
-    if (m < max && !cond.empty())
-      cond.front()->SignalOne();
-    max = m;
-  }
   bool _should_wait(int64_t c) {
     return
       max &&
@@ -74,7 +69,7 @@ public:
       *sleep_seq = sseq;
     if (m) {
       assert(m > 0);
-      _reset_max(m);
+      max = m;
     }
     bool r = _wait(0);
     wseq++;
@@ -99,7 +94,7 @@ public:
       *sleep_seq = sseq;
     if (m) {
       assert(m > 0);
-      _reset_max(m);
+      max = m;
     }
     _wait(c);
     count += c;
-- 
1.7.1


