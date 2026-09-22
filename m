Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB154B1A7
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085688; cv=none; b=W3nAQBQN5IjudDtPFCIGiOMwFpTnNRqO+LRM4noIp8ldUlkbdpHa8uB4yAn8TRQ2YqQXOU0PgkSUhqdS2snrsPtzJy3Ec5CVUxokHjaavu2ReMZVxaeqPNPBW3lDYjhIX/LJG+G2PmcorlMnGRrptqNtW1dhtO4g+tEZn3Lvl8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085688; c=relaxed/simple;
	bh=XD1TWXBFGeiE1x0lwiGC8XrSkgvSAZenPdjt+JsGDDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDGV50MUxQdwm1G56J6S0mmkVEU1adBEqy4hdxHTk8nq0zu2kA/1HW6Px8SIpgKc6EhWCTrANZSdXDVyGxNG3NS9JTkRAY2kKLubJon2EhalFH1cugMqIOkt4Q3MqEKrsYcIshQ3VZF0G35xmJWzYg7ZiESyOglj06HlItIsSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOu5RYv5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc1Lkuan; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOu5RYv5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc1Lkuan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UnRoqyPdYuZNd+sih7w19mDEO9TETdPTt0W7lO7GM0=;
	b=SOu5RYv5BssI1uEOphNzod2lqVaJWhqXF8TgTNTM2tIO0XmmPA9p7QVBJGb2tAc8s/01wS
	i1zxKwe7EfLpOtDQofCJImwFbNijhJttTpW0EFAkLI8wuL9td64+LopHDsYcY2GQaXOoK5
	NVcmFAxjYjzsDiEo8173zZB1NgGFQak=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-n3dUzu1vN5eIZTwIgAhDLA-1; Tue, 22 Sep 2026 10:01:22 -0400
X-MC-Unique: n3dUzu1vN5eIZTwIgAhDLA-1
X-Mimecast-MFC-AGG-ID: n3dUzu1vN5eIZTwIgAhDLA_1790085682
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66c73057f18so3987666d50.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085682; x=1790690482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UnRoqyPdYuZNd+sih7w19mDEO9TETdPTt0W7lO7GM0=;
        b=Cc1Lkuan1xaBglqHLR32K+ejFEOfVsJW7kebtg42dAmHfjHjJcTBpjxzQ4J8x4lh7C
         UJjPawQoMr7dBh1c45ukHLpatZjvAIUE7yTrIJP2J+ECWzoxXDecAwHfno2bnTyHOvmN
         3metqzAqPG7H2VgpCly/78Bt3uKsUtfHmR5enwcwTF1Q2E7/KdV6f6l2DWjnuq4De288
         /F85Sm8lkfO5h9vf6fcyydtkCLabIEZGSp+BVaoVxsDGgD1Dji8p0jN1OKKwFt+8Cn+R
         YC5ViqQ5IAqgKInZ31olYddaWdWVVbdJimkmk9NZ9DvJg3BM8fnwPDaoznLs7mGTKSB6
         fNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085682; x=1790690482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UnRoqyPdYuZNd+sih7w19mDEO9TETdPTt0W7lO7GM0=;
        b=vjikk0xtA6QQ5vz9AnAiXIzZAcvlWaQIUR4NpONrpbQVGKObaaMRNiIOkZYK7KUv9A
         BhdPqNuY92a8HyugBBKPElMX7POcJ4YQupOlYH66NkOcUoSQlDNDVflj6NfbHKHF0rFj
         051He94fscqsQnQ8BJzs77Ec0khQq7jTFM/L6YCIOC1QLT4OKwqtTxOjyaJsqpXiviRO
         dyt5sLePEfNWJ0thvOyH+ACMsuC6D6ZyyHS1XHy4sNvaHuStoJuNjCvYsKK/bSDNz9jW
         yGJZdI8pdTOC3pVkMc3kZTZT8mYvYfYW+6mpSZ1u0UfIO75FHPUxphSECiwKpetbet6y
         I9FA==
X-Gm-Message-State: AFuF++kJg0e/fDjg5noExwiAewL5M5xJJrfBi1H44HtvIZ3o/pNrctma
	HkiYC+djgTgPq42xZ7HUV7ONbTt/0W157klo2jRtC7QhP725tDgle5Y2LKVAqce/wdAgoSFsII4
	iJQE4kwakuqwTmySvpvGxIHd8khvN3NfLj93Fg670RAwvGKYN4SYeoy274zkjlSFtFUn4+YHWgN
	GZAxrFUHXRYQYh+Luc+nC4lKnyhzXc+DEFC1JbM0gnJEVlLqvlNQ==
X-Gm-Gg: AYBFou2lvWWAgbJlnegUXnYYKOqBQbPbTs3RmGgRBxcrDZtgKyGibOy77OYRhoYI0h8
	HLqKLdXlVw1Atq/Y1XvyxqmGyCpJF3ALJeh+2kADDVvTgR58jE4GHhaFc98BXzkZq62zqulwSsP
	R0xpg9Y6xjbqipPbVvti7oh5dO7eIp9Cjw6QPyik2jd2Pe95ScLmI32fCl2Bxgkoiauri8UgeWu
	+tO+SJjj4bOzaYNOMzzrwmynMwPnvdjk5QXlcB4D7ms6bPJeLfmpkFoRo0d+0O91aO+rNTCUsw9
	OSmx2FDk4Vd+41ko+eeDmw41YVZuV83Urs+bZLmh+2SUlrck/arNJHt8FPl9WH64ijg7UfbOaa8
	N/Bq9jP4nIdeW9vei2FClnjMu1mirKoSpY2/b5K3c6hcSmBK+tr9rTQSGN1ziCrQiOKJWi2WUvr
	Zx2bwHzoVHKVp+Uw==
X-Received: by 2002:a05:690e:4503:20b0:671:44fb:9649 with SMTP id 956f58d0204a3-672c53141c3mr679343d50.3.1790085672166;
        Tue, 22 Sep 2026 07:01:12 -0700 (PDT)
