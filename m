Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC89416127
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348734; cv=none; b=l6KGSWYzk7hgct2HSY6NXjBek7LpblJN1aMSIgDeAOh7jCJZ1M5+83zCIf2E/EwC8HHxifWJv2njbpmXUjI0/FqO37laNFz3XIea6pDmYGhSLk2d9UJscKp+iC+HCzl5VDKO23NB/MiuWsJYL8nUxAfA1cGw/nml98Zw3iBledQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348734; c=relaxed/simple;
	bh=yHRFRCbuW5Pc2nyNZqIqKolDr9ayGlnezaY3ukiA0t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhLVzYDFtg5kn15TVPUc4Ts6D/2KU0nojeMwBEJFuzVsWg7pjqnyYc8XriwHT4RU6Z12UAjQhAkpan4HqL4Bb33r5EmdZbYVLQbvwFcSINFLwc88mfOttmktglCLGVTugS2PXL5xZ33VmIKww+yE6c4amGUFDVU+364w8ftycTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFCU1nfn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sRYHl6iB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFCU1nfn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sRYHl6iB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZhuJyxh9F9MorzH2Pb8bu6i0Ik6AkYXaj3X5PLTBjA=;
	b=MFCU1nfnDY+9nK6kOaeykxM5NZTCN0hGo7T8KNWcdXezHi17Zs0m6VspYkgFPNLn2Mj/rc
	o8oJocQAwdYszzronzyVuw/PeXGb0PxNs0vbQkvxD1tHheVjlhdbzYiDa+K6VUmj2NiMIO
	BAnpSBEuoUC71vPEyl7aA+SuwUwOFZc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-uQgyH1hrODyep2nnHE2RYQ-1; Mon, 06 Jul 2026 10:38:49 -0400
X-MC-Unique: uQgyH1hrODyep2nnHE2RYQ-1
X-Mimecast-MFC-AGG-ID: uQgyH1hrODyep2nnHE2RYQ_1783348728
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c12792a87d1so231272466b.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348728; x=1783953528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZhuJyxh9F9MorzH2Pb8bu6i0Ik6AkYXaj3X5PLTBjA=;
        b=sRYHl6iBok/PcLzSVA+ii9Xr8YSdYxZvzazguKBu0vM+eVpNeTsYSEiAxD3+9aX27f
         yJiS3m5GRJqBrgWbZJDZs8M++yRN5AjxtYaKSE/Y+ZezFZXBLeKP2kTe7/5SeyMwDxhr
         pDmMxUdk0jj7Uebhkf919G7JWyYDWTtjuCFJSGNGHrmyvs8rEO5T/QyzJLx3amsQmkt7
         HfBjrcVbMsrvsWwxINqMxc2ICRSZ3rn9bIinmCx/Yblwfno9HVUKDH6B1q5PyfjSuuEz
         uM7+HIN92nr/o2rzqMpG7+3IapJfPGR/YHPb5wy7Lcs37cYYNmqFM7odvZOaIE/e1Wuh
         okfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348728; x=1783953528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZhuJyxh9F9MorzH2Pb8bu6i0Ik6AkYXaj3X5PLTBjA=;
        b=AtnPVfPC/NzCJq+e/Fic4gQuF3r3YqMhVjN8jYPsCiSfWEcezPMAZGSwtjCuRKJKty
         qI8BTSVrfEBj4BUAU842rNXMhF1Y9KXat88X0SAdunXuOkbIiRhjLJ4zsq1cU72ubaU7
         x6OwIZBgF1D+b4IDIJEh6j0IE8p45X6KIHb173cSl92KP/C6x/HnhbVW1/UxRj9+q/qe
         ENhpXXPgCH/EPMU9Ad4KxOi2ZkjIiXHPUXZhYav/ScrSlVcPJbjKXv3ZtN4BFDCEzNDY
         k4XKdqSmtxlfRoLJ3/wlE4NgNGRIlmzQrQBVoRV+bIXs3syeBLKWFjydHz5EdecPXYXY
         KaPg==
