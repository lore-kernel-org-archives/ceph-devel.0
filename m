From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/3] ceph: flush cap release queue when trimming session caps
Date: Tue,  1 Apr 2014 20:43:04 +0800
Message-ID: <1396356184-4317-3-git-send-email-zheng.z.yan@intel.com>
References: <1396356184-4317-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19264 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbaDAMnL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Apr 2014 08:43:11 -0400
In-Reply-To: <1396356184-4317-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 19fbfc4..2b4d093 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1311,6 +1311,9 @@ static int trim_caps(struct ceph_mds_client *mdsc,
 			trim_caps - session->s_trim_caps);
 		session->s_trim_caps = 0;
 	}
+
+	ceph_add_cap_releases(mdsc, session);
+	ceph_send_cap_releases(mdsc, session);
 	return 0;
 }
 
-- 
1.8.5.3

