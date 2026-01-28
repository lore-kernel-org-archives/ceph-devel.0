Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF42F7AAC
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596432; cv=none; b=m0hPFhxQiWPj5k4y9170o0zrL+6/PAd3ZSxXHVrMONKPfRX58XUvpPyqr9JyC6wLKYYpOztUxcX46n+NZriZnwr3eCMHFFRw1xHl+OdfTZ1fQyF4sz4okTGbTZcpbXNpaFvOiKxjP4TEmEhfdDDRZGfwbzXe4UfdCtvS3FbyEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596432; c=relaxed/simple;
	bh=g6IWWygJgnvMzh5FDiPUaZKXzHAVdMWkdK/OOt1fIC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXvlLn6/mcPCRgxcqeO81nrKpGNvc+HD4TpVh68Fa5WI9WOjs3zTHrEMuosDdywgj/gKASnvSkXE9OXhSbNN1GPQ9aUUXoKY78okj/fmHNLhmKCiLIIzGi+JUvDE6mgoLbnwsinBmXcZDpWd/AbAEEQgrqRXaQo/P/ETcqnhVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBDCzd7i; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBDCzd7i"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5032e951106so16193181cf.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 02:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769596430; x=1770201230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cImMB0WndtBqi33Dg1bL0lrLmPlMdNoMp9/sKjnxXHE=;
        b=nBDCzd7ipgLK7Sye59tzWIpOeLVlSpcG+UxLBZ6LLM4jMWfZxkBwW6Ia5TbkfQcjUw
         dN+QiXB/Hw/QV8iHF2nJm3/GmaewevvmwzKuYlE2XyQ7kawrB7v2kHVUOsVYkRze4+en
         PckD0amNSFFrSUL3a/+liXP09aoYYyuMVhedqKujju74d0hI9Usjz2hC/n4E4aFmN19p
         I/vubiHe22ISGcIQ628En1aN6MfAcrfYi4tATrLy0gObQDDfiP7Y3ghEWovUr1wu83rx
         ctpZRU3Petme8u54VWwo+7G7h2ptUCt+h7qJHYJgko1wsVOvocVaCcXenHlUFnUQ2ZGq
         oMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596430; x=1770201230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cImMB0WndtBqi33Dg1bL0lrLmPlMdNoMp9/sKjnxXHE=;
        b=QsDGgE/H64ESeVDrRULYIJSvzqL7DPesT37pFUZLoSwNRp72h+rccm3HHFzykdODVB
         TuLLuGWdUDXSzvijHOsXFOfdP3ywYH+WAnK73zxKouYtVg5HH6p+sBthNtlWaRD7b5Bf
         MygMIG+5Mw6Vmn2Tl/bYHm9ygOhvX8aUkxkchb9F39pLw5oFMCfRdYafMvTfdE0Z1Xii
         XiDFxYTjGoIFrylzB1tkVgDZiUFUrrdxnRenmqsvL3h/ZN4MQvSkTurGvCcIRhOuw1Ng
         nA7GmfdIdXeTzwtH7VS94jq8WGvpYVUNXpWQBfDCztjq+Pbv6G7nFE0p0XY45ni5pSSi
         Uy5w==
X-Gm-Message-State: AOJu0YyL2aNNpiA3HgKe45EGeCJWKNrkJ3LFjGyh8XV877Yx2IUjD6dh
	zK/hCFEUuHnpSje16hrLYQ7Bvosw1ctaeNwdrcafgpTiinJ1vLJu7GLv79mVheuH
X-Gm-Gg: AZuq6aI6VXNpyosDNNJI/XpbkH0LaN+mBg/htzggyCWw0zjjngnoklVOKcV6Fh50+CR
	2LVUqNo/fPBbcitg/NG+ZwZ52XM9RuqKDnOEuXwMdL4Jvni55/crhphZiLov3qDuwxmaTd45enf
	bcE9ekDPRbkMe+7trYPLIG8Q8dfyY93t8ZyTtB7KA4DYnABbl5PWPhNWaIM+LzVs/95rie8Lug0
	HmOHapYnEEz1l8z1VjG+PdlTqPLS9bZ6KEJ+lWx+oCvz9ANOoaTX7uLwZyQ07Lg+ZdNuo9GJTtk
	sJ/HUkSXe+ChDr/GuZ9rB+cXr2ofhPghpXDtNNpp6eMsk19UFTtsWd88q+bPWr13hOjOmJ8Tzrw
	xsjObQso1B5jD9ZuX/NoZ7ht1lk5/3Tw7qB51hmXi4ABcrHp1Csjg7xAVguUkM+VzZ4bUv/uXfz
	8IOtFFSnivN1hOlrGOssVQ0M8wFUzslACixgCw4J1IDvA6bzjP5xT4aQ==
