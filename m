Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A146AEEF
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708418; cv=none; b=HPvzJZ7leZxPr7SfFB7h3eJWcxTA1IgCLSi6RZbVlcwTrBwqMlLlwhwQ1C9Yw9FwBu+S8Je7PREfhD1DLOmUYNrl4lOYPRFhqSKxrF0gTp5/GOXPcA7UysPz8TAAf0qWw4QlLo3TPiVD8uBDt8tG5OYqFk1j/MlNqdk47CzIsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708418; c=relaxed/simple;
	bh=8lApZJzj3IG3AmWDmjNUsdY9Xk+EudJkVOzzuJlf1SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEnldAUYKBddY8XPiEZZZpJqvoxN64O3vNpV//eV2ivXvt2gKcE1kWA3yGkOUKdkw/m7dZXBWCEPRXtz3hAiDuhyLACZRcdhm3wCx25N8XiNwtjWvN8RD5evN4jzLoPN0/Rid9xvzL+r4aoFXQNIYLVHdCX8Kn1sG7PVOsSf5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co79uu3n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=emGAqr1d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co79uu3n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="emGAqr1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6Lsm+kdop7ymsBSjZqJY/UExAC2BvISC4p9vxMoMbU=;
	b=Co79uu3n3wAWH8WwaAS3F5G0A/a0utYHC7bMBxv5g4xUxjYvL2HZYt1p8fn4ds57y18sTX
	k3HiQZxt7cH0A7K2cYh7NUcRy2F1ZHuyCoFR7yXQzEPH9HOYcpqFLxYouyHumjPqRYHwAy
	jYxH6TaLN1F+GqWOpNHvG+xt+tGbnzc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Yi_JKzjLNgCfoeZO9S7tig-1; Wed, 17 Jun 2026 11:00:07 -0400
X-MC-Unique: Yi_JKzjLNgCfoeZO9S7tig-1
X-Mimecast-MFC-AGG-ID: Yi_JKzjLNgCfoeZO9S7tig_1781708407
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6d439842bso8579355a34.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708407; x=1782313207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6Lsm+kdop7ymsBSjZqJY/UExAC2BvISC4p9vxMoMbU=;
        b=emGAqr1dbCl25yiQbHA3bdJV1cgKFu6g96yBzBWYWdokgkQOfATXik0QC5imT6213Z
         3HB5w64j59G7EBh3Zt+lmBMMzk5y4j8rn4VOZtyZ4ThKMi8zjZYGD2MeprVcSnNZVViy
         o8cQ4XyfF5vhuZDo+UgxRRybciPBOKpJnyeRwDhWiWQWuVjONEqcu8R+J5GUBOcLSE2b
         dYmwsgJA1+fD0sOmzq7utOHU1Sekz8Mf/u2hIb0TY6vV9RictbXalysRg2RO9XPpg+yK
         R9WIvP8TV4BCr2j+7qwaZ9sEP/P3fsOQEmwgBLTdxqIUgRWp1kSRBNJvUSoddP81q9bJ
         H3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708407; x=1782313207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6Lsm+kdop7ymsBSjZqJY/UExAC2BvISC4p9vxMoMbU=;
        b=R/jBupzbSaB56RE03Z+OWIhaiNdufD3jyDiArsHSAwkO0+xPNoeUz25wZ/Txnz96cN
         HWkPX5Jol37RTYqF8z879c2Abf72hJKq9aHeT3+Bnv3RdeVhIxWnRiNySQm/SayMY6AZ
         xBEztv2nJuUSoNHiF8SIJ4pQHNgUgHofQaqgbpp/0ong0l8zyYajduBjtvJqWmk9a9JO
         /TN/NlBFL3fsRPviqlZS83WUuCp7pxAFIbzaqH59/sbhP//uHReOhxEgZ6YFx4810Ptf
         kU/jIJ2NmwcQZlFVJi9xo5paa6ebEGfN3EX4nXdqro9D/dWDKCjPQOiQ4dtfW1YXA5ck
         7Rjg==
