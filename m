Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB443F4D1
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447578; cv=none; b=AGHrTccU9ELzXBf0Tgo/b1ueOSuSOiJWDmrLQXdl9vDZm0g2CsGj5TR4LPho+GnwxnSa21982MeJefBuXg/wdv8ZWzwkoQeAY3WTZ8BMr+PU95U2Mp4rN2e0NKbBJf0UDIpJsfZhbkAQzSLZF6tYl5E4kMD1kEawiIYr5SPllc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447578; c=relaxed/simple;
	bh=jMf54vz5lLWWAyBOm8SwuZY6wrGMxLirEhBITV9rcow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUJCTq0x9q908yLLk6PSX8hanOLOnR2KdjhYx43T5xSgKX+Cr9fuv7W5ulMMlfEqpOa7FJauGwZYY2S/EnHlHvky2GbYd2pzxymwIousbN3LXa96Jmd2Wv9ZS1jRXSUTYfviWc3KuZB+6Ks0ZspHs2ILaYr2dc+GwOMky573H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOfEuvuZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOfEuvuZ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e602d2c0fso60619685a.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783447576; x=1784052376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xh8uKkwCGFjIS79lWu05IfbpURewrsfn5K6ej1XEKUg=;
        b=DOfEuvuZABQZDtyfBGaM1DxDOCZx2ycChImrcP+lKgLxjfH6oJmBREY53souBYLgRU
         JuU9Y+qyh3F7D76pUw+YpIEUiZKuQKmY7KvYlNPIkhcHkC1oXQ/l9bVA96hfdNU9/uN7
         peQ2eUvgwzOQeYBKX4WT/SE2JJcrUtV7rG47xcyFzjUlqITpcy4GHM47zkchhm3Bn60S
         lBnPX18zOcQkzg3iI5zguoRFmsrHOqiKz3X5fOZb9AUEfE/ChT2yPuwSOw70qRlcab4A
         T3HII71tVeUG85j8AV/DJCqWIudbuXKlzdapvVggGKT7FzB4u3IgYAyaw9vAcNXSczWa
         aG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447576; x=1784052376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xh8uKkwCGFjIS79lWu05IfbpURewrsfn5K6ej1XEKUg=;
        b=cydhxPX7oasH+yNh+yI+D0Lmv9mup8GWZMnE+OP5ABHDDrax8hbjq2UKZv/zaE8inS
         doX527G516BeYmlBm4YXi51uCno7YK8R3gvsbp+YeLvVeMaclmZ3KjQxxIif33Fu4cxB
         hgAWu/8N7Z0IxOws7mMGNTGil4VILoBWV7CWJK/0w4yFnRy0QMPSHyGQlDT6TIWXs7a5
         hsvI0auKREhl6sqQFJYejMLYhL8z0xsnYhUmo1unM7c/9yqWSAeozCzKiIfRtx+rNQYd
         Y9zeXUG/EanTxCcpd69eJXkh/IUF1ZzsLt9nGKr+Kx2ZQWJOpM/Q2SR5N2Vm+efUzIBN
         l1Hw==
X-Gm-Message-State: AOJu0YwuhVI8kvIZan/xgb6HIyktKa7c5oTvcM5/k9Cbus9bLfCmjjjI
	r6oSIEVf+HZDtxr5qt4ygsvvWpfT6qtvAmqoUDqDb9tP6VKnYkXbrR+z
X-Gm-Gg: AfdE7clX0fRJKjTtShxIrj7l+oh9F2XieZvH9J45sUa+L3GZ9rfXWtITUsUudkZPHYt
	ijMBXhBSaG/IjUI13nF84tza+tI2XfcYKjJdT89s2RRI2rDrWA1kBEATCQu2iL/BaUZR/pJBVsb
	1hU6Ed0fXCPZIpzA8vtFZUl/xXIzg9gqpOV5aBPbWVuB040vQ3mqvUC+KMv4uszoIW6+G1qUgRv
	INToJbNCwwxXz8drJbUnEJ0kSEBzE/zPmwcd+Bxr/65PoJdK07xM3tb0jsawG4mLUOQV9nhNfu6
	iBKExHjECJIMZxZEuNjY3Yadz7EbEJ9S5+1i2Xz6vCkarZu7/9uyeWCAD6eWGAmINEXHYd+EGjB
	z61ghi73QZZGVId19R2XGxt1sL0PEqX40x5Sl9VhNd40j1k+ohmc9Z+tsw7vIZsuuc2/Ldje078
	uv2Pz18/lniaiEv5XtZ5ZMcV9Qzd3aU6j1nh04fBNyQ3WFkq65vpS5IKNuFTgy/miwyYtq0tBY2
	x9Y063RITGzb2oYknaSferLN0/tTsSS
