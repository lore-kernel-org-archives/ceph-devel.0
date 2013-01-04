From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 25/29] mds: check null context in CDir::fetch()
Date: Fri,  4 Jan 2013 17:02:16 +0800
Message-ID: <1357290140-17044-26-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57521 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab3ADJCx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:53 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 91636cc..22cdf48 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1351,8 +1351,11 @@ void CDir::fetch(Context *c, const string& want_dn, bool ignore_authpinnability)
   assert(!is_complete());
 
   if (!can_auth_pin() && !ignore_authpinnability) {
-    dout(7) << "fetch waiting for authpinnable" << dendl;
-    add_waiter(WAIT_UNFREEZE, c);
+    if (c) {
+      dout(7) << "fetch waiting for authpinnable" << dendl;
+      add_waiter(WAIT_UNFREEZE, c);
+    } else
+      dout(7) << "fetch not authpinnable and no context" << dendl;
     return;
   }
 
-- 
1.7.11.7

