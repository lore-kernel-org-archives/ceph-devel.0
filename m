Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B92BEC2E
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596431; cv=none; b=okW1BX5QiPIngPHMu96Czq30hiS4p3IyYjn1icpIbEiS5h8dm79ZuwwD1tVCZa6q9EZh5QE0aoPmd3Qyl8+ttIVrS220k5dEWwUnVWsIydGpwIDrjE+oDRZrnPYN6oghc1OwBkqPHM0EqkKmx95qqQsU/6Gmc0eDWAx4R2XDFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596431; c=relaxed/simple;
	bh=iSNeVT/w02CcJ4bBDJYbZ1PqBIRIPlVYD5wn8WCQHrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izas26wFdRgF3ahNJ9BeneLitUCuc3jYkn+OOFQdk4lcS5T00niWXtoDJvISzOJVDhast3fbmNyalchhdws6hnL+QC9/q1gQQtqMtBaDqSJ/5dwCST4c+T8vlkHkutf4rsKHMVSV5BPc0uJ93wunDvdRq3a9MAvyj1nLkOKsa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk9vTi07; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk9vTi07"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50146483bf9so77266991cf.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769596428; x=1770201228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6lSi/pnOdItdxhupIS7Gd9BonjHoCsJp51skQY5gCk=;
        b=fk9vTi07Jn08iZBTlEtBLUIT6r7N8pJT+5x3fHMdN0dFbI/yWbZeHi5uL+3zbZAzRj
         6SqxcAfbEtSC8nbEfuRNX6Q9AgzJbgXqInRwYNI/+d0klSmdLsHU2KZusRSmIpixKUjf
         uQemZDXUfx7IYF3aqebnokD8lRrjOEjZjQFwBzM417Qv0mNCVXjdcbiTPPdN1dDOcSXj
         nMBWqtUi9NPb7x/wInIe6bpxGi5sdQu+xIo2ahtSRUexMVLWTjJe41Y5cB65AmH5YE2S
         ZTMPU0KB0wmDorUePWe0tQBKw382D3xlnSQyBr4C+xuQ9eL9HJIFuUnEIXUD/Kzy4xCz
         axZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596428; x=1770201228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6lSi/pnOdItdxhupIS7Gd9BonjHoCsJp51skQY5gCk=;
        b=g7o3bCtxdya+Cd04FECc6DXn1qyothRXDzlihkLQwFw4HBEYg19iaddDcT55ux7y2Y
         nsK+6VJNayCywAb8Ibi+rQdin+C63bIpXSK9DrdbCPWFavpWj6IgAVwCLmyeXf58mYHX
         FKhND3HFvpydZCOQCCf7LZahs1SgNvcFkufb/cc7VSxgvVIZbrZus8IIZtmiVGiKnXEU
         zOPFmezbZ4CkAtANJXiBJfzDmyXG6YzZvoqMbW2GARFx05mDdlf2bED0qPqrXydQK9CT
         GQV3xPR8LufQw16JUoV/F7eoOREaY6kMJob8h0+RqL2REOyzx3V3d3fvcY1R47P/HThX
         SH4w==
X-Gm-Message-State: AOJu0YwWFquzhRsZdmcg8u+BzEhvHEb7RrcqErgtlS0Q3LRgQFiw8R6O
	9Mr5zwqikakFSgnxqiqnkpc5Vu68xi0ywxsDRAtydqiYIcSRyMH456h6mN/g2A==
X-Gm-Gg: AZuq6aJzjRhWZEcrZ5XqJITN0vK0wi7rhHcYM9P6dpSsz0lNwppLWWdB7XZElQxTtoy
	MTMdPScJGIURkZVSPY/GOBjVqOC31S86RymbHU4jonzsFqCnCwT+zWv5sc8jBL/5lj80MGA7QEt
	Xwz+RhOYz5eZqe9UqymzZK7H305RShbk9L1IWamQxWOu7HQXCJPn9SoMsXV8Q8TbYBZ2fzvY2tV
	GbRPJeqw0TVJnV2z5ddPGYFSGoDtosGjBwsEFqE6WNWZBUBzow7cY6fjuy46NTJWVWb5yWAfb6j
	QNtYNkxNLcw2DPqaDxQgjZzrV6qGDt6icXkSl/NgPPC++8TZLO5JywNXXPk9Bel4rv206Xj7SJu
	PVwNtIVPj8C10cNzw1/A6MZVyA35heAfXYfVCUXTX/rgrfCE8VAwgvbA91lTHLQFrIawZY5CTfQ
	0hOrzWw+wOZ3ep47vp+yESVK2T8LvV5ZwaKyziWcQuas4vHhTg/s0RGA==
X-Received: by 2002:a05:622a:241:b0:4ee:4a3a:bd0f with SMTP id d75a77b69052e-5032fa02ed1mr64666921cf.69.1769596428487;
        Wed, 28 Jan 2026 02:33:48 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbb66dsm12383451cf.29.2026.01.28.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:33:48 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: [PATCH 1/5] libceph: define and enforce CEPH_MAX_KEY_LEN
Date: Wed, 28 Jan 2026 11:33:23 +0100
Message-ID: <20260128103329.964466-2-idryomov@gmail.com>
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

When decoding the key, verify that the key material would fit into
a fixed-size buffer in process_auth_done() and generally has a sane
length.

The new CEPH_MAX_KEY_LEN check replaces the existing check for a key
with no key material which is a) not universal since CEPH_CRYPTO_NONE
has to be excluded and b) doesn't provide much value since a smaller
than needed key is just as invalid as no key -- this has to be handled
elsewhere anyway.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/crypto.c       | 8 +++++---
 net/ceph/crypto.h       | 2 +-
 net/ceph/messenger_v2.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 01b2ce1e8fc0..5601732cf4fa 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -37,9 +37,6 @@ static int set_secret(struct ceph_crypto_key *key, void *buf)
 		return -ENOTSUPP;
 	}
 
-	if (!key->len)
-		return -EINVAL;
-
 	key->key = kmemdup(buf, key->len, GFP_NOIO);
 	if (!key->key) {
 		ret = -ENOMEM;
@@ -83,6 +80,11 @@ int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end)
 	ceph_decode_copy(p, &key->created, sizeof(key->created));
 	key->len = ceph_decode_16(p);
 	ceph_decode_need(p, end, key->len, bad);
+	if (key->len > CEPH_MAX_KEY_LEN) {
+		pr_err("secret too big %d\n", key->len);
+		return -EINVAL;
+	}
+
 	ret = set_secret(key, *p);
 	memzero_explicit(*p, key->len);
 	*p += key->len;
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index 23de29fc613c..a20bad6d1e96 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -5,7 +5,7 @@
 #include <linux/ceph/types.h>
 #include <linux/ceph/buffer.h>
 
-#define CEPH_KEY_LEN			16
+#define CEPH_MAX_KEY_LEN		16
 #define CEPH_MAX_CON_SECRET_LEN		64
 
 /*
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index c9d50c0dcd33..31e042dc1b3f 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2360,7 +2360,7 @@ static int process_auth_reply_more(struct ceph_connection *con,
  */
 static int process_auth_done(struct ceph_connection *con, void *p, void *end)
 {
-	u8 session_key_buf[CEPH_KEY_LEN + 16];
+	u8 session_key_buf[CEPH_MAX_KEY_LEN + 16];
 	u8 con_secret_buf[CEPH_MAX_CON_SECRET_LEN + 16];
 	u8 *session_key = PTR_ALIGN(&session_key_buf[0], 16);
 	u8 *con_secret = PTR_ALIGN(&con_secret_buf[0], 16);
-- 
2.49.0

