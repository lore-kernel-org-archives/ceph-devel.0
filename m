Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849441C2FD
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708420; cv=none; b=hedV3rmXoDmsQ/6HzkzzY9aJIL4y4wcXWDAkKAZ0y1fHjP0s1EEGovpWJcfgZq876XmPIQQVepR+Uh5VXf7h8l4l504hZM6cP6Y9ZQZ2X2KZJRWATrtOwFDLImYWHidWRFJwXAbvcL5EUBAow7M0sifyiqZ56DgJcAGfLYbwvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708420; c=relaxed/simple;
	bh=PRvZXY/CQZirXkTXBee3qrhDHCVyMrAlYK41X138G50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ri8Hbv1CblgBph028ZSin7XPerMp8qr/hjcjNPeAaOj8GSfW1PTxzgBYnWiQjSZs8+ggIknzbQ7Gl73y67CWNJ/Hf8ouIXvrLmoiQmzwr9VpE8W7JWVp86J379utoOjtSMOd2W8oODaZEn1zuuwqB6CAOy0pUYNSRlUwaFVNSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfkO9RPt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXp344+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfkO9RPt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXp344+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icID9Uqtwt93p8PAmfbXv0rRFkou4sCezJ8NK2mKpZ4=;
	b=QfkO9RPtQ8TnqHBzpXI1gMPhGVpU9OuzdXJghcp+5+74eRjbGGc3RPH+u+qcCaCd0sMwKV
	wBR6nqeVmf/r16fZyoCqbuPJQbQf3wbd3lRj8wc/yCN2SwNd9DT+EpA51Os2Upx/N1MX9N
	IOb6nclC1rbvmBCgwt5J9MkQF4MU+jE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-JYCaegn9N5-vKrU8h_AoWA-1; Wed, 17 Jun 2026 11:00:09 -0400
X-MC-Unique: JYCaegn9N5-vKrU8h_AoWA-1
X-Mimecast-MFC-AGG-ID: JYCaegn9N5-vKrU8h_AoWA_1781708409
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6fa8bba1dso11055240a34.2
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708409; x=1782313209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icID9Uqtwt93p8PAmfbXv0rRFkou4sCezJ8NK2mKpZ4=;
        b=PXp344+PEAXZ5cXfmoq9vkSAZJ6hsTUSEFtDVu4Z0V4AvV3IT7TMSMGakmLE/bSeP4
         ErxLw8+jiT1l0W8VWU8wXFBfxsybJ6XbJ0ua7kO8Q90KgZJ51KHqqdy1/cUS5+6Y2CV0
         B1In0Dx5IncbwbR/6x3C9e5pF4VKXm3xD6PQyVciBPTJrwF2Yg+aWUtlxrQHwVHp5070
         vo+2njytfVBjNOIPc/121WfLtBzePg8jdFMq/Qylw0rGkE0DrrvB5GaeOemLVxtYLXhI
         M6A+hU9P2gdYZHBBE9xBGJZ0j7q/JTM+FBNgMBvDluFkqvk2ZpysPy7lFVXxpaYB0bUG
         usrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708409; x=1782313209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icID9Uqtwt93p8PAmfbXv0rRFkou4sCezJ8NK2mKpZ4=;
        b=bPMDkA8Z2sZ9y5rDfVme9Qas1UEo0F0SYtXx89S5qMEfyawtdNQQP8ezVcDioiI8rt
         RKu1juYs9jKBxaXQ2NyQPKqeMkHoKgWCwmqQODsT5W+1y3HXzR+gL1z2C4E1gw5uiqig
         YAP+cjnWxAP9YQ9CW6Nv6AAR9BHkfoUYDMxP5P1Qn8miqxMidFCZPhHNeIhrcfo5m+90
         1u7rmldcWtCX+eaPW1zAYMatfk6ZY0RsSoITBVnVXL/5DPfyke2tlgwvaapVwvKdvbWE
         Rw+enHuXthyRdcw1mh3MOd/Tkp+bsOoe4SGq2bBUiBC4vgqf8ZX0xjK1lzTuBwyd2eAa
         IKwA==
X-Gm-Message-State: AOJu0Yz5SLQDEjMlZH8d+ZRoXcSf1jKG9CcshpPdJ7bthzMMHGsxmB5O
	sxnX97PovoLhpvq27XJRNGZANx1D19oH6ttys7rSHmT1cL00HFcd+6JVIz09kITq49yhk1xrv3s
	DeYQTT/IEwyqNJneyDgza9ICb+S6knILNQ96aoWS3ibgBjVFxzNJeeO2PUAoj+3mG6hMPONKKau
	euT9r+Z7XtCQ6x4geyYvK69m/dChd04OErYYUoxsefDTAap8NTUQ==
X-Gm-Gg: Acq92OE3GzBdvZfFTzrpx2MFxWdSRWci+hDb23h0GuMleJ9cMul4IA5CJ1oe6pWgKlZ
	s0deM8UYLDCvYefQ+QaS9ihytpS3lezKIHaOoC/lSP6K/whZI3qoIaGbQxFa6F7n5wbYj7lTkQN
	myPhSqpDUKjGfho+rGIi6zo+VJ1rWV8EOw1HKxuBH8COG5q6GWXK/DQZ0pVW/fkUcmtssdnefd3
	mK6P7L/YUNLvLHKgvs9K/1+18f62+LOdMjuWCxaL0wwpnAjEqeqpP8EqK20E2vA9F5PzbXwP7Cd
	54MpKf7ICXPYwm8Pb3SXB0ZtM5xDu81FgAz59Fy/YwttL32VNS5RnWUIt6bwOxXqa0qSqw+qix9
	lMUBk/uFN8OH90YmUaUZNO6/B7eByua6bOm/zgIA8ywJ7
X-Received: by 2002:a05:6830:3105:b0:7e6:e114:899b with SMTP id 46e09a7af769-7e90b40a173mr3780189a34.21.1781708408380;
        Wed, 17 Jun 2026 08:00:08 -0700 (PDT)
X-Received: by 2002:a05:6830:3105:b0:7e6:e114:899b with SMTP id 46e09a7af769-7e90b40a173mr3780141a34.21.1781708407603;
        Wed, 17 Jun 2026 08:00:07 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:07 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 07/15] ceph: add Ceph BLOG scaffolding
Date: Wed, 17 Jun 2026 14:59:37 +0000
Message-Id: <20260617145945.1912736-8-amarkuze@redhat.com>
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

