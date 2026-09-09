Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482F559C9F
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958480; cv=none; b=lxLlXZb3pBPmol2Hv9Fyl4cYcT1jNNqi0gLSQxrxzhyQGd/rVt2XwoH0od9Hfqj4s/nBAJKbwPbQDlJqYznxHYf9T+QKR53zOgreVZVOblw1KglMVqciDwoImF73dLky8nxQAkzb7pyckhjshxVK06+MoFS04H2l/eDhcdjCoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958480; c=relaxed/simple;
	bh=nFio7HX2DuDfqdCjCXtqpL9E3qGGtq48B0xMbRDJK1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRIucBLXx0EypD7KwAUyVrImLihzrCL5cLOoCxTBqEKrSk5ejoHaUCBYWstlcq77bf7OQ3ZX1yw1LwIFLVrjtmN/LQxv62ROyJUMENXvDyVHbp6hHO6GRLJwl1EtIVBIr0YcA+1XBNU02q8ukI+FL+l+bu1AXlNDUPgVDWrrqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4QXVp9l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sOB8yfdw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4QXVp9l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sOB8yfdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JOv7COTm0IFjR6xwADCj7iiHmhK0RwAQI6UdSR2gkE=;
	b=a4QXVp9lsVx7m3zNJsUiQOVasX+mLSvpdSErDWyH4OlCUx0rQKlGs6RVz7p0qRmmbp29Zq
	+YsW3e89PFb9ajxdpVCVhEJmPfDoZ6Pbh+DtwJ/uPfMErkQi+gnhWTKoPBcI0Gf0LX/JfR
	UjX/8oOe4IFa7dLjEgLb67fYPAP8ess=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-rmCQNuSbO12rHN2nO_wCTA-1; Wed, 09 Sep 2026 08:54:34 -0400
X-MC-Unique: rmCQNuSbO12rHN2nO_wCTA-1
X-Mimecast-MFC-AGG-ID: rmCQNuSbO12rHN2nO_wCTA_1788958474
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e62e3459fso904122185a.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958474; x=1789563274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9JOv7COTm0IFjR6xwADCj7iiHmhK0RwAQI6UdSR2gkE=;
        b=sOB8yfdw43GAAF5NP9+s7JlyYijfJKM349SzOIG8dS8vI/BbT+OR48HgjV4DTSnBRQ
         cGQRMjVOwNR5RVtM2VjoEafU68T0av8NR+uuLD52pjOLJxjLKRCBVMSS0W/WinuIAGMb
         GHrVgQ6xeEwLqKcth/Ox5/C4f8bvQRyATSOREBi/JNyLTlPMOgjZV+DJmzX6uFWjLIhR
         8RXDjJH9QY0TvfjKcxvuVF1IlrAgNDrZnW0zITu9pmvnAoooc25ry7bOLjJ59bHWY0qu
         zi+4Znn8sHRF6a+AfJJDzgfySosTVL/Osu6N3pHaB9qFrBbQGqgIue3xNphpMZxYeE50
         ReZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958474; x=1789563274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9JOv7COTm0IFjR6xwADCj7iiHmhK0RwAQI6UdSR2gkE=;
        b=Mgyu1nFuNoHMkrePcIyF7kSE47/JKtRVcQ7afuvYcxV2BPz0oARGm8AI4kll72lGm/
         rWTuD+LF6kMHi4T3PNt3ttetX78rZ9aI8BFwlFljXo21E4uCgqFb8yBEGa4bxA8pGqm9
         FVL4BeJMsy6Xo/VKrkWExGZ1gCT4OtRISxukCWHf8m3nLz0UYSxjyyl1uIzOHJQijnkO
         4rzQicI8xHBRDXZoeidavsGbonRdqa6XqdogKo5UANGL/z56A+iwbuTOL3suORnEesmB
         Z0pUB1MC84duIbCpqoVSzbl83dWcFhUxlWtGWcxsmln8cf1JIpRx/PYyvZH50ff1Qv41
         6I6A==
