Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9284A4839
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263861; cv=none; b=SxTljnNwthK5uOBSuDHqNlTzsaF93W9jzNQN0E/qiGDBrz5+kjX2Yx3llRM4+5/455JrXfclTFyGGmOFpeoFgiWm2+TroPbgbcw7i35e7FEp6uiG5oIHKMDtcaSb7GLZO0M6RQkZI0N6NP/j5Azqs0Y5733sGMtHAZ3a5mxA8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263861; c=relaxed/simple;
	bh=DkXljb9fZ5X/NTqztLTt8/NYV35dI/JzsoQuiBS3TM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqRBhP3/ZpYaU763pjQx6b3SH+SGPviCoppguA35auv33pXAlneFwVcbSvOmIQraT7oC0i8nBalFy5XDkMk0c3EZPYu02/7e/DRNk5Xi/4gTtfzrgegPrMJCgVEbdRg137Q1ZthxLGhpHpd+3eoPj7pFGVuEm9N/kh5/LTcbYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyzGLMQv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pgNpdm9E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyzGLMQv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pgNpdm9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqIm009as6Q4ivoU6tqe6cKxMJORIPFMUTrJgC5cmMQ=;
	b=GyzGLMQvrP0uYudHjlItLyAYv1BX/I+SD8xne1A1K2WPpFEhfBkRirS0EaSrBbid/vmrIg
	Vtd6Pw4mNYepjFk6VEY0HjThzCxHcPzJNhZTTecX/ifzpMrlbDGlry4A2XXwFuYSa+kDJT
	KBwfqZNxU4lWoxlY6b9Vf+SlyIbWd/s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-5pHS-hi5OCWbDR-MovWxig-1; Thu, 24 Sep 2026 11:30:55 -0400
X-MC-Unique: 5pHS-hi5OCWbDR-MovWxig-1
X-Mimecast-MFC-AGG-ID: 5pHS-hi5OCWbDR-MovWxig_1790263854
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c294c2dcdf5so210710766b.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263854; x=1790868654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqIm009as6Q4ivoU6tqe6cKxMJORIPFMUTrJgC5cmMQ=;
        b=pgNpdm9EIdgUHXwQLZdnXWZSOLQWnaS295d98m4VvL1IMTtjzbvn6RF6Bi48uo1AGv
         fka9gNNPc6NsPZjO8c8ATisy7THBSPv3HHWqZtw4+LYeenBNU8DeGSe9jcRWhRVuRznT
         lvyv11CYhjKOkn0xK9/vv93CpezUIwYRmsFJ1L5MFXgUS+pA617bY1J6gBHMPEvRkMeG
         6SRuQYo2z29ZnbZMmQDT1KYWrHEl87huJinH/tAzhAoPx3FqJLOJqey7ehG0SlxernGl
         liJS2+sNaF++N3XmanH5zN8hc11pP1ivNh2eT6Zl6pHzwLd3rYoEGndgvnopaLCJON3E
         G94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263854; x=1790868654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqIm009as6Q4ivoU6tqe6cKxMJORIPFMUTrJgC5cmMQ=;
        b=OyQR6+tq1P5UkJ6rYm4nZabbmQ9J9vC0ne0JjMoEVgZfpRumo8a7PvPirSDlKrdrp0
         7FFWtvayj7/+8+e7rKv2foIzUWkneY8XIs1eB3RGuTfF88oYDnIO2mkT/hALCv1OKiCw
         LqsUM/iGtQvTP0jlULjcI4IXfF4BqapKSLtCIeS6/fSNPMGfIGP9I3lUVluY0znjh1Kn
         M9XNfZAup4SOjyA9+iECBSA81SuljD8sVrZI+B4I4/+f1usdduo9Pkg2k1VL5zIsqbSQ
         F6lVqV0gvUedNZ/47SrlyJgr/6IYoQ0Z/0bU6Rh8XhxPyurgfdFJYcWH3/opxGk6b+eW
         QREw==
