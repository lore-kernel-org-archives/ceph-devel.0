Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9E4A4825
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263861; cv=none; b=mzAFvvi0vJbhbC4N3c2pDaDjad4Ug9stAmqUl9VNe8abOZDqOT9NcQOCgB6dqeDnH8P81bFut8NO1qzJrdUGix5sf0gynymZTt5Fw8Hnzo6L7iRv92/fVtwX3k6pwBKxhwWf8gn+ocgb0xhahTzFeQsSQqJFPYqBZMs4Fzw0KyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263861; c=relaxed/simple;
	bh=zJJW6Ug6wkcIpc7hn5n4HTImnTjCzgM3Ky17nsuPcbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSlI01Q8YfQ3eJBzR8YRR4ripJ50x7ge+81DKzlTnp0eAtGdOxqoXhhFMeWMov9hsmorpxF0MGtDPWbWHggz4bgJsFZ/lTmT+tCvCTwBGlOHQFAHvF7GhuWRQTIegOW1k5FhKShF19j51rxh7JxnCYjX6MkC3ALnp0FOHzCEXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUN7bxrY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfHXmSSn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUN7bxrY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfHXmSSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
	b=TUN7bxrY7w9RYKHFzFyMdVJa6scHaXxqM20TAAUCy2Q9HwESHkuXq3WxAOsq/AvyFAF2Rm
	g3h2CPGdwmmlajE9QGqLunWBe3bZwmzvWef0EdHEimz2XwwgHSYyqeBcZW6wB/hW8ejkJh
	QmR6FT+RWVm5uJlul5rwqfVBSBFoxH0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-jpHRMxRtOOeft5AoUS2kGA-1; Thu, 24 Sep 2026 11:30:56 -0400
X-MC-Unique: jpHRMxRtOOeft5AoUS2kGA-1
X-Mimecast-MFC-AGG-ID: jpHRMxRtOOeft5AoUS2kGA_1790263855
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6aa5d0921fcso2624185a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263855; x=1790868655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
        b=KfHXmSSnvm6QcbCHi19Vh83d3j0ALsv3gmFsFZOKeVd1GPOZaYv+anQlpvO5Lasyul
         thdSpJfxGhjeXiQj7rIC+FNbchfE9V/jDLKSfN+X5GAe05AIFOdC8IIjLJKtvPqtLSzZ
         lsUYjt4kQk+IXusSO5n0esTJspe/HiWvoMoOAHgt1kDrx91duGPWY8fLVdcL7rNRnVXG
         9LmFQBFQ35iwJK9zSDPefYGMr55CyTDOQCDS12UcrsrQexOjLQAn88mZ5gukuA8v5Noh
         +4BlLUPrXmobXhAadUnYRbsspLXQrptgGLWb7XscKTsWNO4oG4zGyROxSmBGPjOGmjAg
         08ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263855; x=1790868655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
        b=e3fIVV+x2JSltRFH+roh+OJOOyzOPCsSNvbFTe+2brQCVDBdTsCTAz/FdjBOz25E2z
         uIdmBBDLAtVQMhg2VTFkmGujHwWlM06RG7qVeCw/DyVAjve7QqFa9Rjms3xmjhoH5NV1
         pIvbfvWP6kROAdWBezf4rJ8SluH2OCSBN+IaCGn7cNftUIUYra9QMfPRo6RMcFKyZkqY
         px18vq5YzxfubbCUeihdd8/bclatAVKyM6bapovRm1nru9ixuUthNGrtYfqlFNZBSsEx
         wxXZq5jvXkTuZQK2KIsoDn39H1CY2XonIELvTt1Ln4P9pJQfw+poyhdXfQf2QmguguLj
         qP9Q==
X-Gm-Message-State: AFuF++mVcN9LCPP5tiAt9IgeFxbSK6lmFgXmNrtbRw55oznMLw2Uor/n
	HMebASECOGZ8int6bNUmFCoeF5F+7az+tf/TK/ljYhmSODb9Xm5Nyls2vZq7cboI2KOaPPdeqcS
	HdutiRyQ0rydWVWsUXML+rBfAyIdpy9ptKvRnLU+CwJbIgBBpOLgRz8CXF64JSe+rOgdot68/p/
	VQIb9gH5a62nRtXHRqXtYzLRr/eORAtO8e+4rIs+T6EI+nyDN5NQ==
