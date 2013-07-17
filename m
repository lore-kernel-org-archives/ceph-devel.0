From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/6] mds: fix cap revoke confirmation
Date: Wed, 17 Jul 2013 16:28:38 +0800
Message-ID: <1374049723-19274-2-git-send-email-zheng.z.yan@intel.com>
References: <1374049723-19274-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:14679 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab3GQI2s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jul 2013 04:28:48 -0400
In-Reply-To: <1374049723-19274-1-git-send-email-zheng.z.yan@intel.com>
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
 src/mds/Capability.h | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index fdecb90..d56bdc9 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -142,13 +142,11 @@ public:
       _pending = c;
       _issued |= c;
     } else if (~_pending & c) {
-      // adding bits only.  remove obsolete revocations?
+      // note prior caps if there are pending revocations
+      if (!_revokes.empty())
+	_revokes.push_back(revoke_info(_pending, last_sent, last_issue));
       _pending |= c;
       _issued |= c;
-      // drop old _revokes with no bits we don't have
-      while (!_revokes.empty() &&
-	     (_revokes.back().before & ~_pending) == 0)
-	_revokes.pop_back();
     } else {
       // no change.
       assert(_pending == c);
@@ -169,16 +167,42 @@ public:
     for (list<revoke_info>::iterator p = _revokes.begin(); p != _revokes.end(); ++p)
       _issued |= p->before;
   }
+  void _update_revokes(ceph_seq_t seq, unsigned caps) {
+    // can i forget any revocations?
+    while (!_revokes.empty() && _revokes.front().seq < seq)
+      _revokes.pop_front();
+
+    if (!_revokes.empty() && _revokes.front().seq == seq) {
+      list<revoke_info>::iterator p = _revokes.begin();
+      unsigned prev_pending = p->before;
+      p->before = caps;
+      // client actively released caps?
+      unsigned release = prev_pending & ~caps;
+      if (release) {
+	for (++p; p != _revokes.end(); ++p) {
+	  // we issued new caps to client?
+	  release &= prev_pending | ~(p->before);
+	  if (release == 0)
+	    break;
+	  prev_pending = p->before;
+	  p->before &= ~release;
+	}
+	if (release) {
+	  // we issued new caps to client?
+	  release &= prev_pending | ~_pending;
+	  _pending &= ~release;
+	}
+      }
+    }
+  }
   void confirm_receipt(ceph_seq_t seq, unsigned caps) {
     if (seq == last_sent) {
-      _pending = caps;
       _revokes.clear();
       _issued = caps;
+      // don't add bits
+      _pending &= caps;
     } else {
-      // can i forget any revocations?
-      while (!_revokes.empty() &&
-	     _revokes.front().seq <= seq)
-	_revokes.pop_front();
+      _update_revokes(seq, caps);
       _calc_issued();
     }
     //check_rdcaps_list();
-- 
1.8.1.4

