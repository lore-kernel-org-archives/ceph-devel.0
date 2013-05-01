From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: allocate object requests with a slab allocator
Date: Wed, 01 May 2013 16:36:04 -0500
Message-ID: <51818AC4.3070702@inktank.com>
References: <51818A5C.1080903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:59404 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab3EAVgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:36:07 -0400
Received: by mail-ia0-f173.google.com with SMTP id 21so51162iay.18
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:36:06 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ha2sm22613279igb.1.2013.05.01.14.36.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:36:06 -0700 (PDT)
In-Reply-To: <51818A5C.1080903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Create a slab cache to manage rbd_obj_request allocation.  We aren't
using a constructor, and we'll zero-fill object request structures
when they're allocated.

This is part of:
    http://tracker.ceph.com/issues/3926

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index da9f41d..28a5ea3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -346,6 +346,7 @@ static LIST_HEAD(rbd_client_list);		/* clients */
 static DEFINE_SPINLOCK(rbd_client_list_lock);

 static struct kmem_cache	*rbd_img_request_cache;
+static struct kmem_cache	*rbd_obj_request_cache;

 static int rbd_img_request_submit(struct rbd_img_request *img_request);

@@ -1762,7 +1763,7 @@ static struct rbd_obj_request
*rbd_obj_request_create(const char *object_name,
 	if (!name)
 		return NULL;

-	obj_request = kzalloc(sizeof (*obj_request), GFP_KERNEL);
+	obj_request = kmem_cache_zalloc(rbd_obj_request_cache, GFP_KERNEL);
 	if (!obj_request) {
 		kfree(name);
 		return NULL;
@@ -1814,7 +1815,8 @@ static void rbd_obj_request_destroy(struct kref *kref)
 	}

 	kfree(obj_request->object_name);
-	kfree(obj_request);
+	obj_request->object_name = NULL;
+	kmem_cache_free(rbd_obj_request_cache, obj_request);
 }

 /*
@@ -5008,14 +5010,29 @@ static int rbd_slab_init(void)
 					sizeof (struct rbd_img_request),
 					__alignof__(struct rbd_img_request),
 					0, NULL);
-	if (rbd_img_request_cache)
+	if (!rbd_img_request_cache)
+		return -ENOMEM;
+
+	rbd_assert(!rbd_obj_request_cache);
+	rbd_obj_request_cache = kmem_cache_create("rbd_obj_request",
+					sizeof (struct rbd_obj_request),
+					__alignof__(struct rbd_obj_request),
+					0, NULL);
+	if (rbd_obj_request_cache)
 		return 0;

+	kmem_cache_destroy(rbd_img_request_cache);
+	rbd_img_request_cache = NULL;
+
 	return -ENOMEM;
 }

 static void rbd_slab_exit(void)
 {
+	rbd_assert(rbd_obj_request_cache);
+	kmem_cache_destroy(rbd_obj_request_cache);
+	rbd_obj_request_cache = NULL;
+
 	rbd_assert(rbd_img_request_cache);
 	kmem_cache_destroy(rbd_img_request_cache);
 	rbd_img_request_cache = NULL;
-- 
1.7.9.5

