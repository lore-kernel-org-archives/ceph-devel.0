Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2747798A
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708427; cv=none; b=AwV4gekr2otyK2da1xQGL/Q7MfGBPZwvxyBRIBxogu4kFgRi6OsgxvA/AheXjfnj1FQFrtV5K8Oaqcla6mpu1x3cX48FAfGTBXN65oFAYksh28tv0dTq9tcYGjh3DBpy605PNDk5y3yhWUVS11oRrqKChT+yjY/T2CaM8x2Wkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708427; c=relaxed/simple;
	bh=+AQaQ+qknVN0ja2mJ325ByhXSBwYyJCk20fEYGyI76I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmHhj+qy9zNPOceh2xki5NJmZW0WKF8L9SxMTclFcKFmrGJd1hJLyYTca8bBKOnWg1E/UXweO4iQylhTM+HNS6n3Q+PsX5IWZ6rnbyHaxGnNblwTwJ/sTswMwS7g4vT1xtpMOdGW3846z54fVK98Drvph4oYlybrzT7z389W+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjQBdxqu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQ/t3hJk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjQBdxqu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQ/t3hJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIzBTWUMfr/ueXHGXZN24HDX8fKNUCB2a6ut0kJQuB4=;
	b=cjQBdxqurjW3Vi3hWj9P19ngFgMYzTjzGkNRpn4+Z3MUeZMX5ZXrb7PeeE5UTy7zxQK2Vx
	cMNB5Sb/Anf7Po/v+J7aH2OCCn5Aws1x3W+nF6jQJbSAKJTmQRxSC1MAPnEIdfTcGsgjqv
	2e+6Gp5KWHJYvqA/p65uF955Hw2uWvw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-lAyyGjN5O-OfHZ_JQZ5zvw-1; Wed, 17 Jun 2026 11:00:15 -0400
X-MC-Unique: lAyyGjN5O-OfHZ_JQZ5zvw-1
X-Mimecast-MFC-AGG-ID: lAyyGjN5O-OfHZ_JQZ5zvw_1781708415
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4893fc86bebso3108069b6e.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708415; x=1782313215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIzBTWUMfr/ueXHGXZN24HDX8fKNUCB2a6ut0kJQuB4=;
        b=dQ/t3hJklyavgMYq9ew6n0VLUyZs11DvEsueK+65ZtPLDUKbHITFIU/we5rPHzg/Iz
         Yp4fBjZP51G6sLfh1fpBXyx0T6KH/939jGFvspZepAPFXuHQDHga81O/rol441WxcVlf
         Kvi6GSdZygIq5Uj6ya6uLdIzJFTqdbbgLqvNLLFnI1i8FKkWnyuFe0UriXt/6Nwn3NUA
         Zoi+uioeKQWBUhLNEon5IdGSmh03V6v74vSIxEF/R5dCmxCWrC+UPz397pZTbsE3tLyW
         KbuFNOLUE3acq10J3gl2EsP6KTL0QWmL4GqEpeKo6f6Go1eQFzGCwwUN/jkmP5KA/HEN
         VVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708415; x=1782313215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wIzBTWUMfr/ueXHGXZN24HDX8fKNUCB2a6ut0kJQuB4=;
        b=KCi2wTtfjVJVIzL7zNOcK/+aeD7R+12+PFjjpaXhY9C/z/oTSXmEG1UZnkDGzQ/uzR
         vet/WAfUcC0bUamMT8fEiv1olelRdFpDxjSf0PdYE3uZZiM2Z0GhnHG7ZW38QKQwPnT2
         B7r87m7YV8J5RrbvPbOqJ+T2ct7ocAaxU1y7tDREgj1FnzK8of/MlPBggZ+09huB6wsq
         ou2rvVvEP5hV9AEe7YmcHB2MULkf0fr8Asf26pRUwEJq7JZG8p01x6lCVVqI+HS2PCDe
         rAk+ItZvbBVjrddVy6EpoQ5+QBaGIWSszoLCJlrYW4uggkX4BSmdO9lA/edmTlv1aFRh
         V3Pw==
