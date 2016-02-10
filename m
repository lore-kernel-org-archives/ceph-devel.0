From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/4] libceph: osdc->req_mempool should be backed by a slab pool
Date: Wed, 10 Feb 2016 12:24:06 +0100
Message-ID: <1455103447-23559-4-git-send-email-idryomov@gmail.com>
References: <1455103447-23559-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35279 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbcBJLYm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 06:24:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id g62so3532377wme.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 03:24:42 -0800 (PST)
In-Reply-To: <1455103447-23559-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

ceph_osd_request_cache was introduced a long time ago.  Also, osd_req
is about to get a flexible array member, which ceph_osd_request_cache
is going to be aware of.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d92fd4ad5a66..8bf4f74064e5 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2637,8 +2637,8 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	    round_jiffies_relative(osdc->client->options->osd_idle_ttl));
 
 	err = -ENOMEM;
-	osdc->req_mempool = mempool_create_kmalloc_pool(10,
-					sizeof(struct ceph_osd_request));
+	osdc->req_mempool = mempool_create_slab_pool(10,
+						     ceph_osd_request_cache);
 	if (!osdc->req_mempool)
 		goto out;
 
-- 
2.4.3

