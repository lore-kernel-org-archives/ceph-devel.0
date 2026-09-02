Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C954AA1C3
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366491; cv=none; b=SBa2cfayFihDvcruYwwEGENgsrGdDbPpfQRwb02v7YEw9K7ZBcXR4yxmvvHjAeZuIVXULmtGFNDKiB7SP1KIewLthgPWrTVUBNN28iRpqi/uLKAAT7rT01JgaHmP0zK27fwMyqk++rzM/FJfW7nzr76QEHlAcZmT8AOMLh9/XZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366491; c=relaxed/simple;
	bh=uAWhKjA4ZnmCMgQGn7SMnWZHrgandnFcLlKwbAmQJ8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwBZw/WaqJ4HYNlP118jU100b6GxswVzHLV9C5/9HOkpJUx5eiM4/hAuxzHgZgNXjfDKDx8SAhFsZk+PHtyZKop9gR8FYDlH7PN+mJJ3Upg35kdZAC0NvmZiBjfwfG3Ye3XtW8ikgr6gUlf5P70KFdf4uMCkb6xtduXaX+1lwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFF4e3p6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mDuIOmNF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFF4e3p6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mDuIOmNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
	b=YFF4e3p69s73JfmhvbMFgM7MP7Z3IZpkrhqmZHBlTTipmCvWPJv5k9NtHA1QJ+Y/Vj2RIC
	5qaPKUo+n46YJYDEXOrz/U475bEhkWBNN8h6LepYVagslJrNaMH23jLIOxs3d2X+Uv2bz+
	V3XQX0lu9DHzVphIxbLGqrKaw1x2n0w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-CGef3aSJMSaH99om6yzq9A-1; Wed, 02 Sep 2026 12:28:07 -0400
X-MC-Unique: CGef3aSJMSaH99om6yzq9A-1
X-Mimecast-MFC-AGG-ID: CGef3aSJMSaH99om6yzq9A_1788366486
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c210c66672eso123430866b.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366486; x=1788971286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
        b=mDuIOmNFpYDaNrEgrIA9CdcwsEbJQFmVG6+JoKYg7tv6f5sBRURVac4BG4l9meezUR
         YKoewDQQkBC8pCxm3VGhp7JfR1H82PGOctqBrSQN8VOsnU61NsPgjO6aNtZjRcO5kN9v
         uAwPJ48SN1MW+Z+u3abcUJVbZ+zej9CzoxSDsLRpAIedD01fNLFu796n/ktcWONVe7jR
         3h9YiYgGNA2Xj2sE3+HfI7MgK9nq1SCErwj9tHtXBU1BhVKV2Kn9p6GZ1jvOJpC9CRJo
         mnkpxtLH1g4sy0l+wWlLXeKTg3y/0uq5ciPptRdtb42wAF2J1dKiMZaM+xWe/YSE4L60
         G0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366486; x=1788971286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
        b=UM6iQtxkC3aRpapjwS5g4r1GMyLWOq+aqS9MLKqWBZqW8RT4Gegczv96UMyz7I19je
         pKuIv/yj31yxyh4NdwFqnHNrk2n10enJ4DF5OJp2seOM2ve9pBEKHcMhtKBqZSWaxJij
         Etfl/Pxzw8JtRa7eW3dpwGDQk6cqLa+UYgSjnX4+UIF1hNp/wiFK3gUWsKPM6wLAne9t
         u6mgP9CeJdvad8bAoIA6IIiG/aRpvoHNaA6FLmclq/VzcDeKQONai1Xd0yAJtgq7kupg
         CIDJ131G3NANKlFaVj9mtCYeGq2StuxSzR2xQhuLSipnAgJSnTpsDeaCbE3T+ZdFNscM
         3DDQ==
X-Gm-Message-State: AFuF++npXLBcKawvdgygmg4+aGoMAoUaGm5UkXKcZXYfrhKSKc/y3Dn5
	3cp6wVjIYzN/s0Jlb5DBp0fDUwl81ThTLiYxch9Mp5XvSPozk/VmSkxa3oEZPvnZfb2XzX6l1Dq
	wH2TK9F0JcAFD5P+fhPhODyGL6kCaGc6+v0bT6hVshicW6Z2erYVCIVTmebs5UkHT7xiNKu2X/W
	UWhrdxVCZGrEheThXYtgCxcmyBpy0Xy6G9DavsqlwMYB9HY5erWw==
X-Gm-Gg: AYBFou16MuAsdYLVF/GU4rnM5Jyc/IkT+RyUDxfz+xvILzrlpy5cR/rbrSKRO2OxZpO
	WmjZ7JPelKKHuqfQt7dBCbcP8JkiefikC1KDo/g9vPSIJ9C84CDTdBjJqjy3i15jymdGLWK8aXb
	yD9oAR8U2rKnrCclvIKTLDvW61VOUnlpHiCgFiBgZux/rJ0vJM20Iwu7XHzNb230N28eO1hTXLp
	SWoAJWA+LoMXfp/OGyrDwlUrdaWtnyoOH5CIhvxLAD5chxuy78MDBO4PuUybYGhvXVneguoIdWu
	0X8KPMS9kgjgoNwbj6Lt9dRtHcCIAPtzjWOuhhcq2uxoyjvMJvkjI/2tEJOem9HDxuzb9zCaiEH
	c6TbdFkPMHDXDjriGhC6+avg8JtDhDm9ZOZMaaBdhZWzY23o1OZ0wN0Hh9fy7W8EB79J+PIrxdW
	F+RjLAFPoQ67/eMg==
X-Received: by 2002:a17:906:ba8b:b0:c25:c14d:1c4d with SMTP id a640c23a62f3a-c25d52b2913mr328223866b.7.1788366485650;
        Wed, 02 Sep 2026 09:28:05 -0700 (PDT)
X-Received: by 2002:a17:906:ba8b:b0:c25:c14d:1c4d with SMTP id a640c23a62f3a-c25d52b2913mr328220666b.7.1788366485253;
        Wed, 02 Sep 2026 09:28:05 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:04 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 04/14] ceph: add BLOG magazine batch allocator
Date: Wed,  2 Sep 2026 16:27:50 +0000
Message-Id: <20260902162800.3197342-5-amarkuze@redhat.com>
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

