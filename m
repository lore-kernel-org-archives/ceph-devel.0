From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 1/2] ceph: Do not leak fscache workqueue
Date: Tue, 27 Aug 2013 19:08:52 -0400
Message-ID: <8eeeba4f77ab7b2a3818a14d6a941b01a6c7f8c3.1377644443.git.milosz@adfin.com>
References: <cover.1377644443.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:54031 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab3H0XIt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 19:08:49 -0400
Received: by mail-qc0-f171.google.com with SMTP id n1so3057164qcw.30
        for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 16:08:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1377644443.git.milosz@adfin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, zheng.z.yan@intel.com

Previously I was not cleanup up the ceph fscache validate workqueue on
filesystem unmount.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a56baab..a14b13a 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -584,6 +584,7 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 
 #ifdef CONFIG_CEPH_FSCACHE
 	ceph_fscache_unregister_fsid_cookie(fsc);
+	destroy_workqueue(fsc->revalidate_wq);
 #endif
 
 	destroy_workqueue(fsc->wb_wq);
-- 
1.8.1.2

