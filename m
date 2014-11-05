From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/3] libceph: change from BUG to WARN for __remove_osd() asserts
Date: Wed,  5 Nov 2014 20:33:24 +0300
Message-ID: <1415208804-10163-4-git-send-email-idryomov@redhat.com>
References: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:64387 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091AbaKERdw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 12:33:52 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so1193413lbj.27
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 09:33:50 -0800 (PST)
Received: from localhost ([109.110.66.36])
        by mx.google.com with ESMTPSA id pr7sm1552598lbc.18.2014.11.05.09.33.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Nov 2014 09:33:49 -0800 (PST)
In-Reply-To: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

No reason to use BUG_ON for osd request list assertions.

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 net/ceph/osd_client.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2a42c795b1ac..1f6c4055adaf 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1007,8 +1007,8 @@ static void put_osd(struct ceph_osd *osd)
 static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 {
 	dout("__remove_osd %p\n", osd);
-	BUG_ON(!list_empty(&osd->o_requests));
-	BUG_ON(!list_empty(&osd->o_linger_requests));
+	WARN_ON(!list_empty(&osd->o_requests));
+	WARN_ON(!list_empty(&osd->o_linger_requests));
 
 	rb_erase(&osd->o_node, &osdc->osds);
 	list_del_init(&osd->o_osd_lru);
-- 
1.7.10.4

