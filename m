Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C439CCFE
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230601; cv=none; b=PviMEs9Ea/byOV1ulfB4rcxi67bI6Z57pu3z2gOGa9IENGN4qTq3tm4z3SmcYQFh0Lfuqi2EusXl836olCTv66kWiPvsvi3WtkWwMbaF7iNSyabDzkDrE3t/DWGt5wgaCo1auU7fjqL8ZGkg9ZUeq0lt23WCQ8oQo91fW9hIqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230601; c=relaxed/simple;
	bh=LGyXFGxBDQGYoCFQinYNjyfCmEyDHXrEQpRZbYlGXbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoMV9dJRzbaVYl26YcUqRkPnK7VY9LY5WQfH77WGvJQikiIe8zwNcU5zdnXWLKzVUFzKfraiIrC/5SkJB0f+rVxicMy6nd+8ORYV8rPNEfYmzwOiP/jkeanWeQwfaLtOj8jPNonACQspwh4NXn9vtyOQDoMl4VWPq2EabqFM350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXDYdxfL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAhgmQuf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXDYdxfL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAhgmQuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXelj5aDRYdBks39i9SNzOWxFxFGlFx6k67NTDxVp2o=;
	b=NXDYdxfLb2/PqeXE1THhp2Yqg0Zsg8posJxkTBdpNVbubgVw2/Lsj9PlyjHlmDak/31Y1t
	mG8hZ7ABvQtUwKnROjAujXC4HWzqhP6y+Zn+Dhd3I6C2wa42RlQRYOFTzK5OT5UDG9FAmm
	qYL7QzGn4UyZ15qn9/jZkk2vUpd445w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-UB6zMuMDMwmvrV_djwVlbg-1; Thu, 20 Aug 2026 08:56:26 -0400
X-MC-Unique: UB6zMuMDMwmvrV_djwVlbg-1
X-Mimecast-MFC-AGG-ID: UB6zMuMDMwmvrV_djwVlbg_1787230585
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-69cd6606b19so1927321a12.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230585; x=1787835385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXelj5aDRYdBks39i9SNzOWxFxFGlFx6k67NTDxVp2o=;
        b=IAhgmQufU5s+HFO42479jmnOwjqKzedEXr/7AgoLf95PhyUWDy4La9Bfg4rZgtp9A4
         U1UMTw5vXH2y+LnnMBi/yrjOs5ScSfVx7SnxzJD12u+GStbsYc+79zH7RRtSc3q+hMN+
         KYTPEPAbPb/dqMSLyEtpXHYt2Yf5Mp86GHNrBCuU2NzLxuu4ezHzg7Ww4utMzfdWMN/U
         cDEzBHua6B0aZKcjcHw8tWYxBDHJpBEtZbgLWRpnNibxUK2G5BKCXMK9Iyb+qey1unKO
         Ntl2tqgpdZK/pUz46FvAvTlJSeOXharCKeSKYkW3JNHWtPZdlZveD24dMWzv47QqnuAX
         5smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230585; x=1787835385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXelj5aDRYdBks39i9SNzOWxFxFGlFx6k67NTDxVp2o=;
        b=DIvx2qGtPKa5LnbQY+I3wD4xj9bUYDNDotyJrUH4mj4fjfE3FCG4Zpkzs1956GHQR0
         tmOTy7/RrguxHaOWteAXDWwAV4Y4F3jVC8WPZP0IZQ5WWmVySQ5Fj5QuJNUS3rigbA19
         GmQzwNHR9LC6EuGFgnizfzkmmw+osAJLyhVrLZlGoaoVeh8fuDOV+siX1yTQQnHbCgmp
         xTaXBql1ttZbxlN0tvgvfWBHx9BpIGx4zYHHwPvaB/6kOsd9iapxGQAx3WfFvmDWPCTo
         +Y2Gvj6qDs9tyzt9qBnEHTTkjgIXlyJKCFUtqXApZ365vKctVHnHrAsKFoJCEn2AFwyO
         hR1g==
X-Gm-Message-State: AFuF++lg5EiCICaCplHb8hxy8O/4kYzy19Yh9/zniy+rM3hDT6SyV9p5
	agKs25cDA0O3YMKmZGGYFO7EMls5DJ6LIOYTiCthVnYFXs0+CD2fEFsWicsnw2QroDNFgoRdyin
	UA45wV5ubSrMW/gRYuAy9fPb0Q0it+H0tPUGDEzv37/yUlhhhMT4HiSAn4JJBLNDbuz0Yxzwsaa
	o9VML4XgzDE1GnyvBto8+WmNUbq2K3g/8/YDIJe6+5E9AS//Q5Jg==
X-Gm-Gg: AR+sD10koz09Z9w4/KP6ZS1dEnrQzQG6ixlDyWwXAyce1Acthd5gaeRm/3BM2jI3ELc
	Lq/znsKus3kbvbr+yeN5B4mRETDIu7pz5N3/tNqajPd8DMBNZ7oFKhbvTLRzIYzL952qWTIxibY
	q6jIOwItgrfw2s/gRVDxiItf5LJLLzgB2/yH5y9ilVb+qk9WKXvgF/CpA3B2qlys25/JrbkQu39
	KLiavAS2qb0ban/qOq0+ESLUtCcbx69TNhT7LmDyq+0VkrR4OcoAItX8B9ElU4ji7+SzTpnmwjA
	jwh2KzFsuuVA/U3E69wzbwuFVHi0EnjGM23i8fugUGV9ziiYcI+TYEPEQwIQ5mdtA50K2zTPAIF
	yDSC70rESrHAoMseZUUrOcEmidN9V744Fow==
X-Received: by 2002:a05:6402:44d6:b0:6a0:e963:f546 with SMTP id 4fb4d7f45d1cf-6a403361199mr7612408a12.15.1787230584863;
        Thu, 20 Aug 2026 05:56:24 -0700 (PDT)
X-Received: by 2002:a05:6402:44d6:b0:6a0:e963:f546 with SMTP id 4fb4d7f45d1cf-6a403361199mr7612361a12.15.1787230584341;
        Thu, 20 Aug 2026 05:56:24 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:23 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 05/14] ceph: add BLOG logger core
Date: Thu, 20 Aug 2026 12:56:08 +0000
Message-Id: <64e2d34021459c96512ba36c55f403f2ff1f3b89.1787229471.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787229471.git.amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
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
 fs/ceph/blog_core.c | 279 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 fs/ceph/blog_core.c

diff --git a/fs/ceph/blog_core.c b/fs/ceph/blog_core.c
new file mode 100644
index 000000000000..90e4c123a6f1
--- /dev/null
+++ b/fs/ceph/blog_core.c
@@ -0,0 +1,279 @@
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
+ *
+ * Returns a unique ID for this source location
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
+/**
+ * blog_get_source_info - Get source info for a given ID
+ * @id: Source ID
+ *
+ * Returns the source information for this ID
+ */
+struct blog_source_info *blog_get_source_info(struct blog_logger *logger, u32 id)
+{
+	if (!logger || unlikely(id == 0 || id >= logger->max_source_ids))
+		return NULL;
+	return &logger->source_map[id];
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
+		if (len >= out_size)
+			return len;
+	}
+
+	/* Get source info */
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
-- 
2.34.1

