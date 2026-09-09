Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4F558205
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958472; cv=none; b=OwVzFTsahegUjbgRNMIlcWpKF1bJGdlozTIypg7pH5wZb6OXp6WdvS0x8fASAxHTe4N12lL+sM7HPUyQZBfvWpdP0Obs1pdBHtlJpYjdZVDNZg64qa5bQT8MLLvRz8l3/1AtHvSUtbh04cGeusRs6DqRV0dKBU9HBnmH6SuagDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958472; c=relaxed/simple;
	bh=Wv5P16ildsSVo0aakbzVjXGpz6vg/gjJIW5s5dV54Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWgIOstEkXA//xZMYo82ffBIRwiycuuXcISQrb1xCaktR8x97nDErb/F/bCZTuI2KS2yyPxe3q5LCxVyGHVqWPQBd21YvIt7wnWbj6upMQ3AlcxWh33F3pG6t8YhMEgTUHjJI4uPqKWXMacljaX0MKdPnJ6c4BFnSnsK8EQIvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hyt26vBA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/a9nn0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hyt26vBA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/a9nn0l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGIY/UwBpfBtHURr0fx/RkEsHGcDf5m9NqvpNDh7bqo=;
	b=Hyt26vBA3TQTADFjFZEVvBQi5AJW6Zb3NaSs1r3emsWpJHyjHM3FLQqFyBWzsmCB912GVX
	WoPGd9ZiD+tWKp+ivwdjowlS+0Py6+iD5N9PFA2ipdipoH+oJbVaAuhuneTNHYYLfhFzWc
	L5naHc+bJii5dAjkoxhh8C4e7oSj/O8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-0sU_OJCqPX248VStKGhJFQ-1; Wed, 09 Sep 2026 08:54:26 -0400
X-MC-Unique: 0sU_OJCqPX248VStKGhJFQ-1
X-Mimecast-MFC-AGG-ID: 0sU_OJCqPX248VStKGhJFQ_1788958466
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5e38fbc5so974495685a.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958466; x=1789563266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGIY/UwBpfBtHURr0fx/RkEsHGcDf5m9NqvpNDh7bqo=;
        b=e/a9nn0lw+sx1/Ee54UGEDNZHnIHl4mvpTy4BuzDpsQF7nextWXtQfYtGT3P4RoNTO
         rsHt8wI+C+QxFgKs4jZTf3iwAk35fuIz4jpw3x7R54rGP1CbN5EFB6qACF7zmMaBrkVB
         hANqQlNflLqWC1p0N7+mi0V/ocigjlSQLfwdI0Yi2GplImm6BeSPd8nzjLJVD7Mf0Rt+
         KMvxUFXLGSIqaHyz4xvasSR+78pY9+AlVfRleW/HdcOzA4ibArRZvHTvJxG7guL2A3r2
         OHOS4WCFvgiGqvLjCg1WwdsjqcRiELvmLgSl4NxipeBdqoBaHo+1ny8ajApAPrJ/QMZO
         1ArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958466; x=1789563266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YGIY/UwBpfBtHURr0fx/RkEsHGcDf5m9NqvpNDh7bqo=;
        b=XuHUaI2cUShR1hsQlzhoh7gHNiMrQtcqfbUqDaAVRbRbrxh8jGQtcj2XCix77BrNEd
         l0yNQdlJHfISW0pSyDvHHMOqNmLfZpGljf9Vt/LkSnz+ljRRqp+Bbo7LN+nlG0t11W1e
         SsmOhucv5a6F08zLxlW1fojxavaoT7PUtQvg8S6+CjjsunlAyKoNOfwZZuw24MvYFSZa
         IODHtirOINDq0ipW0kuwvzf8ZCmfme2IG//gNRPl50+OCHgCFYmn+vq6G3tWBqpBShGd
         kRpKM86Ppra8Ac7wF6Dbn/V6dO7FGwJq/lqxSH1xZcv1o3eJMd1LpI9XxSyto3LqKip5
         1bsQ==
