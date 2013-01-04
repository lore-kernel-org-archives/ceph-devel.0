From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 01/29] mds: don't renew revoking lease
Date: Fri,  4 Jan 2013 17:01:52 +0800
Message-ID: <1357290140-17044-2-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51114 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab3ADJC0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:26 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

MDS may receives lease renew request while lease is being revoked,
just ignore the renew request.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 76708ec..c8cd236 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2914,18 +2914,20 @@ void Locker::handle_client_lease(MClientLease *m)
 
   case CEPH_MDS_LEASE_RENEW:
     {
-      dout(7) << "handle_client_lease client." << client
-	      << " renew on " << *dn << dendl;
-      int pool = 1;   // fixme.. do something smart!
-      m->h.duration_ms = (int)(1000 * mdcache->client_lease_durations[pool]);
-      m->h.seq = ++l->seq;
-      m->clear_payload();
-      
-      utime_t now = ceph_clock_now(g_ceph_context);
-      now += mdcache->client_lease_durations[pool];
-      mdcache->touch_client_lease(l, pool, now);
-      
-      mds->send_message_client_counted(m, m->get_connection());
+      dout(7) << "handle_client_lease client." << client << " renew on " << *dn
+	      << (!dn->lock.can_lease(client)?", revoking lease":"") << dendl;
+      if (dn->lock.can_lease(client)) {
+	int pool = 1;   // fixme.. do something smart!
+	m->h.duration_ms = (int)(1000 * mdcache->client_lease_durations[pool]);
+	m->h.seq = ++l->seq;
+	m->clear_payload();
+
+	utime_t now = ceph_clock_now(g_ceph_context);
+	now += mdcache->client_lease_durations[pool];
+	mdcache->touch_client_lease(l, pool, now);
+
+	mds->send_message_client_counted(m, m->get_connection());
+      }
     }
     break;
 
-- 
1.7.11.7

