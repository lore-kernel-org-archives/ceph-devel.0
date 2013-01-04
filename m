From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 16/29] mds: don't defer processing caps if inode is auth pinned
Date: Fri,  4 Jan 2013 17:02:07 +0800
Message-ID: <1357290140-17044-17-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28255 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab3ADJCo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:44 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We should not defer processing caps if the inode is auth pinned by MDRequest,
because the MDRequest may change lock state of the inode later and wait for
the deferred caps.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index ee2d4cc..dbf4452 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2199,12 +2199,11 @@ bool Locker::should_defer_client_cap_frozen(CInode *in)
    * Currently, a request wait if anything locked is freezing (can't
    * auth_pin), which would avoid any deadlock with cap release.  Thus @in
    * _MUST_ be in the lock/auth_pin set.
+   *
+   * auth_pins==0 implies no unstable lock and not auth pinnned by
+   * client request, otherwise continue even it's freezing.
    */
-  return (in->is_freezing() && (in->filelock.is_stable() &&
-				in->authlock.is_stable() &&
-				in->xattrlock.is_stable() &&
-				in->linklock.is_stable())) ||  // continue if freezing and lock is unstable
-    in->is_frozen();
+  return (in->is_freezing() && in->get_num_auth_pins() == 0) || in->is_frozen();
 }
 
 /*
-- 
1.7.11.7

