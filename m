Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D841611F
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348737; cv=none; b=WnLraHXrv5XghWrV114MNNW2nVVNsv+drsw3zurH9FblD5V7NyBG8E8zplVjwwoVeo+mlRtJfslWdCXK1UgrRW2Ol/L5ABrIUuv7DFHrwYFx27N050N5MQJDa2sHNpzR0r6OJFKzF1026eRXQWvWol1zftR+4y2wSoFBMNWDSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348737; c=relaxed/simple;
	bh=A0DspdDXXYcajWzHdnHTrXAkUzxLQ4FY8a2vFJ0Rur4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FE1Iq/+tMD3W6GfXbE35dF0YTVMPouGUbXQpxiCjJSKQGlerRQbks8yy3k0Q4WCfJW3n6P6KHxU3P5z4S6zmV+/FPVI5CkUeU+k2PXUwkw8BNcS7r5wzhsiOJ80rGeLi2h4PzOQGIorSTdZQjduiwPNeUC8ihOWS4UpFBFea3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMK00TcE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAkOH1YQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMK00TcE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAkOH1YQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncZluNthgrI6veEOQ75BSRndsbMzOg5HmgY7MZZG+bk=;
	b=MMK00TcEekdJzvfHzbkfrOas3JejpxQ/aBdLYPkVhRvxwkDcxqZH0aMpxWVKTIniuLbLtS
	f5M3Tzw5duUBLRq2bHL84e/gtoOgfah1erMdbLts6oPrGxlqZWOBD7WgOMbwRCuNKPS39G
	0l54lPZKGvFXpA4VGqprTQD03E1cwzE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-AnhD_PfKP_Wa4_kfvpfD-g-1; Mon, 06 Jul 2026 10:38:52 -0400
X-MC-Unique: AnhD_PfKP_Wa4_kfvpfD-g-1
X-Mimecast-MFC-AGG-ID: AnhD_PfKP_Wa4_kfvpfD-g_1783348731
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c127ff955c7so219352066b.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348731; x=1783953531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncZluNthgrI6veEOQ75BSRndsbMzOg5HmgY7MZZG+bk=;
        b=HAkOH1YQNpA8REvzpkXpmctCVkWRjDG3yV0S7bA55N4hwYQlDF7vgsc8/AZBchtxSh
         kFEkWMioL7vIpsI9CnX5VHf56scgU+NgD8o6G2v7wkwzKJDpa7pG2Pgkcaiil2s+3+ob
         JFjURs/Nee6pQsqjzh60X2ISwM/05e46/dDKTmIja+JmniPTvVpZaL57SHwo17w4no8O
         JWSolDbFGLlmibZg/spGIeundZKcz7MBN1DJYe4s+9xAMRLIZY/5jNWWp+PAAIUY3muV
         Tyh9/LR8ZV0GAkJrG0AOZDSVmqgGOw/ZpYm8iGOlqI2hPF0M+70nZnA8xiS7DI5PoqWl
         TgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348731; x=1783953531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncZluNthgrI6veEOQ75BSRndsbMzOg5HmgY7MZZG+bk=;
        b=qF9Vs5/XE2xlHrKsRaCgA0nffu/ZXfIyqL5hA+X+ahEsUoGjRPWih/V6OUKYcvWdpv
         IN23dQZ8fiX+pAi2RjgXY8qqnfKA33FgjK2QznRfUAeqn4ROyntCqaG0NkPXS8X5nAkc
         mqhM2CmUiyr+012j7VvLuNvolqJBJlQSGd8nGRj2twMJce4UfrTvVYBYes1f4sRdHD9f
         vldRhxbcA8RYm5RcHD71E/4F+vIM1jS7UYbbhtxZoufs/gcd6Z6hxgxhQe0ZvpYcaXrV
         MTeF4dYTROz2wV73jaDNKb3ywUdyuPCUAnB0tI7A993F+ci+5CZl4hVxEmeoy1mDsrnQ
         JDvg==
