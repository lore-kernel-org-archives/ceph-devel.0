Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286303E3D8B
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348738; cv=none; b=aSXScXH7S1sOKkBON7b0/gM32cTc3lsW9DEG+imXBhasBPbAmZUOJ83aqEDoSekbpaDFHc9qS1d5eIORdESUnZi7hm1mg7fklge2txLH+Uw1fU1O+JW7SesziOLHHLtzuJAVCo2vH5l9vIZqT+5PLMMLfECANvT6b6NOyZezInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348738; c=relaxed/simple;
	bh=8lApZJzj3IG3AmWDmjNUsdY9Xk+EudJkVOzzuJlf1SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j+nPcbyBigGGqppHBEHnJSXkrlf1/8I2jqajKPlz8ayKVmL0gl4dy5tY370e/gF08VUvf6Lgdb3Bve4ohUnFj+1wlTpLcK2odkFDeNXf8UnTM6XB04/W1WeglRc3IVaNMPe+vCHHlKJDHHNHGvXpuxDx7P7RhLnp1Eek8H0tTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByzBBxhg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ln6XcLJH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByzBBxhg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ln6XcLJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6Lsm+kdop7ymsBSjZqJY/UExAC2BvISC4p9vxMoMbU=;
	b=ByzBBxhgaFb85NclKlvWJL79UcUIif6Nk8boNO/xYToPokcTCAdbnvot70ZFw4Ciu1739Q
	5GVajwgdQ5KjxnPeZeUF7JvuhzKVWbnBSjY98Rr3y0KtmfWYItedmsLdaQx7FCEt5jtV0p
	tXO7co4pRn5RYx/lNcFgjstd4k5r1vo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-MjNxK0YAP9mcc8tjRweiBQ-1; Mon, 06 Jul 2026 10:38:54 -0400
X-MC-Unique: MjNxK0YAP9mcc8tjRweiBQ-1
X-Mimecast-MFC-AGG-ID: MjNxK0YAP9mcc8tjRweiBQ_1783348733
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c126bfee5a0so225922866b.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348732; x=1783953532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6Lsm+kdop7ymsBSjZqJY/UExAC2BvISC4p9vxMoMbU=;
        b=ln6XcLJHhMHl6yEP7usHUr4y3mt45RglwTGz2CH3hQPctGQ/8KHpHv/aLWH2uvEglC
         yHLFJLhOWb+GkKv6Zb/FFSFvsHVguiIoT2cZXD4ke3xn8rcP4+NKbBxItVYGhK66gnVM
         wvJvhsPxh4Mp4Gm9FUXWMJ2kEteQzbukMkCgktzl0H/NADBjqkNYCTVDLFtHA4JEsZKq
         GdcZTpPYzCSYruQmLuMyjH256utAGp+5LTBBA/UkWiRmxujoBOtlUXoLLQL86PjmFcnF
         YzX2AdwrqOchjgBJnSFTvTy2Zj43gLyVdD0SGXpvZDd/THPaWryosS/VFnqE/gLWNvlI
         ubFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348732; x=1783953532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6Lsm+kdop7ymsBSjZqJY/UExAC2BvISC4p9vxMoMbU=;
        b=cM+HUMDmFJCLdTUhaFrcQ1FcWnVOQD0srbgtzUOLUYuqhZxdVfkoaLRLSted6yBB4j
         /ltIyplz+LQJ0DdO+wPXVwYUoZKMPUZLyrrgxBC6byD4DkTfYY5+xbFxPNvd01tpY+fE
         TBJ1CZxbZm68fXkNMnzhf34/yb+hrH+QJX4q9tBrEf0oeUp1Gk4ozBjCDKjOqAOKb5Y0
         0K5xPahZxdlnl90VjPAE/lfkscgBvF26JQ9p/QSWJy3v33b2Nfy6N16ejuqTthqzj4Q9
         O7PV20ZeS3gqMrU/A3aTJzZTFb+XVNWxri2imypXVWDcR4Csd1bkxPDSH5Q9yHxp3WZ1
         1sMw==
X-Gm-Message-State: AOJu0YyIcP1RvY3R/pJ42dIA87cYCGcWJX98HzMPLTeq7XAz04PaKW/L
	xhKnyd+TFIMHuhhEMY4LJsNavQLqTBhOQeTpj4Wx0w8eGR/yXARLOAPpt9UgmiJLnieGBCt20A8
	tM925tPPXu9zo7U/TR0wyIsc643YZbGWh5tfYRJqlgGQU9cXT2L/mwaM7pJFlrjQqLDC2ewZsXl
	80H5VsIpTLG9TsajfvRmIzWy9wdbimh51on51hHstu39VvOno4gQ==
X-Gm-Gg: AfdE7cmOMNIBFcJclyiVZXC0m8kGiVLlliANXP/6DBSL2hA1eT9JHUDvBSG5ZnqU1J4
	JXklKbI+TTFbPJNglGZbUFHHYxxa4q1UBIBpQpFJJRaCbajW0o/rNcMeETi2AgfRS9KVpTNYEMR
	iKDZFxyKUnWAIf6NWViupns0HgZPkSv8AhJhmSkaS6+gdTaD9OZCQwmqOw59LDIIU5/GAZrTqyb
	0mKKpG59MwCr49Ni7nlq0cjgEd77OYZJabt43FK+kxoN23dtcbHkJyDWmvMXd4BVKBLADWCqduW
	kbahdWf63+DJNT933+/qS7XXiDlRqKal2rfljvDJaNHRiZYVnwodIRCoo0lX5lJhzNBeseZBwnB
	y3rS7q2bRSzEio2akkyjzysgz5YVr0cskKwJTFDJG9WpB
X-Received: by 2002:a17:906:b349:b0:c12:a599:b59e with SMTP id a640c23a62f3a-c15a6840fdamr34045266b.29.1783348732415;
        Mon, 06 Jul 2026 07:38:52 -0700 (PDT)
X-Received: by 2002:a17:906:b349:b0:c12:a599:b59e with SMTP id a640c23a62f3a-c15a6840fdamr34043166b.29.1783348731789;
        Mon, 06 Jul 2026 07:38:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 06/15] ceph: add BLOG per-module context management
Date: Mon,  6 Jul 2026 14:38:34 +0000
Message-Id: <20260706143843.1980879-7-amarkuze@redhat.com>
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

