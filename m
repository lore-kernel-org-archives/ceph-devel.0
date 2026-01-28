Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB8313535
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596434; cv=none; b=tpA8L3vajqxfb/4R/xRYmVFYWhmxa/be+dAl6IoD7xhAzZnPoKWJ2W82ArG99Oochc+zJNM34DyxZrBxLSzQr7XlZRmCwZy9PaR6Z1NUVJz4XQw87AeRXZ9uOFYlsCcoBPHs02IMlfJw5qQ+IVshOqTjsz04WHEESz9Ip7bTAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596434; c=relaxed/simple;
	bh=2HfmF3Ovy9N8fXzDm/pmcbRtYcMe3e6JkwGhFEGlibw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pa6+sBfXAvwkSwRd5gB1rCqi/85JRzPujfKCwp/nIpXye0wyuleaag4j/qqNof8oq6iHQOrcAF1x9twdmXkGSqVj9DVCPmhC9Z8wE+ZTWK1/mEMGVd+vhYqRKzPwCvQBRSiM4CiUCW6bG2VIUBtGf+iHj1kWTb9ZJxKt5/cljss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrxOnDh1; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrxOnDh1"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-5014f383df6so56548181cf.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769596431; x=1770201231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1HgsTXbdyKjSqzNOssrGMSH6n/agYWunVSDNYW2aGU=;
        b=FrxOnDh1SVMQNrMXLGtOkQOZhzXvmctIxLxqcePMZ99YxSAGj/O8IXG/il/3rpRpNQ
         t6La0PECsVJKDqHn3h2UlrQ87vaduq0T8lpyfZTnXPMIcmR9SKa7s3paFI+mzScViAcO
         RiNV5YUn4piri5vOpvIho/W9yalktdnK0uG8pihH5udnrPV7PAp7+tjkKxGKHUEcDwrM
         HHuK1vdWwlfjp5w4hXlXwK0v9RwiFlk7LmG1l2POfkYbFbtqaEtEQ1AJDC14DhraLwKq
         ynUqASdnl6M2XE2BhcIR/IT79wuiYFXXgdbL7mqbARcOGFgcSl8Odl8Hy0U1nb4jBE++
         9LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596431; x=1770201231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1HgsTXbdyKjSqzNOssrGMSH6n/agYWunVSDNYW2aGU=;
        b=hhTur7lZ5TzuoPwAoBIwvsfPLVCICYBMntIVToL7SCJ9RftE4uNqySwDJ10Ta8xiCK
         QsU9WxRbrvxR2AR8ONpeCTvsEWREBj6e3fGQiP2s9B2O8+kMMwn6gaHK6bOvC8HTZydK
         +wrBdPOxCtgUY+ySIfebf8/JdpTVAwQSqi7hRCSBR0EK//XLzBvHsDRGLZE8HQiwbe/q
         gFrtmr6wN7iymgrDNPeRxgkyFX7Y5haExfdQCiYNLMvaVWnnjUDrTMyQ1D1amVPQdUGL
         UnoJRF9tsVDjGx8w9QyLvyaad60O8k3w/nYOFbPjDXhDLyOYOsFcjU7vUYGBGCSSnGPC
         4BMQ==
X-Gm-Message-State: AOJu0Yxxf60+IWjm27MihDb7NUbkctC1WUEk9QoESz9N3NwIS433x8Y2
	4TsBYo27944KIuymvwZoy9wRwdsnFfgcWGvwULkb5jxJ+vo++6ftdtxniRNwm1wu