X-Gm-Message-State: AOJu0YznzRLKFQEL9NAAgozPjH/0entOpIwCOcOJggvnlF+2uFsziH3O
	AL2urKS3S7Awu6kOLHckpIreFwp33gYhmvqpG/iXlM5ddbfI+mF1iI3UmYsNfGRFQpA+gqzg5nG
	8C6w+LOdJmPBZn0SbNOKpwPPSkLa/RYp5l6iSnbbpPchNCjFYEKC79W4+r9CWD2ht+AB5HdSWO1
	cKUBAW1baGkrmb81gVd8ml+k0Y3kQaZsgrmZPHk1j8pMWmTkBEgw==
X-Gm-Gg: AfdE7clZsqcboWh38k5HP+6pd18buOrEYmDLpfufmkkIYjo6q+VBVxNab3tNqgr/vLw
	WXge/sZVtfIj/z0uzP24nMsTE5DjRqgw2BA2aDAjw3PY3pLwqkGtvajqK8HiHfE40rCr6W0pXo7
	1xw/SNotRYjzCK0BNSr1f6/ds2Oj2ew0wmLmEinu1kCnIpIhimtNFS1b6Qy1i7SGnG5dQhcOKuq
	mwtXegb7btY/LvoEvkv+TrElrBSFL0VgyxxoT3qtpSuTb0VHRDK7lfsu7czOaX+XdQkA06VqjO2
	pFml5rxq3PjWzZKqfAU87ys3WPXwH0mvhJE/ms/PiTTXmY5FlURy+9IjQ4hdCujrj3P3JV2XzXZ
	N5yTeP2l1noIKaUm4Ne0bZDPVoy7kUzbELMsyedi/cSeQ
X-Received: by 2002:a17:907:3d43:b0:c10:18d5:b659 with SMTP id a640c23a62f3a-c15a66b2b7emr55772866b.2.1783348731289;
        Mon, 06 Jul 2026 07:38:51 -0700 (PDT)
X-Received: by 2002:a17:907:3d43:b0:c10:18d5:b659 with SMTP id a640c23a62f3a-c15a66b2b7emr55770366b.2.1783348730689;
        Mon, 06 Jul 2026 07:38:50 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:50 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 05/15] ceph: add BLOG logger core
Date: Mon,  6 Jul 2026 14:38:33 +0000
Message-Id: <20260706143843.1980879-6-amarkuze@redhat.com>
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

Add blog_core.c: central logger, source-ID registry with per-callsite
caching (smp_store_release/smp_load_acquire plus generation counter),
circular entry buffer, and iteration API for debugfs consumers.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_core.c | 424 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 424 insertions(+)
 create mode 100644 fs/ceph/blog_core.c

