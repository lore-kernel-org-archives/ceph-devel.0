From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCH] mon:  use first_commited instead of latest_full map if latest_bl.length() == 0
Date: Fri, 19 Jul 2013 10:31:36 +0200
Message-ID: <1374222696-7100-1-git-send-email-s.priebe@profihost.ag>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from packetbuilder64bit.de-nserver.de ([85.158.179.228]:50469 "EHLO
	packetbuilder64bit.de-nserver.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759500Ab3GSIiU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Jul 2013 04:38:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Stefan Priebe <s.priebe@profihost.ag>

this fixes a failure like:
     0> 2013-07-19 09:29:16.803918 7f7fb5f31780 -1 mon/OSDMonitor.cc: In function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread 7f7fb5f31780 time 2013-07-19 09:29:16.803439
mon/OSDMonitor.cc: 132: FAILED assert(latest_bl.length() != 0)

 ceph version 0.61.5-15-g72c7c74 (72c7c74e1f160e6be39b6edf30bce09b770fa777)
 1: (OSDMonitor::update_from_paxos(bool*)+0x16e1) [0x51d121]
 2: (PaxosService::refresh(bool*)+0xe6) [0x4f2a46]
 3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
 4: (Monitor::init_paxos()+0xe5) [0x48f955]
 5: (Monitor::preinit()+0x679) [0x4b1cf9]
 6: (main()+0x36b0) [0x484bb0]
 7: (__libc_start_main()+0xfd) [0x7f7fb408dc8d]
 8: /usr/bin/ceph-mon() [0x4801e9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
---
 src/mon/OSDMonitor.cc |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index 9c854cd..ab3b8ec 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -129,6 +129,12 @@ void OSDMonitor::update_from_paxos(bool *need_bootstrap)
   if ((latest_full > 0) && (latest_full > osdmap.epoch)) {
     bufferlist latest_bl;
     get_version_full(latest_full, latest_bl);
+
+    if (latest_bl.length() == 0 && latest_full != 0 && get_first_committed() > 1) {
+        dout(0) << __func__ << " latest_bl.length() == 0 use first_commited instead of latest_full" << dendl;
+        latest_full = get_first_committed();
+        get_version_full(latest_full, latest_bl);
+    }
     assert(latest_bl.length() != 0);
     dout(7) << __func__ << " loading latest full map e" << latest_full << dendl;
     osdmap.decode(latest_bl);
-- 
1.7.10.4

