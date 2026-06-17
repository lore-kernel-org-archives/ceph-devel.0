Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F04611C4
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708419; cv=none; b=Qj9ENAQ4t4TtrJAyq6DmYr8QI58LA7ynAn6xkrChqmA6Oh9InGOvzU+EKWnmHva+cApmHnZP1VMmdzOIfxyVUzAcJbefNLLw/4wYJFwaT5/UZkLdp4sKMHyUPcCC8RlJ6NOVidJJa0JkzTCqJgSawrhpEZpoDi8V1dBWUSYWlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708419; c=relaxed/simple;
	bh=ErBGiqUblI8bSe7gMFTzt7NVb92gmXYehbquO98hS3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEAtRyP9u4qx3e8rsxp163fH99ynHvFYlPUC2KtgMLsBL9Gc9qggX7d3/4MlQTa8O2EcITLPTlUU89zA3I0UR2tRPjuETkErIe7ETEJ7S1UjLAOBv1l5kZFOD9ubFYT00cIx3nfuQNIF+eRsNFtkBc4LikPlLEb12KLEV3kg2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gp1AWrGa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m4Ell+oF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp1AWrGa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m4Ell+oF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SICnEp2MS9TsqFmlyybNTluuyRbpzaYyuaIym1bBaA=;
	b=gp1AWrGa+lytfxkJ+5hmjppTIt7BgR0P+gbshRPUp2e+M6eQPL7zo8yBzsQIIY/IQmGkYB
	YGfB/X8HlVkfDM2oo7V4Oq9g/EuJZEazsbo7nGE4lsCSnI94TAVtiL1Xp63R9Fmf5ncMY/
	c0TjVKVKDH/PSZ+ZDrmTKEJqqrbPoXQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-4ZAcAolgP46GCr5tpDeyMw-1; Wed, 17 Jun 2026 11:00:11 -0400
X-MC-Unique: 4ZAcAolgP46GCr5tpDeyMw-1
X-Mimecast-MFC-AGG-ID: 4ZAcAolgP46GCr5tpDeyMw_1781708410
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6cb279950so11637740a34.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708410; x=1782313210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SICnEp2MS9TsqFmlyybNTluuyRbpzaYyuaIym1bBaA=;
        b=m4Ell+oF+BkKsksjM7NcLEQ+hRlVQ9l9y3vhWQoOUWlUBVIL4nk9SqX+BekJSE1AA4
         ldcRkaIf9/+Lsv7Tt3OxtoieYzOnKvnIw+gvPrCsGO8nZ05Jch+bTAxuwcMuq0Nv9Ot2
         Yl3wzHqe54TdxwBXLBDH7GJtArnvVXqnsIhPkaqXHOuTSO35YyfySfz7LAkoib712299
         mrFoowFSMi+iLeAMMoZbcLYD/qyCwQwPCsLee/RrDYxdNchm5gijC1uGleuRkBpaWyFB
         pGamfH9ZESSlYC9gcVPYcFUrT3CiE8Png+zrhfnQI528/XhWsM37ZpPcj0c39l9ZOX6k
         lCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708410; x=1782313210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SICnEp2MS9TsqFmlyybNTluuyRbpzaYyuaIym1bBaA=;
        b=B7lQvWBxcFMupOxgvuwwqLmcYViCS+bEzlX/7bofHO6+NCH9kLBGgQI2eItmT9G6Gw
         NSRv2B7CMRA/X1Mpa/J5D1plIkFESVJfTZhtBLoBuFhyBa8390SwEjIzb5wRnY7v/rBd
         /r8ygICoBP5T84h3n2Aa8mnpKr04c8ryJJo7YVvc+PLGXFQaoZGQ4vA4KRAbqiLbmJon
         0HSOnmOhgdZh5q/5EmUovtR/c3L754K5kMBhQbo1B9XNBgFJvoKJ3lB4FhucA+P6+7nD
         SCzwL6MwWcCKuNHg/nDOXsP15psl1v5b5OG3KKQHcAx7n3WE+Z0X6il5rO1+uS4Ox54i
         8CaA==
