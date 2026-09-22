Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1541A6803
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085665; cv=none; b=Zjd43WKwGS00nG32Exrk3bqF9qeBOkC16KwxhoFFFzD13GcRqUpT5JZpFV70x21gKqlKoeFDJNrjkLaztnH1OvFgWkLzD7Wy2hK9v3O+s3odKyIRhyNwUVc8KxouEYsL0UzPGcvo1Xtrjlinj0S0NrRJ5qdNwOIa5k7GDs+MR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085665; c=relaxed/simple;
	bh=sqxk3Lk4Oj2y30s/VYhNZ5rQ2F/KSy5ZeO+GwGz3qhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhXuqIDQEXamxc/LceATg2KQ/bVdl8RS+bExvl2EbfMitJSaP6DVv6zkCrUya6ZuvPWOVvgPnwPfDZ9RQA+OJrCETFZZ+QsqV4LiHpers9rZN28P9xWyujtaLqrxZU2i03if8C4Fzc1AMvca/VeP7H+oH8yPoT8dFA0wWgXsHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ul66QYy6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ff4gsihv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul66QYy6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff4gsihv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3G2QNyPF1HLqL/IdZkyV/9+Nws39ur4pOd5z0KzE7s=;
	b=Ul66QYy6iZkF5EmiAev87Iyt44s6nLLPlQ6LaoroVq8JJ0aTC294DiW75xL7J8JBBH+hYW
	UVOHzKZCrX4tavonZDww0Qm00DpOQW02u5TcipI+50mcFFtugnH49C9jSv+XM79df/LKre
	ps0TMd4C1pQN6uOJUnHV9WEDQMXihz8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-ve0qJUKrNy2tXQYp5A4rWA-1; Tue, 22 Sep 2026 10:01:00 -0400
X-MC-Unique: ve0qJUKrNy2tXQYp5A4rWA-1
X-Mimecast-MFC-AGG-ID: ve0qJUKrNy2tXQYp5A4rWA_1790085660
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939062ecda9so647787885a.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085660; x=1790690460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3G2QNyPF1HLqL/IdZkyV/9+Nws39ur4pOd5z0KzE7s=;
        b=Ff4gsihvMNZKIi1+I7veFxLQqAr0KAX2EtnnOIfXJNKgwhNTYVprkBUvuUWxmVD73b
         YlyXS4YmA22nAOcqvgmH8tW3awnlUflYqssKcftpt0Mj/aCsUrEG3zfGBSuetkM24Pat
         eadYlnuaVQ88IviiTTxnkGTYDcSDsJfPDohBZLD3Qs+XWN4FCQmmNT2brPQAvpWaNzzU
         WseJMAH+UHesLLbNxcd9/6+z7wugSNCDayemGlwTQ9v2oR3/hzZKumed/eurlsD98XL9
         YQCktHGHu5AxwAfxvEL9R6ofiys/9WbQOTQ6PmsHaBMiwKb3Co6Dt7YndksTQnH5pzqq
         W82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085660; x=1790690460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3G2QNyPF1HLqL/IdZkyV/9+Nws39ur4pOd5z0KzE7s=;
        b=VVZ/MPJXcHZZ3NZ0X2PcB2F1nYTyyzf0QNtpbivkQlo5eJJFdpf+T5uWZUMuyx0hm7
         M0m+J7Cm/wVP7wq6+jSa+KiZeQTSmEjjaEgQcUIn068r0QQIZmT4uGJFOqt2eC768/s8
         hog5eRHaxGRnnzVw6TBog760lFPkAU5LmBXLDtelWQ+7nF95/Hle/5wuMdxBgoABwqtt
         9+ZedU9ZWMfn281Y+jOeDfGSKCOAu9xwEBd8fa4F4VPT5ZViJTgCGW06sN5tNQ/xoZ3s
         3gqlJBIPATbRlUbGOe4Xk4X4q+d7xxLZFqioM25kJJz2vBQxIhHXrK6B58GJOG8ZeYbf
         Ho/w==
X-Gm-Message-State: AFuF++mX0EkXEuipTU1YO2g1orJJI1J3mN4ChRsHYtyBbR+UM7McaZdF
	Notvy5dZ1Ec0qra9GS4x7GvVYy6zL5djpQ1yU6NOwY//nmzzwfwhdDNwSl0b9aZnEjEJ9LXlAkV
	Wrj2UwnKf0HKiS57rIGNMqacqJ8oriuMP3xdsblS5tOAWz1WuS4IOSJM8gagwO4EAONssanLwHU
	WTayrl/2FNQ0UJl4fz0z3sxViGN6xti4YlP+FbC5FuXeZ9WAavRw==
