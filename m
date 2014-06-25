From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 06/14] libceph: assert both regular and lingering lists in __remove_osd()
Date: Wed, 25 Jun 2014 21:16:39 +0400
Message-ID: <1403716607-13535-7-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:37236 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311AbaFYRRG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:06 -0400
Received: by mail-lb0-f171.google.com with SMTP id s7so2096575lbd.30
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:05 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id pp8sm4226985lbb.4.2014.06.25.10.17.04
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:04 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It is important that both regular and lingering requests lists are
empty when the OSD is removed.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 052eb8bfcc74..a9b7ea7bfdc6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1032,6 +1032,8 @@ static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 {
 	dout("__remove_osd %p\n", osd);
 	BUG_ON(!list_empty(&osd->o_requests));
+	BUG_ON(!list_empty(&osd->o_linger_requests));
+
 	rb_erase(&osd->o_node, &osdc->osds);
 	list_del_init(&osd->o_osd_lru);
 	ceph_con_close(&osd->o_con);
-- 
1.7.10.4

