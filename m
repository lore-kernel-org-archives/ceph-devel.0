Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5BF247DE1
	for <ceph-devel@vger.kernel.org>; Sat,  2 May 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777728315; cv=none; b=on5u/vuwYB775ZIl3CCnBZOPPc+xIX7riIfytib1waDqnSON00SDq9TOiwi3YAzm3VHIasbTdGzzu5X93yyezyjG9r7TbMKa2XZtzTD7z8VRR4N7YnUW5biNtCmyhW0iNrosERQHGu7b4A8684sHh5nvTbv8ywNCnS946+04/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777728315; c=relaxed/simple;
	bh=kH62rsUaAss0NtHCfCwEnwUM3x0gdN/omUvzry1yAtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2ssSrdFsClB2tAyRBGBDLqS33ZLjAySNZnKLSo/PAmvyUOEiFhzXZpENjlPhArcGLAfi4iiDlInjZpqZJG4Y8n5QPfMAJHzp0jHnr2RrQ/fzMCtIkC50FWMQKCpVOOn3DRp/Cl7f97lon7blrEszKizwAjaT4UuBU/RrmOEQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhQiepSO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhQiepSO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ef45a6d9dfso305726485a.0
        for <ceph-devel@vger.kernel.org>; Sat, 02 May 2026 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777728312; x=1778333112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TiHfmUTUQA6/Fcz5xp0cK2FWPU1oMzmHzKsF4Cf9JWQ=;
        b=hhQiepSOK7cavYOEwZGlaprRwvuSVv+vsxVSCypNpJ7qU7v4mf9GwDNomw6X5VW66D
         bZl6z0rXS1iysG89+4xFsXyuNM9radoeHaCX90827IpS8HibtGdVCCeZ6Pb0RTUT+Ppx
         Wa/XNgSGpNSnp0dFr2sInL+um9w9AqPixZodiWnKxA18k8S5bH2ABs8d4FUlSdKS7GO8
         /h/unIQVp2uz1mas1vRwN/QPuHiEYYYZNcOR76zmMgljxwrP0DdwIKORHE3JlJLVGaKV
         nAm1zJ9uNtTg0zvtjwk1Q8tfaI8z2uVYMb1bYgLcZsnWlFcM1sZxfyqG7yN4TIRSnKlG
         +Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777728312; x=1778333112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiHfmUTUQA6/Fcz5xp0cK2FWPU1oMzmHzKsF4Cf9JWQ=;
        b=GfvCxbGk5f9ZiYwDNVPCRvV4nDvkUe8HzwUNJKpiIlDvHdjvhedQGQgeo4f/Tft7oc
         x5HX5ue9pXRu4/PoAdFqFOIQ1weuvKL/mRnhMj7oaSnFrFEZCDx9j3zCgAP4Z+TgOdfA
         Ua83VaImnSpSUVIIskNlVa15Groy3/Y7Tx/qG8OnzTIE4a/4QylXrWGVudCn8LCIV+gZ
         lVM/SV5O7TLyAsUalrBt7t7vGM7GXwUncrcoWSW4fALXU0yvcrAMkHy+9IIAB4D4bisq
         +gMqu4eW0w7M5y54kZhn+ZlX22+ULj+9P59q29dnEn+IKNE7/PFE5hEefSJ6Y8Y2u23U
         gYlg==
X-Forwarded-Encrypted: i=1; AFNElJ88jUwfo5SP2TzRakDMyTCE3Svb5dML04mHWF1kdg/IdJdVQzYtbI5NC9jY9zwdJwtAej0izHfRpGQ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLwGDW9ZsMPs2icLplxDc9CGJdm/iRD1LdpeOJu5FXQvSpgdF
	xNtB9+K3U0AiBOi1roYz6O1MJLLYmy7EZR3g3eBDSllK3sH1L9EDhk2d
X-Gm-Gg: AeBDiet/j25oFUyl2vMo7nZgt+WCBTz4nvNRtYQ977Fb2dLLILscgLGavoFId9vBDQv
	PTTuf67s++HMPXOvnoBX46hIc0pO0Urg+d0W+qFHnZkQF3EVviIEoPkf8zstNCRwaLTHlFu49nP
	TQc4oPsG8I9K/Jq0FUXybwY/SISKWnBaqox4NHJDiSro2u+T+xvxTbrH43tugZpyH83NK3OQBdL
	HPj7QKM+qLv7GjaQ9JHg0iuDrZODQtb5E+rxL3S5Xcs1Z0poEJOb2cZO9mqw30geeskEdMgWhs0
	1+q1wjoFcHplUbYK/3wVAGHse0sbaEGoqzWZ8sQ/Y9x5IImB/snj0/PaHTUMmq9rTLFSMvf4ClP
	7YwnD4ZL050mYyPNVQ4uAfDzeeuxTzkQwJkclhsXWPNCRdbhhbPYrgStf92sw9ttHCCTYWXYGVJ
	JnnK8csyvCqWmVzZql7m1LPjdpM0q+7AK0Loq7NpwSr+vFiwrXtA7BRFwGx7a+1XSLGc9+iKRi0
	7h505TrN2b+10GyB/s5ldcux+dwKyY=
