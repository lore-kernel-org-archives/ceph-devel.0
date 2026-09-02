Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAC4A9D48
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365059; cv=none; b=IszLq09tSfL+A8QbE75fDrL4IPKx3eqnQ36VOi/qBbd/VIg01kGXWD+41dAy7EHHC1W022zgXFS1rPcHewqFEN/fw4Ju9kHdlLg2PrazR6MLDz4/hktTaCDhHOMvTjktuz1iv58eknW6oimBqhsWKb+d2lDVX0nBz5zkTKwae0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365059; c=relaxed/simple;
	bh=SbmWbpP5tQz58yKEd4dCgCPnT6BiQ/DFek+0m/gdSD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fndMV8YXjRDLptmkxGlujE6lRsp5fdLuD4MDarUm+QeQq3vrAVECXwKuTe6RwYr4iKdhtIhhUMwtAEfuuVL7I5iB8ofpNrCikLCYy5R5zUx64B80aL5sczSQjOBX9AI8LWpbjupUDH8bXoD/OWcSqpiOR42BPVnkWBrLhQmt/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYaVLyfk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sVzFaHnO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYaVLyfk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sVzFaHnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788365055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRom0KN7AXaVLlMtVJxE+miWBQ/3NaUIMZ+Y8QGbt2I=;
	b=FYaVLyfkwLe8Dlzx/H0WO4ESECzwHSffJkr7hT7WhhyG6M/lAKm1ZRirrAUpf1iJrKVXrn
	uBss/NqowvRdJRBjShr7Hl+GFdwI0VIhZtDx8A93oy0rcDYQjWnewYi2ugCtjYIQOVLZUS
	+izWkCGdaGjUMBPRwU3MoECpsjTYSpY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-YzJzvGqoMaS4u8lXuxUHkw-1; Wed, 02 Sep 2026 12:04:13 -0400
X-MC-Unique: YzJzvGqoMaS4u8lXuxUHkw-1
X-Mimecast-MFC-AGG-ID: YzJzvGqoMaS4u8lXuxUHkw_1788365052
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1f548718d0so137405366b.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788365052; x=1788969852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRom0KN7AXaVLlMtVJxE+miWBQ/3NaUIMZ+Y8QGbt2I=;
        b=sVzFaHnOqiAPU0J50cMx1R4tDXEVXJiExXZTH2H2Cvk59c3g9ZkoLG1/6ulPbBGDu4
         Kexob8cRyz9lp1VEIm4e14r4RYFDStgZ0BgZhtndry6dXZCTufssCNop4IVYqlsNlitJ
         AvbL7sS8kTWCT+6iKW1BnERnxUb3EWeOdW9gse+xarqbLNDdzQoWoM4qJcOJsbV/GngR
         /Fcpl59z6BB9i2pvX8JqB0R53DNYw4n2GkLkJvrM2VMi09mSGoMFbiiTI53AzL2wGpIq
         DHtYKaMvSQ88VvmdKgiJ2RtZq7fzjNE4ENeGhWgWALqopdZxNOgkAsQVZVNNCd7lYnnD
         6oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365052; x=1788969852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRom0KN7AXaVLlMtVJxE+miWBQ/3NaUIMZ+Y8QGbt2I=;
        b=HzgTM2IydNlQuuYf29BMF1gH9028ehHv+Y7Lpp3garIdf7+9ExxBjx61+Gna5pv3Mb
         YQPuumAHjSxuhRvAgV51TI91FBjNFjuV899Uf4IsV0zIE23xMKXL/NhjLQ0fqfc85NCb
         akpV+RExaAfQzAxI1tEWohLyED71q7vJAB5rPP6qVJdVpe2mApN1/n0kstGwcLu2C/la
         tvDkPcWaPr8Hcp1cxgZzAaLZySsG4NLsAP0lqMa9Om1NloIy/lV3/Mkav9d/SW7H70cu
         RaZH4ylwx6GUYSX45GfgFVYgJ+BYGNSvZWkm9dyYyWFeBIAkWQwhKjWk4kOjFDdEaFRC
         uJXg==