X-Gm-Message-State: AFuF++nZ3SO74dfDs+iTfsXJ1kwJmKrVImhvG8kyWkPb7lekT6JxxaLU
	nZSNLvJ7klD0ANKmS8I8B/iExvv4+TZ6RnN9TH6/0sM5jrR908B4HhJKl8lZXBSyln4a8IoSro6
	9LEYxxtz/8WhbGfMwavAO93L8CT0bLsYMKHyhSC897VDh3cYYHWi+Yy3Iz6GaDpga4Z9mYIYeUM
	3+zWaxOmNtULIVqeWFWZdnyKqnHxnk7cbNgJNR+mpjoSRjqz5QAA==
X-Gm-Gg: AYBFou3DQW+yCW5bz1IO4KWgzwznOVEZTNg3lue0DloVllfcQAVQk4O2mNHG9zBHTdt
	ERX86dKK6okLMwY8/xo3YtfJdiocX+zblSpzXtm5nIlpx8Hh9KXs4hunyzNDpmPdws34o3un1to
	JoX9tjXzqLGc+fb9oFdZ5t4wz7OEIpCHL/k6Xb+X5wKGnNBzK4B52IHPeD9tad1i2420npvWxKo
	UzDqd0+3lPryW+b1rOO/Dfcroa3JI4RMgaIa0w8vktxu3cyxgawET8X01WKWCaMN4lXgpLagxt5
	Pm3oR6rF+siMdKd6hexW+962zotLf2neSPeMkNUrE7k15A36FApEjJMNZQJJl/NXXw2LZ7HkDeS
	lxHRsFBjvHIL2UXi8UOKMlo9Hz/CXhc0J8KxitBQcXEh6jrEB2dXKBvHqbCgl+Zrw8+j9uALDD3
	tVztjSPmQsEzFGIg==
X-Received: by 2002:a05:620a:8809:b0:937:3b26:c9e9 with SMTP id af79cd13be357-939d4a2f528mr123988385a.25.1788958464670;
        Wed, 09 Sep 2026 05:54:24 -0700 (PDT)
X-Received: by 2002:a05:620a:8809:b0:937:3b26:c9e9 with SMTP id af79cd13be357-939d4a2f528mr123938585a.25.1788958460844;
        Wed, 09 Sep 2026 05:54:20 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:20 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 01/14] ceph: add BLOG private headers
Date: Wed,  9 Sep 2026 12:54:03 +0000
Message-Id: <20260909125416.3969532-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909125416.3969532-1-amarkuze@redhat.com>
References: <20260909125416.3969532-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609080414.m3ZvUYmq-lkp@int=
el.com/

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog.h          | 206 +++++++++++++++++++++++++++++
 fs/ceph/blog_batch.h    |  44 +++++++
 fs/ceph/blog_des.h      |  16 +++
 fs/ceph/blog_module.h   |  42 ++++++
 fs/ceph/blog_pagefrag.h |  27 ++++
 fs/ceph/blog_ser.h      | 285 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 620 insertions(+)
 create mode 100644 fs/ceph/blog.h
 create mode 100644 fs/ceph/blog_batch.h
 create mode 100644 fs/ceph/blog_des.h
 create mode 100644 fs/ceph/blog_module.h
 create mode 100644 fs/ceph/blog_pagefrag.h
 create mode 100644 fs/ceph/blog_ser.h

