Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48F442FA2
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230596; cv=none; b=jAcY+cDfB4qiEA7pSTr6q5Mrx8bCjCz4VmV8Yf9rygqT1qj7+hiSOjCB+gNCCTbPtS0dtoNtaYgqB5ToptRgw5NUyz9Jz/7AqXcj374JRqCxswy2bgi/YQTUoIbos0DGqCln0nU5BN5f6I0Uc94C1F/5JY1dFmCTM+xA669n3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230596; c=relaxed/simple;
	bh=p3tIgysxFJmViVV2AzzNGt+i6YlCJfXwyLGKQGkdJxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipo0LbstIPQdyliAU/O8Pc/PutBT4vmNQIsTTbE1VA4PnHQSE9/IiUlCdC5/nDHnLTB2VrMBrayHsdM3wDOFoGGgD6Zb7/EzIOCVbf/LdDZ2PBDmwzsn83qXeFSKlYRb3CIYTnPvTGkSUnAG93aQsBQgUG490M0hx0rHb0xg+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpwlP4cL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k40eW+W2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpwlP4cL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k40eW+W2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy+ZuDQJIzeLbYbgr5kiLpkquq0EWlhUoqxu6zu3ONI=;
	b=RpwlP4cL1oeyohcIuetFRU0rG4BqAoGjmrj+h81X80qPZC7HNAw0DuKKMMKX69qCzzWtUy
	KOiNHlxSDBwas3hvFrurXhoMh9LZbi2h0ZH+ZV9jp4G19Wv4b7XOaKniSKf3sf36jeRASN
	HvFHfx2h5b/Fo+fDvyOzdy9hAGHFlxQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-oK57t2n6Nla68_zQjufBsA-1; Thu, 20 Aug 2026 08:56:25 -0400
X-MC-Unique: oK57t2n6Nla68_zQjufBsA-1
X-Mimecast-MFC-AGG-ID: oK57t2n6Nla68_zQjufBsA_1787230584
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a18e611c82so2491673a12.2
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230584; x=1787835384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fy+ZuDQJIzeLbYbgr5kiLpkquq0EWlhUoqxu6zu3ONI=;
        b=k40eW+W2yZBTfYrykjLCMO+D90k5X/JOYDBSkf2coTC660hIcpii+iWWwVXBdg/TCJ
         fV3at3+u3Q5YnT3yZ7hqHvbeq0qwxw+WOmRnEH+ViDyXZHvW1w/SxX5L2mpO6obDOgwR
         jH+pzqzU54zpul613sdiA6H7V9L3P3Nwg+hlYrLmTHa0GVn7vk5gSse5u2cv8Bn8yCQG
         O4dtT8WdCdURjwHbnIzB2y0/pkCIZzr7BMSiWpZMyNhF+Wxx+v11IXC8ppAF9P/j6SSc
         Bbj35d4y8dtp9hh3QcbpJ+vlNNRTuDpylE0Or0HlzQsAXhLk4d0y48cQCPDeDLQ3UAEh
         CcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230584; x=1787835384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fy+ZuDQJIzeLbYbgr5kiLpkquq0EWlhUoqxu6zu3ONI=;
        b=QNK54eJqP+hY1tg8I67hQiXB6ZtM2aU75d5wYkQSmaQBug9blLy2tUylGkiwIeXOiz
         5KuicdHCblEuvYa6LSFh5x9FG+U1RXAeNmVwnBax8CeP9AdYyhnpRE7IGjO9lQvtdyow
         Nz/Lskmtw8ULJQnLSXWCK2VRy0Y2YNT6X1iI9egpLDpFJpTp+rWXFm7QOHIOAosQeKAZ
         iJtAXUIwtHzn5v9L2XA0M7XLsV2141hwD95VyCJfSMM2NbSS7O/ZmwoLSc7I06v7iQ81
         pLNcxK/MnvRHoB8E+crlo+KXuFZYUJ81fzQIVIFchNKhW0DcGHlD5pYvUsVQREkmPLgd
         3Icg==
X-Gm-Message-State: AFuF++mszHrChFSQ2kKtDPsI1tBxmhnp+t/F/Wp8OWIGxIxJEmwbkDZe
	2IBd2tTyqxNCKpvq0rbDurmcE8HPgqqqn0okjDu8k31NvaeVMQdvMcAjsIka2piwDC8vEtWxdcw
	laNeqc+77mqWMWosZONKzNKsd3tOkgHEbm7xRDSRqe+R4DkIKjXhrWo1X6L7CyRiudABbaq62eG
	9KyWNOfJXM4wZnzSkDYNho6sY4cezpj/CAEaPOzgYvaaiUrniuNg==
