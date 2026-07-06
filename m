Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9D3E075C
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323857; cv=none; b=TESe/Dtxz/DHjqYYOzK5+qZ8OXaCUTml38ChIiwiD63Z5kjirySRaa/jgX2n++UUnP60VACoU3xRa4sDBYujkmxXIHICV663MDbq5KzLuR5bvL/FIFaTXPaM2oIIMdC5TT7tYE+LpyhtT1aPe61CB1jZdR6fSAxxf67doorh1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323857; c=relaxed/simple;
	bh=kp2tve8yg97eVe6KN1fHwiiuqPKpUBdKCRpEc807+Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTk0Rk1bvY3c6CbsZOTzIHCvRHMnNwkra54SgisVEXvcGIjsRJ5iywLEOqtH2BIGBc/MtusPPatrFUG3ha6oLj3tZOiy9hEVuLGropb0++7yI0xGBQIi+z08FVUaaDTtcWWxGN06nBdImv95OE93PsQJYScOD9LTyQsV6dSASf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=feem40YK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="feem40YK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493d3135f62so7670065e9.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783323848; x=1783928648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv56uqMTa5ltTK3hth49y7o1dis60eGd+zlFNk3yu/Y=;
        b=feem40YKGwYZWZxIPncArx1+8OvuKy/AlVkBpdyd8usPZddszyp560572OUktyTVjl
         yW7jQIL1biZ34eICB/QbDepww0Di2Eq+H84hkFOaXM7JMoRnVLkkmOw6Fw1ffpOjDtnU
         wyxq4vjRbsbS1LSoVimMUgzTOkhQPsDtviPn7M9DziyuoU9xFo/lQ3lK3lhhxKqb4A4X
         9JblBkx8mza3PSWXCW1Y+BB6wWnx+evc3hfVD0DqTBnBXi1Qnaya/Hn5ex3OoOfz4thg
         78euY2qWZfWMSt4u7ZUTtZmx/yswPvWvXxBknnP6sM+4+Of46Z6gjfjnb1UBw7DHcC6H
         udsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783323848; x=1783928648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv56uqMTa5ltTK3hth49y7o1dis60eGd+zlFNk3yu/Y=;
        b=K4UiHpl7bHYiAp8OYXqogaVU8FUFV9mv/J0Nu39CJFkZcRrbQX8oyrKqlhChmw2uL1
         bshZuCA38iQo1YlVEpFvO1Nc38yy8OzfbEB2P57mB9rD5zHaRZkkB+LRKzA5Sedy8YM2
         Qm3bucKIkuBjfOHX/btwtKbmFBSFgj3RgAD9nQTA67PgMQedV9vLDX7t4IFP6s91SP9v
         +DYRVSwxvXaX4wGxhMNAiONmZNyQS/vBAPaFHgRQOZQxZ8yThkugBYI766bySP9wbFXi
         0CibLctps4L/j99HnU9OqK6HirvIVfISsx2/vhRINtHFX3nnVLRkhLpbHm4F4yLYfL9/
         hfZA==
X-Forwarded-Encrypted: i=1; AHgh+Rqm1t2j11tTGDBtOfNroeqSIwQ38HzYXkDviJFCAkIzL5y8F99f5KCGxl38dPUeXE3O+htrPCBjGjxi@vger.kernel.org
X-Gm-Message-State: AOJu0YyVlVF+ElwuSrsnRNGN2Qb02lI1HmkDcvMYw35GurBaDkoAB6lc
	4UMncCIrsOqp6pr52968XG5dQu/zHiZYK1JBvR7XF8Pvgc3NRLXPHmnPmJCNd++lyt4=
X-Gm-Gg: AfdE7clw4tp1S8s0n858RtabRZ9OdTdtQNkkvaqgkhTLDicN/uFcrBi6EY6a67G4/Ej
	1UBBAggRN8gwR7vfqehj3Ltrm+LGhwuUjoRmOaBE7zz+SyNR09jBoP2l4sTmoK6d9wcn49wc7Nb
	esMlVwQbPNk3wslD+Z92+UniahLNWlclK+35EdQQNOlNqP4qWwbfTKZaMF55r43d+GtNZNTqmNK
	3bBDFVhkU8i9ddMjxk4YvXgnKjGbS2yN6TrCy/jmZr9a5N1SUnFwnjhZsTL8JlAEwDS3uTaZRbU
	Jf4bFBBQ3f1ujgEsC0qCiRuYpYykerhY/BaJemJtM9T9C77+lViB7eNm/8JmyTVYJMSErn2em3+
	l+GIUBwnJ6UQWsXgdxGMMMjYtHMxPazxQdVy256yv66h8FbFmBX7LlQ8bbze6ZzAoKADpz/neRi
	o9qTXHNFW7UIq6FpWsLMKVBE+7CzUB3FcuB2KrOc6VbhWMAvH3NGDq358WvOnWL91Fpzyufedbr
	CSjSSR9/E5DjqcC
X-Received: by 2002:a05:600c:3493:b0:492:4363:e7d6 with SMTP id 5b1f17b1804b1-493d11fdfaamr99814865e9.37.1783323847595;
        Mon, 06 Jul 2026 00:44:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm400517035e9.15.2026.07.06.00.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:44:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Mon,  6 Jul 2026 09:44:02 +0200
Message-ID: <20260706074402.3927113-1-max.kellermann@ionos.com>
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
---
 net/ceph/messenger.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..f7c7179589af 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1221,19 +1221,38 @@ void ceph_addr_set_port(struct ceph_entity_addr *addr, int p)
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
+		if (ipend)
+		    *ipend = str + len;
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 /*
-- 
2.47.3