X-Received: by 2002:a05:690e:4503:20b0:671:44fb:9649 with SMTP id 956f58d0204a3-672c53141c3mr679180d50.3.1790085669937;
        Tue, 22 Sep 2026 07:01:09 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:01:08 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 07/14] ceph: add Ceph BLOG scaffolding
Date: Tue, 22 Sep 2026 14:00:40 +0000
Message-Id: <20260922140047.794405-8-amarkuze@redhat.com>
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

Wire BLOG into CephFS: ceph_blog.h (journal_info, enter/exit, logging
macros), blog_client.c (per-fsc context lifecycle, client-ID mapping,
and blog_max_sources/blog_max_clients module parameters), super.h
(blog_enabled, blog_ctx, debugfs_blog), libceph.h (blog_client_id),
and Makefile (gate all BLOG objects on CONFIG_DEBUG_FS).

BLOG initialization failures must not prevent CephFS registration.
Warn and leave binary logging unavailable if its global resources
cannot be allocated; attempts to enable it then return -ENODEV.
MDS request tracking remains independent of BLOG availability.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Assisted-by: LLM
---
 fs/ceph/Makefile               |   3 +
 fs/ceph/blog_client.c          | 643 +++++++++++++++++++++++++++++++++
 fs/ceph/super.c                |  61 +++-
 fs/ceph/super.h                |   7 +
 include/linux/ceph/ceph_blog.h | 292 +++++++++++++++
 include/linux/ceph/libceph.h   |   2 +
 6 files changed, 995 insertions(+), 13 deletions(-)
 create mode 100644 fs/ceph/blog_client.c
 create mode 100644 include/linux/ceph/ceph_blog.h

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index ebb29d11ac22..2330229d9783 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -10,6 +10,9 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 	mds_client.o mdsmap.o strings.o ceph_frag.o \
 	debugfs.o util.o metric.o subvolume_metrics.o
 
+ceph-$(CONFIG_DEBUG_FS) += blog_core.o blog_module.o blog_batch.o \
+	blog_pagefrag.o blog_des.o blog_client.o blog_debugfs.o
+
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
 ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
