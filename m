Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77374AA00B
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365064; cv=none; b=AWgilzBuMbsX2WZ/0V6es4oMpFZ+8HlBhrj76tqudc511LSvrsVZ/JUX9fq4PQLtj/6sHX0r9RKrV4EKT+6Yi1Gr1Vg1mB2Np+JyOAW28X0uwvYbwpmGWNVyuNZuc0B81Qr7E6CgnxUN278JMeBcZ5OD598GvcO7cIx32pYkoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365064; c=relaxed/simple;
	bh=XU7Upg8EhsrZxsM55inb48icA3aB/PHQJKaZxoQliQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGTGRz/Irg/lDcJ7p53lm9EFWlyu8lhOBMAWEHSqb8tWt8ocicdldUchG38OKutLWpWYplkjX5QtlJjDmSGribeatxs85BxY1SUJXxadDu0T1DT0vNCUcc5A8ihNyf9YPdp/Soy5TYKgn3TmpEXrPiOaUKhgp5+cEux0u6FXLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNELHkRz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuyKT1nO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNELHkRz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuyKT1nO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788365061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPXmswcf+58bdL65W9Mk/juRYEfrp0BoyNzrbzjLsZg=;
	b=ZNELHkRz+qzIIn6lGS7F+pIq3yRacircQdIbBkyxKJTNJp7jsjIMkUoN3kekM3UtvIEyQd
	OLu/lSIL9zKZBI6FKmt/rYhU/sVetLoFCIfavaUZICm1MMse+IuCZ4k9/r+eSH9zboTL4f
	RWMXyQ8KBMM8F2nepWj6CuEg55oPG9k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-AjCXLsyMOV6JgWEmYeFLUw-1; Wed, 02 Sep 2026 12:04:20 -0400
X-MC-Unique: AjCXLsyMOV6JgWEmYeFLUw-1
X-Mimecast-MFC-AGG-ID: AjCXLsyMOV6JgWEmYeFLUw_1788365059
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c25501f4aa2so2817466b.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788365059; x=1788969859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPXmswcf+58bdL65W9Mk/juRYEfrp0BoyNzrbzjLsZg=;
        b=PuyKT1nOexeSaDmDRLVoP8udhIV4kKzkLh2NrpVOA5ifi8S31XqtViABJ0eUdBP34Q
         qyz+FhDg8W6EypPDKSzxn7ihVQBhKWaI+l/sBqKMxiPQ/5XDLbAtW1q5Og+H9EYGvVY/
         dTA4c7uNS8Nif4+eHcpbdzINCUmVgibQ/uXqqNZQ5r4n9Mhenyq2FOCCy6jO19IWP+TS
         bW8IYoI3NS9V5M6W4HqejEh37PJCdY6Wqwr7vbHdTXfvYqyu5oi8uO+pxjKwUY4+Tx5W
         IvCaCMoD5L799DYuk3WC2RmNmyoAHXkOhTHExhqC0p3vYFo6P2x5D0nfgbjtjy58zEEv
         Qvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365059; x=1788969859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPXmswcf+58bdL65W9Mk/juRYEfrp0BoyNzrbzjLsZg=;
        b=DSWWb2HExKWzozaMkihVGvqz05peSwTwi/B/c2BIh0yyJAMGkMjWROsZKFv3LaAhSq
         IoXThwMFkskz4GOSihavdrqy2DtYK8RwcmDkG2KRbw7XKEyPPJDauiu0ogZbrcZw+lw2
         fcYOU3juur/hWf0x5EakeB7kc9bLQX25FgDz8DxVMO3+gSwcKaht4014eUP1k4Yb0DAw
         689moLxAVK5rYYSNW9ZcXCDFcRUBS6yCm8MuGmTsSEA39/q52bslowgr1a8fk74UvZJ7
         zST+4cIhYTqMhKZBGnOpKuxWosPZzvVAd+tDkFWXUxD5zKcszukJMCLsoR85jQz8JBzO
         tlTA==
X-Gm-Message-State: AFuF++nynib7DzXM4oe3o5C4XunD5rQC72VzHjifS4Pwj/ibcpiRhe83
	ovLCvXBgLB00QDRX67vRQ4eW0FUSRD0H+uM+I6Viv45+qVNlH7odtciEXUVr/s3dtHCJjceHaNz
	SDq6TmUuTP2VtsNEoV7VxPiDHHGt1W5IPc8aGottoZb7lM+9/daN6qxpOTqDB6IfT2ybSWiG9dY
	bCAjqdJrxBUXd1hkV/z90nPlDt4q6P8g4+KN8+hIZCGwhNAKo=
X-Gm-Gg: AYBFou1YTag9ux5D9RvAU8GqIw5OLyAyMbYGecISR+3eqXOZfYHNGctrsGKHSXVJrBS
	oabEmWSDKDvrR3tMDmQ17enidyIAT8ccOb7Fo0uEcRapFK3c4SVIONb38zteELeWs+bK7/QVZok
	FZ89gln61FJKEWVWeaQdL55Kjri2DJX0x8E82eTuf+eUBJc3a7yPESC+LysUc/eVG7GS1sNWsyC
	/CcTsx6O880hqIi+4/7cPP/6mdenIVwGnLdi1FKItFPKa2Nq6ZQISiEIg7cVrAUygWuEk1vSXry
	jb5Tv+i3wpxfFZtlV2E7E8lsqBsQ18UsU6D/BU8CY0mQFWw/Onp0F2ZxkQdzDgpQLk7v40T8c8I
	EVRLd9iyiyOu8dGnUMkPG7p3SAXzvWlE9nkgAa+GiL0lr4ZkKRwIPa31drb9Ywec4EpAfHn5X3G
	xFz0ucABW/ozlfxA==
X-Received: by 2002:a17:907:9309:b0:c12:3cbf:9f6d with SMTP id a640c23a62f3a-c25efb58f35mr15949966b.1.1788365058757;
        Wed, 02 Sep 2026 09:04:18 -0700 (PDT)
X-Received: by 2002:a17:907:9309:b0:c12:3cbf:9f6d with SMTP id a640c23a62f3a-c25efb58f35mr15915066b.1.1788365055144;
        Wed, 02 Sep 2026 09:04:15 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7108sm165874566b.10.2026.09.02.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:04:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 05/14] ceph: add BLOG logger core
Date: Wed,  2 Sep 2026 16:03:58 +0000
Message-Id: <20260902160407.3196013-6-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902160407.3196013-1-amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
 <20260902160407.3196013-1-amarkuze@redhat.com>
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