diff --git a/fs/ceph/blog.h b/fs/ceph/blog.h
new file mode 100644
index 000000000000..5a4c4f14e853
--- /dev/null
+++ b/fs/ceph/blog.h
@@ -0,0 +1,206 @@
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
+	/* Nested ceph_blog_enter* depth for this task; bout uses CPU cache only =
while > 0. */
+	unsigned int enter_depth;
+	/* CPU whose per-CPU cache slot bind published; unbind clears it after mi=
gration. */
+	int cache_cpu;
+	/* Matches logger->clear_seq after a reset; readers treat mismatch as emp=
ty. */
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
+	u32 *source_hash;	/* open-addressed, stores source IDs (0 =3D empty) */
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
+	 * Atomic rotate (bout under spinlock) cannot take snapshot_mutex.
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
+ * @id: cached source ID (0 =3D not yet cached)
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
+	.seq =3D SEQCNT_SPINLOCK_ZERO(name.seq, &(name).lock), \
+	.lock =3D __SPIN_LOCK_UNLOCKED(name.lock), \
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
+void blog_log_iter_init(struct blog_log_iter *iter, struct blog_pagefrag *=
pf,
+			u64 head_snapshot);
+struct blog_log_entry *blog_log_iter_next(struct blog_log_iter *iter);
+int blog_des_entry(struct blog_logger *logger, struct blog_log_entry *entr=
y,
+		   char *output, size_t out_size,
+		   blog_client_des_fn client_cb);
+void *blog_log_with_ctx(struct blog_logger *logger,
+			struct blog_tls_ctx *tls_ctx,
+			u32 source_id, u8 client_id, size_t needed_size);
+int blog_log_commit_with_ctx(struct blog_logger *logger,
+			     struct blog_tls_ctx *tls_ctx,
+			     size_t actual_size);
+void blog_log_client_emit(struct blog_tls_ctx *ctx, struct ceph_client *cl=
ient,
+			  struct blog_source_id_cache *cache,
+			  const char *file, const char *func,
+			  unsigned int line, const char *fmt, size_t nargs);
+static inline struct blog_tls_pagefrag *blog_ctx_container(struct blog_tls=
_ctx *ctx)
+{
+	return container_of(ctx, struct blog_tls_pagefrag, ctx);
+}
+
+static inline struct blog_pagefrag *blog_ctx_pf(struct blog_tls_ctx *ctx)
+{
+	return &blog_ctx_container(ctx)->pf;
+}
+
+#define CEPH_BLOG_LOG_CLIENT(ctx, client, fmt, ...) \
+	do { \
+		static struct blog_source_id_cache __source_cache =3D \
+			BLOG_SOURCE_ID_CACHE_INIT(__source_cache); \
+		struct blog_tls_ctx *__blog_ctx =3D (ctx); \
+		size_t __nargs =3D blog_narg(__VA_ARGS__); \
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
+void blog_pagefrag_publish(struct blog_pagefrag *pf, unsigned int publish_=
head);
+void blog_pagefrag_reset(struct blog_pagefrag *pf);
+void *blog_pagefrag_get_ptr(struct blog_pagefrag *pf, u64 val);
+
+#endif /* _FS_CEPH_BLOG_PAGEFRAG_H */
diff --git a/fs/ceph/blog_ser.h b/fs/ceph/blog_ser.h
new file mode 100644
index 000000000000..dbf783c5a593
--- /dev/null
+++ b/fs/ceph/blog_ser.h
@@ -0,0 +1,285 @@
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
+		.str =3D (const char *)(__str), \
+		.len =3D (__len), \
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
+	__scw_result =3D ((type)(value)); \
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
+ * struct blog_arg - an evaluated argument and its serialization reservati=
on
+ * @value: cached scalar value
+ * @str: cached string pointer
+ * @string_len: measured number of source bytes, excluding the terminator
+ * @reserved: bytes reserved for this argument, including string padding
+ * @is_string: @str and @string_len are valid instead of @value
+ *
+ * Logging macros build these records before reserving pagefrag space.  St=
ring
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
+static inline void blog_arg_set_string(struct blog_arg *arg, const char *s=
tr,
+				       size_t limit)
+{
+	size_t len =3D 0;
+
+	arg->is_string =3D true;
+	arg->str =3D str;
+	if (!str) {
+		arg->string_len =3D 0;
+		arg->reserved =3D sizeof("(NULL) ");
+		return;
+	}
+
+	/*
+	 * @limit is the caller's scan bound.  Unbounded %s passes
+	 * STR_MAX_SIZE; BLOG_STR() passes the caller length (paths,
+	 * NAME_MAX dentries) and must not be silently shrunk to 254.
+	 * Cap only so reserved (=3D round_up(len + 1, 4)) fits in u16.
+	 */
+	limit =3D min_t(size_t, limit, (size_t)U16_MAX - 4);
+	while (len < limit && str[len])
+		len++;
+	arg->string_len =3D len;
+	arg->reserved =3D round_up(len + 1, 4);
+}
+
+#define const_char_ptr(str) __suppress_cast_warning(const char *, (str))
+/* Integer-width round-trip so both if-branches type-check for any arg. */
+#define bounded_string_ptr(str) \
+	((const struct blog_bounded_string *)(unsigned long)(str))
+
+#define BLOG_ARG(__arg) \
+({ \
+	__auto_type __blog_value =3D (__arg); \
+	struct blog_arg __blog_arg =3D {}; \
+	if (IS_BOUNDED_STR(__blog_value)) { \
+		const struct blog_bounded_string *__blog_str =3D \
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
+		if (sizeof(__blog_value) =3D=3D sizeof(void *)) \
+			__blog_arg.value =3D (u64)__suppress_cast_warning( \
+				unsigned long, __blog_value); \
+		else \
+			__blog_arg.value =3D __suppress_cast_warning( \
+				u64, __blog_value); \
+		__blog_arg.reserved =3D sizeof(__blog_value) < 4 ? \
+			4 : sizeof(__blog_value); \
+	} \
+	__blog_arg; \
+})
+
+#define ___blog_args0()
+#define ___blog_args1(__t) BLOG_ARG(__t)
+#define ___blog_args2(__t, __args...) BLOG_ARG(__t), ___blog_args1(__args)
+#define ___blog_args3(__t, __args...) BLOG_ARG(__t), ___blog_args2(__args)
+#define ___blog_args4(__t, __args...) BLOG_ARG(__t), ___blog_args3(__args)
+#define ___blog_args5(__t, __args...) BLOG_ARG(__t), ___blog_args4(__args)
+#define ___blog_args6(__t, __args...) BLOG_ARG(__t), ___blog_args5(__args)
+#define ___blog_args7(__t, __args...) BLOG_ARG(__t), ___blog_args6(__args)
+#define ___blog_args8(__t, __args...) BLOG_ARG(__t), ___blog_args7(__args)
+#define ___blog_args9(__t, __args...) BLOG_ARG(__t), ___blog_args8(__args)
+#define ___blog_args10(__t, __args...) BLOG_ARG(__t), ___blog_args9(__args)
+#define ___blog_args11(__t, __args...) BLOG_ARG(__t), ___blog_args10(__arg=
s)
+#define ___blog_args12(__t, __args...) BLOG_ARG(__t), ___blog_args11(__arg=
s)
+#define ___blog_args13(__t, __args...) BLOG_ARG(__t), ___blog_args12(__arg=
s)
+#define ___blog_args14(__t, __args...) BLOG_ARG(__t), ___blog_args13(__arg=
s)
+#define ___blog_args15(__t, __args...) BLOG_ARG(__t), ___blog_args14(__arg=
s)
+#define ___blog_args16(__t, __args...) BLOG_ARG(__t), ___blog_args15(__arg=
s)
+#define ___blog_args17(__t, __args...) BLOG_ARG(__t), ___blog_args16(__arg=
s)
+#define ___blog_args18(__t, __args...) BLOG_ARG(__t), ___blog_args17(__arg=
s)
+#define ___blog_args19(__t, __args...) BLOG_ARG(__t), ___blog_args18(__arg=
s)
+#define ___blog_args20(__t, __args...) BLOG_ARG(__t), ___blog_args19(__arg=
s)
+#define ___blog_args21(__t, __args...) BLOG_ARG(__t), ___blog_args20(__arg=
s)
+#define ___blog_args22(__t, __args...) BLOG_ARG(__t), ___blog_args21(__arg=
s)
+#define ___blog_args23(__t, __args...) BLOG_ARG(__t), ___blog_args22(__arg=
s)
+#define ___blog_args24(__t, __args...) BLOG_ARG(__t), ___blog_args23(__arg=
s)
+#define ___blog_args25(__t, __args...) BLOG_ARG(__t), ___blog_args24(__arg=
s)
+#define ___blog_args26(__t, __args...) BLOG_ARG(__t), ___blog_args25(__arg=
s)
+#define ___blog_args27(__t, __args...) BLOG_ARG(__t), ___blog_args26(__arg=
s)
+#define ___blog_args28(__t, __args...) BLOG_ARG(__t), ___blog_args27(__arg=
s)
+#define ___blog_args29(__t, __args...) BLOG_ARG(__t), ___blog_args28(__arg=
s)
+#define ___blog_args30(__t, __args...) BLOG_ARG(__t), ___blog_args29(__arg=
s)
+#define ___blog_args31(__t, __args...) BLOG_ARG(__t), ___blog_args30(__arg=
s)
+#define ___blog_args32(__t, __args...) BLOG_ARG(__t), ___blog_args31(__arg=
s)
+#define BLOG_ARGS(...) \
+	___blog_apply(___blog_args, blog_narg(__VA_ARGS__))(__VA_ARGS__)
+
+/*
+ * Write args into a caller-supplied array (the per-task TLS scratch).
+ * Do not use a compound literal / VLA here: that is what blew VFS
+ * stack frames when boutc() inlined the old CEPH_BLOG_LOG_CLIENT.
+ */
+#define ___blog_fill0(__dst, ...) do { } while (0)
+#define ___blog_fill1(__dst, _a0) do { (__dst)[0] =3D BLOG_ARG(_a0); } whi=
le (0)
+#define ___blog_fill2(__dst, _a0, _a1) do { (__dst)[0] =3D BLOG_ARG(_a0); =
(__dst)[1] =3D BLOG_ARG(_a1); } while (0)
+#define ___blog_fill3(__dst, _a0, _a1, _a2) do { (__dst)[0] =3D BLOG_ARG(_=
a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); } while (0)
+#define ___blog_fill4(__dst, _a0, _a1, _a2, _a3) do { (__dst)[0] =3D BLOG_=
ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__ds=
t)[3] =3D BLOG_ARG(_a3); } while (0)
+#define ___blog_fill5(__dst, _a0, _a1, _a2, _a3, _a4) do { (__dst)[0] =3D =
BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); =
(__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); } while (0)
+#define ___blog_fill6(__dst, _a0, _a1, _a2, _a3, _a4, _a5) do { (__dst)[0]=
 =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_=
