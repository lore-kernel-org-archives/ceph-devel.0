Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922D54CF6C
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085667; cv=none; b=FKgvhElXlvNNtiOFABwcAfxDX+QiRyL9W6eSDBHUsJwj8h9XU5QAK93TuhporkN9s7LWM+1wjYEPb0I235K5gUCRk74Jz0BLD1AJ5LJfuuCNlnxHaVhed/0sqN9KKNfWQWIU8kg6WAIiFsg/D0Syv8+dqpnsXai74dRGLqngC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085667; c=relaxed/simple;
	bh=HcG+gf3kSIuA0s5TkzCfaMPDVJeDLtQgHdrgfTPrGJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nw5P4qXkxW0q/qbJMPft4xanUhJcHSUpYuajAn2c4Ovd4/y3FXhRnQjdzF5DQFh8RfyrlHmDm3jddBQHUK+VDIzy9CdLM9NfKihGg4OF+6R4S9iRG/B2X7TQM9sJVOtt8QyyzmhoOcipfvKxmi5CAdHHg9/tPQv78iDDvgYJmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SW+6nVw9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITU9u7YK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW+6nVw9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITU9u7YK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
	b=SW+6nVw9HI4DmpKSQm0tqcGhZ/L9a2GNyfgrDfua++7S1HQ9iAGQs0WH5nc46vh48dP/fp
	lF7YWu/mec/D9l3tTren1FIeWtBBg1G8SMDI6/F8leKppGIjZXhhwbApuqDWZZw273u3GN
	iQEtEv3XTBH0NHcRE2fwMhpidhPEWl0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-jQZw5utwNI6F3oSJcSkkMQ-1; Tue, 22 Sep 2026 10:01:01 -0400
X-MC-Unique: jQZw5utwNI6F3oSJcSkkMQ-1
X-Mimecast-MFC-AGG-ID: jQZw5utwNI6F3oSJcSkkMQ_1790085661
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a1b824e84so825441485a.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085661; x=1790690461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=ITU9u7YKiDuoTGJwQcqWsigQVZ4TyCsL+A/1Jf/ACLUWRD1VLb7SwgNbH3vYRUaMDn
         uuUmo0ClAdhuizl0DO+v95GWTq6mGYbGug4vIo73RHAa8/s2Ns89bs/IBblGFQtXUcmX
         xFJaK9eksebHAvERevkA2Z7xkKPEbwf1OTT0RzqClj6WfLP6Dfm/caOYpdWnNERcM1Hi
         j9GFuan1uW6jwFV6GEdh9c7Dszvy2WNVdTZobL6wKNTPAi+buhGKaKoAiCXmCtdHz6ng
         pYZwjPwPaV4ykWDqf1fg9s5DP8Gt20IGK+lZU7EDupWaiUjWKotMZNmeon6sbr+s+8+6
         EMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085661; x=1790690461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=bFQ5mcgFkUiqvfJi7UwHcSI2Ks0peR7v+UaSAZtcRjPVdXHJAMvOpmvVt+dl092x3z
         R5B4iJf5xSJU/mIpZf6KvwQDc0wcppe8fxKVJupXgu/x8Dw/m3BBxI/P8aBKULug8h5m
         0WB7dH1/6uKqbeMxP7FvHhdGDU/twwFmLQBVy3z+4Aj+s6jdlnso9Bl7g7gzhucTBmkh
         NFvcBAOlon9kYMuX00liIC84dhBL2J1AJwjdGBKn++xsf1xqDfuAgGlV+ChoK8yl6nGK
         cRuCU+oLZULXN1mztYhnet4/+kdWg1ybEGmmrKmjoIndaCppPRkEhifeYHjaeB+8EQcg
         hgew==
X-Gm-Message-State: AFuF++kL6ouP6lEZgkvQir09PChT5c17Ug6umU1UKHjjS13wkO9jJg9n
	h06gdJCpzQCvkyE2ErpNxSoAWtbUOKhtsyDjEOlwwOXHvH6zwiSxX6zTPjC3CbUptndgoEC3SU3
	y9RUw/F7y/1Nh7+0YT2XcYYH/MuH0m55hOJ8qovkypSYpD8hd0PTBhsfiSxuHG94EcagZm+DsRY
	fuZQgwOWIzkcYojZ0cxZeqxgEQO88PSQOJSN1tkZVNtff6p3OQ8w==
