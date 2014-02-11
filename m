From: Daniel Poelzleithner <poelzleithner@b1-systems.de>
Subject: [PATCH] Fix for corrupted ceph cluster
Date: Tue, 11 Feb 2014 07:48:01 +0100
Message-ID: <52F9C7A1.3060705@b1-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.b1-systems.de ([84.200.69.220]:45922 "EHLO
	mx1.b1-systems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaBKGsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 01:48:07 -0500
Received: from [172.22.99.170] (anon-32-58.vpn.ipredator.se [46.246.32.58])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id C75994092
	for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 07:33:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I wrote a small patch that ignores object_trim requests when he does not
find the context of this request.
We have a node that fails to start permanently and there is no way to
get all nodes back up.

As far as I understood, deleting something that does not exist should
not cause an assert. It is wired, but should not cause abort.

This is regarding bug http://tracker.ceph.com/issues/6101

Any help is highly appreciated.

kind regards
 Daniel


---
 src/osd/ReplicatedPG.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 90d3e1d..d7e0b62 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1491,7 +1491,7 @@ ReplicatedPG::RepGather
*ReplicatedPG::trim_object(const hobject_t &coid)
   int r = find_object_context(coid, &obc, false, NULL);
   if (r == -ENOENT || coid.snap != obc->obs.oi.soid.snap) {
     derr << __func__ << "could not find coid " << coid << dendl;
-    assert(0);
+    return NULL;
   }
   assert(r == 0);
   assert(obc->registered);
@@ -7866,7 +7866,10 @@ boost::statechart::result
ReplicatedPG::TrimmingObjects::react(const SnapTrim&)

   dout(10) << "TrimmingObjects react trimming " << pos << dendl;
   RepGather *repop = pg->trim_object(pos);
-  assert(repop);
+  if (!repop) {
+      derr << "TrimmingObjects failed " << pos << dendl;
+      return discard_event();
+  }

   repop->queue_snap_trimmer = true;
   eversion_t old_last_update = pg->pg_log.get_head();
-- 
1.8.5.3
