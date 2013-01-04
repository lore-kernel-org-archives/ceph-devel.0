From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 14/29] mds: fix lock state transition check
Date: Fri,  4 Jan 2013 17:02:05 +0800
Message-ID: <1357290140-17044-15-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50946 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814Ab3ADJCm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:42 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Locker::simple_excl() and Locker::scatter_mix() miss is_rdlocked
check; Locker::file_excl() miss is_rdlocked check and is_wrlocked
check.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index dec0a94..e826321 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -3408,6 +3408,8 @@ void Locker::simple_excl(SimpleLock *lock, bool *need_issue)
   }
   
   int gather = 0;
+  if (lock->is_rdlocked())
+    gather++;
   if (lock->is_wrlocked())
     gather++;
   if (lock->is_xlocked())
@@ -4167,6 +4169,8 @@ void Locker::scatter_mix(ScatterLock *lock, bool *need_issue)
     }
 
     int gather = 0;
+    if (lock->is_rdlocked())
+      gather++;
     if (in->is_replicated()) {
       if (lock->get_state() != LOCK_EXCL_MIX &&   // EXCL replica is already LOCK
 	  lock->get_state() != LOCK_XSYN_EXCL) {  // XSYN replica is already LOCK;  ** FIXME here too!
@@ -4237,6 +4241,11 @@ void Locker::file_excl(ScatterLock *lock, bool *need_issue)
   }
   int gather = 0;
   
+  if (lock->is_rdlocked())
+    gather++;
+  if (lock->is_wrlocked())
+    gather++;
+
   if (in->is_replicated() &&
       lock->get_state() != LOCK_LOCK_EXCL &&
       lock->get_state() != LOCK_XSYN_EXCL) {  // if we were lock, replicas are already lock.
-- 
1.7.11.7