X-Gm-Message-State: AOJu0YweRLNXbKx0Yv1I960mh1N2TjZtbvDo2jLjK4CozlFxIKAKb/2Z
	AOSE4pyh3JnZysy8KkwkSbTwrcESsyprqkHn9Pm54rh2K53YfHePNQtG+stXdNenpw/Rkz0kRrR
	mqyFwTlvFNW1p49lzAqUuNBBgOb8RKH1dzcLK0EG2sm4K/Z3p8wMlCf+6zSnCXax4k5tWVjgpyI
	otMifQ3HD2EYDueb/4o0bYBoSS17cw1RDg/z0cOqAKtMADazwRIA==
X-Gm-Gg: Acq92OHWgi72ti1f3qa207rx2ku/OU7fuDYU30sFcvbud24gtOTPzROA1QyTaE0b4K2
	4J+G/94CK0zfnztc9TmY1entxcEjpNzQ55+eQBwKOtMvVE1Vx+0mD4DzC7NJvfS9G4H4kEslZnB
	yvCsnNgFqq3rZmerUBDkaaFLlwEtCshgAncyLWR/psmPiK1SB2mS34vKfo8lb8eZb0Kx9yiGPBS
	lHHuvXnsg1qEW0zqIowm/nj9jzByjUHSAmJqQaBPrJKGwaxa3uMp+4OulU5i94aT4SO1gVHFMiy
	i4YKBVLoC/pqhjB/eLxgs0kmeDMkTasB3RKhcvE/bZSHmQ0LNO3bFO/jfC65WspSnrdRDV3N3sP
	ETIJVF5GXWptycLxsReZXFI1tXF7+NpHKg2uRwz13itGg
X-Received: by 2002:a05:6808:1916:b0:485:3a3f:c2d6 with SMTP id 5614622812f47-489429df24cmr3880852b6e.31.1781708414433;
        Wed, 17 Jun 2026 08:00:14 -0700 (PDT)
X-Received: by 2002:a05:6808:1916:b0:485:3a3f:c2d6 with SMTP id 5614622812f47-489429df24cmr3880808b6e.31.1781708413537;
        Wed, 17 Jun 2026 08:00:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:13 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 10/15] ceph: add BLOG debugfs interface
Date: Wed, 17 Jun 2026 14:59:40 +0000
Message-Id: <20260617145945.1912736-11-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617145945.1912736-1-amarkuze@redhat.com>
References: <20260617145945.1912736-1-amarkuze@redhat.com>
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
debugfs.c.  Readers use smp_load_acquire() on pf->head to pair
with writers' smp_store_release() publication.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/Makefile       |   3 +
 fs/ceph/blog_debugfs.c | 434 +++++++++++++++++++++++++++++++++++++++++
 fs/ceph/debugfs.c      |  23 ++-
 fs/ceph/super.c        |  58 ++++--
 4 files changed, 500 insertions(+), 18 deletions(-)
 create mode 100644 fs/ceph/blog_debugfs.c

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index d1177badef00..f600ccf5c423 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -16,3 +16,6 @@ ceph-y += blog_client.o
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
 ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
