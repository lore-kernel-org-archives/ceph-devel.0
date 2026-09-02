Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6A4AA3FC
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366490; cv=none; b=Dw11eu1YPaNwL/STPCDHWYj2gfEbPAXoBTEbHt1Fk8dsV5WOAdlzsubp00VGee+hkcjFwDW5SbWwodWRs/dxci+sjR1DY3VrhG//OW7NhNo+dgpbH1lw3bg4jJChXek7ywbKohkAU4iKb2beHP28VlOedeKoOIJgG8nZuYKfbL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366490; c=relaxed/simple;
	bh=HcG+gf3kSIuA0s5TkzCfaMPDVJeDLtQgHdrgfTPrGJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNCoFVPdfqIHZXg0eu/IpEoGOhVwRMAzVNrS0tnR3X+jndFl+0GfKQN4YijG6vMqkdKpIahY2YVPTG5tNYDG9hNZZ6CPEdX0lpey9gzE1JOvJn3JssKHiQVvIW7cacG3QrmVxQedWhtOh6Ar1JewrHQEmtyjWQfZYRroD+8KZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3QuqvJc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o5/zI2nZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3QuqvJc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o5/zI2nZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
	b=L3QuqvJcfeFTgzcQ8EEW2oYfbzgzpu6FVpF7Tpjt/KIMnPjZ74Gf25+YHL/boxLzv6kwJ6
	EEF1OIMrQmF7ypgv2Lk9I8kfT/7zrXb0SOOsl7QKf2fCGXpCWTEJQOpzb8Hq5wlOSn4tTB
	4JbwPOiJ14BeJR/oBQwhqGNdhEbN0w4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-cDmEaa71PYy1XQpK4mowtA-1; Wed, 02 Sep 2026 12:28:06 -0400
X-MC-Unique: cDmEaa71PYy1XQpK4mowtA-1
X-Mimecast-MFC-AGG-ID: cDmEaa71PYy1XQpK4mowtA_1788366485
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c253185765dso134182066b.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366485; x=1788971285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=o5/zI2nZTj8eBA+kHq9/QpLCdDe/aIK6RQfLoFA4AwnC1oAEmefj58JB2PZPEYczY3
         gPgKUqGGI8jneDIvcOiOzcwSZa1/pFoMIrXqyEyb5z6PDfwImpG4SVzpWipaiBu9nlDa
         Ov4X7bKzCaK7OKNNR+X6drmY9O9RXHp2LKhq2MdsU89DAMODtIBOx+03tZAPEZEa0S9R
         ZtcbdG3s9CUYfHoaAf0WRTFZOLGGoefSLdD9G5EMJzFaUL4RPbkboK15FEliWsWRg2+h
         3UnZNqXEaDhJ7V+HyLA/f+da6+u1fpzgHmpkh8P3H7N1TIG28ql7yJbPZey81Zbbv9fO
         Nsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366485; x=1788971285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=rQPHKgJiPy6d87wZA91Pe06lmJhAnM676y62Q6cS5o0xJtMrUJg/NnjzF9v0wqwIsQ
         bu8WEIR1VT9CUdmvAgv6GCyCyaJT76dROoxJ2EFUXVdhpI3xv5CeR41DOH8FED6ocNJt
         Im7MwH5wYqz4rntVqeEPepADN8G30PJXPNbtg3HNIIxBK9hIzCx7/C1ocFsejBAamUXm
         XaPJv9yGBIb9fcGtnjq4tXwEzAw9GRxdRPZKUkw94JY2nGwDWwG3Dd1q28CZWK9FGDva
         HI0wWj1pWGhTZxH1WYQM55zKfv+puhQZblV8lrMjSrFUnfQX6qfSiQqWHZpiPstVrcZW
         r/Rg==
X-Gm-Message-State: AFuF++njRDMhgrs9mHyIoKWFCpFdQwoYclN2O2uIniodOEAr+ekj0VHL
	7nUble0sQm2doqhBiR0N9OUSZZov6l6fJyfF5iRmNp61BDr9WjSeIDAOFpwBC5vylQs1ddYaIre
	/MRA4ou8vUU5FSZfX82meHJx2orn3wt5VxxwBfp1Kf1CtTWzARptvfTY1V+my+8Yw9/67kLDopd
	jKburGZE5+20eDFiSEzdqvCrldKEHTip1Z4LKRZJ7bLO/4QlpFmQ==
X-Gm-Gg: AYBFou3gK37OTDnCs/Gd7oBsYQFYWvGjvSuSN0iEalT8VOsfZByXC7IzsVHe9PV55n/
	3C0Iie12xcRSoPSHb49qY8svDdx/Xcn48w4JVeRCpQNFnFVAybEUoQnoO9Mxwye0nGfN1nOd0yA
	04nwhpsn5GUqmvWkcxMyO8wR4NmMlQpWHCeuh74l+7Jz1pYINUTLmprDHyyogecZRh8tbrWlLJD
	UVECoIZFoi4crUYWC5IEJVC4UsYkh2IvBf7zz/9PCdcVqfGERtCV/Nid0ya0E8EICzdxVlSfqtC
	hVkclAdITEWCDO2SyPB58Gbmwc0zlqHMM3O0ESC6/ICpDSbQjg83q/rJSxATHyWBG14LY4Ulpqk
	1YcnI+dgn5lVLG3rcv3KHBD4Dnwmi05R53wTdzCuJWpokaYTz3+5GygEVcaxQBiedVZKD9PiJNO
	VQeqDRhE0w0Mzh1Q==
X-Received: by 2002:a17:907:7209:b0:c25:833d:383e with SMTP id a640c23a62f3a-c25d549302cmr417152866b.13.1788366485121;
        Wed, 02 Sep 2026 09:28:05 -0700 (PDT)
X-Received: by 2002:a17:907:7209:b0:c25:833d:383e with SMTP id a640c23a62f3a-c25d549302cmr417150066b.13.1788366484491;
        Wed, 02 Sep 2026 09:28:04 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:04 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 03/14] ceph: add BLOG page-fragment allocator
Date: Wed,  2 Sep 2026 16:27:49 +0000
Message-Id: <20260902162800.3197342-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902162800.3197342-1-amarkuze@redhat.com>
References: <20260902162800.3197342-1-amarkuze@redhat.com>
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

