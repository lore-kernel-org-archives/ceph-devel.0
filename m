From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: allocate name separate from obj_request
Date: Wed, 01 May 2013 16:35:46 -0500
Message-ID: <51818AB2.1060909@inktank.com>
References: <51818A5C.1080903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41384 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758252Ab3EAVft (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:35:49 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so2399359ieb.39
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:35:48 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id fl5sm5708988igb.9.2013.05.01.14.35.47
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:35:48 -0700 (PDT)
In-Reply-To: <51818A5C.1080903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The next patch will define a slab allocator for a object requests.
To use that we'll need to allocate the name of an object separate
from the request structure itself.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 005c397..da9f41d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1758,11 +1758,16 @@ static struct rbd_obj_request
*rbd_obj_request_create(const char *object_name,
 	rbd_assert(obj_request_type_valid(type));

 	size = strlen(object_name) + 1;
-	obj_request = kzalloc(sizeof (*obj_request) + size, GFP_KERNEL);
-	if (!obj_request)
+	name = kmalloc(size, GFP_KERNEL);
+	if (!name)
+		return NULL;
+
+	obj_request = kzalloc(sizeof (*obj_request), GFP_KERNEL);
+	if (!obj_request) {
+		kfree(name);
 		return NULL;
+	}

-	name = (char *)(obj_request + 1);
 	obj_request->object_name = memcpy(name, object_name, size);
 	obj_request->offset = offset;
 	obj_request->length = length;
@@ -1808,6 +1813,7 @@ static void rbd_obj_request_destroy(struct kref *kref)
 		break;
 	}

+	kfree(obj_request->object_name);
 	kfree(obj_request);
 }

-- 
1.7.9.5

