From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/6] libceph: grab snapc in ceph_osdc_alloc_request()
Date: Thu, 19 May 2016 16:06:38 +0200
Message-ID: <1463666802-25140-3-git-send-email-idryomov@gmail.com>
References: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34827 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbcESOHJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 10:07:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id s63so6790021wme.2
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 07:07:08 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-165-81.net.upcbroadband.cz. [94.112.165.81])
        by smtp.gmail.com with ESMTPSA id b124sm3586833wmb.1.2016.05.19.07.07.07
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 07:07:07 -0700 (PDT)
In-Reply-To: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ceph_osdc_build_request() is going away.  Grab snapc and initialize
->r_snapid in ceph_osdc_alloc_request().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cacce9e35f08..ccb9539dc780 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -391,6 +391,8 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	req->r_osdc = osdc;
 	req->r_mempool = use_mempool;
 	req->r_num_ops = num_ops;
+	req->r_snapid = CEPH_NOSNAP;
+	req->r_snapc = ceph_get_snap_context(snapc);
 
 	kref_init(&req->r_kref);
 	init_completion(&req->r_completion);
@@ -2457,7 +2459,7 @@ void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 	unsigned int i;
 
 	req->r_snapid = snap_id;
-	req->r_snapc = ceph_get_snap_context(snapc);
+	WARN_ON(snapc != req->r_snapc);
 
 	/* encode request */
 	msg->hdr.version = cpu_to_le16(4);
@@ -2508,7 +2510,7 @@ void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 	ceph_encode_64(&p, req->r_snapc ? req->r_snapc->seq : 0);
 	ceph_encode_32(&p, req->r_snapc ? req->r_snapc->num_snaps : 0);
 	if (req->r_snapc) {
-		for (i = 0; i < snapc->num_snaps; i++) {
+		for (i = 0; i < req->r_snapc->num_snaps; i++) {
 			ceph_encode_64(&p, req->r_snapc->snaps[i]);
 		}
 	}
-- 
2.4.3