X-Gm-Message-State: AOJu0YyvcgJ3jGCPj/o5SsIAdxdvGvafwReTU5C0whAHC+ZR7eDGNfeU
	NA6IAdhESQ/KSKracoBXteilxE08SdFEq/hDU1uR/c+UUtWgRGSdqagUD3oenx6+maRBd4uttoS
	N0gww6p2qSEAlGDFm/jMlK1074CM2hQTYySVB3HoahgE0I0qXipLyO6X80DG0eoe+ST6LoeAqUl
	xR8wwHdXMm1wFS99oyQ2HSnpeEV3Z15hbkn4szASpLsfyr2JtMoA==
X-Gm-Gg: Acq92OHY3MAtyp3+j4vCRQSDgWhAeK1h6byK/6oYzZowLvzs/awTxHMvcxGKGtohnlG
	qOcWjh1/TY8cNt/FtfAwOBdou5WLMROyKGXUidBzfi3GuHQzchC7Iy228jDawY+uXEM0FD5XHNE
	m/SPh3qn7WoVb//WdtMl5OijY304hxJJAW/kigaU564dy9dkH8ac9wUURi45UTqmD7Jz6GJXtRa
	FUeMId1dtPVtWI7wUsQSTOrNXPgvSBxPm/JU2PKf0ftKOJ+eiZWY2an9hNYhuWrFIg2Y59j7hEg
	xfcyhpdSGhohngzjF+E3Zco5AuHwuJGjb0vkeGcDXPkwZLuekcfPOXFz0uvgu90Cv/+d2ze5D3r
	hLfdvZT9PG7pca3hlPCmdhZhniehGA1QLtOmjZV5lIMcB
X-Received: by 2002:a05:6830:82e7:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7e90b2ae84cmr4210840a34.1.1781708410066;
        Wed, 17 Jun 2026 08:00:10 -0700 (PDT)
X-Received: by 2002:a05:6830:82e7:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7e90b2ae84cmr4210797a34.1.1781708409416;
        Wed, 17 Jun 2026 08:00:09 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:09 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 08/15] ceph: add bout and boutc wrappers for BLOG
Date: Wed, 17 Jun 2026 14:59:38 +0000
Message-Id: <20260617145945.1912736-9-amarkuze@redhat.com>
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

Add bout()/boutc() macros to ceph_debug.h as drop-in replacements
for dout()/doutc().  When BLOG is enabled they serialize to binary;
when disabled they compile to nothing.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/ceph_debug.h | 44 ++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index 5f904591fa5f..621f9190e6e7 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -8,25 +8,18 @@
 
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
@@ -38,16 +31,43 @@
 
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
+ * bout / boutc -- binary-logging variants.
+ *
+ * When Ceph BLOG tracing has been explicitly enabled and a BLOG context
+ * has been cached in current->journal_info (via ceph_blog_enter()),
+ * these route through the BLOG serialization path. Otherwise they fall
+ * back to the traditional text-based dout/doutc macros so that existing
+ * debug semantics remain unchanged.
+ */
+#if IS_ENABLED(CONFIG_CEPH_FS)
+# include <linux/ceph/ceph_blog.h>
+# define bout(fmt, ...) \
+	do { \
+		if (ceph_blog_get_cached_ctx()) \
+			CEPH_BLOG_LOG(fmt, ##__VA_ARGS__); \
+		else \
+			dout(fmt, ##__VA_ARGS__); \
+	} while (0)
+# define boutc(client, fmt, ...) \
+	do { \
+		if (ceph_blog_get_cached_ctx()) \
+			CEPH_BLOG_LOG_CLIENT(client, fmt, ##__VA_ARGS__); \
+		else \
+			doutc(client, fmt, ##__VA_ARGS__); \
+	} while (0)
+#else
+# define bout(fmt, ...)          dout(fmt, ##__VA_ARGS__)
+# define boutc(client, fmt, ...) doutc(client, fmt, ##__VA_ARGS__)
+#endif
+
 #define pr_notice_client(client, fmt, ...)				\
 	pr_notice("[%pU %llu]: " fmt, &client->fsid,			\
 		  client->monc.auth->global_id, ##__VA_ARGS__)
-- 
2.34.1

