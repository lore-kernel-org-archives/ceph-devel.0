From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 2/3] common/Throttle: Add timed_wait().
Date: Wed, 22 Jun 2011 12:26:26 -0600
Message-ID: <1308767187-10376-4-git-send-email-jaschut@sandia.gov>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53504 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758023Ab1FVS1Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2011 14:27:16 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1A6EC173229
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:27:14 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:26:58 -0600
In-Reply-To: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

This will enable SimpleMessenger to send keepalives to clients while
blocked in the policy throttler.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/Throttle.h |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index 8fd2625..5a028cc 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -27,6 +27,9 @@ private:
       ((c < max && count + c > max) ||   // normally stay under max
        (c >= max && count > max));       // except for large c
   }
+
+  /* Returns true if it had to block/wait, false otherwise.
+   */
   bool _wait(int64_t c) {
     bool waited = false;
     if (_should_wait(c)) {
@@ -44,6 +47,28 @@ private:
     return waited;
   }
 
+  /* Returns true if it timed out while blocked/waiting,
+   * false otherwise.
+   */
+  bool _timed_wait(utime_t interval, int64_t c) {
+    if (_should_wait(c)) {
+      utime_t timeout_at = g_clock.now() + interval;
+      waiting += c;
+      do {
+	if (cond.WaitUntil(lock, timeout_at)) {
+	  waiting -= c;
+	  return true;
+	}
+      } while (_should_wait(c));
+      waiting -= c;
+
+      // wake up the next guy
+      if (waiting)
+	cond.SignalOne();
+    }
+    return false;
+  }
+
 public:
   int64_t get_current() {
     Mutex::Locker l(lock);
@@ -79,6 +104,21 @@ public:
     count += c;
   }
 
+  /* Returns true if it got the requested amount within
+   * the specified interval, false otherwise.
+   */
+  bool timed_get(utime_t interval, int64_t c = 1, int64_t m = 0) {
+    assert(c >= 0);
+    Mutex::Locker l(lock);
+    if (m) {
+      assert(m > 0);
+      _reset_max(m);
+    }
+    if (_timed_wait(interval, c)) return false;
+    count += c;
+    return true;
+  }
+
   /* Returns true if it successfully got the requested amount,
    * or false if it would block.
    */
-- 
1.7.1


