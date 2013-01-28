From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/6] mds: fix 'discover' handling in the rejoin stage
Date: Mon, 28 Jan 2013 10:28:23 +0800
Message-ID: <1359340106-24257-4-git-send-email-zheng.z.yan@intel.com>
References: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58841 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab3A1C2c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 21:28:32 -0500
In-Reply-To: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If the MDS is the resolve stage, current MDCache::handle_discover() only handles
'discover' from MDS that it has already gotten rejoin acknowledgement. This can
cause circular wait because MDCache::rejoin_gather_finish() fetches reconnected
inodes before send rejoin acknowledgements, and fetching reconnected inode may
triggers 'discover'. The fix is not delay handling 'discover' from MDS that are
also in the rejoin stage.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 9ad6919..f311f55 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8867,10 +8867,12 @@ void MDCache::handle_discover(MDiscover *dis)
 
   assert(from != whoami);
 
-  if (mds->get_state() < MDSMap::STATE_CLIENTREPLAY) {
+  if (mds->get_state() <= MDSMap::STATE_REJOIN) {
     int from = dis->get_source().num();
+    // proceed if requester is in the REJOIN stage, the request is from parallel_fetch().
+    // delay processing request from survivor because we may not yet choose lock states.
     if (mds->get_state() < MDSMap::STATE_REJOIN ||
-	rejoin_ack_gather.count(from)) {
+	!mds->mdsmap->is_rejoin(from)) {
       dout(0) << "discover_reply not yet active(|still rejoining), delaying" << dendl;
       mds->wait_for_active(new C_MDS_RetryMessage(mds, dis));
       return;
-- 
1.7.11.7

