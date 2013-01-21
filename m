From: Loic Dachary <loic@dachary.org>
Subject: [PATCH] Always Signal() the first Cond when changing the maximum
Date: Mon, 21 Jan 2013 14:30:08 +0100
Message-ID: <50FD42E0.3040101@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:35246 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab3AUNaN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 08:30:13 -0500
Received: from [10.8.2.6] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id E7A1226394
	for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 14:30:08 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

 Removes a test by which the waiting queue is only
 Signal()ed if the new maximum is lower than the current
 maximum.  There is no evidence of a use case where such a
 restriction would be useful. In addition waking up a thread
 when the maximum increases gives it a chance to immediately
 continue the suspended process instead of waiting for the
 next put().  For additional context see the discussion at
 http://marc.info/?t=135868938300001&r=1&w=4

Signed-off-by: Loic Dachary <loic@dachary.org>
---
 src/common/Throttle.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/Throttle.cc b/src/common/Throttle.cc
index 844263a..82ffe7a 100644
--- a/src/common/Throttle.cc
+++ b/src/common/Throttle.cc
@@ -65,7 +65,7 @@ Throttle::~Throttle()
 void Throttle::_reset_max(int64_t m)
 {
   assert(lock.is_locked());
-  if (m < ((int64_t)max.read()) && !cond.empty())
+  if (!cond.empty())
     cond.front()->SignalOne();
   logger->set(l_throttle_max, m);
   max.set((size_t)m);
-- 
1.7.10.4