X-Gm-Gg: AYBFou3DG75NWEpYC+iTnZ3eYAGcpSMvELTe+5VOyVyXewpwqvJx/DqEydLZrx61Dtu
	pbK3nEKABa5TmTw21qsTol69sAbgVpemSXh0UVGzq1ZFnJDAOQkWXu0gdobzHoE91W7s2gWQQRd
	PnRR/CccMmyU9ZiiUXmD5VSc1LnPe5dq6OFvL6iSVylRW7AP4JAdJZcGFY+Gc6hp0DEG8HRCuE8
	QzxNVtkNRofxUyH3iVDet4cLksUd3w1RuveCLf4WAjXnZStOkQyNHldddZCfAl9zGKg3Udu+RqG
	BBtH7BIBXVFcN9A3TNKaeCHzbNoFNU0yDws/x7+c4o3J9MPv4rEExASrPhcO3ox1M2tOUZlYPQH
	EcTDSJlqvLFSewlG9p+IptceoY3BsT2ykAwEUqpPP22hB29HIi8FvhtQOBUe6TatdpFLqfqNeNE
	ygTXEMFRtq8ZqGiA==
X-Received: by 2002:a05:6402:50c6:b0:6a8:d72a:3b21 with SMTP id 4fb4d7f45d1cf-6aac9108d83mr2336984a12.44.1790263855216;
        Thu, 24 Sep 2026 08:30:55 -0700 (PDT)
X-Received: by 2002:a05:6402:50c6:b0:6a8:d72a:3b21 with SMTP id 4fb4d7f45d1cf-6aac9108d83mr2336962a12.44.1790263854529;
        Thu, 24 Sep 2026 08:30:54 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:54 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 05/14] ceph: add BLOG logger core
Date: Thu, 24 Sep 2026 15:30:35 +0000
Message-Id: <20260924153045.994784-6-amarkuze@redhat.com>
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

Add blog_core.c: central logger, source-ID registry with per-callsite
caching (smp_store_release/smp_load_acquire plus generation counter),
circular entry buffer, and iteration API for debugfs consumers.

blog_log_client_emit() is the noinline helper that writes a record
from TLS argument scratch, so boutc() call sites do not allocate
struct blog_arg[] on the VFS stack.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_core.c | 297 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)
 create mode 100644 fs/ceph/blog_core.c

