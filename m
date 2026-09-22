Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABE54EEB1
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085668; cv=none; b=AX7ApvnGNb4hiArI9bmv2U3BUg4lk2RrMD9y5/p6oFryxI2AJhlCqvhqOr5+JXVE5hfWdU5/+pl5wyaqYU1LLukua2Vz+8/0AEXh/msNn80hOXWOf/R/VWVi9Oe8qtmRNfVKsSEOaqB9BllCpqjFgYkRhXjEYTdRaNP/CE0fe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085668; c=relaxed/simple;
	bh=uAWhKjA4ZnmCMgQGn7SMnWZHrgandnFcLlKwbAmQJ8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxxVZuD5hVr1Wgf3379YGfcEjZ73zcvBnCe5CMQiU5ckaKr1EUK8x7aevgpURymoqN6Koj+g7OhgdI8/tiVrPHsxzMjkkGe2vpLg4qyJXxTVOD6/gYU3Yw5yw2XDH4wwSE2CeFOpaxR+uUYRvAo2NOdIPSgEDr5z2NoSV5+Kl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTsMdiaR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tpbPOsu5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTsMdiaR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tpbPOsu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
	b=UTsMdiaRen9zGkzThSJHkxWkAmwcE2OJrdkj0nZJL0hYdBk515Y2cbGai6KtA5a16xpUZB
	gRchQz5BBAddfr4BfRk3wrr8Km16RwVQhenfOkbRXDN/4xyb87DH0STxrCvZiCr8zUoxsv
	mw1DEDWfhoJDgF2o1UGmMsXjMGaEwws=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-orz8c2FSNey1MFERBHt7TA-1; Tue, 22 Sep 2026 10:01:03 -0400
X-MC-Unique: orz8c2FSNey1MFERBHt7TA-1
X-Mimecast-MFC-AGG-ID: orz8c2FSNey1MFERBHt7TA_1790085663
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934956beec8so853810485a.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085663; x=1790690463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
        b=tpbPOsu5j/ySP9zcKBZIvwCFchYWF0VyaumhoRAGltFMj0nHH01ihi6Rdu08qZxi6t
         y3ZQIDJIZZXpaHfqARy5FqVbwhxhI/cbrCISofviVSX8DVH3hLCvF0lwZsYvI64ByDQ6
         Q/N8LTznPxSwB3kmapT1oRf3YeyUahrZ4kpo88guc2yYgvHIztZRFsjrzcWaYp6Rmhrr
         J+k5m+rlZpV95DJ5I0opC92DxO+jUoYygU/Ad5FCYTF/I4LnsY7V9ybc2GQVJYPDLRPE
         poLICfR0JIadLiEQRcGXcU1fhbp8GzBIV9bTnqpXnUMXlJLJ/nrThkIQjVO4MUjmL0m7
         yyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085663; x=1790690463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrfL6mkPQBtosPhgAgHlWxqUF0bWHn8IiXStDxTspB8=;
        b=ZjcXvV2vq+aaO3KET6a54PAL7au3OoolM7rWo6a87/pQi1rUzl2IvL2W2p3mo1auSh
         y5naAEwHo9xDBZeLf6+CzECIb3n0DsKZ0C3FC1/z12RswzVprl2w6hrdOPpAz+oGDQ6y
         tyeIZljoET4UlyhVOK4QgriCkvwufsqaf1gMDYRM1mYgxbTDAZgoeWlA0TVAGKA7i4yV
         pescQJsx66DLyYQIkiS7w9+pTllx13sS3h6jBCt7XrRvUSmGQGjsX2cWx4yTg83ubUIq
         ys7rAjbcCYPurjUg6oyPTs8O/laROZdWzSFqPeJinDfM1yiXVmYD61pbKHTF1Y1UN2J8
         T+Gw==
X-Gm-Message-State: AFuF++mUwgNM7IlKjfJR6XSqag75d0XffsKdp2l/Gu+OAntCIu083ldu
	37/gpJg3TQ4H8wacGxaS3mPa1cBJEr2CyQzejBJZUpH/uXt2C5UfADaQ8xRwHaLitY34ptCuzrP
	r7o/rKoFUbUVLK4EKGHJVy+yZtxVbCYWSETku7aBlQoLP45rRCSNUjba7yhUnnYZR6fXSGDPGhm
	S183q/DRJSROhrV2C8BQcvSCa489tqemg5HktljrdoEhTLxX+q4w==
X-Gm-Gg: AYBFou1z6nSv4Hj0cdN8WJhkKHsCnzbC7DZqgqP+yom5e+ga0UJ+orC2OpCXaIDlzRU
	9DfOhVKQbduoOXZxKCZ5X05NEXgiJvrHsst7W/sf64gMshoadOF8K0hHPBYM5bFodKDeoJNz/rR
	DYcCIxSXkBxhFzJF6ZTL4cafYaujjvT6q7hjQwKlMEccawPhpcxrk56cQvOiFQUv5y4bpzJPEPd
	ZM3lwdJTJfbE1Jrsircpjn03wCYEoHr7KvKKFD659Jh+mJUlVrzIynePvpuvyVOOwYemALMiIA2
	2XvAx8zUUGpizHyDUM2goR+qF3XeY7yNwvuyyFuJMd3bR4PT8X4K4MI5ISeb+mHfYvCVj0V0Ok9
	Amcf1d53je3vGHdNH+BCJeleZHtfNbJfwBItw49daHrDueHWOqMQBOqu8lwqwa2th08J/5DeEfu
	jqO7G8YjQsxty8GQ==
X-Received: by 2002:a05:620a:400d:b0:93b:d7a3:45cf with SMTP id af79cd13be357-93c15e8d12emr557027985a.56.1790085662735;
        Tue, 22 Sep 2026 07:01:02 -0700 (PDT)
X-Received: by 2002:a05:620a:400d:b0:93b:d7a3:45cf with SMTP id af79cd13be357-93c15e8d12emr557023685a.56.1790085662084;
        Tue, 22 Sep 2026 07:01:02 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:01:00 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 04/14] ceph: add BLOG magazine batch allocator
Date: Tue, 22 Sep 2026 14:00:37 +0000
Message-Id: <20260922140047.794405-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922140047.794405-1-amarkuze@redhat.com>
References: <20260922140047.794405-1-amarkuze@redhat.com>
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