a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5]=
 =3D BLOG_ARG(_a5); } while (0)
+#define ___blog_fill7(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6) do { (__ds=
t)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_=
ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__ds=
t)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); } while (0)
+#define ___blog_fill8(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7) do { =
(__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D =
BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); =
(__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D =
BLOG_ARG(_a7); } while (0)
+#define ___blog_fill9(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8) =
do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2]=
 =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_=
a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7]=
 =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); } while (0)
+#define ___blog_fill10(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__d=
st)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG=
_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__d=
st)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG=
_ARG(_a9); } while (0)
+#define ___blog_fill11(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1)=
; (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =
=3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a=
6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =
=3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); } while (0)
+#define ___blog_fill12(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_AR=
G(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)=
[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_AR=
G(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)=
[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG=
_ARG(_a11); } while (0)
+#define ___blog_fill13(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D B=
LOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (=
__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D B=
LOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (=
__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[11] =
=3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); } while (0)
+#define ___blog_fill14(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1]=
 =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_=
a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6]=
 =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_=
a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[=
11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D BLO=
G_ARG(_a13); } while (0)
+#define ___blog_fill15(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14) do { (__dst)[0] =3D BLOG_ARG(_a0); (__d=
st)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG=
_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__d=
st)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG=
_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (_=
_dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =
=3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); } while (0)
+#define ___blog_fill16(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15) do { (__dst)[0] =3D BLOG_ARG(_a0)=
; (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =
=3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a=
5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =
=3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_=
a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__ds=
t)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =3D =
BLOG_ARG(_a15); } while (0)
+#define ___blog_fill17(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16) do { (__dst)[0] =3D BLOG_AR=
G(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)=
[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_AR=
G(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)=
[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_A=
RG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (=
__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =
=3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); } while (0)
+#define ___blog_fill18(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17) do { (__dst)[0] =3D B=
LOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (=
__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D B=
LOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (=
__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D =
BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a=
12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst=
)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17] =3D B=
LOG_ARG(_a17); } while (0)
+#define ___blog_fill19(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18) do { (__dst)[0]=
 =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_=
