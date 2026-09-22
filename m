Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9254857A
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085682; cv=none; b=o7krxtROoAJEQo0Z4kaMqH+phXgm8crXtmhHeugBFYkQdKZfEPdf6oaPbwWANp43wmeuAqJofzNiog2ohI1n30OJVDkhcFN1rn+wQ51FAZM50gWv8Ed7l3VVu/lQJVJNxYHoKMDlPimyJ7X2O6XdeIkWNpwRaLLl66pOSgONqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085682; c=relaxed/simple;
	bh=TPluu+gMNl/X49ImtSeBB0gmoqAobBSWOyTihP7LEoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOCqq7QYVn5Byl9u1Qaz9Ym5Ho/ItUJ1wSYAqu7N5Pz6OMfQ7UYlHEpJXTslSJixSbQoAOTfndUX2Juhj8IofEjXgWhJKYNzwENI9iBSXvloSr9oB0EctUMMY4E5+OpQWnDhhRtjPLTNJOlhI3J5Ao8aFm6pYJilCt8ptz/Oprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvpemzZR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGUkTkls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvpemzZR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGUkTkls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5R1jYllZ8ZmtQtqDQN4pCmw0ibgldwFqJ4BaGYJO0Q=;
	b=LvpemzZRN9SwyDuBi9o0VXOnf/RAkeiwPtUMhB0GoPHX2gpRDoRG3KyTKH/dRJdEMlrPKd
	ht9Pt1Uf5DMaQhw6otzDzsiFAATfg+iSEQSM/GaLwUaT+bzbY8lrZWHPGqtI/x7nyTuSpG
	wRJUYsxAy1JZvn1Sbg0eKuwbDHcu67Y=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-dxTHg0i4O3-QqJM6ckCNJQ-1; Tue, 22 Sep 2026 10:01:17 -0400
X-MC-Unique: dxTHg0i4O3-QqJM6ckCNJQ-1
X-Mimecast-MFC-AGG-ID: dxTHg0i4O3-QqJM6ckCNJQ_1790085676
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-671203c3d56so1560897d50.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085676; x=1790690476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5R1jYllZ8ZmtQtqDQN4pCmw0ibgldwFqJ4BaGYJO0Q=;
        b=cGUkTklsyrtmX0y0sHsFwC5pRoJl6dMqqqsX15IFfk5kYl68NMyP8J53Sj+g1isWuk
         qN/CmMgDAycBHo6BxRluV9jDhNm39GMjOyF+dO1EXHzC/9Nmv5S2FQtZyJMHL2XIMx09
         nuKrANE/wYbi913d/0r71pZUxJk3d+5j8P19BLsfY1d3lrtBSbfm4j7H8mZguLzsUZUA
         jZ6HnCtqi6bEcjL9tB0B9un2KKnTH1npe7ylIthG3SBiZT08he1uAHaxRVHWl70yhoP6
         9xaOmc2xJYrxL/BsJs0NaECbC3/Nti8n0E42b/5o9iwJ1V2pAD4U+yxTd+RrUwuu1Ra4
         r/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085676; x=1790690476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5R1jYllZ8ZmtQtqDQN4pCmw0ibgldwFqJ4BaGYJO0Q=;
        b=Antklc+wifMTJJykan/ZSFgJvcFmDVGgWrAM4lCC1MQoE3MtL+Qpo1r+5CXB9Ro33M
         Goy2HXo1M+JSE4Gv+AuCQEfvdaiw0sboSlZFfr8eyz4h7awhx2q9ekWbRz3nRmYtav/W
         s1vv1fGkx8gvJE/oakThSM9CmDZMnn7MHE+djM9NEGWNq9Dw60lw3tNR55PnnMcZXU/m
         rDNoTm15Kfp9LuY/VWzz0XwXkuWb4i9dOlKgFdl7Pkze38cfNMZQ+2yTG5eLiXIKXe/r
         uMFzrq/ZbUpkp3ihEnNPy+VOI0WmEknPqoUP5qTbYWZWGIiJZRj6taEHGAMqNurqVvvS
         UuDw==
X-Gm-Message-State: AFuF++mbc+kEA8E1gmfh1ddHlapI61fWuS8G+esrpAhAExkqcSEy4nxe
	CJ0BmuFM0WjbpOwcrn366S1+8CN3QaTZUI1DNSWcR3LDq0/A9sEGgQbvKn8f6Wn7bEy2K0fj8QV
	+wc0KoAvqkDZNZ+Tf4LYvytTowOjD2C3zNdjqivBChCvgK/GgDTH/oCjQt0pvVMp7KMAvj+VHKe
	RvF01HiDDECgAdFj7iRPx0PhosdGRu9znJWl1Wg6kkrJ0VqPg4fQ==
X-Gm-Gg: AYBFou2FYXXtPyjZo1DMYVaqiJgOeiAyJ9W/KV78wCg9a2L7MZH9po9fJCwGD/dgDGg
	WVn8ToGwdSpxMlDfI2lubZvQy4TfRKTPon91etAZ9JUqCjwPBld9r0ghdxmCUMOP5Z1S13L6Y/h
	w8b3a8Q7GxoJ5x/XjtDp3GJb62oFJGL3I6k7inlWrEG1W0SSgNMWKwlSYQa2cZZXaznYKVI5x9G
	tfJ4G9L6RG+RkJ4A4C1VLZOwJNcKBD3GRbhVxtssEXZOv+OkpjbJvv+PvY/5n4tnH0agbcam008
	KATSLb3NluO8UsETdkcy4PuGDs6cj4tVAiw1HtgGiHDI7jq5HuFDbtYd3eA2eCuLTZ8MNZslUMt
	EmniRe+xo/4/gpuoQnoWmO7FiBf1Ep6ex0f8rMeMo0vKXDbn9kJcg0uYUyFW6PEnT1YHgVBn+/q
	7/aDx9osyjXMvHfg==
X-Received: by 2002:a05:690e:1443:b0:66f:bfd2:6b80 with SMTP id 956f58d0204a3-672c292b2d3mr1281021d50.4.1790085674892;
        Tue, 22 Sep 2026 07:01:14 -0700 (PDT)
X-Received: by 2002:a05:690e:1443:b0:66f:bfd2:6b80 with SMTP id 956f58d0204a3-672c292b2d3mr1280849d50.4.1790085673551;
        Tue, 22 Sep 2026 07:01:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:01:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 08/14] ceph: add boutc wrappers for BLOG
Date: Tue, 22 Sep 2026 14:00:41 +0000
Message-Id: <20260922140047.794405-9-amarkuze@redhat.com>
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

