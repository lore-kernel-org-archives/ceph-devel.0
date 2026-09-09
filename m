Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEF5592F4
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958472; cv=none; b=jX1RD3dTcf8zDbuymMHiLZIftDcNUMzgaPIAHnl+5op/m5XZj3RUgzMTOf78NyeyavyN1gzV2e6su7nWCpdUwGD+wnzNRrj1o1C4YHBsWdHf5iL357OPgMAVveKcSld+a2s9d5DjOSvZ3Okkj5HDLZw/Zv0XaL79EmtHHZghFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958472; c=relaxed/simple;
	bh=uAWhKjA4ZnmCMgQGn7SMnWZHrgandnFcLlKwbAmQJ8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPglXNKKJAfjiz8s8b1dnDdojxbowb5/23fWTPMJ49DgH7hldfdAyIja4NeEqtU40e7i+D2WL3ZHDIty5EKhmep1yFZU4DgWal1Z7gsHtNy1zV4Kexy21N6f7IMWmJQPUlgZ9QittqSyjE58GBfaQhSCd62MzGSdd0+jyrtWLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQfkJhEy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l9jxvxCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQfkJhEy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l9jxvxCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
	b=aQfkJhEysi2MgFsJbGAeevrHi42kycCMc/5q28wJylYkgS0zxT8eBtfWtjgp1z42L4xGxC
	mMbmxkD0qCNACnySPyTL5d4f7IFMldtifCphF+StB9tV5amjhfWF82z77q0DIjRA+3edKq
	qP8Po9FDypnRDHWd1+hi4Synmv0gt8g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-jqVGk2qrMeaYq7K6UqcRrw-1; Wed, 09 Sep 2026 08:54:28 -0400
X-MC-Unique: jqVGk2qrMeaYq7K6UqcRrw-1
X-Mimecast-MFC-AGG-ID: jqVGk2qrMeaYq7K6UqcRrw_1788958467
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494cce712so1021258685a.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958467; x=1789563267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
        b=l9jxvxCrRVDy2sMOYGe04X+ZwwtQEzJCPAf1ZpIYhWb/4GZy6BG0+tiVbuxdlYwwud
         arMOVdaiGsSDadwkUDXsVRX5kjpGUIA80dIpUl6h/4bp82XgCsAfF8TL2UsXQrIR8XVA
         nuU4I9xx8V0gSsSLh6fFCvMmFSzU7SIdRfJxZ/Bv27NeDR+jEmK67GdeRCunnh1EqA8r
         mPlgILSuFxYsBe+1NhUcYIqISJzzDzyVt+E3+CxxIhmKq5hbYJ0/+uDEVEXtdOg2ZvDM
         +AFPdU9sGhIirqQDtuOg9WkUPLNVHSKgVqvdmxvhyA42/NQY/z2/tDEu9DrjjaJDB5Gv
         i5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958467; x=1789563267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
        b=MHngvXGAazAEhwJS0intM80svcn6TD87rquKGlloVH6DHeIfZS/4L68P7C6kRT4sEb
         6TZwu/iyVkI4z6n4f/kwbsQBHjqRArCSEXOAARaytTbVmRLr1Mgmv24C0Yfa8emzbX2w
         DEQ1/fWDuIKnOvudl6iF0JnIp/YXysYF4lZYAT8icR9feozXkTaDfJ0D0PjqyH87ECbh
         Lw3ZTyf9FQXdg3AsAkChgqpwI1iqTmQU0Iw4QMWvOe1T1/5YZNbOezTE6B8lpav3buvS
         Y2tQeg7qDgzpttp2hcOnDP8N5iDt0BN3jAMFW1TjBxcgK3BWoUYZ1OrbICoWyMJhSPOs
         sIPQ==
X-Gm-Message-State: AFuF++kKaCz8/3Vc2xQW0cNFO9d7oqQl1cIu+Z3K7sHwribpNOQ41puN
	C6gi5eHqI9TEclEBn7Ga/zWBHkGlap6ewossJaD+fOgmTHAjQ5BmZ6nvXIN1QdjA+w/cW3MfV2Z
	3iU5SByiGXkfXdSKREIun8XtCFV7ogs0/pcFfndYprS8ost9U8sUj208UUcdT6k4eNL+/Y2DIFo
	xeei4mc1Af4NCjLuomaSON5gu2BNGxUAvkJOsNk+qMJqy0lWQtFw==
X-Gm-Gg: AYBFou1YRLJ1yGzV+IFclfAD0HvhTIeQR2mrQJ6Ve9baqTJzl1Mz+7qVn7Lz8oilZLx
	fskmzTCrrwP0fGkpUQn9Yl7VSUJXyojIpgxKM1D0zWx2sq1p4iD4BAP5Q1IePd0ry/SpeYMVx1O
	etlWD1vc2Ogn6r0228wXuMZ0ibFtalub5ARBpNGNqG1uvW3Ewb2C/Qxqx9L6yN/NtXYasSKlp4/
	JRcL+0VNOy0U2z4eRLalviX1PhA0SXiWkxO8L3WOH4EBZzk2xxRnnEHkbNDKXZxfigzllvO8oLf
	51Exo6jJzoYLAyFdymBGZ0hZMAfIjuC7KOkiyQVIp2zywSnm8ROGU9ICylZ9MST+IXVtG5VtleT
	3OCdjSXQgqKev32oc1SMZigw2xGBiQQ+U/Lz+8cAWQZcxVVDjna0ODlYJoz9PzvE2z3ZaxytIkQ
	4mn1By2MbOy396Rw==