diff --git a/fs/ceph/blog_client.c b/fs/ceph/blog_client.c
new file mode 100644
index 000000000000..9a5ac023d27d
--- /dev/null
+++ b/fs/ceph/blog_client.c
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ceph client ID management for BLOG integration
+ *
+ * Maintains mapping between Ceph's fsid/global_id and BLOG client IDs
+ */
+
+#include <linux/ceph/ceph_debug.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/gfp.h>
+#include <linux/preempt.h>
+#include <linux/sched.h>
+#include <linux/jump_label.h>
+#include <linux/ceph/libceph.h>
+#include <linux/ceph/ceph_blog.h>
+#include "blog.h"
+#include "blog_module.h"
+
+#include "super.h"
+
+DEFINE_STATIC_KEY_FALSE(ceph_blog_key);
+
+static int blog_max_sources = BLOG_DEFAULT_MAX_SOURCES;
+static int blog_max_clients = BLOG_DEFAULT_MAX_CLIENTS;
+
+module_param_named(blog_max_sources, blog_max_sources, int, 0444);
+MODULE_PARM_DESC(blog_max_sources,
+		 "Maximum BLOG source IDs per logger (load-time, default 4096)");
+module_param_named(blog_max_clients, blog_max_clients, int, 0444);
+MODULE_PARM_DESC(blog_max_clients,
+		 "Maximum BLOG client IDs (load-time, default 256)");
+
+int blog_param_max_sources(void)
+{
+	int n = READ_ONCE(blog_max_sources);
+
+	if (n < 2)
+		n = 2;
+	if (n > BLOG_MAX_SOURCE_IDS_CAP)
+		n = BLOG_MAX_SOURCE_IDS_CAP;
+	return n;
+}
+
+int blog_param_max_clients(void)
+{
+	int n = READ_ONCE(blog_max_clients);
+
+	if (n < 2)
+		n = 2;
+	if (n > BLOG_MAX_CLIENT_IDS_CAP)
+		n = BLOG_MAX_CLIENT_IDS_CAP;
+	return n;
+}
+
+/* Global client mapping state */
+static struct {
+	struct ceph_blog_client_info *client_map;
+	/* Parallel to client_map: which ceph_client owns each slot. */
+	struct ceph_client **owners;
+	u32 max_clients;
+	u32 next_client_id;
+	spinlock_t lock;  /* protects client_map */
+	bool initialized;
+} ceph_blog_state = {
+	.next_client_id = 1,  /* Start from 1, 0 is reserved */
+	.lock = __SPIN_LOCK_UNLOCKED(ceph_blog_state.lock),
+	.initialized = false,
+};
+
+static bool ceph_blog_ids_match(const struct ceph_blog_client_info *entry,
+				     const char *fsid, u64 global_id)
+{
+	if (!entry)
+		return false;
+	if (entry->global_id != global_id)
+		return false;
+	return !memcmp(entry->fsid, fsid, sizeof(entry->fsid));
+}
+
+static bool ceph_blog_client_slot_free(const struct ceph_blog_client_info *entry)
+{
+	return !data_race(entry->global_id) &&
+	       !data_race(memchr_inv(entry->fsid, 0, sizeof(entry->fsid)));
+}
+
+int ceph_blog_init(void)
+{
+	u32 max_clients;
+	int ret;
+
+	if (ceph_blog_state.initialized)
+		return 0;
+
+	ret = blog_module_wq_init();
+	if (ret)
+		return ret;
+
+	max_clients = blog_param_max_clients();
+	ceph_blog_state.client_map = kcalloc(max_clients,
+					     sizeof(*ceph_blog_state.client_map),
+					     GFP_KERNEL);
+	if (!ceph_blog_state.client_map) {
+		blog_module_wq_exit();
+		return -ENOMEM;
+	}
+	ceph_blog_state.owners = kcalloc(max_clients,
+					 sizeof(*ceph_blog_state.owners),
+					 GFP_KERNEL);
+	if (!ceph_blog_state.owners) {
+		kfree(ceph_blog_state.client_map);
+		ceph_blog_state.client_map = NULL;
+		blog_module_wq_exit();
+		return -ENOMEM;
+	}
+
+	ceph_blog_state.max_clients = max_clients;
+	ceph_blog_state.next_client_id = 1;
+	ceph_blog_state.initialized = true;
+
+	pr_debug("ceph: BLOG client mapping initialized (max_clients=%u)\n",
+		 max_clients);
+	return 0;
+}
+
+void ceph_blog_cleanup(void)
+{
+	void *client_map = NULL;
+	void *owners = NULL;
+
+	blog_module_flush_frees();
+
+	if (ceph_blog_state.initialized) {
+		spin_lock(&ceph_blog_state.lock);
+		client_map = ceph_blog_state.client_map;
+		ceph_blog_state.client_map = NULL;
+		owners = ceph_blog_state.owners;
+		ceph_blog_state.owners = NULL;
+		ceph_blog_state.max_clients = 0;
+		ceph_blog_state.next_client_id = 1;
+		ceph_blog_state.initialized = false;
+		spin_unlock(&ceph_blog_state.lock);
+		kfree(client_map);
+		kfree(owners);
+		pr_debug("ceph: BLOG client mapping cleaned up\n");
+	}
+
+	blog_module_wq_exit();
+}
+
+int ceph_blog_fsc_init(struct ceph_fs_client *fsc)
+{
+	if (!fsc)
+		return -EINVAL;
+
+	mutex_init(&fsc->blog_mutex);
+	RCU_INIT_POINTER(fsc->blog_ctx, NULL);
+	WRITE_ONCE(fsc->blog_enabled, false);
+	return 0;
+}
+
+int ceph_blog_set_enabled(struct ceph_fs_client *fsc, bool enabled)
+{
+	struct blog_module_context *ctx;
+	bool was_enabled;
+	int ret = 0;
+
+	if (!fsc)
+		return -EINVAL;
+	if (enabled && !READ_ONCE(ceph_blog_state.initialized))
+		return -ENODEV;
+
+	mutex_lock(&fsc->blog_mutex);
+	was_enabled = READ_ONCE(fsc->blog_enabled);
+	ctx = rcu_dereference_protected(fsc->blog_ctx,
+					lockdep_is_held(&fsc->blog_mutex));
+	if (enabled && !ctx) {
+		ctx = blog_module_init("ceph");
+		if (!ctx) {
+			pr_err("ceph: failed to initialize BLOG context for fs client\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+		rcu_assign_pointer(fsc->blog_ctx, ctx);
+	}
+	WRITE_ONCE(fsc->blog_enabled, enabled);
+	if (enabled && !was_enabled)
+		static_branch_inc(&ceph_blog_key);
+	else if (!enabled && was_enabled)
+		static_branch_dec(&ceph_blog_key);
+out:
+	mutex_unlock(&fsc->blog_mutex);
+	return ret;
+}
+
+void ceph_blog_fsc_cleanup(struct ceph_fs_client *fsc)
+{
+	struct blog_module_context *ctx;
+	bool was_enabled;
+
+	if (!fsc)
+		return;
+
+	mutex_lock(&fsc->blog_mutex);
+	was_enabled = READ_ONCE(fsc->blog_enabled);
+	WRITE_ONCE(fsc->blog_enabled, false);
+	if (was_enabled)
+		static_branch_dec(&ceph_blog_key);
+	ctx = rcu_replace_pointer(fsc->blog_ctx, NULL,
+				  lockdep_is_held(&fsc->blog_mutex));
+	mutex_unlock(&fsc->blog_mutex);
+
+	if (ctx) {
+		synchronize_rcu();
+		blog_module_put(ctx);
+		blog_module_flush_frees();
+	}
+}
+
+bool ceph_blog_is_enabled(struct ceph_fs_client *fsc)
+{
+	struct blog_module_context *ctx;
+	bool enabled = false;
+
+	if (!fsc || !READ_ONCE(fsc->blog_enabled))
+		return false;
+
+	rcu_read_lock();
+	ctx = rcu_dereference(fsc->blog_ctx);
+	if (ctx && READ_ONCE(ctx->logger))
+		enabled = true;
+	rcu_read_unlock();
+
+	return enabled;
+}
+
+struct blog_tls_ctx *ceph_blog_acquire_ctx(struct ceph_fs_client *fsc,
+					   gfp_t gfp,
+					   struct blog_module_context **held_mod)
+{
+	struct blog_module_context *ctx;
+	struct blog_tls_ctx *tls_ctx = NULL;
+
+	if (held_mod)
+		*held_mod = NULL;
+
+	if (!fsc || !READ_ONCE(fsc->blog_enabled))
+		return NULL;
+
+	rcu_read_lock();
+	ctx = rcu_dereference(fsc->blog_ctx);
+	if (!ctx || !READ_ONCE(ctx->logger)) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	if (!gfpflags_allow_blocking(gfp)) {
+		/*
+		 * Non-blocking: reuse an existing per-task ctx only.  Do not
+		 * pin the module until lookup hits. A miss must not call
+		 * blog_module_put(), which can sleep in blog_module_free().
+		 */
+		tls_ctx = blog_lookup_tls_ctx(ctx);
+		if (!tls_ctx || !refcount_inc_not_zero(&ctx->refcount)) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		rcu_read_unlock();
+		goto hold;
+	}
+
+	if (!refcount_inc_not_zero(&ctx->refcount)) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	rcu_read_unlock();
+
+	tls_ctx = blog_get_tls_ctx_ctx(ctx, gfp);
+	if (!tls_ctx) {
+		blog_module_put(ctx);
+		return NULL;
+	}
+
+hold:
+	/* Keep the module ref for the enter-exit window; put via blog_mod. */
+	if (held_mod)
+		*held_mod = ctx;
+	else
+		blog_module_put(ctx);
+
+	return tls_ctx;
+}
+
+void ceph_blog_module_put(struct blog_module_context *ctx)
+{
+	blog_module_put(ctx);
+}
+
+struct ceph_blog_cpu_cache {
+	struct task_struct *task;
+	struct blog_tls_ctx *ctx;
+};
+
+static DEFINE_PER_CPU(struct ceph_blog_cpu_cache, ceph_blog_cpu_cache);
+
+static void blog_cpu_cache_clear_slot(struct blog_tls_ctx *ctx, int cpu)
+{
+	struct ceph_blog_cpu_cache *c;
+
+	if (cpu < 0)
+		return;
+	c = per_cpu_ptr(&ceph_blog_cpu_cache, cpu);
+	if (READ_ONCE(c->ctx) == ctx) {
+		WRITE_ONCE(c->task, NULL);
+		WRITE_ONCE(c->ctx, NULL);
+	}
+}
+
+/*
+ * Drop published per-CPU slots for @ctx before GC/retire can free it.
+ * With the single-slot invariant, clearing cache_cpu (and this CPU) is enough.
+ */
+void ceph_blog_cpu_clear(struct blog_tls_ctx *ctx)
+{
+	int cpu;
+
+	if (!ctx)
+		return;
+
+	preempt_disable();
+	cpu = READ_ONCE(ctx->cache_cpu);
+	blog_cpu_cache_clear_slot(ctx, cpu);
+	if (cpu != smp_processor_id())
+		blog_cpu_cache_clear_slot(ctx, smp_processor_id());
+	WRITE_ONCE(ctx->cache_cpu, -1);
+	preempt_enable();
+}
+
+void ceph_blog_cpu_bind(struct blog_tls_ctx *ctx)
+{
+	struct ceph_blog_cpu_cache *c;
+	int cpu, prev_cpu;
+
+	if (!ctx)
+		return;
+
+	/*
+	 * Publish into the per-CPU cache under preempt_disable only.
+	 * Do not migrate_disable() across the enter-exit window: on !RT
+	 * that is preempt_disable and would leave preempt elevated for
+	 * the whole VFS call.  Keep each ctx on at most one CPU slot:
+	 * clear the prior publish before installing the new one.
+	 */
+	preempt_disable();
+	WRITE_ONCE(ctx->enter_depth, READ_ONCE(ctx->enter_depth) + 1);
+	cpu = smp_processor_id();
+	prev_cpu = READ_ONCE(ctx->cache_cpu);
+	if (prev_cpu >= 0 && prev_cpu != cpu)
+		blog_cpu_cache_clear_slot(ctx, prev_cpu);
+	c = this_cpu_ptr(&ceph_blog_cpu_cache);
+	WRITE_ONCE(c->task, current);
+	WRITE_ONCE(c->ctx, ctx);
+	WRITE_ONCE(ctx->cache_cpu, cpu);
+	preempt_enable();
+}
+
+void ceph_blog_cpu_unbind(struct blog_tls_ctx *ctx)
+{
+	int cpu;
+
+	if (!ctx || !READ_ONCE(ctx->enter_depth))
+		return;
+
+	preempt_disable();
+	WRITE_ONCE(ctx->enter_depth, READ_ONCE(ctx->enter_depth) - 1);
+	if (!READ_ONCE(ctx->enter_depth)) {
+		cpu = READ_ONCE(ctx->cache_cpu);
+		blog_cpu_cache_clear_slot(ctx, cpu);
+		if (cpu != smp_processor_id())
+			blog_cpu_cache_clear_slot(ctx, smp_processor_id());
+		WRITE_ONCE(ctx->cache_cpu, -1);
+	}
+	preempt_enable();
+}
+
+struct blog_tls_ctx *ceph_blog_get_cached_ctx(struct ceph_fs_client *fsc)
+{
+	struct ceph_blog_cpu_cache *c;
+	struct blog_tls_ctx *ctx = NULL;
+	struct blog_module_context *mod;
+	struct ceph_journal_info *ji;
+	struct blog_logger *want_logger;
+	int cpu, prev_cpu;
+
+	if (!fsc)
+		return NULL;
+
+	rcu_read_lock();
+	mod = rcu_dereference(fsc->blog_ctx);
+	want_logger = (mod && mod->logger) ? mod->logger : NULL;
+	if (!want_logger) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	preempt_disable();
+	c = this_cpu_ptr(&ceph_blog_cpu_cache);
+	if (likely(READ_ONCE(c->task) == current) && READ_ONCE(c->ctx)) {
+		ctx = READ_ONCE(c->ctx);
+		if (READ_ONCE(ctx->task) == current &&
+		    READ_ONCE(ctx->enter_depth) &&
+		    ctx->logger == want_logger)
+			; /* hit. Mount-scoped */
+		else {
+			WRITE_ONCE(c->task, NULL);
+			WRITE_ONCE(c->ctx, NULL);
+			ctx = NULL;
+		}
+	}
+	preempt_enable();
+	if (ctx) {
+		rcu_read_unlock();
+		return ctx;
+	}
+
+	/*
+	 * Cache miss after preemption.  Prefer the mount-scoped
+	 * journal_info ctx when it matches @fsc so nested multi-mount
+	 * work does not attach to another mount's logger.  Plain
+	 * ceph_blog_enter() never installs journal_info. Recover only
+	 * from @fsc's own task map (not a cross-mount module-list walk).
+	 */
+	ji = ceph_ji_from_current();
+	if (ji && ceph_ji_matches_fsc(ji, fsc)) {
+		if (ji->blog_ctx &&
+		    READ_ONCE(ji->blog_ctx->enter_depth) &&
+		    READ_ONCE(ji->blog_ctx->task) == current &&
+		    ji->blog_ctx->logger == want_logger)
+			ctx = ji->blog_ctx;
+	} else {
+		ctx = blog_lookup_tls_ctx(mod);
+		if (ctx && !(READ_ONCE(ctx->enter_depth) &&
+			     READ_ONCE(ctx->task) == current))
+			ctx = NULL;
+	}
+	rcu_read_unlock();
+
+	if (ctx) {
+		preempt_disable();
+		cpu = smp_processor_id();
+		prev_cpu = READ_ONCE(ctx->cache_cpu);
+		if (prev_cpu >= 0 && prev_cpu != cpu)
+			blog_cpu_cache_clear_slot(ctx, prev_cpu);
+		c = this_cpu_ptr(&ceph_blog_cpu_cache);
+		WRITE_ONCE(c->task, current);
+		WRITE_ONCE(c->ctx, ctx);
+		WRITE_ONCE(ctx->cache_cpu, cpu);
+		preempt_enable();
+		return ctx;
+	}
+
+	return NULL;
+}
+
+/**
+ * ceph_blog_check_client_id - Check if a client ID matches the given fsid:global_id pair
+ * @id: Client ID to check
+ * @fsid: Client FSID to compare
+ * @global_id: Client global ID to compare
+ *
+ * Returns the actual ID of the pair. If the given ID doesn't match, scans for
+ * existing matches or allocates a new ID if no match is found.
+ */
+u32 ceph_blog_check_client_id(u32 id, const char *fsid, u64 global_id)
+{
+	u32 found_id = 0;
+	u32 max_clients;
+	struct ceph_blog_client_info *entry;
+
+	if (unlikely(!ceph_blog_state.initialized)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	spin_lock(&ceph_blog_state.lock);
+	max_clients = ceph_blog_state.max_clients;
+
+	if (id != 0 && id < max_clients) {
+		entry = &ceph_blog_state.client_map[id];
+		if (ceph_blog_ids_match(entry, fsid, global_id)) {
+			found_id = id;
+			goto out;
+		}
+	}
+
+	for (id = 1; id < max_clients; id++) {
+		entry = &ceph_blog_state.client_map[id];
+		if (ceph_blog_ids_match(entry, fsid, global_id)) {
+			found_id = id;
+			goto out;
+		}
+	}
+
+	if (ceph_blog_state.next_client_id < max_clients) {
+		found_id = ceph_blog_state.next_client_id++;
+	} else {
+		found_id = 0;
+		for (id = 1; id < max_clients; id++) {
+			entry = &ceph_blog_state.client_map[id];
+			if (ceph_blog_client_slot_free(entry)) {
+				found_id = id;
+				break;
+			}
+		}
+		if (!found_id) {
+			pr_warn_once("ceph: BLOG client ID space exhausted\n");
+			goto out;
+		}
+	}
+
+	entry = &ceph_blog_state.client_map[found_id];
+	memset(entry, 0, sizeof(*entry));
+	memcpy(entry->fsid, fsid, sizeof(entry->fsid));
+	entry->global_id = global_id;
+
+out:
+	spin_unlock(&ceph_blog_state.lock);
+	return found_id;
+}
+
+/**
+ * ceph_blog_get_client_info - Get client info for a given ID
+ * @id: Client ID
+ *
+ * Reads client_map[] without holding ceph_blog_state.lock.
+ * Writers store fields under the lock. Callers accept the benign
+ * race: a concurrent slot release and reuse may cause old log
+ * entries to show a new client's identity; the impact is cosmetic.
+ */
+const struct ceph_blog_client_info *ceph_blog_get_client_info(u32 id)
+{
+	const struct ceph_blog_client_info *entry;
+
+	if (!READ_ONCE(ceph_blog_state.initialized) ||
+	    id == 0 || id >= READ_ONCE(ceph_blog_state.max_clients))
+		return NULL;
+	entry = &ceph_blog_state.client_map[id];
+	/* Freed/zeroed slots must not deserialize as a valid client. */
+	if (ceph_blog_client_slot_free(entry))
+		return NULL;
+	return entry;
+}
+
+int ceph_blog_client_des_callback(char *buf, size_t size, u8 client_id)
+{
+	const struct ceph_blog_client_info *info;
+	char fsid[16];
+	u64 global_id;
+
+	if (!buf || !size)
+		return -EINVAL;
+	if (client_id == 0)
+		return 0;
+
+	info = ceph_blog_get_client_info(client_id);
+	if (!info)
+		return snprintf(buf, size, "[unknown_client_%u]", client_id);
+
+	global_id = data_race(info->global_id);
+	data_race(memcpy(fsid, info->fsid, sizeof(fsid)));
+	return snprintf(buf, size, "[%pU %llu] ", fsid, global_id);
+}
+
+u32 ceph_blog_get_client_id(struct ceph_client *client)
+{
+	u32 cached;
+	u32 id;
+
+	if (!client)
+		return 0;
+	if (!client->monc.auth)
+		return 0;
+
+	cached = READ_ONCE(client->blog_client_id);
+
+	id = ceph_blog_check_client_id(cached,
+				       client->fsid.fsid,
+				       client->monc.auth->global_id);
+	if (!id)
+		return 0;
+
+	/*
+	 * Record ownership of the (possibly new) slot.  On auth rekey do
+	 * not clear the prior map entry: buffered records still carry the
+	 * old client_id and resolve it lazily on readback.  All of this
+	 * client's slots are freed in ceph_blog_release_client_id() before
+	 * fsc cleanup tears down the buffers.
+	 */
+	spin_lock(&ceph_blog_state.lock);
+	if (ceph_blog_state.initialized &&
+	    id < ceph_blog_state.max_clients)
+		ceph_blog_state.owners[id] = client;
+	spin_unlock(&ceph_blog_state.lock);
+
+	if (cached != id)
+		WRITE_ONCE(client->blog_client_id, id);
+
+	return id;
+}
+
+/**
+ * ceph_blog_release_client_id - Free a client's BLOG ID mapping slots
+ * @client: Ceph client being torn down
+ *
+ * Clears the cached ID on @client and zeroes every global map entry this
+ * client owns (including slots left behind by auth rekey) so the 8-bit
+ * namespace can be reused after remounts / new auth sessions.
+ */
+void ceph_blog_release_client_id(struct ceph_client *client)
+{
+	u32 id;
+
+	if (!client)
+		return;
+
+	WRITE_ONCE(client->blog_client_id, 0);
+
+	spin_lock(&ceph_blog_state.lock);
+	if (!ceph_blog_state.initialized) {
+		spin_unlock(&ceph_blog_state.lock);
+		return;
+	}
+	for (id = 1; id < ceph_blog_state.max_clients; id++) {
+		if (ceph_blog_state.owners[id] != client)
+			continue;
+		ceph_blog_state.owners[id] = NULL;
+		memset(&ceph_blog_state.client_map[id], 0,
+		       sizeof(*ceph_blog_state.client_map));
+	}
+	spin_unlock(&ceph_blog_state.lock);
+}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index d3c97a1d0ad2..40be4b16e486 100644
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
@@ -64,8 +68,11 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
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
@@ -73,8 +80,10 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	}
 
 	err = ceph_monc_do_statfs(monc, data_pool, &st);
-	if (err < 0)
+	if (err < 0) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 
 	/* fill in kstatfs */
 	buf->f_type = CEPH_SUPER_MAGIC;  /* ?? */
@@ -121,7 +130,8 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	/* fold the fs_cluster_id into the upper bits */
 	buf->f_fsid.val[1] = monc->fs_cluster_id;
 
-	doutc(fsc->client, "done\n");
+	boutc(fsc->client, "done\n");
+	ceph_blog_exit(&__ji);
 	return 0;
 }
 
@@ -129,19 +139,24 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
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
 
@@ -887,12 +902,18 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
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
@@ -922,6 +943,8 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 	ceph_mdsc_destroy(fsc);
 	destroy_workqueue(fsc->inode_wq);
 	destroy_workqueue(fsc->cap_wq);
+	ceph_blog_release_client_id(fsc->client);
+	ceph_blog_fsc_cleanup(fsc);
 
 	destroy_mount_options(fsc->mount_options);
 
@@ -1056,11 +1079,15 @@ static void __ceph_umount_begin(struct ceph_fs_client *fsc)
 void ceph_umount_begin(struct super_block *sb)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
+	struct ceph_journal_info __ji;
 
-	doutc(fsc->client, "starting forced umount\n");
+	ceph_blog_enter(fsc, &__ji);
+
+	boutc(fsc->client, "starting forced umount\n");
 
 	fsc->mount_state = CEPH_MOUNT_SHUTDOWN;
 	__ceph_umount_begin(fsc);
+	ceph_blog_exit(&__ji);
 }
 
 static const struct super_operations ceph_super_ops = {
@@ -1683,9 +1710,15 @@ int ceph_force_reconnect(struct super_block *sb)
 
 static int __init init_ceph(void)
 {
-	int ret = init_caches();
+	int ret;
+
+	ret = ceph_blog_init();
 	if (ret)
-		goto out;
+		pr_warn("BLOG initialization failed (%d); binary logging unavailable\n", ret);
+
+	ret = init_caches();
+	if (ret)
+		goto out_blog;
 
 	ceph_flock_init();
 	ret = register_filesystem(&ceph_fs_type);
@@ -1698,7 +1731,8 @@ static int __init init_ceph(void)
 
 out_caches:
 	destroy_caches();
-out:
+out_blog:
+	ceph_blog_cleanup();
 	return ret;
 }
 
@@ -1707,6 +1741,7 @@ static void __exit exit_ceph(void)
 	dout("exit_ceph\n");
 	unregister_filesystem(&ceph_fs_type);
 	destroy_caches();
+	ceph_blog_cleanup();
 }
 
 static int param_set_metrics(const char *val, const struct kernel_param *kp)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index e00df8000427..458fd63dd79f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -3,8 +3,11 @@
 #define _FS_CEPH_SUPER_H
 
 #include <linux/ceph/ceph_debug.h>
