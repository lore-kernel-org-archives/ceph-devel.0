Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20E55C32B
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958480; cv=none; b=c7KhLG0LIwJkv0wFYPWXwQC8u+Dktxxd8xioiWKqNaE6sc/oNpjIC8Z5bKc9ou10rDnGHDoHmhrEZgFuJFhktyEodBJ4RIuFE96LMu9lCkizeop7L/TGcTfs2Y5aYy5l/+3KCLhfj/WehrWYt9tN1XKmWgCmEUFeJqmLOVtOtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958480; c=relaxed/simple;
	bh=9MG0X8mloQDDOvQemBsFUFZDkF+N6Ofznpi66UL0zNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVSxofCfLOF5VkAuxz2sLiKMQrwAKUIXXcCw0Kbg8DX6Pnl365e2Pgo9KhcwuO8fGalNV6o94ydxeRfbhnJkG7QTBFZa9WYkhW12pyNJREoN82mdeK1CqK7IrFyx8pJRVbAglmGESYuLaI/QnD6cH56bihADb4caqEquV0K1gc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBf7ufYu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5QpKuHC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBf7ufYu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5QpKuHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
	b=jBf7ufYumGxuAJQARJlPSH+vFNYueuCFV8qf+dj8EYFU65GIEL2YMk1UeEXvIlfKY3m0rI
	FjMghBNuxoJyKmj1wi2beUxsbp3vqeR5yHv8UPdMN1qCz44fmghX4hDQP8I5a0v/6A4Xka
	D1YeYtWDUFv2TFFrO3Qq9gqyYVNGKM0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-a82PlVXWPzmDQ7TxyeNXgQ-1; Wed, 09 Sep 2026 08:54:36 -0400
X-MC-Unique: a82PlVXWPzmDQ7TxyeNXgQ-1
X-Mimecast-MFC-AGG-ID: a82PlVXWPzmDQ7TxyeNXgQ_1788958476
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92ec3146553so1345834885a.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958476; x=1789563276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=E5QpKuHCg5qE9nTerCLnjEr3lMHn87s6srgpqyyw8mgTCcFTj/xNmTIzJwD3jRSww0
         FGr/SyZTP8u8irz0oRqVkgcCjvgphiNvFVqvBB0d5CbWdVs6e6IuHqApwVrvceS8ZObk
         +tA3ld3PI58xX6E83nLLwHYDraU/bLYHWTr94rrRP2GaOotjaANC0TDCDfUcvTClymy8
         qA5ltgo66hOi02h9QPIOl9vehLNvU6BY4WcXdY+2EKNAqW4xQcp1YR37tMlnEB7Kre3y
         zv/dTSjKvpCAt7lxI1hP2/FWH/J6BX78WdWlPmd5dCaJ/l9aBjKIEcGsd2sEeLwa1P7v
         9kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958476; x=1789563276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=RuIQfKNCXRoYWyWpbRoEmkigDy/qGR5Bk7BOSNchStOKmce22riw1zxfwgCpp/s5WP
         JXYUrxB6tNAhjnz24Pc2o4e8hlTK9Oai4QfOay2RhrBZpwpCEq/6qsLTgMhnDWj5Y+zm
         /joTnXsqVA54p48RcdkxNfibTqOkA+gRTKVZyFI23opZNplSUoKLFj/yUxKvPeDH1xfa
         bXcaypiNQAKfgi1N09a8VHFAWDft1FGQRW7cQ/+hW1QfeWwYsZj9plMQZdnbMXTm1k4L
         IydBC9hUxoBfFwDzd9obKOcwrnz8F897z2wd9xg2FRgRjlxrgrMKuALXF3hmkVIDD7ii
         /DjQ==
X-Gm-Message-State: AFuF++lNaCU8+pr4STChZ8YAopbYkugzS93hcmgsRJFJHWahVBpMsL+A
	P1RayNdT16UC0B960+BmdGBQPwhLqZgiwc8gpDWE9aDTiO425rg1yU2XhchvKgGxu/HdbUSagtP
	cGfMATxKFINwuU/5l7VHYD/jjUNMU6URzC1l+ktBKP8nEdDj2Gb2E0V7GGpGSI+D7ano7DkVhAr
	cx37YCMCixa3jI9XfLf+Qfhs8xMOTspPwhMLmr1sdL7P5fzCuekw==