X-Gm-Message-State: AOJu0YzJpu41cWMeYh/9bN5HPnRotjz2NbvmEaiUuus6iotXQwveksXq
	lR4TxVVQILeb79B2nn4tgOUA6AMkyDaoqaE13nYKN6LWmDlPpnDjbqh9XeypoqnqLKG83DhlJuY
	jkrY6BBXDP+Sm8pudYVX6YHFYiGoqswkBOGTlpTNY/Af93tVWVEjTJm1MOpcEhF1W8mVU1Yg/vR
	KLoWJPo+/YHdyf5CxlKQk2X/XHcf0YMku2TNf4/JepfcrHvaWBwQ==
X-Gm-Gg: Acq92OHxc+bx5qkqaOTvvwvVKBES8Ao3ZoPOMvPxtnV+MDtlatt4+3P5ta/odBPvrpC
	HmcNyPGGCNApwfLLPl5veb7cM8hTtMde1uD6WTHJJl1m2ejP2c1SfMRAmTxkoJ8xJ6MBI/rxPjK
	tANzg75TxlfhwVo0r8cvlcJa56pyt8rLHfPexSla1iaDrQMTkp3iJQv58w2BqY+5AHOvy5dZ0zm
	p3WvJIAdTBo2vvdTEjUBPWFy/2+PBN3RFpPNZ9a4Q/5KNV57ckDu6ZjC2yqFg1HpON01Zb2Sp1m
	w+XOIMzmnxQjwDPeMNF6zHFkblP+Qc7QxFGzhNup3uad8YrihwT3z9Fl2T8Y2NeFFV4mhPDDpLS
	XgfFV99dX18jw+mDlwonvpU2ZU9FYd3Waua563E3iykhE
X-Received: by 2002:a05:6830:4888:b0:7e6:fdea:7ab1 with SMTP id 46e09a7af769-7e90b31f0efmr3803085a34.8.1781708406449;
        Wed, 17 Jun 2026 08:00:06 -0700 (PDT)
X-Received: by 2002:a05:6830:4888:b0:7e6:fdea:7ab1 with SMTP id 46e09a7af769-7e90b31f0efmr3803042a34.8.1781708405755;
        Wed, 17 Jun 2026 08:00:05 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:05 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 06/15] ceph: add BLOG per-module context management
Date: Wed, 17 Jun 2026 14:59:36 +0000
Message-Id: <20260617145945.1912736-7-amarkuze@redhat.com>
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

Add blog_module.c: per-superblock rhashtable mapping tasks to
blog_task_entry structures, with context acquire/release and safe
retirement that clears the RETIRED bit on removal failure.

Task pointers are not pinned with get_task_struct(); retirement
happens lazily on pointer reuse (PID-mismatch detection) and at
unmount.  Filesystem-reachable allocation paths use GFP_NOFS to
avoid reclaim recursion.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_module.c | 584 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 584 insertions(+)
 create mode 100644 fs/ceph/blog_module.c

