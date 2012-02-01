From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 2/6] common/Throttle: track sleep/wake sequences in
 Throttle, report them for policy throttler
Date: Wed,  1 Feb 2012 08:54:24 -0700
Message-ID: <1328111668-10068-3-git-send-email-jaschut@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:38995 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498Ab2BAQMf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:12:35 -0500
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1083D17A6B6
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 08:55:26 -0700 (MST)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 08:55:02 -0700
In-Reply-To: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

This simplifies post-processing logs to discover to what extent message
wait time in the policy throttler is due to thread wakeup order.

Use get()/wait() arguments rather than an accessor function to minimize
confusion from inconsistent reporting caused by racing on the Throttle mutex.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/Throttle.h      |   24 ++++++++++++++++++++----
 src/msg/SimpleMessenger.cc |    6 +++++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index f13fde0..10560bf 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -6,11 +6,12 @@
 
 class Throttle {
   int64_t count, max, waiting;
+  uint64_t sseq, wseq;
   Mutex lock;
   Cond cond;
   
 public:
-  Throttle(int64_t m = 0) : count(0), max(m), waiting(0),
+  Throttle(int64_t m = 0) : count(0), max(m), waiting(0), sseq(0), wseq(0),
 			  lock("Throttle::lock") {
     assert(m >= 0);
   }
@@ -52,13 +53,21 @@ public:
 
   int64_t get_max() { return max; }
 
-  bool wait(int64_t m = 0) {
+  bool wait(int64_t m = 0,
+	    uint64_t *sleep_seq = NULL, uint64_t *wake_seq = NULL) {
     Mutex::Locker l(lock);
+    sseq++;
+    if (sleep_seq)
+      *sleep_seq = sseq;
     if (m) {
       assert(m > 0);
       _reset_max(m);
     }
-    return _wait(0);
+    bool r = _wait(0);
+    wseq++;
+    if (wake_seq)
+      *wake_seq = wseq;
+    return r;
   }
 
   int64_t take(int64_t c = 1) {
@@ -68,15 +77,22 @@ public:
     return count;
   }
 
-  void get(int64_t c = 1, int64_t m = 0) {
+  void get(int64_t c = 1, int64_t m = 0,
+	   uint64_t *sleep_seq = NULL, uint64_t *wake_seq = NULL) {
     assert(c >= 0);
     Mutex::Locker l(lock);
+    sseq++;
+    if (sleep_seq)
+      *sleep_seq = sseq;
     if (m) {
       assert(m > 0);
       _reset_max(m);
     }
     _wait(c);
     count += c;
+    wseq++;
+    if (wake_seq)
+      *wake_seq = wseq;
   }
 
   /* Returns true if it successfully got the requested amount,
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 952ed7c..259d3b7 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1898,7 +1898,11 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
       ldout(msgr->cct,10) << "reader wants " << message_size << " from policy throttler "
 	       << policy.throttler->get_current() << "/"
 	       << policy.throttler->get_max() << dendl;
-      policy.throttler->get(message_size);
+      uint64_t sseq, wseq;
+      policy.throttler->get(message_size, 0, &sseq, &wseq);
+      ldout(msgr->cct,10) << "reader got " << message_size << " from policy throttler "
+	     <<  policy.throttler->get_current() << "/" << policy.throttler->get_max()
+	     << " " << sseq << "/" << wseq << dendl;
     }
 
     // throttle total bytes waiting for dispatch.  do this _after_ the
-- 
1.7.1


