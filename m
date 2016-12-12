From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 08/15] libceph: switch ceph_x_decrypt() to ceph_crypt()
Date: Mon, 12 Dec 2016 21:48:53 +0100
Message-ID: <1481575740-1834-9-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34848 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbcLLUuL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so13798443wme.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:10 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.08
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:08 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 78 +++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 46 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index a13ce443073b..b216131915e7 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -69,32 +69,28 @@ static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
 	return sizeof(u32) + ciphertext_len;
 }
 
-static int ceph_x_decrypt(struct ceph_crypto_key *secret,
-			  void **p, void *end, void **obuf, size_t olen)
+static int ceph_x_decrypt(struct ceph_crypto_key *secret, void **p, void *end)
 {
-	struct ceph_x_encrypt_header head;
-	size_t head_len = sizeof(head);
-	int len, ret;
-
-	len = ceph_decode_32(p);
-	if (*p + len > end)
-		return -EINVAL;
+	struct ceph_x_encrypt_header *hdr = *p + sizeof(u32);
+	int ciphertext_len, plaintext_len;
+	int ret;
 
-	dout("ceph_x_decrypt len %d\n", len);
-	if (*obuf == NULL) {
-		*obuf = kmalloc(len, GFP_NOFS);
-		if (!*obuf)
-			return -ENOMEM;
-		olen = len;
-	}
+	ceph_decode_32_safe(p, end, ciphertext_len, e_inval);
+	ceph_decode_need(p, end, ciphertext_len, e_inval);
 
-	ret = ceph_decrypt2(secret, &head, &head_len, *obuf, &olen, *p, len);
+	ret = ceph_crypt(secret, false, *p, end - *p, ciphertext_len,
+			 &plaintext_len);
 	if (ret)
 		return ret;
-	if (head.struct_v != 1 || le64_to_cpu(head.magic) != CEPHX_ENC_MAGIC)
+
+	if (hdr->struct_v != 1 || le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC)
 		return -EPERM;
-	*p += len;
-	return olen;
+
+	*p += ciphertext_len;
+	return plaintext_len - sizeof(struct ceph_x_encrypt_header);
+
+e_inval:
+	return -EINVAL;
 }
 
 /*
@@ -149,12 +145,10 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	int type;
 	u8 tkt_struct_v, blob_struct_v;
 	struct ceph_x_ticket_handler *th;
-	void *dbuf = NULL;
 	void *dp, *dend;
 	int dlen;
 	char is_enc;
 	struct timespec validity;
-	void *ticket_buf = NULL;
 	void *tp, *tpend;
 	void **ptp;
 	struct ceph_crypto_key new_session_key;
@@ -179,14 +173,12 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	}
 
 	/* blob for me */
-	dlen = ceph_x_decrypt(secret, p, end, &dbuf, 0);
-	if (dlen <= 0) {
-		ret = dlen;
+	dp = *p + ceph_x_encrypt_offset();
+	ret = ceph_x_decrypt(secret, p, end);
+	if (ret < 0)
 		goto out;
-	}
-	dout(" decrypted %d bytes\n", dlen);
-	dp = dbuf;
-	dend = dp + dlen;
+	dout(" decrypted %d bytes\n", ret);
+	dend = dp + ret;
 
 	tkt_struct_v = ceph_decode_8(&dp);
 	if (tkt_struct_v != 1)
@@ -207,15 +199,13 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	ceph_decode_8_safe(p, end, is_enc, bad);
 	if (is_enc) {
 		/* encrypted */
-		dout(" encrypted ticket\n");
-		dlen = ceph_x_decrypt(&th->session_key, p, end, &ticket_buf, 0);
-		if (dlen < 0) {
-			ret = dlen;
+		tp = *p + ceph_x_encrypt_offset();
+		ret = ceph_x_decrypt(&th->session_key, p, end);
+		if (ret < 0)
 			goto out;
-		}
-		tp = ticket_buf;
+		dout(" encrypted ticket, decrypted %d bytes\n", ret);
 		ptp = &tp;
-		tpend = *ptp + dlen;
+		tpend = tp + ret;
 	} else {
 		/* unencrypted */
 		ptp = p;
@@ -246,8 +236,6 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	xi->have_keys |= th->service;
 
 out:
-	kfree(ticket_buf);
-	kfree(dbuf);
 	return ret;
 
 bad:
@@ -638,24 +626,22 @@ static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
 					  struct ceph_authorizer *a, size_t len)
 {
 	struct ceph_x_authorizer *au = (void *)a;
-	int ret = 0;
-	struct ceph_x_authorize_reply reply;
-	void *preply = &reply;
 	void *p = au->enc_buf;
+	struct ceph_x_authorize_reply *reply = p + ceph_x_encrypt_offset();
+	int ret;
 
-	ret = ceph_x_decrypt(&au->session_key, &p, p + CEPHX_AU_ENC_BUF_LEN,
-			     &preply, sizeof(reply));
+	ret = ceph_x_decrypt(&au->session_key, &p, p + CEPHX_AU_ENC_BUF_LEN);
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(reply))
+	if (ret != sizeof(*reply))
 		return -EPERM;
 
-	if (au->nonce + 1 != le64_to_cpu(reply.nonce_plus_one))
+	if (au->nonce + 1 != le64_to_cpu(reply->nonce_plus_one))
 		ret = -EPERM;
 	else
 		ret = 0;
 	dout("verify_authorizer_reply nonce %llx got %llx ret %d\n",
-	     au->nonce, le64_to_cpu(reply.nonce_plus_one), ret);
+	     au->nonce, le64_to_cpu(reply->nonce_plus_one), ret);
 	return ret;
 }
 
-- 
2.4.3

