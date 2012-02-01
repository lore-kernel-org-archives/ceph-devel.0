From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 3/6] common/Throttle: throttle in FIFO order
Date: Wed,  1 Feb 2012 08:54:25 -0700
Message-ID: <1328111668-10068-4-git-send-email-jaschut@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:38997 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab2BAQMf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:12:35 -0500
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1C9DB17A6B7
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 08:55:19 -0700 (MST)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 08:55:02 -0700
In-Reply-To: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Under heavy write load from many clients, many reader threads will
be waiting in the policy throttler, all on a single condition variable.
When a wakeup is signalled, any of those threads may receive the
signal.  This increases the variance in the message processing
latency, and in extreme cases can significantly delay a message.

This patch causes threads to exit a throttler in the same order
they entered.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/Throttle.h |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index 10560bf..ca72060 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -3,23 +3,31 @@
 
 #include "Mutex.h"
 #include "Cond.h"
+#include <list>
 
 class Throttle {
-  int64_t count, max, waiting;
+  int64_t count, max;
   uint64_t sseq, wseq;
   Mutex lock;
-  Cond cond;
+  list<Cond*> cond;
   
 public:
-  Throttle(int64_t m = 0) : count(0), max(m), waiting(0), sseq(0), wseq(0),
+  Throttle(int64_t m = 0) : count(0), max(m), sseq(0), wseq(0),
 			  lock("Throttle::lock") {
     assert(m >= 0);
   }
+  ~Throttle() {
+    while (!cond.empty()) {
+      Cond *cv = cond.front();
+      delete cv;
+      cond.pop_front();
+    }
+  }
 
 private:
   void _reset_max(int64_t m) {
-    if (m < max)
-      cond.SignalOne();
+    if (m < max && !cond.empty())
+      cond.front()->SignalOne();
     max = m;
   }
   bool _should_wait(int64_t c) {
@@ -28,19 +36,24 @@ private:
       ((c < max && count + c > max) ||   // normally stay under max
        (c >= max && count > max));       // except for large c
   }
+
   bool _wait(int64_t c) {
     bool waited = false;
-    if (_should_wait(c)) {
-      waiting += c;
+    if (_should_wait(c) || !cond.empty()) { // always wait behind other waiters.
+      Cond *cv = new Cond;
+      cond.push_back(cv);
       do {
+        if (cv != cond.front())
+          cond.front()->SignalOne();  // wake up the oldest.
 	waited = true;
-	cond.Wait(lock);
-      } while (_should_wait(c));
-      waiting -= c;
+        cv->Wait(lock);
+      } while (_should_wait(c) || cv != cond.front());
+      delete cv;
+      cond.pop_front();
 
       // wake up the next guy
-      if (waiting)
-	cond.SignalOne();
+      if (!cond.empty())
+        cond.front()->SignalOne();
     }
     return waited;
   }
@@ -101,7 +114,7 @@ public:
   bool get_or_fail(int64_t c = 1) {
     assert (c >= 0);
     Mutex::Locker l(lock);
-    if (_should_wait(c)) return false;
+    if (_should_wait(c) || !cond.empty()) return false;
     count += c;
     return true;
   }
@@ -110,7 +123,8 @@ public:
     assert(c >= 0);
     Mutex::Locker l(lock);
     if (c) {
-      cond.SignalOne();
+      if (!cond.empty())
+        cond.front()->SignalOne();
       count -= c;
       assert(count >= 0); //if count goes negative, we failed somewhere!
     }
-- 
1.7.1


