Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F094AA401
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366496; cv=none; b=oun8BzmWfnT025NSlZFTTG9SVAowYTjCn1s7FIALePUA3WaHM8lZ/2qFVwwAp1rFnMyoA3Zxrl0VNATYgJThjqgGpHq61ddetWchdmpbT8kLWgeq4EA9UxmScYDgHQPal8Yql2LJBKtOkKDxssDY3HIOwEyDT049Otg7/nttr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366496; c=relaxed/simple;
	bh=9MG0X8mloQDDOvQemBsFUFZDkF+N6Ofznpi66UL0zNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I78wP/P6RmdULejgwm1bhK0gj69matEwIGYXJH3/snGjvpJyLTFu5CZH+sm0zlK9b45AxZVlbLlsTCfbdpVukXYqRFxNtjT+vQbGtWjpB3keV+SIdsebZQFV+yBT4io1lIE9EglSYy6JGBr38hqhMxoqSUhj06o+jIn95x/5S4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzodsAXy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rQqVTsjl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzodsAXy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rQqVTsjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
	b=HzodsAXysECG0YnL1oELnYwluYGTXXBrRJzptgXWCqRMLkxacq8XnXu54rkZzLN7o2U6PL
	4jRHnR++OMTgIVfXQjfR/hXwgmnJEoBt663YiEP8lj+qa8uXjrFhRp0VnXcPRMsQBFau0Z
	gjjllmt+pIIE1++TbmEuLQAuL8jMnnw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-wlYMzPNZMKylAPDa-fDtKA-1; Wed, 02 Sep 2026 12:28:11 -0400
X-MC-Unique: wlYMzPNZMKylAPDa-fDtKA-1
X-Mimecast-MFC-AGG-ID: wlYMzPNZMKylAPDa-fDtKA_1788366490
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15e6109f9aso117015666b.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366490; x=1788971290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=rQqVTsjlUuUl0J2+nbCOHWUdaRZm2q5yhWPpl16+73FLsDmVSjWs7ymp8BnJefs3kP
         y1xkN9xfQQPBBpXcH8O5ka4Fgo/DJ/p3FmyI4SO/vWvioP1DNcitbQLtXpeHjAtGMKq2
         fqlibgZhP9ErcK2yuoWyUSguvFsEUGanlW3Qv8yi80+ovZ6v5HP6I8oDUfvfcMTkKcpo
         ebJELrWcO6nyCNOvn49nvDyCNXnU9lTGwoMI8iQQxQJGdveEjQgsUCsz/MswfGzAm80h
         1F+9ZO72+sKX1d9MnBiaLTeWZUUaLznZlaO9UxOhHv6SQ5PUNvtD3D50eTMRTESISLyy
         9vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366490; x=1788971290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f4fqcwbMx0lCiN0kKQQeyACbW8vpItpDaz/a4HSldDo=;
        b=PA4F0W+0oam+KptE702KaVzyB9vlVOfs9707XK6Xc/lmURZOrHC/+h0tmzMu0MeChQ
         yUeLKEzE+jUXL9Buw2BOHgswwY8qn2VFoYrMPLiOjnnNQZIJtDXoQSoEARrmCcWx0Bfq
         KgSrtSGKloqKg5sJS0768JyiZrNvkW750O4cjrhiXwzuVUGa5EBNf3+Glv67wAGfb/Aa
         Kl8FndZ/xOBoWdQ0EZva0+nNN3DamKYAWueZmyPyX1X2qOjJdHuDFmT3hP2pLrr2sdnD
         LyuBcEo8tunRWWa7vHTUB573vbqKVNPmyX4yReb8tDnICxXxniCBNyG7zTQk/z3WrBkO
         eBUw==
X-Gm-Message-State: AFuF++kBPm4rVzlY3c28ABmRThIk/1PxC0mNDDwkvI2lldVwJxy3KP6H
	StwAY2f3+8RhPNYzfTT7hoPqe8iBlkIPRYqwnDb2gZv13RErB79dYinJcaKsa1n5q6f461I2qMA
	acq/m5lAjHTR7DfF45PtGphoP3xyLzlk8JsbHZ3iWM1J7enrVBnJmERhj9ciDZXayvNqVjeYI5W
	M4VW/T5JbFFok8RoiaWrTutsLH5IkL1uf5kvxRcxYcbRhE386I8w==
X-Gm-Gg: AYBFou29O5PTxFXVOokDTM07vCSDKyhxn9gDImuLbdKEQf+wWdxAYmay93Ln2U6oVgs
	2Cs9/12sZPP0W7bu1GenbH1CgO38NYVHcD8jGh063P8fgYUmevYP4bUrK1/KaMG65n4NzgW+XW5
	pqiSpAVCu0NiaYvSMnLkvkFMW9PhFT8oDsWa3fS3S+EVunhdzEOzI93MBZv5poT4UNRAarOlFsF
	O4v22gRqYDizHCUzSs0UY2xX1sgXXcUN2otdLVF0YzmRkBGvagyu+3HYgI1E2DPQZ3t8D0o7H3Y
	GKHcB4NixftUvXSk7yvpkqSNlbjns/0uZjcE9yiK2Sb8cGXQLsXbrEU5FAZwgkGq5Yf+wx2rrq/
	CfNAlqx4Fc78mpSP1WAQEYN6nIE9xsu0SFvBBbUc8JIslLs33fbzbfkQ6jgP8u3Ur2lDfELNCu1
	v8HukSdnT6/legBg==
X-Received: by 2002:a17:907:6c0f:b0:c24:680b:3944 with SMTP id a640c23a62f3a-c25d55b651bmr461760166b.13.1788366489839;
        Wed, 02 Sep 2026 09:28:09 -0700 (PDT)
X-Received: by 2002:a17:907:6c0f:b0:c24:680b:3944 with SMTP id a640c23a62f3a-c25d55b651bmr461757166b.13.1788366489311;
        Wed, 02 Sep 2026 09:28:09 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:08 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 08/14] ceph: add bout and boutc wrappers for BLOG
Date: Wed,  2 Sep 2026 16:27:54 +0000
Message-Id: <20260902162800.3197342-9-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902162800.3197342-1-amarkuze@redhat.com>
References: <20260902162800.3197342-1-amarkuze@redhat.com>
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

