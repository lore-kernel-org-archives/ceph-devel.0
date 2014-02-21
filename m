From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 4/6] rbd: do not hard-code CEPH_OSD_MAX_OP in rbd_osd_req_callback()
Date: Fri, 21 Feb 2014 20:55:44 +0200
Message-ID: <1393008946-7931-5-git-send-email-ilya.dryomov@inktank.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:52298 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbaBUS4E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 13:56:04 -0500
Received: by mail-ea0-f172.google.com with SMTP id l9so1777664eaj.3
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 10:56:02 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id m8sm19595074eef.14.2014.02.21.10.56.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 10:56:01 -0800 (PST)
In-Reply-To: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

CEPH_OSD_MAX_OP value in rbd_osd_req_callback() is hard-coded to 2.
Fix it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b365e0dfccb6..48a889866824 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1654,7 +1654,7 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	if (osd_req->r_result < 0)
 		obj_request->result = osd_req->r_result;
 
-	BUG_ON(osd_req->r_num_ops > 2);
+	BUG_ON(osd_req->r_num_ops > CEPH_OSD_MAX_OP);
 
 	/*
 	 * We support a 64-bit length, but ultimately it has to be
-- 
1.7.10.4