X-Received: by 2002:a05:620a:4015:b0:8cf:d6f8:599f with SMTP id af79cd13be357-8fd1863dbfcmr491717085a.57.1777728312166;
        Sat, 02 May 2026 06:25:12 -0700 (PDT)
Received: from server1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91dd48sm491819285a.38.2026.05.02.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:25:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: krb5 - wait for async aead completion before freeing buffer
Date: Sat,  2 May 2026 09:25:06 -0400
Message-ID: <20260502132506.1936358-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

krb5_aead_encrypt(), krb5_aead_decrypt() in rfc3961_simplified.c and
rfc8009_encrypt(), rfc8009_decrypt() in rfc8009_aes2.c set a NULL
completion callback on the aead_request and treat any negative return
from crypto_aead_{encrypt,decrypt}() as terminal, falling through to
kfree_sensitive(buffer) where buffer == req.

The crypto API returns -EINPROGRESS when an asynchronous backend has
accepted the request and queued it for completion by a worker, and
-EBUSY when a backlog-capable backend has accepted it onto its
backlog (with CRYPTO_TFM_REQ_MAY_BACKLOG set).  In both cases the
operation will complete asynchronously and the request buffer must
remain live until the backend's completion callback fires.  Without
that flag set, -EBUSY instead means "rejected, try again later" and
no completion will fire.  In the current code the callback is NULL
and any negative return is treated as terminal, so when the
encrypt_name composition resolves to an async instance (a hardware
AEAD provider that registers an instance for the krb5 inner template,
or any future code path that takes a cryptd-wrapped instance for the
krb5 enctype name), -EINPROGRESS satisfies the "if (ret < 0)" check
and the buffer is freed while the backend's worker still holds a
pointer.  The worker subsequently dereferences req via
aead_request_complete(), reading from freed slab.

KASAN report under UML+SLUB with a faithful reproducer that drives
crypto_krb5_decrypt() through the existing API, with an async aead
backend bound to krb5->encrypt_name:

  BUG: KASAN: slab-use-after-free in t5_stub_complete+0x7d/0xc7
  Read of size 8 at addr 00000000619e9410 by task kworker/0:1/12

  Allocated by task 40:
   __kmalloc_noprof+0x1df/0x1ee
   kzalloc_noprof.constprop.0+0x19/0x1b [krb5]
   rfc8009_decrypt+0x294/0x7c4 [krb5]
   crypto_krb5_decrypt+0x93/0xa2 [krb5]

  Freed by task 40:
   kfree_sensitive+0x57/0x5c
   rfc8009_decrypt+0x790/0x7c4 [krb5]
   crypto_krb5_decrypt+0x93/0xa2 [krb5]

  The buggy address belongs to the cache kmalloc-128 of size 128

These helpers are reached today from net/rxrpc/rxgk.c and
rxgk_common.h (AFS/RxRPC RxGK packet encrypt/decrypt),
fs/afs/cm_security.c, and net/ceph/crypto.c (Linux kernel Ceph
client cephx encrypt/decrypt).  The bug is triggerable when one of
these paths uses a krb5 AEAD whose selected implementation is async
(or inherits async completion from an async child/provider).

Fix by following the standard kernel idiom for synchronous waiting on
a potentially-asynchronous AEAD: install crypto_req_done() as the
completion callback, set CRYPTO_TFM_REQ_MAY_BACKLOG so a backlogged
backend's -EBUSY indicates a queued (not rejected) request, and wrap
the crypto_aead_{encrypt,decrypt}() return through crypto_wait_req()
so the function blocks on the worker's completion before falling
through to kfree_sensitive().  This matches the crypto_wait_req()
usage pattern in net/tls/, fs/ecryptfs/, fs/smb/server/auth.c, and
other consumers that need a synchronous result over an arbitrarily-
async backend; MAY_BACKLOG is required (not optional) so that
crypto_wait_req() does not block waiting for a completion that will
never fire from a rejected request.

Regression coverage: the in-tree krb5 selftests
(CONFIG_CRYPTO_KRB5_SELFTESTS=y) cover all four touched functions for
all six supported enctypes (aes128/aes256-cts-hmac-sha1-96,
aes128/aes256-cts-hmac-sha256/384, camellia128/256-cts-cmac) via the
PRF, key-derivation, encrypt, decrypt and MIC paths; the patched
kernel reports "krb5: Selftests succeeded" when those default sync
backends are in use.  Additionally, on a separate boot of the
patched kernel with CONFIG_CRYPTO_SELFTESTS_FULL=y and without the
synthetic async-aead provider used to drive the reproducer loaded,
the kernel's testmgr emits no "alg: ... self-test failed" lines for
the authenc(hmac(sha256/sha384),cts(cbc(aes))) instances the krb5
layer instantiates.  (The reproducer boot does carry an expected
testmgr failure for that synthetic provider's algorithm name; that
is not a regression of any in-tree algorithm.)  The faithful
reproducer above no longer trips KASAN when an async backend is
bound.

