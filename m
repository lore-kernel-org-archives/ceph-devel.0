Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18BA3BBFAC
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348740; cv=none; b=o16m7Fj0SRvAYC5wSxjF4MgOO0Zbdf9UGrwQNT5L9eQuKbke9cPB24R4/gY/WPxGbyei07utrnXC+IV3pfnNZ66CuPtN33jhUaJPptbREkY9Icladah9Qk6gIiyiE6Nnn8xfYhX8q2QkoenSaLHJpMA9dvoCPFtTD3foUX4XLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348740; c=relaxed/simple;
	bh=PRvZXY/CQZirXkTXBee3qrhDHCVyMrAlYK41X138G50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gwAk6Y7de7IIeJwp8TSuyQLUkHmrHQJSQ4wbt3SpMXI2HSmcv9mygwzTIKWb9oNnWOnIIEpuBTfTOeSsclL3MRvOXpKH9zDFoY4B6vh65wZH/8d0UpM89RZoOTKPNlXJoagJ4ncP5kdF58t1bHkxQMCszSVh0XkBcy4H5ryAFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxU/SzvF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nTA/L6Jp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxU/SzvF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nTA/L6Jp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icID9Uqtwt93p8PAmfbXv0rRFkou4sCezJ8NK2mKpZ4=;
	b=OxU/SzvFI3H/7iAW5Vg3eihb5aBIhm1n75XJBQYtaIwZILKYoYrZxqKLMRP8sdiv5iLjel
	agIyV1WoBqcLoGJxw4ZbmfzNkjgCgN98XlcnJkoP1nDRyEMpb+Io3eYrHG7yL2bVyojLOj
	92vbOLh8asdTQqAUYJgu+kr1397qllc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-BZLYVz3eMhKPkblLWLVKTg-1; Mon, 06 Jul 2026 10:38:55 -0400
X-MC-Unique: BZLYVz3eMhKPkblLWLVKTg-1
X-Mimecast-MFC-AGG-ID: BZLYVz3eMhKPkblLWLVKTg_1783348734
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c12e5e49423so186724266b.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348734; x=1783953534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icID9Uqtwt93p8PAmfbXv0rRFkou4sCezJ8NK2mKpZ4=;
        b=nTA/L6Jp4lKOORD5rjhQL7or0GmmYIWEoT93WRBjdWYA9hDJmhQiARRVkFH1SeG6Cg
         RDutUPYoxeLCobeB/pZvi3eXOYzH7F9HZUokHcrhxYrHslhOSHnAmqcFA3kKl8U8S0Gc
         K1CJLTtWgCqq3CyaU5dvysS5LUWdLFR6pjYhExXxUxpELiWie5WbJU2wB2KO9wJTLQEQ
         uTYyGhBSAcqNmXOhmVeIgxY4sDkujpRrTUFN80lM/otWePxmuUgfo+qNC+8mzZ/KAdR8
         zFBu7JFoUKRffBuiuN9aCKmYbE9S/S5Wc/gWeR6qWr2sy1X2gIyqomMuvqFdm1WQznVF
         rtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348734; x=1783953534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=icID9Uqtwt93p8PAmfbXv0rRFkou4sCezJ8NK2mKpZ4=;
        b=TFl/khP/UspgqA09uxDeO6eXEEzCb3bEJr576fyCTGTqzJSZFqfyyYZhsl6tdckVOk
         OFSvCk/Yi9Wzm0By7tMTy/2mjIWcgDdyrCRKFDR6aUPGujX2lxj7tUcpgYdiVP9rkPdV
         t2/cEFLT6ku2BkMIKO4+XChHec1EsvyQsBil5cwtBdCrCXoV4bk0SbQKaFd4Yv4YqgyJ
         eYY952N6RmR4VMi/PDMqlLhL5kFIlVU76SeHPkArPc3iG/peDAHk/ynRDy+UJc0w4r7D
         jgi6EJwVLhz9AeFu1+bzw33NKm64nI0iv49C9Rq3SIKurgX64CnAmk9WjINRrWOvxDkL
         yFkg==
