Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B524AA41C
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366493; cv=none; b=paApPeRjYxQ26yqk4a7Aga2/9iOdNe5eTf/4JnCVBcNTvwJhRXM7fzudizkhQbK/bmtaNPIIJj1OltXdVAR67eieQf38dKPZ5Q1iK7Sjv5rPtXNJMdffjaAnNmSw2HDJ0TBFSSXpXRLf5B/nACOEe0gqbN9W+LE4V+LFY03Vn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366493; c=relaxed/simple;
	bh=XU7Upg8EhsrZxsM55inb48icA3aB/PHQJKaZxoQliQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYhLT1FLCQ/vWZNx1p86cupaHy43h4ze9eh6ugIVElR2jqSFmjxkQahntUDrIngr+FkSN+SFOZJsF4yB90uKfZJk06q1GL+Rjc3nlKNe6Hn9iC6TqRHvfALu1XBp+Mj4B+TLDo//36o0KMAm3DXz3yK37IToDkskriUy8lN5GP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b67jOYJP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt5WVbZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b67jOYJP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt5WVbZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPXmswcf+58bdL65W9Mk/juRYEfrp0BoyNzrbzjLsZg=;
	b=b67jOYJPSz/7RqD/nDNKjwhIYcI40Gnie8TuyDjRrMHJjkWU1zQWD0cGNpG+ipvrreu7P5
	pxVT91FQdoxcCbN8wxWnAzw9dtuG/jd/3iT/Cw7ZmsQor+auT6eoxFL84jC7PnBcPeTSg5
	xWzNUIqa67bLh+4TWlKYD9EnxlTzd9A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-0pVaHIUjMVW0ziMkizk4cw-1; Wed, 02 Sep 2026 12:28:08 -0400
X-MC-Unique: 0pVaHIUjMVW0ziMkizk4cw-1
X-Mimecast-MFC-AGG-ID: 0pVaHIUjMVW0ziMkizk4cw_1788366487
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c253185765dso134185766b.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366487; x=1788971287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPXmswcf+58bdL65W9Mk/juRYEfrp0BoyNzrbzjLsZg=;
        b=Yt5WVbZf7dcc/Viyte71rUrN37MD1/hin+Wi2N3ERc+wKA9tQOrp2aLdmfzFl+XrmM
         0VDFd+Sb4I/mVayXyu0vdKaUM8lEW8ntqfpLLKLuKDUz7TL4263Jx3zzSPVsYdMXkU9v
         BDKH1tl9HIhPRbn7poadcxLyLFKVOsT9MpUUS728r6uy21ZE8H5t2KUbXHL7rUze8T7j
         4CPSwVU1ffN/JJE3tuOQgmkNCJ9bFBxvDW/RkKb0IcXouawGKhXmTLFN+xeJuc0Q6wul
         7Uzopvuz0rnz3HTzWk29zP39Ce86TmWFNmYFC+j/hHivPEcKywUMyKDzwhY1pvNNyteq
         pJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366487; x=1788971287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPXmswcf+58bdL65W9Mk/juRYEfrp0BoyNzrbzjLsZg=;
        b=UVRzhJIWQkgNGtzHtfeNDfkm5++HifriY4Bk2/IlftbsS2Br0To6LdzQJmIRWlzKEV
         87KWoDKQMKgBw0UG9xNbPIsQ8L5a3wA3VyepewAEzK+reiAXv9H/64f7MVw9KXBdd7kV
         GjsdQftVMCq2O/856uMycATCb58p0/ov9Y3WKqlJbp51suf9XJqazGfqO/zsXL0wS1Aw
         lYBlWmLh+f2Zb8l5lhBx3pPvdIsTniy3tdTXyBz/DkezMH6pYJQ/WS5Kw01rnZMEdkRs
         Qun1iPEgX4CIv6eODDeaQCFNnnMReuTbQVwRmRlH+H0k2EMcakKxyq7DcFtjVjyDSjy2
         Wyyw==
X-Gm-Message-State: AFuF++kMJ+arj2PAK/xj1S7FIBqJSkdRVri3t8vUuS6FCjW/ZTgejOMa
	EK+fj8nxv4P9OtRQnAW9Yax5ZuzqUcXYTx8pcqtC7V0K25wwKPtmlHwmQIZi7hU6KAJQDAvAolI
	0whgUJVVkMkr1fKgPRL/NF7e/XMaq8Q25DQYJ8fWihx6if0ljlBZGawQp4U99zrZvR4LmXCwfTp
	x3Nedsd38cRFpN8R4+jVoeKE0g8RUvbc+I4JbGmp9lBHT0Psxvew==
X-Gm-Gg: AYBFou1ipBFkdoqnPs+iAQlJrlsKxaT6veR6xBhrZ3RxOIXp64C5rgno3jPssXqfO+c
	7M8R0t0NGbEDm8f5+smD5Nc44Xy6ULn7ZsRhVOtocMWRJUDBXESRD+n4ku20oHZElg9om8vuyBY
	n+GDEFJF7JCYUkBMJq54kKPazNH49eRtAXBRkl4lVR6i3Ajq6zFf72O2FfI9Dz3wN5IicpfoHJW
	84czOtMS6WNlYNIEW2AdOQb8Nzrb/e6ENJCtTNJ7uROTTLihoBR1QNLF8NpFflylrjP+RFSHSeM
	WBczX9AsEY57bAJPbNzKkcOlpAthRH+Ay/56EV0Za/UNSkScUVWni8caibBgEVN9GW1V30wnB+n
	flqw/nl4pQFV3z7ZXM5W73Kk+ikqHdT3jrWcTIJhe0GsAkiHSilWzXDtzVbfBHAavlVQ1viXbCB
	x6H44hyCdVo/Bmrg==
X-Received: by 2002:a17:906:6a06:b0:c25:88e2:fe25 with SMTP id a640c23a62f3a-c25d53cd18bmr308496766b.7.1788366486801;
        Wed, 02 Sep 2026 09:28:06 -0700 (PDT)
X-Received: by 2002:a17:906:6a06:b0:c25:88e2:fe25 with SMTP id a640c23a62f3a-c25d53cd18bmr308493866b.7.1788366486222;
        Wed, 02 Sep 2026 09:28:06 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:05 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 05/14] ceph: add BLOG logger core
Date: Wed,  2 Sep 2026 16:27:51 +0000
Message-Id: <20260902162800.3197342-6-amarkuze@redhat.com>
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

Add blog_core.c: central logger, source-ID registry with per-callsite
caching (smp_store_release/smp_load_acquire plus generation counter),
circular entry buffer, and iteration API for debugfs consumers.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_core.c | 257 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100644 fs/ceph/blog_core.c

diff --git a/fs/ceph/blog_core.c b/fs/ceph/blog_core.c
new file mode 100644
index 000000000000..1be908e6a6d7
--- /dev/null
+++ b/fs/ceph/blog_core.c
@@ -0,0 +1,257 @@
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
-- 
2.34.1