+ifdef CONFIG_DEBUG_FS
+ceph-y += blog_debugfs.o
+endif
diff --git a/fs/ceph/blog_debugfs.c b/fs/ceph/blog_debugfs.c
new file mode 100644
index 000000000000..c32327d6fb24
--- /dev/null
+++ b/fs/ceph/blog_debugfs.c
@@ -0,0 +1,434 @@
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
+#include <linux/ceph/blog.h>
+#include <linux/ceph/blog_des.h>
+
+#include "super.h"
+
+static int jiffies_to_formatted_time(u64 jiffies_value, char *buffer,
+	size_t buffer_len);
+
+static struct blog_logger *ceph_blog_debugfs_logger(struct ceph_fs_client *fsc)
+{
+	if (!fsc || !fsc->blog_ctx || !fsc->blog_ctx->logger)
+		return NULL;
+
+	return fsc->blog_ctx->logger;
+}
+
+/**
+ * blog_entries_show - Show all BLOG entries for Ceph
+ *
+ * Iterates through all contexts, deserializing their pagefrag entries.
+ *
+ * To avoid holding logger->lock for the entire (potentially large)
+ * iteration, we use an ID-cursor: each pass acquires the lock, finds
+ * the next context by ascending ID, snapshots its buffer under
+ * pf->lock, releases both locks, then outputs outside any lock.
+ */
+static int blog_entries_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
+	struct blog_logger *logger;
+	struct blog_tls_ctx *ctx;
+	void *buf_copy;
+	char *output_buf;
+	int entry_count = 0;
+	u64 cursor_id = 0;
+
+	logger = ceph_blog_debugfs_logger(fsc);
+	if (!logger) {
+		seq_puts(s, "Ceph BLOG context not initialized\n");
+		return 0;
+	}
+
+	buf_copy = kmalloc(BLOG_TLS_PAGEFRAG_BUFFER_SIZE, GFP_KERNEL);
+	if (!buf_copy)
+		return -ENOMEM;
+	output_buf = kmalloc(1024, GFP_KERNEL);
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
+			break;
+		}
+
+		/* Snapshot the buffer while both locks are held */
+		pf = blog_ctx_pf(best);
+		spin_lock(&pf->lock);
+		head = smp_load_acquire(&pf->head);
+		if (head) {
+			memcpy(buf_copy, pf->buffer, head);
+			base_jiffies = best->base_jiffies;
+		}
+		spin_unlock(&pf->lock);
+		cursor_id = best_id;
+		spin_unlock(&logger->lock);
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
+			memset(output_buf, 0, 1024);
+			ret = blog_des_entry(logger, entry,
+					     output_buf, 1024,
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
+	return single_open(file, blog_entries_show, inode->i_private);
+}
+
+static const struct file_operations blog_entries_fops = {
+	.open = blog_entries_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/**
+ * blog_stats_show - Show BLOG statistics
+ */
+static int blog_stats_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
+	struct blog_logger *logger = ceph_blog_debugfs_logger(fsc);
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
+	seq_printf(s, "  Next context ID: %llu\n", logger->next_ctx_id);
+	seq_printf(s, "  Next source ID: %u\n",
+		   atomic_read(&logger->next_source_id));
+
+	seq_puts(s, "\nAllocation Batch:\n");
+	seq_printf(s, "  Full magazines: %u\n", logger->alloc_batch.nr_full);
+	seq_printf(s, "  Empty magazines: %u\n", logger->alloc_batch.nr_empty);
+
+	seq_puts(s, "\nLog Batch:\n");
+	seq_printf(s, "  Full magazines: %u\n", logger->log_batch.nr_full);
+	seq_printf(s, "  Empty magazines: %u\n", logger->log_batch.nr_empty);
+
+	return 0;
+}
+
+static int blog_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, blog_stats_show, inode->i_private);
+}
+
+static const struct file_operations blog_stats_fops = {
+	.open = blog_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/**
+ * blog_sources_show - Show all registered source locations
+ */
+static int blog_sources_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
+	struct blog_logger *logger = ceph_blog_debugfs_logger(fsc);
+	struct blog_source_info *source;
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
+	for (id = 1; id < BLOG_MAX_SOURCE_IDS; id++) {
+		source = blog_get_source_info(logger, id);
+		if (!source || !source->file)
+			continue;
+
+		count++;
+		seq_printf(s, "ID %u: %s:%s:%u\n", id,
+			  source->file, source->func, source->line);
+		seq_printf(s, "  Format: %s\n", source->fmt ? source->fmt : "(null)");
+		seq_printf(s, "  Warnings: %d\n", source->warn_count);
+
+#if BLOG_TRACK_USAGE
+		seq_printf(s, "  Usage: %d calls, %d bytes\n",
+			  atomic_read(&source->task_usage),
+			  atomic_read(&source->task_bytes));
+#endif
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
+	return single_open(file, blog_sources_show, inode->i_private);
+}
+
+static const struct file_operations blog_sources_fops = {
+	.open = blog_sources_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/**
+ * blog_clients_show - Show all registered Ceph clients
+ */
+static int blog_clients_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
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
+	return single_open(file, blog_clients_show, inode->i_private);
+}
+
+static const struct file_operations blog_clients_fops = {
+	.open = blog_clients_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/**
+ * blog_clear_write - Clear all BLOG entries (write-only)
+ */
+static ssize_t blog_clear_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct ceph_fs_client *fsc = file->private_data;
+	struct blog_logger *logger = ceph_blog_debugfs_logger(fsc);
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
+	/* Only accept "clear" command */
+	if (strncmp(cmd, "clear", 5) != 0)
+		return -EINVAL;
+
+	/*
+	 * Deferred clear: set a flag on each context rather than resetting
+	 * the pagefrag directly, which would race with concurrent writers.
+	 * Each context consumes the flag and resets its pagefrag before its
+	 * next write.  A read-after-clear may still show stale entries from
+	 * contexts that have not yet written.
+	 */
+	if (logger) {
+		struct blog_tls_ctx *tls_ctx;
+
+		spin_lock(&logger->lock);
+		list_for_each_entry(tls_ctx, &logger->contexts, list)
+			set_bit(BLOG_CTX_NEEDS_RESET, &tls_ctx->flags);
+		spin_unlock(&logger->lock);
+		pr_debug("ceph: BLOG entries cleared via debugfs\n");
+	}
+
+	return count;
+}
+
+static const struct file_operations blog_clear_fops = {
+	.open = simple_open,
+	.write = blog_clear_write,
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
+	if (!dir)
+		return -ENOMEM;
+	fsc->debugfs_blog = dir;
+
+	/* Create debugfs entries */
+	debugfs_create_bool("enabled", 0600, fsc->debugfs_blog,
+			    &fsc->blog_enabled);
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
+	WRITE_ONCE(fsc->blog_enabled, false);
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
index 18eb5da03411..a88bfed7c236 100644
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
 
@@ -639,7 +639,7 @@ DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
 
 void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 {
-	doutc(fsc->client, "begin\n");
+	boutc(fsc->client, "begin\n");
 	debugfs_remove(fsc->debugfs_bdi);
 	debugfs_remove(fsc->debugfs_congestion_kb);
 	debugfs_remove(fsc->debugfs_mdsmap);
@@ -650,14 +650,19 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove_recursive(fsc->debugfs_reset_dir);
 	debugfs_remove(fsc->debugfs_subvolume_metrics);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
-	doutc(fsc->client, "done\n");
+
+#if IS_ENABLED(CONFIG_CEPH_FS)
+	ceph_blog_debugfs_cleanup(fsc);
+#endif
+
+	boutc(fsc->client, "done\n");
 }
 
 void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 {
 	char name[NAME_MAX];
 
-	doutc(fsc->client, "begin\n");
+	boutc(fsc->client, "begin\n");
 	fsc->debugfs_congestion_kb =
 		debugfs_create_file("writeback_congestion_kb",
 				    0600,
@@ -728,9 +733,13 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 		debugfs_create_file("subvolumes", 0400,
 				    fsc->debugfs_metrics_dir, fsc,
 				    &subvolume_metrics_fops);
-	doutc(fsc->client, "done\n");
-}
 
+#if IS_ENABLED(CONFIG_CEPH_FS)
+	ceph_blog_debugfs_init(fsc);
+#endif
+
+	boutc(fsc->client, "done\n");
+}
 
 #else  /* CONFIG_DEBUG_FS */
 
@@ -742,4 +751,4 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 {
 }
 
-#endif  /* CONFIG_DEBUG_FS */
+#endif	/* CONFIG_DEBUG_FS */
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c05fbd4237f8..30b35f496794 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -49,11 +49,15 @@ static LIST_HEAD(ceph_fsc_list);
 static void ceph_put_super(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
+	struct ceph_journal_info __ji;
 
-	doutc(fsc->client, "begin\n");
+	ceph_blog_enter(fsc, &__ji);
+
+	boutc(fsc->client, "begin\n");
 	ceph_fscrypt_free_dummy_policy(fsc);
 	ceph_mdsc_close_sessions(fsc->mdsc);
-	doutc(fsc->client, "done\n");
+	boutc(fsc->client, "done\n");
+	ceph_blog_exit(&__ji);
 }
 
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -63,8 +67,11 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct ceph_statfs st;
 	int i, err;
 	u64 data_pool;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	doutc(fsc->client, "begin\n");
+	boutc(fsc->client, "begin\n");
 	if (fsc->mdsc->mdsmap->m_num_data_pg_pools == 1) {
 		data_pool = fsc->mdsc->mdsmap->m_data_pg_pools[0];
 	} else {
@@ -72,8 +79,10 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	}
 
 	err = ceph_monc_do_statfs(monc, data_pool, &st);
-	if (err < 0)
+	if (err < 0) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	/* fill in kstatfs */
 	buf->f_type = CEPH_SUPER_MAGIC;  /* ?? */
@@ -118,7 +127,8 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	/* fold the fs_cluster_id into the upper bits */
 	buf->f_fsid.val[1] = monc->fs_cluster_id;
 
-	doutc(fsc->client, "done\n");
+	boutc(fsc->client, "done\n");
+	ceph_blog_exit(&__ji);
 	return 0;
 }
 
@@ -126,19 +136,24 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (!wait) {
-		doutc(cl, "(non-blocking)\n");
+		boutc(cl, "(non-blocking)\n");
 		ceph_flush_dirty_caps(fsc->mdsc);
 		ceph_flush_cap_releases(fsc->mdsc);
-		doutc(cl, "(non-blocking) done\n");
+		boutc(cl, "(non-blocking) done\n");
+		ceph_blog_exit(&__ji);
 		return 0;
 	}
 
-	doutc(cl, "(blocking)\n");
+	boutc(cl, "(blocking)\n");
 	ceph_osdc_sync(&fsc->client->osdc);
 	ceph_mdsc_sync(fsc->mdsc);
-	doutc(cl, "(blocking) done\n");
+	boutc(cl, "(blocking) done\n");
+	ceph_blog_exit(&__ji);
 	return 0;
 }
 
