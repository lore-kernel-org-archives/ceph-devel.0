Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AF41DEFB
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348737; cv=none; b=JQO9VMMajUIMeHm9IOYbg+1vwTL5wUxdhaUMbTCirYD1R4NmghSUUPAO+VkwmL2ju9MzDrz5ZlsrmKJD0tNrRSw00IqdGwlui3k2IADCHMoKJCUajdBqfj6z+aiHn0+6AUe1EOO7y8X+ZiRWvdLrVI/5SsUKB1IEh8Yjj4LQbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348737; c=relaxed/simple;
	bh=Ge+xREHUzIFAv2iPytGrM9yk8EOae86kjSKYEnSjBhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOsAJIftVwxYCdxVOCzIaD3TDvBcAFdRoPnIjejQP6rhK67eT2qVEZl8QMOKWasJ0YxiL5TFWuaogFeBu+A0QDBNUDHsdYnzpPIBQi+17daTe5w3EyF5JBwjNH4U0u1Geuuz+q5dW2GL5n9HSO5PritCvjag1U17ojPl/v+TbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGbvbQeb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYO0j/ue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGbvbQeb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYO0j/ue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VU6bNGDdp0rI3WsqzTKPr7JfkwiW3hoSy7BhvGfIckI=;
	b=KGbvbQebofE8uaaXCETrBgp6Lat9soRC6RkVBQaVQT6NLRp2xWnvFXwnxJBHk4DzKzrVUZ
	ttTqLj6KlOhlkK/9XCNlu2F8qGP7ANgUkWX2d2TUOlt3j1V8If/AMxkN+rsznN/bGL1c+v
	97JLajOggmINWdZZr4DL6muSsbFSJSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-0ZU0XTUtPa2DnzJxyLAg8g-1; Mon, 06 Jul 2026 10:38:51 -0400
X-MC-Unique: 0ZU0XTUtPa2DnzJxyLAg8g-1
X-Mimecast-MFC-AGG-ID: 0ZU0XTUtPa2DnzJxyLAg8g_1783348730
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1263dd9fcaso226620866b.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348730; x=1783953530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU6bNGDdp0rI3WsqzTKPr7JfkwiW3hoSy7BhvGfIckI=;
        b=MYO0j/uebLgd/qLTXMvL8rhe+yUSr8p2L3Jd5+8enjPR75MhSFa7ReObvFQ597w2ab
         a6p8D5qlTpvgi6WHRUiN2w5lPC7U/m9uINO2RwJ19OVbyz0bhTqHnJiosrSu8hKGGOjP
         yQioEDh0dIqfmOtOf6TbFg9WIwHWKI0l+nv+pJ7g8Q7aqeg6I2LeBIYtIKVRe/Ujy6dV
         YhzpUYYQuHiysw8FDsNY9lYyYvkcERuWOxw5ok5xF7yA+UL65k9csOXzhiCborESyQfw
         SL3SVP7TNWaTOwzSI2jLwe9qjCq8N2GAJWCF3oNn810hhduD74FjQQImOr+5w68t4N3e
         oEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348730; x=1783953530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VU6bNGDdp0rI3WsqzTKPr7JfkwiW3hoSy7BhvGfIckI=;
        b=jWgY517aDI1oMeIY587Lt/cVRzCIIkjKvKnJ7TBmQn4mgP75ugp/yCIaNF6b7j30sw
         VjiKCO5NSalI6/1Qg0Li75Y9RmNlsrqKbGrysob2+icvwBPI5h7/V/jH4K9GJCAOGgU5
         Go5Y+p92hXKrc+Cj3AHWDWGp9qE/9wah/D+bxhKwbUwGhEcI/+B9pKkOUIjOgqeR4tIH
         6GrWM3rssJfpPHmexlPuCSydr9hyEFJY+uAjqqcMe94h7n1beK+RBnb7zalauuefE5wx
         KeRUQw3pRGuLBu/VXGpjjA9GI5gvi4Y9lbTWrWIcrBS1A9W0Slr65MCdj05WOao8GzTf
         slKA==
X-Gm-Message-State: AOJu0YwrGS7YKRSfu5+HA/06F0DSIRbhr2C8/k2p6aeIHrTMJdDY3isl
	D4VMxsJAafKAJZU3shDezoZzP6mMct+FpUibWmWq7oBQO3oRlou7e3R5XCuZLI1xedzdgtZ/x6x
	H8YMA4EN/Hp9q2k48Movn0/SWPzlKlzbsF29eBlVc/sXv+sL8BZ3eNTjrZtBJmR1G88h4XMTtxe
	lz2hg96LmxR8pc/bkBFDlfhaTCsaNrasNzHnVKkKPAcPPhuMEwWA==
X-Gm-Gg: AfdE7cn3ePqgcXpX/oyQrZVA4yPkZs7nOkuhnzySWyX7ZVaEYPj108iIh2CSRsVNxac
	FrrOD+5px9eLINS5sJsrOAizT+EUXg3g9AuLbMZWLqgkJbxU8k1QnMomo7dlW2OKEuZFlQXwHIN
	Z4+hvdBQZwRUpp0tQs7WRoZiFd0MQ8ABvFvNKQrNBLaKfOwrSIWUJyn2BwPnZvvUAZugNAhogVB
	1D+Kks331/zlcRxisrKZw/i+z7s89W1dZ3zSxw9QeMvZ/ZbXUjd87PuVl1pYMUdGU7e4ZgtD5ok
	4bjgI5njLerg2muwTNk+ttYA7wWkVZzYAS6f9gQTMEy61a1oF5CH8rgw+Hflp/ss4GThTorqer3
	qtBkI9vdBT7sBfSKUQ7O6EPrRIjKQ+DbbQw4CyQMkNRng
X-Received: by 2002:a17:906:c351:b0:c12:64f1:c4f6 with SMTP id a640c23a62f3a-c15a67bc6bbmr39669366b.38.1783348730057;
        Mon, 06 Jul 2026 07:38:50 -0700 (PDT)
X-Received: by 2002:a17:906:c351:b0:c12:64f1:c4f6 with SMTP id a640c23a62f3a-c15a67bc6bbmr39667666b.38.1783348729451;
        Mon, 06 Jul 2026 07:38:49 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:49 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 04/15] ceph: add BLOG magazine batch allocator
Date: Mon,  6 Jul 2026 14:38:32 +0000
Message-Id: <20260706143843.1980879-5-amarkuze@redhat.com>
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

