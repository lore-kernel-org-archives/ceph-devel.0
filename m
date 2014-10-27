From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: nuke ceph_kvfree()
Date: Mon, 27 Oct 2014 19:38:17 +0300
Message-ID: <1414427897-11486-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:57542 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbaJ0Qi1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 12:38:27 -0400
Received: by mail-lb0-f180.google.com with SMTP id z12so2639223lbi.11
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 09:38:25 -0700 (PDT)
Received: from localhost ([109.110.67.111])
        by mx.google.com with ESMTPSA id xn9sm2161582lbb.25.2014.10.27.09.38.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 09:38:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Use kvfree() from linux/mm.h instead, which is identical.  Also fix the
ceph_buffer comment: we will allocate with kmalloc() up to 32k - the
value of PAGE_ALLOC_COSTLY_ORDER, but that really is just an
implementation detail so don't mention it at all.

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 include/linux/ceph/buffer.h  |    3 +--
 include/linux/ceph/libceph.h |    1 -
 net/ceph/buffer.c            |    4 ++--
 net/ceph/ceph_common.c       |    8 --------
 net/ceph/messenger.c         |    2 +-
 5 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/include/linux/ceph/buffer.h b/include/linux/ceph/buffer.h
index 07ad423cc37f..07ca15e76100 100644
--- a/include/linux/ceph/buffer.h
+++ b/include/linux/ceph/buffer.h
@@ -10,8 +10,7 @@
 /*
  * a simple reference counted buffer.
  *
- * use kmalloc for small sizes (<= one page), vmalloc for larger
- * sizes.
+ * use kmalloc for smaller sizes, vmalloc for larger sizes.
  */
 struct ceph_buffer {
 	struct kref kref;
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 07bc359b88ac..d293f7e38814 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -184,7 +184,6 @@ extern bool libceph_compatible(void *data);
 extern const char *ceph_msg_type_name(int type);
 extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid *fsid);
 extern void *ceph_kvmalloc(size_t size, gfp_t flags);
-extern void ceph_kvfree(const void *ptr);
 
 extern struct ceph_options *ceph_parse_options(char *options,
 			      const char *dev_name, const char *dev_name_end,
diff --git a/net/ceph/buffer.c b/net/ceph/buffer.c
index 621b5f65407f..add5f921a0ff 100644
--- a/net/ceph/buffer.c
+++ b/net/ceph/buffer.c
@@ -6,7 +6,7 @@
 
 #include <linux/ceph/buffer.h>
 #include <linux/ceph/decode.h>
-#include <linux/ceph/libceph.h> /* for ceph_kv{malloc,free} */
+#include <linux/ceph/libceph.h> /* for ceph_kvmalloc */
 
 struct ceph_buffer *ceph_buffer_new(size_t len, gfp_t gfp)
 {
@@ -35,7 +35,7 @@ void ceph_buffer_release(struct kref *kref)
 	struct ceph_buffer *b = container_of(kref, struct ceph_buffer, kref);
 
 	dout("buffer_release %p\n", b);
-	ceph_kvfree(b->vec.iov_base);
+	kvfree(b->vec.iov_base);
 	kfree(b);
 }
 EXPORT_SYMBOL(ceph_buffer_release);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 58fbfe134f93..d361a274aee7 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -184,14 +184,6 @@ void *ceph_kvmalloc(size_t size, gfp_t flags)
 	return __vmalloc(size, flags | __GFP_HIGHMEM, PAGE_KERNEL);
 }
 
-void ceph_kvfree(const void *ptr)
-{
-	if (is_vmalloc_addr(ptr))
-		vfree(ptr);
-	else
-		kfree(ptr);
-}
-
 
 static int parse_fsid(const char *str, struct ceph_fsid *fsid)
 {
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8d1653caffdb..863d07ab2129 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3288,7 +3288,7 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 static void ceph_msg_free(struct ceph_msg *m)
 {
 	dout("%s %p\n", __func__, m);
-	ceph_kvfree(m->front.iov_base);
+	kvfree(m->front.iov_base);
 	kmem_cache_free(ceph_msg_cache, m);
 }
 
-- 
1.7.10.4