diff --git a/fs/ceph/blog_core.c b/fs/ceph/blog_core.c
new file mode 100644
index 000000000000..3b5bca332625
--- /dev/null
+++ b/fs/ceph/blog_core.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BLOG logger: source-ID registry and log iteration.
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
+#include <linux/hash.h>
+
+#include <linux/rhashtable.h>
+#include "blog.h"
+#include "blog_batch.h"
+#include "blog_pagefrag.h"
+#include "blog_ser.h"
+#include "blog_des.h"
+#include "blog_module.h"
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
+static u32 blog_source_hash(const char *fmt, unsigned int line, u32 mask)
+{
+	return (hash_ptr((void *)fmt, 32) ^ line) & mask;
+}
+
+/**
+ * blog_get_source_id - Get or create a source ID for the given location
+ * @logger: Logger instance to use
+ * @file: Source file name
+ * @func: Function name
+ * @line: Line number
+ * @fmt: Format string
+ */
+u32 blog_get_source_id(struct blog_logger *logger, const char *file,
+		       const char *func, unsigned int line, const char *fmt)
+{
+	struct blog_source_info *info;
+	u32 id, slot, first;
+
+	if (!logger || !logger->source_hash)
+		return 0;
+
+	spin_lock(&logger->source_lock);
+	slot = blog_source_hash(fmt, line, logger->source_hash_mask);
+	first = slot;
+	do {
+		id = logger->source_hash[slot];
+		if (!id)
+			break;
+		info = &logger->source_map[id];
+		if (blog_source_matches(info, file, func, line, fmt))
+			goto out_unlock;
+		slot = (slot + 1) & logger->source_hash_mask;
+	} while (slot != first);
+
+	id = logger->next_source_id;
+	if (id >= logger->max_source_ids) {
+		spin_unlock(&logger->source_lock);
+		pr_warn_once("blog: source ID overflow\n");
+		return 0;
+	}
+
+	/* No empty slot in the hash table. */
+	if (logger->source_hash[slot]) {
+		spin_unlock(&logger->source_lock);
+		pr_warn_once("blog: source hash full\n");
+		return 0;
+	}
+
+	logger->next_source_id = id + 1;
+	info = &logger->source_map[id];
+	info->file = file;
+	info->func = func;
+	info->line = line;
+	info->fmt = fmt;
+	info->warn_count = 0;
+	logger->source_hash[slot] = id;
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
+	struct blog_logger *cached_logger;
+	u64 generation;
+	unsigned int seq;
+	u32 sid;
+
+	if (!logger)
+		return 0;
+	if (!cache)
+		return blog_get_source_id(logger, file, func, line, fmt);
+
+	/* Callsites are shared by mounts, so read one lockless snapshot. */
+	do {
+		seq = read_seqcount_begin(&cache->seq);
+		sid = cache->id;
+		cached_logger = cache->logger;
+		generation = cache->generation;
+	} while (read_seqcount_retry(&cache->seq, seq));
+	if (sid && cached_logger == logger &&
+	    generation == logger->generation)
+		return sid;
+
+	spin_lock(&cache->lock);
+	sid = cache->id;
+	if (sid && cache->logger == logger &&
+	    cache->generation == logger->generation)
+		goto out;
+
+	sid = blog_get_source_id(logger, file, func, line, fmt);
+	if (sid) {
+		write_seqcount_begin(&cache->seq);
+		cache->logger = logger;
+		cache->generation = logger->generation;
+		cache->id = sid;
+		write_seqcount_end(&cache->seq);
+	}
+
+out:
+	spin_unlock(&cache->lock);
+	return sid;
+}
+
+struct blog_source_info *blog_get_source_info(struct blog_logger *logger, u32 id)
+{
+	if (!logger || unlikely(id == 0 || id >= logger->max_source_ids))
+		return NULL;
+	return &logger->source_map[id];
+}
+
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
+	/* Reject truncated / corrupt payloads before deserializing. */
+	if (iter->current_offset + sizeof(*entry) + entry->len >
+	    iter->end_offset)
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
+int blog_des_entry(struct blog_logger *logger, struct blog_log_entry *entry,
+		   char *output, size_t out_size, blog_client_des_fn client_cb)
+{
+	int len = 0;
+	struct blog_source_info *source;
+
+	if (!entry || !output)
+		return -EINVAL;
+
+	if (client_cb) {
+		len = client_cb(output, out_size, entry->client_id);
+		if (len < 0)
+			return len;
+		if (len >= out_size)
+			return len;
+	}
+
+	source = blog_get_source_info(logger, entry->source_id);
+	if (!source) {
+		len += scnprintf(output + len, out_size - len,
+				 "[unknown source %u]", entry->source_id);
+		return len;
+	}
+
+	/* Snapshot under source_lock (same pattern as blog_sources_show). */
+	{
+		const char *file, *func, *fmt;
+		unsigned int line;
+		int ret;
+
+		spin_lock(&logger->source_lock);
+		file = source->file;
+		func = source->func;
+		line = source->line;
+		fmt = source->fmt;
+		spin_unlock(&logger->source_lock);
+		if (!file) {
+			len += scnprintf(output + len, out_size - len,
+					 "[unknown source %u]",
+					 entry->source_id);
+			return len;
+		}
+
+		len += scnprintf(output + len, out_size - len, "[%s:%s:%u] ",
+				 file, func, line);
+		if (len >= out_size)
+			return len;
+
+		ret = blog_des_reconstruct(fmt, entry->buffer, entry->len,
+					   output + len, out_size - len);
+		if (ret < 0)
+			return ret;
+		len += ret;
+	}
+
+	return len;
+}
+
+noinline void blog_log_client_emit(struct blog_tls_ctx *ctx,
+				   struct ceph_client *client,
+				   struct blog_source_id_cache *cache,
+				   const char *file, const char *func,
+				   unsigned int line, const char *fmt,
+				   size_t nargs)
+{
+	struct blog_logger *logger;
+	struct blog_arg *args;
+	size_t size;
+	void *buffer;
+	void *tmp;
+	u32 sid;
+	u32 client_id;
+
+	BUILD_BUG_ON(sizeof(struct blog_tls_pagefrag) >= BLOG_PAGEFRAG_SIZE);
+
+	if (unlikely(!ctx || !cache || nargs > BLOG_MAX_ARGS))
+		return;
+
+	logger = ctx->logger;
+	if (unlikely(!logger))
+		return;
+
+	args = ctx->arg_scratch;
+	sid = blog_get_source_id_cached(logger, cache, file, func, line, fmt);
+	if (unlikely(!sid))
+		return;
+
+	client_id = ceph_blog_get_client_id(client);
+	size = blog_args_size(args, nargs);
+	buffer = blog_log_with_ctx(logger, ctx, sid, client_id, size);
+	if (!buffer)
+		return;
+
+	tmp = buffer;
+	buffer = blog_serialize_args(buffer, args, nargs);
+	blog_log_commit_with_ctx(logger, ctx, buffer - tmp);
+}
-- 
2.34.1

