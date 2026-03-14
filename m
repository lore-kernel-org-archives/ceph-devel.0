Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0C139D;
	Sat, 14 Mar 2026 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773523601; cv=none; b=WYVv8ggpZytvavK905KSVgXOJXCZOEHJU16M0pxHRS1EF3aHvsJt1AUJjMdceSKIa6GQbz80fDL1H0zsr3Bm2uIzA8FpnDs0FNY7QyDTHBucn+qQ59uojJZet97fJ9VqZ6m5nS73AHXEWfEhVj/Gg1rfHStUBnfauS0B0yDoOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773523601; c=relaxed/simple;
	bh=hpx71h7qJT5RDq4f+fg9Wv2fxlT5wg8N1TZ8XscUfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGvzaAOSrJH6DOuC+fHusQEIwdbN/HxU9+mzKLsjbA++ex8xtkRi4FSiczo/i17HXDW43+XgmjWi4/JagMl7eyGOtehpiYrf9fIc2lv7J/TZn51iM/sXPKROoxBmVTjyk6VVyfhgO4/jk5EDGAIffIGF+gbNl4W7Cd8usvm/zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnlMNrRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnlMNrRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8BEC116C6;
	Sat, 14 Mar 2026 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773523600;
	bh=hpx71h7qJT5RDq4f+fg9Wv2fxlT5wg8N1TZ8XscUfmw=;
	h=From:To:Cc:Subject:Date:From;
	b=XnlMNrRXurLLMm39G4PW3/FOoSSk2oZnhq3uJuRSuhU1cdtJmfpVA8d0ZnVCbHQJQ
	 32lzRpJ22jyxNoBGvm2B1wLft25EEzm4MgYRdpbJEs91Q6xT+r6zbHmK4Qh4fZp0X5
	 ti4jDYzyNW6O3WcKkmaI5hebUli7K4xo6lwuyzYsYquqDvoXBxP8qFqRf+dm6HNpCn
	 z3j3fsY4uqOB7uxRwgS/WHv3+eJRPz0E5f/uiyWxqrGcy+UohMzqBbxzaSpV8XBIfX
	 a1ovZMsB8n1ENxf51W5nZEhALpalqZrlePfLSkCbaMgm2Pu/UK62iakBOKkzRkyMVJ
	 ij01cOsuBqlkA==
From: Eric Biggers <ebiggers@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] libceph: Remove obsolete session key alignment logic
Date: Sat, 14 Mar 2026 14:25:19 -0700
Message-ID: <20260314212519.84244-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the call to crypto_shash_setkey() was replaced with
hmac_sha256_preparekey() which doesn't allocate memory regardless of the
alignment of the input key, remove the session key alignment logic from
process_auth_done().  Also remove the inclusion of crypto/hash.h, which
is no longer needed since crypto_shash is no longer used.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/ceph/messenger_v2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 50f65820f623f..865a9221315b0 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -6,11 +6,10 @@
  */
 
 #include <linux/ceph/ceph_debug.h>
 
 #include <crypto/aead.h>
-#include <crypto/hash.h>
 #include <crypto/sha2.h>
 #include <crypto/utils.h>
 #include <linux/bvec.h>
 #include <linux/crc32c.h>
 #include <linux/net.h>
@@ -2350,20 +2349,18 @@ static int process_auth_reply_more(struct ceph_connection *con,
 	pr_err("failed to decode auth_reply_more\n");
 	return -EINVAL;
 }
 
 /*
- * Align session_key and con_secret to avoid GFP_ATOMIC allocation
- * inside crypto_shash_setkey() and crypto_aead_setkey() called from
- * setup_crypto().  __aligned(16) isn't guaranteed to work for stack
+ * Align con_secret to avoid GFP_ATOMIC allocation inside crypto_aead_setkey()
+ * called from setup_crypto().  __aligned(16) isn't guaranteed to work for stack
  * objects, so do it by hand.
  */
 static int process_auth_done(struct ceph_connection *con, void *p, void *end)
 {
-	u8 session_key_buf[CEPH_MAX_KEY_LEN + 16];
+	u8 session_key[CEPH_MAX_KEY_LEN];
 	u8 con_secret_buf[CEPH_MAX_CON_SECRET_LEN + 16];
-	u8 *session_key = PTR_ALIGN(&session_key_buf[0], 16);
 	u8 *con_secret = PTR_ALIGN(&con_secret_buf[0], 16);
 	int session_key_len, con_secret_len;
 	int payload_len;
 	u64 global_id;
 	int ret;
@@ -2413,11 +2410,11 @@ static int process_auth_done(struct ceph_connection *con, void *p, void *end)
 	}
 
 	con->state = CEPH_CON_S_V2_AUTH_SIGNATURE;
 
 out:
-	memzero_explicit(session_key_buf, sizeof(session_key_buf));
+	memzero_explicit(session_key, sizeof(session_key));
 	memzero_explicit(con_secret_buf, sizeof(con_secret_buf));
 	return ret;
 
 bad:
 	pr_err("failed to decode auth_done\n");

base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.53.0