X-Gm-Message-State: AFuF++mKFpdGeTy8PWbRtugDw8n/Mt8XyC/PBQxCm/peA+E8mrPGuXJ/
	VSdgwJW5a6j+FAZvrHo7ENTIAW2FzkihCSnViTqMH90PvJHSTo3zP+PeJF7KFyr2ogBPQQV56Ly
	EvQNUmMhHfr1x7rPS/avkBRSlmg/oXkAr/EFz37yqP3cohefaURXUWOXWt54Wvr2PNGPgq++OMi
	vURi3+SZ42j6Ho/r6iXFJfR9ziz1OdqbRH0eI59s7zeLoitMNUZQ==
X-Gm-Gg: AYBFou1Ebqf0VDsc+OAK2HZaHp3KuAmDDja7R5X3nATk0c+jrXtHd3MTdP5ft3Lnnoo
	CSHAYv1e/1gzXAQ4Fuq4JTy7XGmwu5kr25zKncdIUCtDZweXp90NX6qEy5UBDPrqrlDY1B0ZU7/
	yjRSXxF2AGc/66uqJDUCrAudmICMLJSNaU79EzWKCANO2ksiG2GpxKoQZ6ZiwReRvEnAnWp01yx
	9tRTPz7x5MuZYYlmoFRPv0OkDEXR/oHoRTulUOcSLQU34pHqZK8L5OOFsW0sAZA204M/Boy8qf9
	S7HMOIn5DSkDjnpjsP+MCejsahQilC0Hw8aS6VTTRR0IcTIuju/3YJZ/nOCx0p52BHWT0kF1tk5
	4w5vVCJYl2XvMdQu69gS/5wbtjqN9LXKozJzP0Q3A/gat9sswPJt/Y7H/S9Ai7W/5ANeKxQ6b7e
	9f9Hm2Y49j+1JTwg==
X-Received: by 2002:a05:620a:8805:b0:939:c96a:518f with SMTP id af79cd13be357-939c96a52a9mr697774685a.19.1788958473681;
        Wed, 09 Sep 2026 05:54:33 -0700 (PDT)
X-Received: by 2002:a05:620a:8805:b0:939:c96a:518f with SMTP id af79cd13be357-939c96a52a9mr697765885a.19.1788958472902;
        Wed, 09 Sep 2026 05:54:32 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:32 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 10/14] ceph: add BLOG debugfs interface
Date: Wed,  9 Sep 2026 12:54:12 +0000
Message-Id: <20260909125416.3969532-11-amarkuze@redhat.com>
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

Add blog_debugfs.c: per-superblock debugfs files under
/sys/kernel/debug/ceph/<fsid>/blog/ (entries, stats, sources,
clients, enable, clear).  Wire lifecycle hooks in super.c and
debugfs.c.

Document blog_entries_show() parameters.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_debugfs.c | 688 +++++++++++++++++++++++++++++++++++++++++
 fs/ceph/debugfs.c      |  11 +-
 2 files changed, 696 insertions(+), 3 deletions(-)
 create mode 100644 fs/ceph/blog_debugfs.c