Fixes: 00244da40f78 ("crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt functions")
Fixes: 6c3c0e86c2ac ("crypto/krb5: Implement the AES enctypes from rfc8009")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 crypto/krb5/rfc3961_simplified.c | 12 ++++++++----
 crypto/krb5/rfc8009_aes2.c       | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/crypto/krb5/rfc3961_simplified.c b/crypto/krb5/rfc3961_simplified.c
index e49cbdec7c40..c4b8e9b89c7b 100644
--- a/crypto/krb5/rfc3961_simplified.c
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -543,6 +543,7 @@ ssize_t krb5_aead_encrypt(const struct krb5_enctype *krb5,
 			  size_t data_offset, size_t data_len,
 			  bool preconfounded)
 {
+	DECLARE_CRYPTO_WAIT(wait);
 	struct aead_request *req;
 	ssize_t ret, done;
 	size_t bsize, base_len, secure_offset, secure_len, pad_len, cksum_offset;
@@ -588,9 +589,10 @@ ssize_t krb5_aead_encrypt(const struct krb5_enctype *krb5,
 	iv = buffer + krb5_aead_size(aead);
 
 	aead_request_set_tfm(req, aead);
-	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  crypto_req_done, &wait);
 	aead_request_set_crypt(req, sg, sg, secure_len, iv);
-	ret = crypto_aead_encrypt(req);
+	ret = crypto_wait_req(crypto_aead_encrypt(req), &wait);
 	if (ret < 0)
 		goto error;
 
@@ -610,6 +612,7 @@ int krb5_aead_decrypt(const struct krb5_enctype *krb5,
 		      struct scatterlist *sg, unsigned int nr_sg,
 		      size_t *_offset, size_t *_len)
 {
+	DECLARE_CRYPTO_WAIT(wait);
 	struct aead_request *req;
 	size_t bsize;
 	void *buffer;
@@ -633,9 +636,10 @@ int krb5_aead_decrypt(const struct krb5_enctype *krb5,
 	iv = buffer + krb5_aead_size(aead);
 
 	aead_request_set_tfm(req, aead);
-	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  crypto_req_done, &wait);
 	aead_request_set_crypt(req, sg, sg, *_len, iv);
-	ret = crypto_aead_decrypt(req);
+	ret = crypto_wait_req(crypto_aead_decrypt(req), &wait);
 	if (ret < 0)
 		goto error;
 
diff --git a/crypto/krb5/rfc8009_aes2.c b/crypto/krb5/rfc8009_aes2.c
index d39851fc3a4e..dda29f0bb700 100644
--- a/crypto/krb5/rfc8009_aes2.c
+++ b/crypto/krb5/rfc8009_aes2.c
@@ -175,6 +175,7 @@ static ssize_t rfc8009_encrypt(const struct krb5_enctype *krb5,
 			       size_t data_offset, size_t data_len,
 			       bool preconfounded)
 {
+	DECLARE_CRYPTO_WAIT(wait);
 	struct aead_request *req;
 	struct scatterlist bsg[2];
 	ssize_t ret, done;
@@ -227,10 +228,11 @@ static ssize_t rfc8009_encrypt(const struct krb5_enctype *krb5,
 
 	/* Hash and encrypt the message. */
 	aead_request_set_tfm(req, aead);
-	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  crypto_req_done, &wait);
 	aead_request_set_ad(req, krb5_aead_ivsize(aead));
 	aead_request_set_crypt(req, bsg, bsg, secure_len, iv);
-	ret = crypto_aead_encrypt(req);
+	ret = crypto_wait_req(crypto_aead_encrypt(req), &wait);
 	if (ret < 0)
 		goto error;
 
@@ -253,6 +255,7 @@ static int rfc8009_decrypt(const struct krb5_enctype *krb5,
 			   struct scatterlist *sg, unsigned int nr_sg,
 			   size_t *_offset, size_t *_len)
 {
+	DECLARE_CRYPTO_WAIT(wait);
 	struct aead_request *req;
 	struct scatterlist bsg[2];
 	size_t bsize;
@@ -283,10 +286,11 @@ static int rfc8009_decrypt(const struct krb5_enctype *krb5,
 
 	/* Decrypt the message and verify its checksum. */
 	aead_request_set_tfm(req, aead);
-	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  crypto_req_done, &wait);
 	aead_request_set_ad(req, krb5_aead_ivsize(aead));
 	aead_request_set_crypt(req, bsg, bsg, *_len, iv);
-	ret = crypto_aead_decrypt(req);
+	ret = crypto_wait_req(crypto_aead_decrypt(req), &wait);
 	if (ret < 0)
 		goto error;
 
-- 
2.53.0

