From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 6/6] msg: log Message interactions with throttler
Date: Wed,  1 Feb 2012 08:54:28 -0700
Message-ID: <1328111668-10068-7-git-send-email-jaschut@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:38993 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab2BAQMf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:12:35 -0500
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1173B17A6B8
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 08:55:26 -0700 (MST)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 08:55:07 -0700
In-Reply-To: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Also, fix logging race about policy throttler count in SimpleMessenger.cc,
so that throttler logging is always consistent.

Finally, log message source on policy throttler messages to make extracting
them from logs for a single message simpler.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/Throttle.h      |    7 ++--
 src/msg/Message.h          |   71 +++++++++++++++++++++++++++++++++++++-------
 src/msg/SimpleMessenger.cc |   19 +++++++-----
 3 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index dd74730..56ecb08 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -85,9 +85,9 @@ public:
     return count;
   }
 
-  void get(int64_t c = 1, int64_t m = 0,
-	   uint64_t *sleep_seq = NULL, uint64_t *wake_seq = NULL,
-	   int *sleep_waiters = NULL, int *wake_waiters = NULL) {
+  int64_t get(int64_t c = 1, int64_t m = 0,
+	      uint64_t *sleep_seq = NULL, uint64_t *wake_seq = NULL,
+	      int *sleep_waiters = NULL, int *wake_waiters = NULL) {
     assert(c >= 0);
     Mutex::Locker l(lock);
     sseq++;
@@ -106,6 +106,7 @@ public:
       *wake_seq = wseq;
     if (wake_waiters)
       *wake_waiters = cond.size();
+    return count;
   }
 
   /* Returns true if it successfully got the requested amount,
diff --git a/src/msg/Message.h b/src/msg/Message.h
index f37a884..fdcb930 100644
--- a/src/msg/Message.h
+++ b/src/msg/Message.h
@@ -313,8 +313,12 @@ protected:
     assert(nref.read() == 0);
     if (connection)
       connection->put();
-    if (throttler)
-      throttler->put(payload.length() + middle.length() + data.length());
+    if (throttler) {
+      unsigned dlen = payload.length() + middle.length() + data.length();
+      int64_t tcnt = throttler->put(dlen);
+      generic_dout(1) << "~Message() on " << this << " returned " << dlen
+		      << " to throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
   }
 public:
   Connection *get_connection() { return connection; }
@@ -342,39 +346,84 @@ public:
    */
 
   void clear_payload() {
-    if (throttler) throttler->put(payload.length() + middle.length());
+    if (throttler) {
+      unsigned dlen = payload.length() + middle.length();
+      int64_t tcnt = throttler->put(dlen);
+      generic_dout(1) << "clear_payload() on " << this << " returned " << dlen
+		      << " to throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
     payload.clear();
     middle.clear();
   }
   void clear_data() {
-    if (throttler) throttler->put(data.length());
+    if (throttler) {
+      unsigned dlen = data.length();
+      int64_t tcnt = throttler->put(dlen);
+      generic_dout(1) << "clear_data() on " << this << " returned " << dlen
+		      << " to throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
     data.clear();
   }
 
   bool empty_payload() { return payload.length() == 0; }
   bufferlist& get_payload() { return payload; }
   void set_payload(bufferlist& bl) {
-    if (throttler) throttler->put(payload.length());
+    if (throttler) {
+      unsigned dlen = payload.length();
+      int64_t tcnt = throttler->put(dlen);
+      generic_dout(1) << "set_payload() on " << this << " returned " << dlen
+		      << " to throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
     payload.claim(bl);
-    if (throttler) throttler->take(payload.length());
+    if (throttler) {
+      unsigned dlen = payload.length();
+      int64_t tcnt = throttler->take(dlen);
+      generic_dout(1) << "set_payload() on " << this << " took " << dlen
+		      << " from throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
   }
 
   void set_middle(bufferlist& bl) {
-    if (throttler) throttler->put(payload.length());
+    if (throttler) {
+      unsigned dlen = payload.length();
+      int64_t tcnt = throttler->put(dlen);
+      generic_dout(1) << "set_middle() on " << this << " returned " << dlen
+		      << " to throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
     middle.claim(bl);
-    if (throttler) throttler->take(payload.length());
+    if (throttler) {
+      unsigned dlen = payload.length();
+      int64_t tcnt = throttler->take(dlen);
+      generic_dout(1) << "set_middle() on " << this << " took " << dlen
+		      << " from throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
   }
   bufferlist& get_middle() { return middle; }
 
   void set_data(const bufferlist &d) {
-    if (throttler) throttler->put(data.length());
+    if (throttler) {
+      unsigned dlen = data.length();
+      int64_t tcnt = throttler->put(dlen);
+      generic_dout(1) << "set_data() on " << this << " returned " << dlen
+		      << " to throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
     data = d;
-    if (throttler) throttler->take(data.length());
+    if (throttler) {
+      unsigned dlen = data.length();
+      int64_t tcnt = throttler->take(dlen);
+      generic_dout(1) << "set_data() on " << this << " took " << dlen
+		      << " from throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
   }
 
   bufferlist& get_data() { return data; }
   void claim_data(bufferlist& bl) {
-    if (throttler) throttler->put(data.length());
+    if (throttler) {
+      unsigned dlen = data.length();
+      int64_t tcnt = throttler->put(dlen);
+      generic_dout(1) << "claim_data() on " << this << " returned " << dlen
+		      << " to throttler " << tcnt << "/" << throttler->get_max() << dendl;
+    }
     bl.claim(data);
   }
   off_t get_data_len() { return data.length(); }
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 3167749..d7bbe7b 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1897,13 +1897,15 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
     if (policy.throttler) {
       ldout(msgr->cct,10) << "reader wants " << message_size << " from policy throttler "
 	       << policy.throttler->get_current() << "/"
-	       << policy.throttler->get_max() << dendl;
+	       << policy.throttler->get_max() 
+	       << " for src " << entity_name_t(header.src) << " tid=" << header.tid << dendl;
       uint64_t sseq, wseq;
       int swait, wwait;
-      policy.throttler->get(message_size, 0, &sseq, &wseq, &swait, &wwait);
+      int64_t tcnt = policy.throttler->get(message_size, 0, &sseq, &wseq, &swait, &wwait);
       ldout(msgr->cct,10) << "reader got " << message_size << " from policy throttler "
-	     <<  policy.throttler->get_current() << "/" << policy.throttler->get_max()
-	     << " seq " << sseq << "/" << wseq  << " waiters " << swait << "/" << wwait << dendl;
+	     << tcnt << "/" << policy.throttler->get_max()
+	     << " seq " << sseq << "/" << wseq  << " waiters " << swait << "/" << wwait
+	     << " for src " << entity_name_t(header.src) << " tid=" << header.tid << dendl;
     }
 
     // throttle total bytes waiting for dispatch.  do this _after_ the
@@ -2028,10 +2030,11 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
   // release bytes reserved from the throttlers on failure
   if (message_size) {
     if (policy.throttler) {
-      ldout(msgr->cct,10) << "reader releasing " << message_size << " to policy throttler "
-	       << policy.throttler->get_current() << "/"
-	       << policy.throttler->get_max() << dendl;
-      policy.throttler->put(message_size);
+      int64_t tcnt = policy.throttler->put(message_size);
+      ldout(msgr->cct,10) << "reader returned " << message_size << " to policy throttler "
+	       << tcnt << "/" << policy.throttler->get_max()
+     	       << " for src " << entity_name_t(header.src) << " tid=" << header.tid << dendl;
+
     }
 
     msgr->dispatch_throttle_release(message_size);
-- 
1.7.1