X-Gm-Message-State: AOJu0YyevQAg2r/fRV/hJtycygE6PSQr31GBHn3rQRoR3qY+uTr/hDkf
	Q8ZcpUR3WdbLs/mDGR72FZ/imx1F6gS1APypF4uXsOvKW2IBL5uk1xBFMwAtnzvi+AH7v/8XH9U
	K0nVMTcW7ipB4oF/N0WWp8tJVt2qk1bRwuUyAbrEBs/1E1ScKIGGW9XaIrzeoYf4S216qXNTgqs
	y5ZrLiKvN4PT7PuyNeoB4YuBgA7cBmDT5bU2qoxlsKyTkXMS3hOA==
X-Gm-Gg: AfdE7cmQfczqKCFqYqhLOGiGLWiMhCnOnE4nwnpcVOPH0V/OQcK++15F4YvZb5D5w4m
	nxfeb+KSWt8PjpbzkuEA4zCWudK1r9gfcFQqSqkVjOtHabzVrYM+s7yIlt2V9BGy1AL1QmpVWfU
	SR52J/rgiKb+c4tN79ZiS3JEyVpw5MYla8bgnpLsJKQ+wJ7lg1KOgrvq78AU0YTmC8NffMoMD/I
	qM2fTqXTHC2hh71qp8HU0JKSvOgNhfqn+E1WC+8Q9sLMYIRFGHow8w4Wq116M+VvYtxSPoYsoxO
	2G4qdy/RX5wAwmFIgxXl6Ab+BIJu4hUumLOGP5LULrmRD8R+TgxdtfPQs8xxZt3b6fcDf+MFpX1
	7t8m6FrxYHPSNp1Ed/ek/DuQU/XGAiivRQCFdU8LM8mpC
X-Received: by 2002:a17:907:bf06:b0:c12:36ff:6ebb with SMTP id a640c23a62f3a-c15a692b12dmr44988666b.44.1783348727217;
        Mon, 06 Jul 2026 07:38:47 -0700 (PDT)
X-Received: by 2002:a17:907:bf06:b0:c12:36ff:6ebb with SMTP id a640c23a62f3a-c15a692b12dmr44986566b.44.1783348726408;
        Mon, 06 Jul 2026 07:38:46 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:45 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 01/15] ceph: add BLOG public headers
Date: Mon,  6 Jul 2026 14:38:29 +0000
Message-Id: <20260706143843.1980879-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706143843.1980879-1-amarkuze@redhat.com>
References: <20260706143843.1980879-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the public header files for the binary logging (BLOG) subsystem:

  blog.h          - core types: blog_logger, blog_log_entry,
                    blog_tls_ctx, blog_source_info, blog_log_iter,
                    blog_source_id_cache; core API prototypes
  blog_ser.h      - type-safe serialization macros (blog_ser,
                    blog_cnt) with compile-time type dispatch
  blog_des.h      - deserialization prototypes
  blog_batch.h    - per-CPU magazine batch allocator types
  blog_pagefrag.h - page-fragment allocator types
  blog_module.h   - per-module context types (blog_task_entry,
                    blog_module_context) and the __BLOG_LOG_CTX
                    macro that drives the per-callsite fast path

All headers live under include/linux/ceph/ since BLOG is consumed
exclusively by the CephFS client.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/blog.h          | 196 +++++++++++++++++++++
 include/linux/ceph/blog_batch.h    |  44 +++++
 include/linux/ceph/blog_des.h      |  16 ++
 include/linux/ceph/blog_module.h   |  91 ++++++++++
 include/linux/ceph/blog_pagefrag.h |  32 ++++
 include/linux/ceph/blog_ser.h      | 270 +++++++++++++++++++++++++++++
 6 files changed, 649 insertions(+)
 create mode 100644 include/linux/ceph/blog.h
 create mode 100644 include/linux/ceph/blog_batch.h
 create mode 100644 include/linux/ceph/blog_des.h
 create mode 100644 include/linux/ceph/blog_module.h
 create mode 100644 include/linux/ceph/blog_pagefrag.h
 create mode 100644 include/linux/ceph/blog_ser.h

