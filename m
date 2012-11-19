From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 16/16] mds: use rdlock_try() when checking NULL dentry
Date: Mon, 19 Nov 2012 10:43:48 +0800
Message-ID: <1353293028-15238-17-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57821 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab2KSCoH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:07 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Use rdlock_try() instead can_read() when path_traverse encounters
a NULL dentry. This can partly avoid infinitely waiting for the
dentry to become readable when the dentry is replica.

Strictly speaking, use rdlock_try() is still enough because auth
MDS may drop the REQRDLOCK message in some cases.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 9cddfeb..7152b5e 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -6707,11 +6707,11 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
     
     // can we conclude ENOENT?
     if (dnl && dnl->is_null()) {
-      if (dn->lock.can_read(client)) {
-        dout(12) << "traverse: miss on null+readable dentry " << path[depth] << " " << *dn << dendl;
+      if (mds->locker->rdlock_try(&dn->lock, client, NULL)) {
+        dout(10) << "traverse: miss on null+readable dentry " << path[depth] << " " << *dn << dendl;
         return -ENOENT;
       } else {
-        dout(12) << "miss on dentry " << *dn << ", can't read due to lock" << dendl;
+        dout(10) << "miss on dentry " << *dn << ", can't read due to lock" << dendl;
         dn->lock.add_waiter(SimpleLock::WAIT_RD, _get_waiter(mdr, req, fin));
         return 1;
       }
-- 
1.7.11.7