a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5]=
 =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_=
a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10=
] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_=
ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); =
(__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17]=
 =3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18); } while (0)
+#define ___blog_fill20(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19) do { (__d=
st)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG=
_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__d=
st)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG=
_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__d=
st)[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D=
 BLOG_ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_=
a14); (__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__ds=
t)[17] =3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18); (__dst)[19] =3D =
BLOG_ARG(_a19); } while (0)
+#define ___blog_fill21(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20) do =
{ (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =
=3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a=
4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =
=3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a=
9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)=
[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BL=
OG_ARG(_a14); (__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16=
); (__dst)[17] =3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18); (__dst)[=
19] =3D BLOG_ARG(_a19); (__dst)[20] =3D BLOG_ARG(_a20); } while (0)
+#define ___blog_fill22(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)=
[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_AR=
G(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)=
[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_AR=
G(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__=
dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =
=3D BLOG_ARG(_a14); (__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_AR=
G(_a16); (__dst)[17] =3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18); (_=
_dst)[19] =3D BLOG_ARG(_a19); (__dst)[20] =3D BLOG_ARG(_a20); (__dst)[21] =
=3D BLOG_ARG(_a21); } while (0)
+#define ___blog_fill23(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (=
__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D B=
LOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (=
__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D B=
LOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11=
); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[=
14] =3D BLOG_ARG(_a14); (__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLO=
G_ARG(_a16); (__dst)[17] =3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18)=
; (__dst)[19] =3D BLOG_ARG(_a19); (__dst)[20] =3D BLOG_ARG(_a20); (__dst)[2=
1] =3D BLOG_ARG(_a21); (__dst)[22] =3D BLOG_ARG(_a22); } while (0)
+#define ___blog_fill24(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_=
a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4]=
 =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_=
