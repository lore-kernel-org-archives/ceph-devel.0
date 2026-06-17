Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7C4657C4
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708408; cv=none; b=N2c4jDRs+Jm8sjQB3qn6icVYa9IRVlHGjFPMAvTVpKrp1XqifdROLbOgV0oxn4hUbVLsbd2gFcxEGaGDDWMfkQ8O9mJUnxSprWb5O5ewQhjMlrowc9C6/GxgWWgDX9u3yJBn+z13XX/2s6f1ETkYEdXzUIUfNJ2TA8ubbDh5RJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708408; c=relaxed/simple;
	bh=Ge+xREHUzIFAv2iPytGrM9yk8EOae86kjSKYEnSjBhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9GzpeW/k8r1Jf+CRSZNqGU7X8KqAxj6XUx8cylHeGz8NK+6mAQ476HoLfNmDCzEwa+HJ3iSL/Tofp5D/2TG1T0a9zk/274E+0dBoqnETe3ayhwa0t9IPcyrVhqdRZR9jcJFC58ejfRAW70ilfbg60+96MVutHfnIx6ACfGsFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbDkXAiP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rR7gcA23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbDkXAiP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rR7gcA23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VU6bNGDdp0rI3WsqzTKPr7JfkwiW3hoSy7BhvGfIckI=;
	b=IbDkXAiPGl9g5ISVX7jn8d96QBWvxcj8jqHTKz6i5lG8EqGvqwebpOmII1KtXVbAMs614N
	ttWLUXN9QCN/vaS0rBthnTvo0indT3Bz25phvtEf2qRFahaefIP2LE16LwUqsx84OudTUN
	V4Gnqwi1y9LxsiqAlgKqGb7lItuP/qg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-n-StsN10MeqJAF4wrPy_Jg-1; Wed, 17 Jun 2026 11:00:03 -0400
X-MC-Unique: n-StsN10MeqJAF4wrPy_Jg-1
X-Mimecast-MFC-AGG-ID: n-StsN10MeqJAF4wrPy_Jg_1781708403
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6ec7ce0b2so4540277a34.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708403; x=1782313203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU6bNGDdp0rI3WsqzTKPr7JfkwiW3hoSy7BhvGfIckI=;
        b=rR7gcA23KGHzHPMb57PLWVgMFe8qiOkd+DYK9G6egwhMIm7bnhswNZRytdu8gbERZm
         KA1ZcGM1Lkxd1mYv9+3VoxVTVFs032Z3LGnQL0bj3tnqXNxMS9SFqfRFBet/ec0Zf4nQ
         Bx/3VBKPPu3Dh6khABDiSo5NwXNheGzFTS+CtX9cXqwg3FAUCmUAaTaud8hyAXn+s78u
         6zdnwf2WgxEh8YeS8K773cHytbkyL1gbXzbFujBRXsfPQor5aNKDv0vZQngqVurftzof
         3HcDo/jRa3YMfFiqOSVAXe5mjtc7WN5UrmBatVeAk48Ty+zoDpyoCtDncYMFZCEdJ3e3
         29zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708403; x=1782313203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VU6bNGDdp0rI3WsqzTKPr7JfkwiW3hoSy7BhvGfIckI=;
        b=b3hiA+qusE7Z+2HhwFBMc1D656ktBXEq0EDMSSDbsVrDHRXgzIqRy6ETZ9BCDfQtyO
         zcEaV3mQRr6ZyaOVP25ajiaSRJ1tyP1jhW5Lxz5bKEnVqIXy2LDAyRaTiwtUCfqAv4b7
         DvT0HUmxDoqgzvadaAVohudYse0Xy+K9wUpRLDFRmrfKQgRkfaTKTAJVWIEMrfPRZDsB
         w57JbH91z3vCu+dF+n0QeCHqFjdJynLQq/sqjMVdgYYxCftKcfgNa5spI9Gxf8YfPm36
         Es8aXIBHFxvgTMg4KIGZI0/YhcXsQaXG3x9oSOMVXzt3reB8OIuKWvGoy/CC27cZUIzC
         wu5w==