X-Gm-Message-State: AOJu0YyLsaxYFgpJa0K8ESEZQSqSrdAmg5wZYucRNx+4mJLIGKs7d/go
	01dwnRjG+NX1tVakkppNEJ/bt1k8Vpc06FDkGm68SY2PYMRPzYXPkIIbz8oedErFTxl1TigymgC
	AWlM++HK36GGv/zR5mB3g6O2VA7lfggHy02vFYJ2qJtFQb5SO9HlLt73qp/aqorh/ZS6KunRa/W
	dzHZTCU8P+mRBrBte3uH9XV2EYGBMV/DNlLZa/4Wo4/WyQteE0Xw==
X-Gm-Gg: AfdE7cmv9sHhyKQPU2K58r+VXlTVufUBrb7NVTTJbFYq8jdGUvKFLf2896IvF5ZfOPW
	FESArRZX82QlZkYDocgn1iThiU3lZShkCFS0z7bLqAfDSVQvz5/vfthiIXNrBGrqvJubuGWCVNj
	2Fr0IfZi3NZyJ7LsxlRH59BXQPXLvhou8d2GgO/cKyxaNwzgPG3dHCE7z7mZxwOUev+rI564OZT
	eiNrVTvI4nREIsN9DHZ5iqUIe9jQQC89/+Z07GY8EPbuXYqlf2k9t7iPl3favaB2DT2jT9p8nRz
	jM6HSnu1XwM8x/iQWS1Gv5YCWF/H62AJGwNXcFJ5HyuKGivjPM8oolyxFI2lSdaV1zJCST6JJ2q
	I9e3O33gsmI9N7u7QQUVZtt8yqXBuyptxD5dAzkLBT9H2
X-Received: by 2002:a17:906:c101:b0:c12:e178:9e68 with SMTP id a640c23a62f3a-c15a6799a68mr57601866b.19.1783348733490;
        Mon, 06 Jul 2026 07:38:53 -0700 (PDT)
X-Received: by 2002:a17:906:c101:b0:c12:e178:9e68 with SMTP id a640c23a62f3a-c15a6799a68mr57599066b.19.1783348732851;
        Mon, 06 Jul 2026 07:38:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:52 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 07/15] ceph: add Ceph BLOG scaffolding
Date: Mon,  6 Jul 2026 14:38:35 +0000
Message-Id: <20260706143843.1980879-8-amarkuze@redhat.com>
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

Wire BLOG into CephFS: ceph_blog.h (journal_info, enter/exit, logging
macros), blog_client.c (per-fsc context lifecycle, client-ID), super.h
(blog_enabled, blog_ctx, debugfs_blog), libceph.h (blog_client_id),
and Makefile (link all BLOG objects into ceph.ko).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/Makefile               |   3 +
 fs/ceph/blog_client.c          | 266 ++++++++++++++++++++++++++++++
 fs/ceph/super.h                |   5 +
 include/linux/ceph/ceph_blog.h | 284 +++++++++++++++++++++++++++++++++
 include/linux/ceph/libceph.h   |   2 +
 5 files changed, 560 insertions(+)
 create mode 100644 fs/ceph/blog_client.c
 create mode 100644 include/linux/ceph/ceph_blog.h

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index ebb29d11ac22..d1177badef00 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -10,6 +10,9 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 	mds_client.o mdsmap.o strings.o ceph_frag.o \
 	debugfs.o util.o metric.o subvolume_metrics.o
 
+ceph-y += blog_core.o blog_module.o blog_batch.o blog_pagefrag.o blog_des.o
+ceph-y += blog_client.o
+
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
 ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