X-Gm-Gg: AYBFou3cU2k0vWP7xkgbudi4RkndbKZ8jh8L+PxijSZug6WzUvhp3EmBlLe7e5Ma8a/
	ErQZFQ+sXU9eF9tjAvfKtbBF74aVEP60/4UR7NV+zYRZ+Fqno2SKF5hU5WLpRx5FWL9ntb2uBgW
	KkUnDcBM41WgB1zPmg5T3dn2SMy021/OJW9uHm8jsXXek+xIusrdShfCNmHdp9Dp6waXsXCn5xs
	IegZ51IB2k8dEARLjR+woRN6/cLBhZoJHuqIzBA7VWsK1jfo5ITHMSkJ9zNcmECZ4NH41hycDYM
	azazQvROzYIfWYF7JiL4rKZg8BOFM71xE1AOWLn9wcdRb+A/hYOGJkTLGD/buzrepqsohUGpmO1
	Aiofvu9uwUILM8gjjIfChX1EGQ8HArsNHFuoeuCgv7wOAXz8v1KG3uwKi0yw5Gv+kYZ23rg4/Ke
	GzLRfuNYDN0v+IDA==
X-Received: by 2002:a05:620a:172c:b0:936:77d7:55a4 with SMTP id af79cd13be357-939805edadbmr3789760285a.19.1788958475806;
        Wed, 09 Sep 2026 05:54:35 -0700 (PDT)
X-Received: by 2002:a05:620a:172c:b0:936:77d7:55a4 with SMTP id af79cd13be357-939805edadbmr3789708585a.19.1788958470407;
        Wed, 09 Sep 2026 05:54:30 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:30 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 08/14] ceph: add bout and boutc wrappers for BLOG
Date: Wed,  9 Sep 2026 12:54:10 +0000
Message-Id: <20260909125416.3969532-9-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909125416.3969532-1-amarkuze@redhat.com>
References: <20260909125416.3969532-1-amarkuze@redhat.com>
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

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/ceph_debug.h | 84 ++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index 5f904591fa5f..2f0c35b7f6d4 100644
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
@@ -38,16 +32,82 @@
 
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
+		if (static_branch_unlikely(&ceph_blog_key)) { \
+			struct blog_tls_ctx *__ctx = ceph_blog_get_cached_ctx( \
+				(struct ceph_fs_client *)(client)->private); \
+			if (__ctx) \
+				CEPH_BLOG_LOG_CLIENT(__ctx, client, fmt, ##__VA_ARGS__); \
+			else \
+				doutc(client, fmt, ##__VA_ARGS__); \
+		} else \
+			doutc(client, fmt, ##__VA_ARGS__); \
+	} while (0)
+# define boutc_bounded(client, fmt, blog_args, text_args) \
+	do { \
+		if (static_branch_unlikely(&ceph_blog_key)) { \
+			struct blog_tls_ctx *__ctx = ceph_blog_get_cached_ctx( \
+				(struct ceph_fs_client *)(client)->private); \
+			if (__ctx) \
+				CEPH_BLOG_LOG_CLIENT(__ctx, client, fmt, \
+						     __ceph_blog_args blog_args); \
+			else \
+				doutc(client, fmt, __ceph_blog_args text_args); \
+		} else \
+			doutc(client, fmt, __ceph_blog_args text_args); \
+	} while (0)
+# define boutc_formats(client, blog_fmt, text_fmt, blog_args, text_args) \
+	do { \
+		if (static_branch_unlikely(&ceph_blog_key)) { \
+			struct blog_tls_ctx *__ctx = ceph_blog_get_cached_ctx( \
+				(struct ceph_fs_client *)(client)->private); \
+			if (__ctx) \
+				CEPH_BLOG_LOG_CLIENT(__ctx, client, blog_fmt, \
+						     __ceph_blog_args blog_args); \
+			else \
+				doutc(client, text_fmt, __ceph_blog_args text_args); \
+		} else \
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

