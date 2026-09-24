Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588A4A5EA7
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263864; cv=none; b=Cl9yW4fseMEuHDGGSGv8bQK0Gdh0u8xYDqkhOGEVzy7/iTPXP3N60OlfPMUmEaWSltv/vkUtv5q/pAesaBNcKRjT2obyBydN/eDyRNQxj+Mh1C8pVgzmrichtSjqXx9dFl6CoczsDiJXFYPqgUOPPoUfcG/3cCBD7kEfsmEn+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263864; c=relaxed/simple;
	bh=TPluu+gMNl/X49ImtSeBB0gmoqAobBSWOyTihP7LEoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GltwVA4Tvt0FupTI5RdBX11AZZd+A33VNmE3ojrA9Vfg4oQAFS62nC+WN28RV9Ex/4B3x8Pz2kZ6FlivDMw0RkO0Yaka1zAW5i4ukrTRjliVZuUcfuFUmHz5AbZLsS74MQLITp8l98Bt/Xp7SzgTPWErxwmFnwjWB3Lru1T71MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nz9IYSMq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qDC46XtA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz9IYSMq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qDC46XtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5R1jYllZ8ZmtQtqDQN4pCmw0ibgldwFqJ4BaGYJO0Q=;
	b=Nz9IYSMquJjCn8ELn9dv+kP7OJItpq7nJWjMxLSoz3YE9OsWulWYNuS2k/UYpicS+awThp
	9NU4klj+zvme3j7Yc1LQCFUlx2cUus+4mCHrNdKGVp6eTL/ioYnEakOTQfZYlNEdy7UCDf
	VhfVMs939DDzTL/Kz3vDvrZj9MwEH90=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-07ItJvmWOw2en6L4wk09qA-1; Thu, 24 Sep 2026 11:31:00 -0400
X-MC-Unique: 07ItJvmWOw2en6L4wk09qA-1
X-Mimecast-MFC-AGG-ID: 07ItJvmWOw2en6L4wk09qA_1790263859
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a91d818528so2639514a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263859; x=1790868659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5R1jYllZ8ZmtQtqDQN4pCmw0ibgldwFqJ4BaGYJO0Q=;
        b=qDC46XtAwGLSUkrYylsMTTPGcawpHGGMVgwZDVh2vHEpV07TI/rDm1roVK2XYyAMFA
         kGYzonkerEHROmulaT6nyi8IktpzB45jAxiw59qxKs1QI6sIzbo421Afa4xMBXeILQyc
         m3OvAmvLvDJPdY0P0kpISV2qHwLTRxBWhbyB/waFG0S/RKDBZA4DvJvZ+lKWWV4ro0Dz
         ZszC8IDKP4DfUolSr5nCo/UqbGkIy0P/jNG1QHJcFanBLIPv9+/izEUMxquT5FmCyrKX
         GghkiRm+tXwg+E5quZE8gaICvPB0+ulh+vb7bWD5epEf2ginz3e2YgHEmvcoMPoAv/xJ
         EfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263859; x=1790868659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5R1jYllZ8ZmtQtqDQN4pCmw0ibgldwFqJ4BaGYJO0Q=;
        b=jwsAw/VjZOs+7e48Sav7060DNJ/vZmaHUYuM1r5SnROY+1ZU3otFoy7r39dlFAzNVn
         Qy+BUVQaOxszPCCfFJCgLwoTpPO5XpN5T9CJS+9t8rQNDWmsaN7VIpdIExtrlosBWZPg
         SET/EUgT44S9fIZndZXjWDmFmKxvP7kKtxVESitpVHTp1VgbaDzDrSC+6AUaopXkt6c9
         FQFCq/9Ft2qbm1t+1NQ37a22C6wLYtJxF97blb1kAqdDQzXbNmTmMW/c0Ya/8LRlrCZY
         mI//ePXgmLa51dSmRWVh+ZGWoxlGAaG/ils1bkH6wb0GURRRPehCAdbM9RRXsFOk55Wr
         dqOg==