X-Gm-Message-State: AFuF++lPdpSRGVz9PGAqEshDeH8LvoTDU8RVOK/1Kxw5C0eqlkPuG9GE
	GWrnKuLVXSYiYqBgltE2xxkOyNeHiX8paeffqBaJmCZsVMVYwjsB+o+az6Q/BThBWg5GRbQwibA
	mowv4r3qMMs85HrfWGkn3v32hVqTUfs++7JmTYtBRqURfAkxsUQnj2neOm8zWMlSvJcEw79AwSu
	bCM9d/MUp17egxqSGTv39/SJrtEWNU1N5+g/KLhUdm6n4xN0o=
X-Gm-Gg: AYBFou1vuSzRryrujYnBrahIdJXrpcuYthAeN944B34if6atAeep5sy7FZBRwc/ddxd
	FOk1s79gXiu7G17moRacMbH1M2Dkz+8p6sgwG5NbLi9UVOJQ7yqaPacNA4RmaKf+HkxaL1Pu4jv
	T7JpUyCHZLfxuJEfnNvb/ajOBd6bfg45gm3dx2Eu2/HkDT7Wm92TU6zzReDj9NfytvLUtgFC3lO
	P5GdeTBrW+Hxmf05sjm60S7tA1DLyY4O+iwwaHFk7csvY2O3xnx70RnGwF3hNlML6OPQmG+5utM
	ZErWpKcozRJ0QcMhGAhGlXtQfHtdCV/9t2cGGStj/aQOBdS2ay532S5T+GgF069X5SheNXFGZpo
	I7GO/oWlgpJDQGXxaeBtthZ2bWMe3uNDmu7Bex5LKHsY6vH5SIzFoxqMpkYCCJUtGzTUOw0CgXv
	raUPH+h4e/t7G9Vg==
X-Received: by 2002:a17:907:c78a:b0:c25:541e:be7d with SMTP id a640c23a62f3a-c25d55b8807mr447767766b.18.1788365052094;
        Wed, 02 Sep 2026 09:04:12 -0700 (PDT)
X-Received: by 2002:a17:907:c78a:b0:c25:541e:be7d with SMTP id a640c23a62f3a-c25d55b8807mr447761266b.18.1788365051534;
        Wed, 02 Sep 2026 09:04:11 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7108sm165874566b.10.2026.09.02.09.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:04:11 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 01/14] ceph: add BLOG private headers
Date: Wed,  2 Sep 2026 16:03:54 +0000
Message-Id: <20260902160407.3196013-2-amarkuze@redhat.com>
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

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog.h          | 220 +++++++++++++++++++++++++++++++++++++
 fs/ceph/blog_batch.h    |  44 ++++++++
 fs/ceph/blog_des.h      |  16 +++
 fs/ceph/blog_module.h   |  42 ++++++++
 fs/ceph/blog_pagefrag.h |  27 +++++
 fs/ceph/blog_ser.h      | 234 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 583 insertions(+)
 create mode 100644 fs/ceph/blog.h
 create mode 100644 fs/ceph/blog_batch.h
 create mode 100644 fs/ceph/blog_des.h
 create mode 100644 fs/ceph/blog_module.h
 create mode 100644 fs/ceph/blog_pagefrag.h
 create mode 100644 fs/ceph/blog_ser.h