X-Gm-Gg: AZuq6aKFDwwImqGwwtZ06wcd/HZ1rTf/lJe+Z5E+BcaBdskR8pTgypGISeZq7GJpxi1
	bLd+xaW5/v1BanQqVJwfPxqor7Qb/heOTB9EnUNJvWs+Wzf+/RwPOqiu/s0FaE+IJkPJyQB5923
	oFfc7nlN/Wupr5aR6O2G21Ft9idyljASSyypaAARlLj5usXLiUyOQlixJF1I+BKcohb3zBbYJNo
	uaRREYqLWAysGJ1Q5gi7n1zp9PRvYGcWlAzSFkh8E+yGAlllbbeWlw6JEheugmIXBW1C7d9m/QP
	ct1EN7+FXtGaFgUWpkgqqQxJSdabLTvMN7mKxu6urxM/PIVR/XA229cArbGc2YDC+E3AlC6kdF1
	KhZYzK+Pn5RTJp2OTLEZMGBBp99sTbHiJpg/kC3pQcnTjVuP4PjvEMrahaSE5pioVwdOIz3rUuT
	1AwC+X+2IRgrLgamGGpDzWmnBaTPZXN8GWNxIjO/zdMQQKMZRXrGIqeKiuC9P/ONzC
X-Received: by 2002:ac8:5844:0:b0:4ee:26bd:13f2 with SMTP id d75a77b69052e-5032fc1d6c3mr58659091cf.72.1769596431448;
        Wed, 28 Jan 2026 02:33:51 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbb66dsm12383451cf.29.2026.01.28.02.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:33:51 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: [PATCH 3/5] libceph: introduce ceph_crypto_key_prepare()
Date: Wed, 28 Jan 2026 11:33:25 +0100
Message-ID: <20260128103329.964466-4-idryomov@gmail.com>
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

In preparation for bringing in a new encryption scheme/key type,
decouple decoding or cloning the key from allocating required crypto
API objects and setting them up.  The rationale is that a) in some
cases a shallow clone is sufficient and b) ceph_crypto_key_prepare()
may grow additional parameters that would be inconvenient to provide
at the point the key is originally decoded.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 26 +++++++++++++----
 net/ceph/crypto.c | 71 +++++++++++++++++++++++------------------------
 net/ceph/crypto.h |  1 +
 3 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 5d7245884f95..abdd35be263a 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -221,6 +221,10 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	if (ret)
 		goto out;
 
+	ret = ceph_crypto_key_prepare(&new_session_key);
+	if (ret)
+		goto out;
+
 	ceph_decode_need(&dp, dend, sizeof(struct ceph_timespec), bad);
 	ceph_decode_timespec64(&validity, dp);
 	dp += sizeof(struct ceph_timespec);
@@ -380,6 +384,10 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	if (ret)
 		goto out_au;
 
+	ret = ceph_crypto_key_prepare(&au->session_key);
+	if (ret)
+		goto out_au;
+
 	maxlen = sizeof(*msg_a) + ticket_blob_len +
 		ceph_x_encrypt_buflen(&au->session_key, sizeof(*msg_b));
 	dout("  need len %d\n", maxlen);
@@ -1106,21 +1114,26 @@ int ceph_x_init(struct ceph_auth_client *ac)
 	int ret;
 
 	dout("ceph_x_init %p\n", ac);
-	ret = -ENOMEM;
 	xi = kzalloc(sizeof(*xi), GFP_NOFS);
 	if (!xi)
-		goto out;
+		return -ENOMEM;
 
 	ret = -EINVAL;
 	if (!ac->key) {
 		pr_err("no secret set (for auth_x protocol)\n");
-		goto out_nomem;
+		goto err_xi;
 	}
 
 	ret = ceph_crypto_key_clone(&xi->secret, ac->key);
 	if (ret < 0) {
 		pr_err("cannot clone key: %d\n", ret);
-		goto out_nomem;
+		goto err_xi;
+	}
+
+	ret = ceph_crypto_key_prepare(&xi->secret);
+	if (ret) {
+		pr_err("cannot prepare key: %d\n", ret);
+		goto err_secret;
 	}
 
 	xi->starting = true;
@@ -1131,8 +1144,9 @@ int ceph_x_init(struct ceph_auth_client *ac)
 	ac->ops = &ceph_x_ops;
 	return 0;
 
-out_nomem:
+err_secret:
+	ceph_crypto_key_destroy(&xi->secret);
+err_xi:
 	kfree(xi);