X-Gm-Message-State: AFuF++mTytkG6hWP9MRtADyJmrBPyTpobOzKc1Qdb+jNk4tmFHm4u5WS
	3BSDANrpd0wtss4i4MJZd5ZzbNttOVQ+2IIY4F284MDPqJQhEnk2qf7VudyaXrddf5Bk6BsrHJi
	LGO03wqlflRoJi6gyYKGOrI6YPecFLD5HO5T3cuGdDfNhvtsoyh4c/QNj/lPzRz0eHYVl0zfU4m
	1i0Y/bfkn0wJkbNlrae/AVKArIGy0PqYsf6kq/12QHF90u6Qwjbw==
X-Gm-Gg: AYBFou38uTEz+NIf/cRwUCkL1L2YZCxpUMD5wS3Q/KWIkKEnUxRxClFwm393FMPwRFD
	7GUHfjDYz03co3+NxyxwHNFV7eIAVL0fgddojlF+yjhe+7oA3XOQsV8ZHeQCTUOgVEavC3eOMDT
	7EzXEnnEGrRKCOKBJCvrxkl/qY8ARlbz8isT0mLd7Kx8tl8abTttr+i5qclZfKEBMUJuJw7R6M5
	SuepuYEhXO9AC8s6SsOJ0qQAxbbf3FqYqvCKf1Q5EEUx7XZbJdqb3gVryDhTJKn9goCZ7NG38P0
	S8pEQd4k7UCyPaVQDrE/FOJycsfmXI6x97WojTGUu1ANMIsR28jizMEqO2itOUQiDaMQMT3up2a
	0augRqo5Dbld3g9BIreQLhmUlBmUHGuNmZp5coA+y3uWvRSxIcg3Iny+9JR7+fbUSOJh64jjs8A
	yqlVm2fxbIvwpWQQ==
X-Received: by 2002:a05:6402:3552:b0:6aa:82f:8093 with SMTP id 4fb4d7f45d1cf-6aac90dc803mr2665570a12.37.1790263858802;
        Thu, 24 Sep 2026 08:30:58 -0700 (PDT)
X-Received: by 2002:a05:6402:3552:b0:6aa:82f:8093 with SMTP id 4fb4d7f45d1cf-6aac90dc803mr2665540a12.37.1790263858183;
        Thu, 24 Sep 2026 08:30:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 08/14] ceph: add boutc wrappers for BLOG
Date: Thu, 24 Sep 2026 15:30:38 +0000
Message-Id: <20260924153045.994784-9-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924153045.994784-1-amarkuze@redhat.com>
References: <20260924153045.994784-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add boutc()/boutc_bounded()/boutc_formats() macros to ceph_debug.h as
drop-in replacements for doutc().  When BLOG is enabled they serialize
to binary; when disabled they fall back to doutc().

Resolve the optional binary context before choosing the backend.
Expand the doutc fallback only once per call site to avoid duplicate
dynamic-debug metadata and excessive VFS stack frames.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Assisted-by: LLM
---
 include/linux/ceph/ceph_debug.h | 81 ++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index 5f904591fa5f..e055091d5c3c 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -5,28 +5,22 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/string.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_CEPH_LIB_PRETTYDEBUG
 
-/*
- * wrap pr_debug to include a filename:lineno prefix on each line.
- * this incurs some overhead (kernel size and execution time) due to
- * the extra function call at each call site.
- */
-
 # if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
 #  define dout(fmt, ...)						\
 	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
 		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
 #  define doutc(client, fmt, ...)					\
-	pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,			\
+	pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,		\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
 		 kbasename(__FILE__), __LINE__,				\
 		 &client->fsid, client->monc.auth->global_id,		\
 		 ##__VA_ARGS__)
 # else
-/* faux printk call just to see any compiler warnings. */
 #  define dout(fmt, ...)					\
 		no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
 #  define doutc(client, fmt, ...)				\
@@ -38,16 +32,79 @@
 
 #else
 
