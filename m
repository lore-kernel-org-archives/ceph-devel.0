Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32A427F9E
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230606; cv=none; b=c2+DQ6rliJDsTgIddIbbsqUHXNVGJDky2XeiiP6H+2K1rPRS+3JHrrq/UPFWAWRYRzO2UqyYKCVhUC7z4rxJkXvilI5CLPydLoxCkgkuwTmcu8jUuIonyZO2o2cm/O0e0eadZx9Xc9jwcAmYWuOfXmqltVsMm/jAoXbT5rca/x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230606; c=relaxed/simple;
	bh=E509Fcg+TB6PvLrS2AYXCGeLg4bwHr660WkFxZqKWEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVECf8mVTmwHcqi3OCud+G47FIFGxPKRvAflGbkBnV2ddMhDruPoveEgfX7kGUdOtBJpH2/TqcrqrBDrd1CNXiiKu+jQ1hGpVBqAbTXmzi3N14uhHI13Bg+XHjB5ju7IpIOYelGZQ+ETUvCWxIMiRl9BXO868xHvS4R80oQx/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0ikawMV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqC0zHIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0ikawMV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqC0zHIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5Kxe8ehIcRPSx3slJFkhDK7XBNkgvoVXqYsdSinCsk=;
	b=A0ikawMVuD94AlBSufFKGtLvi38JbRz6k6FrVTjUZyRXTcZ+gthII6keePLK8BoatXiNO3
	/t7vxObDw5s+0+1vgLK1Vl+PLd1aXmrRARKX8yfaAlsrKTNCMgTN1hsPdoXRrjl29Bh+vQ
	QAH38FrxPtohOEU5J6O+rh6ENkY3LxQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-UsVSWpQSPSqfW4b0Epfq3A-1; Thu, 20 Aug 2026 08:56:34 -0400
X-MC-Unique: UsVSWpQSPSqfW4b0Epfq3A-1
X-Mimecast-MFC-AGG-ID: UsVSWpQSPSqfW4b0Epfq3A_1787230593
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c21946c03e5so95170466b.0
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230593; x=1787835393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U5Kxe8ehIcRPSx3slJFkhDK7XBNkgvoVXqYsdSinCsk=;
        b=bqC0zHIEoC39OH8kVCL0LtLRgeymEtBTFbbWduldvAQsPcN83z5YvVjZvko34VLhLR
         IdMylECf/E8V4iTPrm+iHVC9zN9SLe+upfEPZlesG8JxC6WtdJ3oYLwom82hIQ7bYMON
         kL45QepNXBekngsO97d0SdwtkIWyvcscVZ0npESNdNEzbW08+xhSVczc1nGdncuNHtb8
         voY96PmYKjF6nvvLhwB4C2TK7zDD1KOEaoc5xi4HLFjVEQw5nNUQvINiO0mKGF9aAfXk
         baRA7KlNRqjXANyp4n25gN/GmSTwOiKOmJ5Suy4ZhpzhjeSlFTtYRsosnGE2qHKk+aMX
         x/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230593; x=1787835393;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5Kxe8ehIcRPSx3slJFkhDK7XBNkgvoVXqYsdSinCsk=;
        b=HLs7bdETht3K3D1HDLI9/cfTdpAGeYCh1LyflWkXgWaPEVlEIT1s4DAU0jIcw1SS+s
         II9fkQC8pVo4wE+yD11ZjNqP3ji9Rqn0aWtJ0aMCZz1Vm9ei6oX5NlVgfoHU1CHIrg7H
         Cy9s2oBjwh9T6q1rY6ap8mLq7n0290TXCJKIMcObjVzU/WiKcu89KwcOGgRI5MfGjs1R
         5PExMYquphxMtye08S5qr19syGAEQTA+kKEsZzGkDI9Ghp3N4LhGA/YpR0MeKzHdpRJh
         4u56DV/cuFj7a2wSECcb/Pkjxek5+dnSoSZjXudoEzeGKqnzucls8IzA/TutkVoTtuDC
         MhHA==
X-Gm-Message-State: AOJu0YyPKysJplIWlugaLyix9lUSy8zUhNw85uo2ztGaSHF5TVnSxMNN
	VyjiegoXMipJLMdq7s5rrB66gG2M11zl3fc9m9pTPVoBdJ1eviLZmAd/X4ykbwdhNBL9kwANJPI
	zVVQv2hQ1Xc6wr7kzafhgc5YgMqJI8OjQ76Au6LS+bPsKugDHxqLbH8dFx4IuUbiCAw3jExGThM
	DBfPQ9jkp5V7iKYCnlWt/uIrk+0QgoOePhMbSnTnEYaep0qOj1zQ==
