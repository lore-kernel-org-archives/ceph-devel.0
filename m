Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45241F7EF
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348739; cv=none; b=DZ29TS2I0me1Vc+ad+6VxTRHAnK3DpRqAPHNmTzrgR0cP+2gltRHMmsS4esXa8UBhYp6niz6eZS39FvfUzbQphRuVEdwADV8pOjLr2Ruen1ATQjHASB1kFxJRHyanGm+DANlcU24I3Yh1SbG+U4lF4rEtYJs3H5QuiIpG34BHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348739; c=relaxed/simple;
	bh=ErBGiqUblI8bSe7gMFTzt7NVb92gmXYehbquO98hS3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qA5o4hzsYBEoSI1a1CtUCV1zgGEfkp3kMkQjDEE0kmPV37T3svgwW38uA9+YNuNL9v/zsL0c+pPTlWnBipmWiEd78vLwUVaGEhtW7sLeaT8vPLUVVD9lEFhT4fBZldEsuGIjuHRWnE0ARtRKJz5wJoRc72WwO4cuL1fbp+HXkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEN8qRCm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2bsKlyR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEN8qRCm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2bsKlyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SICnEp2MS9TsqFmlyybNTluuyRbpzaYyuaIym1bBaA=;
	b=XEN8qRCmKGvySa4+SuvL09ioKtNfYzx65WCEn0PqDwT372Z6b+qYwTDLwn/7crJAGh9uHB
	NdfXyhiRccoCkg2VDz/lhQ/d2RlRnXy0tEA8QOU5BiXIyzYNKcue0xUtNKQGbmLQ3/i/hv
	PsozDfp/o5K7Q7mcRcJBfAOdARCNOAc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-zvcq35LhOJqzduavS2i2AA-1; Mon, 06 Jul 2026 10:38:55 -0400
X-MC-Unique: zvcq35LhOJqzduavS2i2AA-1
X-Mimecast-MFC-AGG-ID: zvcq35LhOJqzduavS2i2AA_1783348735
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c128cc0129cso223839566b.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348735; x=1783953535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SICnEp2MS9TsqFmlyybNTluuyRbpzaYyuaIym1bBaA=;
        b=N2bsKlyRACBjUKZB68kjwfnJ5Cv9pvFG8wPOjR3U82NSHe0VAO48c7hPwaD1eVXvVO
         hVl1nmnbK/NxNjSpKleJ2KOjWRWrXkxYVU0gi2QGb4YVmKqKqbbyaoHJtkDzJq1b1Cuf
         R6bGRYPoUH10cb0c52aExUJwZFQjhPVmsRKlpgiKlId9H9B7hNgMjwfl3hsp1LJ4NTaR
         lfLp2HE3DtQmby7pB5cj8qbWkrsPZzIMg3rUUDuUiQH1eh2StmyboO60MqC8oQlJLqhm
         nEtOLwTZav7tf4nEGPQOSi19ZodP5oLlbmeBfpR+MIPnm6ANbju36wkobWUG6M4/UoPs
         MK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348735; x=1783953535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SICnEp2MS9TsqFmlyybNTluuyRbpzaYyuaIym1bBaA=;
        b=N3S++/gn5jzMOhG3tJb382iWmH79fYUi5MnjDHGNaeEpNNdiL2ir4CkemY/8KTHvVg
         bCgl0YXrqPNnQXbmkatug/2Tz5KisFzAm72eyfEA9hyz7/G0HmcyLU2xYlkkvxUrv72U
         VHgo+DjvYTWz4wC3o3murrnXZOTJvear0EDL56urJQhxzMe3xwZwsDXY8J0GKSExFKzp
         fJ+0tKaedlwoMZMaY+1DyBNsmasOUk+4hTgmURBKa4B0Hgo3BSRv1/HIQplqiEuSdmQB
         i8UgWqrlKhswqOrVktGmGtY3xTK3XY9443KbXT8vY9yzYfyWKIjqgCdDEd1LC4DJKSXa
         d4og==
X-Gm-Message-State: AOJu0YxLM662gmr9/rFvAztcS/pY1FVObKU5haej0QSrPmnOImwyiv9U
	HXm2dCoIm5weDo3K8p8POzPWEu47pr0W3/l14ZuW6XazoOsH2Bp+rYjZAK1eenIp4Y5rLaSA9Xm
	tAF5hPeKm2FeK3It9g/TMuqlc68hI3aoJ7HQhjK2ntr3NvkOpY1PeGQ8oOwvSi60ZccdZF0ehIZ
	3iRaPVHvt7o74Xedf2ecmqX6x06NFyiGozv1/yiSwh5h6li3mgbQ==
X-Gm-Gg: AfdE7ckBNU6i+VLgcuPsKAEDQ2OvFySF0TiVTD7h0YU2GTusgkweFdYNoq1QHu/+wpp
	4wZfwJk1ss+bxbFvPh4wnBNFTuTyPIX5lZtvb7i+NY8dQ3ahV0ata5Suo6lnvXn//PdCaItpBC3
	NfEaV86oiZbtHC7D2Y0nqWxpyaMxkf64EwQs8tjj42a1yXeh7obxcM5X+2c5HP06SyUXf7uVk09
	Ejpd1ujYNbut9WSMs82TTigxLf9lNdqCf8erkKhOr7fnq9ZGVH/VV/qCOQyT3TaIOMt1E3zw6NV
	L08fZWVGiSX7vBrBhX+fPUlphPg7VQzUB3Rc4YpWtbm06x5m+rR9BAX3jgF94QenDnaPKR+IYYb
	GZBk4YYEtI1SDvUcZYo0JNxPz3hv44EyQ5+db+QRZwEXS
X-Received: by 2002:a17:907:72c7:b0:c12:6280:33c9 with SMTP id a640c23a62f3a-c15a624de1amr47797166b.28.1783348734519;
        Mon, 06 Jul 2026 07:38:54 -0700 (PDT)
X-Received: by 2002:a17:907:72c7:b0:c12:6280:33c9 with SMTP id a640c23a62f3a-c15a624de1amr47795266b.28.1783348734004;
        Mon, 06 Jul 2026 07:38:54 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 08/15] ceph: add bout and boutc wrappers for BLOG
Date: Mon,  6 Jul 2026 14:38:36 +0000
Message-Id: <20260706143843.1980879-9-amarkuze@redhat.com>
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

