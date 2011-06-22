From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 1/3] common/Throttle: Remove unused return type on
 Throttle::get()
Date: Wed, 22 Jun 2011 12:26:25 -0600
Message-ID: <1308767187-10376-3-git-send-email-jaschut@sandia.gov>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53393 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab1FVS07 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2011 14:26:59 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 10887173223
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:26:57 -0600 (MDT)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:26:48 -0600
In-Reply-To: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/common/Throttle.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index cd772dd..8fd2625 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -68,16 +68,15 @@ public:
     return count;
   }
 
-  bool get(int64_t c = 1, int64_t m = 0) {
+  void get(int64_t c = 1, int64_t m = 0) {
     assert(c >= 0);
     Mutex::Locker l(lock);
     if (m) {
       assert(m > 0);
       _reset_max(m);
     }
-    bool waited = _wait(c);
+    _wait(c);
     count += c;
-    return waited;
   }
 
   /* Returns true if it successfully got the requested amount,
-- 
1.7.1


