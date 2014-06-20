From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/4] libceph: assert both regular and lingering lists in __remove_osd()
Date: Fri, 20 Jun 2014 13:09:40 +0400
Message-ID: <1403255383-5729-2-git-send-email-ilya.dryomov@inktank.com>
References: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:42301 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbaFTJJu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 05:09:50 -0400
Received: by mail-la0-f43.google.com with SMTP id e16so2214271lan.30
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jun 2014 02:09:49 -0700 (PDT)
Received: from localhost ([109.110.66.173])
        by mx.google.com with ESMTPSA id of9sm6153072lbb.4.2014.06.20.02.09.47
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 02:09:48 -0700 (PDT)
In-Reply-To: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It is important that both regular and lingering requests lists are
empty when the OSD is removed.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b0dfce77656a..6b8c5e8c49ce 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1007,7 +1007,8 @@ static void put_osd(struct ceph_osd *osd)
 static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 {
 	dout("__remove_osd %p\n", osd);
-	BUG_ON(!list_empty(&osd->o_requests));
+	BUG_ON(!list_empty(&osd->o_requests) ||
+	       !list_empty(&osd->o_linger_requests));
 	rb_erase(&osd->o_node, &osdc->osds);
 	list_del_init(&osd->o_osd_lru);
 	ceph_con_close(&osd->o_con);
-- 
1.7.10.4

