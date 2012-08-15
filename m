From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] libceph: Assign different global_id for each ceph_auth_client.
Date: Wed, 15 Aug 2012 17:23:31 +0800
Message-ID: <1345022611-14080-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50805 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab2HOJXe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 Aug 2012 05:23:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The global_id for ceph_auth_client is always zero. It prevents the
kernel from creating more than one ceph_clients that are connected
to the same cluster. (ceph_debugfs_client_init() fails to create
debugfs directory)

Without this patch, I can't using rbd and cephfs on the same machine.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 net/ceph/auth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index b4bf4ac..2b00d3a 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -12,6 +12,8 @@
 #include "auth_x.h"
 
 
+static u64 auth_global_id;
+
 /*
  * get protocol handler
  */
@@ -54,6 +56,7 @@ struct ceph_auth_client *ceph_auth_init(const char *name, const struct ceph_cryp
 		ac->name = CEPH_AUTH_NAME_DEFAULT;
 	dout("auth_init name %s\n", ac->name);
 	ac->key = key;
+	ac->global_id = ++auth_global_id;
 	return ac;
 
 out:
-- 
1.7.11.2

