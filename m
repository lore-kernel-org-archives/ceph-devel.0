From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 03/14] libceph: move and add dout()s to ceph_msg_{get,put}()
Date: Wed, 25 Jun 2014 21:16:36 +0400
Message-ID: <1403716607-13535-4-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:60099 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311AbaFYRQ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:16:59 -0400
Received: by mail-lb0-f170.google.com with SMTP id 10so2085846lbg.1
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:16:57 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id i10sm1805659laa.46.2014.06.25.10.16.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:16:57 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add dout()s to ceph_msg_{get,put}().  Also move them to .c and turn
kref release callback into a static function.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/messenger.h |   14 ++------------
 net/ceph/messenger.c           |   31 ++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index d21f2dba0731..40ae58e3e9db 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -285,19 +285,9 @@ extern void ceph_msg_data_add_bio(struct ceph_msg *msg, struct bio *bio,
 
 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
-extern void ceph_msg_kfree(struct ceph_msg *m);
 
-
-static inline struct ceph_msg *ceph_msg_get(struct ceph_msg *msg)
-{
-	kref_get(&msg->kref);
-	return msg;
-}
-extern void ceph_msg_last_put(struct kref *kref);
-static inline void ceph_msg_put(struct ceph_msg *msg)
-{
-	kref_put(&msg->kref, ceph_msg_last_put);
-}
+extern struct ceph_msg *ceph_msg_get(struct ceph_msg *msg);
+extern void ceph_msg_put(struct ceph_msg *msg);
 
 extern void ceph_msg_dump(struct ceph_msg *msg);
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1948d592aa54..8bffa5b90fef 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3269,24 +3269,21 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 /*
  * Free a generically kmalloc'd message.
  */
-void ceph_msg_kfree(struct ceph_msg *m)
+static void ceph_msg_free(struct ceph_msg *m)
 {
-	dout("msg_kfree %p\n", m);
+	dout("%s %p\n", __func__, m);
 	ceph_kvfree(m->front.iov_base);
 	kmem_cache_free(ceph_msg_cache, m);
 }
 
-/*
- * Drop a msg ref.  Destroy as needed.
- */
-void ceph_msg_last_put(struct kref *kref)
+static void ceph_msg_release(struct kref *kref)
 {
 	struct ceph_msg *m = container_of(kref, struct ceph_msg, kref);
 	LIST_HEAD(data);
 	struct list_head *links;
 	struct list_head *next;
 
-	dout("ceph_msg_put last one on %p\n", m);
+	dout("%s %p\n", __func__, m);
 	WARN_ON(!list_empty(&m->list_head));
 
 	/* drop middle, data, if any */
@@ -3308,9 +3305,25 @@ void ceph_msg_last_put(struct kref *kref)
 	if (m->pool)
 		ceph_msgpool_put(m->pool, m);
 	else
-		ceph_msg_kfree(m);
+		ceph_msg_free(m);
+}
+
+struct ceph_msg *ceph_msg_get(struct ceph_msg *msg)
+{
+	dout("%s %p (was %d)\n", __func__, msg,
+	     atomic_read(&msg->kref.refcount));
+	kref_get(&msg->kref);
+	return msg;
+}
+EXPORT_SYMBOL(ceph_msg_get);
+
+void ceph_msg_put(struct ceph_msg *msg)
+{
+	dout("%s %p (was %d)\n", __func__, msg,
+	     atomic_read(&msg->kref.refcount));
+	kref_put(&msg->kref, ceph_msg_release);
 }
-EXPORT_SYMBOL(ceph_msg_last_put);
+EXPORT_SYMBOL(ceph_msg_put);
 
 void ceph_msg_dump(struct ceph_msg *msg)
 {
-- 
1.7.10.4