X-Gm-Gg: AR+sD11Dwh6g1prsGmtjon1eHLhqN1gpmV2Tfl3QT9EUJGvBV/fTUxlc3IeQ7mwGpIV
	9UOm6LLzlWJep61bEuuftcjcydVbmdSt6yQF6VM29gduReCssXkoKvnKaUOuMJglhUNlnVWlk0J
	LNXcUfSCqVhWNFtPSYj1m+crPDYvXcDSXIx1P/n/5e9B1BGfuc28NOZ6PEhWhx2wgTXhw3G+W7l
	zKswdQk0DNOPjwqwhT7Mxdlc6r+llAI9w5cCG88dNboNyKlyoxdLxpMuv0JHdl4LWco5WiJ7f3t
	aDhSy2dZ6j+Jr4rBeSAt24xVqKhBJVNDPYBrQilEx+fibj++VP5V5Uipe7WDMGGTxAN/YVpOeVr
	b/+u715FY9VPESxlB1pSpJpW4XI5i3tVtxA==
X-Received: by 2002:a05:6402:5010:b0:698:3469:fa99 with SMTP id 4fb4d7f45d1cf-6a4031e6834mr9454169a12.0.1787230583747;
        Thu, 20 Aug 2026 05:56:23 -0700 (PDT)
X-Received: by 2002:a05:6402:5010:b0:698:3469:fa99 with SMTP id 4fb4d7f45d1cf-6a4031e6834mr9454117a12.0.1787230583238;
        Thu, 20 Aug 2026 05:56:23 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:22 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 04/14] ceph: add BLOG magazine batch allocator
Date: Thu, 20 Aug 2026 12:56:07 +0000
Message-Id: <1e98829cd8925d4051a735ba37bc36f4dbdb7cf8.1787229471.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787229471.git.amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add blog_batch.c: per-CPU magazine batching for TLS context recycling.
Freed composites go to a local magazine; subsequent acquisitions reclaim
from the magazine, making the common-case log path allocation-free.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_batch.c | 307 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 307 insertions(+)
 create mode 100644 fs/ceph/blog_batch.c