X-Gm-Message-State: AOJu0YxSng0Sf1qN4uhfANDkK66h5A1NJyTJ0SUNEi0XORdVB5Wc6QZQ
	TZDH4VqOjwpAnlBo3vA3RDaPSXSzSpSqR/7SeccyBLt9rIzSFcCaR8s83D6qrB6B2+GzH5EWvUy
	NAWifvbRGN+ua52+U6hWmYsFC6JKhqbT5lsjZZLbwFvp8abfj3vm2xT3LU866ZKKRBj3S7kK/fB
	NZSJPDiTJfJecg+WDRqUdq3128uyT48DI9vO01AJ1pkQrbcg7kGQ==
X-Gm-Gg: Acq92OHXSED7ENSN2ziHcOLGhOSWmGh4tmBj4iiEgfr0phtI2sJrWWLUBd55f2rtqNZ
	7PlbR61NRDNr5nX1x/ozB7L02V6ikcZUFS+SwleZdiK9WmlK0P5AfP5AozjOVxf5A9F/lyHkdQd
	zbPwWtFvW1L/k/34uo9ISZM7Rv+3JyjwCkbGHh4MuALuNJsQLwAxUSFzr9R5QqSp9eqM5myF6cK
	G2pKxDUjV3OqpAn7tXWJzxIecKDHNwc42KYYEVh6wRPojgqLhn3yoDIT5ZxcwpfvyZGSTqTztHX
	Z9HrG7kiN2Wx4BMLFCUD4TLXgfegAV4fq5EmD2q0I7B3E0rE9GMtWzfnQ6gEIzwwCmbTR/45hN8
	AQUQep+kMn5jts/OAr4dgPuuSHuyp+W2opPRAh8Ksc/Wv
X-Received: by 2002:a05:6808:1a15:b0:486:45c7:34c5 with SMTP id 5614622812f47-489428a0d26mr3223002b6e.17.1781708402602;
        Wed, 17 Jun 2026 08:00:02 -0700 (PDT)
X-Received: by 2002:a05:6808:1a15:b0:486:45c7:34c5 with SMTP id 5614622812f47-489428a0d26mr3222975b6e.17.1781708402045;
        Wed, 17 Jun 2026 08:00:02 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:01 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 04/15] ceph: add BLOG magazine batch allocator
Date: Wed, 17 Jun 2026 14:59:34 +0000
Message-Id: <20260617145945.1912736-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617145945.1912736-1-amarkuze@redhat.com>
References: <20260617145945.1912736-1-amarkuze@redhat.com>
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
 fs/ceph/blog_batch.c | 312 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)
 create mode 100644 fs/ceph/blog_batch.c

