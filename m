From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] libceph: allocate ceph messages with a slab allocator
Date: Wed, 01 May 2013 16:38:06 -0500
Message-ID: <51818B3E.8020007@inktank.com>
References: <51818B12.4010307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61616 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760761Ab3EAViJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:38:09 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so2442638iec.22
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:38:08 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id dy5sm5801450igc.1.2013.05.01.14.38.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:38:07 -0700 (PDT)
In-Reply-To: <51818B12.4010307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Create a slab cache to manage ceph_msg structure allocation.

This is part of:
    http://tracker.ceph.com/issues/3926

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 91dd451..bc1ba4c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -152,6 +152,10 @@ static bool con_flag_test_and_set(struct
ceph_connection *con,
 	return test_and_set_bit(con_flag, &con->flags);
 }

+/* Slab caches for frequently-allocated structures */
+
+static struct kmem_cache	*ceph_msg_cache;
+
 /* static tag bytes (protocol control messages) */
 static char tag_msg = CEPH_MSGR_TAG_MSG;
 static char tag_ack = CEPH_MSGR_TAG_ACK;
@@ -226,6 +230,22 @@ static void encode_my_addr(struct ceph_messenger *msgr)
  */
 static struct workqueue_struct *ceph_msgr_wq;

+static int ceph_msgr_slab_init(void)
+{
+	BUG_ON(ceph_msg_cache);
+	ceph_msg_cache = kmem_cache_create("ceph_msg",
+					sizeof (struct ceph_msg),
+					__alignof__(struct ceph_msg), 0, NULL);
+	return ceph_msg_cache ? 0 : -ENOMEM;
+}
+
+static void ceph_msgr_slab_exit(void)
+{
+	BUG_ON(!ceph_msg_cache);
+	kmem_cache_destroy(ceph_msg_cache);
+	ceph_msg_cache = NULL;
+}
+
 static void _ceph_msgr_exit(void)
 {
 	if (ceph_msgr_wq) {
@@ -233,6 +253,8 @@ static void _ceph_msgr_exit(void)
 		ceph_msgr_wq = NULL;
 	}

+	ceph_msgr_slab_exit();
+
 	BUG_ON(zero_page == NULL);
 	kunmap(zero_page);
 	page_cache_release(zero_page);
@@ -245,6 +267,9 @@ int ceph_msgr_init(void)
 	zero_page = ZERO_PAGE(0);
 	page_cache_get(zero_page);

+	if (ceph_msgr_slab_init())
+		return -ENOMEM;
+
 	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_NON_REENTRANT, 0);
 	if (ceph_msgr_wq)
 		return 0;
@@ -3068,7 +3093,7 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 {
 	struct ceph_msg *m;

-	m = kzalloc(sizeof(*m), flags);
+	m = kmem_cache_zalloc(ceph_msg_cache, flags);
 	if (m == NULL)
 		goto out;

@@ -3215,7 +3240,7 @@ void ceph_msg_kfree(struct ceph_msg *m)
 		vfree(m->front.iov_base);
 	else
 		kfree(m->front.iov_base);
-	kfree(m);
+	kmem_cache_free(ceph_msg_cache, m);
 }

 /*
-- 
1.7.9.5