X-Received: by 2002:a05:622a:19a3:b0:501:5260:51d6 with SMTP id d75a77b69052e-5032f77059emr54285961cf.10.1769596429986;
        Wed, 28 Jan 2026 02:33:49 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbb66dsm12383451cf.29.2026.01.28.02.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:33:49 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: [PATCH 2/5] libceph: generalize ceph_x_encrypt_offset() and ceph_x_encrypt_buflen()
Date: Wed, 28 Jan 2026 11:33:24 +0100
Message-ID: <20260128103329.964466-3-idryomov@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128103329.964466-1-idryomov@gmail.com>
References: <20260128103329.964466-1-idryomov@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- introduce the notion of a data offset for ceph_x_encrypt_offset()
  to allow for e.g. confounder to be prepended before the encryption
  header in the future.  For CEPH_CRYPTO_AES, the data offset is 0
  (i.e. nothing is prepended).

- adjust ceph_x_encrypt_buflen() accordingly and make it account for
  PKCS#7 padding that is used by CEPH_CRYPTO_AES precisely instead of
  just always adding 16.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 44 +++++++++++++++++++++++++++++---------------
 net/ceph/crypto.c | 25 +++++++++++++++++++++++++
 net/ceph/crypto.h |  2 ++
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index a21c157daf7d..5d7245884f95 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -44,23 +44,35 @@ static int ceph_x_should_authenticate(struct ceph_auth_client *ac)
 	return !!need;
 }
 
-static int ceph_x_encrypt_offset(void)
+static int __ceph_x_encrypt_offset(const struct ceph_crypto_key *key)
 {
-	return sizeof(u32) + sizeof(struct ceph_x_encrypt_header);
+	return ceph_crypt_data_offset(key) +
+	       sizeof(struct ceph_x_encrypt_header);
 }
 