@@ -843,6 +858,7 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 
 	atomic_long_set(&fsc->writeback_count, 0);
 	fsc->write_congested = false;
+	WRITE_ONCE(fsc->blog_enabled, false);
 
 	err = -ENOMEM;
 	/*
@@ -859,12 +875,18 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	hash_init(fsc->async_unlink_conflict);
 	spin_lock_init(&fsc->async_unlink_conflict_lock);
 
+	err = ceph_blog_fsc_init(fsc);
+	if (err)
+		goto fail_cap_wq;
+
 	spin_lock(&ceph_fsc_lock);
 	list_add_tail(&fsc->metric_wakeup, &ceph_fsc_list);
 	spin_unlock(&ceph_fsc_lock);
 
 	return fsc;
 
+fail_cap_wq:
+	destroy_workqueue(fsc->cap_wq);
 fail_inode_wq:
 	destroy_workqueue(fsc->inode_wq);
 fail_client:
@@ -894,6 +916,7 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 	ceph_mdsc_destroy(fsc);
 	destroy_workqueue(fsc->inode_wq);
 	destroy_workqueue(fsc->cap_wq);
+	ceph_blog_fsc_cleanup(fsc);
 
 	destroy_mount_options(fsc->mount_options);
 
@@ -1028,11 +1051,15 @@ static void __ceph_umount_begin(struct ceph_fs_client *fsc)
 void ceph_umount_begin(struct super_block *sb)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	doutc(fsc->client, "starting forced umount\n");
+	boutc(fsc->client, "starting forced umount\n");
 
 	fsc->mount_state = CEPH_MOUNT_SHUTDOWN;
 	__ceph_umount_begin(fsc);
+	ceph_blog_exit(&__ji);
 }
 
 static const struct super_operations ceph_super_ops = {
@@ -1636,10 +1663,16 @@ int ceph_force_reconnect(struct super_block *sb)
 
 static int __init init_ceph(void)
 {
-	int ret = init_caches();
+	int ret;
+
+	ret = ceph_blog_init();
 	if (ret)
 		goto out;
 
+	ret = init_caches();
+	if (ret)
+		goto out_blog;
+
 	ceph_flock_init();
 	ret = register_filesystem(&ceph_fs_type);
 	if (ret)
@@ -1651,6 +1684,8 @@ static int __init init_ceph(void)
 
 out_caches:
 	destroy_caches();
+out_blog:
+	ceph_blog_cleanup();
 out:
 	return ret;
 }
@@ -1660,6 +1695,7 @@ static void __exit exit_ceph(void)
 	dout("exit_ceph\n");
 	unregister_filesystem(&ceph_fs_type);
 	destroy_caches();
+	ceph_blog_cleanup();
 }
 
 static int param_set_metrics(const char *val, const struct kernel_param *kp)
-- 
2.34.1

