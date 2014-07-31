From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] locking/mutexes: Revert "locking/mutexes: Add extra reschedule point"
Date: Thu, 31 Jul 2014 14:16:37 +0400
Message-ID: <1406801797-20139-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:57950 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291AbaGaKQm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 06:16:42 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so1841425lab.21
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 03:16:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, ceph-devel@vger.kernel.org

This reverts commit 34c6bc2c919a55e5ad4e698510a2f35ee13ab900.

This commit can lead to deadlocks by way of what at a high level
appears to look like a missing wakeup on mutex_unlock() when
CONFIG_MUTEX_SPIN_ON_OWNER is set, which is how most distributions ship
their kernels.  In particular, it causes reproducible deadlocks in
libceph/rbd code under higher than moderate loads with the evidence
actually pointing to the bowels of mutex_lock().

kernel/locking/mutex.c, __mutex_lock_common():
476         osq_unlock(&lock->osq);
477 slowpath:
478         /*
479          * If we fell out of the spin path because of need_resched(),
480          * reschedule now, before we try-lock the mutex. This avoids getting
481          * scheduled out right after we obtained the mutex.
482          */
483         if (need_resched())
484                 schedule_preempt_disabled(); <-- never returns
485 #endif
486         spin_lock_mutex(&lock->wait_lock, flags);

We started bumping into deadlocks in QA the day our branch has been
rebased onto 3.15 (the release this commit went in) but then as part of
debugging effort I enabled all locking debug options, which also
disabled CONFIG_MUTEX_SPIN_ON_OWNER and made everything disappear,
which is why it hasn't been looked into until now.  Revert makes the
problem go away, confirmed by our users.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org # 3.15
Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 kernel/locking/mutex.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index acca2c1a3c5e..746ff280a2fc 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -475,13 +475,6 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 	osq_unlock(&lock->osq);
 slowpath:
-	/*
-	 * If we fell out of the spin path because of need_resched(),
-	 * reschedule now, before we try-lock the mutex. This avoids getting
-	 * scheduled out right after we obtained the mutex.
-	 */
-	if (need_resched())
-		schedule_preempt_disabled();
 #endif
 	spin_lock_mutex(&lock->wait_lock, flags);
 
-- 
1.7.10.4

