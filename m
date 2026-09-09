Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FA5592E9
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958470; cv=none; b=H3PmGtOGdtvHgaivb7CPKjctQNIoRiYxr5Tpz8/ZSE05vYNjpO69ANSB95isJtL47/E4NKr/Ke/hwhg9yYHjGJ0+1fALWGoDygEuGYOYBfTElpFz68+3i78a//3TdbM75+vKolZDCWqlYJrGWVR37zGM6PbpbyXG/V/uf/J9Lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958470; c=relaxed/simple;
	bh=HcG+gf3kSIuA0s5TkzCfaMPDVJeDLtQgHdrgfTPrGJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPybPSB1TBoDZ7QL94a8c+bO/cGE7OFWOBY42/nSfFkhY+7Vkm06VzsFU/f2RiheGUJ8VTYObYLuN+Rq055ctYgoSe5aLn7YW7kRe4jnauGSTDgOoXh5SM77KtXQKp9mTCfBq5lKcicpEGMInSKNMHRcbmXxAe1uaUEocvkX/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de/foXQ3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnSxPZ2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de/foXQ3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnSxPZ2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
	b=de/foXQ3fvZ83Lm56s+ts+tvIrKjoVZrkb+PjeAju5QJXBaeEUQdTlYk52GzoGmnrlKjgW
	8t3d5Hfonxjq7u95bA3xB3SjqtTbRmtsh85GHkJuAZz0ABI7ha6bU737/hchAoxO82MeHk
	9SjVa0A+suZKy1liYRrT+NZDgy315f0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-pu65BxEmO6aKPxJF_btWdg-1; Wed, 09 Sep 2026 08:54:24 -0400
X-MC-Unique: pu65BxEmO6aKPxJF_btWdg-1
X-Mimecast-MFC-AGG-ID: pu65BxEmO6aKPxJF_btWdg_1788958464
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939665a1ae6so741390485a.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958464; x=1789563264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=GnSxPZ2CI+U4H4ldjvlIN6TW7bPymqg84k5rvcfb9uYjpbkHyNxWi98SXHEy/gWS7M
         +K6mSWQfjAvASW8cntLOsc4IBQnWXooOLaYlSahQT57uDqy7tqd0QWNS2JjIxXJwpjpW
         DC0jbB1/Km+RC+mo8zZZwpXRWCHwxPnF9uU5FAwHrK0vB2UpN5xstPPzEhpHBAKbaeGC
         E1iDwj+uF1lbEiDJO86d9P4bC+iRzhnfv+VIMkk9Dxr2OvBrSarlNEU9mP9jSCjArs6j
         0zYMe2UnoSZJIYtGzIBinJlUXtud8Sbtq89/yEg5KbWZFgwj1CdMnyj0UCcYbPABJD7t
         1D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958464; x=1789563264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=NRr+PVGm+rAbdpNG/dr78vonOAE/bljSAiFQf+s1cbIgIksOsVHr5H1Kp9h9QOcHtA
         CJP9bn8uUXw0CVrz8coIhTu+wtMlZcxxo1iF3902GKn0Wc0b/m+zfYbuoW5sZMjSLsxq
         CYXVytMklG7TpoF4yO+Wb7iDL0xG2QitdqhXp8F6zT9+GEq7phHuET3JnjrCS069cX4G
         1m5AFxU71tK462AJHOWHn6qUT7TxhCR9ogvr9efFvdOY1Huj+FY94Q8bd9aPb3mNqzla
         21e9rp2BbzEFvMLi9ZEGoNy1EVm7OyEvUBRITVsEjLHIWaaqCuFX/dcH3R56oVs1CUqC
         XCkQ==
X-Gm-Message-State: AFuF++kxFdqdhpsFFGalwWlbLpw5IkBBsUHo1VZ/l2de8l+WedPgQt5T
	VHM2fS6Utwz9URmlqFEtSY24wWPAkLXIYE1NdlSKu3FDU375BB87Po0bnO9g0Bx1CIXGRjzcewG
	QOHlzjDggA1RFqTtUrOlg5rNkXygjBgE2KZ7EgvRPVG5hu0lJTzA54CuMRO74xIxOWjlhtLkuYA
	++8F7lpjKH3M+8pyhcDLRYDA/YS+TVri11K245y1uKYVPln01vhA==
X-Gm-Gg: AYBFou21m7HeHm1q7xunmVTh+8pnHu6T0P+2wozC2Uk2On5od8WB+YybtGjl2Gq2tBA
	0OeYhjJ7Ss6aIgXnobPHF2GiwPbleZOQQmd9R2FpWilEplnjwptQ9H9RNDPi3yfiVVM7Cv6e1Ga
	23ebj3yYJGsyXGQnRP3WCBttzAQOn8RIJeiroRJvuS5d4uqdih/lcE1/ft71d/KDZqdedeI/mqc
	PT2QhYserp7qatmUa5negZ1/HWx6/WNIWfS2wC65aXNuaMK9+rBvsqn4ukLFX5XIjtTl4YUMpMV
	RSyF0rw8E60y1ensNQqSIG9yNH9SgjQsiIwEZgTffId+mIWFgIjnrx0J44AfHJ/hUsMXRAcZrNo
	ZpZPYOz0GSN5Sngvv+3HMrVaBQT7NfgOmTxD583lrSXD7NUyPYjcNQ+kONnNeq54Gsw/v8kvTSC
	ts9CMkqoK4ofsZmQ==
X-Received: by 2002:a05:620a:1b82:b0:939:a834:98f2 with SMTP id af79cd13be357-939a8349910mr2372039785a.15.1788958464166;
        Wed, 09 Sep 2026 05:54:24 -0700 (PDT)
X-Received: by 2002:a05:620a:1b82:b0:939:a834:98f2 with SMTP id af79cd13be357-939a8349910mr2372033285a.15.1788958463588;
        Wed, 09 Sep 2026 05:54:23 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:23 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 03/14] ceph: add BLOG page-fragment allocator
Date: Wed,  9 Sep 2026 12:54:05 +0000
Message-Id: <20260909125416.3969532-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909125416.3969532-1-amarkuze@redhat.com>
References: <20260909125416.3969532-1-amarkuze@redhat.com>
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