X-Gm-Gg: AR+sD12YCuUy+UIs6CfklLLRsvBo0uzxpe/Coat04ZfQPcWygQRUGjSKWbIvWEj+mpL
	8DrGYmMVp9Ic9UFZx1zZkfYBAJOFgzHcJM09rmd7MFj58DWJ21HOThl17h+F4lJwp3fGmMJ81OP
	TfmbtJvqPAzjWDhcze6JM9M16IPZnITcGPaE05g25Kqtk3aNQOemLxKTZ4KjIuK/AqFpj+6/ELZ
	Tfl1lkooV/BJOGbpKERsdcq3dHQKDrKfv3KJTv81frDHfmqf1az8GPkkjG88MrBcQEZMHFIgZnl
	gWIlY7wT3i0epUfe3HE+WjOBEm6KEr+GPynbGFxFdKaw7n+/7OEKZpv3c7fY9Rkva+WfuLPcEU1
	8+iHDPyrR49pYxqcsupkgDVQyRCCJtBgJxg==
X-Received: by 2002:a17:907:e8c:b0:c20:f85f:e7c6 with SMTP id a640c23a62f3a-c244d69f833mr418304566b.8.1787230593114;
        Thu, 20 Aug 2026 05:56:33 -0700 (PDT)
X-Received: by 2002:a17:907:e8c:b0:c20:f85f:e7c6 with SMTP id a640c23a62f3a-c244d69f833mr418301166b.8.1787230592588;
        Thu, 20 Aug 2026 05:56:32 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:31 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 10/14] ceph: add BLOG debugfs interface
Date: Thu, 20 Aug 2026 12:56:13 +0000
Message-Id: <c5e6992169b6a1bbb1f0775c9c9202a16b44109e.1787229471.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787229471.git.amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add blog_debugfs.c: per-superblock debugfs files under
/sys/kernel/debug/ceph/<fsid>/blog/ (entries, stats, sources,
clients, enable, clear).  Wire lifecycle hooks in super.c and
debugfs.c.  Readers use smp_load_acquire() on pf->head to pair
with writers' smp_store_release() publication.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_debugfs.c | 713 +++++++++++++++++++++++++++++++++++++++++
 fs/ceph/debugfs.c      |  11 +-
 2 files changed, 721 insertions(+), 3 deletions(-)
 create mode 100644 fs/ceph/blog_debugfs.c

diff --git a/fs/ceph/blog_debugfs.c b/fs/ceph/blog_debugfs.c
new file mode 100644
index 000000000000..e5df659c30f3
--- /dev/null
+++ b/fs/ceph/blog_debugfs.c
@@ -0,0 +1,713 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ceph BLOG debugfs interface
+ *
+ * Provides debugfs entries to view and manage BLOG entries for Ceph
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
+ * blog_entries_show - Show all BLOG entries for Ceph
+ *
+ * Iterates through all contexts, deserializing their pagefrag entries.
+ *
+ * To avoid holding logger->lock for the entire (potentially large)
+ * iteration, we use an ID-cursor: each pass finds the next context by
+ * ascending ID, drops logger->lock, and snapshots only its published bytes
+ * under pf->lock.  snapshot_mutex keeps retained contexts from being
+ * reclaimed between the list lookup and the snapshot.
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
+		/* Find the next context by ascending ID */
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
+		 * advance just because head is non-zero — that may be
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
+/**
+ * blog_stats_show - Show BLOG statistics
+ */
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
+/**
+ * blog_sources_show - Show all registered source locations
+ */
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
+/**
+ * blog_clients_show - Show all registered Ceph clients
+ */
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
+/**
+ * blog_clear_write - Clear all BLOG entries (write-only)
+ */
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
+/**
+ * ceph_blog_debugfs_init - Initialize Ceph BLOG debugfs entries
+ * @fsc: CephFS client whose debugfs directory hosts BLOG entries
+ *
+ * Return: 0 on success, negative error code on failure
+ */
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
+	/* Create debugfs entries */
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
+/**
+ * ceph_blog_debugfs_cleanup - Clean up Ceph BLOG debugfs entries
+ * @fsc: CephFS client whose BLOG debugfs directory should be removed
+ */
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