X-Received: by 2002:a05:6214:508d:b0:8f0:796:1346 with SMTP id 6a1803df08f44-8fd7305a956mr33325936d6.18.1783447575387;
        Tue, 07 Jul 2026 11:06:15 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de87e3sm166404376d6.35.2026.07.07.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:06:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ceph: cap delegated inode count in ceph_parse_deleg_inos()
Date: Tue,  7 Jul 2026 14:06:00 -0400
Message-ID: <6a37b446fa15089850b123d47484c3663036b6cf.1783447231.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783447231.git.michael.bommarito@gmail.com>
References: <cover.1783447231.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ceph_parse_deleg_inos() decodes interval sets of delegated inode numbers
from an MDS create-with-delegation reply. For each set it reads a 64-bit
start and a 64-bit len with ceph_decode_64_safe(), which only validates
that the eight bytes are present in the message, not the value, and then
loops over len while inserting entries into s_delegated_inos.

len is fully attacker controlled. A malicious or compromised MDS can send
one huge interval, many intervals in one reply, duplicate intervals, or
repeated replies that accumulate delegated inodes on the same session.
The original code bounded none of these and could spin the insert loop or
grow the xarray without limit.

Bound both dimensions with a single enforcement point. Track the number
of delegated inodes held by each MDS session in an atomic counter and
grow it only in ceph_insert_deleg_ino(), which uses atomic_add_unless()
to refuse to push the count past CEPH_MAX_DELEG_INOS. Because that helper
is the only place the counter grows, the per-session population can never
exceed the cap, so no separate per-session pre-check is needed. The
counter is decremented when async create consumes a delegated inode or
when an insert fails, incremented when a delegated inode is restored,
initialized with the session xarray, and reset when reconnect destroys
the xarray.

A per-session cap alone still lets one reply spin the insert loop on
duplicate ranges without growing the counter, so also cap the aggregate
interval length accepted from a single reply. Together these bound both
the loop trip count per reply and the xarray population across replies.

The cap is a fixed, client-chosen constant rather than a value derived
from the MDS. mds_client_prealloc_inos is a userspace MDS configuration
option; it is never sent to the kernel client on the wire, and a
server-supplied bound could not be trusted for a defensive limit in any
case. The constant is set well above that option's documented default of
1000 (a generous multiple), so legitimate refill behavior is unaffected
while the CPU and xarray memory a malformed delegation stream can consume
stays bounded.

Impact: a malicious or compromised Ceph MDS can no longer make a client
spin through an unbounded delegated-inode interval or grow one session's
delegated-inode xarray without limit.

Fixes: d48464878708 ("ceph: decode interval_sets for delegated inos")
Cc: stable@vger.kernel.org
Suggested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/ceph/mds_client.c | 59 +++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.h      |  9 +++++++
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 94f76e9fe4ead..7b00b83371f7e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -618,10 +618,36 @@ static int parse_reply_info_filelock(void **p, void *end,
 
 #define DELEGATED_INO_AVAILABLE		xa_mk_value(1)
 
+static int ceph_insert_deleg_ino(struct ceph_mds_session *s, u64 ino)
+{
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
+	int err;
+
+	/*
+	 * Cap how many delegated inodes a single session may hold. This is
+	 * the only place that grows the count, so atomic_add_unless() bounds
+	 * it at exactly CEPH_MAX_DELEG_INOS; s_num_deleg_inos can never exceed
+	 * that.
+	 */
+	if (!atomic_add_unless(&s->s_num_deleg_inos, 1, CEPH_MAX_DELEG_INOS)) {
+		pr_warn_ratelimited_client(cl,
+			"MDS session already holds %d delegated inodes\n",
+			CEPH_MAX_DELEG_INOS);
+		return -EOVERFLOW;
+	}
+
+	err = xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
+			GFP_KERNEL);
+	if (err)
+		atomic_dec(&s->s_num_deleg_inos);
+	return err;
+}
+
 static int ceph_parse_deleg_inos(void **p, void *end,
 				 struct ceph_mds_session *s)
 {
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
+	u64 msg_deleg_inos = 0;
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
@@ -639,16 +665,34 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 				start, len);
 			continue;
 		}