X-Gm-Gg: AYBFou1l3SGOXmGz6nRianqGoMTva7htJAin0txqrLd8ll/42sqvEAoVZNeWD2f6iY5
	jGnHZfHYW7TkxaSSdWt4KbIU6PJnYcgqdjFngJjOa/31HJWLH5qzmhxSRfKkVasGkBoNES+m2xR
	bIFVusn3WKoriyYIEMtJhAyUC9l+LO9gE5F2gSeC0niNjy2sFM7gCA5qOjXHOcjgg2pXUuXG1gi
	pqV1CBs1zktd38i9wt0IjYSVe4/1INdyFhXSu3H48OqCipQFVML3BU/nGoIexrMPYNeXg0y94WP
	p96URENmwc0AVd+xoqjlLU9utKn3M1zi461C4bVvwTLr11nosy9DJbXkHHeP2ThPQdI8ytQwkdW
	Xpc2SxYNtEt+a6pv5DIScUK7m2YcPjOx0J2b61VLgDzPSlqHjjegi7BRL1N5JkETPCSuxZ+abpW
	nq8ZHCYPM2MExp4g==
X-Received: by 2002:a05:620a:4447:b0:93b:d7a2:83d9 with SMTP id af79cd13be357-93c15f328e5mr539001885a.72.1790085661064;
        Tue, 22 Sep 2026 07:01:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4447:b0:93b:d7a2:83d9 with SMTP id af79cd13be357-93c15f328e5mr538986485a.72.1790085658984;
        Tue, 22 Sep 2026 07:00:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:00:58 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 03/14] ceph: add BLOG page-fragment allocator
Date: Tue, 22 Sep 2026 14:00:36 +0000
Message-Id: <20260922140047.794405-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922140047.794405-1-amarkuze@redhat.com>
References: <20260922140047.794405-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add blog_pagefrag.c: lockless page-fragment buffer allocator for
per-task BLOG contexts.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_pagefrag.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 fs/ceph/blog_pagefrag.c

diff --git a/fs/ceph/blog_pagefrag.c b/fs/ceph/blog_pagefrag.c
new file mode 100644
index 000000000000..20f57082fdab
--- /dev/null
+++ b/fs/ceph/blog_pagefrag.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BLOG page-fragment allocator.
+ */
+
+#include "blog_pagefrag.h"
+
+/**
+ * blog_pagefrag_reserve - reserve space without publishing it
+ * @pf: pagefrag allocator
+ * @n: number of bytes
+ *
+ * Returns the current head offset without advancing. Caller writes, then
+ * blog_pagefrag_publish(). Single-writer (per-task).
+ */
+int blog_pagefrag_reserve(struct blog_pagefrag *pf, unsigned int n)
+{
+	if (n > pf->capacity - pf->head)
+		return -ENOMEM;
+	return pf->head;
+}
+
+/**
+ * blog_pagefrag_publish - make reserved bytes visible to readers
+ * @pf: pagefrag allocator
+ * @publish_head: new head (offset + bytes_written)
+ *
+ * Store-release so a reader that observes the new head (load-acquire or
+ * under pf->lock) sees the preceding entry writes. Single-writer.
+ */
+void blog_pagefrag_publish(struct blog_pagefrag *pf, unsigned int publish_head)
+{
+	/* Release-store pairs with the acquire in readers (pf->lock). */
+	smp_store_release(&pf->head, publish_head);
+}
+
+void *blog_pagefrag_get_ptr(struct blog_pagefrag *pf, u64 val)
+{
+	char *base = (char *)pf->buffer;
+	void *rc = base + val;
+
+	if (unlikely(rc < pf->buffer ||
+		     rc >= (void *)(base + pf->capacity))) {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+	return rc;
+}
+
+/**
+ * blog_pagefrag_reset - discard stored entries
+ * @pf: pagefrag allocator to reset
+ *
+ * Callers must ensure no writer is mid-reservation. The pagefrag is
+ * single-writer and writers do not take pf->lock.
+ */
+void blog_pagefrag_reset(struct blog_pagefrag *pf)
+{
+	spin_lock(&pf->lock);
+	pf->head = 0;
+	spin_unlock(&pf->lock);
+}
-- 
2.34.1