X-Gm-Gg: AYBFou3xhinhEPQURfovNJDc6UM9jAyLCO1e3Z7FBSKMoEUcJlUGpa+5sM9fi3cgzL4
	+zzlYlmJwC68jD7NYDXbzHxOncVhaSo3PusRJ87HQlyMbijIVGi5pFqQhq/WP4YQvBusYotnTMq
	dqj4NjqHTE9XHm778UNOqfD29y/TbAMEPHpqOaE2J5QpF1G/UGj64hUMC8L0nzDLbFvoloK6nN6
	7RgzP6nWRIwGoEWcHRvW8p4xw8bqVguf/1hlj8SVt/jTmw5mGgEAES9iRgKRcxZf9ttL9LuDiZs
	ys+8u6+C0MnAl80CZslRDDTsUmu+fSfpku7XXnMI+JB1jY0Q3zQZ6HMaHlUeyznGW7tdEr9oIGl
	lytJ9QNZlrx+XYQzgc73UMV9tVgY16pYn8jaGh9nDL4C5Bsiifq8ZpiY/q4BNhPrrDThN3EfWa3
	5ysN3NBo2WHzEm0A==
X-Received: by 2002:a05:620a:2a03:b0:91c:c20b:a135 with SMTP id af79cd13be357-93c15e7671dmr554218485a.40.1790085658014;
        Tue, 22 Sep 2026 07:00:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2a03:b0:91c:c20b:a135 with SMTP id af79cd13be357-93c15e7671dmr554198085a.40.1790085654429;
        Tue, 22 Sep 2026 07:00:54 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:00:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 01/14] ceph: add BLOG private headers
Date: Tue, 22 Sep 2026 14:00:34 +0000
Message-Id: <20260922140047.794405-2-amarkuze@redhat.com>
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

Add the private header files for the binary logging (BLOG) subsystem:

  blog.h          - core types: blog_logger, blog_log_entry,
                    blog_tls_ctx, blog_source_info, blog_log_iter,
                    blog_source_id_cache; core API prototypes
  blog_ser.h      - single-evaluation argument packing and bounded,
                    type-aware serialization helpers
  blog_des.h      - deserialization prototypes
  blog_batch.h    - per-CPU magazine batch allocator types
  blog_pagefrag.h - page-fragment allocator types
  blog_module.h   - per-module context and task-entry declarations

Private headers live under fs/ceph/; only the CephFS integration
surface remains in include/linux/ceph/.

CEPH_BLOG_LOG_CLIENT stages packed arguments in the per-task
blog_tls_ctx scratch and emits from a noinline helper so VFS frames
do not grow a struct blog_arg[] at each call site. Same-width values
go through unsigned long before u64 so 32-bit sparse does not see
pointer-to-u64.

Fill TLS scratch with recursive macros that capture each destination
and argument once, in argument order. Keep the fill definitions short
without reintroducing a stack argument array. Provide a private
static-key context selector for logging-only preparation helpers.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609080414.m3ZvUYmq-lkp@intel.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Assisted-by: LLM
---
 fs/ceph/blog.h          | 216 +++++++++++++++++++++
 fs/ceph/blog_batch.h    |  44 +++++
 fs/ceph/blog_des.h      |  16 ++
 fs/ceph/blog_module.h   |  42 +++++
 fs/ceph/blog_pagefrag.h |  27 +++
 fs/ceph/blog_ser.h      | 404 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 749 insertions(+)
 create mode 100644 fs/ceph/blog.h
 create mode 100644 fs/ceph/blog_batch.h
 create mode 100644 fs/ceph/blog_des.h
 create mode 100644 fs/ceph/blog_module.h
 create mode 100644 fs/ceph/blog_pagefrag.h
 create mode 100644 fs/ceph/blog_ser.h

