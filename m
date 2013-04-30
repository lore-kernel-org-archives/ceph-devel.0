From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: drop obj_request->version
Date: Tue, 30 Apr 2013 07:32:40 -0500
Message-ID: <517FB9E8.8060408@inktank.com>
References: <517FB909.40309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44789 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760554Ab3D3Mct (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:32:49 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so495231iea.18
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:32:48 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id 9sm22263444igy.7.2013.04.30.05.32.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:32:41 -0700 (PDT)
In-Reply-To: <517FB909.40309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Nothing ever uses the version field maintained in the object request
structure any more, so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ddf4305..15e84d8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -225,7 +225,6 @@ struct rbd_obj_request {
 	struct ceph_osd_request	*osd_req;

 	u64			xferred;	/* bytes transferred */
-	u64			version;
 	int			result;

 	rbd_obj_callback_t	callback;
@@ -1486,7 +1485,6 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,

 	if (osd_req->r_result < 0)
 		obj_request->result = osd_req->r_result;
-	obj_request->version = le64_to_cpu(osd_req->r_reassert_version.version);

 	BUG_ON(osd_req->r_num_ops > 2);

-- 
1.7.9.5

