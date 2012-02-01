From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 5/6] common/Throttle: make get() report number of
 waiters on entry/exit
Date: Wed,  1 Feb 2012 08:54:27 -0700
Message-ID: <1328111668-10068-6-git-send-email-jaschut@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:38994 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab2BAQMf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:12:35 -0500
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1F85F17A6B5
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 08:55:26 -0700 (MST)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 08:55:07 -0700
In-Reply-To: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Use get() arguments rather than an accessor function to minimize confusion
from inconsistent reporting caused by racing on the Throttle mutex.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/Throttle.h      |    7 ++++++-
 src/msg/SimpleMessenger.cc |    5 +++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index 2f74f4a..dd74730 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -86,12 +86,15 @@ public:
   }
 
   void get(int64_t c = 1, int64_t m = 0,
-	   uint64_t *sleep_seq = NULL, uint64_t *wake_seq = NULL) {
+	   uint64_t *sleep_seq = NULL, uint64_t *wake_seq = NULL,
+	   int *sleep_waiters = NULL, int *wake_waiters = NULL) {
     assert(c >= 0);
     Mutex::Locker l(lock);
     sseq++;
     if (sleep_seq)
       *sleep_seq = sseq;
+    if (sleep_waiters)
+      *sleep_waiters = cond.size();
     if (m) {
       assert(m > 0);
       max = m;
@@ -101,6 +104,8 @@ public:
     wseq++;
     if (wake_seq)
       *wake_seq = wseq;
+    if (wake_waiters)
+      *wake_waiters = cond.size();
   }
 
   /* Returns true if it successfully got the requested amount,
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 259d3b7..3167749 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1899,10 +1899,11 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
 	       << policy.throttler->get_current() << "/"
 	       << policy.throttler->get_max() << dendl;
       uint64_t sseq, wseq;
-      policy.throttler->get(message_size, 0, &sseq, &wseq);
+      int swait, wwait;
+      policy.throttler->get(message_size, 0, &sseq, &wseq, &swait, &wwait);
       ldout(msgr->cct,10) << "reader got " << message_size << " from policy throttler "
 	     <<  policy.throttler->get_current() << "/" << policy.throttler->get_max()
-	     << " " << sseq << "/" << wseq << dendl;
+	     << " seq " << sseq << "/" << wseq  << " waiters " << swait << "/" << wwait << dendl;
     }
 
     // throttle total bytes waiting for dispatch.  do this _after_ the
-- 
1.7.1


