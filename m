From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 07/15] libceph: switch ceph_x_encrypt() to ceph_crypt()
Date: Mon, 12 Dec 2016 21:48:52 +0100
Message-ID: <1481575740-1834-8-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33510 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932485AbcLLUuK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:10 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so13765454wmu.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:09 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.07
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:07 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 71 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 78c1675b0df7..a13ce443073b 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -49,22 +49,24 @@ static int ceph_x_encrypt_buflen(int ilen)
 	return ceph_x_encrypt_offset() + ilen + 16;
 }
 
-static int ceph_x_encrypt(struct ceph_crypto_key *secret,
-			  void *ibuf, int ilen, void *obuf, size_t olen)
+static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
+			  int buf_len, int plaintext_len)
 {
-	struct ceph_x_encrypt_header head = {
-		.struct_v = 1,
-		.magic = cpu_to_le64(CEPHX_ENC_MAGIC)
-	};
-	size_t len = olen - sizeof(u32);
+	struct ceph_x_encrypt_header *hdr = buf + sizeof(u32);
+	int ciphertext_len;
 	int ret;
 
-	ret = ceph_encrypt2(secret, obuf + sizeof(u32), &len,
-			    &head, sizeof(head), ibuf, ilen);
+	hdr->struct_v = 1;
+	hdr->magic = cpu_to_le64(CEPHX_ENC_MAGIC);
+
+	ret = ceph_crypt(secret, true, buf + sizeof(u32), buf_len - sizeof(u32),
+			 plaintext_len + sizeof(struct ceph_x_encrypt_header),
+			 &ciphertext_len);
 	if (ret)
 		return ret;
-	ceph_encode_32(&obuf, len);
-	return len + sizeof(u32);
+
+	ceph_encode_32(&buf, ciphertext_len);
+	return sizeof(u32) + ciphertext_len;
 }
 
 static int ceph_x_decrypt(struct ceph_crypto_key *secret,
@@ -296,7 +298,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 {
 	int maxlen;
 	struct ceph_x_authorize_a *msg_a;
-	struct ceph_x_authorize_b msg_b;
+	struct ceph_x_authorize_b *msg_b;
 	void *p, *end;
 	int ret;
 	int ticket_blob_len =
@@ -311,7 +313,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 		goto out_au;
 
 	maxlen = sizeof(*msg_a) + ticket_blob_len +
-		ceph_x_encrypt_buflen(sizeof(msg_b));
+		ceph_x_encrypt_buflen(sizeof(*msg_b));
 	dout("  need len %d\n", maxlen);
 	if (au->buf && au->buf->alloc_len < maxlen) {
 		ceph_buffer_put(au->buf);
@@ -345,11 +347,11 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	p += ticket_blob_len;
 	end = au->buf->vec.iov_base + au->buf->vec.iov_len;
 
+	msg_b = p + ceph_x_encrypt_offset();
+	msg_b->struct_v = 1;
 	get_random_bytes(&au->nonce, sizeof(au->nonce));
-	msg_b.struct_v = 1;
-	msg_b.nonce = cpu_to_le64(au->nonce);
-	ret = ceph_x_encrypt(&au->session_key, &msg_b, sizeof(msg_b),
-			     p, end - p);
+	msg_b->nonce = cpu_to_le64(au->nonce);
+	ret = ceph_x_encrypt(&au->session_key, p, end - p, sizeof(*msg_b));
 	if (ret < 0)
 		goto out_au;
 
@@ -455,8 +457,9 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 	if (need & CEPH_ENTITY_TYPE_AUTH) {
 		struct ceph_x_authenticate *auth = (void *)(head + 1);
 		void *p = auth + 1;
-		struct ceph_x_challenge_blob tmp;
-		char tmp_enc[40];
+		void *enc_buf = xi->auth_authorizer.enc_buf;
+		struct ceph_x_challenge_blob *blob = enc_buf +
+							ceph_x_encrypt_offset();
 		u64 *u;
 
 		if (p > end)
@@ -467,16 +470,16 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 
 		/* encrypt and hash */
 		get_random_bytes(&auth->client_challenge, sizeof(u64));
-		tmp.client_challenge = auth->client_challenge;
-		tmp.server_challenge = cpu_to_le64(xi->server_challenge);
-		ret = ceph_x_encrypt(&xi->secret, &tmp, sizeof(tmp),
-				     tmp_enc, sizeof(tmp_enc));
+		blob->client_challenge = auth->client_challenge;
+		blob->server_challenge = cpu_to_le64(xi->server_challenge);
+		ret = ceph_x_encrypt(&xi->secret, enc_buf, CEPHX_AU_ENC_BUF_LEN,
+				     sizeof(*blob));
 		if (ret < 0)
 			return ret;
 
 		auth->struct_v = 1;
 		auth->key = 0;
-		for (u = (u64 *)tmp_enc; u + 1 <= (u64 *)(tmp_enc + ret); u++)
+		for (u = (u64 *)enc_buf; u + 1 <= (u64 *)(enc_buf + ret); u++)
 			auth->key ^= *(__le64 *)u;
 		dout(" server_challenge %llx client_challenge %llx key %llx\n",
 		     xi->server_challenge, le64_to_cpu(auth->client_challenge),
@@ -710,27 +713,27 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
 static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
 			  __le64 *psig)
 {
-	char tmp_enc[40];
+	void *enc_buf = au->enc_buf;
 	struct {
 		__le32 len;
 		__le32 header_crc;
 		__le32 front_crc;
 		__le32 middle_crc;
 		__le32 data_crc;
-	} __packed sigblock;
+	} __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
 	int ret;
 
-	sigblock.len = cpu_to_le32(4*sizeof(u32));
-	sigblock.header_crc = msg->hdr.crc;
-	sigblock.front_crc = msg->footer.front_crc;
-	sigblock.middle_crc = msg->footer.middle_crc;
-	sigblock.data_crc =  msg->footer.data_crc;
-	ret = ceph_x_encrypt(&au->session_key, &sigblock, sizeof(sigblock),
-			     tmp_enc, sizeof(tmp_enc));
+	sigblock->len = cpu_to_le32(4*sizeof(u32));
+	sigblock->header_crc = msg->hdr.crc;
+	sigblock->front_crc = msg->footer.front_crc;
+	sigblock->middle_crc = msg->footer.middle_crc;
+	sigblock->data_crc =  msg->footer.data_crc;
+	ret = ceph_x_encrypt(&au->session_key, enc_buf, CEPHX_AU_ENC_BUF_LEN,
+			     sizeof(*sigblock));
 	if (ret < 0)
 		return ret;
 
-	*psig = *(__le64 *)(tmp_enc + sizeof(u32));
+	*psig = *(__le64 *)(enc_buf + sizeof(u32));
 	return 0;
 }
 
-- 
2.4.3