diff --git a/fs/ceph/blog.h b/fs/ceph/blog.h
new file mode 100644
index 000000000000..ee34035dd0b0
--- /dev/null
+++ b/fs/ceph/blog.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CephFS binary logging (BLOG) private types.
+ */
+#ifndef _FS_CEPH_BLOG_H
+#define _FS_CEPH_BLOG_H
+
+#include <linux/types.h>
+#include <linux/limits.h>
+#include <linux/build_bug.h>
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/seqlock.h>
+#include <linux/atomic.h>
+#include <linux/workqueue.h>
+#include <linux/rhashtable-types.h>
+#include <linux/ceph/ceph_blog.h>
+#include "blog_batch.h"
+#include "blog_pagefrag.h"
+#include "blog_ser.h"
+#include "blog_des.h"
+
+struct blog_module_context;
+
+/* Absolute caps for module parameters (load-time only). */
+#define BLOG_MAX_SOURCE_IDS_CAP	65535
+#define BLOG_MAX_CLIENT_IDS_CAP	256
+#define BLOG_DEFAULT_MAX_SOURCES 4096
+#define BLOG_DEFAULT_MAX_CLIENTS 256
+#define BLOG_MAX_PAYLOAD U16_MAX
+
+struct blog_source_info {
+	const char *file;
+	const char *func;
+	unsigned int line;
+	const char *fmt;
+	int warn_count;
+};
+
+struct blog_log_entry {
+	u32 ts_delta;
+	u16 source_id;
+	u16 len;
+	u8 client_id;
+	u8 flags;
+	char buffer[];
+};
+
+#define BLOG_CTX_NEEDS_RESET	0
+#define BLOG_CTX_TASK_COUNTED	1
+
+struct blog_tls_ctx {
+	struct list_head list;
+	void (*release)(void *data);
+	atomic_t refcount;
+	struct task_struct *task;
+	pid_t pid;
+	char comm[TASK_COMM_LEN];
+	u64 id;
+	unsigned long base_jiffies;
+	struct blog_logger *logger;
+	int pending_offset;
+	size_t pending_size;
+	unsigned long flags;
+	/* The CPU cache is usable only while inside ceph_blog_enter*(). */
+	unsigned int enter_depth;
+	/* CPU whose per-CPU cache slot bind published; unbind clears it after migration. */
+	int cache_cpu;
+	/* Matches logger->clear_seq after a reset; readers treat mismatch as empty. */
+	atomic64_t clear_seq;
+	/*
+	 * Staging for boutc() argument packing. Lives here so VFS frames
+	 * do not grow a struct blog_arg[] per call site. Fill+emit in one
+	 * boutc() is not re-entrant: argument expressions must not log.
+	 */
+	struct blog_arg arg_scratch[BLOG_MAX_ARGS];
+};
+
+struct blog_tls_pagefrag {
+	struct blog_tls_ctx ctx;
+	struct blog_pagefrag pf;
+	unsigned char buf[];
+};
+
+#define BLOG_TLS_PAGEFRAG_ALLOC_SIZE BLOG_PAGEFRAG_SIZE
+#define BLOG_TLS_PAGEFRAG_BUFFER_SIZE \
+	(BLOG_PAGEFRAG_SIZE - sizeof(struct blog_tls_pagefrag))
+
+struct blog_logger {
+	struct list_head contexts;
+	spinlock_t lock;
+	struct mutex snapshot_mutex;
+	struct rhashtable task_map;
+	struct blog_batch alloc_batch;
+	struct blog_batch log_batch;
+	struct kmem_cache *magazine_cache;
+	struct blog_source_info *source_map;
+	u32 *source_hash;	/* open-addressed, stores source IDs (0 = empty) */
+	u32 source_hash_mask;
+	u32 max_source_ids;
+	u32 next_source_id;	/* serialized by source_lock */
+	spinlock_t source_lock;
+	unsigned long total_contexts_allocated;
+	u64 next_ctx_id;
+	spinlock_t ctx_id_lock;
+	struct blog_module_context *owner_ctx;
+	u64 generation;
+	/* Bumped by debugfs "clear"; writers/readers sync via ctx->clear_seq. */
+	atomic64_t clear_seq;
+	struct delayed_work task_gc_work;
+	bool task_gc_stopping;
+	/*
+	 * Atomic rotate (boutc under spinlock) cannot take snapshot_mutex.
+	 * Failed log-batch puts land on reclaim_list; reclaim_work drains
+	 * them and rebalances under sleepable context.
+	 */
+	struct list_head reclaim_list;
+	struct work_struct reclaim_work;
+};
+
+/**
+ * struct blog_source_id_cache - per-callsite source ID fast cache
+ * @logger: logger that owns the cached ID
+ * @generation: logger generation at cache-fill time
+ * @id: cached source ID (0 = not yet cached)
+ * @seq: validates lockless cache snapshots
+ * @lock: serializes cache updates shared by all mounts
+ */
+struct blog_source_id_cache {
+	struct blog_logger *logger;
+	u64 generation;
+	u32 id;
+	seqcount_spinlock_t seq;
+	spinlock_t lock;
+};
+
+#define BLOG_SOURCE_ID_CACHE_INIT(name) { \
+	.seq = SEQCNT_SPINLOCK_ZERO(name.seq, &(name).lock), \
+	.lock = __SPIN_LOCK_UNLOCKED(name.lock), \
+}
+
+struct blog_log_iter {
+	struct blog_pagefrag *pf;
+	u64 current_offset;
+	u64 end_offset;
+	u64 prev_offset;
+	u64 steps;
+};
+
+typedef int (*blog_client_des_fn)(char *buf, size_t size, u8 client_id);
+
+int blog_param_max_sources(void);
+int blog_param_max_clients(void);
+
+u32 blog_get_source_id(struct blog_logger *logger, const char *file,
+		       const char *func, unsigned int line, const char *fmt);
+u32 blog_get_source_id_cached(struct blog_logger *logger,
+			      struct blog_source_id_cache *cache,
+			      const char *file, const char *func,
+			      unsigned int line, const char *fmt);
+struct blog_source_info *blog_get_source_info(struct blog_logger *logger,
+					      u32 id);
+void blog_log_iter_init(struct blog_log_iter *iter, struct blog_pagefrag *pf,
+			u64 head_snapshot);
+struct blog_log_entry *blog_log_iter_next(struct blog_log_iter *iter);
+int blog_des_entry(struct blog_logger *logger, struct blog_log_entry *entry,
+		   char *output, size_t out_size,
+		   blog_client_des_fn client_cb);
+void *blog_log_with_ctx(struct blog_logger *logger,
+			struct blog_tls_ctx *tls_ctx,
+			u32 source_id, u8 client_id, size_t needed_size);
+int blog_log_commit_with_ctx(struct blog_logger *logger,
+			     struct blog_tls_ctx *tls_ctx,
+			     size_t actual_size);
+void blog_log_client_emit(struct blog_tls_ctx *ctx, struct ceph_client *client,
+			  struct blog_source_id_cache *cache,
+			  const char *file, const char *func,
+			  unsigned int line, const char *fmt, size_t nargs);
+static inline struct blog_tls_pagefrag *blog_ctx_container(struct blog_tls_ctx *ctx)
+{
+	return container_of(ctx, struct blog_tls_pagefrag, ctx);
+}
+
+static inline struct blog_pagefrag *blog_ctx_pf(struct blog_tls_ctx *ctx)
+{
+	return &blog_ctx_container(ctx)->pf;
+}
+
+/* Select the binary path before preparing logging-only snapshots or strings. */
+static inline struct blog_tls_ctx *ceph_blog_get_ctx(struct ceph_fs_client *fsc)
+{
+#ifdef CONFIG_DEBUG_FS
+	if (static_branch_unlikely(&ceph_blog_key))
+		return ceph_blog_get_cached_ctx(fsc);
+#endif
+	return NULL;
+}
+
+#define CEPH_BLOG_LOG_CLIENT(ctx, client, fmt, ...) \
+	do { \
+		static struct blog_source_id_cache __source_cache = \
+			BLOG_SOURCE_ID_CACHE_INIT(__source_cache); \
+		struct blog_tls_ctx *__blog_ctx = (ctx); \
+		size_t __nargs = blog_narg(__VA_ARGS__); \
+		if (unlikely(!__blog_ctx) || unlikely(!__blog_ctx->logger)) \
+			break; \
+		BUILD_BUG_ON(blog_narg(__VA_ARGS__) > BLOG_MAX_ARGS); \
+		BLOG_FILL_ARGS(__blog_ctx->arg_scratch, ##__VA_ARGS__); \
+		blog_log_client_emit(__blog_ctx, client, &__source_cache, \
+				     kbasename(__FILE__), __func__, __LINE__, \
+				     fmt, __nargs); \
+	} while (0)
+
+#endif /* _FS_CEPH_BLOG_H */
diff --git a/fs/ceph/blog_batch.h b/fs/ceph/blog_batch.h
new file mode 100644
index 000000000000..90696175b157
--- /dev/null
+++ b/fs/ceph/blog_batch.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BLOG magazine batcher.
+ */
+#ifndef _FS_CEPH_BLOG_BATCH_H
+#define _FS_CEPH_BLOG_BATCH_H
+
+#include <linux/types.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
+#define BLOG_MAGAZINE_SIZE 16
+
+struct blog_magazine {
+	struct list_head list;
+	unsigned int count;
+	void *elements[BLOG_MAGAZINE_SIZE];
+};
+
+struct blog_cpu_magazine {
+	struct blog_magazine *mag;
+};
+
+struct blog_batch {
+	struct list_head full_magazines;
+	struct list_head empty_magazines;
+	raw_spinlock_t full_lock;
+	raw_spinlock_t empty_lock;
+	unsigned int nr_full;
+	unsigned int nr_empty;
+	struct blog_cpu_magazine __percpu *cpu_magazines;
+	struct kmem_cache *magazine_cache;
+	bool external_cache;
+	unsigned int retain_limit;
+};
+
+int blog_batch_init(struct blog_batch *batch, struct kmem_cache *mag_cache,
+		    unsigned int nr_prealloc, unsigned int retain_limit);
+void blog_batch_cleanup(struct blog_batch *batch);
+void *blog_batch_get(struct blog_batch *batch);
+bool blog_batch_put(struct blog_batch *batch, void *element);
+
+#endif /* _FS_CEPH_BLOG_BATCH_H */
diff --git a/fs/ceph/blog_des.h b/fs/ceph/blog_des.h
new file mode 100644
index 000000000000..a67bec43ab2d
--- /dev/null
+++ b/fs/ceph/blog_des.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BLOG record deserialization.
+ */
+#ifndef _FS_CEPH_BLOG_DES_H
+#define _FS_CEPH_BLOG_DES_H
+
+#include <linux/types.h>
+
+struct blog_log_entry;
+struct blog_logger;
+
+int blog_des_reconstruct(const char *fmt, const void *buffer,
+			 size_t size, char *out, size_t out_size);
+
+#endif /* _FS_CEPH_BLOG_DES_H */
diff --git a/fs/ceph/blog_module.h b/fs/ceph/blog_module.h
new file mode 100644
index 000000000000..adb24a8ee1ac
--- /dev/null
+++ b/fs/ceph/blog_module.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Per-superblock BLOG context and task-keyed rhashtable.
+ */
+#ifndef _FS_CEPH_BLOG_MODULE_H
+#define _FS_CEPH_BLOG_MODULE_H
+
+#include "blog.h"
+#include <linux/rhashtable.h>
+#include <linux/refcount.h>
+
+struct blog_task_entry {
+	struct rhash_head	node;
+	struct task_struct	*task;
+	pid_t			pid;
+	char			comm[TASK_COMM_LEN];
+	struct blog_tls_ctx	*ctx;
+	unsigned long		flags;
+	struct rcu_head		rcu;
+};
+
+struct blog_module_context {
+	char name[32];
+	struct blog_logger *logger;
+	void *module_private;
+	refcount_t refcount;
+	atomic_t allocated_contexts;
+	struct work_struct free_work;
+	bool initialized;
+};
+
+struct blog_module_context *blog_module_init(const char *module_name);
+void blog_module_put(struct blog_module_context *ctx);
+void blog_module_flush_frees(void);
+int blog_module_wq_init(void);
+void blog_module_wq_exit(void);
+
+struct blog_tls_ctx *blog_lookup_tls_ctx(struct blog_module_context *ctx);
+struct blog_tls_ctx *blog_get_tls_ctx_ctx(struct blog_module_context *ctx,
+					  gfp_t gfp);
+
+#endif /* _FS_CEPH_BLOG_MODULE_H */
diff --git a/fs/ceph/blog_pagefrag.h b/fs/ceph/blog_pagefrag.h
new file mode 100644
index 000000000000..d6a77268cf12
--- /dev/null
+++ b/fs/ceph/blog_pagefrag.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BLOG page-fragment allocator.
+ */
+#ifndef _FS_CEPH_BLOG_PAGEFRAG_H
+#define _FS_CEPH_BLOG_PAGEFRAG_H
+
+#include <linux/types.h>
+#include <linux/sizes.h>
+#include <linux/spinlock.h>
+
+#define BLOG_PAGEFRAG_SIZE  SZ_4K
+#define BLOG_PAGEFRAG_MASK (BLOG_PAGEFRAG_SIZE - 1)
+
+struct blog_pagefrag {
+	void *buffer;
+	size_t capacity;
+	spinlock_t lock;
+	unsigned int head;
+};
+
+int blog_pagefrag_reserve(struct blog_pagefrag *pf, unsigned int n);
+void blog_pagefrag_publish(struct blog_pagefrag *pf, unsigned int publish_head);
+void blog_pagefrag_reset(struct blog_pagefrag *pf);
+void *blog_pagefrag_get_ptr(struct blog_pagefrag *pf, u64 val);
+
+#endif /* _FS_CEPH_BLOG_PAGEFRAG_H */
diff --git a/fs/ceph/blog_ser.h b/fs/ceph/blog_ser.h
new file mode 100644
index 000000000000..157cf34a6993
--- /dev/null
+++ b/fs/ceph/blog_ser.h
@@ -0,0 +1,404 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BLOG argument packing.
+ */
+#ifndef _FS_CEPH_BLOG_SER_H
+#define _FS_CEPH_BLOG_SER_H
+
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define IS_STR_PTR(t) \
+	(__builtin_types_compatible_p(typeof(t), const char *) || \
+	 __builtin_types_compatible_p(typeof(t), char *) || \
+	 __builtin_types_compatible_p(typeof(t), const unsigned char *) || \
+	 __builtin_types_compatible_p(typeof(t), unsigned char *))
+
+#define IS_STR_ARRAY(t) \
+	(__builtin_types_compatible_p(typeof(t), const char []) || \
+	 __builtin_types_compatible_p(typeof(t), char []) || \
+	 __builtin_types_compatible_p(typeof(t), const unsigned char []) || \
+	 __builtin_types_compatible_p(typeof(t), unsigned char []))
+
+#define IS_STR(t) (IS_STR_PTR(t) || IS_STR_ARRAY(t))
+
+struct blog_bounded_string {
+	const char *str;
+	size_t len;
+};
+
+#define BLOG_STR(__str, __len) \
+	(&(const struct blog_bounded_string){ \
+		.str = (const char *)(__str), \
+		.len = (__len), \
+	})
+
+#define IS_BOUNDED_STR(t) \
+	(__builtin_types_compatible_p(typeof(t), \
+				      const struct blog_bounded_string *) || \
+	 __builtin_types_compatible_p(typeof(t), struct blog_bounded_string *))
+
+#define __suppress_cast_warning(type, value) \
+({ \
+	_Pragma("GCC diagnostic push") \
+	_Pragma("GCC diagnostic ignored \"-Wint-to-pointer-cast\"") \
+	_Pragma("GCC diagnostic ignored \"-Wpointer-to-int-cast\"") \
+	type __scw_result; \
+	__scw_result = ((type)(value)); \
+	_Pragma("GCC diagnostic pop") \
+	__scw_result; \
+})
+
+#define ___blog_concat(__a, __b) __a ## __b
+#define ___blog_apply(__fn, __n) ___blog_concat(__fn, __n)
+
+#define ___blog_nth(_, __1, __2, __3, __4, __5, __6, __7, __8, __9, \
+	__10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, \
+	__21, __22, __23, __24, __25, __26, __27, __28, __29, __30, __31, \
+	__32, __N, ...) __N
+#define ___blog_narg(...) ___blog_nth(_, ##__VA_ARGS__, \
+	32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, \
+	16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+#define blog_narg(...) ___blog_narg(__VA_ARGS__)
+
+#define STR_MAX_SIZE 255
+#define BLOG_MAX_ARGS 32
+
+/**
+ * struct blog_arg - an evaluated argument and its serialization reservation
+ * @value: cached scalar value
+ * @str: cached string pointer
+ * @string_len: measured number of source bytes, excluding the terminator
+ * @reserved: bytes reserved for this argument, including string padding
+ * @is_string: @str and @string_len are valid instead of @value
+ *
+ * Logging macros build these records before reserving pagefrag space.  String
+ * expressions are therefore evaluated once, and serialization cannot copy
+ * beyond the length used to calculate that string's reservation.
+ */
+struct blog_arg {
+	union {
+		u64 value;
+		const char *str;
+	};
+	u16 string_len;
+	u16 reserved;
+	bool is_string;
+};
+
+static inline void blog_arg_set_string(struct blog_arg *arg, const char *str,
+				       size_t limit)
+{
+	size_t len = 0;
+
+	arg->is_string = true;
+	arg->str = str;
+	if (!str) {
+		arg->string_len = 0;
+		arg->reserved = sizeof("(NULL) ");
+		return;
+	}
+
+	/*
+	 * @limit is the caller's scan bound.  Unbounded %s passes
+	 * STR_MAX_SIZE; BLOG_STR() passes the caller length (paths,
+	 * NAME_MAX dentries) and must not be silently shrunk to 254.
+	 * Cap only so reserved (= round_up(len + 1, 4)) fits in u16.
+	 */
+	limit = min_t(size_t, limit, (size_t)U16_MAX - 4);
+	while (len < limit && str[len])
+		len++;
+	arg->string_len = len;
+	arg->reserved = round_up(len + 1, 4);
+}
+
+#define const_char_ptr(str) __suppress_cast_warning(const char *, (str))
+/* Integer-width round-trip so both if-branches type-check for any arg. */
+#define bounded_string_ptr(str) \
+	((const struct blog_bounded_string *)(unsigned long)(str))
+
+#define BLOG_ARG(__arg) \
+({ \
+	__auto_type __blog_value = (__arg); \
+	struct blog_arg __blog_arg = {}; \
+	if (IS_BOUNDED_STR(__blog_value)) { \
+		const struct blog_bounded_string *__blog_str = \
+			bounded_string_ptr(__blog_value); \
+		blog_arg_set_string(&__blog_arg, __blog_str->str, \
+				    __blog_str->len); \
+	} else if (IS_STR(__blog_value)) { \
+		blog_arg_set_string(&__blog_arg, const_char_ptr(__blog_value), \
+				    STR_MAX_SIZE); \
+	} else { \
+		/* Same-width integer first so 32-bit sparse does not see \
+		 * pointer-to-u64. Wider scalars still go through u64. \
+		 */ \
+		if (sizeof(__blog_value) == sizeof(void *)) \
+			__blog_arg.value = (u64)__suppress_cast_warning( \
+				unsigned long, __blog_value); \
+		else \
+			__blog_arg.value = __suppress_cast_warning( \
+				u64, __blog_value); \
+		__blog_arg.reserved = sizeof(__blog_value) < 4 ? \
+			4 : sizeof(__blog_value); \
+	} \
+	__blog_arg; \
+})
+
+/*
+ * Fill the per-task scratch in argument order, evaluating each expression once.
+ * Each recursive step captures its destination before writing the next slot.
+ * Keep argument arrays off the VFS stack.
+ */
+#define ___blog_fill0(__dst, ...) ((void)(__dst))
+#define ___blog_fill1(__dst, __arg) ((__dst)[0] = BLOG_ARG(__arg))
+#define ___blog_fill2(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst2 = (__dst); \
+		___blog_fill1(__blog_dst2, __arg); \
+		___blog_fill1(__blog_dst2 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill3(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst3 = (__dst); \
+		___blog_fill1(__blog_dst3, __arg); \
+		___blog_fill2(__blog_dst3 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill4(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst4 = (__dst); \
+		___blog_fill1(__blog_dst4, __arg); \
+		___blog_fill3(__blog_dst4 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill5(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst5 = (__dst); \
+		___blog_fill1(__blog_dst5, __arg); \
+		___blog_fill4(__blog_dst5 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill6(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst6 = (__dst); \
+		___blog_fill1(__blog_dst6, __arg); \
+		___blog_fill5(__blog_dst6 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill7(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst7 = (__dst); \
+		___blog_fill1(__blog_dst7, __arg); \
+		___blog_fill6(__blog_dst7 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill8(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst8 = (__dst); \
+		___blog_fill1(__blog_dst8, __arg); \
+		___blog_fill7(__blog_dst8 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill9(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst9 = (__dst); \
+		___blog_fill1(__blog_dst9, __arg); \
+		___blog_fill8(__blog_dst9 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill10(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst10 = (__dst); \
+		___blog_fill1(__blog_dst10, __arg); \
+		___blog_fill9(__blog_dst10 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill11(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst11 = (__dst); \
+		___blog_fill1(__blog_dst11, __arg); \
+		___blog_fill10(__blog_dst11 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill12(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst12 = (__dst); \
+		___blog_fill1(__blog_dst12, __arg); \
+		___blog_fill11(__blog_dst12 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill13(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst13 = (__dst); \
+		___blog_fill1(__blog_dst13, __arg); \
+		___blog_fill12(__blog_dst13 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill14(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst14 = (__dst); \
+		___blog_fill1(__blog_dst14, __arg); \
+		___blog_fill13(__blog_dst14 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill15(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst15 = (__dst); \
+		___blog_fill1(__blog_dst15, __arg); \
+		___blog_fill14(__blog_dst15 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill16(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst16 = (__dst); \
+		___blog_fill1(__blog_dst16, __arg); \
+		___blog_fill15(__blog_dst16 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill17(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst17 = (__dst); \
+		___blog_fill1(__blog_dst17, __arg); \
+		___blog_fill16(__blog_dst17 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill18(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst18 = (__dst); \
+		___blog_fill1(__blog_dst18, __arg); \
+		___blog_fill17(__blog_dst18 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill19(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst19 = (__dst); \
+		___blog_fill1(__blog_dst19, __arg); \
+		___blog_fill18(__blog_dst19 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill20(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst20 = (__dst); \
+		___blog_fill1(__blog_dst20, __arg); \
+		___blog_fill19(__blog_dst20 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill21(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst21 = (__dst); \
+		___blog_fill1(__blog_dst21, __arg); \
+		___blog_fill20(__blog_dst21 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill22(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst22 = (__dst); \
+		___blog_fill1(__blog_dst22, __arg); \
+		___blog_fill21(__blog_dst22 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill23(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst23 = (__dst); \
+		___blog_fill1(__blog_dst23, __arg); \
+		___blog_fill22(__blog_dst23 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill24(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst24 = (__dst); \
+		___blog_fill1(__blog_dst24, __arg); \
+		___blog_fill23(__blog_dst24 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill25(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst25 = (__dst); \
+		___blog_fill1(__blog_dst25, __arg); \
+		___blog_fill24(__blog_dst25 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill26(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst26 = (__dst); \
+		___blog_fill1(__blog_dst26, __arg); \
+		___blog_fill25(__blog_dst26 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill27(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst27 = (__dst); \
+		___blog_fill1(__blog_dst27, __arg); \
+		___blog_fill26(__blog_dst27 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill28(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst28 = (__dst); \
+		___blog_fill1(__blog_dst28, __arg); \
+		___blog_fill27(__blog_dst28 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill29(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst29 = (__dst); \
+		___blog_fill1(__blog_dst29, __arg); \
+		___blog_fill28(__blog_dst29 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill30(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst30 = (__dst); \
+		___blog_fill1(__blog_dst30, __arg); \
+		___blog_fill29(__blog_dst30 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill31(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst31 = (__dst); \
+		___blog_fill1(__blog_dst31, __arg); \
+		___blog_fill30(__blog_dst31 + 1, __VA_ARGS__); \
+	} while (0)
+#define ___blog_fill32(__dst, __arg, ...) \
+	do { \
+		struct blog_arg *__blog_dst32 = (__dst); \
+		___blog_fill1(__blog_dst32, __arg); \
+		___blog_fill31(__blog_dst32 + 1, __VA_ARGS__); \
+	} while (0)
+#define BLOG_FILL_ARGS(__dst, ...) \
+	___blog_apply(___blog_fill, blog_narg(__VA_ARGS__))(__dst, __VA_ARGS__)
+
+static inline size_t blog_args_size(const struct blog_arg *args,
+				    size_t nr_args)
+{
+	size_t size = 0;
+	size_t i;
+
+	for (i = 0; i < nr_args; i++)
+		size += args[i].reserved;
+	return size;
+}
+
+static inline size_t blog_serialize_string(char *dst,
+					   const struct blog_arg *arg)
+{
+	static const char null_str[] = "(NULL) ";
+	size_t limit;
+	size_t count;
+
+	if (!arg->str) {
+		memcpy(dst, null_str, min(sizeof(null_str), arg->reserved));
+		return arg->reserved;
+	}
+
+	limit = min(arg->string_len, arg->reserved - 1);
+	for (count = 0; count < limit; count++) {
+		dst[count] = arg->str[count];
+		if (!dst[count])
+			return round_up(count + 1, 4);
+	}
+	dst[count] = '\0';
+	return round_up(count + 1, 4);
+}
+
+static inline void *blog_serialize_args(void *buffer,
+					const struct blog_arg *args,
+					size_t nr_args)
+{
+	char *dst = buffer;
+	size_t i;
+
+	for (i = 0; i < nr_args; i++) {
+		const struct blog_arg *arg = &args[i];
+
+		if (arg->is_string) {
+			dst += blog_serialize_string(dst, arg);
+		} else if (arg->reserved == 8) {
+			put_unaligned(arg->value, (u64 *)dst);
+			dst += 8;
+		} else {
+			put_unaligned((u32)arg->value, (u32 *)dst);
+			dst += 4;
+		}
+	}
+	return dst;
+}
+
+#endif /* _FS_CEPH_BLOG_SER_H */
-- 
2.34.1

