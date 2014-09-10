From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/3] libceph: add process_one_ticket() helper
Date: Wed, 10 Sep 2014 11:54:30 +0400
Message-ID: <1410335671-4581-3-git-send-email-ilya.dryomov@inktank.com>
References: <1410335671-4581-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:55175 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaIJHyl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 03:54:41 -0400
Received: by mail-la0-f54.google.com with SMTP id b17so21387446lan.27
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 00:54:39 -0700 (PDT)
Received: from localhost ([109.110.67.183])
        by mx.google.com with ESMTPSA id as6sm5361578lbc.17.2014.09.10.00.54.38
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 00:54:38 -0700 (PDT)
In-Reply-To: <1410335671-4581-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add a helper for processing individual cephx auth tickets.  Needed for
the next commit, that deals with allocating ticket buffers.  (Most of
the diff here is whitespace - view with git diff -b).

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/auth_x.c |  228 +++++++++++++++++++++++++++++------------------------
 1 file changed, 124 insertions(+), 104 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 96238ba95f2b..0eb146dce1aa 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -129,17 +129,131 @@ static void remove_ticket_handler(struct ceph_auth_client *ac,
 	kfree(th);
 }
 
+static int process_one_ticket(struct ceph_auth_client *ac,
+			      struct ceph_crypto_key *secret,
+			      void **p, void *end,
+			      void *dbuf, void *ticket_buf)
+{
+	struct ceph_x_info *xi = ac->private;
+	int type;
+	u8 tkt_struct_v, blob_struct_v;
+	struct ceph_x_ticket_handler *th;
+	void *dp, *dend;
+	int dlen;
+	char is_enc;
+	struct timespec validity;
+	struct ceph_crypto_key old_key;
+	void *tp, *tpend;
+	struct ceph_timespec new_validity;
+	struct ceph_crypto_key new_session_key;
+	struct ceph_buffer *new_ticket_blob;
+	unsigned long new_expires, new_renew_after;
+	u64 new_secret_id;
+	int ret;
+
+	ceph_decode_need(p, end, sizeof(u32) + 1, bad);
+
+	type = ceph_decode_32(p);
+	dout(" ticket type %d %s\n", type, ceph_entity_type_name(type));
+
+	tkt_struct_v = ceph_decode_8(p);
+	if (tkt_struct_v != 1)
+		goto bad;
+
+	th = get_ticket_handler(ac, type);
+	if (IS_ERR(th)) {
+		ret = PTR_ERR(th);
+		goto out;
+	}
+
+	/* blob for me */
+	dlen = ceph_x_decrypt(secret, p, end, dbuf,
+			      TEMP_TICKET_BUF_LEN);
+	if (dlen <= 0) {
+		ret = dlen;
+		goto out;
+	}
+	dout(" decrypted %d bytes\n", dlen);
+	dp = dbuf;
+	dend = dp + dlen;
+
+	tkt_struct_v = ceph_decode_8(&dp);
+	if (tkt_struct_v != 1)
+		goto bad;
+
+	memcpy(&old_key, &th->session_key, sizeof(old_key));
+	ret = ceph_crypto_key_decode(&new_session_key, &dp, dend);
+	if (ret)
+		goto out;
+
+	ceph_decode_copy(&dp, &new_validity, sizeof(new_validity));
+	ceph_decode_timespec(&validity, &new_validity);
+	new_expires = get_seconds() + validity.tv_sec;
+	new_renew_after = new_expires - (validity.tv_sec / 4);
+	dout(" expires=%lu renew_after=%lu\n", new_expires,
+	     new_renew_after);
+
+	/* ticket blob for service */
+	ceph_decode_8_safe(p, end, is_enc, bad);
+	tp = ticket_buf;
+	if (is_enc) {
+		/* encrypted */
+		dout(" encrypted ticket\n");
+		dlen = ceph_x_decrypt(&old_key, p, end, ticket_buf,
+				      TEMP_TICKET_BUF_LEN);
+		if (dlen < 0) {
+			ret = dlen;
+			goto out;
+		}
+		dlen = ceph_decode_32(&tp);
+	} else {
+		/* unencrypted */
+		ceph_decode_32_safe(p, end, dlen, bad);
+		ceph_decode_need(p, end, dlen, bad);
+		ceph_decode_copy(p, ticket_buf, dlen);
+	}
+	tpend = tp + dlen;
+	dout(" ticket blob is %d bytes\n", dlen);
+	ceph_decode_need(&tp, tpend, 1 + sizeof(u64), bad);
+	blob_struct_v = ceph_decode_8(&tp);
+	new_secret_id = ceph_decode_64(&tp);
+	ret = ceph_decode_buffer(&new_ticket_blob, &tp, tpend);
+	if (ret)
+		goto out;
+
+	/* all is well, update our ticket */
+	ceph_crypto_key_destroy(&th->session_key);
+	if (th->ticket_blob)
+		ceph_buffer_put(th->ticket_blob);
+	th->session_key = new_session_key;
+	th->ticket_blob = new_ticket_blob;
+	th->validity = new_validity;
+	th->secret_id = new_secret_id;
+	th->expires = new_expires;
+	th->renew_after = new_renew_after;
+	dout(" got ticket service %d (%s) secret_id %lld len %d\n",
+	     type, ceph_entity_type_name(type), th->secret_id,
+	     (int)th->ticket_blob->vec.iov_len);
+	xi->have_keys |= th->service;
+
+out:
+	return ret;
+
+bad:
+	ret = -EINVAL;
+	goto out;
+}
+
 static int ceph_x_proc_ticket_reply(struct ceph_auth_client *ac,
 				    struct ceph_crypto_key *secret,
 				    void *buf, void *end)
 {
-	struct ceph_x_info *xi = ac->private;
-	int num;
 	void *p = buf;
-	int ret;
 	char *dbuf;
 	char *ticket_buf;
 	u8 reply_struct_v;
+	u32 num;
+	int ret;
 
 	dbuf = kmalloc(TEMP_TICKET_BUF_LEN, GFP_NOFS);
 	if (!dbuf)
@@ -150,112 +264,18 @@ static int ceph_x_proc_ticket_reply(struct ceph_auth_client *ac,
 	if (!ticket_buf)
 		goto out_dbuf;
 
-	ceph_decode_need(&p, end, 1 + sizeof(u32), bad);
-	reply_struct_v = ceph_decode_8(&p);
+	ceph_decode_8_safe(&p, end, reply_struct_v, bad);
 	if (reply_struct_v != 1)
-		goto bad;
-	num = ceph_decode_32(&p);
-	dout("%d tickets\n", num);
-	while (num--) {
-		int type;
-		u8 tkt_struct_v, blob_struct_v;
-		struct ceph_x_ticket_handler *th;
-		void *dp, *dend;
-		int dlen;
-		char is_enc;
-		struct timespec validity;
-		struct ceph_crypto_key old_key;
-		void *tp, *tpend;
-		struct ceph_timespec new_validity;
-		struct ceph_crypto_key new_session_key;
-		struct ceph_buffer *new_ticket_blob;
-		unsigned long new_expires, new_renew_after;
-		u64 new_secret_id;
-
-		ceph_decode_need(&p, end, sizeof(u32) + 1, bad);
-
-		type = ceph_decode_32(&p);
-		dout(" ticket type %d %s\n", type, ceph_entity_type_name(type));
-
-		tkt_struct_v = ceph_decode_8(&p);
-		if (tkt_struct_v != 1)
-			goto bad;
-
-		th = get_ticket_handler(ac, type);
-		if (IS_ERR(th)) {
-			ret = PTR_ERR(th);
-			goto out;
-		}
-
-		/* blob for me */
-		dlen = ceph_x_decrypt(secret, &p, end, dbuf,
-				      TEMP_TICKET_BUF_LEN);
-		if (dlen <= 0) {
-			ret = dlen;
-			goto out;
-		}
-		dout(" decrypted %d bytes\n", dlen);
-		dend = dbuf + dlen;
-		dp = dbuf;
-
-		tkt_struct_v = ceph_decode_8(&dp);
-		if (tkt_struct_v != 1)
-			goto bad;
+		return -EINVAL;
 
-		memcpy(&old_key, &th->session_key, sizeof(old_key));
-		ret = ceph_crypto_key_decode(&new_session_key, &dp, dend);
-		if (ret)
-			goto out;
+	ceph_decode_32_safe(&p, end, num, bad);
+	dout("%d tickets\n", num);
 
-		ceph_decode_copy(&dp, &new_validity, sizeof(new_validity));
-		ceph_decode_timespec(&validity, &new_validity);
-		new_expires = get_seconds() + validity.tv_sec;
-		new_renew_after = new_expires - (validity.tv_sec / 4);
-		dout(" expires=%lu renew_after=%lu\n", new_expires,
-		     new_renew_after);
-
-		/* ticket blob for service */
-		ceph_decode_8_safe(&p, end, is_enc, bad);
-		tp = ticket_buf;
-		if (is_enc) {
-			/* encrypted */
-			dout(" encrypted ticket\n");
-			dlen = ceph_x_decrypt(&old_key, &p, end, ticket_buf,
-					      TEMP_TICKET_BUF_LEN);
-			if (dlen < 0) {
-				ret = dlen;
-				goto out;
-			}
-			dlen = ceph_decode_32(&tp);
-		} else {
-			/* unencrypted */
-			ceph_decode_32_safe(&p, end, dlen, bad);
-			ceph_decode_need(&p, end, dlen, bad);
-			ceph_decode_copy(&p, ticket_buf, dlen);
-		}
-		tpend = tp + dlen;
-		dout(" ticket blob is %d bytes\n", dlen);
-		ceph_decode_need(&tp, tpend, 1 + sizeof(u64), bad);
-		blob_struct_v = ceph_decode_8(&tp);
-		new_secret_id = ceph_decode_64(&tp);
-		ret = ceph_decode_buffer(&new_ticket_blob, &tp, tpend);
+	while (num--) {
+		ret = process_one_ticket(ac, secret, &p, end,
+					 dbuf, ticket_buf);
 		if (ret)
 			goto out;
-
-		/* all is well, update our ticket */
-		ceph_crypto_key_destroy(&th->session_key);
-		if (th->ticket_blob)
-			ceph_buffer_put(th->ticket_blob);
-		th->session_key = new_session_key;
-		th->ticket_blob = new_ticket_blob;
-		th->validity = new_validity;
-		th->secret_id = new_secret_id;
-		th->expires = new_expires;
-		th->renew_after = new_renew_after;
-		dout(" got ticket service %d (%s) secret_id %lld len %d\n",
-		     type, ceph_entity_type_name(type), th->secret_id,
-		     (int)th->ticket_blob->vec.iov_len);
-		xi->have_keys |= th->service;
 	}
 
 	ret = 0;
-- 
1.7.10.4