diff --git a/fs/ceph/blog_client.c b/fs/ceph/blog_client.c
new file mode 100644
index 000000000000..be92b97d2903
--- /dev/null
+++ b/fs/ceph/blog_client.c
@@ -0,0 +1,266 @@
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
+#include <linux/ceph/libceph.h>
+#include <linux/ceph/ceph_blog.h>
+#include <linux/ceph/blog.h>
+
+#include "super.h"
+
+/* Global client mapping state */
+static struct {
+	struct ceph_blog_client_info client_map[CEPH_BLOG_MAX_CLIENTS];
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
+/**
+ * ceph_blog_init - Initialize Ceph BLOG integration
+ *
+ * Initializes the shared client ID mapping state used by per-superblock
+ * BLOG instances.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int ceph_blog_init(void)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+	if (ceph_blog_state.initialized)
+		return 0;
+
+	/* Initialize client mapping state */
+	memset(ceph_blog_state.client_map, 0, sizeof(ceph_blog_state.client_map));
+	ceph_blog_state.next_client_id = 1;
+	ceph_blog_state.initialized = true;
+
+	pr_debug("ceph: BLOG client mapping initialized\n");
+	return 0;
+}
+
+/**
+ * ceph_blog_cleanup - Clean up Ceph BLOG integration
+ *
+ * Cleans up Ceph's module-specific BLOG context and client mappings.
+ */
+void ceph_blog_cleanup(void)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+	if (!ceph_blog_state.initialized)
+		return;
+
+	/* Clean up client mapping state */
+	spin_lock(&ceph_blog_state.lock);
+	memset(ceph_blog_state.client_map, 0, sizeof(ceph_blog_state.client_map));
+	ceph_blog_state.next_client_id = 1;
+	ceph_blog_state.initialized = false;
+	spin_unlock(&ceph_blog_state.lock);
+
+	pr_debug("ceph: BLOG client mapping cleaned up\n");
+}
+
+int ceph_blog_fsc_init(struct ceph_fs_client *fsc)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+	if (!fsc)
+		return -EINVAL;
+	if (fsc->blog_ctx)
+		return 0;
+
+	fsc->blog_ctx = blog_module_init("ceph");
+	if (!fsc->blog_ctx) {
+		pr_err("ceph: Failed to initialize BLOG context for fs client\n");
+		return -ENOMEM;
+	}
+
+	WRITE_ONCE(fsc->blog_enabled, false);
+	return 0;
+}
+
+void ceph_blog_fsc_cleanup(struct ceph_fs_client *fsc)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_FS) || !fsc)
+		return;
+
+	WRITE_ONCE(fsc->blog_enabled, false);
+	if (fsc->blog_ctx) {
+		blog_module_cleanup(fsc->blog_ctx);
+		fsc->blog_ctx = NULL;
+	}
+}
+
+bool ceph_blog_is_enabled(struct ceph_fs_client *fsc)
+{
+	return fsc && READ_ONCE(fsc->blog_enabled) &&
+	       fsc->blog_ctx && fsc->blog_ctx->logger;
+}
+
+struct blog_tls_ctx *ceph_blog_acquire_ctx(struct ceph_fs_client *fsc)
+{
+	if (!ceph_blog_is_enabled(fsc))
+		return NULL;
+
+	return blog_get_ctx_ctx(fsc->blog_ctx);
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
+ *
+ * Return: Client ID for this fsid/global_id pair
+ */
+u32 ceph_blog_check_client_id(u32 id, const char *fsid, u64 global_id)
+{
+	u32 found_id = 0;
+	struct ceph_blog_client_info *entry;
+
+	if (unlikely(!ceph_blog_state.initialized)) {
+		WARN_ON_ONCE(1);  /* Should never happen - init_ceph() initializes BLOG */
+		return 0;  /* Drop the log entry */
+	}
+
+	spin_lock(&ceph_blog_state.lock);
+
+	/* Reuse caller-provided hint when it still matches */
+	if (id != 0 && id < CEPH_BLOG_MAX_CLIENTS) {
+		entry = &ceph_blog_state.client_map[id];
+		if (ceph_blog_ids_match(entry, fsid, global_id)) {
+			found_id = id;
+			goto out;
+		}
+	}
+
+	/* Search for an existing entry with matching identity */
+	for (id = 1; id < CEPH_BLOG_MAX_CLIENTS; id++) {
+		entry = &ceph_blog_state.client_map[id];
+		if (ceph_blog_ids_match(entry, fsid, global_id)) {
+			found_id = id;
+			goto out;
+		}
+	}
+
+	/* Assign new identifier; refuse on overflow rather than aliasing */
+	if (ceph_blog_state.next_client_id >= CEPH_BLOG_MAX_CLIENTS - 1) {
+		pr_warn_once("ceph: BLOG client ID space exhausted\n");
+		found_id = 0;
+		goto out;
+	}
+
+	found_id = ceph_blog_state.next_client_id++;
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
+ * race: a torn read may see a partially-updated fsid or global_id,
+ * which only affects the cosmetic prefix in deserialized output.
+ *
+ * Return: Client information for this ID, or NULL if invalid
+ */
+const struct ceph_blog_client_info *ceph_blog_get_client_info(u32 id)
+{
+	if (!READ_ONCE(ceph_blog_state.initialized) ||
+	    id == 0 || id >= CEPH_BLOG_MAX_CLIENTS)
+		return NULL;
+	return &ceph_blog_state.client_map[id];
+}
+
+/**
+ * ceph_blog_client_des_callback - Deserialization callback for Ceph client info
+ * @buf: Output buffer
+ * @size: Buffer size
+ * @client_id: Client ID to deserialize
+ *
+ * This is the callback that BLOG will use to deserialize client information.
+ *
+ * Return: Number of bytes written to buffer
+ */
+int ceph_blog_client_des_callback(char *buf, size_t size, u8 client_id)
+{
+	const struct ceph_blog_client_info *info;
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
+	/* Use %pU to format fsid, matching boutc and other Ceph client logging */
+	return snprintf(buf, size, "[%pU %llu] ",
+			info->fsid, info->global_id);
+}
+
+/**
+ * ceph_blog_get_client_id - Get or allocate client ID for a Ceph client
+ * @client: Ceph client structure
+ *
+ * Return: Client ID for this client
+ */
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
+	if (READ_ONCE(client->blog_client_id) != id)
+		WRITE_ONCE(client->blog_client_id, id);
+
+	return id;
+}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..ecb72c482d0e 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -3,6 +3,7 @@
 #define _FS_CEPH_SUPER_H
 
 #include <linux/ceph/ceph_debug.h>
+#include <linux/ceph/ceph_blog.h>
 #include <linux/ceph/osd_client.h>
 
 #include <linux/unaligned.h>
@@ -154,6 +155,7 @@ struct ceph_fs_client {
 	int mount_state;
 
 	bool blocklisted;
+	bool blog_enabled;
 
 	bool have_copy_from2;
 
@@ -171,6 +173,8 @@ struct ceph_fs_client {
 	DECLARE_HASHTABLE(async_unlink_conflict, CEPH_ASYNC_CREATE_CONFLICT_BITS);
 	spinlock_t async_unlink_conflict_lock;
 
+	struct blog_module_context *blog_ctx;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dentry_lru, *debugfs_caps;
 	struct dentry *debugfs_congestion_kb;
@@ -180,6 +184,7 @@ struct ceph_fs_client {
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
 	struct dentry *debugfs_reset_dir;
+	struct dentry *debugfs_blog;
 	struct dentry *debugfs_subvolume_metrics;
 #endif
 
diff --git a/include/linux/ceph/ceph_blog.h b/include/linux/ceph/ceph_blog.h
new file mode 100644
index 000000000000..29df4f662a2f
--- /dev/null
+++ b/include/linux/ceph/ceph_blog.h
@@ -0,0 +1,284 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ceph integration with BLOG (Binary LOGging)
+ *
+ * Provides a shared per-call context (struct ceph_journal_info) cached
+ * in current->journal_info that carries both the BLOG TLS context and
+ * the MDS request pointer used by the xattr / security-label paths.
+ */
+#ifndef CEPH_BLOG_H
+#define CEPH_BLOG_H
+
+#include <linux/ceph/blog.h>
+#include <linux/ceph/blog_module.h>
+#include <linux/ceph/libceph.h>
+
+/* ---------- shared journal_info carrier ---------- */
+
+#define CEPH_JI_MAGIC	0xCE9B7081UL
+
+struct ceph_fs_client;
+
+/**
+ * struct ceph_journal_info - per-call context stashed in journal_info
+ * @magic: CEPH_JI_MAGIC, for safe type-checking when reading journal_info
+ * @saved_ji: previous value of current->journal_info (restored on exit)
+ * @blog_ctx: BLOG TLS context for binary logging, or NULL
+ * @mds_req: MDS request during ceph_fill_trace / readdir_prepopulate,
+ *           or NULL.  Read by xattr.c to avoid deadlocking RPCs and
+ *           to discover which capabilities were already fetched.
+ *
+ * Allocated on the caller's stack at every Ceph VFS entry point.
+ * ceph_blog_enter() installs it in current->journal_info;
+ * ceph_blog_exit() restores the previous value.
+ */
+struct ceph_journal_info {
+	unsigned long		magic;
+	void			*saved_ji;
+	struct ceph_fs_client	*fsc;
+	struct blog_tls_ctx	*blog_ctx;
+	struct ceph_mds_request	*mds_req;
+};
+
+/**
+ * ceph_ji_from_current - safely retrieve ceph_journal_info from journal_info
+ *
+ * Returns the ceph_journal_info pointer if journal_info currently holds
+ * one (magic matches), NULL otherwise.
+ */
+static inline struct ceph_journal_info *ceph_ji_from_current(void)
+{
+	struct ceph_journal_info *ji = current->journal_info;
+
+	if (ji && READ_ONCE(ji->magic) == CEPH_JI_MAGIC)
+		return ji;
+	return NULL;
+}
+
+static inline bool ceph_ji_matches_fsc(const struct ceph_journal_info *ji,
+				       struct ceph_fs_client *fsc)
+{
+	return ji && ji->fsc == fsc;
+}
+
+/**
+ * ceph_current_mds_request - get the in-flight MDS request, if any
+ *
+ * Used by xattr.c to detect whether we are inside ceph_fill_trace()
+ * and to inspect the request's capability mask.  Returns NULL when
+ * called outside that window.
+ */
+static inline struct ceph_mds_request *
+ceph_current_mds_request(struct ceph_fs_client *fsc)
+{
+	struct ceph_journal_info *ji = ceph_ji_from_current();
+
+	return ceph_ji_matches_fsc(ji, fsc) ? ji->mds_req : NULL;
+}
+
+/* ---------- client ID mapping ---------- */
+
+struct ceph_blog_client_info {
+	char fsid[16];
+	u64 global_id;
+};
+
+#define CEPH_BLOG_MAX_CLIENTS 256
+
+struct ceph_client;
+struct ceph_fs_client;
+
+#if IS_ENABLED(CONFIG_CEPH_FS)
+
+int  ceph_blog_init(void);
+void ceph_blog_cleanup(void);
+int  ceph_blog_fsc_init(struct ceph_fs_client *fsc);
+void ceph_blog_fsc_cleanup(struct ceph_fs_client *fsc);
+u32  ceph_blog_check_client_id(u32 id, const char *fsid, u64 global_id);
+u32  ceph_blog_get_client_id(struct ceph_client *client);
+const struct ceph_blog_client_info *ceph_blog_get_client_info(u32 id);
+int  ceph_blog_client_des_callback(char *buf, size_t size, u8 client_id);
+bool ceph_blog_is_enabled(struct ceph_fs_client *fsc);
+struct blog_tls_ctx *ceph_blog_acquire_ctx(struct ceph_fs_client *fsc);
+
+/* ---------- entry / exit helpers ---------- */
+
+/**
+ * ceph_blog_enter - call at every Ceph VFS entry point
+ * @fsc: CephFS client that owns this VFS operation
+ * @ji: caller-allocated struct ceph_journal_info (typically on the stack)
+ *
+ * Saves the current journal_info, inherits any active Ceph request
+ * state from the parent frame, and installs @ji as journal_info.
+ * When BLOG tracing is enabled, the outermost Ceph entry acquires and
+ * caches the BLOG context for nested bout()/boutc() callsites.
+ */
+static inline void ceph_blog_enter(struct ceph_fs_client *fsc,
+				   struct ceph_journal_info *ji)
+{
+	struct ceph_journal_info *parent = ceph_ji_from_current();
+
+	ji->magic    = CEPH_JI_MAGIC;
+	ji->saved_ji = current->journal_info;
+	ji->fsc      = fsc;
+	ji->mds_req  = ceph_ji_matches_fsc(parent, fsc) ? parent->mds_req : NULL;
+	ji->blog_ctx = ceph_ji_matches_fsc(parent, fsc) ? parent->blog_ctx : NULL;
+
+	if (!ji->blog_ctx && ceph_blog_is_enabled(fsc))
+		ji->blog_ctx = ceph_blog_acquire_ctx(fsc);
+
+	current->journal_info = ji;
+}
+
+/**
+ * ceph_blog_exit - call at every Ceph VFS exit point
+ * @ji: the same struct passed to ceph_blog_enter()
+ */
+static inline void ceph_blog_exit(struct ceph_journal_info *ji)
+{
+	current->journal_info = ji->saved_ji;
+}
+
+/* ---------- cached-context accessor for boutc hot path ---------- */
+
+static inline struct blog_tls_ctx *ceph_blog_get_cached_ctx(void)
+{
+	struct ceph_journal_info *ji = ceph_ji_from_current();
+
+	if (!ji || !ceph_blog_is_enabled(ji->fsc))
+		return NULL;
+	return ji->blog_ctx;
+}
+
+/* ---------- logging macros ---------- */
+
+#define CEPH_BLOG_LOG(fmt, ...) \
+	do { \
+		static struct blog_source_id_cache __source_cache; \
+		size_t __size = blog_cnt(__VA_ARGS__); \
+		struct blog_tls_ctx *__ctx; \
+		struct blog_logger *__logger; \
+		void *___buffer; \
+		u32 __sid; \
+		__ctx = ceph_blog_get_cached_ctx(); \
+		if (unlikely(!__ctx)) \
+			break; \
+		__logger = __ctx->logger; \
+		if (unlikely(!__logger)) \
+			break; \
+		__sid = blog_get_source_id_cached(__logger, &__source_cache, \
+						  kbasename(__FILE__), __func__, \
+						  __LINE__, fmt); \
+		if (unlikely(__sid == 0)) { \
+			WRITE_ONCE(__source_cache.logger, NULL); \
+			WRITE_ONCE(__source_cache.id, 0); \
+			break; \
+		} \
+		___buffer = blog_log_with_ctx(__logger, __ctx, \
+					      __sid, 0, __size); \
+		if (likely(___buffer)) { \
+			void *___tmp = ___buffer; \
+			if (__size > 0) { \
+				blog_ser(___buffer, ##__VA_ARGS__); \
+			} \
+			blog_log_commit_with_ctx(__logger, __ctx, \
+						 ___buffer - ___tmp); \
+		} \
+	} while (0)
+
+#define CEPH_BLOG_LOG_CLIENT(client, fmt, ...) \
+	do { \
+		static struct blog_source_id_cache __source_cache; \
+		size_t __size = blog_cnt(__VA_ARGS__); \
+		struct blog_tls_ctx *__ctx; \
+		struct blog_logger *__logger; \
+		void *___buffer; \
+		u32 __client_id; \
+		u32 __sid; \
+		__ctx = ceph_blog_get_cached_ctx(); \
+		if (unlikely(!__ctx)) \
+			break; \
+		__logger = __ctx->logger; \
+		if (unlikely(!__logger)) \
+			break; \
+		__sid = blog_get_source_id_cached(__logger, &__source_cache, \
+						  kbasename(__FILE__), __func__, \
+						  __LINE__, fmt); \
+		if (unlikely(__sid == 0)) { \
+			WRITE_ONCE(__source_cache.logger, NULL); \
+			WRITE_ONCE(__source_cache.id, 0); \
+			break; \
+		} \
+		__client_id = ceph_blog_get_client_id(client); \
+		___buffer = blog_log_with_ctx(__logger, __ctx, \
+					      __sid, __client_id, __size); \
+		if (likely(___buffer)) { \
+			void *___tmp = ___buffer; \
+			if (__size > 0) { \
+				blog_ser(___buffer, ##__VA_ARGS__); \
+			} \
+			blog_log_commit_with_ctx(__logger, __ctx, \
+						 ___buffer - ___tmp); \
+		} \
+	} while (0)
+
+#else /* !CONFIG_CEPH_FS */
+
+#define CEPH_BLOG_LOG(fmt, ...)				do {} while (0)
+#define CEPH_BLOG_LOG_CLIENT(client, fmt, ...)		do {} while (0)
+
+static inline int  ceph_blog_init(void) { return 0; }
+static inline void ceph_blog_cleanup(void) { }
+static inline int  ceph_blog_fsc_init(struct ceph_fs_client *fsc) { return 0; }
+static inline void ceph_blog_fsc_cleanup(struct ceph_fs_client *fsc) {}
+static inline u32  ceph_blog_get_client_id(struct ceph_client *c) { return 0; }
+static inline u32  ceph_blog_check_client_id(u32 id, const char *fsid,
+					     u64 global_id) { return 0; }
+static inline const struct ceph_blog_client_info *
+ceph_blog_get_client_info(u32 id) { return NULL; }
+static inline int  ceph_blog_client_des_callback(char *buf, size_t size,
+						 u8 client_id) { return 0; }
+static inline bool ceph_blog_is_enabled(struct ceph_fs_client *fsc) { return false; }
+static inline struct blog_tls_ctx *
+ceph_blog_acquire_ctx(struct ceph_fs_client *fsc) { return NULL; }
+
+/*
+ * When BLOG is disabled, ceph_blog_enter/exit still install the
+ * ceph_journal_info so that the mds_req path works unconditionally.
+ */
+static inline void ceph_blog_enter(struct ceph_fs_client *fsc,
+				   struct ceph_journal_info *ji)
+{
+	struct ceph_journal_info *parent = ceph_ji_from_current();
+
+	ji->magic    = CEPH_JI_MAGIC;
+	ji->saved_ji = current->journal_info;
+	ji->fsc      = fsc;
+	ji->mds_req  = ceph_ji_matches_fsc(parent, fsc) ? parent->mds_req : NULL;
+	ji->blog_ctx = NULL;
+	current->journal_info = ji;
+}
+
+static inline void ceph_blog_exit(struct ceph_journal_info *ji)
+{
+	current->journal_info = ji->saved_ji;
+}
+
+static inline struct blog_tls_ctx *ceph_blog_get_cached_ctx(void)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_CEPH_FS */
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
index 63e0e2aa1ce9..f853836be298 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -133,6 +133,8 @@ struct ceph_client {
 	struct ceph_mon_client monc;
 	struct ceph_osd_client osdc;
 
+	u32 blog_client_id;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_monmap;
-- 
2.34.1