+#include <linux/ceph/ceph_blog.h>
 #include <linux/ceph/osd_client.h>
 
+#include "blog.h"
+
 #include <linux/unaligned.h>
 #include <linux/backing-dev.h>
 #include <linux/completion.h>
@@ -174,6 +177,9 @@ struct ceph_fs_client {
 	spinlock_t async_unlink_conflict_lock;
 
 #ifdef CONFIG_DEBUG_FS
+	bool blog_enabled;
+	struct mutex blog_mutex;
+	struct blog_module_context __rcu *blog_ctx;
 	struct dentry *debugfs_dentry_lru, *debugfs_caps;
 	struct dentry *debugfs_congestion_kb;
 	struct dentry *debugfs_bdi;
@@ -182,6 +188,7 @@ struct ceph_fs_client {
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
 	struct dentry *debugfs_reset_dir;
+	struct dentry *debugfs_blog;
 	struct dentry *debugfs_subvolume_metrics;
 #endif
 
diff --git a/include/linux/ceph/ceph_blog.h b/include/linux/ceph/ceph_blog.h
new file mode 100644
index 000000000000..82c64bc98972
--- /dev/null
+++ b/include/linux/ceph/ceph_blog.h
@@ -0,0 +1,292 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ceph integration with BLOG (Binary LOGging)
+ *
+ * Provides a shared per-call context (struct ceph_journal_info) used for
+ * the narrow MDS fill-trace window (mds_req in current->journal_info) and
+ * optional BLOG TLS binding via Ceph-private per-task storage / CPU cache.
+ */
+#ifndef CEPH_BLOG_H
+#define CEPH_BLOG_H
+
+#include <linux/sched/mm.h>
+#include <linux/gfp.h>
+#include <linux/jump_label.h>
+
+/* ---------- shared journal_info carrier ---------- */
+
+#define CEPH_JI_MAGIC	0xCE9B7081UL
+#define CEPH_JI_TAG	3UL
+#define CEPH_JI_TAG_MASK	3UL
+
+struct ceph_fs_client;
+struct ceph_mds_request;
+struct ceph_client;
+struct blog_module_context;
+struct blog_tls_ctx;
+
+/**
+ * struct ceph_journal_info - per-call context stashed in journal_info
+ * @magic: CEPH_JI_MAGIC, for safe type-checking when reading journal_info
+ * @saved_ji: previous value of current->journal_info (restored on exit)
+ * @fsc: filesystem client for this enter
+ * @blog_ctx: BLOG TLS context for binary logging, or NULL
+ * @blog_mod: module context ref held for @blog_ctx when this enter acquired
+ *            it (NULL when ctx was inherited from a nested parent)
+ * @mds_req: MDS request during ceph_fill_trace / readdir_prepopulate,
+ *           or NULL.  Read by xattr.c to avoid deadlocking RPCs and
+ *           to discover which capabilities were already fetched.
+ *
+ * Allocated on the caller's stack at every Ceph VFS entry point.
+ * ceph_blog_enter_req() installs it in current->journal_info for MDS
+ * fill-trace; plain ceph_blog_enter() binds BLOG without touching
+ * journal_info.  ceph_blog_exit() restores journal_info when installed.
+ */
+struct ceph_journal_info {
+	unsigned long		magic;
+	void			*saved_ji;
+	struct ceph_fs_client	*fsc;
+	struct blog_tls_ctx	*blog_ctx;
+	struct blog_module_context *blog_mod;
+	struct ceph_mds_request	*mds_req;
+};
+
+/**
+ * ceph_ji_from_current - safely retrieve ceph_journal_info from journal_info
+ *
+ * Ceph tags its journal_info pointer so foreign filesystem state can be
+ * rejected without dereferencing it.  Returns the decoded pointer if the
+ * tag and magic match, NULL otherwise.
+ */
+static inline struct ceph_journal_info *ceph_ji_from_current(void)
+{
+	void *journal_info = current->journal_info;
+	struct ceph_journal_info *ji;
+
+	if (((unsigned long)journal_info & CEPH_JI_TAG_MASK) != CEPH_JI_TAG)
+		return NULL;
+	ji = (void *)((unsigned long)journal_info & ~CEPH_JI_TAG_MASK);
+	if (!ji)
+		return NULL;
+	if (READ_ONCE(ji->magic) == CEPH_JI_MAGIC)
+		return ji;
+	return NULL;
+}
+
+static inline void *ceph_ji_encode(struct ceph_journal_info *ji)
+{
+	WARN_ON_ONCE((unsigned long)ji & CEPH_JI_TAG_MASK);
+	return (void *)((unsigned long)ji | CEPH_JI_TAG);
+}
+
+static inline bool ceph_ji_matches_fsc(const struct ceph_journal_info *ji,
+				       struct ceph_fs_client *fsc)
+{
+	return ji && ji->fsc == fsc;
+}
+
+/**
+ * ceph_current_mds_request - get this mount's in-flight MDS request
+ *
+ * Same-fsc helper for request introspection (e.g. getattr mask).
+ * Returns NULL outside fill-trace or when the tagged journal_info
+ * belongs to a different ceph_fs_client.
+ */
+static inline struct ceph_mds_request *
+ceph_current_mds_request(struct ceph_fs_client *fsc)
+{
+	struct ceph_journal_info *ji = ceph_ji_from_current();
+
+	return ceph_ji_matches_fsc(ji, fsc) ? ji->mds_req : NULL;
+}
+
+/**
+ * ceph_current_fill_trace_request - any in-flight Ceph fill-trace on this task
+ *
+ * Sync xattr recursion must stay task-scoped: a security hook on a
+ * second Ceph mount during handle_reply() -> ceph_fill_trace() still
+ * has to return -EBUSY.  Do not use the same-fsc helper for that guard.
+ */
+static inline struct ceph_mds_request *
+ceph_current_fill_trace_request(void)
+{
+	struct ceph_journal_info *ji = ceph_ji_from_current();
+
+	return ji ? ji->mds_req : NULL;
+}
+
+/* ---------- client ID mapping ---------- */
+
+struct ceph_blog_client_info {
+	char fsid[16];
+	u64 global_id;
+};
+
+#ifdef CONFIG_DEBUG_FS
+extern struct static_key_false ceph_blog_key;
+
+int  ceph_blog_init(void);
+void ceph_blog_cleanup(void);
+int  ceph_blog_fsc_init(struct ceph_fs_client *fsc);
+void ceph_blog_fsc_cleanup(struct ceph_fs_client *fsc);
+int  ceph_blog_set_enabled(struct ceph_fs_client *fsc, bool enabled);
+u32  ceph_blog_check_client_id(u32 id, const char *fsid, u64 global_id);
+u32  ceph_blog_get_client_id(struct ceph_client *client);
+void ceph_blog_release_client_id(struct ceph_client *client);
+const struct ceph_blog_client_info *ceph_blog_get_client_info(u32 id);
+int  ceph_blog_client_des_callback(char *buf, size_t size, u8 client_id);
+bool ceph_blog_is_enabled(struct ceph_fs_client *fsc);
+struct blog_tls_ctx *ceph_blog_acquire_ctx(struct ceph_fs_client *fsc,
+					   gfp_t gfp,
+					   struct blog_module_context **held_mod);
+void ceph_blog_module_put(struct blog_module_context *ctx);
+void ceph_blog_cpu_bind(struct blog_tls_ctx *ctx);
+void ceph_blog_cpu_unbind(struct blog_tls_ctx *ctx);
+void ceph_blog_cpu_clear(struct blog_tls_ctx *ctx);
+struct blog_tls_ctx *ceph_blog_get_cached_ctx(struct ceph_fs_client *fsc);
+#else
+/* CONFIG_DEBUG_FS=n: BLOG objects are not linked; stubs below. */
+
+static inline int ceph_blog_init(void) { return 0; }
+static inline void ceph_blog_cleanup(void) {}
+static inline int ceph_blog_fsc_init(struct ceph_fs_client *fsc) { return 0; }
+static inline void ceph_blog_fsc_cleanup(struct ceph_fs_client *fsc) {}
+static inline int ceph_blog_set_enabled(struct ceph_fs_client *fsc, bool enabled)
+{
+	return 0;
+}
+static inline u32 ceph_blog_check_client_id(u32 id, const char *fsid,
+					    u64 global_id)
+{
+	return 0;
+}
+static inline u32 ceph_blog_get_client_id(struct ceph_client *client)
+{
+	return 0;
+}
+static inline void ceph_blog_release_client_id(struct ceph_client *client) {}
+static inline const struct ceph_blog_client_info *
+ceph_blog_get_client_info(u32 id)
+{
+	return NULL;
+}
+static inline int ceph_blog_client_des_callback(char *buf, size_t size,
+						u8 client_id)
+{
+	return 0;
+}
+static inline bool ceph_blog_is_enabled(struct ceph_fs_client *fsc)
+{
+	return false;
+}
+static inline struct blog_tls_ctx *
+ceph_blog_acquire_ctx(struct ceph_fs_client *fsc, gfp_t gfp,
+		      struct blog_module_context **held_mod)
+{
+	if (held_mod)
+		*held_mod = NULL;
+	return NULL;
+}
+static inline void ceph_blog_module_put(struct blog_module_context *ctx) {}
+static inline void ceph_blog_cpu_bind(struct blog_tls_ctx *ctx) {}
+static inline void ceph_blog_cpu_unbind(struct blog_tls_ctx *ctx) {}
+static inline void ceph_blog_cpu_clear(struct blog_tls_ctx *ctx) {}
+static inline struct blog_tls_ctx *
+ceph_blog_get_cached_ctx(struct ceph_fs_client *fsc)
+{
+	return NULL;
+}
+#endif
+
+/* ---------- entry / exit helpers ---------- */
+
+/**
+ * ceph_blog_enter_req_gfp - bind optional BLOG ctx; install journal_info for MDS
+ * @gfp: GFP_NOFS for sleepable VFS paths; GFP_ATOMIC (or any non-blocking
+ *       combination) for callbacks that must not sleep.  Non-blocking
+ *       acquires only reuse an existing per-task context; first-touch
+ *       allocation is skipped and logging is a no-op for that enter.
+ *
+ * BLOG state lives in the per-task map and CPU cache.  Plain VFS enters
+ * never publish into current->journal_info.  Only enter_req (MDS
+ * fill-trace, which already runs under memalloc_nofs_save) installs the
+ * tagged carrier so xattr paths can see mds_req.
+ */
+static inline void ceph_blog_enter_req_gfp(struct ceph_fs_client *fsc,
+					   struct ceph_journal_info *ji,
+					   struct ceph_mds_request *req,
+					   gfp_t gfp)
+{
+	struct ceph_journal_info *parent = ceph_ji_from_current();
+
+	ji->magic    = CEPH_JI_MAGIC;
+	ji->saved_ji = current->journal_info;
+	ji->fsc      = fsc;
+	ji->mds_req  = req;
+	ji->blog_mod = NULL;
+	ji->blog_ctx = ceph_ji_matches_fsc(parent, fsc) ? parent->blog_ctx : NULL;
+
+	if (!ji->blog_ctx && ceph_blog_is_enabled(fsc))
+		ji->blog_ctx = ceph_blog_acquire_ctx(fsc, gfp, &ji->blog_mod);
+
+	if (ji->blog_ctx)
+		ceph_blog_cpu_bind(ji->blog_ctx);
+
+	/* MDS fill-trace only: keep journal_info off reclaimable VFS paths. */
+	if (req)
+		current->journal_info = ceph_ji_encode(ji);
+}
+
+static inline void ceph_blog_enter_req(struct ceph_fs_client *fsc,
+				       struct ceph_journal_info *ji,
+				       struct ceph_mds_request *req)
+{
+	ceph_blog_enter_req_gfp(fsc, ji, req, GFP_NOFS);
+}
+
+static inline void ceph_blog_enter_gfp(struct ceph_fs_client *fsc,
+				       struct ceph_journal_info *ji,
+				       gfp_t gfp)
+{
+	struct ceph_journal_info *parent = ceph_ji_from_current();
+	struct ceph_mds_request *req =
+		ceph_ji_matches_fsc(parent, fsc) ? parent->mds_req : NULL;
+
+	ceph_blog_enter_req_gfp(fsc, ji, req, gfp);
+}
+
+static inline void ceph_blog_enter(struct ceph_fs_client *fsc,
+				   struct ceph_journal_info *ji)
+{
+	ceph_blog_enter_gfp(fsc, ji, GFP_NOFS);
+}
+
+/**
+ * ceph_blog_exit - call at every Ceph VFS exit point
+ * @ji: the same struct passed to ceph_blog_enter()
+ */
+static inline void ceph_blog_exit(struct ceph_journal_info *ji)
+{
+	if (ji->blog_ctx)
+		ceph_blog_cpu_unbind(ji->blog_ctx);
+
+	if (ji->blog_mod) {
+		ceph_blog_module_put(ji->blog_mod);
+		ji->blog_mod = NULL;
+	}
+
+	if (current->journal_info == ceph_ji_encode(ji))
+		current->journal_info = ji->saved_ji;
+}
+
+/* ---------- debugfs ---------- */
+
+#ifdef CONFIG_DEBUG_FS
+int  ceph_blog_debugfs_init(struct ceph_fs_client *fsc);
+void ceph_blog_debugfs_cleanup(struct ceph_fs_client *fsc);
+#else
+static inline int  ceph_blog_debugfs_init(struct ceph_fs_client *fsc) { return 0; }
+static inline void ceph_blog_debugfs_cleanup(struct ceph_fs_client *fsc) {}
+#endif
+
+#endif /* CEPH_BLOG_H */
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index d800b30425bf..4d493a08faf5 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -135,6 +135,8 @@ struct ceph_client {
 	struct ceph_osd_client osdc;
 
 #ifdef CONFIG_DEBUG_FS
+	u32 blog_client_id;
+
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_monmap;
 	struct dentry *debugfs_osdmap;
-- 
2.34.1

