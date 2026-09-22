Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F954B1B3
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085672; cv=none; b=pmJAIQ9S9kH4nUiboMQSpa5OH/Zv1c3KHGvLHTMAVkJ/bysOGUHaZ8pKptWWyfBH20mXsocqHuv6qKbHnxn9Hu8+r9kjZb0E3dRav/j+lrOAHyppLXsGD6To/2GrWLEcA1UCUt2xQWpFOSLkRxTTcJorlXsgLBIjMePA54pnQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085672; c=relaxed/simple;
	bh=zJJW6Ug6wkcIpc7hn5n4HTImnTjCzgM3Ky17nsuPcbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=js8yZRnYc03azmvR1Ba0gj+ek/RfQ/iIolF6cnuxdEw9h6F1/iT9VsWyVwINs+eAiTWVnGfzroz5CEakLeMZFSfyLg0s/disWy//mEJYX/fbDY6y297u3MjN9Z/tueAPqXg+StAZVVQa+nxJrcNTm8eOXfGvHYdgfBQqVeyRRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjOcHkkT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t1vJCz+8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjOcHkkT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t1vJCz+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
	b=XjOcHkkTFC5/4812+8UUk27Qo1J1+KyeJSs1FTtbgzSo9OFHvd32OHYkxFYiTsmhFHNFaN
	a0mwcIHhF81ovbF4QqrQvdDKFibhJoftL0Qtx0cVskvjvZZMkiDuwWKL06Zs4r3rT0LPs9
	qOxOdkfILsBHZUHLQoZdul83b+WfW70=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-v2c9rC8_P-e8Qf9-sGVDtw-1; Tue, 22 Sep 2026 10:01:08 -0400
X-MC-Unique: v2c9rC8_P-e8Qf9-sGVDtw-1
X-Mimecast-MFC-AGG-ID: v2c9rC8_P-e8Qf9-sGVDtw_1790085668
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90cdc69a7b5so87490746d6.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085667; x=1790690467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
        b=t1vJCz+86CNKqP6nHf5OdrdKPjMTtbsXaNqSrwMrJtxAQWeVe11G8FC8ZG+2I5YQH3
         ctWkF7FVUKl1m+Bgz87OLvyDbL1EOEtU4USc8s6E5PIobB52xLg6Oofs8aidqX7J4jl/
         Gr39TroeoMKkPO1Tr+kZWJ6YttOQqaLLoRfeZQOuT0nUjJQEM6us5tHeDw/tO3R+zeqB
         Ec0lNhHK5a91XjgpOFMB4uyZGC3rUJqV4b2MIlD4PjktyAOeIn2DZAH2s+PBIr/RZYmq
         OwhPT6LVOrK8pyJvlzmm77ac7EYwmnpEvbOL2khPuZM2FDiRH7uM6wMrnpEwgeN2tf64
         36HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085667; x=1790690467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
        b=bNClWMhyfaj/W4/fr+zdc+jL0XG2T1jU/PKD7ug5sXNtpxRL5HkZN50wYN3YD/nA7k
         Q9OtKLnIQ7l7QzVOkPblnL2HDhd5TOMctEFIQF/kOtUdJM09NFtR91pdfvnwKumVzOlp
         AWA+ZLq9CyJfbYvPJoc5dqawxfoDm49XwKRgN+6arzigM3XU4YFeXH4C69W6ogKPcTKs
         O31uYC/Zhds2yL2AbZoI+15IfmzNG6pbviICeUuQXFx6nS4IKL0Edxj45CXIJWbqDHUV
         JkBzT0LU4h83RI9yGKrGKoIyNrNdi9otgc4tIiS3hT8pNbDx8ot2nSfViBsNSXq8VW/3
         NVTQ==
X-Gm-Message-State: AFuF++kUWlK33tChI22FSHs1HvKAbgrvINKdEXK50jWSXMoXrj4MVhYw
	BptEsLtlVuN/0QGsu32QF+mHGq2TpMkjuzknPi55mpZq10UoC3cnE2ZhC8OSmcXXu5sIR1HlBbe
	UFwdXpAdYrBMaJ8KD2kRaPzQY0662nDKTGhemXh+iWj+J1oFSf6GF5osotTDXOKwEXs4JBfVxZg
	DmYDAxM5sUdKHbbpo1wMugM0ub1ZSuLZhH+5pdZ61dEcl6OdhXwA==
X-Gm-Gg: AYBFou24MVD02S/q3ikgn2ruSnJW2gg0IxGhov9AinMGO+5mQ7i6VXSnIoJhNxOlJys
	odET3wgfive9FZHp7qqqNG+5Tp2LBjlq5bSwCg3tnPOLIbw5hcIjsnX4DM+Xiic+el+3H+IC6kP
	r//0GcOgbwxY5R2eXREYGhzxUB6+ebyYykhjgvaW4jQBMTjHBt5PHZoPqnIZ3nc4gi3zewochIA
	tRqPi6NrOzBLdEIzRAKPf8ggKxfvETvuE1pXn5rAJiwJ8Mso6dwSV1IVWFFdizKeLr2Y1c02DlU
	RZEQFMVyRXh+AW11sYhmdmZvKsKwbbxUAQ7WlAYL3YxPyVXKta4S4Y27dHU949Y4oIprpUEtDuw
	rsGaqW742Q9PiJR5nmujleJi0LcQfGI6/ALal12SFaWEzOcHkeJn8g36C1wCEyNZnQWST/INoZh
	eir0EixqL4GsRaEw==
X-Received: by 2002:a05:620a:44c8:b0:939:fc74:b6af with SMTP id af79cd13be357-93c15d763b9mr580684385a.11.1790085667371;
        Tue, 22 Sep 2026 07:01:07 -0700 (PDT)
X-Received: by 2002:a05:620a:44c8:b0:939:fc74:b6af with SMTP id af79cd13be357-93c15d763b9mr580666085a.11.1790085665204;
        Tue, 22 Sep 2026 07:01:05 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:01:03 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 05/14] ceph: add BLOG logger core
Date: Tue, 22 Sep 2026 14:00:38 +0000
Message-Id: <20260922140047.794405-6-amarkuze@redhat.com>
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