diff --git a/fs/ceph/blog_debugfs.c b/fs/ceph/blog_debugfs.c
new file mode 100644
index 000000000000..1052ca26decf
--- /dev/null
+++ b/fs/ceph/blog_debugfs.c
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ceph BLOG debugfs.
+ */
+
+#include <linux/ceph/ceph_debug.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/jiffies.h>
+#include <linux/timekeeping.h>
+#include <linux/ceph/ceph_blog.h>
+#include "blog.h"
+#include "blog_des.h"
+#include "blog_module.h"
+
+#include "super.h"
+
+static int jiffies_to_formatted_time(u64 jiffies_value, char *buffer,
+	size_t buffer_len);
+
+struct blog_dbg_file {
+	struct ceph_fs_client *fsc;
+	struct blog_module_context *ctx;
+};
+
+static int blog_dbg_pin(struct ceph_fs_client *fsc,
+			struct blog_dbg_file *priv)
+{
+	struct blog_module_context *ctx;
+
+	if (!fsc)
+		return -ENODEV;
+
+	/*
+	 * Module + blog_ctx refs only.  No open-count wait on fsc:
+	 * debugfs_create_file() already get/puts around read/write, so
+	 * remove waits for in-flight ops; release must not touch fsc.
+	 */
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	rcu_read_lock();
+	ctx = rcu_dereference(fsc->blog_ctx);
+	if (ctx && !refcount_inc_not_zero(&ctx->refcount))
+		ctx = NULL;
+	rcu_read_unlock();
+
+	priv->fsc = fsc;
+	priv->ctx = ctx;
+	return 0;
+}
+
+static void blog_dbg_unpin(struct blog_dbg_file *priv)
+{
+	if (priv->ctx)
+		blog_module_put(priv->ctx);
+	module_put(THIS_MODULE);
+}
+
+static struct blog_logger *blog_dbg_logger(struct blog_dbg_file *priv)
+{
+	if (!priv || !priv->ctx)
+		return NULL;
+	return READ_ONCE(priv->ctx->logger);
+}
+
+/**
+ * blog_entries_show - dump decoded records
+ * @s: seq_file to write
+ * @p: unused iterator cookie
+ *
+ * ID-cursor walk: each pass finds the next context by ascending ID, drops
+ * logger->lock, and snapshots only its published bytes under pf->lock.
+ * snapshot_mutex keeps retained contexts from being reclaimed between the
+ * list lookup and the snapshot.
+ */
+static int blog_entries_show(struct seq_file *s, void *p)
+{
+	struct blog_dbg_file *priv = s->private;
+	struct blog_logger *logger;
+	struct blog_tls_ctx *ctx;
+	void *buf_copy;
+	char *output_buf;
+	int entry_count = 0;
+	u64 cursor_id = 0;
+
+	logger = blog_dbg_logger(priv);
+	if (!logger) {
+		seq_puts(s, "Ceph BLOG context not initialized\n");
+		return 0;
+	}
+
+	buf_copy = kmalloc(BLOG_TLS_PAGEFRAG_BUFFER_SIZE, GFP_KERNEL);
+	if (!buf_copy)
+		return -ENOMEM;
+	/* Match live buffer capacity so long reconstructed lines are not cut. */
+	output_buf = kmalloc(BLOG_TLS_PAGEFRAG_BUFFER_SIZE, GFP_KERNEL);
+	if (!output_buf) {
+		kfree(buf_copy);
+		return -ENOMEM;
+	}
+
+	for (;;) {
+		struct blog_tls_ctx *best = NULL;
+		struct blog_pagefrag *pf;
+		unsigned long base_jiffies;
+		struct blog_pagefrag tmp_pf;
+		struct blog_log_iter iter;
+		struct blog_log_entry *entry;
+		u64 best_id = U64_MAX;
+		u64 head;
+		int ret;
+
+		mutex_lock(&logger->snapshot_mutex);
+		spin_lock(&logger->lock);
+		list_for_each_entry(ctx, &logger->contexts, list) {
+			if (ctx->id > cursor_id && ctx->id < best_id) {
+				best = ctx;
+				best_id = ctx->id;
+			}
+		}
+
+		if (!best) {
+			spin_unlock(&logger->lock);
+			mutex_unlock(&logger->snapshot_mutex);
+			break;
+		}
+
+		pf = blog_ctx_pf(best);
+		/* Idle contexts lagging a clear look empty immediately. */
+		if (atomic64_read(&best->clear_seq) !=
+		    atomic64_read(&logger->clear_seq)) {
+			spin_unlock(&logger->lock);
+			cursor_id = best_id;
+			mutex_unlock(&logger->snapshot_mutex);
+			continue;
+		}
+		spin_unlock(&logger->lock);
+
+		/*
+		 * Snapshot published prefix under pf->lock.  Buffer is SZ_4K,
+		 * so holding the lock across the copy is cheaper and safer
+		 * than an unbounded head/head2 retry loop.
+		 */
+		spin_lock(&pf->lock);
+		head = smp_load_acquire(&pf->head);
+		base_jiffies = READ_ONCE(best->base_jiffies);
+		if (head)
+			memcpy(buf_copy, pf->buffer, head);
+		spin_unlock(&pf->lock);
+
+		/*
+		 * Rotate publishes the snapshot (id swap + contexts insert)
+		 * before clearing live and without snapshot_mutex.  After
+		 * we dropped logger->lock it can move best_id onto a
+		 * snapshot and give this ctx a new id.  Any id mismatch
+		 * means this copy is not the retired window; leave the
+		 * cursor so the next walk finds the snapshot.  Do not
+		 * advance just because head is non-zero. That may be
+		 * the *new* live tail.
+		 */
+		spin_lock(&logger->lock);
+		if (best->id != best_id) {
+			spin_unlock(&logger->lock);
+			mutex_unlock(&logger->snapshot_mutex);
+			continue;
+		}
+		cursor_id = best_id;
+		spin_unlock(&logger->lock);
+		mutex_unlock(&logger->snapshot_mutex);
+
+		if (!head)
+			continue;
+
+		/* Deserialize and output outside any lock */
+		memset(&tmp_pf, 0, sizeof(tmp_pf));
+		tmp_pf.buffer = buf_copy;
+		tmp_pf.capacity = head;
+		tmp_pf.head = head;
+
+		blog_log_iter_init(&iter, &tmp_pf, head);
+
+		while ((entry = blog_log_iter_next(&iter)) != NULL) {
+			char time_buf[64];
+			u64 entry_jiffies;
+
+			entry_count++;
+			memset(output_buf, 0, BLOG_TLS_PAGEFRAG_BUFFER_SIZE);
+			ret = blog_des_entry(logger, entry,
+					     output_buf,
+					     BLOG_TLS_PAGEFRAG_BUFFER_SIZE,
+					     ceph_blog_client_des_callback);
+			if (ret < 0) {
+				seq_printf(s,
+					   "[Error deserializing entry %d: %d]\n",
+					   entry_count, ret);
+				continue;
+			}
+			entry_jiffies = base_jiffies + entry->ts_delta;
+			if (jiffies_to_formatted_time(entry_jiffies, time_buf,
+						      sizeof(time_buf)) < 0)
+				strscpy(time_buf, "(invalid)", sizeof(time_buf));
+			if (ret > 0 && output_buf[ret - 1] == '\n')
+				output_buf[ret - 1] = '\0';
+			seq_printf(s, "%s %s\n", time_buf, output_buf);
+		}
+	}
+
+	kfree(output_buf);
+	kfree(buf_copy);
+	return 0;
+}
+
+static int blog_entries_open(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = blog_dbg_pin(inode->i_private, priv);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	ret = single_open(file, blog_entries_show, priv);
+	if (ret) {
+		blog_dbg_unpin(priv);
+		kfree(priv);
+	}
+	return ret;
+}
+
+static int blog_dbg_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct blog_dbg_file *priv = seq ? seq->private : NULL;
+	int ret = single_release(inode, file);
+
+	if (priv) {
+		blog_dbg_unpin(priv);
+		kfree(priv);
+	}
+	return ret;
+}
+
+static const struct file_operations blog_entries_fops = {
+	.owner = THIS_MODULE,
+	.open = blog_entries_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = blog_dbg_release,
+};
+
+static int blog_stats_show(struct seq_file *s, void *p)
+{
+	struct blog_dbg_file *priv = s->private;
+	struct blog_logger *logger = blog_dbg_logger(priv);
+
+	seq_puts(s, "Ceph BLOG Statistics\n");
+	seq_puts(s, "====================\n\n");
+
+	if (!logger) {
+		seq_puts(s, "Ceph BLOG context not initialized\n");
+		return 0;
+	}
+
+	seq_puts(s, "Ceph Module Logger State:\n");
+	seq_printf(s, "  Total contexts allocated: %lu\n",
+		   logger->total_contexts_allocated);
+	seq_printf(s, "  Next context ID: %llu\n",
+		   READ_ONCE(logger->next_ctx_id));
+	seq_printf(s, "  Next source ID: %u\n",
+		   READ_ONCE(logger->next_source_id));
+
+	seq_puts(s, "\nAllocation Batch:\n");
+	seq_printf(s, "  Full magazines: %u\n",
+		   READ_ONCE(logger->alloc_batch.nr_full));
+	seq_printf(s, "  Empty magazines: %u\n",
+		   READ_ONCE(logger->alloc_batch.nr_empty));
+
+	seq_puts(s, "\nLog Batch:\n");
+	seq_printf(s, "  Full magazines: %u\n",
+		   READ_ONCE(logger->log_batch.nr_full));
+	seq_printf(s, "  Empty magazines: %u\n",
+		   READ_ONCE(logger->log_batch.nr_empty));
+
+	return 0;
+}
+
+static int blog_stats_open(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = blog_dbg_pin(inode->i_private, priv);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	ret = single_open(file, blog_stats_show, priv);
+	if (ret) {
+		blog_dbg_unpin(priv);
+		kfree(priv);
+	}
+	return ret;
+}
+
+static const struct file_operations blog_stats_fops = {
+	.owner = THIS_MODULE,
+	.open = blog_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = blog_dbg_release,
+};
+
+static int blog_sources_show(struct seq_file *s, void *p)
+{
+	struct blog_dbg_file *priv = s->private;
+	struct blog_logger *logger = blog_dbg_logger(priv);
+	struct blog_source_info *source;
+	const char *file, *func, *fmt;
+	unsigned int line;
+	int warn_count;
+	u32 id;
+	int count = 0;
+
+	seq_puts(s, "Ceph BLOG Source Locations\n");
+	seq_puts(s, "===========================\n\n");
+
+	if (!logger) {
+		seq_puts(s, "Ceph BLOG context not initialized\n");
+		return 0;
+	}
+
+	for (id = 1; id < logger->max_source_ids; id++) {
+		source = blog_get_source_info(logger, id);
+		if (!source)
+			continue;
+
+		spin_lock(&logger->source_lock);
+		file = source->file;
+		func = source->func;
+		line = source->line;
+		fmt = source->fmt;
+		warn_count = source->warn_count;
+		spin_unlock(&logger->source_lock);
+		if (!file)
+			continue;
+
+		count++;
+		seq_printf(s, "ID %u: %s:%s:%u\n", id, file, func, line);
+		seq_printf(s, "  Format: %s\n", fmt ? fmt : "(null)");
+		seq_printf(s, "  Warnings: %d\n", warn_count);
+
+		seq_puts(s, "\n");
+	}
+
+	seq_printf(s, "Total registered sources: %d\n", count);
+
+	return 0;
+}
+
+static int blog_sources_open(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = blog_dbg_pin(inode->i_private, priv);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	ret = single_open(file, blog_sources_show, priv);
+	if (ret) {
+		blog_dbg_unpin(priv);
+		kfree(priv);
+	}
+	return ret;
+}
+
+static const struct file_operations blog_sources_fops = {
+	.owner = THIS_MODULE,
+	.open = blog_sources_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = blog_dbg_release,
+};
+
+static int blog_clients_show(struct seq_file *s, void *p)
+{
+	struct blog_dbg_file *priv = s->private;
+	struct ceph_fs_client *fsc = priv->fsc;
+	struct ceph_client *client;
+	u32 client_id;
+
+	seq_puts(s, "Ceph BLOG Mount Client\n");
+	seq_puts(s, "======================\n\n");
+
+	if (!fsc || !fsc->client) {
+		seq_puts(s, "client unavailable\n");
+		return 0;
+	}
+
+	client = fsc->client;
+	client_id = READ_ONCE(client->blog_client_id);
+
+	seq_printf(s, "FSID: %pU\n", &client->fsid);
+	if (client->monc.auth)
+		seq_printf(s, "Global ID: %llu\n", client->monc.auth->global_id);
+	else
+		seq_puts(s, "Global ID: (unavailable)\n");
+	if (client_id)
+		seq_printf(s, "Cached BLOG client ID: %u\n", client_id);
+	else
+		seq_puts(s, "Cached BLOG client ID: (unassigned)\n");
+	if (ceph_blog_is_enabled(fsc))
+		seq_puts(s, "BLOG enabled: yes\n");
+	else
+		seq_puts(s, "BLOG enabled: no\n");
+
+	return 0;
+}
+
+static int blog_clients_open(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = blog_dbg_pin(inode->i_private, priv);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	ret = single_open(file, blog_clients_show, priv);
+	if (ret) {
+		blog_dbg_unpin(priv);
+		kfree(priv);
+	}
+	return ret;
+}
+
+static const struct file_operations blog_clients_fops = {
+	.owner = THIS_MODULE,
+	.open = blog_clients_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = blog_dbg_release,
+};
+
+static ssize_t blog_clear_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct blog_dbg_file *priv = file->private_data;
+	struct blog_logger *logger = blog_dbg_logger(priv);
+	char cmd[16];
+
+	if (count >= sizeof(cmd))
+		return -EINVAL;
+
+	if (copy_from_user(cmd, buf, count))
+		return -EFAULT;
+
+	cmd[count] = '\0';
+
+	/* Only accept exact "clear" (optional trailing newline) */
+	if (strncmp(cmd, "clear", 5) != 0 ||
+	    (cmd[5] != '\0' && cmd[5] != '\n'))
+		return -EINVAL;
+
+	/*
+	 * Bump clear_seq so readers treat lagging contexts as empty until
+	 * their next write resets the pagefrag.  Also set NEEDS_RESET so a
+	 * concurrent writer notices promptly.  Hold snapshot_mutex so a
+	 * concurrent entries snapshot cannot copy pre-clear data after
+	 * this write returns.
+	 */
+	if (logger) {
+		struct blog_tls_ctx *tls_ctx;
+
+		mutex_lock(&logger->snapshot_mutex);
+		spin_lock(&logger->lock);
+		atomic64_inc(&logger->clear_seq);
+		list_for_each_entry(tls_ctx, &logger->contexts, list)
+			set_bit(BLOG_CTX_NEEDS_RESET, &tls_ctx->flags);
+		spin_unlock(&logger->lock);
+		mutex_unlock(&logger->snapshot_mutex);
+		pr_debug("ceph: BLOG entries cleared via debugfs\n");
+	}
+
+	return count;
+}
+
+static int blog_clear_open(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = blog_dbg_pin(inode->i_private, priv);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	file->private_data = priv;
+	return 0;
+}
+
+static int blog_clear_release(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv = file->private_data;
+
+	if (priv) {
+		blog_dbg_unpin(priv);
+		kfree(priv);
+	}
+	return 0;
+}
+
+static const struct file_operations blog_clear_fops = {
+	.owner = THIS_MODULE,
+	.open = blog_clear_open,
+	.write = blog_clear_write,
+	.release = blog_clear_release,
+	.llseek = noop_llseek,
+};
+
+static ssize_t blog_enabled_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct blog_dbg_file *priv = file->private_data;
+	char tmp[32];
+	int len;
+
+	len = scnprintf(tmp, sizeof(tmp), "%llu\n",
+			(u64)READ_ONCE(priv->fsc->blog_enabled));
+	return simple_read_from_buffer(buf, count, ppos, tmp, len);
+}
+
+static ssize_t blog_enabled_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct blog_dbg_file *priv = file->private_data;
+	u64 val;
+	int ret;
+
+	ret = kstrtoull_from_user(buf, count, 0, &val);
+	if (ret)
+		return ret;
+	if (val > 1)
+		return -EINVAL;
+
+	ret = ceph_blog_set_enabled(priv->fsc, val);
+	return ret ? ret : count;
+}
+
+static int blog_enabled_open(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = blog_dbg_pin(inode->i_private, priv);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	file->private_data = priv;
+	return 0;
+}
+
+static int blog_enabled_release(struct inode *inode, struct file *file)
+{
+	struct blog_dbg_file *priv = file->private_data;
+
+	if (priv) {
+		blog_dbg_unpin(priv);
+		kfree(priv);
+	}
+	return 0;
+}
+
+static const struct file_operations blog_enabled_fops = {
+	.owner = THIS_MODULE,
+	.open = blog_enabled_open,
+	.release = blog_enabled_release,
+	.read = blog_enabled_read,
+	.write = blog_enabled_write,
+	.llseek = generic_file_llseek,
+};
+
+int ceph_blog_debugfs_init(struct ceph_fs_client *fsc)
+{
+	struct dentry *dir;
+
+	if (!fsc || !fsc->client || !fsc->client->debugfs_dir)
+		return -EINVAL;
+	if (fsc->debugfs_blog)
+		return 0;
+
+	dir = debugfs_create_dir("blog", fsc->client->debugfs_dir);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+	fsc->debugfs_blog = dir;
+
+	debugfs_create_file("enabled", 0600, fsc->debugfs_blog, fsc,
+			    &blog_enabled_fops);
+	debugfs_create_file("entries", 0444, fsc->debugfs_blog, fsc,
+			    &blog_entries_fops);
+
+	debugfs_create_file("stats", 0444, fsc->debugfs_blog, fsc,
+			    &blog_stats_fops);
+
+	debugfs_create_file("sources", 0444, fsc->debugfs_blog, fsc,
+			    &blog_sources_fops);
+
+	debugfs_create_file("clients", 0444, fsc->debugfs_blog, fsc,
+			    &blog_clients_fops);
+
+	debugfs_create_file("clear", 0200, fsc->debugfs_blog, fsc,
+			    &blog_clear_fops);
+
+	pr_debug("ceph: BLOG debugfs initialized\n");
+	return 0;
+}
+
+void ceph_blog_debugfs_cleanup(struct ceph_fs_client *fsc)
+{
+	if (!fsc || !fsc->debugfs_blog)
+		return;
+
+	debugfs_remove_recursive(fsc->debugfs_blog);
+	fsc->debugfs_blog = NULL;
+	pr_debug("ceph: BLOG debugfs cleaned up\n");
+}
+
+static int jiffies_to_formatted_time(u64 jiffies_value, char *buffer,
+	size_t buffer_len)
+{
+	u64 now_ns = ktime_get_real_ns();
+	u64 now_jiffies = get_jiffies_64();
+	u64 delta_jiffies = (now_jiffies > jiffies_value) ?
+		now_jiffies - jiffies_value : 0;
+	u64 delta_ns = jiffies64_to_nsecs(delta_jiffies);
+	u64 event_ns = (delta_ns > now_ns) ? 0 : now_ns - delta_ns;
+	struct timespec64 event_ts = ns_to_timespec64(event_ns);
+	struct tm tm_time;
+
+	if (!buffer || !buffer_len)
+		return -EINVAL;
+
+	time64_to_tm(event_ts.tv_sec, 0, &tm_time);
+
+	return scnprintf(buffer, buffer_len,
+			"%04ld-%02d-%02d %02d:%02d:%02d.%03lu",
+			tm_time.tm_year + 1900, tm_time.tm_mon + 1, tm_time.tm_mday,
+			tm_time.tm_hour, tm_time.tm_min, tm_time.tm_sec,
+			(unsigned long)(event_ts.tv_nsec / NSEC_PER_MSEC));
+}
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 18eb5da03411..6a9a5551d9d7 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -11,12 +11,12 @@
 #include <linux/ktime.h>
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
-
 #include <linux/ceph/libceph.h>
 #include <linux/ceph/mon_client.h>
 #include <linux/ceph/auth.h>
 #include <linux/ceph/debugfs.h>
 #include <linux/ceph/decode.h>
+#include <linux/ceph/ceph_blog.h>
 
 #include "super.h"
 
@@ -650,6 +650,9 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove_recursive(fsc->debugfs_reset_dir);
 	debugfs_remove(fsc->debugfs_subvolume_metrics);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
+
+	ceph_blog_debugfs_cleanup(fsc);
+
 	doutc(fsc->client, "done\n");
 }
 
@@ -728,10 +731,12 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 		debugfs_create_file("subvolumes", 0400,
 				    fsc->debugfs_metrics_dir, fsc,
 				    &subvolume_metrics_fops);
+
+	ceph_blog_debugfs_init(fsc);
+
 	doutc(fsc->client, "done\n");
 }
 
-
 #else  /* CONFIG_DEBUG_FS */
 
 void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
@@ -742,4 +747,4 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 {
 }
 
-#endif  /* CONFIG_DEBUG_FS */
+#endif	/* CONFIG_DEBUG_FS */
-- 
2.34.1

