Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0353AF65A
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543147; cv=none; b=Bx8ypevJxFDRSBZgV35w4SNXyVmp/aaVTMRwSzZIY3wQCzar3APEoLGWE3bQg7hck/YCB0vQ0/ys/1G7Zm0Pi1fkKg3pJlFnFLkp3i1EzTH05Rl3d8h0jFuq4aNt+PflZZ1F/kf7qXdcHIKQfiQq+0zJ6Iqbz2DThmcwR165LGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543147; c=relaxed/simple;
	bh=SPyf1sVRImYy025lzafai3puMJ9u2Ehpp+yOSZGkUJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqRw8Zhsn3THF0j8MxgdTjkP0bw24Pp9UoPCNvtBMcZo9EvsvUXTAhNFtHEAliHv3D+4jo51nz4AANL8XK0hL/cjnxYc1bCw91E3dFa4cd9FkoXIcepKQcjxpA6kUIhod7dIx3FkBnbIqFxEsl7oOO3Wv2pRla/IJAwgy6bOmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gxAdgQAS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gxAdgQAS"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso88759f8f.2
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jul 2026 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783543144; x=1784147944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L6HVoHiWWa30jPC1xil3MwgrmH/xxywgrreM6/9IQpQ=;
        b=gxAdgQASacs+/+NT1nXeh4zl8Qjm8QU1mv5XD8hZocU1cPtGuuoIZ9wcyrt2i6h0r/
         nX/nl5460+X3b7hwZO0oYHGptdMq/NFFS8k/hyf7dkv353EJBTeeHLOcX17ADJspfmRX
         rq8Y6IS0o8MF/PikGtozQfKTH7CzNTtHNyg4VJvD6CA8fU/HJWTk21LVNc6q8UxuvA/M
         3lw1MoJs/1tBqVPZVUqeQC+Zi7Uf9xR/VMjAn7mz+ARklEE/h592krJ4eVAWzWGgTjX3
         crP13bzUpTJ9oVP710DZRuF4b0Sw93IFxJ0dRcn6JY6PSheEWPx2q7AsfYel+BMgeAqH
         Lo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783543144; x=1784147944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6HVoHiWWa30jPC1xil3MwgrmH/xxywgrreM6/9IQpQ=;
        b=VwgDNxnIMVRkkKY0YjujmOHdP7APdCyi+n4Gj9KEkxWNq7xTT6LoQK5z505HGMQ3uO
         ayKrk0BD+5F6lkY3BVtlAUH9nkeSxlEa2QhFV0+hCYR8h94HpAMi5juqfQgsrLlZeI2r
         /RHIq768rpufEPcQDRdXOb+N9vqiAR58AYnodNPM1COwyT2Pu3NIIyYqemLJlXSHs1B3
         QrHjotQN7ZkxvO6Dau1stqfWuRVphavNvB1Qi4cRg6t7AEwHxlqYcU8+8aBUGfw8lHKH
         esjfD4GyOnvOsCAi3bTY6I+2kmWR0o4/VYPI401nVLO2bzIllWJv/yCUCWPxWlu6YUKd
         Fu8w==
X-Forwarded-Encrypted: i=1; AHgh+RoR+qlfH9zwCvdfjJ00uqu8UhveE5AGaIWl72NfrOWioViL+X/K013TmVojp/NkDxKVCgu7tE/CIzfj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5Wv75nX2iIofgUSgs2GeZJ55qORobFHBEJuTwulXVAUZ1D5v
	023lf1eAYLQOV3PkV8GoKKfYlKF3gl0tbxopyGbfcvTKlcuaxsQCzajKXUJzCJ7Pm/hQzfCHjTZ
	mr57eHgw=
