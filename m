From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/6] mds: fix cap revoke confirmation
Date: Mon,  5 Aug 2013 14:10:22 +0800
Message-ID: <1375683030-28305-2-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33765 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695Ab3HEGKe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:34 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

There are several issues in the Capability::confirm_receipt()

1. when receiving a client caps message with 'seq == last_sent',
   it doesn't mean we finish revoking caps. The client can send
   caps message that only flushes dirty metadata.

2. When receiving a client caps message with 'seq == N', we should
   forget pending revocations whose seq numbers are less than N.
   This is because, when revoking caps, we create a revoke_info
   structure and set its seq number to 'last_sent', then increase
   the 'last_sent'.

3. When client actively releases caps (by request), the code only
   works for the 'seq == last_sent' case. If there are pending
   revocations, we should update them as if the release message
   is received before we revoke the corresponding caps.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Capability.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index fdecb90..fb6b3dc 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -171,14 +171,16 @@ public:
   }
   void confirm_receipt(ceph_seq_t seq, unsigned caps) {
     if (seq == last_sent) {
-      _pending = caps;
       _revokes.clear();
       _issued = caps;
+      // don't add bits
+      _pending &= caps;
     } else {
       // can i forget any revocations?
-      while (!_revokes.empty() &&
-	     _revokes.front().seq <= seq)
+      while (!_revokes.empty() && _revokes.front().seq < seq)
 	_revokes.pop_front();
+      if (!_revokes.empty() && _revokes.front().seq == seq)
+	_revokes.begin()->before = caps;
       _calc_issued();
     }
     //check_rdcaps_list();
-- 
1.8.1.4