X-Received: by 2002:a05:620a:4508:b0:939:639b:2e1f with SMTP id af79cd13be357-939d49184d3mr112588685a.7.1788958467463;
        Wed, 09 Sep 2026 05:54:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4508:b0:939:639b:2e1f with SMTP id af79cd13be357-939d49184d3mr112564385a.7.1788958464921;
        Wed, 09 Sep 2026 05:54:24 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:24 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 04/14] ceph: add BLOG magazine batch allocator
Date: Wed,  9 Sep 2026 12:54:06 +0000
Message-Id: <20260909125416.3969532-5-amarkuze@redhat.com>
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

Add blog_batch.c: per-CPU magazine batching for TLS context recycling.
Freed composites go to a local magazine; subsequent acquisitions
reclaim from the magazine without allocating.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_batch.c | 259 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 259 insertions(+)
 create mode 100644 fs/ceph/blog_batch.c

diff --git a/fs/ceph/blog_batch.c b/fs/ceph/blog_batch.c
new file mode 100644
index 000000000000..1f7d5cda0d87
--- /dev/null
+++ b/fs/ceph/blog_batch.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Per-CPU magazine batching for BLOG TLS context recycling.
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
+	for (i = 0; i < mag->count; i++) {
+		composite = mag->elements[i];
+		if (composite)
+			kvfree_atomic(composite);
+	}
+
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
+ * Pass nr_prealloc = 0 for batches that start empty (e.g. log_batch).
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
+	batch->nr_full = 0;
+	batch->nr_empty = 0;
+	batch->retain_limit = retain_limit;
+
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
+	INIT_LIST_HEAD(&batch->full_magazines);
+	INIT_LIST_HEAD(&batch->empty_magazines);
+	raw_spin_lock_init(&batch->full_lock);
+	raw_spin_lock_init(&batch->empty_lock);
+
+	batch->cpu_magazines = alloc_percpu(struct blog_cpu_magazine);
+	if (!batch->cpu_magazines)
+		goto cleanup_cache;
+
+	for_each_possible_cpu(cpu) {
+		cpu_mag = per_cpu_ptr(batch->cpu_magazines, cpu);
+		cpu_mag->mag = NULL;
+	}
+
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
+void blog_batch_cleanup(struct blog_batch *batch)
+{
+	int cpu;
+	struct blog_magazine *mag, *tmp;
+	struct blog_cpu_magazine *cpu_mag;
+
+	if (batch->cpu_magazines) {
+		for_each_possible_cpu(cpu) {
+			cpu_mag = per_cpu_ptr(batch->cpu_magazines, cpu);
+			if (cpu_mag->mag)
+				free_magazine(batch, cpu_mag->mag);
+		}
+		free_percpu(batch->cpu_magazines);
+	}
+
+	raw_spin_lock(&batch->full_lock);
+	list_for_each_entry_safe(mag, tmp, &batch->full_magazines, list) {
+		list_del(&mag->list);
+		batch->nr_full--;
+		free_magazine(batch, mag);
+	}
+	raw_spin_unlock(&batch->full_lock);
+
+	raw_spin_lock(&batch->empty_lock);
+	list_for_each_entry_safe(mag, tmp, &batch->empty_magazines, list) {
+		list_del(&mag->list);
+		batch->nr_empty--;
+		free_magazine(batch, mag);
+	}
+	raw_spin_unlock(&batch->empty_lock);
+
+	if (!batch->external_cache && batch->magazine_cache)
+		kmem_cache_destroy(batch->magazine_cache);
+
+	batch->magazine_cache = NULL;
+	batch->external_cache = false;
+}
+
+void *blog_batch_get(struct blog_batch *batch)
+{
+	struct blog_cpu_magazine *cpu_mag;
+	struct blog_magazine *old_mag, *new_mag;
+	void *element = NULL;
+
+	preempt_disable();
+	cpu_mag = this_cpu_ptr(batch->cpu_magazines);
+
+	if (cpu_mag->mag && cpu_mag->mag->count > 0) {
+		element = cpu_mag->mag->elements[--cpu_mag->mag->count];
+		goto out;
+	}
+
+	old_mag = cpu_mag->mag;
+
+	if (old_mag) {
+		raw_spin_lock(&batch->empty_lock);
+		list_add(&old_mag->list, &batch->empty_magazines);
+		batch->nr_empty++;
+		raw_spin_unlock(&batch->empty_lock);
+		cpu_mag->mag = NULL;
+	}
+
+	if (READ_ONCE(batch->nr_full) > 0) {
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
+	if (likely(cpu_mag->mag && cpu_mag->mag->count < BLOG_MAGAZINE_SIZE)) {
+		cpu_mag->mag->elements[cpu_mag->mag->count++] = element;
+		goto out;
+	}
+
+	if (likely(cpu_mag->mag && cpu_mag->mag->count >= BLOG_MAGAZINE_SIZE)) {
+		raw_spin_lock(&batch->full_lock);
+		list_add_tail(&cpu_mag->mag->list, &batch->full_magazines);
+		batch->nr_full++;
+		raw_spin_unlock(&batch->full_lock);
+		cpu_mag->mag = NULL;
+	}
+
+	if (likely(!cpu_mag->mag)) {
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
+	cpu_mag->mag->elements[cpu_mag->mag->count++] = element;
+out:
+	preempt_enable();
+	return stored;
+}
-- 
2.34.1

