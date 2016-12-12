From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 04/15] libceph: introduce ceph_crypt() for in-place en/decryption
Date: Mon, 12 Dec 2016 21:48:49 +0100
Message-ID: <1481575740-1834-5-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34567 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbcLLUuH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so13807124wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:07 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.05
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:05 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Starting with 4.9, kernel stacks may be vmalloced and therefore not
guaranteed to be physically contiguous; the new CONFIG_VMAP_STACK
option is enabled by default on x86.  This makes it invalid to use
on-stack buffers with the crypto scatterlist API, as sg_set_buf()
expects a logical address and won't work with vmalloced addresses.

There isn't a different (e.g. kvec-based) crypto API we could switch
net/ceph/crypto.c to and the current scatterlist.h API isn't getting
updated to accommodate this use case.  Allocating a new header and
padding for each operation is a non-starter, so do the en/decryption
in-place on a single pre-assembled (header + data + padding) heap
buffer.  This is explicitly supported by the crypto API:

    "... the caller may provide the same scatter/gather list for the
     plaintext and cipher text. After the completion of the cipher
     operation, the plaintext data is replaced with the ciphertext data
     in case of an encryption and vice versa for a decryption."

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/crypto.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/ceph/crypto.h |  2 ++
 2 files changed, 89 insertions(+)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index db2847ac5f12..32099c5c4c75 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -526,6 +526,93 @@ int ceph_encrypt2(struct ceph_crypto_key *secret, void *dst, size_t *dst_len,
 	}
 }
 
+static int ceph_aes_crypt(const struct ceph_crypto_key *key, bool encrypt,
+			  void *buf, int buf_len, int in_len, int *pout_len)
+{
+	struct crypto_skcipher *tfm = ceph_crypto_alloc_cipher();
+	SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct sg_table sgt;
+	struct scatterlist prealloc_sg;
+	char iv[AES_BLOCK_SIZE];
+	int pad_byte = AES_BLOCK_SIZE - (in_len & (AES_BLOCK_SIZE - 1));
+	int crypt_len = encrypt ? in_len + pad_byte : in_len;
+	int ret;
+
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	WARN_ON(crypt_len > buf_len);
+	if (encrypt)
+		memset(buf + in_len, pad_byte, pad_byte);
+	ret = setup_sgtable(&sgt, &prealloc_sg, buf, crypt_len);
+	if (ret)
+		goto out_tfm;
+
+	crypto_skcipher_setkey((void *)tfm, key->key, key->len);
+	memcpy(iv, aes_iv, AES_BLOCK_SIZE);
+
+	skcipher_request_set_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, sgt.sgl, sgt.sgl, crypt_len, iv);
+
+	/*
+	print_hex_dump(KERN_ERR, "key: ", DUMP_PREFIX_NONE, 16, 1,
+		       key->key, key->len, 1);
+	print_hex_dump(KERN_ERR, " in: ", DUMP_PREFIX_NONE, 16, 1,
+		       buf, crypt_len, 1);
+	*/
+	if (encrypt)
+		ret = crypto_skcipher_encrypt(req);
+	else
+		ret = crypto_skcipher_decrypt(req);
+	skcipher_request_zero(req);
+	if (ret) {
+		pr_err("%s %scrypt failed: %d\n", __func__,
+		       encrypt ? "en" : "de", ret);
+		goto out_sgt;
+	}
+	/*
+	print_hex_dump(KERN_ERR, "out: ", DUMP_PREFIX_NONE, 16, 1,
+		       buf, crypt_len, 1);
+	*/
+
+	if (encrypt) {
+		*pout_len = crypt_len;
+	} else {
+		pad_byte = *(char *)(buf + in_len - 1);
+		if (pad_byte > 0 && pad_byte <= AES_BLOCK_SIZE &&
+		    in_len >= pad_byte) {
+			*pout_len = in_len - pad_byte;
+		} else {
+			pr_err("%s got bad padding %d on in_len %d\n",
+			       __func__, pad_byte, in_len);
+			ret = -EPERM;
+			goto out_sgt;
+		}
+	}
+
+out_sgt:
+	teardown_sgtable(&sgt);
+out_tfm:
+	crypto_free_skcipher(tfm);
+	return ret;
+}
+
+int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
+	       void *buf, int buf_len, int in_len, int *pout_len)
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+		*pout_len = in_len;
+		return 0;
+	case CEPH_CRYPTO_AES:
+		return ceph_aes_crypt(key, encrypt, buf, buf_len, in_len,
+				      pout_len);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
 static int ceph_key_preparse(struct key_preparsed_payload *prep)
 {
 	struct ceph_crypto_key *ckey;
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index 2e9cab09f37b..73da34e8c62e 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -43,6 +43,8 @@ int ceph_encrypt2(struct ceph_crypto_key *secret,
 		  void *dst, size_t *dst_len,
 		  const void *src1, size_t src1_len,
 		  const void *src2, size_t src2_len);
+int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
+	       void *buf, int buf_len, int in_len, int *pout_len);
 int ceph_crypto_init(void);
 void ceph_crypto_shutdown(void);
 
-- 
2.4.3

