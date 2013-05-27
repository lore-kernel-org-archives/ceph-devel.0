From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 18/30] mds: don't issue Fc cap from replica
Date: Mon, 27 May 2013 10:13:26 +0800
Message-ID: <51A2C146.7060907@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-19-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231108230.32642@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44079 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab3E0CN2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 May 2013 22:13:28 -0400
In-Reply-To: <alpine.DEB.2.00.1305231108230.32642@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

updated version
---
From f232021801cb4bb8f9647c54bafc933ae7af5a92 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Mon, 6 May 2013 10:18:36 +0800
Subject: [PATCH 19/33] mds: Fix replica's allowed caps for filelock in
 SYNC_LOCK state

For replica, filelock in LOCK_LOCK state doesn't allow Fc cap. So
filelock in LOCK_SYNC_LOCK/LOCK_EXCL_LOCK state shouldn't allow Fc
cap either.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mds/locks.c b/src/mds/locks.c
index c7dd5be..9031087 100644
--- a/src/mds/locks.c
+++ b/src/mds/locks.c
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