-/*
- * or, just wrap pr_debug
- */
 # define dout(fmt, ...)	pr_debug(" " fmt, ##__VA_ARGS__)
 # define doutc(client, fmt, ...)					\
-	pr_debug(" [%pU %llu] %s: " fmt, &client->fsid,			\
+	pr_debug(" [%pU %llu] %s: " fmt, &client->fsid,		\
 		 client->monc.auth->global_id, __func__, ##__VA_ARGS__)
 
 #endif
 
+/*
+ * boutc* -- binary-logging variants of doutc*.
+ *
+ * When Ceph BLOG tracing has been explicitly enabled and a BLOG context
+ * has been bound for the current task (via ceph_blog_enter()),
+ * these route through the BLOG serialization path. Otherwise they fall
+ * back to the traditional text-based doutc macros so that existing
+ * debug semantics remain unchanged.
+ *
+ * Must only be used from fs/ceph/ where client->private is a
+ * ceph_fs_client *.  Do not call from net/ceph or RBD; ->private is not
+ * an fsc there (ceph_blog_key stays false, but the cast is still wrong).
+ */
+#define __ceph_blog_args(...) __VA_ARGS__
+#if IS_ENABLED(CONFIG_CEPH_FS) && IS_ENABLED(CONFIG_DEBUG_FS)
+# include <linux/ceph/ceph_blog.h>
+# define boutc(client, fmt, ...) \
+	do { \
+		struct blog_tls_ctx *__ctx = NULL; \
+		if (static_branch_unlikely(&ceph_blog_key)) \
+			__ctx = ceph_blog_get_cached_ctx( \
+				(struct ceph_fs_client *)(client)->private); \
+		if (__ctx) \
+			CEPH_BLOG_LOG_CLIENT(__ctx, client, fmt, ##__VA_ARGS__); \
+		else \
+			doutc(client, fmt, ##__VA_ARGS__); \
+	} while (0)
+# define boutc_bounded(client, fmt, blog_args, text_args) \
+	do { \
+		struct blog_tls_ctx *__ctx = NULL; \
+		if (static_branch_unlikely(&ceph_blog_key)) \
+			__ctx = ceph_blog_get_cached_ctx( \
+				(struct ceph_fs_client *)(client)->private); \
+		if (__ctx) \
+			CEPH_BLOG_LOG_CLIENT(__ctx, client, fmt, \
+					     __ceph_blog_args blog_args); \
+		else \
+			doutc(client, fmt, __ceph_blog_args text_args); \
+	} while (0)
+# define boutc_formats(client, blog_fmt, text_fmt, blog_args, text_args) \
+	do { \
+		struct blog_tls_ctx *__ctx = NULL; \
+		if (static_branch_unlikely(&ceph_blog_key)) \
+			__ctx = ceph_blog_get_cached_ctx( \
+				(struct ceph_fs_client *)(client)->private); \
+		if (__ctx) \
+			CEPH_BLOG_LOG_CLIENT(__ctx, client, blog_fmt, \
+					     __ceph_blog_args blog_args); \
+		else \
+			doutc(client, text_fmt, __ceph_blog_args text_args); \
+	} while (0)
+#else
+# define boutc(client, fmt, ...) doutc(client, fmt, ##__VA_ARGS__)
+# define boutc_bounded(client, fmt, blog_args, text_args) \
+	do { \
+		(void)sizeof(#blog_args); \
+		doutc(client, fmt, __ceph_blog_args text_args); \
+	} while (0)
+# define boutc_formats(client, blog_fmt, text_fmt, blog_args, text_args) \
+	do { \
+		(void)sizeof(blog_fmt); \
+		(void)sizeof(#blog_args); \
+		doutc(client, text_fmt, __ceph_blog_args text_args); \
+	} while (0)
+#endif
+
 #define pr_notice_client(client, fmt, ...)				\
 	pr_notice("[%pU %llu]: " fmt, &client->fsid,			\
 		  client->monc.auth->global_id, ##__VA_ARGS__)
-- 
2.34.1