diff --git a/fs/ceph/blog_batch.c b/fs/ceph/blog_batch.c
new file mode 100644
index 000000000000..a4407d144c17
--- /dev/null
+++ b/fs/ceph/blog_batch.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Batch Management
+ *
+ * Magazine-based batching for efficient object recycling.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/vmalloc.h>
+#include "blog_batch.h"
+#include "blog.h"
+
+static struct blog_magazine *alloc_magazine(struct blog_batch *batch, gfp_t gfp)
+{
+	struct blog_magazine *mag;
+
+	/* Allocate magazine structure from cache */
+	mag = kmem_cache_zalloc(batch->magazine_cache, gfp);
+	if (!mag)
+		return NULL;
+
+	INIT_LIST_HEAD(&mag->list);
+	mag->count = 0;
+	return mag;
+}
+
+static void free_magazine(struct blog_batch *batch, struct blog_magazine *mag)
+{
+	int i;
+	struct blog_tls_pagefrag *composite;
+
+	/* Free all composites in this magazine before freeing magazine itself */
+	for (i = 0; i < mag->count; i++) {
+		composite = mag->elements[i];
+		if (composite)
+			kvfree_atomic(composite);
+	}
+
+	/* Free the magazine structure itself */
+	kmem_cache_free(batch->magazine_cache, mag);
+}
+
+/**
+ * blog_batch_init - Initialize the batching system
+ * @batch: Batch structure to initialize
+ * @mag_cache: Slab cache for magazine structs, or NULL to create one
+ * @nr_prealloc: Number of composites to preallocate (0 = none)
+ * @retain_limit: Max composites to retain on put; excess are freed (0 = unlimited)
+ *
+ * Allocates and initializes the per-CPU magazines and global pools.
+ * Composites are allocated via kvzalloc() in BLOG_MAGAZINE_SIZE
+ * batches.  Pass nr_prealloc = 0 for batches that start empty
+ * (e.g. the log_batch).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int blog_batch_init(struct blog_batch *batch, struct kmem_cache *mag_cache,
+		    unsigned int nr_prealloc, unsigned int retain_limit)
+{
+	unsigned int nr_mags, i, j;
+	int cpu;
+	struct blog_cpu_magazine *cpu_mag;
+	struct blog_magazine *mag;
+	struct blog_tls_pagefrag *composite;
+
+	/* Initialize counters */
+	batch->nr_full = 0;
+	batch->nr_empty = 0;
+	batch->retain_limit = retain_limit;
+
+	/* Use caller-provided cache or create one */
+	if (mag_cache) {
+		batch->magazine_cache = mag_cache;
+		batch->external_cache = true;
+	} else {
+		batch->magazine_cache = kmem_cache_create("blog_magazine",
+						       sizeof(struct blog_magazine),
+						       0, SLAB_HWCACHE_ALIGN, NULL);
+		if (!batch->magazine_cache)
+			return -ENOMEM;
+		batch->external_cache = false;
+	}
+
+	/* Initialize global magazine lists */
+	INIT_LIST_HEAD(&batch->full_magazines);
+	INIT_LIST_HEAD(&batch->empty_magazines);
+	raw_spin_lock_init(&batch->full_lock);
+	raw_spin_lock_init(&batch->empty_lock);
+
+	/* Allocate per-CPU magazines */
+	batch->cpu_magazines = alloc_percpu(struct blog_cpu_magazine);
+	if (!batch->cpu_magazines)
+		goto cleanup_cache;
+
+	/* Initialize per-CPU magazines to NULL (magazines allocated on-demand) */
+	for_each_possible_cpu(cpu) {
+		cpu_mag = per_cpu_ptr(batch->cpu_magazines, cpu);
+		cpu_mag->mag = NULL;
+	}
+
+	/* Pre-populate magazines with composites */
+	nr_mags = DIV_ROUND_UP(nr_prealloc, BLOG_MAGAZINE_SIZE);
+	for (i = 0; i < nr_mags; i++) {
+		mag = alloc_magazine(batch, GFP_KERNEL);
+		if (!mag)
+			goto cleanup;
+
+		for (j = 0; j < BLOG_MAGAZINE_SIZE; j++) {
+			composite = kvzalloc(BLOG_TLS_PAGEFRAG_ALLOC_SIZE,
+					      GFP_KERNEL);
+			if (!composite) {
+				free_magazine(batch, mag);
+				goto cleanup;
+			}
+			mag->elements[j] = composite;
+			mag->count++;
+		}
+
+		raw_spin_lock(&batch->full_lock);
+		list_add(&mag->list, &batch->full_magazines);
+		batch->nr_full++;
+		raw_spin_unlock(&batch->full_lock);
+	}
+
+	return 0;
+
+cleanup:
+	blog_batch_cleanup(batch);
+	return -ENOMEM;
+
+cleanup_cache:
+	if (!batch->external_cache && batch->magazine_cache)
+		kmem_cache_destroy(batch->magazine_cache);
+	return -ENOMEM;
+}
+
+/**
+ * blog_batch_cleanup - Clean up the batching system
+ * @batch: Batch structure to clean up
+ *
+ * Frees all magazines and composites, and destroys the magazine cache.
+ */
+void blog_batch_cleanup(struct blog_batch *batch)
+{
+	int cpu;
+	struct blog_magazine *mag, *tmp;
+	struct blog_cpu_magazine *cpu_mag;
+
+	/* Free per-CPU magazines */
+	if (batch->cpu_magazines) {
+		for_each_possible_cpu(cpu) {
+			cpu_mag = per_cpu_ptr(batch->cpu_magazines, cpu);
+			if (cpu_mag->mag)
+				free_magazine(batch, cpu_mag->mag);
+		}
+		free_percpu(batch->cpu_magazines);
+	}
+
+	/* Free magazines in the full pool */
+	raw_spin_lock(&batch->full_lock);
+	list_for_each_entry_safe(mag, tmp, &batch->full_magazines, list) {
+		list_del(&mag->list);
+		batch->nr_full--;
+		free_magazine(batch, mag);
+	}
+	raw_spin_unlock(&batch->full_lock);
+
+	/* Free magazines in the empty pool */
+	raw_spin_lock(&batch->empty_lock);
+	list_for_each_entry_safe(mag, tmp, &batch->empty_magazines, list) {
+		list_del(&mag->list);
+		batch->nr_empty--;
+		free_magazine(batch, mag);
+	}
+	raw_spin_unlock(&batch->empty_lock);
+
+	/* Destroy magazine cache */
+	if (!batch->external_cache && batch->magazine_cache)
+		kmem_cache_destroy(batch->magazine_cache);
+
+	batch->magazine_cache = NULL;
+	batch->external_cache = false;
+}
+
+/**
+ * blog_batch_get - Get an element from the batch
+ * @batch: Batch to get element from
+ *
+ * Return: Element from the magazine, or NULL if none available
+ */
+void *blog_batch_get(struct blog_batch *batch)
+{
+	struct blog_cpu_magazine *cpu_mag;
+	struct blog_magazine *old_mag, *new_mag;
+	void *element = NULL;
+
+	preempt_disable();
+	cpu_mag = this_cpu_ptr(batch->cpu_magazines);
+
+	/* If we have a magazine and it has elements, use it */
+	if (cpu_mag->mag && cpu_mag->mag->count > 0) {
+		element = cpu_mag->mag->elements[--cpu_mag->mag->count];
+		goto out;
+	}
+
+	/* Current magazine is empty, try to get a full one */
+	old_mag = cpu_mag->mag;
+
+	/* Return old magazine to empty pool if we have one */
+	if (old_mag) {
+		raw_spin_lock(&batch->empty_lock);
+		list_add(&old_mag->list, &batch->empty_magazines);
+		batch->nr_empty++;
+		raw_spin_unlock(&batch->empty_lock);
+		cpu_mag->mag = NULL;
+	}
+
+	if (READ_ONCE(batch->nr_full) > 0) {
+		/* Try to get a full magazine */
+		raw_spin_lock(&batch->full_lock);
+		if (!list_empty(&batch->full_magazines)) {
+			new_mag = list_first_entry(&batch->full_magazines,
+						   struct blog_magazine, list);
+			list_del(&new_mag->list);
+			batch->nr_full--;
+			raw_spin_unlock(&batch->full_lock);
+
+			cpu_mag->mag = new_mag;
+			if (new_mag->count > 0)
+				element = new_mag->elements[--new_mag->count];
+		} else {
+			raw_spin_unlock(&batch->full_lock);
+		}
+	}
+out:
+	preempt_enable();
+	return element;
+}
+
+/**
+ * blog_batch_put - Put an element back into the batch
+ * @batch: Batch to put element into
+ * @element: Element to put back
+ *
+ * Return: true if the batch retained the element, false otherwise
+ */
+bool blog_batch_put(struct blog_batch *batch, void *element)
+{
+	struct blog_cpu_magazine *cpu_mag;
+	struct blog_magazine *mag;
+	bool stored = true;
+
+	/* Trim: if over retention limit, decline to store the element */
+	if (batch->retain_limit &&
+	    READ_ONCE(batch->nr_full) * BLOG_MAGAZINE_SIZE >= batch->retain_limit)
+		return false;
+
+	preempt_disable();
+	cpu_mag = this_cpu_ptr(batch->cpu_magazines);
+
+	/* Optimistically try to add to current magazine */
+	if (likely(cpu_mag->mag && cpu_mag->mag->count < BLOG_MAGAZINE_SIZE)) {
+		cpu_mag->mag->elements[cpu_mag->mag->count++] = element;
+		goto out;
+	}
+
+	/* If current magazine is full, move it to full pool */
+	if (likely(cpu_mag->mag && cpu_mag->mag->count >= BLOG_MAGAZINE_SIZE)) {
+		raw_spin_lock(&batch->full_lock);
+		list_add_tail(&cpu_mag->mag->list, &batch->full_magazines);
+		batch->nr_full++;
+		raw_spin_unlock(&batch->full_lock);
+		cpu_mag->mag = NULL;
+	}
+
+	/* Get new magazine if needed */
+	if (likely(!cpu_mag->mag)) {
+		/* Try to get from empty pool first */
+		raw_spin_lock(&batch->empty_lock);
+		if (!list_empty(&batch->empty_magazines)) {
+			mag = list_first_entry(&batch->empty_magazines,
+					       struct blog_magazine, list);
+			list_del(&mag->list);
+			batch->nr_empty--;
+			raw_spin_unlock(&batch->empty_lock);
+			cpu_mag->mag = mag;
+		} else {
+			raw_spin_unlock(&batch->empty_lock);
+			cpu_mag->mag = alloc_magazine(batch, GFP_ATOMIC);
+		}
+
+		if (unlikely(!cpu_mag->mag)) {
+			stored = false;
+			goto out;
+		}
+	}
+	/* Add element to magazine */
+	cpu_mag->mag->elements[cpu_mag->mag->count++] = element;
+out:
+	preempt_enable();
+	return stored;
+}
-- 
2.34.1

