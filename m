From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 23/29] mds: fix cap mask for ifile lock
Date: Fri,  4 Jan 2013 17:02:14 +0800
Message-ID: <1357290140-17044-24-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57521 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022Ab3ADJCw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:52 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

ifile lock has 8 cap bits, should its cap mask should be 0xff

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/SimpleLock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/SimpleLock.h b/src/mds/SimpleLock.h
index 5ea2d4b..9531a01 100644
--- a/src/mds/SimpleLock.h
+++ b/src/mds/SimpleLock.h
@@ -273,7 +273,7 @@ public:
   }
   int get_cap_mask() const {
     switch (get_type()) {
-    case CEPH_LOCK_IFILE: return 0xf;
+    case CEPH_LOCK_IFILE: return 0xff;
     default: return 0x3;
     }
   }
-- 
1.7.11.7

