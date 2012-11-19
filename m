From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 13/16] mds: fix assertion in handle_cache_expire
Date: Mon, 19 Nov 2012 10:43:45 +0800
Message-ID: <1353293028-15238-14-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57821 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab2KSCoF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:05 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

During export, it's possible to get cache expire messages in
DISCOVERING, FREEZING and PREPPING state.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 48ccc7e..5dcb3e3 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5928,6 +5928,7 @@ void MDCache::handle_cache_expire(MCacheExpire *m)
 	continue;
       }
       assert(!(parent_dir->is_auth() && parent_dir->is_exporting()) ||
+	     migrator->get_export_state(parent_dir) <= Migrator::EXPORT_PREPPING ||
              (migrator->get_export_state(parent_dir) == Migrator::EXPORT_WARNING &&
                  !migrator->export_has_warned(parent_dir, from)));
 
-- 
1.7.11.7