-out:
 	return ret;
 }
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 2b98daffe9af..3453dc303315 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -16,65 +16,61 @@
 #include <linux/ceph/decode.h>
 #include "crypto.h"
 
-/*
- * Set ->key and ->tfm.  The rest of the key should be filled in before
- * this function is called.
- */
-static int set_secret(struct ceph_crypto_key *key, void *buf)
+static int set_aes_tfm(struct ceph_crypto_key *key)
 {
 	unsigned int noio_flag;
 	int ret;
 
-	key->key = NULL;
-	key->tfm = NULL;
-
-	switch (key->type) {
-	case CEPH_CRYPTO_NONE:
-		return 0; /* nothing to do */
-	case CEPH_CRYPTO_AES:
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	key->key = kmemdup(buf, key->len, GFP_NOIO);
-	if (!key->key) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	/* crypto_alloc_sync_skcipher() allocates with GFP_KERNEL */
 	noio_flag = memalloc_noio_save();
 	key->tfm = crypto_alloc_sync_skcipher("cbc(aes)", 0, 0);
 	memalloc_noio_restore(noio_flag);
 	if (IS_ERR(key->tfm)) {
 		ret = PTR_ERR(key->tfm);
 		key->tfm = NULL;
-		goto fail;
+		return ret;
 	}
 
 	ret = crypto_sync_skcipher_setkey(key->tfm, key->key, key->len);
 	if (ret)
-		goto fail;
+		return ret;
 
 	return 0;
+}
 
-fail:
-	ceph_crypto_key_destroy(key);
-	return ret;
+int ceph_crypto_key_prepare(struct ceph_crypto_key *key)
+{
+	switch (key->type) {
+	case CEPH_CRYPTO_NONE:
+		return 0; /* nothing to do */
+	case CEPH_CRYPTO_AES:
+		return set_aes_tfm(key);
+	default:
+		return -ENOTSUPP;
+	}
 }
 
+/*
+ * @dst should be zeroed before this function is called.
+ */
 int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
 			  const struct ceph_crypto_key *src)
 {
-	memcpy(dst, src, sizeof(struct ceph_crypto_key));
-	return set_secret(dst, src->key);
+	dst->type = src->type;
+	dst->created = src->created;
+	dst->len = src->len;
+
+	dst->key = kmemdup(src->key, src->len, GFP_NOIO);
+	if (!dst->key)
+		return -ENOMEM;
+
+	return 0;
 }
 
+/*
+ * @key should be zeroed before this function is called.
+ */
 int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end)
 {
-	int ret;
-
 	ceph_decode_need(p, end, 2*sizeof(u16) + sizeof(key->created), bad);
 	key->type = ceph_decode_16(p);
 	ceph_decode_copy(p, &key->created, sizeof(key->created));
@@ -85,10 +81,13 @@ int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end)
 		return -EINVAL;
 	}
 
-	ret = set_secret(key, *p);
+	key->key = kmemdup(*p, key->len, GFP_NOIO);
+	if (!key->key)
+		return -ENOMEM;
+
 	memzero_explicit(*p, key->len);
 	*p += key->len;
-	return ret;
+	return 0;
 
 bad:
 	dout("failed to decode crypto key\n");
@@ -322,7 +321,7 @@ static int ceph_key_preparse(struct key_preparsed_payload *prep)
 		goto err;
 
 	ret = -ENOMEM;
-	ckey = kmalloc(sizeof(*ckey), GFP_KERNEL);
+	ckey = kzalloc(sizeof(*ckey), GFP_KERNEL);
 	if (!ckey)
 		goto err;
 
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index 736ec6d2fbcb..2b8f8f68ff7a 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -19,6 +19,7 @@ struct ceph_crypto_key {
 	struct crypto_sync_skcipher *tfm;
 };
 
+int ceph_crypto_key_prepare(struct ceph_crypto_key *key);
 int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
 			  const struct ceph_crypto_key *src);
 int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end);
-- 
2.49.0