diff --git a/fs/ceph/blog_core.c b/fs/ceph/blog_core.c
new file mode 100644
index 000000000000..da8567c53229
--- /dev/null
+++ b/fs/ceph/blog_core.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Infrastructure - Core Implementation
+ *
+ * Per-module logger instances, source-ID registration, log-entry
+ * reservation/commit, and pagefrag-based context management.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/printk.h>
+#include <linux/time.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <linux/atomic.h>
+
+#include <linux/rhashtable.h>
+#include <linux/ceph/blog.h>
+#include <linux/ceph/blog_batch.h>
+#include <linux/ceph/blog_pagefrag.h>
+#include <linux/ceph/blog_ser.h>
+#include <linux/ceph/blog_des.h>
+#include <linux/ceph/blog_module.h>
+
+/* Core BLOG functions - all require a valid logger parameter */
+
+static struct blog_tls_ctx *lookup_active_ctx(struct blog_logger *logger)
+{
+	struct task_struct *task = current;
+	struct blog_task_entry *entry;
+
+	if (!logger)
+		return NULL;
+
+	rcu_read_lock();
+	entry = rhashtable_lookup_fast(&logger->task_map, &task,
+				       logger->task_map.p);
+	if (entry && entry->pid == task->pid) {
+		struct blog_tls_ctx *ctx = entry->ctx;
+
+		rcu_read_unlock();
+		return ctx;
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
+/**
+ * blog_get_tls_ctx - Get or create TLS context for current task
+ * @logger: Logger instance to use
+ *
+ * Returns pointer to TLS context or NULL on error
+ */
+struct blog_tls_ctx *blog_get_tls_ctx(struct blog_logger *logger)
+{
+	struct blog_tls_ctx *ctx;
+
+	if (!logger)
+		return NULL;
+
+	ctx = lookup_active_ctx(logger);
+	if (ctx)
+		return ctx;
+
+	/* Delegate to module layer which manages the rhashtable insert */
+	if (logger->owner_ctx)
+		return blog_get_tls_ctx_ctx(logger->owner_ctx);
+
+	return NULL;
+}
+
+static bool blog_source_matches(const struct blog_source_info *info,
+				const char *file, const char *func,
+				unsigned int line, const char *fmt)
+{
+	return info->file && info->func && info->fmt &&
+	       info->line == line && info->fmt == fmt &&
+	       !strcmp(info->file, file) && !strcmp(info->func, func);
+}
+
+/**
+ * blog_get_source_id - Get or create a source ID for the given location
+ * @logger: Logger instance to use (NULL for global)
+ * @file: Source file name
+ * @func: Function name
+ * @line: Line number
+ * @fmt: Format string
+ *
+ * Returns a unique ID for this source location
+ */
+u32 blog_get_source_id(struct blog_logger *logger, const char *file,
+		       const char *func, unsigned int line, const char *fmt)
+{
+	struct blog_source_info *info;
+	u32 id, next_id;
+
+	if (!logger)
+		return 0;
+
+	spin_lock(&logger->source_lock);
+	next_id = atomic_read(&logger->next_source_id);
+	for (id = 1; id < next_id; id++) {
+		info = &logger->source_map[id];
+		if (blog_source_matches(info, file, func, line, fmt))
+			goto out_unlock;
+	}
+
+	id = next_id;
+	if (id >= BLOG_MAX_SOURCE_IDS) {
+		atomic_set(&logger->next_source_id, BLOG_MAX_SOURCE_IDS);
+		spin_unlock(&logger->source_lock);
+		pr_warn_once("blog: source ID overflow\n");
+		return 0;
+	}
+
+	atomic_inc(&logger->next_source_id);
+	info = &logger->source_map[id];
+	info->file = file;
+	info->func = func;
+	info->line = line;
+	info->fmt = fmt;
+	info->warn_count = 0;
+#if BLOG_TRACK_USAGE
+	atomic_set(&info->task_usage, 0);
+	atomic_set(&info->task_bytes, 0);
+#endif
+
+out_unlock:
+	spin_unlock(&logger->source_lock);
+	return id;
+}
+
+u32 blog_get_source_id_cached(struct blog_logger *logger,
+			      struct blog_source_id_cache *cache,
+			      const char *file, const char *func,
+			      unsigned int line, const char *fmt)
+{
+	u32 sid;
+
+	if (!logger)
+		return 0;
+	if (cache) {
+		sid = smp_load_acquire(&cache->id);
+		if (sid && READ_ONCE(cache->logger) == logger &&
+		    READ_ONCE(cache->generation) == logger->generation)
+			return sid;
+	}
+
+	sid = blog_get_source_id(logger, file, func, line, fmt);
+	if (cache && sid) {
+		WRITE_ONCE(cache->logger, logger);
+		WRITE_ONCE(cache->generation, logger->generation);
+		smp_store_release(&cache->id, sid);
+	}
+
+	return sid;
+}
+
+/**
+ * blog_get_source_info - Get source info for a given ID
+ * @id: Source ID
+ *
+ * Returns the source information for this ID
+ */
+struct blog_source_info *blog_get_source_info(struct blog_logger *logger, u32 id)
+{
+	if (!logger || unlikely(id == 0 || id >= BLOG_MAX_SOURCE_IDS))
+		return NULL;
+	return &logger->source_map[id];
+}
+
+/**
+ * blog_log - Reserve buffer for a binary log message
+ * @logger: Logger instance to use
+ * @source_id: Source ID for this location
+ * @client_id: Client ID for this message (module-specific)
+ * @needed_size: Size needed for the message
+ *
+ * Only one reservation may be outstanding per context at a time.
+ * The caller must call blog_log_commit() before issuing another
+ * blog_log() on the same context.
+ *
+ * Returns a buffer to write the message into, or NULL on failure
+ */
+void *blog_log(struct blog_logger *logger, u32 source_id, u8 client_id, size_t needed_size)
+{
+	struct blog_tls_ctx *ctx;
+	struct blog_log_entry *entry = NULL;
+	int alloc;
+	int retry_count = 0;
+
+#if BLOG_TRACK_USAGE
+	struct blog_source_info *source;
+#endif
+	/* Preserve payload length; compute rounded total allocation separately */
+	size_t payload_len = needed_size;
+
+	if (payload_len > BLOG_MAX_PAYLOAD) {
+		pr_warn_once("%s: payload %zu exceeds max %u\n",
+				__func__, payload_len, BLOG_MAX_PAYLOAD);
+		return NULL;
+	}
+
+	needed_size = round_up(payload_len + sizeof(struct blog_log_entry), 8);
+#if BLOG_TRACK_USAGE
+	source = blog_get_source_info(logger, source_id);
+	if (unlikely(source)) {
+		atomic_inc(&source->task_usage);
+		atomic_add(needed_size, &source->task_bytes);
+	}
+#endif
+
+	while (entry == NULL) {
+		struct blog_pagefrag *pf;
+
+		ctx = blog_get_ctx(logger);
+		if (!ctx)
+			return NULL;
+		if (unlikely(retry_count)) {
+			pr_debug(
+				"[%d]Retrying allocation with ctx %llu (%s, pid %d) (retry %d, needed_size=%zu @ %d)\n",
+				smp_processor_id(), ctx->id, ctx->comm,
+				ctx->pid, retry_count, needed_size, source_id);
+		}
+
+		pf = blog_ctx_pf(ctx);
+
+		if (test_and_clear_bit(BLOG_CTX_NEEDS_RESET, &ctx->flags)) {
+			blog_pagefrag_reset(pf);
+			ctx->pending_offset = 0;
+			ctx->pending_size = 0;
+		}
+
+		alloc = blog_pagefrag_reserve(pf, needed_size);
+		if (alloc == -ENOMEM) {
+			pr_debug("%s: allocation failed (needed %zu), resetting context\n",
+				 __func__, needed_size);
+			blog_pagefrag_reset(pf);
+			retry_count++;
+			if (retry_count > 3) {
+				pr_err("%s: failed to allocate after 3 retries\n", __func__);
+				return NULL;
+			}
+			continue;
+		}
+
+		entry = blog_pagefrag_get_ptr(pf, alloc);
+		if (!entry) {
+			pr_err("%s: failed to get pointer from pagefrag\n", __func__);
+			return NULL;
+		}
+		pf->last_entry = entry;
+
+		/* Store pending publish info for blog_log_commit() */
+		if (WARN_ON_ONCE(ctx->pending_size != 0))
+			return NULL;
+		ctx->pending_offset = alloc;
+		ctx->pending_size = needed_size;
+	}
+
+#if BLOG_DEBUG_POISON
+	entry->debug_poison = BLOG_LOG_ENTRY_POISON;
+#endif
+	entry->ts_delta = (u32)(jiffies - ctx->base_jiffies);
+	entry->source_id = (u16)source_id;
+	entry->len = (u16)payload_len;
+	entry->client_id = client_id;
+	entry->flags = 0;
+
+	return entry->buffer;
+}
+
+/**
+ * blog_log_commit - Publish a reserved log entry
+ * @logger: Logger instance
+ * @actual_size: Actual bytes written during serialization
+ *
+ * Publishes the log entry that was reserved by the last blog_log() call.
+ * Must be called after serialization is complete to make the entry visible
+ * to readers.
+ *
+ * Context: Same context as the preceding blog_log() call
+ * Return: 0 on success, negative error code on failure
+ */
+int blog_log_commit(struct blog_logger *logger, size_t actual_size)
+{
+	struct blog_tls_ctx *ctx = blog_get_ctx(logger);
+	struct blog_pagefrag *pf;
+	struct blog_log_entry *entry;
+	size_t total_size;
+
+	if (!ctx)
+		return -EINVAL;
+
+	/* Validate that actual_size fits within the reservation */
+	total_size = round_up(sizeof(struct blog_log_entry) + actual_size, 8);
+	if (total_size > ctx->pending_size)
+		return -ENOSPC;
+
+	pf = blog_ctx_pf(ctx);
+
+	entry = blog_pagefrag_get_ptr(pf, ctx->pending_offset);
+	if (!entry) {
+		ctx->pending_offset = 0;
+		ctx->pending_size = 0;
+		return -EFAULT;
+	}
+	entry->len = (u16)actual_size;
+
+	blog_pagefrag_publish(pf, ctx->pending_offset + total_size);
+	ctx->pending_offset = 0;
+	ctx->pending_size = 0;
+
+	return 0;
+}
+
+/**
+ * blog_get_ctx - Get logging context for current task
+ */
+struct blog_tls_ctx *blog_get_ctx(struct blog_logger *logger)
+{
+	return blog_get_tls_ctx(logger);
+}
+
+/**
+ * blog_log_iter_init - Initialize the iterator for a specific pagefrag
+ */
+void blog_log_iter_init(struct blog_log_iter *iter, struct blog_pagefrag *pf,
+			u64 head_snapshot)
+{
+	if (!iter || !pf)
+		return;
+
+	iter->pf = pf;
+	iter->current_offset = 0;
+	iter->end_offset = head_snapshot;
+	iter->prev_offset = 0;
+	iter->steps = 0;
+}
+
+/**
+ * blog_log_iter_next - Get next log entry
+ */
+struct blog_log_entry *blog_log_iter_next(struct blog_log_iter *iter)
+{
+	struct blog_log_entry *entry;
+
+	if (!iter || iter->current_offset >= iter->end_offset)
+		return NULL;
+
+	/* Ensure the entry header itself fits within the snapshot. */
+	if (iter->current_offset + sizeof(struct blog_log_entry) >
+	    iter->end_offset)
+		return NULL;
+
+	entry = blog_pagefrag_get_ptr(iter->pf, iter->current_offset);
+	if (!entry)
+		return NULL;
+
+	iter->prev_offset = iter->current_offset;
+	iter->current_offset +=
+		round_up(sizeof(struct blog_log_entry) + entry->len, 8);
+	iter->steps++;
+
+	/*
+	 * Clamp to the snapshot boundary: a corrupted entry->len could
+	 * push current_offset past end_offset into garbage memory.
+	 */
+	if (iter->current_offset > iter->end_offset)
+		iter->current_offset = iter->end_offset;
+
+	return entry;
+}
+
+/**
+ * blog_des_entry - Deserialize entry with callback
+ */
+int blog_des_entry(struct blog_logger *logger, struct blog_log_entry *entry,
+		   char *output, size_t out_size, blog_client_des_fn client_cb)
+{
+	int len = 0;
+	struct blog_source_info *source;
+
+	if (!entry || !output)
+		return -EINVAL;
+
+	/* Let module handle client_id if callback provided */
+	if (client_cb) {
+		len = client_cb(output, out_size, entry->client_id);
+		if (len < 0)
+			return len;
+	}
+
+	/* Get source info */
+	source = blog_get_source_info(logger, entry->source_id);
+	if (!source) {
+		len += snprintf(output + len, out_size - len,
+				"[unknown source %u]", entry->source_id);
+		return len;
+	}
+
+	/* Add source location */
+	len += snprintf(output + len, out_size - len, "[%s:%s:%u] ",
+			source->file, source->func, source->line);
+
+	/* Deserialize the buffer content */
+	{
+		int ret;
+
+		ret = blog_des_reconstruct(source->fmt, entry->buffer,
+					   entry->len, output + len,
+					   out_size - len);
+		if (ret < 0)
+			return ret;
+		len += ret;
+	}
+
+	return len;
+}
-- 
2.34.1

