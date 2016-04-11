From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: make authorizer destruction independent of ceph_auth_client
Date: Mon, 11 Apr 2016 19:42:49 +0200
Message-ID: <1460396569-22254-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33221 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcDKRnX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 13:43:23 -0400
Received: by mail-wm0-f41.google.com with SMTP id f198so155598966wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 10:43:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alan Zhang <alan.zhang@linux.com>

Starting the kernel client with cephx disabled and then enabling cephx
and restarting userspace daemons can result in a crash:

    [262671.478162] BUG: unable to handle kernel paging request at ffffebe000000000
    [262671.531460] IP: [<ffffffff811cd04a>] kfree+0x5a/0x130
    [262671.584334] PGD 0
    [262671.635847] Oops: 0000 [#1] SMP
    [262672.055841] CPU: 22 PID: 2961272 Comm: kworker/22:2 Not tainted 4.2.0-34-generic #39~14.04.1-Ubuntu
    [262672.162338] Hardware name: Dell Inc. PowerEdge R720/068CDY, BIOS 2.4.3 07/09/2014
    [262672.268937] Workqueue: ceph-msgr con_work [libceph]
    [262672.322290] task: ffff88081c2d0dc0 ti: ffff880149ae8000 task.ti: ffff880149ae8000
    [262672.428330] RIP: 0010:[<ffffffff811cd04a>]  [<ffffffff811cd04a>] kfree+0x5a/0x130
    [262672.535880] RSP: 0018:ffff880149aeba58  EFLAGS: 00010286
    [262672.589486] RAX: 000001e000000000 RBX: 0000000000000012 RCX: ffff8807e7461018
    [262672.695980] RDX: 000077ff80000000 RSI: ffff88081af2be04 RDI: 0000000000000012
    [262672.803668] RBP: ffff880149aeba78 R08: 0000000000000000 R09: 0000000000000000
    [262672.912299] R10: ffffebe000000000 R11: ffff880819a60e78 R12: ffff8800aec8df40
    [262673.021769] R13: ffffffffc035f70f R14: ffff8807e5b138e0 R15: ffff880da9785840
    [262673.131722] FS:  0000000000000000(0000) GS:ffff88081fac0000(0000) knlGS:0000000000000000
    [262673.245377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [262673.303281] CR2: ffffebe000000000 CR3: 0000000001c0d000 CR4: 00000000001406e0
    [262673.417556] Stack:
    [262673.472943]  ffff880149aeba88 ffff88081af2be04 ffff8800aec8df40 ffff88081af2be04
    [262673.583767]  ffff880149aeba98 ffffffffc035f70f ffff880149aebac8 ffff8800aec8df00
    [262673.694546]  ffff880149aebac8 ffffffffc035c89e ffff8807e5b138e0 ffff8805b047f800
    [262673.805230] Call Trace:
    [262673.859116]  [<ffffffffc035f70f>] ceph_x_destroy_authorizer+0x1f/0x50 [libceph]
    [262673.968705]  [<ffffffffc035c89e>] ceph_auth_destroy_authorizer+0x3e/0x60 [libceph]
    [262674.078852]  [<ffffffffc0352805>] put_osd+0x45/0x80 [libceph]
    [262674.134249]  [<ffffffffc035290e>] remove_osd+0xae/0x140 [libceph]
    [262674.189124]  [<ffffffffc0352aa3>] __reset_osd+0x103/0x150 [libceph]
    [262674.243749]  [<ffffffffc0354703>] kick_requests+0x223/0x460 [libceph]
    [262674.297485]  [<ffffffffc03559e2>] ceph_osdc_handle_map+0x282/0x5e0 [libceph]
    [262674.350813]  [<ffffffffc035022e>] dispatch+0x4e/0x720 [libceph]
    [262674.403312]  [<ffffffffc034bd91>] try_read+0x3d1/0x1090 [libceph]
    [262674.454712]  [<ffffffff810ab7c2>] ? dequeue_entity+0x152/0x690
    [262674.505096]  [<ffffffffc034cb1b>] con_work+0xcb/0x1300 [libceph]
    [262674.555104]  [<ffffffff8108fb3e>] process_one_work+0x14e/0x3d0
    [262674.604072]  [<ffffffff810901ea>] worker_thread+0x11a/0x470
    [262674.652187]  [<ffffffff810900d0>] ? rescuer_thread+0x310/0x310
    [262674.699022]  [<ffffffff810957a2>] kthread+0xd2/0xf0
    [262674.744494]  [<ffffffff810956d0>] ? kthread_create_on_node+0x1c0/0x1c0
    [262674.789543]  [<ffffffff817bd81f>] ret_from_fork+0x3f/0x70
    [262674.834094]  [<ffffffff810956d0>] ? kthread_create_on_node+0x1c0/0x1c0

What happens is the following:

    (1) new MON session is established
    (2) old "none" ac is destroyed
    (3) new "cephx" ac is constructed
    ...
    (4) old OSD session (w/ "none" authorizer) is put
          ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer)

osd->o_auth.authorizer in the "none" case is just a bare pointer into
ac, which contains a single static copy for all services.  By the time
we get to (4), "none" ac, freed in (2), is long gone.  On top of that,
a new vtable installed in (3) points us at ceph_x_destroy_authorizer(),
so we end up trying to destroy a "none" authorizer with a "cephx"
destructor operating on invalid memory!

To fix this, decouple authorizer destruction from ac and do away with
a single static "none" authorizer by making a copy for each OSD or MDS
session.  Authorizers themselves are independent of ac and so there is
no reason for destroy_authorizer() to be an ac op.  Make it an op on
the authorizer itself by turning ceph_authorizer into a real struct.

Fixes: http://tracker.ceph.com/issues/15447

Reported-by: Alan Zhang <alan.zhang@linux.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/mds_client.c            |  6 ++--
 include/linux/ceph/auth.h       | 10 +++---
 include/linux/ceph/osd_client.h |  1 -
 net/ceph/auth.c                 |  8 ++---
 net/ceph/auth_none.c            | 71 ++++++++++++++++++++++-------------------
 net/ceph/auth_none.h            |  3 +-
 net/ceph/auth_x.c               | 21 ++++++------
 net/ceph/auth_x.h               |  1 +
 net/ceph/osd_client.c           |  6 ++--
 9 files changed, 62 insertions(+), 65 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 44852c3ae531..c150c85e54ec 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -386,9 +386,7 @@ void ceph_put_mds_session(struct ceph_mds_session *s)
 	     atomic_read(&s->s_ref), atomic_read(&s->s_ref)-1);
 	if (atomic_dec_and_test(&s->s_ref)) {
 		if (s->s_auth.authorizer)
-			ceph_auth_destroy_authorizer(
-				s->s_mdsc->fsc->client->monc.auth,
-				s->s_auth.authorizer);
+			ceph_auth_destroy_authorizer(s->s_auth.authorizer);
 		kfree(s);
 	}
 }