-static int ceph_x_encrypt_buflen(int ilen)
+static int ceph_x_encrypt_offset(const struct ceph_crypto_key *key)
 {
-	return ceph_x_encrypt_offset() + ilen + 16;
+	return sizeof(u32) + __ceph_x_encrypt_offset(key);
+}
+
+/*
+ * AES: ciphertext_len | hdr | data... | padding
+ */
+static int ceph_x_encrypt_buflen(const struct ceph_crypto_key *key,
+				 int data_len)
+{
+	int encrypt_len = sizeof(struct ceph_x_encrypt_header) + data_len;
+	return sizeof(u32) + ceph_crypt_buflen(key, encrypt_len);
 }
 
 static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
 			  int buf_len, int plaintext_len)
 {
-	struct ceph_x_encrypt_header *hdr = buf + sizeof(u32);
+	struct ceph_x_encrypt_header *hdr;
 	int ciphertext_len;
 	int ret;
 
+	hdr = buf + sizeof(u32) + ceph_crypt_data_offset(secret);
 	hdr->struct_v = 1;
 	hdr->magic = cpu_to_le64(CEPHX_ENC_MAGIC);
 
@@ -77,7 +89,7 @@ static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
 static int __ceph_x_decrypt(struct ceph_crypto_key *secret, void *p,
 			    int ciphertext_len)
 {
-	struct ceph_x_encrypt_header *hdr = p;
+	struct ceph_x_encrypt_header *hdr;
 	int plaintext_len;
 	int ret;
 
@@ -86,6 +98,7 @@ static int __ceph_x_decrypt(struct ceph_crypto_key *secret, void *p,
 	if (ret)
 		return ret;
 
+	hdr = p + ceph_crypt_data_offset(secret);
 	if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
 		pr_err("%s bad magic\n", __func__);
 		return -EINVAL;
@@ -193,7 +206,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	}
 
 	/* blob for me */
-	dp = *p + ceph_x_encrypt_offset();
+	dp = *p + ceph_x_encrypt_offset(secret);
 	ret = ceph_x_decrypt(secret, p, end);
 	if (ret < 0)
 		goto out;
@@ -220,7 +233,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	ceph_decode_8_safe(p, end, is_enc, bad);
 	if (is_enc) {
 		/* encrypted */
-		tp = *p + ceph_x_encrypt_offset();
+		tp = *p + ceph_x_encrypt_offset(&th->session_key);
 		ret = ceph_x_decrypt(&th->session_key, p, end);
 		if (ret < 0)
 			goto out;
@@ -312,7 +325,7 @@ static int encrypt_authorizer(struct ceph_x_authorizer *au,
 	p = (void *)(msg_a + 1) + le32_to_cpu(msg_a->ticket_blob.blob_len);
 	end = au->buf->vec.iov_base + au->buf->vec.iov_len;
 
-	msg_b = p + ceph_x_encrypt_offset();
+	msg_b = p + ceph_x_encrypt_offset(&au->session_key);
 	msg_b->struct_v = 2;
 	msg_b->nonce = cpu_to_le64(au->nonce);
 	if (server_challenge) {
@@ -368,7 +381,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 		goto out_au;
 
 	maxlen = sizeof(*msg_a) + ticket_blob_len +
-		ceph_x_encrypt_buflen(sizeof(*msg_b));
+		ceph_x_encrypt_buflen(&au->session_key, sizeof(*msg_b));
 	dout("  need len %d\n", maxlen);
 	if (au->buf && au->buf->alloc_len < maxlen) {
 		ceph_buffer_put(au->buf);
@@ -507,7 +520,7 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 		struct ceph_x_authenticate *auth = (void *)(head + 1);
 		void *enc_buf = xi->auth_authorizer.enc_buf;
 		struct ceph_x_challenge_blob *blob = enc_buf +
-							ceph_x_encrypt_offset();
+					     ceph_x_encrypt_offset(&xi->secret);
 		u64 *u;
 
 		p = auth + 1;
@@ -634,7 +647,7 @@ static int handle_auth_session_key(struct ceph_auth_client *ac, u64 global_id,
 	ceph_decode_need(p, end, len, e_inval);
 	dout("%s connection secret blob len %d\n", __func__, len);
 	if (len > 0) {
-		dp = *p + ceph_x_encrypt_offset();
+		dp = *p + ceph_x_encrypt_offset(&th->session_key);
 		ret = ceph_x_decrypt(&th->session_key, p, *p + len);
 		if (ret < 0)
 			return ret;
@@ -804,7 +817,7 @@ static int decrypt_authorizer_challenge(struct ceph_crypto_key *secret,
 		return ret;
 
 	dout("%s decrypted %d bytes\n", __func__, ret);
-	dp = challenge + sizeof(struct ceph_x_encrypt_header);
+	dp = challenge + __ceph_x_encrypt_offset(secret);
 	dend = dp + ret;
 
 	ceph_decode_skip_8(&dp, dend, e_inval);  /* struct_v */
@@ -851,7 +864,7 @@ static int decrypt_authorizer_reply(struct ceph_crypto_key *secret,
 	u8 struct_v;
 	int ret;
 
-	dp = *p + ceph_x_encrypt_offset();
+	dp = *p + ceph_x_encrypt_offset(secret);
 	ret = ceph_x_decrypt(secret, p, end);
 	if (ret < 0)
 		return ret;
@@ -974,7 +987,8 @@ static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
 			__le32 front_crc;
 			__le32 middle_crc;
 			__le32 data_crc;
-		} __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
+		} __packed *sigblock = enc_buf +
+				       ceph_x_encrypt_offset(&au->session_key);
 
 		sigblock->len = cpu_to_le32(4*sizeof(u32));
 		sigblock->header_crc = msg->hdr.crc;
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 5601732cf4fa..2b98daffe9af 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -285,6 +285,31 @@ int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
 	}
 }
 
+int ceph_crypt_data_offset(const struct ceph_crypto_key *key)
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+	case CEPH_CRYPTO_AES:
+		return 0;
+	default:
+		BUG();
+	}
+}
+
+int ceph_crypt_buflen(const struct ceph_crypto_key *key, int data_len)
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+		return data_len;
+	case CEPH_CRYPTO_AES:
+		/* PKCS#7 padding at the end */
+		return data_len + AES_BLOCK_SIZE -
+		       (data_len & (AES_BLOCK_SIZE - 1));
+	default:
+		BUG();
+	}
+}
+
 static int ceph_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct ceph_crypto_key *ckey;
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index a20bad6d1e96..736ec6d2fbcb 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -28,6 +28,8 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key);
 /* crypto.c */
 int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
 	       void *buf, int buf_len, int in_len, int *pout_len);
+int ceph_crypt_data_offset(const struct ceph_crypto_key *key);
+int ceph_crypt_buflen(const struct ceph_crypto_key *key, int data_len);
 int ceph_crypto_init(void);
 void ceph_crypto_shutdown(void);
 
-- 
2.49.0

