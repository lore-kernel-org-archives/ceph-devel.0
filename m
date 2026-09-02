Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FC4AA011
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365065; cv=none; b=LdvDHusb2PsI1VpYq/Ap7XxZoYVGfCWearxTwhI/zvgGztEYGjLvdVAKN/6r7SqNJX9QX1Xmx2LeuS3t0uQEfgaE19fwIbKh0I85wSV7mf/0+9r67X2Lkom5jh99xVlrg+JU93gsXsVJvBX+gk02bDHSNJmtznekVOPs7cMsymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365065; c=relaxed/simple;
	bh=9MG0X8mloQDDOvQemBsFUFZDkF+N6Ofznpi66UL0zNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyWddEgxUzj4D8sUS4y7z0wJkElJ3bS4/sKuBh4pKZq7Ng8Zu8PTRQxgpCNOwbRp4+pdOy3uFJYAE8FPrikuc/u8+EwO2zDtFLCSXsOS3BiG4QpSPSxyE1ZDtPUUidJdQ60doJ5eY4qOiR06pmcuc9NeXFdVXKVhDOaDo03qIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epgrB4w9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtTCFK2K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epgrB4w9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtTCFK2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788365061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
	b=epgrB4w9g117l0GN4qHmYmeZhDqPmfsbxI/glMSjB+x0xcY0qfOkJixM0kr5cBzLWbgft0
	Rn6rqKkma0szkGCSzkajLF/eyL/Ic/3yeY7bDVWvYFLS74JnDprAQ+YrNQvTLegbNLpiEP
	udxUH2p10XJ8ZcIyCWcHxalDk4QLMcc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Me4k7ZV4M2uT5qu2_qUDKQ-1; Wed, 02 Sep 2026 12:04:20 -0400
X-MC-Unique: Me4k7ZV4M2uT5qu2_qUDKQ-1
X-Mimecast-MFC-AGG-ID: Me4k7ZV4M2uT5qu2_qUDKQ_1788365059
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c213d5fb55aso124641466b.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788365059; x=1788969859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=XtTCFK2KDlhNjtoz+wVtrThE9Kyu43imYp0S1W/myHJBCU8zpmw9POVLOXURP4sI5J
         E0lhQSmNib7Sb02F5cznMVZCvI1pXfSj4VAaNsof4qE+AgI1J1JCuyaQ7YwicqqWpfq1
         OJx/TDXTzm7DAayAwZdysoM6Ht9yXwspP+lbZq0gyvo/GWBeYahzkSth4A8BYCvGK8Cg
         PM+rPcpCnqU7j5Zs92cdlkHUcv5Mv1oQEtdVdXPZHnv0FOET8++NKfS8sIUl4fxkQoFC
         h+JoB3CTQ/xpmABEalMytA7wH6QL0tAexsIbTRKuevSkSrgc3xS/yG2uZhzyW1viEI9A
         eBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365059; x=1788969859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=mVaOCDeo0At8hC+c+DG21VKKlfgSk3u3czQunAUkCWVbOSNSVKOstWv2Jag+FwPGQp
         2aTN4xaNHeUFKl1etcfcCYFKrKfBCUEnsWvDzb1ZrN8pYHCpfQWQaRf0rhs0HMxxpFVs
         26C1FKx+4uiM4akY5v2YdUgwGhhQhqgTPvL4zTmHcbdxRgteRrtqAttu8Q5fEYf7/v6F
         Kd0uhP1XwuAgffuGLHffRYIiolqoEP+rKvzg8jtAtwGJis+4TrRgY51GIasEExYIUMen
         QnTZTV5f82jugfLjWHh4X903mi2RQztaubXuSfw/Tl+GGbLj9xLMjmoNq7H7/H48ZaDy
         Vsgw==
X-Gm-Message-State: AFuF++moFVHXUt3NXyStwSpz3mfyIsrVuBSVIek59dNPOt17QpeFs5y1
	Ds/kltKq5jaEDvrh6bkbDTtSDDlNwokUb3kfErRFvy/vqHhLrT6a/p7yEVoBr1CdNoVT1yhDArk
	SXLIZ6H5STK0Dj7IYOkkfCHyObLhwiUnfE8dVZzDb/pxNXmKU4tuP3U2T0rOhZqvTJrFpyEIvnQ
	SG7y5sj/91UDXHwgvzvB9V0hwabNg7V9PCpOXRG1Tml+g0KjQ=
X-Gm-Gg: AYBFou2ULfXLAL2dRhSjS5BPYd2hQ+3aAfbtE9Rkq01+C2KUystWQny8Oo2tI5Fl7Kg
	1MHDxo9VRn6LuU0XgxOcy2VavrvfX07tlGXaTCPgs0jN1wXNIBjHlAMrLPTK/QWaK1BBPgqxDUq
	BqHrYpPpqZJpCz+up8ALE9nZC9U2g9MOWuhcYqYJuk5Hp+MnflNJIqfkJ0RtM/5NdgNfoxiYGF3
	jZ7G+ChJmfr6euFz4T7DoKApQ7hLnNTo9wsWHisH0W5B3tzjszhGkMGhsb6zuuxv7seK32wtcoQ
	jJE/EuDxsea1XcniPM1OpB2YFLbTQbR2lTkwjudqTWVylJhQab2G7jCuwxHByJ/8XpwYa9eYxqa
	xs5UQHF9lUsjCsUtgCkPy9LVMs1s1xx6gf/wPx+wyoHNlyUV9d/MEYe1cYtzHDSi3ea1gJfya7Z
	Dt4xQlE4yy+OIgNQ==
X-Received: by 2002:a17:907:8dcd:b0:c25:a25d:86c with SMTP id a640c23a62f3a-c25d554218fmr367508666b.22.1788365059118;
        Wed, 02 Sep 2026 09:04:19 -0700 (PDT)
X-Received: by 2002:a17:907:8dcd:b0:c25:a25d:86c with SMTP id a640c23a62f3a-c25d554218fmr367502766b.22.1788365058627;
        Wed, 02 Sep 2026 09:04:18 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7108sm165874566b.10.2026.09.02.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:04:18 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 08/14] ceph: add bout and boutc wrappers for BLOG
Date: Wed,  2 Sep 2026 16:04:01 +0000
Message-Id: <20260902160407.3196013-9-amarkuze@redhat.com>
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

