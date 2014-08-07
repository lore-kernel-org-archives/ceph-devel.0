From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: allocate img_request with GFP_NOIO instead GFP_ATOMIC
Date: Thu,  7 Aug 2014 13:40:11 +0400
Message-ID: <1407404411-4928-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:49678 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbaHGJkQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Aug 2014 05:40:16 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so3236826lab.26
        for <ceph-devel@vger.kernel.org>; Thu, 07 Aug 2014 02:40:14 -0700 (PDT)
Received: from localhost ([109.110.66.143])
        by mx.google.com with ESMTPSA id xu8sm1811240lab.41.2014.08.07.02.40.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 02:40:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that rbd_img_request_create() is called from work functions, no
need to use GFP_ATOMIC.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4515b128d0b4..a5ebcf28e041 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2061,7 +2061,7 @@ static struct rbd_img_request *rbd_img_request_create(
 {
 	struct rbd_img_request *img_request;
 
-	img_request = kmem_cache_alloc(rbd_img_request_cache, GFP_ATOMIC);
+	img_request = kmem_cache_alloc(rbd_img_request_cache, GFP_NOIO);
 	if (!img_request)
 		return NULL;
 
-- 
1.7.10.4

