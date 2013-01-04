From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 22/29] mds: fix replica state for LOCK_MIX_LOCK
Date: Fri,  4 Jan 2013 17:02:13 +0800
Message-ID: <1357290140-17044-23-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38624 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab3ADJCw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:52 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

LOCK_MIX_LOCK state is for gathering local locks and caps, so replica state
should be LOCK_MIX.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mds/locks.c b/src/mds/locks.c
index ce1a6dd..73b99fb 100644
--- a/src/mds/locks.c
+++ b/src/mds/locks.c
@@ -64,7 +64,7 @@ static const struct sm_state_t scatterlock[LOCK_MAX] = {
    
     [LOCK_LOCK]      = { 0,         false, LOCK_LOCK, AUTH, 0,   REQ, AUTH,0,   0,   ANY, 0,0,0,0 },
     [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   0,   0,   0,   0,   0,   0,0,0,0 },
-    [LOCK_MIX_LOCK]  = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
+    [LOCK_MIX_LOCK]  = { LOCK_LOCK, false, LOCK_MIX,  0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
     [LOCK_MIX_LOCK2] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
     [LOCK_TSYN_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
     
@@ -98,7 +98,7 @@ const struct sm_state_t filelock[LOCK_MAX] = {
     [LOCK_LOCK]      = { 0,         false, LOCK_LOCK, AUTH, 0,   REQ, AUTH,0,   0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
     [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,CEPH_CAP_GCACHE },
     [LOCK_EXCL_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,CEPH_CAP_GCACHE },
-    [LOCK_MIX_LOCK]  = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
+    [LOCK_MIX_LOCK]  = { LOCK_LOCK, false, LOCK_MIX,  AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
     [LOCK_MIX_LOCK2] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
 
     [LOCK_PREXLOCK]  = { LOCK_LOCK, false, LOCK_LOCK, 0,    XCL, 0,   0,   0,   0,   ANY, CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
-- 
1.7.11.7