X-Gm-Message-State: AFuF++kaox1EkQCKyg3kEBoHJmarE787FM28G2kecCMqUOmNdBPBMv3b
	jo8ojO7FQ0enhYbMv8RPkl7XooKY7VZP9LDMD4ChiHbWkERVp167BrkAKyhTFxNUbv6KZCGdSOp
	hI6zM0LAhc27T6rABQFkKpLviBjhtFNxYn30yWLTmZaJ9EM4G11l4fIpPZpt3OFE8jX4LQzwqVG
	jMImNT+5cPVhaN5sJNtL0kbx6+We4LxjlgNrKzJlzXtm6HC46vBA==
X-Gm-Gg: AYBFou0WUeh7I2HGo6fh82mBTcLsaZk9p41imn05dkrk1VyOvME1PW/OuUbUrxzvl45
	7BaGPqHf4jPXfzYysnSu1yPHPhEbfnzN8wUbp3PojoNaHogIEpc6TAHdCmWgWRWy8KBUqFnlMLN
	V1/R0P9N18i46tMd28ALj8Jp344Ejs9QpkdslbGWjwq6Og/9qI4ctob5DKQ8NRK3+UTTGGLfukH
	P0e/DlYhhmapU4Wj0l6Ktqad8kWsDO9vN/Wyfffz7pBY1GgZMQGXOG1R2sB/D4MquA/syHeV9Do
	eshelTHAz7eiCm6A73EeMqA+/BJvOyv+K3nCG8OER/2tVhKi5j/Ys31X+8XYvzH2QiyoRcV/GRc
	1MNVyUv0Qw3dFnij80smfVr+NFCUqIriLrvtc6UT3I+fO1e6XPtCoJHti2ofJro/l/sExnXUbzA
	ChzC7+5K43+dcx9w==
X-Received: by 2002:a05:6402:3553:b0:6aa:af44:3e9e with SMTP id 4fb4d7f45d1cf-6aac90cf1f5mr2474725a12.30.1790263854123;
        Thu, 24 Sep 2026 08:30:54 -0700 (PDT)
X-Received: by 2002:a05:6402:3553:b0:6aa:af44:3e9e with SMTP id 4fb4d7f45d1cf-6aac90cf1f5mr2474696a12.30.1790263853574;
        Thu, 24 Sep 2026 08:30:53 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 04/14] ceph: add BLOG magazine batch allocator
Date: Thu, 24 Sep 2026 15:30:34 +0000
Message-Id: <20260924153045.994784-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924153045.994784-1-amarkuze@redhat.com>
References: <20260924153045.994784-1-amarkuze@redhat.com>
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

Return exhausted magazines to an explicit refill batch. When full
magazines move from the log batch to the allocation batch, returning
empties to the allocation batch strands them: only the log batch
puts elements back. Detach the per-CPU magazine before publishing it
under the refill batch's empty-list lock. Both batches must share
the magazine slab cache.

Reported-by: Xiubo Li <xiubo.li@clyso.com>
Link: https://lore.kernel.org/ceph-devel/CAOJNxRJTiUkSAW6diKfZA51mGMCeGdKsbcb5mdkYxqf+-+e8fQ@mail.gmail.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Assisted-by: LLM
---
 fs/ceph/blog_batch.c | 267 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 fs/ceph/blog_batch.c

diff --git a/fs/ceph/blog_batch.c b/fs/ceph/blog_batch.c
new file mode 100644
index 000000000000..c4d2a69e6621
--- /dev/null
+++ b/fs/ceph/blog_batch.c
@@ -0,0 +1,267 @@
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
+/**
+ * blog_batch_get - Take an element and return exhausted magazines for reuse
+ * @batch: Batch supplying elements
+ * @recycle: Batch that will refill exhausted magazines
+ *
+ * The batches must share a magazine cache. Pass the same batch to reuse
+ * magazines locally, or its producer when elements move between batches.
+ */
+void *blog_batch_get(struct blog_batch *batch, struct blog_batch *recycle)
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
+		cpu_mag->mag = NULL;
+		raw_spin_lock(&recycle->empty_lock);
+		list_add(&old_mag->list, &recycle->empty_magazines);
+		recycle->nr_empty++;
+		raw_spin_unlock(&recycle->empty_lock);
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

