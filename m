From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] PG: Do not discard op data too early
Date: Thu, 27 Sep 2012 15:56:15 -0600
Message-ID: <1348782975-7082-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:54885 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab2I0V47 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 17:56:59 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1B052D2C734
	for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 15:56:57 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 15:56:36 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Under a sustained cephfs write load where the offered load is higher
than the storage cluster write throughput, a backlog of replication ops
that arrive via the cluster messenger builds up.  The client message
policy throttler, which should be limiting the total write workload
accepted by the storage cluster, is unable to prevent it, for any
value of osd_client_message_size_cap, under such an overload condition.

The root cause is that op data is released too early, in op_applied().

If instead the op data is released at op deletion, then the limit
imposed by the client policy throttler applies over the entire
lifetime of the op, including commits of replication ops.  That
makes the policy throttler an effective means for an OSD to
protect itself from a sustained high offered load, because it can
effectively limit the total, cluster-wide resources needed to process
in-progress write ops.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/osd/ReplicatedPG.cc |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index a64abda..80bec2a 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -3490,10 +3490,6 @@ void ReplicatedPG::op_applied(RepGather *repop)
   dout(10) << "op_applied " << *repop << dendl;
   if (repop->ctx->op)
     repop->ctx->op->mark_event("op_applied");
-
-  // discard my reference to the buffer
-  if (repop->ctx->op)
-    repop->ctx->op->request->clear_data();
   
   repop->applying = false;
   repop->applied = true;
-- 
1.7.8.2