a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9]=
 =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_AR=
G(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (_=
_dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =
=3D BLOG_ARG(_a16); (__dst)[17] =3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_AR=
G(_a18); (__dst)[19] =3D BLOG_ARG(_a19); (__dst)[20] =3D BLOG_ARG(_a20); (_=
_dst)[21] =3D BLOG_ARG(_a21); (__dst)[22] =3D BLOG_ARG(_a22); (__dst)[23] =
=3D BLOG_ARG(_a23); } while (0)
+#define ___blog_fill25(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG=
_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__d=
st)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG=
_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__d=
st)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D B=
LOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a1=
3); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =3D BLOG_ARG(_a15); (__dst)=
[16] =3D BLOG_ARG(_a16); (__dst)[17] =3D BLOG_ARG(_a17); (__dst)[18] =3D BL=
OG_ARG(_a18); (__dst)[19] =3D BLOG_ARG(_a19); (__dst)[20] =3D BLOG_ARG(_a20=
); (__dst)[21] =3D BLOG_ARG(_a21); (__dst)[22] =3D BLOG_ARG(_a22); (__dst)[=
23] =3D BLOG_ARG(_a23); (__dst)[24] =3D BLOG_ARG(_a24); } while (0)
+#define ___blog_fill26(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24, _a25) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)[1] =
=3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_ARG(_a=
3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)[6] =
=3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_ARG(_a=
8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__dst)[1=
1] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D BLOG=
_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =3D BLOG_ARG(_a15);=
 (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17] =3D BLOG_ARG(_a17); (__dst)[18=
] =3D BLOG_ARG(_a18); (__dst)[19] =3D BLOG_ARG(_a19); (__dst)[20] =3D BLOG_=
ARG(_a20); (__dst)[21] =3D BLOG_ARG(_a21); (__dst)[22] =3D BLOG_ARG(_a22); =
(__dst)[23] =3D BLOG_ARG(_a23); (__dst)[24] =3D BLOG_ARG(_a24); (__dst)[25]=
 =3D BLOG_ARG(_a25); } while (0)
+#define ___blog_fill27(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24, _a25, _a26) do { (__dst)[0] =3D BLOG_ARG(_a0); (__dst)=
[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D BLOG_AR=
G(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (__dst)=
[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D BLOG_AR=
G(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10); (__ds=
t)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13] =3D =
BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =3D BLOG_ARG(_a=
15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17] =3D BLOG_ARG(_a17); (__dst=
)[18] =3D BLOG_ARG(_a18); (__dst)[19] =3D BLOG_ARG(_a19); (__dst)[20] =3D B=
LOG_ARG(_a20); (__dst)[21] =3D BLOG_ARG(_a21); (__dst)[22] =3D BLOG_ARG(_a2=
2); (__dst)[23] =3D BLOG_ARG(_a23); (__dst)[24] =3D BLOG_ARG(_a24); (__dst)=
[25] =3D BLOG_ARG(_a25); (__dst)[26] =3D BLOG_ARG(_a26); } while (0)
+#define ___blog_fill28(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24, _a25, _a26, _a27) do { (__dst)[0] =3D BLOG_ARG(_a0); (=
__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3] =3D B=
LOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_a5); (=
__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8] =3D B=
LOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(_a10);=
 (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__dst)[13=
] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =3D BLOG_=
ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17] =3D BLOG_ARG(_a17); =
(__dst)[18] =3D BLOG_ARG(_a18); (__dst)[19] =3D BLOG_ARG(_a19); (__dst)[20]=
 =3D BLOG_ARG(_a20); (__dst)[21] =3D BLOG_ARG(_a21); (__dst)[22] =3D BLOG_A=