@@ -3900,7 +3898,7 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
 	struct ceph_auth_handshake *auth = &s->s_auth;
 
 	if (force_new && auth->authorizer) {
-		ceph_auth_destroy_authorizer(ac, auth->authorizer);
+		ceph_auth_destroy_authorizer(auth->authorizer);
 		auth->authorizer = NULL;
 	}
 	if (!auth->authorizer) {
diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
index 260d78b587c4..1563265d2097 100644
--- a/include/linux/ceph/auth.h
+++ b/include/linux/ceph/auth.h
@@ -12,9 +12,12 @@
  */
 
 struct ceph_auth_client;
-struct ceph_authorizer;
 struct ceph_msg;
 
+struct ceph_authorizer {
+	void (*destroy)(struct ceph_authorizer *);
+};
+
 struct ceph_auth_handshake {
 	struct ceph_authorizer *authorizer;
 	void *authorizer_buf;
@@ -62,8 +65,6 @@ struct ceph_auth_client_ops {
 				 struct ceph_auth_handshake *auth);
 	int (*verify_authorizer_reply)(struct ceph_auth_client *ac,
 				       struct ceph_authorizer *a, size_t len);
-	void (*destroy_authorizer)(struct ceph_auth_client *ac,
-				   struct ceph_authorizer *a);
 	void (*invalidate_authorizer)(struct ceph_auth_client *ac,
 				      int peer_type);
 
@@ -112,8 +113,7 @@ extern int ceph_auth_is_authenticated(struct ceph_auth_client *ac);
 extern int ceph_auth_create_authorizer(struct ceph_auth_client *ac,
 				       int peer_type,
 				       struct ceph_auth_handshake *auth);
-extern void ceph_auth_destroy_authorizer(struct ceph_auth_client *ac,
-					 struct ceph_authorizer *a);
+void ceph_auth_destroy_authorizer(struct ceph_authorizer *a);
 extern int ceph_auth_update_authorizer(struct ceph_auth_client *ac,
 				       int peer_type,
 				       struct ceph_auth_handshake *a);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 4343df806710..cbf460927c42 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -16,7 +16,6 @@ struct ceph_msg;
 struct ceph_snap_context;
 struct ceph_osd_request;
 struct ceph_osd_client;
-struct ceph_authorizer;
 
 /*
  * completion callback for async writepages
diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index 6b923bcaa2a4..2bc5965fdd1e 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -293,13 +293,9 @@ int ceph_auth_create_authorizer(struct ceph_auth_client *ac,
 }
 EXPORT_SYMBOL(ceph_auth_create_authorizer);
 
-void ceph_auth_destroy_authorizer(struct ceph_auth_client *ac,
-				  struct ceph_authorizer *a)
+void ceph_auth_destroy_authorizer(struct ceph_authorizer *a)
 {
-	mutex_lock(&ac->mutex);
-	if (ac->ops && ac->ops->destroy_authorizer)
-		ac->ops->destroy_authorizer(ac, a);
-	mutex_unlock(&ac->mutex);
+	a->destroy(a);
 }
 EXPORT_SYMBOL(ceph_auth_destroy_authorizer);
 
diff --git a/net/ceph/auth_none.c b/net/ceph/auth_none.c
index 8c93fa8d81bc..5f836f02ae36 100644
--- a/net/ceph/auth_none.c
+++ b/net/ceph/auth_none.c
@@ -16,7 +16,6 @@ static void reset(struct ceph_auth_client *ac)
 	struct ceph_auth_none_info *xi = ac->private;
 
 	xi->starting = true;
-	xi->built_authorizer = false;
 }
 
 static void destroy(struct ceph_auth_client *ac)
@@ -39,6 +38,27 @@ static int should_authenticate(struct ceph_auth_client *ac)
 	return xi->starting;
 }
 
+static int ceph_auth_none_build_authorizer(struct ceph_auth_client *ac,
+					   struct ceph_none_authorizer *au)
+{
+	void *p = au->buf;
+	void *const end = p + sizeof(au->buf);
+	int ret;
+
+	ceph_encode_8_safe(&p, end, 1, e_range);
+	ret = ceph_entity_name_encode(ac->name, &p, end);
+	if (ret < 0)
+		return ret;
+
+	ceph_encode_64_safe(&p, end, ac->global_id, e_range);
+	au->buf_len = p - (void *)au->buf;
+	dout("%s built authorizer len %d\n", __func__, au->buf_len);
+	return 0;
+
+e_range:
+	return -ERANGE;
+}
+
 static int build_request(struct ceph_auth_client *ac, void *buf, void *end)
 {
 	return 0;
@@ -57,32 +77,32 @@ static int handle_reply(struct ceph_auth_client *ac, int result,
 	return result;
 }
 
+static void ceph_auth_none_destroy_authorizer(struct ceph_authorizer *a)
+{
+	kfree(a);
+}
+
 /*
- * build an 'authorizer' with our entity_name and global_id.  we can
- * reuse a single static copy since it is identical for all services
- * we connect to.
+ * build an 'authorizer' with our entity_name and global_id.  it is
+ * identical for all services we connect to.
  */
 static int ceph_auth_none_create_authorizer(
 	struct ceph_auth_client *ac, int peer_type,
 	struct ceph_auth_handshake *auth)
 {
-	struct ceph_auth_none_info *ai = ac->private;
-	struct ceph_none_authorizer *au = &ai->au;
-	void *p, *end;
+	struct ceph_none_authorizer *au;
 	int ret;
 
-	if (!ai->built_authorizer) {
-		p = au->buf;
-		end = p + sizeof(au->buf);
-		ceph_encode_8(&p, 1);
-		ret = ceph_entity_name_encode(ac->name, &p, end - 8);
-		if (ret < 0)
-			goto bad;
-		ceph_decode_need(&p, end, sizeof(u64), bad2);
-		ceph_encode_64(&p, ac->global_id);
-		au->buf_len = p - (void *)au->buf;
-		ai->built_authorizer = true;
-		dout("built authorizer len %d\n", au->buf_len);
+	au = kmalloc(sizeof(*au), GFP_NOFS);
+	if (!au)
+		return -ENOMEM;
+
+	au->base.destroy = ceph_auth_none_destroy_authorizer;
+
+	ret = ceph_auth_none_build_authorizer(ac, au);
+	if (ret) {
+		kfree(au);
+		return ret;
 	}
 
 	auth->authorizer = (struct ceph_authorizer *) au;
@@ -92,17 +112,6 @@ static int ceph_auth_none_create_authorizer(
 	auth->authorizer_reply_buf_len = sizeof (au->reply_buf);
 
 	return 0;
-
-bad2:
-	ret = -ERANGE;
-bad:
-	return ret;
-}
-
-static void ceph_auth_none_destroy_authorizer(struct ceph_auth_client *ac,
-				      struct ceph_authorizer *a)
-{
-	/* nothing to do */
 }
 
 static const struct ceph_auth_client_ops ceph_auth_none_ops = {
@@ -114,7 +123,6 @@ static const struct ceph_auth_client_ops ceph_auth_none_ops = {
 	.build_request = build_request,
 	.handle_reply = handle_reply,
 	.create_authorizer = ceph_auth_none_create_authorizer,
-	.destroy_authorizer = ceph_auth_none_destroy_authorizer,
 };
 
 int ceph_auth_none_init(struct ceph_auth_client *ac)
@@ -127,7 +135,6 @@ int ceph_auth_none_init(struct ceph_auth_client *ac)
 		return -ENOMEM;
 
 	xi->starting = true;
-	xi->built_authorizer = false;
 
 	ac->protocol = CEPH_AUTH_NONE;
 	ac->private = xi;
diff --git a/net/ceph/auth_none.h b/net/ceph/auth_none.h
index 059a3ce4b53f..62021535ae4a 100644
--- a/net/ceph/auth_none.h
+++ b/net/ceph/auth_none.h
@@ -12,6 +12,7 @@
  */
 
 struct ceph_none_authorizer {
+	struct ceph_authorizer base;
 	char buf[128];
 	int buf_len;
 	char reply_buf[0];
@@ -19,8 +20,6 @@ struct ceph_none_authorizer {
 
 struct ceph_auth_none_info {
 	bool starting;
-	bool built_authorizer;
-	struct ceph_none_authorizer au;   /* we only need one; it's static */
 };
 
 int ceph_auth_none_init(struct ceph_auth_client *ac);
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 9e43a315e662..a0905f04bd13 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -565,6 +565,14 @@ static int ceph_x_handle_reply(struct ceph_auth_client *ac, int result,
 	return -EAGAIN;
 }
 
+static void ceph_x_destroy_authorizer(struct ceph_authorizer *a)
+{
+	struct ceph_x_authorizer *au = (void *)a;
+
+	ceph_x_authorizer_cleanup(au);
+	kfree(au);
+}
+
 static int ceph_x_create_authorizer(
 	struct ceph_auth_client *ac, int peer_type,
 	struct ceph_auth_handshake *auth)
@@ -581,6 +589,8 @@ static int ceph_x_create_authorizer(
 	if (!au)
 		return -ENOMEM;
 
+	au->base.destroy = ceph_x_destroy_authorizer;
+
 	ret = ceph_x_build_authorizer(ac, th, au);
 	if (ret) {
 		kfree(au);
@@ -643,16 +653,6 @@ static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
 	return ret;
 }
 
-static void ceph_x_destroy_authorizer(struct ceph_auth_client *ac,
-				      struct ceph_authorizer *a)
-{
-	struct ceph_x_authorizer *au = (void *)a;
-
-	ceph_x_authorizer_cleanup(au);
-	kfree(au);
-}
-
-
 static void ceph_x_reset(struct ceph_auth_client *ac)
 {
 	struct ceph_x_info *xi = ac->private;
@@ -770,7 +770,6 @@ static const struct ceph_auth_client_ops ceph_x_ops = {
 	.create_authorizer = ceph_x_create_authorizer,
 	.update_authorizer = ceph_x_update_authorizer,
 	.verify_authorizer_reply = ceph_x_verify_authorizer_reply,
-	.destroy_authorizer = ceph_x_destroy_authorizer,
 	.invalidate_authorizer = ceph_x_invalidate_authorizer,
 	.reset =  ceph_x_reset,
 	.destroy = ceph_x_destroy,
diff --git a/net/ceph/auth_x.h b/net/ceph/auth_x.h
index 40b1a3cf7397..21a5af904bae 100644
--- a/net/ceph/auth_x.h
+++ b/net/ceph/auth_x.h
@@ -26,6 +26,7 @@ struct ceph_x_ticket_handler {
 
 
 struct ceph_x_authorizer {
+	struct ceph_authorizer base;
 	struct ceph_crypto_key session_key;
 	struct ceph_buffer *buf;
 	unsigned int service;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 32355d9d0103..40a53a70efdf 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1087,10 +1087,8 @@ static void put_osd(struct ceph_osd *osd)
 	dout("put_osd %p %d -> %d\n", osd, atomic_read(&osd->o_ref),
 	     atomic_read(&osd->o_ref) - 1);
 	if (atomic_dec_and_test(&osd->o_ref)) {
-		struct ceph_auth_client *ac = osd->o_osdc->client->monc.auth;
-
 		if (osd->o_auth.authorizer)
-			ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
+			ceph_auth_destroy_authorizer(osd->o_auth.authorizer);
 		kfree(osd);
 	}
 }
@@ -2984,7 +2982,7 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
 	struct ceph_auth_handshake *auth = &o->o_auth;
 
 	if (force_new && auth->authorizer) {
-		ceph_auth_destroy_authorizer(ac, auth->authorizer);
+		ceph_auth_destroy_authorizer(auth->authorizer);
 		auth->authorizer = NULL;
 	}
 	if (!auth->authorizer) {
-- 
2.4.3

