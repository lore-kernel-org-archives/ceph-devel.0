From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mon: Fix leak of context
Date: Sat, 27 Apr 2013 11:04:38 +0800
Message-ID: <1367031878-7078-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3661 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab3D0DEq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Apr 2013 23:04:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, joao.luis@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Use Context::complete() to finish context, it frees the context
after executing Context::finish().

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mon/Paxos.cc | 2 +-
 src/mon/Paxos.h  | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/mon/Paxos.cc b/src/mon/Paxos.cc
index 21b9343..46eaf88 100644
--- a/src/mon/Paxos.cc
+++ b/src/mon/Paxos.cc
@@ -805,7 +805,7 @@ void Paxos::finish_queued_proposal()
 	     << " to finish" << dendl;
 
     proposals.pop_front();
-    proposal->finish(0);
+    proposal->complete(0);
   }
 }
 
diff --git a/src/mon/Paxos.h b/src/mon/Paxos.h
index 8fcf66b..ca467ce 100644
--- a/src/mon/Paxos.h
+++ b/src/mon/Paxos.h
@@ -642,8 +642,10 @@ public:
       { }
 
     void finish(int r) {
-      if (proposer_context)
-        proposer_context->finish(r);
+      if (proposer_context) {
+	proposer_context->complete(r);
+	proposer_context = NULL;
+      }
     }
   };
   /**
-- 
1.8.1.4