RG(_a22); (__dst)[23] =3D BLOG_ARG(_a23); (__dst)[24] =3D BLOG_ARG(_a24); (=
__dst)[25] =3D BLOG_ARG(_a25); (__dst)[26] =3D BLOG_ARG(_a26); (__dst)[27] =
=3D BLOG_ARG(_a27); } while (0)
+#define ___blog_fill29(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24, _a25, _a26, _a27, _a28) do { (__dst)[0] =3D BLOG_ARG(_=
a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__dst)[3]=
 =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG_ARG(_=
a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__dst)[8]=
 =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLOG_ARG(=
_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12); (__d=
st)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[15] =3D=
 BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17] =3D BLOG_ARG(_=
a17); (__dst)[18] =3D BLOG_ARG(_a18); (__dst)[19] =3D BLOG_ARG(_a19); (__ds=
t)[20] =3D BLOG_ARG(_a20); (__dst)[21] =3D BLOG_ARG(_a21); (__dst)[22] =3D =
BLOG_ARG(_a22); (__dst)[23] =3D BLOG_ARG(_a23); (__dst)[24] =3D BLOG_ARG(_a=
24); (__dst)[25] =3D BLOG_ARG(_a25); (__dst)[26] =3D BLOG_ARG(_a26); (__dst=
)[27] =3D BLOG_ARG(_a27); (__dst)[28] =3D BLOG_ARG(_a28); } while (0)
+#define ___blog_fill30(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24, _a25, _a26, _a27, _a28, _a29) do { (__dst)[0] =3D BLOG=
_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a2); (__d=
st)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =3D BLOG=
_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a7); (__d=
st)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10] =3D BLO=
G_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_ARG(_a12)=
; (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (__dst)[1=
5] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17] =3D BLOG=
_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18); (__dst)[19] =3D BLOG_ARG(_a19);=
 (__dst)[20] =3D BLOG_ARG(_a20); (__dst)[21] =3D BLOG_ARG(_a21); (__dst)[22=
] =3D BLOG_ARG(_a22); (__dst)[23] =3D BLOG_ARG(_a23); (__dst)[24] =3D BLOG_=
ARG(_a24); (__dst)[25] =3D BLOG_ARG(_a25); (__dst)[26] =3D BLOG_ARG(_a26); =
(__dst)[27] =3D BLOG_ARG(_a27); (__dst)[28] =3D BLOG_ARG(_a28); (__dst)[29]=
 =3D BLOG_ARG(_a29); } while (0)
+#define ___blog_fill31(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24, _a25, _a26, _a27, _a28, _a29, _a30) do { (__dst)[0] =
=3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_ARG(_a=
2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)[5] =
=3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_ARG(_a=
7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)[10]=
 =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BLOG_A=
RG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14); (=
__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[17] =
=3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18); (__dst)[19] =3D BLOG_AR=
G(_a19); (__dst)[20] =3D BLOG_ARG(_a20); (__dst)[21] =3D BLOG_ARG(_a21); (_=
_dst)[22] =3D BLOG_ARG(_a22); (__dst)[23] =3D BLOG_ARG(_a23); (__dst)[24] =
=3D BLOG_ARG(_a24); (__dst)[25] =3D BLOG_ARG(_a25); (__dst)[26] =3D BLOG_AR=
G(_a26); (__dst)[27] =3D BLOG_ARG(_a27); (__dst)[28] =3D BLOG_ARG(_a28); (_=
_dst)[29] =3D BLOG_ARG(_a29); (__dst)[30] =3D BLOG_ARG(_a30); } while (0)
+#define ___blog_fill32(__dst, _a0, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8,=
 _a9, _a10, _a11, _a12, _a13, _a14, _a15, _a16, _a17, _a18, _a19, _a20, _a2=