diff --git a/fs/ceph/blog.h b/fs/ceph/blog.h
new file mode 100644
index 000000000000..2d68c09a635f
--- /dev/null
+++ b/fs/ceph/blog.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CephFS binary logging (BLOG) private types.
+ */
+#ifndef _FS_CEPH_BLOG_H
+#define _FS_CEPH_BLOG_H
+
+#include <linux/types.h>
+#include <linux/limits.h>
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
+	/* Nested ceph_blog_enter* depth for this task; bout uses CPU cache only while > 0. */
+	unsigned int enter_depth;
+	/* CPU whose per-CPU cache slot bind published; unbind clears it after migration. */
+	int cache_cpu;
+	/* Matches logger->clear_seq after a reset; readers treat mismatch as empty. */
+	atomic64_t clear_seq;
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
+#define CEPH_BLOG_LOG_CLIENT(ctx, client, fmt, ...) \
+	do { \
+		static struct blog_source_id_cache __source_cache = \
+			BLOG_SOURCE_ID_CACHE_INIT(__source_cache); \
+		struct blog_tls_ctx *__blog_ctx = (ctx); \
+		struct blog_logger *__logger; \
+		if (unlikely(!__blog_ctx)) \
+			break; \
+		__logger = __blog_ctx->logger; \
+		if (unlikely(!__logger)) \
+			break; \
+		{ \
+			struct blog_arg __args[blog_narg(__VA_ARGS__) ?: 1] = { \
+				BLOG_ARGS(__VA_ARGS__) \
+			}; \
+			size_t __nargs = blog_narg(__VA_ARGS__); \
+			size_t __size = blog_args_size(__args, __nargs); \
+			void *___buffer; \
+			u32 __client_id; \
+			u32 __sid; \
+			__sid = blog_get_source_id_cached(__logger, \
+					&__source_cache, \
+					kbasename(__FILE__), __func__, \
+					__LINE__, fmt); \
+			if (unlikely(__sid == 0)) \
+				break; \
+			__client_id = ceph_blog_get_client_id(client); \
+			___buffer = blog_log_with_ctx(__logger, __blog_ctx, \
+						      __sid, __client_id, \
+						      __size); \
+			if (likely(___buffer)) { \
+				void *___tmp = ___buffer; \
+				___buffer = blog_serialize_args(___buffer, \
+						__args, __nargs); \
+				blog_log_commit_with_ctx(__logger, __blog_ctx, \
+						___buffer - ___tmp); \
+			} \
+		} \
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
index 000000000000..b8627370175a
--- /dev/null
+++ b/fs/ceph/blog_ser.h
@@ -0,0 +1,234 @@
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
+		__blog_arg.value = __suppress_cast_warning(u64, __blog_value); \
+		__blog_arg.reserved = sizeof(__blog_value) < 4 ? \
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
+#define ___blog_args11(__t, __args...) BLOG_ARG(__t), ___blog_args10(__args)
+#define ___blog_args12(__t, __args...) BLOG_ARG(__t), ___blog_args11(__args)
+#define ___blog_args13(__t, __args...) BLOG_ARG(__t), ___blog_args12(__args)
+#define ___blog_args14(__t, __args...) BLOG_ARG(__t), ___blog_args13(__args)
+#define ___blog_args15(__t, __args...) BLOG_ARG(__t), ___blog_args14(__args)
+#define ___blog_args16(__t, __args...) BLOG_ARG(__t), ___blog_args15(__args)
+#define ___blog_args17(__t, __args...) BLOG_ARG(__t), ___blog_args16(__args)
+#define ___blog_args18(__t, __args...) BLOG_ARG(__t), ___blog_args17(__args)
+#define ___blog_args19(__t, __args...) BLOG_ARG(__t), ___blog_args18(__args)
+#define ___blog_args20(__t, __args...) BLOG_ARG(__t), ___blog_args19(__args)
+#define ___blog_args21(__t, __args...) BLOG_ARG(__t), ___blog_args20(__args)
+#define ___blog_args22(__t, __args...) BLOG_ARG(__t), ___blog_args21(__args)
+#define ___blog_args23(__t, __args...) BLOG_ARG(__t), ___blog_args22(__args)
+#define ___blog_args24(__t, __args...) BLOG_ARG(__t), ___blog_args23(__args)
+#define ___blog_args25(__t, __args...) BLOG_ARG(__t), ___blog_args24(__args)
+#define ___blog_args26(__t, __args...) BLOG_ARG(__t), ___blog_args25(__args)
+#define ___blog_args27(__t, __args...) BLOG_ARG(__t), ___blog_args26(__args)
+#define ___blog_args28(__t, __args...) BLOG_ARG(__t), ___blog_args27(__args)
+#define ___blog_args29(__t, __args...) BLOG_ARG(__t), ___blog_args28(__args)
+#define ___blog_args30(__t, __args...) BLOG_ARG(__t), ___blog_args29(__args)
+#define ___blog_args31(__t, __args...) BLOG_ARG(__t), ___blog_args30(__args)
+#define ___blog_args32(__t, __args...) BLOG_ARG(__t), ___blog_args31(__args)
+#define BLOG_ARGS(...) \
+	___blog_apply(___blog_args, blog_narg(__VA_ARGS__))(__VA_ARGS__)
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

