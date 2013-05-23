From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 18/30] mds: don't issue Fc cap from replica
Date: Thu, 23 May 2013 16:06:46 +0800
Message-ID: <1369296418-14871-19-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab3EWINO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:14 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

For replica, filelock in LOCK_LOCK state doesn't allow Fc cap. So
filelock in LOCK_SYNC_LOCK/LOCK_EXCL_LOCK state shouldn't allow Fc
cap either.

Replica can issue Fc cap only when filelock is in LOCK_SYNC state.
Every time filelock changes to other state, replica need revoke Fc
cap. This is slow, so I think it's better to not issue Fc cap from
replica.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/locks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mds/locks.c b/src/mds/locks.c
index c7dd5be..542595a 100644
--- a/src/mds/locks.c
+++ b/src/mds/locks.c
@@ -88,7 +88,7 @@ const struct sm_t sm_scatterlock = {
 
 const struct sm_state_t filelock[LOCK_MAX] = {
                       // stable     loner  rep state  r     rp   rd   wr   fwr  l    x    caps(any,loner,xlocker,replica)
-    [LOCK_SYNC]      = { 0,         false, LOCK_SYNC, ANY,  0,   ANY, 0,   0,   ANY, 0,   CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD,0,0,CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD },
+    [LOCK_SYNC]      = { 0,         false, LOCK_SYNC, ANY,  0,   ANY, 0,   0,   ANY, 0,   CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD,0,0,CEPH_CAP_GSHARED|CEPH_CAP_GRD },
     [LOCK_LOCK_SYNC] = { LOCK_SYNC, false, LOCK_LOCK, AUTH, 0,   0,   0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,0 },
     [LOCK_EXCL_SYNC] = { LOCK_SYNC, true,  LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   0,CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD,0,0 },
     [LOCK_MIX_SYNC]  = { LOCK_SYNC, false, LOCK_MIX_SYNC2,0,0,   0,   0,   0,   0,   0,   CEPH_CAP_GRD|CEPH_CAP_GLAZYIO,0,0,CEPH_CAP_GRD },
@@ -97,8 +97,8 @@ const struct sm_state_t filelock[LOCK_MAX] = {
     [LOCK_XSYN_SYNC] = { LOCK_SYNC, true,  LOCK_LOCK, AUTH, 0,   AUTH,0,   0,   0,   0,   0,CEPH_CAP_GCACHE,0,0 },
   
     [LOCK_LOCK]      = { 0,         false, LOCK_LOCK, AUTH, 0,   REQ, AUTH,0,   0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
-    [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,CEPH_CAP_GCACHE },
-    [LOCK_EXCL_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,CEPH_CAP_GCACHE },
+    [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,0 },
+    [LOCK_EXCL_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
     [LOCK_MIX_LOCK]  = { LOCK_LOCK, false, LOCK_MIX,  AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
     [LOCK_MIX_LOCK2] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
 
-- 
1.8.1.4

