Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554343A7587
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348735; cv=none; b=oqeAS1JrHvgJj1+9/pYGHLQN1RIBlnKZodfSDZzW1/sIWwkHipTf2UGHS1xuZZtgAduu7Ad8dQXfhg6ooogMaVNy9pD2skPXIbHn+KMXWIQXr0vIu3PyupT6/EGVPeMdcSaC7QCMpaA4S9+Ohl5sCuLmD+DPOnrRAO8h3aRSXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348735; c=relaxed/simple;
	bh=GVoW/u+EUYuUBRuepaFw62HU7Wzhz6FMAoZDVL+RUmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeSQbARUB9nBpempH5Ve0VTdEk2G8fr0Fb32xjG0JL7x8GupybUf0U76l3SHbjL/xB7QGqxgI5DhUYTUDC12Nd7YhlXwcxWxZHOyz1MRfbxtK+F2DwgIjtJ0cHrqmpeEQD0x2hpkh6Y4179i1QgU/qM0ahkacy4dn6+3Ri4J1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=criqTWsJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JM6bLpYn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="criqTWsJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JM6bLpYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCZaY2vdUqdR4Jx3U3Qimevn9xxJRMASlSBclQPdDeI=;
	b=criqTWsJmHqxDxY47+U266N9DS6QmFd04sBmkXJ6w370rMGfveS1wH8a15JQ+GFhyveMiG
	zYLANKpELv7s8Eew8RTsrTiZQ2MVSNTRCE3c+rI+tAS9IR4KRg1nfTaa+ke9e15ABD1Ogi
	LYU0Ahemk25k28gqUfqkPTgzJepusbg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-AeYmVCOiNv2g2gFZtCXRIg-1; Mon, 06 Jul 2026 10:38:50 -0400
X-MC-Unique: AeYmVCOiNv2g2gFZtCXRIg-1
X-Mimecast-MFC-AGG-ID: AeYmVCOiNv2g2gFZtCXRIg_1783348729
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c12d8e468b9so169484166b.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348729; x=1783953529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCZaY2vdUqdR4Jx3U3Qimevn9xxJRMASlSBclQPdDeI=;
        b=JM6bLpYn+rhrha051Yoy59YgVJ8vyLwSOsKOPW3uI9DftjAiERQyDqnbG3qTJPLJhX
         yMaPnJX8XdB4P95uNJN2bMwr52nnGFWYTuI6GO3wfedzV8CdiufUVLXzlHhqHhyb++W8
         JaZGya3jQ62lzbai5fQ7ZprwjcQDdEBiFLjnKJX/GMAC2aaae8w5OSSRyOJaxTisCfkt
         d74l793LsA7Rwf0pYBhZXLTs2M4zndJCWb+FhItcAw64lDnNggMzNQ+311H1vdXy1gcI
         yoRBHIbahNussN8KlrWnhZl/phk7w3AhhsLvevTkVqIAYJKKv3ndSmkgRH+UMNZGJkpb
         6vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348729; x=1783953529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCZaY2vdUqdR4Jx3U3Qimevn9xxJRMASlSBclQPdDeI=;
        b=LQSFUzcop7K4749EH5i6KuKneyn8fSHLf2ABrDvcEgEquLexLmjpdZGCx8hewim3QH
         huePkPVXBvVoO4E7WNGdlg6pYrFuXkJiU3+lEPA1/wcPE1K8JwgBNC0i+aKV13KdOxT6
         2hUiVDSgP9QNt5MdiLSN1+nbaz+Wf3p5o4UGhLaLtq6rV79Pq7bPzz7TG/JqY2mnOrsW
         NWT43GNiXKWxD4pUp3md2u7BVrm3BPKXgN5Y+snuAxQZm1msLSlX7cxzk0FZSBHHGet9
         IXB0+o03IZ82nl/C43/8H7k6pI2Oi9Yz6n24/MACzED571Z+K1ihEtf8ZtFEJJhWeybQ
         XivA==
X-Gm-Message-State: AOJu0Yw26NY/jklSSqQJvNHxcfdnp0O7NY9dsjEyFy5m021FE3qlibZn
	QVDxcqOzGONxmmuMiclFcd3TZF3Nbt6n5qfeRGqYFmOlAAIGMTpvV+MHhbjAwaQP1VmyHjkvZpu
	LmRVioeI06qURdah9ESXHjxlReNRkutNNTyur4i7vmn5yAv/fOt59zbicjyPw44dP/VvPvm5F8i
	FglwinQgI5MGTvAEE3JVeP/IZQdat6Dzs4RRatkja5zpN7BfzFGA==