X-Gm-Gg: AfdE7ckv2OQNlI5vOH/67RkS4/Y3Rvaxoa2cZypZR8o373RjHzl4n3L3k7xUN6S/2n0
	/3uuGUuU0ztHGoWapiziBdu08PYOfnauj1ypTlj31q+GI28w8GYLpIh8S5moH2klL/XAVOnop6G
	WAYY+1xxngTFXpyIlpQr/kYXpd26++oVyj8EhLHiKFh+g7k3mq8b2cyM0jWLL8OFPMx1K6+TK9S
	R6+VI0B8EsuqzCIXxdvxKzoMXsWAUfKB7Lsa6LrVitkx1e0nYUysD3N7kBARorgOsIqpe3wuv66
	Z6QV5K4Eynmj1EghOfws/KcN1eMB3SHNLgzLbaJstIkAB8y/mJ8nuG/KvqfchjSqDO3YirIfPHq
	LLD4vxFhQF/8Wlv0Sj9z86Hual1amCswlZfuV/sVWj0Zz9YEvy9r1KIFFUPkFg/hJZyuv6jkjZS
	mEe1NhbbgA2vVCIYjzq/nwF5T6dkqsXAfgNFSyDENZSbyNegwbXVAxwSaATd9MSimRuSANH5Gzw
	p2SIlradDm1pEMXYPoHmm5J8QI=
X-Received: by 2002:a05:6000:2003:b0:46d:d5da:f0a9 with SMTP id ffacd0b85a97d-47df077f4abmr4408683f8f.44.1783543143899;
        Wed, 08 Jul 2026 13:39:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm48721570f8f.37.2026.07.08.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:39:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3] net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Wed,  8 Jul 2026 22:38:58 +0200
Message-ID: <20260708203858.263229-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ceph_pton() using inet_pton_with_scope().  This minimal
patch preserves the ceph_pton() API and thus requires copying the
parameter to a null-terminated string.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2:
- check "ipend" before dereferencing it

v2->v3:
- fix indentation
- use the caller's network namespace instead of init_ns
- stop parsing at the port separator

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 net/ceph/messenger.c | 45 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..21dfff074e7d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1221,19 +1221,46 @@ void ceph_addr_set_port(struct ceph_entity_addr *addr, int p)
 static int ceph_pton(const char *str, size_t len, struct ceph_entity_addr *addr,
 		char delim, const char **ipend)
 {
-	memset(&addr->in_addr, 0, sizeof(addr->in_addr));
+	const char *delim_p;
+	char *copy;
+	struct sockaddr_storage stor = { 0 };
+	int ret;
 
-	if (in4_pton(str, len, (u8 *)&((struct sockaddr_in *)&addr->in_addr)->sin_addr.s_addr, delim, ipend)) {
-		put_unaligned(AF_INET, &addr->in_addr.ss_family);
-		return 0;
-	}
+	delim_p = memchr(str, delim, len);
+	if (delim_p)
+		/* delimiter was found - stop parsing there */
+		len = delim_p - str;
 
-	if (in6_pton(str, len, (u8 *)&((struct sockaddr_in6 *)&addr->in_addr)->sin6_addr.s6_addr, delim, ipend)) {
-		put_unaligned(AF_INET6, &addr->in_addr.ss_family);
-		return 0;
+	delim_p = memchr(str, ':', len);
+	if (delim_p && !memchr(delim_p + 1, ':', str + len - delim_p - 1))
+		/* a single colon was found - stop parsing there
+		 * because the caller wants to parse the port
+		 * number
+		 */
+		len = delim_p - str;
+
+	/* the input string might not be null terminated, so copy it
+	 * to a null-terminated string
+	 */
+	copy = kstrndup(str, len, GFP_NOFS);
+	if (!copy)
+		return -ENOMEM;
+
+	ret = inet_pton_with_scope(current->nsproxy->net_ns, AF_UNSPEC, copy, NULL, &stor);
+	kfree(copy);
+
+	if (!ret) {
+		/* ceph_entity_addr might be misaligned, so we have to
+		 * parse to a stack variable first
+		 */
+		memcpy(&addr->in_addr, &stor, sizeof(stor));
+
+		/* return the end of the parsed portion to the caller on success */
+		if (ipend)
+			*ipend = str + len;
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 /*
-- 
2.47.3

