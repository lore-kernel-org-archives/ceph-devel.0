From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/16] mds: don't add not issued caps when confirming cap receipt
Date: Mon, 19 Nov 2012 10:43:35 +0800
Message-ID: <1353293028-15238-4-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34224 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab2KSCny (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:54 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

There is message ordering race in cephfs kernel client. We compose
cap messages when i_ceph_lock is hold. But when adding messages
to the output queue, the kernel releases i_ceph_lock and acquires
a mutex. So it is possible that cap messages are send out of order.
If the kernel client send a cap update, then send a cap release,
but the two messages reach MDS out of order. The update message
will re-add the released caps. This patch adds code to check if
caps were actually issued when confirming cap receipt.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 9d91748..c29ac34 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2287,11 +2287,17 @@ void Locker::handle_client_caps(MClientCaps *m)
  
     // head inode, and cap
     MClientCaps *ack = 0;
+
+    int caps = m->get_caps();
+    if (caps & ~cap->issued()) {
+      dout(10) << " confirming not issued caps " << ccap_string(caps & ~cap->issued()) << dendl;
+      caps &= cap->issued();
+    }
     
-    cap->confirm_receipt(m->get_seq(), m->get_caps());
+    cap->confirm_receipt(m->get_seq(), caps);
     dout(10) << " follows " << follows
 	     << " retains " << ccap_string(m->get_caps())
-	     << " dirty " << ccap_string(m->get_caps())
+	     << " dirty " << ccap_string(m->get_dirty())
 	     << " on " << *in << dendl;
 
 
@@ -2424,6 +2430,10 @@ void Locker::process_request_cap_release(MDRequest *mdr, client_t client, const
     return;
   }
     
+  if (caps & ~cap->issued()) {
+    dout(10) << " confirming not issued caps " << ccap_string(caps & ~cap->issued()) << dendl;
+    caps &= cap->issued();
+  }
   cap->confirm_receipt(seq, caps);
   adjust_cap_wanted(cap, wanted, issue_seq);
   
-- 
1.7.11.7