diff --git a/fs/ceph/blog_module.c b/fs/ceph/blog_module.c
new file mode 100644
index 000000000000..74bec04b6e92
--- /dev/null
+++ b/fs/ceph/blog_module.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Infrastructure (BLOG) - Per-Module Support
+ *
+ * Per-task context association via rhashtable keyed by task pointer.
+ * Stale entries (task_struct reuse) are detected by PID comparison.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/atomic.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/rhashtable.h>
+#include <linux/ceph/blog.h>
+#include <linux/ceph/blog_module.h>
+
+static LIST_HEAD(blog_module_contexts);
+static DEFINE_SPINLOCK(blog_modules_lock);
+static atomic64_t blog_logger_gen = ATOMIC64_INIT(1);
+
+#define BLOG_LOG_BATCH_MAX_FULL 16
+#define BLOG_TASK_ENTRY_RETIRED 0
+
+/* --- rhashtable parameters for task -> context mapping --- */
+
+static const struct rhashtable_params blog_task_ht_params = {
+	.key_offset = offsetof(struct blog_task_entry, task),
+	.key_len = sizeof(struct task_struct *),
+	.head_offset = offsetof(struct blog_task_entry, node),
+	.automatic_shrinking = true,
+};
+
+/* --- helper: recycle a TLS context back to the magazine batches --- */
+
+static void blog_module_rebalance_log_batch(struct blog_logger *logger)
+{
+	struct blog_magazine *mag;
+
+	if (!logger || logger->log_batch.nr_full <= BLOG_LOG_BATCH_MAX_FULL)
+		return;
+
+	spin_lock(&logger->log_batch.full_lock);
+	if (list_empty(&logger->log_batch.full_magazines)) {
+		spin_unlock(&logger->log_batch.full_lock);
+		return;
+	}
+	mag = list_first_entry(&logger->log_batch.full_magazines,
+			       struct blog_magazine, list);
+	list_del(&mag->list);
+	logger->log_batch.nr_full--;
+	spin_unlock(&logger->log_batch.full_lock);
+
+	spin_lock(&logger->alloc_batch.full_lock);
+	list_add(&mag->list, &logger->alloc_batch.full_magazines);
+	logger->alloc_batch.nr_full++;
+	spin_unlock(&logger->alloc_batch.full_lock);
+}
+
+static void blog_module_queue_to_log_batch(struct blog_logger *logger,
+					   struct blog_tls_ctx *ctx)
+{
+	struct blog_tls_pagefrag *composite;
+
+	if (!logger || !ctx)
+		return;
+	if (logger->owner_ctx)
+		atomic_dec(&logger->owner_ctx->allocated_contexts);
+	composite = blog_ctx_container(ctx);
+	atomic_set(&ctx->refcount, 0);
+	ctx->pending_offset = 0;
+	ctx->pending_size = 0;
+	blog_batch_put(&logger->log_batch, composite);
+	blog_module_rebalance_log_batch(logger);
+}
+
+static void blog_module_clear_task(struct blog_tls_ctx *ctx)
+{
+	if (ctx)
+		WRITE_ONCE(ctx->task, NULL);
+}
+
+static void blog_module_tls_release(void *ptr)
+{
+	struct blog_tls_ctx *ctx = ptr;
+	struct blog_logger *logger;
+
+	if (!ctx)
+		return;
+	logger = ctx->logger;
+	if (!logger) {
+		pr_err("BUG: TLS context id=%llu has no logger\n", ctx->id);
+		return;
+	}
+	blog_module_clear_task(ctx);
+	blog_module_queue_to_log_batch(logger, ctx);
+}
+
+/* --- task-entry lifecycle --- */
+
+static void blog_task_entry_free_rcu(struct rcu_head *rcu)
+{
+	kfree(container_of(rcu, struct blog_task_entry, rcu));
+}
+
+/*
+ * Retire a stale rhashtable entry: remove from hash table, recycle the
+ * TLS context back to the magazine batch, and schedule the entry for
+ * RCU-deferred freeing.
+ */
+static bool blog_retire_entry_locked(struct blog_logger *logger,
+				     struct blog_task_entry *entry,
+				     struct blog_tls_ctx **tls_ctx)
+{
+	if (test_and_set_bit(BLOG_TASK_ENTRY_RETIRED, &entry->flags))
+		return false;
+	if (rhashtable_remove_fast(&logger->task_map, &entry->node,
+				   blog_task_ht_params)) {
+		clear_bit(BLOG_TASK_ENTRY_RETIRED, &entry->flags);
+		return false;
+	}
+
+	*tls_ctx = entry->ctx;
+	if (*tls_ctx && !list_empty(&(*tls_ctx)->list))
+		list_del_init(&(*tls_ctx)->list);
+	return true;
+}
+
+static bool blog_retire_stale_task(struct blog_logger *logger,
+				   struct task_struct *task)
+{
+	struct blog_task_entry *entry;
+	struct blog_tls_ctx *tls_ctx = NULL;
+	bool retired = false;
+
+	spin_lock(&logger->lock);
+	rcu_read_lock();
+	entry = rhashtable_lookup_fast(&logger->task_map, &task,
+				       blog_task_ht_params);
+	if (entry && entry->pid != task->pid)
+		retired = blog_retire_entry_locked(logger, entry, &tls_ctx);
+	rcu_read_unlock();
+	spin_unlock(&logger->lock);
+
+	if (tls_ctx) {
+		blog_module_clear_task(tls_ctx);
+		blog_module_queue_to_log_batch(logger, tls_ctx);
+	}
+	if (retired)
+		call_rcu(&entry->rcu, blog_task_entry_free_rcu);
+	return retired;
+}
+
+/*
+ * Allocate a fresh TLS context (composite) from the magazine batch or
+ * the page allocator, initialize it, and link it into the logger.
+ */
+static struct blog_tls_ctx *blog_alloc_tls_ctx(struct blog_logger *logger)
+{
+	struct blog_tls_pagefrag *composite;
+	struct blog_tls_ctx *tls_ctx;
+	struct blog_pagefrag *pf;
+	struct task_struct *task = current;
+
+	composite = blog_batch_get(&logger->alloc_batch);
+	if (!composite) {
+		struct page *pages;
+
+		pages = alloc_pages(GFP_NOFS | __GFP_ZERO,
+				    get_order(BLOG_TLS_PAGEFRAG_ALLOC_SIZE));
+		if (!pages)
+			return NULL;
+		composite = page_address(pages);
+	}
+
+	tls_ctx = &composite->ctx;
+
+	if (tls_ctx->id == 0) {
+		INIT_LIST_HEAD(&tls_ctx->list);
+		spin_lock(&logger->ctx_id_lock);
+		tls_ctx->id = logger->next_ctx_id++;
+		spin_unlock(&logger->ctx_id_lock);
+#if BLOG_DEBUG_POISON
+		tls_ctx->debug_poison = BLOG_CTX_POISON;
+#endif
+	}
+
+	atomic_set(&tls_ctx->refcount, 1);
+	tls_ctx->task = task;
+	tls_ctx->pid = task->pid;
+	get_task_comm(tls_ctx->comm, task);
+	tls_ctx->base_jiffies = jiffies;
+	tls_ctx->release = blog_module_tls_release;
+	tls_ctx->logger = logger;
+	tls_ctx->flags = 0;
+	tls_ctx->pending_offset = 0;
+	tls_ctx->pending_size = 0;
+
+	pf = &composite->pf;
+	pf->pages = NULL;
+	pf->buffer = composite->buf;
+	pf->capacity = BLOG_TLS_PAGEFRAG_BUFFER_SIZE;
+	spin_lock_init(&pf->lock);
+	pf->head = 0;
+	pf->alloc_count = 0;
+	pf->active_elements = 0;
+	pf->last_entry = NULL;
+
+	spin_lock(&logger->lock);
+	if (list_empty(&tls_ctx->list)) {
+		list_add(&tls_ctx->list, &logger->contexts);
+		logger->total_contexts_allocated++;
+	}
+	spin_unlock(&logger->lock);
+
+	return tls_ctx;
+}
+
+/* --- public module API --- */
+
+struct blog_module_context *blog_module_init(const char *module_name)
+{
+	struct blog_module_context *ctx;
+	struct blog_logger *logger;
+	int ret;
+
+	if (!module_name || !*module_name)
+		return NULL;
+	if (strlen(module_name) >= sizeof(ctx->name))
+		return NULL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	logger = kzalloc(sizeof(*logger), GFP_KERNEL);
+	if (!logger)
+		goto err_ctx;
+
+	logger->magazine_cache = kmem_cache_create("blog_magazine",
+						   sizeof(struct blog_magazine),
+						   0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!logger->magazine_cache)
+		goto err_logger;
+
+	logger->source_map = kvcalloc(BLOG_MAX_SOURCE_IDS,
+				      sizeof(struct blog_source_info),
+				      GFP_KERNEL);
+	if (!logger->source_map)
+		goto err_cache;
+
+	strscpy(ctx->name, module_name, sizeof(ctx->name));
+	ctx->logger = logger;
+	atomic_set(&ctx->refcount, 1);
+	atomic_set(&ctx->allocated_contexts, 0);
+	INIT_LIST_HEAD(&ctx->list);
+
+	INIT_LIST_HEAD(&logger->contexts);
+	spin_lock_init(&logger->lock);
+	spin_lock_init(&logger->source_lock);
+	spin_lock_init(&logger->ctx_id_lock);
+	atomic_set(&logger->next_source_id, 1);
+	logger->next_ctx_id = 1;
+	logger->total_contexts_allocated = 0;
+	logger->owner_ctx = ctx;
+	logger->generation = atomic64_inc_return(&blog_logger_gen);
+
+	ret = rhashtable_init(&logger->task_map, &blog_task_ht_params);
+	if (ret)
+		goto err_source_map;
+
+	ret = blog_batch_init(&logger->alloc_batch, logger->magazine_cache,
+			      num_possible_cpus() * 4 + 32,
+			      num_possible_cpus() + 32);
+	if (ret)
+		goto err_ht;
+
+	ret = blog_batch_init(&logger->log_batch, logger->magazine_cache, 0, 0);
+	if (ret)
+		goto err_batch_alloc;
+
+	spin_lock(&blog_modules_lock);
+	list_add(&ctx->list, &blog_module_contexts);
+	spin_unlock(&blog_modules_lock);
+
+	ctx->initialized = true;
+	pr_debug("BLOG: module '%s' initialized\n", module_name);
+	return ctx;
+
+err_batch_alloc:
+	blog_batch_cleanup(&logger->alloc_batch);
+err_ht:
+	rhashtable_destroy(&logger->task_map);
+err_source_map:
+	kvfree(logger->source_map);
+err_cache:
+	kmem_cache_destroy(logger->magazine_cache);
+err_logger:
+	kfree(logger);
+err_ctx:
+	kfree(ctx);
+	return NULL;
+}
+
+/*
+ * Walk callback for rhashtable_free_and_destroy -- release each
+ * task entry and its associated TLS context.
+ */
+static void blog_task_entry_free_cb(void *ptr, void *arg)
+{
+	struct blog_task_entry *entry = ptr;
+	struct blog_logger *logger = arg;
+
+	if (entry->ctx) {
+		spin_lock(&logger->lock);
+		if (!list_empty(&entry->ctx->list))
+			list_del_init(&entry->ctx->list);
+		spin_unlock(&logger->lock);
+
+		blog_module_clear_task(entry->ctx);
+		blog_module_queue_to_log_batch(logger, entry->ctx);
+	}
+	kfree(entry);
+}
+
+void blog_module_cleanup(struct blog_module_context *ctx)
+{
+	struct blog_logger *logger;
+	struct blog_tls_ctx *tls_ctx, *tmp;
+	LIST_HEAD(pending);
+
+	if (!ctx || !ctx->initialized)
+		return;
+	logger = ctx->logger;
+	if (!logger)
+		return;
+
+	spin_lock(&blog_modules_lock);
+	list_del(&ctx->list);
+	spin_unlock(&blog_modules_lock);
+
+	/* Drain the task hash table */
+	rhashtable_free_and_destroy(&logger->task_map,
+				    blog_task_entry_free_cb, logger);
+
+	/* Detach any remaining contexts from the logger list */
+	spin_lock(&logger->lock);
+	list_for_each_entry_safe(tls_ctx, tmp, &logger->contexts, list)
+		list_move(&tls_ctx->list, &pending);
+	spin_unlock(&logger->lock);
+
+	list_for_each_entry_safe(tls_ctx, tmp, &pending, list) {
+		list_del_init(&tls_ctx->list);
+		blog_module_clear_task(tls_ctx);
+		if (tls_ctx->release)
+			tls_ctx->release(tls_ctx);
+		else
+			blog_module_queue_to_log_batch(logger, tls_ctx);
+	}
+
+	blog_batch_cleanup(&logger->alloc_batch);
+	blog_batch_cleanup(&logger->log_batch);
+
+	if (logger->magazine_cache)
+		kmem_cache_destroy(logger->magazine_cache);
+	kvfree(logger->source_map);
+
+	pr_debug("BLOG: module '%s' cleaned up\n", ctx->name);
+
+	kfree(logger);
+	ctx->logger = NULL;
+	ctx->initialized = false;
+	kfree(ctx);
+}
+
+void blog_module_get(struct blog_module_context *ctx)
+{
+	if (ctx)
+		atomic_inc(&ctx->refcount);
+}
+
+void blog_module_put(struct blog_module_context *ctx)
+{
+	if (ctx && atomic_dec_and_test(&ctx->refcount))
+		blog_module_cleanup(ctx);
+}
+
+/* --- source ID helpers --- */
+
+u32 blog_get_source_id_ctx(struct blog_module_context *ctx, const char *file,
+			   const char *func, unsigned int line, const char *fmt)
+{
+	if (!ctx || !ctx->logger)
+		return 0;
+	return blog_get_source_id(ctx->logger, file, func, line, fmt);
+}
+
+struct blog_source_info *blog_get_source_info_ctx(struct blog_module_context *ctx,
+						  u32 id)
+{
+	if (!ctx || !ctx->logger || id >= BLOG_MAX_SOURCE_IDS)
+		return NULL;
+	return &ctx->logger->source_map[id];
+}
+
+/* --- per-task context acquisition (rhashtable-based) --- */
+
+struct blog_tls_ctx *blog_get_tls_ctx_ctx(struct blog_module_context *ctx)
+{
+	struct blog_logger *logger;
+	struct blog_task_entry *entry;
+	struct blog_tls_ctx *tls_ctx;
+	struct task_struct *task = current;
+	bool stale;
+
+	if (!ctx || !ctx->logger)
+		return NULL;
+	logger = ctx->logger;
+
+retry:
+	rcu_read_lock();
+	entry = rhashtable_lookup_fast(&logger->task_map, &task,
+				       blog_task_ht_params);
+	if (entry && entry->pid == task->pid) {
+		tls_ctx = entry->ctx;
+		rcu_read_unlock();
+		return tls_ctx;
+	}
+	stale = !!entry;
+	rcu_read_unlock();
+
+	if (stale) {
+		if (!blog_retire_stale_task(logger, task))
+			return NULL;
+		goto retry;
+	}
+
+	/* Allocate fresh context */
+	tls_ctx = blog_alloc_tls_ctx(logger);
+	if (!tls_ctx)
+		return NULL;
+
+	entry = kzalloc(sizeof(*entry), GFP_NOFS);
+	if (!entry) {
+		blog_module_queue_to_log_batch(logger, tls_ctx);
+		return NULL;
+	}
+
+	entry->task = task;
+	entry->pid = task->pid;
+	get_task_comm(entry->comm, task);
+	entry->ctx = tls_ctx;
+
+	if (rhashtable_lookup_insert_fast(&logger->task_map, &entry->node,
+					  blog_task_ht_params)) {
+		/*
+		 * Race: another thread inserted for the same task.
+		 * Recycle our context and use theirs.
+		 */
+		kfree(entry);
+		blog_module_clear_task(tls_ctx);
+		blog_module_queue_to_log_batch(logger, tls_ctx);
+
+		rcu_read_lock();
+		entry = rhashtable_lookup_fast(&logger->task_map, &task,
+					       blog_task_ht_params);
+		tls_ctx = entry && entry->pid == task->pid ? entry->ctx : NULL;
+		rcu_read_unlock();
+		if (!tls_ctx)
+			goto retry;
+		return tls_ctx;
+	}
+
+	atomic_inc(&ctx->allocated_contexts);
+	return tls_ctx;
+}
+
+struct blog_tls_ctx *blog_get_ctx_ctx(struct blog_module_context *ctx)
+{
+	return blog_get_tls_ctx_ctx(ctx);
+}
+
+/* --- blog_log_with_ctx / blog_log_commit_with_ctx --- */
+
+/**
+ * blog_log_with_ctx - Reserve buffer for a binary log message (explicit ctx)
+ * @logger: Logger instance
+ * @tls_ctx: TLS context to log into
+ * @source_id: Source ID for this location
+ * @client_id: Client ID for this message
+ * @needed_size: Size needed for the message
+ *
+ * Only one reservation may be outstanding per context at a time.
+ * The caller must call blog_log_commit_with_ctx() before issuing
+ * another reservation on the same context.
+ *
+ * Returns a buffer to write the message into, or NULL on failure
+ */
+void *blog_log_with_ctx(struct blog_logger *logger,
+			struct blog_tls_ctx *tls_ctx,
+			u32 source_id, u8 client_id, size_t needed_size)
+{
+	struct blog_pagefrag *pf;
+	struct blog_log_entry *entry;
+	int alloc;
+	size_t total_size;
+
+	if (!logger || !tls_ctx)
+		return NULL;
+
+	if (needed_size > BLOG_MAX_PAYLOAD)
+		return NULL;
+
+	total_size = round_up(sizeof(*entry) + needed_size, 8);
+	pf = blog_ctx_pf(tls_ctx);
+
+	if (test_and_clear_bit(BLOG_CTX_NEEDS_RESET, &tls_ctx->flags)) {
+		blog_pagefrag_reset(pf);
+		tls_ctx->pending_offset = 0;
+		tls_ctx->pending_size = 0;
+	}
+
+	alloc = blog_pagefrag_reserve(pf, total_size);
+	if (alloc == -ENOMEM) {
+		blog_pagefrag_reset(pf);
+		return NULL;
+	}
+
+	entry = blog_pagefrag_get_ptr(pf, alloc);
+	if (!entry)
+		return NULL;
+
+	if (WARN_ON_ONCE(tls_ctx->pending_size != 0))
+		return NULL;
+	tls_ctx->pending_offset = alloc;
+	tls_ctx->pending_size = total_size;
+
+#if BLOG_DEBUG_POISON
+	entry->debug_poison = BLOG_LOG_ENTRY_POISON;
+#endif
+	entry->ts_delta = jiffies - tls_ctx->base_jiffies;
+	entry->source_id = source_id;
+	entry->len = (u16)needed_size;
+	entry->client_id = client_id;
+	entry->flags = 0;
+
+	return entry->buffer;
+}
+
+int blog_log_commit_with_ctx(struct blog_logger *logger,
+			     struct blog_tls_ctx *tls_ctx,
+			     size_t actual_size)
+{
+	struct blog_pagefrag *pf;
+	struct blog_log_entry *entry;
+	size_t total_size;
+
+	if (!logger || !tls_ctx)
+		return -EINVAL;
+
+	/* Validate that actual_size fits within the reservation */
+	total_size = round_up(sizeof(struct blog_log_entry) + actual_size, 8);
+	if (total_size > tls_ctx->pending_size)
+		return -ENOSPC;
+
+	pf = blog_ctx_pf(tls_ctx);
+
+	entry = blog_pagefrag_get_ptr(pf, tls_ctx->pending_offset);
+	if (!entry) {
+		tls_ctx->pending_offset = 0;
+		tls_ctx->pending_size = 0;
+		return -EFAULT;
+	}
+	entry->len = (u16)actual_size;
+
+	blog_pagefrag_publish(pf, tls_ctx->pending_offset + total_size);
+	tls_ctx->pending_offset = 0;
+	tls_ctx->pending_size = 0;
+
+	return 0;
+}
-- 
2.34.1

