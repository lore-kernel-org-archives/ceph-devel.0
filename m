Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AF559C9B
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958472; cv=none; b=X/SmTeYWfNImz13nuYS65Gd4N0p1Vvyi9BoqnyOTSYJKEFogHD2wPeZ6u5+q+Nkf+RsWBxSsXuX6dx7RZDMUVCUb2v9OSMUhPeDycT/UcV+4PXDAepFXk652IiqH4mp/TG3LVSqudp2wqWlblUvcu4rqSNgYTMlr1sLhWhjdIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958472; c=relaxed/simple;
	bh=zJJW6Ug6wkcIpc7hn5n4HTImnTjCzgM3Ky17nsuPcbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7gGCAifAWgmk6kaKNEla9CUKNy/h7RwRgg52ZboH+jopzzt2XZp9GAPwduqH6Vzxkk0kCKKSe6GsrP4R7HZSgLlEwisKS4N5pyAJHi+EAab572PV8Zp5jiGrkWsRvrI7QEhPH8e6zSXKamF1f+kl8WXF7FwkUD6IMb9KeJPKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhGXB8Cr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tpBevhb6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhGXB8Cr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tpBevhb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
	b=DhGXB8CrpQK1fpbEL4shSqld2/7HZ1jKOSxj22HhUwL/uc7WVnNo4jWpEnHENHGmoS7TUX
	tD/3xS6nUV1PSVWrjscfPk8Gdlqy9nIWOBVmuKjefA33Q+J6VhlkDhFTsd4qpDX4Xs6w/4
	3+TPRPSGi+VrCeqkQIlttLgbLE9bjOo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-_W3p6iU5OUyHhVG10FRR8Q-1; Wed, 09 Sep 2026 08:54:27 -0400
X-MC-Unique: _W3p6iU5OUyHhVG10FRR8Q-1
X-Mimecast-MFC-AGG-ID: _W3p6iU5OUyHhVG10FRR8Q_1788958467
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939c30aa9a0so162814185a.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958467; x=1789563267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
        b=tpBevhb6nwF0lsSOGS35QCeIliZcfSUAkSBH/jDml21nrhxdmd+v/yPG5npjNO5UJ1
         R8Rs6SabpzD6UUiLJToBd6Uap+LvB74QM5HDmYl2lkRI9RT7W8UWDxusl8uWEYPtJ1My
         sOhhLg3ll8SVvhNg1UtqQ5l0uhfMfz2FtWUyAyLyXEHQlrHsGPeJ8doCIjPBbTCXymbJ
         4KnlfkyIqDaWKh+mjZbLcqrloiDZgX5zPL5K+1echKH+LBjUq+P27SE6WoPfwHCJLd7O
         wUzoRdIB6YGsNjSuQh4GsyTrKgcx53WxYnV8ntWVhoqwYc0RqtxspDGP+l4BlUfaYdxS
         6Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958467; x=1789563267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmSw6Ni31zj7pByeFkFSHapvx5I70UMMXEya7lZFNuE=;
        b=rr0K6Rrw5+QVGsFOLxn66l5V+WCotUYiww9kt47gtAhdMGd4+NGEuZmnJuElS2qZ0Q
         xod9vxKdwI9RHPzSmlHK5Novjo0nu7D9hjbKx2Yf6xymqSzqFOwAtBI2/AppDGPhKUpO
         qGu9RhEXy86lWoftawonTO0D7+9PDV2NGBf032pkT0p7Nc0F3A4wGop+LHjMdt0hRQIW
         5Khz9iH7foFJ+BYt08WdMsCoAjnEc792WEK2BeqPxA+I0ZuYAQZSR2EsbwqRacazEC9K
         46CKET1OVC9/wF17Zs40fNqTNOw5wngGfheM2J/QzVPYlkAKnEXBBM0sC6JLtKKldhs9
         zhKg==
X-Gm-Message-State: AFuF++lh5GUwb+Z0UaPqSbPVF3uyzi3Ne4FrcyICn7eY7nlnPveCu9KL
	CLVORgz0ubgqePhT1R4zqpfUg0QjikHoteb+D1HxD+qiP70s6ulmE6BM5IMD6a+h+BoZjFhJrta
	1derlGvtRHmhPTB8sNJaJUZA/myDw9PU5DePx8uoZPLqQu87ldGGOYt7cMwLWJoWBe3q1k+ZbgM
	otiu9gi8Aqx8By2aklBFKF9ITLZAWWATYHaj2mPnLSgdygzRbznQ==
X-Gm-Gg: AYBFou3bj6X3nPHfD2amzcsoNEIaMvDCh5dl5QhdlZNxlqcW+O+BMzjgHiSFhRaxMGL
	+8TXkrIuurjldZ7b/nAYbHW8gBiIiAgMWLgESRoOTjVRv4w6jERqZgZeS53OZKH6JOWqIBhthW0
	sfH8inv0VjIOePXp1zufVuvTz2chKQNdKd+5BkOUqwTS65lLoghzMSrCioOU4aYailrA5cOTe9j
	9vS0lkVx8/xRGRho/DILZUwjxUo76RJMeFqrbNeGY/eMPdL2UYd+/CCPMQQM48t0+p84Ym7gTdc
	QOSNWDdcD/eysDs0L1sK7vOTIiTNpqoBejGc2i8UIYaR1MacNqI/tUc2WuQrOXW/zTQlW496K1q
	7dlStBr2yFFO3KB1wDBV8Xw3yrDTl0uksLKpy8nzd3SuDMQU0gmx96aadmf15RKvPD+gocQsMpF
	tYjqHpt3xrrSulFQ==
X-Received: by 2002:a05:620a:c4f:b0:939:cb1a:2c59 with SMTP id af79cd13be357-939cb1a2f27mr576423685a.22.1788958466935;
        Wed, 09 Sep 2026 05:54:26 -0700 (PDT)
X-Received: by 2002:a05:620a:c4f:b0:939:cb1a:2c59 with SMTP id af79cd13be357-939cb1a2f27mr576414885a.22.1788958466232;
        Wed, 09 Sep 2026 05:54:26 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:25 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 05/14] ceph: add BLOG logger core
Date: Wed,  9 Sep 2026 12:54:07 +0000
Message-Id: <20260909125416.3969532-6-amarkuze@redhat.com>
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

