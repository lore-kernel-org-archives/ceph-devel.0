Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3F4AA01D
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365080; cv=none; b=CO2FJ+S85MXd8a4S+ToKk+Bk0XRM2+n5Zmm5gsETEZwdslEdYWj6976W2A+umwSz5Be7WBROLO0aYF9ehs0MEKftT/6slTkAMONBGuEpFWkAqSeBchKDnvERgxu+WGp9E3YT02fQLddRKVgb0UaEniYnyy2ilkqQpvjMMcY0IQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365080; c=relaxed/simple;
	bh=HcG+gf3kSIuA0s5TkzCfaMPDVJeDLtQgHdrgfTPrGJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1aAYPJdzOuihhdXmCJXyITKjqMfHwo3f1KDNycfYlFy/D6Eyv2L4tWwg7WHMX6OIrIx61E7Y43rEmMWpqDCFVcEjAeXQJalKeZk8+GiDRFUrVRwqbz/N16ybe5Bq2XDlbwUhoery0jSKElyvBOI1J8MsIDjmhrVjxY3KkHRPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVxZdTQ+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeyHWNPS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVxZdTQ+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeyHWNPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788365077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
	b=DVxZdTQ+XBa71Sw+gC7TNVGeLNaVdlhXGqZntV02K1YStE8D5oWXx2jEOXvKD6g3CXBSMj
	PHhzXdAY3mR+bMA/g2BjNqVe3wLmDMuR423z2hvoglV4b17Y/JyozBeM0D8xVHe2zxiTxS
	70pvCa6AsrFCNKGVrwyHpa3Hf+Q1SIE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-KVgzfS-lNcKaacdG9rdhjA-1; Wed, 02 Sep 2026 12:04:34 -0400
X-MC-Unique: KVgzfS-lNcKaacdG9rdhjA-1
X-Mimecast-MFC-AGG-ID: KVgzfS-lNcKaacdG9rdhjA_1788365073
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c232fa136so4303166b.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788365054; x=1788969854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=YeyHWNPSH3rSNYa94ztvmxW3uPHDks52bVY3JQViMSOY+RTJY80OwTWPnr1TWxqcTi
         xotoTbq7wTIUfwIG5fqx7R5OuEIv5fRba/2A/A4nHkOWAzs0OAA8/GapByCS8ajWBszI
         SpH81BgGkkqn/HCVkm510dm9gtJeZTwCuPxZloLSHBokfuAd0pDQx0L+pPPwA1GgBt/3
         XUtrsr0lSfSMCbfw6mw1DKqyM/X6bHBgTfXx9rDs6RxZYGpUlNLOONj0aMYaP/1pk72y
         jaJO/wo0Zrfa9Qsp4+jYokB7QYRsSNxeYNNbhGfhslrtELEhigx1qv8PFbbTDoIgPqpF
         xKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365054; x=1788969854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=e9APDeV7kwTrgFfolRfXTb62yoN1S7IrlMxk0Nmtr0uq+/maQNcP33C1m43S7ExIRC
         bv2avunJk0b0wnMuXrfBsFwsURU9APspQ0rN80Z5zhHoUVUJEThuhRkFYZYeipAWT4mR
         O7YoV0EcT9L2pt4lEIv/3Q460GvtpztEBY1adYqs/I7dv8DhhW+FhbLDkz4IEbU8oOXW
         j66/hOwuMf7zWRQsJRwRxdCOdPZjyiJf5lv2KXkNbmsk1oGf0om53Xd33tQpbP7HajSe
         OYSylke1064nvgKqbc0/g/XWJA0GEODC5eRX1yr4PNZiBSZ4aluqlY5ORJZcrqRpYdpM
         Y6gg==
X-Gm-Message-State: AFuF++kpLcklYnoiHF3jPWmV7LPLMByf8PWC7qjmdOeFdBDrnZjl8Oil
	VLzOmBvr39aRe5XEOubGbxdCJSDTXK6xGt7GFl3M0IEWOMkdEswfw0z/yWDwp7op7TF6sBQAFuQ
	pFmuHtv1I8z4q0zLkhdk/Hr0M1xs8i5NZ8sZ2wZbSIM2rt0Ecn9b1kcF00uqGTTKEoDvFBNp0hN
	KiBpJNp2KFpjG+xXDUGzxUxf7tK5N+3g0Gh9+gW+bvs0rXxDE=
X-Gm-Gg: AYBFou0F/lJqQA5DtCT9Q+Fxc5AYsFb1sSy/7ZjI+khQMnqUUyDGrp4B+tB5yK38g+6
	ywjX9YkmRoBIesxNHmTJxJnwGvsOlHdZS3pN0HK8aRYY06IurMXGHK5xCVxSHaov7fyxBpRm81a
	C5l/E9IaQJJh2MIBqYTpaL84N+Q5VaSkrrIW1sByvsRPqH/vU44sktrIVXTJJehz4jgIYSIq1R3
	iqmfoo+hWO+vnHwHj1oWdpnilHAURLzzDXW+AbKgWHrUKtn/KrG7W3YEwwC8Np3NWg87T6kbA3s
	VF0mTuBqF7P0XiRgvq3XC5bZ/mULujELYVszPso5SU0ex1TE80yrEWDjMHG5NLN3S+ObTYln6QD
	fnMtTPKqSOz9WoDu2Eh2CPHu+ksxps3Ivdl1Q8ffCb9CADDRLwbdMAJHf+wYTVfVgsRl0MEUbYB
	3Zz/0f2WP/F35DNg==
X-Received: by 2002:a17:907:3f22:b0:c15:a7b9:2ae1 with SMTP id a640c23a62f3a-c25efe07ea0mr18836666b.6.1788365053836;
        Wed, 02 Sep 2026 09:04:13 -0700 (PDT)
X-Received: by 2002:a17:907:3f22:b0:c15:a7b9:2ae1 with SMTP id a640c23a62f3a-c25efe07ea0mr18827566b.6.1788365053312;
        Wed, 02 Sep 2026 09:04:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7108sm165874566b.10.2026.09.02.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:04:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 03/14] ceph: add BLOG page-fragment allocator
Date: Wed,  2 Sep 2026 16:03:56 +0000
Message-Id: <20260902160407.3196013-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902160407.3196013-1-amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
 <20260902160407.3196013-1-amarkuze@redhat.com>
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