+
+		/*
+		 * Bound the number of inodes one reply may delegate.
+		 * ceph_insert_deleg_ino() separately caps the per-session
+		 * population, so this only has to stop one reply from spinning
+		 * the insert loop under an attacker-controlled len.
+		 */
+		if (len > (u64)CEPH_MAX_DELEG_INOS ||
+		    msg_deleg_inos > (u64)CEPH_MAX_DELEG_INOS - len) {
+			pr_warn_ratelimited_client(cl,
+				"MDS reply delegates too many inodes (have %llu, +%llu, max %d)\n",
+				msg_deleg_inos, len, CEPH_MAX_DELEG_INOS);
+			return -EIO;
+		}
+		msg_deleg_inos += len;
+
 		while (len--) {
-			int err = xa_insert(&s->s_delegated_inos, start++,
-					    DELEGATED_INO_AVAILABLE,
-					    GFP_KERNEL);
+			int err = ceph_insert_deleg_ino(s, start++);
+
 			if (!err) {
 				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
 				pr_warn_client(cl,
 					"MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
+			} else if (err == -EOVERFLOW) {
+				/* ceph_insert_deleg_ino() already warned. */
+				return -EIO;
 			} else {
 				return err;
 			}
@@ -666,16 +710,17 @@ u64 ceph_get_deleg_ino(struct ceph_mds_session *s)
 
 	xa_for_each(&s->s_delegated_inos, ino, val) {
 		val = xa_erase(&s->s_delegated_inos, ino);
-		if (val == DELEGATED_INO_AVAILABLE)
+		if (val == DELEGATED_INO_AVAILABLE) {
+			atomic_dec(&s->s_num_deleg_inos);
 			return ino;
+		}
 	}
 	return 0;
 }
 
 int ceph_restore_deleg_ino(struct ceph_mds_session *s, u64 ino)
 {
-	return xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
-			 GFP_KERNEL);
+	return ceph_insert_deleg_ino(s, ino);
 }
 #else /* BITS_PER_LONG == 64 */
 /*
@@ -1062,6 +1107,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	INIT_LIST_HEAD(&s->s_waiting);
 	INIT_LIST_HEAD(&s->s_unsafe);
 	xa_init(&s->s_delegated_inos);
+	atomic_set(&s->s_num_deleg_inos, 0);
 	INIT_LIST_HEAD(&s->s_cap_releases);
 	INIT_WORK(&s->s_cap_release_work, ceph_cap_release_work);
 
@@ -5103,6 +5149,7 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	/* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
 	xa_destroy(&session->s_delegated_inos);
+	atomic_set(&session->s_num_deleg_inos, 0);
 	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
 	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
 		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 731d6ad04956d..d1a10c4bd4d2d 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -299,6 +299,7 @@ struct ceph_mds_session {
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
+	atomic_t	  s_num_deleg_inos;
 };
 
 /*
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3737ea7ed88b3..fb2b0a4b7bb3e 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -642,6 +642,15 @@ static inline int ceph_ino_compare(struct inode *inode, void *data)
 #define CEPH_MDS_INO_LOG_OFFSET		(2 * CEPH_MAX_MDS)
 #define CEPH_INO_SYSTEM_BASE		((6*CEPH_MAX_MDS) + (CEPH_MAX_MDS * CEPH_NUM_STRAY))
 
+/*
+ * Upper bound on the number of delegated inodes a single MDS session may
+ * hold. The MDS normally hands out a small preallocation window (the
+ * userspace mds_client_prealloc_inos option defaults to 1000) and refills
+ * it as the client consumes entries. This leaves generous headroom while
+ * bounding the CPU and memory a malformed delegation interval can consume.
+ */
+#define CEPH_MAX_DELEG_INOS		8192
+
 static inline bool ceph_vino_is_reserved(const struct ceph_vino vino)
 {
 	if (vino.ino >= CEPH_INO_SYSTEM_BASE ||
-- 
2.53.0

