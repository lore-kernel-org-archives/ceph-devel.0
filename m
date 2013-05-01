From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libceph: allocate ceph message data with a slab
Date: Wed, 01 May 2013 16:38:17 -0500
Message-ID: <51818B49.3000401@inktank.com>
References: <51818B12.4010307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34514 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761937Ab3EAViU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:38:20 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so2487015iec.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:38:19 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id p10sm26874249igj.5.2013.05.01.14.38.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:38:19 -0700 (PDT)
In-Reply-To: <51818B12.4010307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Create a slab cache to manage ceph_msg_data structure allocation.

This is part of:
    http://tracker.ceph.com/issues/3926

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index bc1ba4c..eb0a46a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -155,6 +155,7 @@ static bool con_flag_test_and_set(struct
ceph_connection *con,
 /* Slab caches for frequently-allocated structures */

 static struct kmem_cache	*ceph_msg_cache;
+static struct kmem_cache	*ceph_msg_data_cache;

 /* static tag bytes (protocol control messages) */
 static char tag_msg = CEPH_MSGR_TAG_MSG;
@@ -236,11 +237,30 @@ static int ceph_msgr_slab_init(void)
 	ceph_msg_cache = kmem_cache_create("ceph_msg",
 					sizeof (struct ceph_msg),
 					__alignof__(struct ceph_msg), 0, NULL);
-	return ceph_msg_cache ? 0 : -ENOMEM;
+
+	if (!ceph_msg_cache)
+		return -ENOMEM;
+
+	BUG_ON(ceph_msg_data_cache);
+	ceph_msg_data_cache = kmem_cache_create("ceph_msg_data",
+					sizeof (struct ceph_msg_data),
+					__alignof__(struct ceph_msg_data),
+					0, NULL);
+	if (ceph_msg_data_cache)
+		return 0;
+
+	kmem_cache_destroy(ceph_msg_cache);
+	ceph_msg_cache = NULL;
+
+	return -ENOMEM;
 }

 static void ceph_msgr_slab_exit(void)
 {
+	BUG_ON(!ceph_msg_data_cache);
+	kmem_cache_destroy(ceph_msg_data_cache);
+	ceph_msg_data_cache = NULL;
+
 	BUG_ON(!ceph_msg_cache);
 	kmem_cache_destroy(ceph_msg_cache);
 	ceph_msg_cache = NULL;
@@ -3008,7 +3028,7 @@ static struct ceph_msg_data
*ceph_msg_data_create(enum ceph_msg_data_type type)
 	if (WARN_ON(!ceph_msg_data_type_valid(type)))
 		return NULL;

-	data = kzalloc(sizeof (*data), GFP_NOFS);
+	data = kmem_cache_zalloc(ceph_msg_data_cache, GFP_NOFS);
 	if (data)
 		data->type = type;
 	INIT_LIST_HEAD(&data->links);
@@ -3026,7 +3046,7 @@ static void ceph_msg_data_destroy(struct
ceph_msg_data *data)
 		ceph_pagelist_release(data->pagelist);
 		kfree(data->pagelist);
 	}
-	kfree(data);
+	kmem_cache_free(ceph_msg_data_cache, data);
 }

 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
-- 
1.7.9.5

