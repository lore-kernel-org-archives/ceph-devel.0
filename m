From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v2 3/5] libceph: bump CEPH_OSD_MAX_OP to 3
Date: Tue, 25 Feb 2014 17:36:45 +0200
Message-ID: <1393342607-23653-4-git-send-email-ilya.dryomov@inktank.com>
References: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33437 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaBYPg7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 10:36:59 -0500
Received: by mail-lb0-f179.google.com with SMTP id l4so3341896lbv.24
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 07:36:58 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id zf7sm503021lab.7.2014.02.25.07.36.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Feb 2014 07:36:57 -0800 (PST)
In-Reply-To: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Our longest osd request now contains 3 ops: copyup+hint+write.

Also, CEPH_OSD_MAX_OP value in a BUG_ON in rbd_osd_req_callback() was
hard-coded to 2.  Fix it, and switch to rbd_assert while at it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 drivers/block/rbd.c             |    2 +-
 include/linux/ceph/osd_client.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b365e0dfccb6..bcb93332587f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1654,7 +1654,7 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	if (osd_req->r_result < 0)
 		obj_request->result = osd_req->r_result;
 
-	BUG_ON(osd_req->r_num_ops > 2);
+	rbd_assert(osd_req->r_num_ops <= CEPH_OSD_MAX_OP);
 
 	/*
 	 * We support a 64-bit length, but ultimately it has to be
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 627d663d22b7..e998ccc47fdd 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -43,7 +43,7 @@ struct ceph_osd {
 };
 
 
-#define CEPH_OSD_MAX_OP	2
+#define CEPH_OSD_MAX_OP	3
 
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
-- 
1.7.10.4

