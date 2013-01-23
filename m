From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/25] mds: properly set error_dentry for discover reply
Date: Wed, 23 Jan 2013 11:08:42 +0800
Message-ID: <1358910541-15535-7-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab3AWDJK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:10 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If MDCache::handle_discover() receives an 'discover path' request but
can not find the base inode. It should properly set the 'error_dentry'
to make sure MDCache::handle_discover_reply() checks correct object's
wait queue.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 9557436..adcf8c1 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8644,6 +8644,8 @@ void MDCache::handle_discover(MDiscover *dis)
       dout(7) << "handle_discover mds." << from 
 	      << " don't have base ino " << dis->get_base_ino() << "." << snapid
 	      << dendl;
+      if (!dis->wants_base_dir() && dis->get_want().depth() > 0)
+	reply->set_error_dentry(dis->get_dentry(0));
       reply->set_flag_error_dir();
     } else if (dis->wants_base_dir()) {
       dout(7) << "handle_discover mds." << from 
-- 
1.7.11.7