X-Gm-Gg: AfdE7cmOP5uksir8OmDCG5U6Q/TIn8YVkjiBwNXlzzLnyY3lNht5irsYlm423CtfWVG
	Q1Gb3A13E2AQ1oStXKh/Yolfx1keGWeSAA5Nn/comH3ll/mCBlgecPowdjL16wX+gv/PvlvRLND
	Beg9nrhORVgSbMfVH31dYY8CQRANnkSUqV8Dwlw0kp0TU5h4z8JXVVyIjRlLrs+E6Ld43Sfo4Xx
	gtjoc2GF4uS5HbEYelaMuqtvLDhqZ0ukBO0Ifjq1+wiQhFRymIlhbRLN2/X+p40Z1jxBpuxCmGd
	sHps72vB2MEUCNRivkK8zcQDCsPNOV0Wwco+9S6LTukVmHevcUhvRkGM0gkiQCoYqSHIBwKtoTA
	e3aHXD9Zb40dordQ9YnDx8/HQm7EXrfCC9T6gqUMZyVtp
X-Received: by 2002:a17:907:e153:b0:c12:44b4:c8ae with SMTP id a640c23a62f3a-c15a689c4afmr32527866b.61.1783348729030;
        Mon, 06 Jul 2026 07:38:49 -0700 (PDT)
X-Received: by 2002:a17:907:e153:b0:c12:44b4:c8ae with SMTP id a640c23a62f3a-c15a689c4afmr32526266b.61.1783348728578;
        Mon, 06 Jul 2026 07:38:48 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:47 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 03/15] ceph: add BLOG page-fragment allocator
Date: Mon,  6 Jul 2026 14:38:31 +0000
Message-Id: <20260706143843.1980879-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706143843.1980879-1-amarkuze@redhat.com>
References: <20260706143843.1980879-1-amarkuze@redhat.com>
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
 fs/ceph/blog_pagefrag.c | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 fs/ceph/blog_pagefrag.c

diff --git a/fs/ceph/blog_pagefrag.c b/fs/ceph/blog_pagefrag.c
new file mode 100644
index 000000000000..bae88ea82aec
--- /dev/null
+++ b/fs/ceph/blog_pagefrag.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Page Fragment Management
+ */
+
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/ceph/blog_pagefrag.h>
+
+/**
+ * blog_pagefrag_reserve - Reserve space in the pagefrag buffer
+ * @pf: pagefrag allocator
+ * @n: number of bytes to reserve
+ *
+ * Checks if there is sufficient space and returns the current head offset
+ * WITHOUT advancing the head pointer. This allows the caller to write data
+ * before making it visible via blog_pagefrag_publish().
+ *
+ * This is lockless - only one writer per pagefrag (per-task context).
+ *
+ * Return: offset to reserved memory, or negative error if not enough space
+ */
+int blog_pagefrag_reserve(struct blog_pagefrag *pf, unsigned int n)
+{
+	if (n > pf->capacity - pf->head)
+		return -ENOMEM; /* No space left */
+	return pf->head;  /* Return offset without advancing */
+}
+
+/**
+ * blog_pagefrag_publish - Publish reserved space by advancing head pointer
+ * @pf: pagefrag allocator
+ * @publish_head: new head value (offset + bytes_written)
+ *
+ * Advances the head pointer to make previously written data visible to
+ * readers.  Uses store-release so that any reader that observes the new
+ * head value (via load-acquire or under pf->lock) is guaranteed to see
+ * the preceding entry writes.
+ *
+ * Single-writer per pagefrag (per-task context).
+ */
+void blog_pagefrag_publish(struct blog_pagefrag *pf, u64 publish_head)
+{
+	pf->alloc_count++;
+	pf->active_elements++;
+	/* Release-store pairs with the acquire in readers (pf->lock). */
+	smp_store_release(&pf->head, (unsigned int)publish_head);
+}
+
+/**
+ * blog_pagefrag_get_ptr - Get buffer pointer from pagefrag reserve result
+ * @pf: pagefrag allocator
+ * @val: return value from blog_pagefrag_reserve
+ *
+ * Return: pointer to reserved buffer region
+ */
+void *blog_pagefrag_get_ptr(struct blog_pagefrag *pf, u64 val)
+{
+	char *base = (char *)pf->buffer;
+	void *rc = base + val;
+
+	if (unlikely(rc < pf->buffer ||
+		     rc >= (void *)(base + pf->capacity))) {
+		pr_err("%s: invalid pointer %llx\n", __func__,
+		       (unsigned long long)(uintptr_t)rc);
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+	return rc;
+}
+
+/**
+ * blog_pagefrag_reset - Reset the pagefrag allocator
+ * @pf: pagefrag allocator to reset
+ *
+ * Resets the head pointer and counters to the beginning of the buffer,
+ * discarding all stored entries.
+ *
+ * Context: Callers must ensure that no writers are active on this
+ * pagefrag before calling reset. The pagefrag is single-writer and
+ * writers do not take pf->lock, so resetting while a writer is mid-
+ * reservation corrupts state. In practice this means the owning task
+ * must have finished its current blog_log() / blog_log_commit() pair.
+ */
+void blog_pagefrag_reset(struct blog_pagefrag *pf)
+{
+	spin_lock(&pf->lock);
+	pf->head = 0;
+	pf->active_elements = 0;
+	pf->alloc_count = 0;
+	pf->last_entry = NULL;
+	spin_unlock(&pf->lock);
+}
-- 
2.34.1

