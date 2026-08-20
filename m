Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B5258EE9
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230620; cv=none; b=eQLsYpCs2N5n5h4b+XRwV2d8/vn4+VCLnKf/J+zP1yYyxhpeRtGgCEV3xOmdNvYRnUb9x6ibcacot4a0LOEuURQSNpi9po+rYC2xpujMdbRjZG+NBgNaFeDdI7Y6WI9uY9GHfLdWNrR/KpM7+f3UYAj7YoDwRTpgliFM+ivfEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230620; c=relaxed/simple;
	bh=9MG0X8mloQDDOvQemBsFUFZDkF+N6Ofznpi66UL0zNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=movD2aFvc/xx6Jvezerd+pUjcg9Qap40ldM4nBAQImF4NSk1YZ3uVRTYJLGuM6v4fyIhkEjIQ8IKMF3dk98D5odN9wv+q9W5D8hcGnlAugGFg5qqZ2VFFSMzWFNNfz2INJ+eKPtoWJuLPr2UnC68A3gO4SNJGXMaaVVX5r/Zscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipJ1tv8R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyquoiKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipJ1tv8R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyquoiKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
	b=ipJ1tv8RebTWUJZ3V5TNvCwhyvMIq6PMsSu8ZNuxFDHuSZMGX51Wg/uEMmrlcRdlPMcCUf
	PKotEDWWiLekIgaAlmOVmdxcoCVj2VeEWrDiibon1kRGkHlAqfyl0X+3lOS7Y4MOxm1DK+
	8CzmnwfGbvYqp5ymOXwhDuJ3NEMux7s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-TomuFXulPDOjHKQdXlUu_w-1; Thu, 20 Aug 2026 08:56:31 -0400
X-MC-Unique: TomuFXulPDOjHKQdXlUu_w-1
X-Mimecast-MFC-AGG-ID: TomuFXulPDOjHKQdXlUu_w_1787230590
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-698557ec1e9so1952272a12.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230590; x=1787835390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=OyquoiKKPimFfFRdZuho7omo+jYUxUnf1JEh8UIaDvG18KUFxqzWWig4wBjr1sMYO9
         tOldTCNcV/rii8mbnX1Sz2U0U0v6CpiP4ZjxxSPA+7FZQq+vJA24IqPqU/XHHaV6zrqD
         NLL0SK7YCVxag6bgsi6Bs5gkLailk/+bIKQVFyL7WCUHiqSawajdb2b+OFlqoG8phELG
         yoowBhd2bu5W9oqkDahP/IGk7/uSuKSwaVXEagIr2JBaWp7HYhlBlpBPlhTczVlKUw+j
         ycRoRPbuBqI0SziEYN/STqVDz0lsLnlD7IexDMq9Djw9EppCdHuV56AWNdisg8vYu3BC
         /k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230590; x=1787835390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=CHy2Y/5Jhm6IB0bw0100r5p1RMkDxDH74upxeMGW0El9MUe3AethO99g7VBzHnzGTf
         PDeFYQGpZKigw66bpKxvdABIAoVKyMKuXnmXPLcSh+Xntj0r2jN2psTlzPV+rbNtnUCU
         i7p5LH9E2jRbPfegPQP5AALWCAUOE8em+c/o53/aE6758Dg+GYWtywI0bs3ZOiFjH673
         MAnI+YjQJS7HYacRKa9lxp3U3bp1rWSMhmBvil1pNmjcNnMaZEbh6Cmx/8cuSpQL+3+O
         keSF/kAEHlPWk6lea26rkajnkH6mjS52ykDRksF34TVUhWNfW9CeBlOIxjnefvmPtX7f
         +WtA==
X-Gm-Message-State: AFuF++kIVAWHUmbo99CKLtc4G4WftuVNBEFxz8XXUgQc8N1eiRwPAhjR
	mBMszxBO5IZd+o2jl2uBLd0h58DECmmBvZXUBsp1us4wM8+fpWimdWp7zYiZMZo5sgCsDyWvP1x
	MULTIMGuYR0KUxVyvNSQYVX6XEVBUPuVF9rwUpq/pV4jw9C0ZilG46Ukt9oT3m8WLej7IMfkorp
	J4g6bzUyvecpShRYPjYnGkZOYbt0+JFiQXLVCb/jxyIlVGfjwaKQ==
X-Gm-Gg: AR+sD11/47GIxCTqfj/6WRzdUjjOmuh0VRv59W4pCE6dIPajBxr9Qbigm4+HKfJgooi
	XwdfZQbf44ODNlx9V8JZw5m/QoPDnt4Na2h/wIgKAY3BQXgKCH6HnGzG1u0zOcW0so5ZTv1daBX
	Zh81SAJeyYdIzd2WIrFnheXedbw153B2poE78z4ZKKaIPQ65nl0nJ/iBZdrOsdoUApwUC60NjU4
	hP/1ryP4jkJ5bZT5uJX3i17ayHjHA7qUXkPl17gVDOyOwY8xjsNnWQPU0wBahMl2alIgf6zalcX
	EU9JYYDwPqdf25MtsKMNE8Lmv+aGLo3tfhW5Q3YdcT7xMDd2DLUTT8lU/XiE/EEHJm+71jjm6ex
	AphPXuYUkm+Zjb78ri1AFgD4yyUH4DfR6vw==
X-Received: by 2002:a05:6402:371b:b0:6a1:29ca:681e with SMTP id 4fb4d7f45d1cf-6a4032b30afmr10322671a12.7.1787230589676;
        Thu, 20 Aug 2026 05:56:29 -0700 (PDT)
X-Received: by 2002:a05:6402:371b:b0:6a1:29ca:681e with SMTP id 4fb4d7f45d1cf-6a4032b30afmr10322628a12.7.1787230589208;
        Thu, 20 Aug 2026 05:56:29 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:28 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 08/14] ceph: add bout and boutc wrappers for BLOG
Date: Thu, 20 Aug 2026 12:56:11 +0000
Message-Id: <99e6d2223afbd497fa7501d5237779b6b31633bc.1787229471.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787229471.git.amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
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