1, _a22, _a23, _a24, _a25, _a26, _a27, _a28, _a29, _a30, _a31) do { (__dst)=
[0] =3D BLOG_ARG(_a0); (__dst)[1] =3D BLOG_ARG(_a1); (__dst)[2] =3D BLOG_AR=
G(_a2); (__dst)[3] =3D BLOG_ARG(_a3); (__dst)[4] =3D BLOG_ARG(_a4); (__dst)=
[5] =3D BLOG_ARG(_a5); (__dst)[6] =3D BLOG_ARG(_a6); (__dst)[7] =3D BLOG_AR=
G(_a7); (__dst)[8] =3D BLOG_ARG(_a8); (__dst)[9] =3D BLOG_ARG(_a9); (__dst)=
[10] =3D BLOG_ARG(_a10); (__dst)[11] =3D BLOG_ARG(_a11); (__dst)[12] =3D BL=
OG_ARG(_a12); (__dst)[13] =3D BLOG_ARG(_a13); (__dst)[14] =3D BLOG_ARG(_a14=
); (__dst)[15] =3D BLOG_ARG(_a15); (__dst)[16] =3D BLOG_ARG(_a16); (__dst)[=
17] =3D BLOG_ARG(_a17); (__dst)[18] =3D BLOG_ARG(_a18); (__dst)[19] =3D BLO=
G_ARG(_a19); (__dst)[20] =3D BLOG_ARG(_a20); (__dst)[21] =3D BLOG_ARG(_a21)=
; (__dst)[22] =3D BLOG_ARG(_a22); (__dst)[23] =3D BLOG_ARG(_a23); (__dst)[2=
4] =3D BLOG_ARG(_a24); (__dst)[25] =3D BLOG_ARG(_a25); (__dst)[26] =3D BLOG=
_ARG(_a26); (__dst)[27] =3D BLOG_ARG(_a27); (__dst)[28] =3D BLOG_ARG(_a28);=
 (__dst)[29] =3D BLOG_ARG(_a29); (__dst)[30] =3D BLOG_ARG(_a30); (__dst)[31=
] =3D BLOG_ARG(_a31); } while (0)
+#define BLOG_FILL_ARGS(__dst, ...) \
+	___blog_apply(___blog_fill, blog_narg(__VA_ARGS__))(__dst, __VA_ARGS__)
+
+static inline size_t blog_args_size(const struct blog_arg *args,
+				    size_t nr_args)
+{
+	size_t size =3D 0;
+	size_t i;
+
+	for (i =3D 0; i < nr_args; i++)
+		size +=3D args[i].reserved;
+	return size;
+}
+
+static inline size_t blog_serialize_string(char *dst,
+					   const struct blog_arg *arg)
+{
+	static const char null_str[] =3D "(NULL) ";
+	size_t limit;
+	size_t count;
+
+	if (!arg->str) {
+		memcpy(dst, null_str, min(sizeof(null_str), arg->reserved));
+		return arg->reserved;
+	}
+
+	limit =3D min(arg->string_len, arg->reserved - 1);
+	for (count =3D 0; count < limit; count++) {
+		dst[count] =3D arg->str[count];
+		if (!dst[count])
+			return round_up(count + 1, 4);
+	}
+	dst[count] =3D '\0';
+	return round_up(count + 1, 4);
+}
+
+static inline void *blog_serialize_args(void *buffer,
+					const struct blog_arg *args,
+					size_t nr_args)
+{
+	char *dst =3D buffer;
+	size_t i;
+
+	for (i =3D 0; i < nr_args; i++) {
+		const struct blog_arg *arg =3D &args[i];
+
+		if (arg->is_string) {
+			dst +=3D blog_serialize_string(dst, arg);
+		} else if (arg->reserved =3D=3D 8) {
+			put_unaligned(arg->value, (u64 *)dst);
+			dst +=3D 8;
+		} else {
+			put_unaligned((u32)arg->value, (u32 *)dst);
+			dst +=3D 4;
+		}
+	}
+	return dst;
+}
+
+#endif /* _FS_CEPH_BLOG_SER_H */
--=20
2.34.1