diff --git a/fs/ceph/blog_batch.c b/fs/ceph/blog_batch.c
new file mode 100644
index 000000000000..6daf853b8201
--- /dev/null
+++ b/fs/ceph/blog_batch.c
@@ -0,0 +1,312 @@
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
+#include <linux/ceph/blog_batch.h>
+#include <linux/ceph/blog.h>
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
+		if (composite) {
+			/* Composites are allocated with alloc_pages(), free with __free_pages() */
+			__free_pages(virt_to_page(composite),
+				     get_order(BLOG_TLS_PAGEFRAG_ALLOC_SIZE));
+		}
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
+ * Composites are allocated via alloc_pages() in BLOG_MAGAZINE_SIZE
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
+	struct page *pages;
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
+	spin_lock_init(&batch->full_lock);
+	spin_lock_init(&batch->empty_lock);
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
+			pages = alloc_pages(GFP_KERNEL | __GFP_ZERO,
+					    get_order(BLOG_TLS_PAGEFRAG_ALLOC_SIZE));
+			if (!pages) {
+				free_magazine(batch, mag);
+				goto cleanup;
+			}
+			composite = page_address(pages);
+			mag->elements[j] = composite;
+			mag->count++;
+		}
+
+		spin_lock(&batch->full_lock);
+		list_add(&mag->list, &batch->full_magazines);
+		batch->nr_full++;
+		spin_unlock(&batch->full_lock);
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
+	spin_lock(&batch->full_lock);
+	list_for_each_entry_safe(mag, tmp, &batch->full_magazines, list) {
+		list_del(&mag->list);
+		batch->nr_full--;
+		free_magazine(batch, mag);
+	}
+	spin_unlock(&batch->full_lock);
+
+	/* Free magazines in the empty pool */
+	spin_lock(&batch->empty_lock);
+	list_for_each_entry_safe(mag, tmp, &batch->empty_magazines, list) {
+		list_del(&mag->list);
+		batch->nr_empty--;
+		free_magazine(batch, mag);
+	}
+	spin_unlock(&batch->empty_lock);
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
+		spin_lock(&batch->empty_lock);
+		list_add(&old_mag->list, &batch->empty_magazines);
+		batch->nr_empty++;
+		spin_unlock(&batch->empty_lock);
+		cpu_mag->mag = NULL;
+	}
+
+	if (READ_ONCE(batch->nr_full) > 0) {
+		/* Try to get a full magazine */
+		spin_lock(&batch->full_lock);
+		if (!list_empty(&batch->full_magazines)) {
+			new_mag = list_first_entry(&batch->full_magazines,
+						   struct blog_magazine, list);
+			list_del(&new_mag->list);
+			batch->nr_full--;
+			spin_unlock(&batch->full_lock);
+
+			cpu_mag->mag = new_mag;
+			if (new_mag->count > 0)
+				element = new_mag->elements[--new_mag->count];
+		} else {
+			spin_unlock(&batch->full_lock);
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
+ */
+void blog_batch_put(struct blog_batch *batch, void *element)
+{
+	struct blog_cpu_magazine *cpu_mag;
+	struct blog_magazine *mag;
+
+	/* Trim: if over retention limit, free the element instead of storing */
+	if (batch->retain_limit &&
+	    READ_ONCE(batch->nr_full) * BLOG_MAGAZINE_SIZE >= batch->retain_limit) {
+		__free_pages(virt_to_page(element),
+			     get_order(BLOG_TLS_PAGEFRAG_ALLOC_SIZE));
+		return;
+	}
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
+		spin_lock(&batch->full_lock);
+		list_add_tail(&cpu_mag->mag->list, &batch->full_magazines);
+		batch->nr_full++;
+		spin_unlock(&batch->full_lock);
+		cpu_mag->mag = NULL;
+	}
+
+	/* Get new magazine if needed */
+	if (likely(!cpu_mag->mag)) {
+		/* Try to get from empty pool first */
+		spin_lock(&batch->empty_lock);
+		if (!list_empty(&batch->empty_magazines)) {
+			mag = list_first_entry(&batch->empty_magazines,
+					       struct blog_magazine, list);
+			list_del(&mag->list);
+			batch->nr_empty--;
+			spin_unlock(&batch->empty_lock);
+			cpu_mag->mag = mag;
+		} else {
+			spin_unlock(&batch->empty_lock);
+			cpu_mag->mag = alloc_magazine(batch, GFP_ATOMIC);
+		}
+
+		if (unlikely(!cpu_mag->mag)) {
+			/* Cannot store element; free it to avoid a leak */
+			__free_pages(virt_to_page(element),
+				     get_order(BLOG_TLS_PAGEFRAG_ALLOC_SIZE));
+			goto out;
+		}
+	}
+	/* Add element to magazine */
+	cpu_mag->mag->elements[cpu_mag->mag->count++] = element;
+out:
+	preempt_enable();
+}
-- 
2.34.1