diff --git a/include/linux/ceph/blog.h b/include/linux/ceph/blog.h
new file mode 100644
index 000000000000..edc0e1aa05bf
--- /dev/null
+++ b/include/linux/ceph/blog.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Binary Logging Infrastructure (BLOG)
+ *
+ * Generic binary logging infrastructure for kernel subsystems.
+ * Modules maintain their own client mappings and debugfs interfaces.
+ */
+#ifndef _LINUX_CEPH_BLOG_H
+#define _LINUX_CEPH_BLOG_H
+
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/rhashtable-types.h>
+#include <linux/ceph/blog_batch.h>
+#include <linux/ceph/blog_pagefrag.h>
+#include <linux/ceph/blog_ser.h>
+#include <linux/ceph/blog_des.h>
+
+struct blog_module_context;
+
+#ifdef CONFIG_BLOG_DEBUG
+#define BLOG_DEBUG_POISON 1
+#else
+#define BLOG_DEBUG_POISON 0
+#endif
+
+#ifdef CONFIG_BLOG_TRACK_USAGE
+#define BLOG_TRACK_USAGE 1
+#else
+#define BLOG_TRACK_USAGE 0
+#endif
+
+#if BLOG_DEBUG_POISON
+#define BLOG_LOG_ENTRY_POISON 0xD1E7C0DE
+#define BLOG_CTX_POISON 0xCAFEBABE
+#endif
+
+#define BLOG_MAX_PAYLOAD 255
+#ifdef CONFIG_BLOG_MAX_SOURCES
+#define BLOG_MAX_SOURCE_IDS CONFIG_BLOG_MAX_SOURCES
+#else
+#define BLOG_MAX_SOURCE_IDS 4096
+#endif
+#ifdef CONFIG_BLOG_MAX_CLIENTS
+#define BLOG_MAX_CLIENT_IDS CONFIG_BLOG_MAX_CLIENTS
+#else
+#define BLOG_MAX_CLIENT_IDS 256
+#endif
+
+struct blog_source_info {
+	const char *file;
+	const char *func;
+	unsigned int line;
+	const char *fmt;
+	int warn_count;
+#if BLOG_TRACK_USAGE
+	atomic_t napi_usage;
+	atomic_t task_usage;
+	atomic_t napi_bytes;
+	atomic_t task_bytes;
+#endif
+};
+
+struct blog_log_entry {
+#if BLOG_DEBUG_POISON
+	u64 debug_poison;
+#endif
+	u32 ts_delta;
+	u16 source_id;
+	u8 len;
+	u8 client_id;
+	u8 flags;
+	char buffer[];
+};
+
+#define BLOG_CTX_NEEDS_RESET	0
+
+struct blog_tls_ctx {
+	struct list_head list;
+	void (*release)(void *data);
+	atomic_t refcount;
+	struct task_struct *task;
+	pid_t pid;
+	char comm[TASK_COMM_LEN];
+	u64 id;
+#if BLOG_DEBUG_POISON
+	u64 debug_poison;
+#endif
+	unsigned long base_jiffies;
+	struct blog_logger *logger;
+	int pending_offset;
+	size_t pending_size;
+	unsigned long flags;
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
+	struct rhashtable task_map;
+	struct blog_batch alloc_batch;
+	struct blog_batch log_batch;
+	struct kmem_cache *magazine_cache;
+	struct blog_source_info *source_map;
+	atomic_t next_source_id;
+	spinlock_t source_lock;
+	unsigned long total_contexts_allocated;
+	u64 next_ctx_id;
+	spinlock_t ctx_id_lock;
+	struct blog_tls_ctx *__percpu
+		*napi_ctxs;
+	struct blog_module_context *owner_ctx;
+	u64 generation;
+};
+
+/**
+ * struct blog_source_id_cache - per-callsite source ID fast cache
+ * @logger: logger that owns the cached ID
+ * @generation: logger generation at cache-fill time
+ * @id: cached source ID (0 = not yet cached)
+ */
+struct blog_source_id_cache {
+	struct blog_logger *logger;
+	u64 generation;
+	u32 id;
+};
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
+u32 blog_get_source_id(struct blog_logger *logger, const char *file,
+		       const char *func, unsigned int line, const char *fmt);
+u32 blog_get_source_id_cached(struct blog_logger *logger,
+			      struct blog_source_id_cache *cache,
+			      const char *file, const char *func,
+			      unsigned int line, const char *fmt);
+struct blog_source_info *blog_get_source_info(struct blog_logger *logger,
+					      u32 id);
+void *blog_log(struct blog_logger *logger, u32 source_id, u8 client_id,
+	       size_t needed_size);
+int blog_log_commit(struct blog_logger *logger, size_t actual_size);
+struct blog_tls_ctx *blog_get_tls_ctx(struct blog_logger *logger);
+struct blog_tls_ctx *blog_get_napi_ctx(struct blog_logger *logger);
+void blog_set_napi_ctx(struct blog_logger *logger, struct blog_tls_ctx *ctx);
+struct blog_tls_ctx *blog_get_ctx(struct blog_logger *logger);
+void blog_log_iter_init(struct blog_log_iter *iter, struct blog_pagefrag *pf,
+			u64 head_snapshot);
+struct blog_log_entry *blog_log_iter_next(struct blog_log_iter *iter);
+int blog_des_entry(struct blog_logger *logger, struct blog_log_entry *entry,
+		   char *output, size_t out_size,
+		   blog_client_des_fn client_cb);
+bool blog_is_valid_kernel_addr(const void *addr);
+
+static inline void blog_logger_print_stats(struct blog_logger *logger)
+{
+	pr_debug(
+		"blog: total_contexts=%lu, alloc_batch={empty=%d, full=%d}, log_batch={empty=%d, full=%d}\n",
+		logger->total_contexts_allocated, logger->alloc_batch.nr_empty,
+		logger->alloc_batch.nr_full, logger->log_batch.nr_empty,
+		logger->log_batch.nr_full);
+}
+
+static inline struct blog_tls_pagefrag *blog_ctx_container(struct blog_tls_ctx *ctx)
+{
+	return container_of(ctx, struct blog_tls_pagefrag, ctx);
+}
+
+static inline void *blog_ctx_buffer(struct blog_tls_ctx *ctx)
+{
+	return blog_ctx_container(ctx)->buf;
+}
+
+static inline struct blog_pagefrag *blog_ctx_pf(struct blog_tls_ctx *ctx)
+{
+	return &blog_ctx_container(ctx)->pf;
+}
+
+#endif /* _LINUX_CEPH_BLOG_H */
diff --git a/include/linux/ceph/blog_batch.h b/include/linux/ceph/blog_batch.h
new file mode 100644
index 000000000000..be61ebd37c17
--- /dev/null
+++ b/include/linux/ceph/blog_batch.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Binary Logging Batch Management
+ */
+#ifndef _LINUX_CEPH_BLOG_BATCH_H
+#define _LINUX_CEPH_BLOG_BATCH_H
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
+	spinlock_t full_lock;
+	spinlock_t empty_lock;
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
+void blog_batch_put(struct blog_batch *batch, void *element);
+
+#endif /* _LINUX_CEPH_BLOG_BATCH_H */
diff --git a/include/linux/ceph/blog_des.h b/include/linux/ceph/blog_des.h
new file mode 100644
index 000000000000..a5ce1ed6290a
--- /dev/null
+++ b/include/linux/ceph/blog_des.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Binary Logging Deserialization
+ */
+#ifndef _LINUX_CEPH_BLOG_DES_H
+#define _LINUX_CEPH_BLOG_DES_H
+
+#include <linux/types.h>
+
+struct blog_log_entry;
+struct blog_logger;
+
+int blog_des_reconstruct(const char *fmt, const void *buffer,
+			 size_t size, char *out, size_t out_size);
+
+#endif /* _LINUX_CEPH_BLOG_DES_H */
diff --git a/include/linux/ceph/blog_module.h b/include/linux/ceph/blog_module.h
new file mode 100644
index 000000000000..41651f6bc742
--- /dev/null
+++ b/include/linux/ceph/blog_module.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Binary Logging Infrastructure (BLOG) - Per-Module Support
+ *
+ * Each kernel module can have its own isolated logging context.
+ * Per-task context association uses an rhashtable keyed by task pointer,
+ * with PID validation for stale-entry detection.
+ */
+#ifndef _LINUX_CEPH_BLOG_MODULE_H
+#define _LINUX_CEPH_BLOG_MODULE_H
+
+#include <linux/ceph/blog.h>
+#include <linux/rhashtable.h>
+
+struct blog_task_entry {
+	struct rhash_head	node;
+	struct task_struct	*task;
+	pid_t			pid;
+	char			comm[TASK_COMM_LEN];
+	struct blog_tls_ctx	*ctx;
+	struct rcu_head		rcu;
+};
+
+struct blog_module_context {
+	char name[32];
+	struct blog_logger *logger;
+	void *module_private;
+	struct list_head list;
+	atomic_t refcount;
+	atomic_t allocated_contexts;
+	bool initialized;
+};
+
+struct blog_module_context *blog_module_init(const char *module_name);
+void blog_module_cleanup(struct blog_module_context *ctx);
+void blog_module_get(struct blog_module_context *ctx);
+void blog_module_put(struct blog_module_context *ctx);
+
+struct blog_tls_ctx *blog_get_tls_ctx_ctx(struct blog_module_context *ctx);
+struct blog_tls_ctx *blog_get_napi_ctx_ctx(struct blog_module_context *ctx);
+void blog_set_napi_ctx_ctx(struct blog_module_context *ctx,
+			   struct blog_tls_ctx *tls_ctx);
+struct blog_tls_ctx *blog_get_ctx_ctx(struct blog_module_context *ctx);
+
+u32 blog_get_source_id_ctx(struct blog_module_context *ctx, const char *file,
+			   const char *func, unsigned int line, const char *fmt);
+struct blog_source_info *blog_get_source_info_ctx(struct blog_module_context *ctx,
+						  u32 id);
+
+void *blog_log_with_ctx(struct blog_logger *logger,
+			struct blog_tls_ctx *tls_ctx,
+			u32 source_id, u8 client_id, size_t needed_size);
+int blog_log_commit_with_ctx(struct blog_logger *logger,
+			     struct blog_tls_ctx *tls_ctx,
+			     size_t actual_size);
+
+#define BLOG_LOG_CTX(ctx, fmt, ...) \
+	__BLOG_LOG_CTX(ctx, 0, 0, fmt, ##__VA_ARGS__)
+
+#define BLOG_LOG_CLIENT_CTX(ctx, client_id, fmt, ...) \
+	__BLOG_LOG_CTX(ctx, 0, client_id, fmt, ##__VA_ARGS__)
+
+#define __BLOG_LOG_CTX(__ctx, dbg, __client_id, fmt, ...) \
+	do { \
+		static u32 __source_id; \
+		static size_t __size; \
+		struct blog_tls_ctx *__tls; \
+		void *___buffer = NULL; \
+		(void)(dbg); \
+		if (unlikely(!(__ctx) || !(__ctx)->logger)) \
+			break; \
+		__tls = blog_get_ctx_ctx(__ctx); \
+		if (unlikely(!__tls)) \
+			break; \
+		if (unlikely(__source_id == 0)) { \
+			__source_id = blog_get_source_id_ctx(__ctx, \
+				kbasename(__FILE__), __func__, __LINE__, fmt); \
+			__size = blog_cnt(__VA_ARGS__); \
+		} \
+		___buffer = blog_log_with_ctx((__ctx)->logger, __tls, \
+					      __source_id, __client_id, __size); \
+		if (likely(___buffer)) { \
+			void *___tmp = ___buffer; \
+			if (__size > 0) \
+				blog_ser(___buffer, ##__VA_ARGS__); \
+			blog_log_commit_with_ctx((__ctx)->logger, __tls, \
+						 ___buffer - ___tmp); \
+		} \
+	} while (0)
+
+#endif /* _LINUX_CEPH_BLOG_MODULE_H */
diff --git a/include/linux/ceph/blog_pagefrag.h b/include/linux/ceph/blog_pagefrag.h
new file mode 100644
index 000000000000..b48095d9690c
--- /dev/null
+++ b/include/linux/ceph/blog_pagefrag.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Binary Logging Page Fragment Management
+ */
+#ifndef _LINUX_CEPH_BLOG_PAGEFRAG_H
+#define _LINUX_CEPH_BLOG_PAGEFRAG_H
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+
+#define BLOG_PAGEFRAG_SIZE  (1<<17)  /* 128KB */
+#define BLOG_PAGEFRAG_MASK (BLOG_PAGEFRAG_SIZE - 1)
+
+struct blog_pagefrag {
+	struct page *pages;
+	void *buffer;
+	size_t capacity;
+	spinlock_t lock;
+	unsigned int head;
+	unsigned int alloc_count;
+	int active_elements;
+	void *last_entry;
+};
+
+int blog_pagefrag_init_with_buffer(struct blog_pagefrag *pf, void *buffer, size_t size);
+int blog_pagefrag_reserve(struct blog_pagefrag *pf, unsigned int n);
+void blog_pagefrag_publish(struct blog_pagefrag *pf, u64 publish_head);
+void blog_pagefrag_reset(struct blog_pagefrag *pf);
+void *blog_pagefrag_get_ptr(struct blog_pagefrag *pf, u64 val);
+
+#endif /* _LINUX_CEPH_BLOG_PAGEFRAG_H */
diff --git a/include/linux/ceph/blog_ser.h b/include/linux/ceph/blog_ser.h
new file mode 100644
index 000000000000..1d570388ff09
--- /dev/null
+++ b/include/linux/ceph/blog_ser.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Binary Logging Serialization
+ */
+#ifndef _LINUX_CEPH_BLOG_SER_H
+#define _LINUX_CEPH_BLOG_SER_H
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#define IS_CONST_STR_PTR(t) \
+	__builtin_types_compatible_p(typeof(t), const char *)
+
+#define IS_STR_PTR(t) \
+	__builtin_types_compatible_p(typeof(t), char *)
+
+#define IS_STR(t) \
+	(__builtin_types_compatible_p(typeof(t), const char *) || \
+	__builtin_types_compatible_p(typeof(t), char *))
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
+#define __sizeof(x) \
+	(IS_STR(x) ? STR_MAX_SIZE : \
+	 (sizeof(x) < 4) ? 4 : sizeof(x))
+
+/* Size calculation macros */
+#define ___blog_cnt0()		(0)
+#define ___blog_cnt1(__t)		(__sizeof(__t))
+#define ___blog_cnt2(__t, __args...)	(___blog_cnt1(__args) + __sizeof(__t))
+#define ___blog_cnt3(__t, __args...)	(___blog_cnt2(__args) + __sizeof(__t))
+#define ___blog_cnt4(__t, __args...)	(___blog_cnt3(__args) + __sizeof(__t))
+#define ___blog_cnt5(__t, __args...)	(___blog_cnt4(__args) + __sizeof(__t))
+#define ___blog_cnt6(__t, __args...)	(___blog_cnt5(__args) + __sizeof(__t))
+#define ___blog_cnt7(__t, __args...)	(___blog_cnt6(__args) + __sizeof(__t))
+#define ___blog_cnt8(__t, __args...)	(___blog_cnt7(__args) + __sizeof(__t))
+#define ___blog_cnt9(__t, __args...)	(___blog_cnt8(__args) + __sizeof(__t))
+#define ___blog_cnt10(__t, __args...)	(___blog_cnt9(__args) + __sizeof(__t))
+#define ___blog_cnt11(__t, __args...)	(___blog_cnt10(__args) + __sizeof(__t))
+#define ___blog_cnt12(__t, __args...)	(___blog_cnt11(__args) + __sizeof(__t))
+#define ___blog_cnt13(__t, __args...)	(___blog_cnt12(__args) + __sizeof(__t))
+#define ___blog_cnt14(__t, __args...)	(___blog_cnt13(__args) + __sizeof(__t))
+#define ___blog_cnt15(__t, __args...)	(___blog_cnt14(__args) + __sizeof(__t))
+#define ___blog_cnt16(__t, __args...)	(___blog_cnt15(__args) + __sizeof(__t))
+#define ___blog_cnt17(__t, __args...)	(___blog_cnt16(__args) + __sizeof(__t))
+#define ___blog_cnt18(__t, __args...)	(___blog_cnt17(__args) + __sizeof(__t))
+#define ___blog_cnt19(__t, __args...)	(___blog_cnt18(__args) + __sizeof(__t))
+#define ___blog_cnt20(__t, __args...)	(___blog_cnt19(__args) + __sizeof(__t))
+#define ___blog_cnt21(__t, __args...)	(___blog_cnt20(__args) + __sizeof(__t))
+#define ___blog_cnt22(__t, __args...)	(___blog_cnt21(__args) + __sizeof(__t))
+#define ___blog_cnt23(__t, __args...)	(___blog_cnt22(__args) + __sizeof(__t))
+#define ___blog_cnt24(__t, __args...)	(___blog_cnt23(__args) + __sizeof(__t))
+#define ___blog_cnt25(__t, __args...)	(___blog_cnt24(__args) + __sizeof(__t))
+#define ___blog_cnt26(__t, __args...)	(___blog_cnt25(__args) + __sizeof(__t))
+#define ___blog_cnt27(__t, __args...)	(___blog_cnt26(__args) + __sizeof(__t))
+#define ___blog_cnt28(__t, __args...)	(___blog_cnt27(__args) + __sizeof(__t))
+#define ___blog_cnt29(__t, __args...)	(___blog_cnt28(__args) + __sizeof(__t))
+#define ___blog_cnt30(__t, __args...)	(___blog_cnt29(__args) + __sizeof(__t))
+#define ___blog_cnt31(__t, __args...)	(___blog_cnt30(__args) + __sizeof(__t))
+#define ___blog_cnt32(__t, __args...)	(___blog_cnt31(__args) + __sizeof(__t))
+#define blog_cnt(...)	 ___blog_apply(___blog_cnt, blog_narg(__VA_ARGS__))(__VA_ARGS__)
+
+#define IS_STR_ARRAY(t) \
+	__builtin_types_compatible_p(typeof(t), char [])
+
+#define IS_DYNAMIC_CHAR_PTR(t) \
+	(__builtin_classify_type((t)) == 14 && \
+	 __builtin_types_compatible_p(typeof(t), char *) && \
+	 !__builtin_constant_p((t)))
+
+#define IS_STATIC_CHAR_ARRAY(t) \
+	(__builtin_classify_type((t)) == 5 && \
+	 __builtin_types_compatible_p(typeof(t), char[]) && \
+	 __builtin_constant_p((t)))
+
+#define IS_DYNAMIC_CHAR_ARRAY(t) \
+	(__builtin_classify_type((t)) == 5 && \
+	 __builtin_types_compatible_p(typeof(t), char[]) && \
+	 !__builtin_constant_p((t)))
+
+#define char_ptr(str) __suppress_cast_warning(char *, (str))
+
+#ifndef _BLOG_SER_HELPERS_DEFINED
+#define _BLOG_SER_HELPERS_DEFINED
+
+union null_str_u {
+	char str[8];
+	unsigned long force_align;
+};
+
+static const union null_str_u null_str = {
+	.str = "(NULL) \0"
+};
+
+static inline size_t write_null_str(char *dst)
+{
+	*(union null_str_u *)dst = null_str;
+	static_assert(sizeof(null_str.str) == sizeof(unsigned long),
+		     "null_str.str size must match unsigned long for proper alignment");
+	return __builtin_strlen(null_str.str);
+}
+
+static inline size_t strscpy_n(char *dst, const char *src)
+{
+	size_t count = 0;
+
+	while (count < STR_MAX_SIZE - 1) {
+		dst[count] = src[count];
+		if (src[count] == '\0')
+			goto out;
+		count++;
+	}
+
+	dst[count] = '\0';
+	pr_warn("blog_ser: string truncated, exceeded max size %d\n", STR_MAX_SIZE);
+out:
+	return count + 1;
+}
+
+static inline ssize_t __strscpy(char *dst, const char *src)
+{
+	if (src != NULL)
+		return strscpy_n(dst, src);
+	return write_null_str(dst);
+}
+
+static inline void *strscpy_n_update(char *dst, const char *src, const char *file, int line)
+{
+	ssize_t ret = __strscpy(dst, src);
+
+	if (unlikely(ret <= 0 || ret >= STR_MAX_SIZE)) {
+		pr_err("blog_ser: string handling error ret=%zd at %s:%d :: dst='%s' src='%s'\n",
+		       ret, file, line, dst, src ? src : "(null)");
+		if (ret >= STR_MAX_SIZE) {
+			dst[STR_MAX_SIZE - 1] = '\0';
+			ret = STR_MAX_SIZE;
+		} else {
+			dst[0] = '\0';
+			ret = 1;
+		}
+	}
+	return dst + round_up(ret, 4);
+}
+
+#endif /* _BLOG_SER_HELPERS_DEFINED */
+
+#define __blog_ser_type(__buffer, __t)                          \
+	(__builtin_choose_expr(IS_STATIC_CHAR_ARRAY((__t)),               \
+		((__buffer) = (void *)strscpy_n_update((__buffer),            \
+						char_ptr(__t),                             \
+						kbasename(__FILE__),                      \
+						__LINE__)),                               \
+	__builtin_choose_expr(IS_STR((__t)),               \
+		((__buffer) = (void *)strscpy_n_update((__buffer),            \
+						char_ptr(__t),                             \
+						kbasename(__FILE__),                      \
+						__LINE__)),                               \
+	__builtin_choose_expr(IS_STR_ARRAY((__t)),               \
+		 ((__buffer) = (void *)strscpy_n_update((__buffer),        \
+						char_ptr(__t),                       \
+						kbasename(__FILE__),                \
+						__LINE__)),                          \
+	__builtin_choose_expr(sizeof((__t)) == 1,                         \
+		(*(u32 *)(__buffer) = __suppress_cast_warning(u32, (__t)), \
+		 (__buffer) = (void *)((char *)(__buffer) + 4)),            \
+	__builtin_choose_expr(sizeof((__t)) == 2,                         \
+		(*(u32 *)(__buffer) = __suppress_cast_warning(u32, (__t)), \
+		 (__buffer) = (void *)((char *)(__buffer) + 4)),            \
+	__builtin_choose_expr(sizeof((__t)) == 4,                         \
+		(*(u32 *)(__buffer) = __suppress_cast_warning(u32, (__t)), \
+		 (__buffer) = (void *)((char *)(__buffer) + 4)),            \
+	__builtin_choose_expr(sizeof((__t)) == 8,                         \
+		(*(u64 *)(__buffer) = __suppress_cast_warning(u64, (__t)), \
+		 (__buffer) = (void *)((char *)(__buffer) + 8)),            \
+		(pr_err("UNSUPPORTED_TYPE: %s:%d: unsupported type size %zu\n",       \
+			kbasename(__FILE__), __LINE__, sizeof(__t)))              \
+	))))))))
+
+/* Serialization macros */
+#define ___blog_ser0(__buffer)
+#define ___blog_ser1(__buffer, __t)           (__blog_ser_type(__buffer, __t))
+#define ___blog_ser2(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser1(__buffer, __args))
+#define ___blog_ser3(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser2(__buffer, __args))
+#define ___blog_ser4(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser3(__buffer, __args))
+#define ___blog_ser5(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser4(__buffer, __args))
+#define ___blog_ser6(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser5(__buffer, __args))
+#define ___blog_ser7(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser6(__buffer, __args))
+#define ___blog_ser8(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser7(__buffer, __args))
+#define ___blog_ser9(__buffer, __t, __args...)    \
+	(__blog_ser_type(__buffer, __t), ___blog_ser8(__buffer, __args))
+#define ___blog_ser10(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser9(__buffer, __args))
+#define ___blog_ser11(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser10(__buffer, __args))
+#define ___blog_ser12(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser11(__buffer, __args))
+#define ___blog_ser13(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser12(__buffer, __args))
+#define ___blog_ser14(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser13(__buffer, __args))
+#define ___blog_ser15(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser14(__buffer, __args))
+#define ___blog_ser16(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser15(__buffer, __args))
+#define ___blog_ser17(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser16(__buffer, __args))
+#define ___blog_ser18(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser17(__buffer, __args))
+#define ___blog_ser19(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser18(__buffer, __args))
+#define ___blog_ser20(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser19(__buffer, __args))
+#define ___blog_ser21(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser20(__buffer, __args))
+#define ___blog_ser22(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser21(__buffer, __args))
+#define ___blog_ser23(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser22(__buffer, __args))
+#define ___blog_ser24(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser23(__buffer, __args))
+#define ___blog_ser25(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser24(__buffer, __args))
+#define ___blog_ser26(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser25(__buffer, __args))
+#define ___blog_ser27(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser26(__buffer, __args))
+#define ___blog_ser28(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser27(__buffer, __args))
+#define ___blog_ser29(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser28(__buffer, __args))
+#define ___blog_ser30(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser29(__buffer, __args))
+#define ___blog_ser31(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser30(__buffer, __args))
+#define ___blog_ser32(__buffer, __t, __args...)   \
+	(__blog_ser_type(__buffer, __t), ___blog_ser31(__buffer, __args))
+#define ___blog_ser(__buffer, ...)   \
+	___blog_apply(___blog_ser, blog_narg(__VA_ARGS__))(__buffer, ##__VA_ARGS__)
+#define blog_ser(...)  ___blog_ser(__VA_ARGS__)
+
+#endif /* _LINUX_CEPH_BLOG_SER_H */
-- 
2.34.1

