From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: use GFP_NOIO in rbd_obj_request_create()
Date: Tue, 30 Jun 2015 22:19:02 +0300
Message-ID: <1435691942-41015-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:33324 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbF3TT0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 15:19:26 -0400
Received: by laar3 with SMTP id r3so26258650laa.0
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 12:19:24 -0700 (PDT)
Received: from localhost.localdomain ([109.110.66.238])
        by mx.google.com with ESMTPSA id aj4sm11857096lbd.5.2015.06.30.12.19.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 12:19:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_obj_request_create() is called on the main I/O path, so we need to
use GFP_NOIO to make sure allocation doesn't blow back on us.  Not all
callers need this, but I'm still hardcoding the flag inside rather than
making it a parameter because a) this is going to stable, and b) those
callers shouldn't really use rbd_obj_request_create() and will be fixed
in the future.

More memory allocation fixes will follow.

Cc: stable@vger.kernel.org # 3.10+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b316ee48a30b..d94529d5c8e9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2022,11 +2022,11 @@ static struct rbd_obj_request *rbd_obj_request_create(const char *object_name,
 	rbd_assert(obj_request_type_valid(type));
 
 	size = strlen(object_name) + 1;
-	name = kmalloc(size, GFP_KERNEL);
+	name = kmalloc(size, GFP_NOIO);
 	if (!name)
 		return NULL;
 
-	obj_request = kmem_cache_zalloc(rbd_obj_request_cache, GFP_KERNEL);
+	obj_request = kmem_cache_zalloc(rbd_obj_request_cache, GFP_NOIO);
 	if (!obj_request) {
 		kfree(name);
 		return NULL;
-- 
1.9.3

