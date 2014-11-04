From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/2] libceph: store session key in cephx authorizer
Date: Tue,  4 Nov 2014 17:04:51 +0800
Message-ID: <1415091892-2086-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbaKDJFP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Nov 2014 04:05:15 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA495Ec8007763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 4 Nov 2014 04:05:15 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

Session key is required when calculating message signature. Save the session key
in authorizer, this avoid lookup ticket handler for each message

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 net/ceph/auth_x.c | 18 +++++++++++-------
 net/ceph/auth_x.h |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index de6662b..8da8568 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -298,6 +298,11 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	dout("build_authorizer for %s %p\n",
 	     ceph_entity_type_name(th->service), au);
 
+	ceph_crypto_key_destroy(&au->session_key);
+	ret = ceph_crypto_key_clone(&au->session_key, &th->session_key);
+	if (ret)
+		return ret;
+
 	maxlen = sizeof(*msg_a) + sizeof(msg_b) +
 		ceph_x_encrypt_buflen(ticket_blob_len);
 	dout("  need len %d\n", maxlen);
@@ -307,8 +312,10 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	}
 	if (!au->buf) {
 		au->buf = ceph_buffer_new(maxlen, GFP_NOFS);
-		if (!au->buf)
+		if (!au->buf) {
+			ceph_crypto_key_destroy(&au->session_key);
 			return -ENOMEM;
+		}
 	}
 	au->service = th->service;
 	au->secret_id = th->secret_id;
@@ -334,7 +341,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	get_random_bytes(&au->nonce, sizeof(au->nonce));
 	msg_b.struct_v = 1;
 	msg_b.nonce = cpu_to_le64(au->nonce);
-	ret = ceph_x_encrypt(&th->session_key, &msg_b, sizeof(msg_b),
+	ret = ceph_x_encrypt(&au->session_key, &msg_b, sizeof(msg_b),
 			     p, end - p);
 	if (ret < 0)
 		goto out_buf;
@@ -593,17 +600,13 @@ static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
 					  struct ceph_authorizer *a, size_t len)
 {
 	struct ceph_x_authorizer *au = (void *)a;
-	struct ceph_x_ticket_handler *th;
 	int ret = 0;
 	struct ceph_x_authorize_reply reply;
 	void *preply = &reply;
 	void *p = au->reply_buf;
 	void *end = p + sizeof(au->reply_buf);
 
-	th = get_ticket_handler(ac, au->service);
-	if (IS_ERR(th))
-		return PTR_ERR(th);
-	ret = ceph_x_decrypt(&th->session_key, &p, end, &preply, sizeof(reply));
+	ret = ceph_x_decrypt(&au->session_key, &p, end, &preply, sizeof(reply));
 	if (ret < 0)
 		return ret;
 	if (ret != sizeof(reply))
@@ -623,6 +626,7 @@ static void ceph_x_destroy_authorizer(struct ceph_auth_client *ac,
 {
 	struct ceph_x_authorizer *au = (void *)a;
 
+	ceph_crypto_key_destroy(&au->session_key);
 	ceph_buffer_put(au->buf);
 	kfree(au);
 }
diff --git a/net/ceph/auth_x.h b/net/ceph/auth_x.h
index 65ee720..e8b7c69 100644
--- a/net/ceph/auth_x.h
+++ b/net/ceph/auth_x.h
@@ -26,6 +26,7 @@ struct ceph_x_ticket_handler {
 
 
 struct ceph_x_authorizer {
+	struct ceph_crypto_key session_key;
 	struct ceph_buffer *buf;
 	unsigned int service;
 	u64 nonce;
-- 
1.9.3

