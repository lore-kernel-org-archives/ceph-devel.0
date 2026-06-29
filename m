Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4B32694E
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762957; cv=none; b=M+gAJuCYb90EStyhbOEPuoYjSg211h6L2nxNx949Q9CxOYH6mnkPWg9yfjVaRcL9Ygm0sm7pa2nY9C7tOJ8fDpgb9XYzidfG8tjW2/46FZJr5gqD/BCTNCsK6yIuDK2BC00zkW5k1MRXlTxZRxrNlpD+8Vfa6h1oFE5/sEifupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762957; c=relaxed/simple;
	bh=mZ16wN+coN8+TfASm/P9BVAQjGfQ483wqdX5R17V9S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn4MqsnZhRxHUfLr9Rdi9VYOJyeVFvZ81fA+hoCy6Pk3jigdHLUxc7Dy9wUpbDayyw3m+RX+ypo/6r1xtnbC+8ZkazQXzLWCcrmTSFAIpQUmx6GikFDQdpv9nGsJdd0Rm51xvOZ7BDzNq8HLf0ghXeE/4YIHSU9pYvqHwQtQI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=B6NzFLKL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="B6NzFLKL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4924593f45dso48650785e9.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782762955; x=1783367755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9M8rBrzksoz9JiVNGQu5419fT7SACyNWqjAWrtAQ4c=;
        b=B6NzFLKL3e1lae+B2bh+pA8i9QIyAo5rk6FQ3BBiPxO4ePDqOhkllw2iXyAyU0Qosc
         6oWjdaOJPM2qNfH/LPKlX1ydh31duasnbWpL5xbjyEcwR6ZOT+dHQkPMuoQkxV3eJWkf
         tbXcaHnVEHL8GiAflw0/d9w7dgKC+5uaWPT0fGvV4TKGpgX3dr/p7MX8kphNDt1/DnHX
         4c/oufbKepRb4nYetiT9Ddtr07GiypFOQOiUhYd+vqY8OBrYqS5dIOvxO3KRcqDavmjZ
         pyevBPDrw+SJCtTpdHfU1+k+4Pq74VSZK9vlVoQwk7Htc0SpNzJABQzbmVIzXLSg6jhg
         ky/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782762955; x=1783367755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9M8rBrzksoz9JiVNGQu5419fT7SACyNWqjAWrtAQ4c=;
        b=KgpRIsYKtHzk2qYzekdBAY91yf0EyqIP9+2jsr2OAhhydKVQMQzCZYJbDZ6kcD+zy6
         pzgFZllYxMEgJfeFiFIryGLK80yphmbqgnTRI79XVNcqs6Zp9VRU1Wu5dQnGRyywhPsa
         W5oTzJl3P/G49kNwtu1IehNQUywKfUcJz75V+QTNcJdfT+xW95pU/sjRHtdNRrVS4jnQ
         +ceDiwdL1mdqSeZKdi6smIe1cqtR26VC3lGHJu+Yh4Jtfgnfqs3u6vqP23rR0xy585Ix
         z1nay2SI9v9V3A45vgY05aijbd7uecBjhAH+pEfUDJpNbnzaeJ6k0kpk0C8apRQygPei
         IZnw==
X-Forwarded-Encrypted: i=1; AFNElJ9pj6JgWZUim/5EzAVSog9XA5epHYUE0e2Xrke190n02N3h1fOkFRZwTsJwwT4k0GEDDHOBju+9lw/p@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3OS0FvR4esQyEYk1wdW5mzdVjRW/9npzxjtVeJLdufyOS8Mo
	Cc08hxgGgR9xABQrZfS77D8MDZg5WXCmJq9+IBw+VwF2nkwLfQFEwsjJdqfva3DN1n4=
X-Gm-Gg: AfdE7cl1hXBLAJ3fGzIPytcdpzfkWiAgOCgkx1vsDPvjWVx9xw6S8Mosue4IASLwWim
	nmZ0E4uSqAl0TE//7AwopmrQl/j0vUkhbgceAz19QRpp/AgO1EeGQ53ihSnFDzufjyvNCVmjQdn
	RrfqEH71B/mzd48W7tV+tLxSGp8+2ETyCs8eEolMh6G8pnrrInxjW9OKhW6vIQw2YRT7NQU2vYU
	4ea4RWEuMalRgtfR7RSbdjEvMgivg0xsxjd66mQWYo35hfnSevYFLS9CecRFGmivpfYXLzlOEy8
	Ab88WPr0K2i2ydm8NCv36ekgBSD6ZbWxb4+te1FhF0lvpwsFUS5sNrctR6Et0HZFB6bDTqfCGql
	S5T2PPPrbv41ss8P/lY5GxoLHMopTzOhPUNhmpOqwJCQsPBmUvV2zpdMyDBlF82nvsctIgz3HYg
	zslef2lXIJL/C3kkHcGOL7HSDBvshz4uB0ZCWZWJcH93Mtv4ivzGC/Ufc/FPrZ8tQNs9P0WDzZ+
	PhEgcVs0Kh0o+PM
X-Received: by 2002:a05:600c:5392:b0:493:b771:de06 with SMTP id 5b1f17b1804b1-493b82816cfmr16553315e9.5.1782762954634;
        Mon, 29 Jun 2026 12:55:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4659sm698902f8f.12.2026.06.29.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:55:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Mon, 29 Jun 2026 21:55:40 +0200
Message-ID: <20260629195540.2892415-1-max.kellermann@ionos.com>
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
 net/ceph/messenger.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..4848ae5f61bb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1221,19 +1221,37 @@ void ceph_addr_set_port(struct ceph_entity_addr *addr, int p)
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
+	/* the input string might not be null terminated, so copy it
+	 * to a null-terminated string
+	 */
+	copy = kstrndup(str, len, GFP_NOFS);
+	if (!copy)
+		return -ENOMEM;
+
+	ret = inet_pton_with_scope(&init_net, AF_UNSPEC, copy, NULL, &stor);
+	kfree(copy);
+
+	if (!ret) {
+		/* ceph_entity_addr might be misaligned, so we have to
+		 * parse to a stack variable first
+		 */
+		memcpy(&addr->in_addr, &stor, sizeof(stor));
+
+		/* return the end of the parsed portion to the caller on success */
+		*ipend = str + len;
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 /*
-- 
2.47.3

