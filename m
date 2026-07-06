Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC6416126
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348733; cv=none; b=bGZWQNKALiEmVdWhHC/14ufAkosTvbjQBaKvNhAbuu3WEJSTMfxxZ8qm5QcdY266DQwvJ+LWcAm4ZyEo1nFFHnfVqk17bEfS2CPr+dxh7JH+QLQhyLIkYjI86z6wDxE53BwSUqzSXwAvixtNIRaiR6XuunITaEgqAafO7kOla60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348733; c=relaxed/simple;
	bh=lwuned5OjEtSKxAAPclgUwEW5UNSd/XmtlEBzxD9mZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4KDnG4RAlrv1dtR1owN1fWQU9UTJtI+7MRN1Gd8KKvEdQarFup+QT2/a2k8bLrP6HE/6sgZGAkKxdOsFkLgs2QseXQZ4VdtOCCX+uPrsxvGnq3B9JMVucybI1S8qgZHdp0AsGhdHG4lKoq67dVQbHJppsDUF49Ric255JHWqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgOObcmd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADmBizP+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgOObcmd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADmBizP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTd5MZt3RZ/NLD7/JM391IiRYo7tr/WwIXqzO2bOh8s=;
	b=LgOObcmdjjddpzO+nQY70mWyeaaBqaht4dt7cvqBRlEA3UfATuPFjA8VqIKDmTBskCUvIw
	ABpEt/PPR19wOuVY5XTw9MeHr/k+l4iz6EPHd56asFCr1XjJNuhm8SKDUUQYuzP3xwTR/0
	CSEunWhIfKndNwKZi6j0Jdrx96tow5A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-2W3H_4wtPaeG5rtR_upCmA-1; Mon, 06 Jul 2026 10:38:49 -0400
X-MC-Unique: 2W3H_4wtPaeG5rtR_upCmA-1
X-Mimecast-MFC-AGG-ID: 2W3H_4wtPaeG5rtR_upCmA_1783348728
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c12dd729b4fso221711566b.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348728; x=1783953528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTd5MZt3RZ/NLD7/JM391IiRYo7tr/WwIXqzO2bOh8s=;
        b=ADmBizP+0JXi9ZLWHsqSRgaqWPvJvm1QSeZUI/ws/lc17EP0COsR8cvZXZi69jYoAR
         aWjNYYEAqvRH0qpLCNdY8FR7kZ6XPIyLMSDbYibUje9MofBVZQivOxbqbTZUlqjsDGeX
         kbrMxMdzDSG6jygf0s3mTJlr/I0WUNbrh3ztxM4YHkqEStjKIOzou56236uLB422D8zF
         lZ//b6I+GgvznE9ws+0fp+rg3kSfqUbv28zbOCdIts+Q4HuekwcIUVLoZqXjZ+YI6L0/
         fYooLod6Rlu6by9nlU/hAnqqunRv87pMS3iPmNOWk4GqYtjTqAXHNsJeIuKhMdnt3ugZ
         ImvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348728; x=1783953528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rTd5MZt3RZ/NLD7/JM391IiRYo7tr/WwIXqzO2bOh8s=;
        b=L0xO+OACuVie8ARgX43lVCMU4QLRGdvuh2M3zNqZ1isKmcvzrnxLJXDlyjqRWj8pWT
         yQ2Vh3/y/S//TjvufQPKLQeItu+tmiiDr3f7u8kvwBagrww7mcsLmwrsUAqCqp2gI/YR
         hsgloL5/bdzlvK/zPicfLuqvr6tYvPreSdg933Im/YekSYJH0pbdvWNVB3lUj3gRfKQr
         ocuUl+mZbEpB7UQDKSlChDPzQ4bkc6PS1cyaZdZGXSANvfezfsUDz37uLiTXqH9UkymU
         d8YxT3YB8l7QVxmJBGhz9Qi8+JJtX8uc2rPConTCQk6BKav0gmY4uXCose88+i2i1Dh9
         Wokw==
X-Gm-Message-State: AOJu0YwHH0t4cr5REA+lGzBEnh8PdCAyYelxzGaV4EQocDhqEc0dOpBt
	Jp4xDkHAEpBBMpwZSPh/vVrvNWJ1LTYHEX0LYcG1atBq8yLKWqaXSe9E5o6jnQICwTXW0Wuxhx/
	elmDUGAcztwOPrFKmX8OoI8CMoUDf0j+ohlfomRLh4vf9/7G1xCbrNSA++D3jwXQ02TmNQAbgho
	AM0OX4okkABuzXB3Lg1R6ZNaa9BQkovVgxtpxTN7C+yJdsN6p2IA==
X-Gm-Gg: AfdE7ckPy5U68wEVVmqdHYOun24NRgZ6Pth3a3VocM+7XDyup1eiPusAfjcZhluJ79M
	zd2QuMgXw6QqrULUweCBT7uSRy8P/sf8OwDAxHgAbMk9SSx/wqqg24/gitkho3ALup8YzEmuUG/
	SCAP84ZSbbuiuyloolZE39QoMCwBSDYfWydkGkCg7ml8pUCgKKzbvK2fqzT0P0877sHtc7Now2e
	s/YueF676TRago46WtuywTaXFgThBZoBz2hGFUylZ6/SM+OqiMjlwZ/AkOqPNVXyd0RvoAzIIEk
	9XA49lt7ZNlrM7yV6/8K1s/DAJ/R1au/GG9VsR0WaNZaT3b0j7E+OYsbTaJaxK9uIhG8QzszCkx
	aI07HLpLTdQJKeujqMA/BTgtYUvAdUSUDCpJVNg38p13t
X-Received: by 2002:a17:907:f501:b0:c12:80a6:2df9 with SMTP id a640c23a62f3a-c15a67b7807mr51109966b.8.1783348727922;
        Mon, 06 Jul 2026 07:38:47 -0700 (PDT)
X-Received: by 2002:a17:907:f501:b0:c12:80a6:2df9 with SMTP id a640c23a62f3a-c15a67b7807mr51106766b.8.1783348727369;
        Mon, 06 Jul 2026 07:38:47 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:46 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 02/15] ceph: add BLOG deserialization support
Date: Mon,  6 Jul 2026 14:38:30 +0000
Message-Id: <20260706143843.1980879-3-amarkuze@redhat.com>
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

Add blog_des.c implementing the binary record deserialization engine
used by the debugfs read paths.  Supports %d, %i, %u, %o, %x, %X,
%s, %p, %c, and length modifiers (l, ll, h, hh, z).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_des.c | 332 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 332 insertions(+)
 create mode 100644 fs/ceph/blog_des.c

diff --git a/fs/ceph/blog_des.c b/fs/ceph/blog_des.c
new file mode 100644
index 000000000000..e84ca3fa156c
--- /dev/null
+++ b/fs/ceph/blog_des.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Deserialization
+ */
+
+#include <linux/ceph/blog_des.h>
+#include <linux/ceph/blog.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/align.h>
+#include <linux/unaligned.h>
+
+static inline void des_advance(int ret, char **out, size_t *remaining)
+{
+	if (ret > 0) {
+		if (ret >= *remaining)
+			ret = *remaining > 0 ? *remaining - 1 : 0;
+		*out += ret;
+		*remaining -= ret;
+	}
+}
+
+/**
+ * blog_des_reconstruct - Reconstructs a formatted string from serialized values
+ * @fmt: Format string containing % specifiers
+ * @buffer: Buffer containing serialized values
+ * @size: Size of the buffer in bytes
+ * @out: Buffer to store the reconstructed string
+ * @out_size: Size of the output buffer
+ *
+ * Return: Number of bytes written to out buffer, or negative error code on failure
+ */
+int blog_des_reconstruct(const char *fmt, const void *buffer,
+			 size_t size, char *out, size_t out_size)
+{
+	const char *buf_start = (const char *)buffer;
+	const char *buf_ptr = buf_start;
+	const char *buf_end = buf_start + size;
+	const char *fmt_ptr = fmt;
+	char *out_ptr = out;
+	size_t remaining = out_size - 1; /* Reserve space for null terminator */
+	size_t arg_count = 0;
+	int ret;
+
+	if (!fmt || !buffer || !out || !out_size) {
+		pr_err_ratelimited("blog_des_reconstruct: invalid params fmt=%p buffer=%p out=%p out_size=%zu\n",
+			fmt, buffer, out, out_size);
+		return -EINVAL;
+	}
+
+	*out_ptr = '\0';
+
+	/* Process the format string */
+	while (*fmt_ptr && remaining > 0) {
+		int is_long;
+		int is_long_long;
+		int dyn_width = -1;
+		int dyn_precision = -1;
+
+		if (*fmt_ptr != '%') {
+			/* Copy literal character */
+			*out_ptr++ = *fmt_ptr++;
+			remaining--;
+			continue;
+		}
+
+		/* Skip the '%' */
+		fmt_ptr++;
+
+		/* Handle %% */
+		if (*fmt_ptr == '%') {
+			*out_ptr++ = '%';
+			fmt_ptr++;
+			remaining--;
+			continue;
+		}
+
+		/* Skip flags (-+#0 space) */
+		while (*fmt_ptr && (*fmt_ptr == '-' || *fmt_ptr == '+' || *fmt_ptr == '#' ||
+				   *fmt_ptr == '0' || *fmt_ptr == ' ')) {
+			fmt_ptr++;
+		}
+
+		/* Consume field width: digits are format-only, * is serialized */
+		while (*fmt_ptr && (*fmt_ptr >= '0' && *fmt_ptr <= '9'))
+			fmt_ptr++;
+		if (*fmt_ptr == '*') {
+			if (buf_ptr + sizeof(int) > buf_end)
+				return -EBADMSG;
+			dyn_width = get_unaligned((int *)buf_ptr);
+			buf_ptr += sizeof(int);
+			fmt_ptr++;
+		}
+
+		/* Consume precision: digits are format-only, * is serialized */
+		if (*fmt_ptr == '.') {
+			fmt_ptr++;
+			while (*fmt_ptr && (*fmt_ptr >= '0' && *fmt_ptr <= '9'))
+				fmt_ptr++;
+			if (*fmt_ptr == '*') {
+				if (buf_ptr + sizeof(int) > buf_end)
+					return -EBADMSG;
+				dyn_precision = get_unaligned((int *)buf_ptr);
+				buf_ptr += sizeof(int);
+				fmt_ptr++;
+			}
+		}
+
+		/*
+		 * dyn_width: consumed from the buffer to keep offsets
+		 * aligned; output width-padding is not implemented.
+		 */
+		(void)dyn_width;
+
+		/* Parse length modifiers (l, ll, h, hh, z) */
+		is_long = 0;
+		is_long_long = 0;
+
+		if (*fmt_ptr == 'l') {
+			fmt_ptr++;
+			is_long = 1;
+			if (*fmt_ptr == 'l') {
+				fmt_ptr++;
+				is_long_long = 1;
+				is_long = 0;
+			}
+		} else if (*fmt_ptr == 'h') {
+			fmt_ptr++;
+			if (*fmt_ptr == 'h')
+				fmt_ptr++;
+		} else if (*fmt_ptr == 'z') {
+			fmt_ptr++;
+			if (sizeof(size_t) == sizeof(long long))
+				is_long_long = 1;
+			else
+				is_long = 1;
+		}
+
+		/* Parse and handle format specifier */
+		switch (*fmt_ptr) {
+		case 's': {
+			const char *str;
+			size_t str_len;
+			size_t out_len;
+			size_t max_scan_len;
+
+			if (buf_ptr >= buf_end) {
+				pr_err_ratelimited("blog_des_reconstruct: string arg %zu overruns buffer (no space)\n",
+					       arg_count);
+				return -EBADMSG;
+			}
+
+			str = buf_ptr;
+			max_scan_len = buf_end - buf_ptr;
+
+			str_len = strnlen(str, max_scan_len);
+			if (str_len == max_scan_len && str[str_len - 1] != '\0') {
+				pr_err_ratelimited("blog_des_reconstruct: unterminated string at arg %zu (fmt=%s)\n",
+					       arg_count, fmt);
+				return -EBADMSG;
+			}
+
+			buf_ptr += round_up(str_len + 1, 4);
+			if (buf_ptr > buf_end) {
+				pr_err_ratelimited("blog_des_reconstruct: string arg %zu overruns buffer after copy (fmt=%s)\n",
+					       arg_count, fmt);
+				return -EBADMSG;
+			}
+
+			out_len = str_len;
+			if (dyn_precision >= 0 && (size_t)dyn_precision < out_len)
+				out_len = (size_t)dyn_precision;
+			if (out_len > remaining)
+				out_len = remaining;
+			memcpy(out_ptr, str, out_len);
+			out_ptr += out_len;
+			remaining -= out_len;
+			break;
+		}
+		case 'd':
+		case 'i': {
+			if (is_long_long) {
+				long long val;
+
+				if (buf_ptr + sizeof(long long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((long long *)buf_ptr);
+				buf_ptr += sizeof(long long);
+				ret = snprintf(out_ptr, remaining, "%lld", val);
+			} else if (is_long) {
+				long val;
+
+				if (buf_ptr + sizeof(long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((long *)buf_ptr);
+				buf_ptr += sizeof(long);
+				ret = snprintf(out_ptr, remaining, "%ld", val);
+			} else {
+				int val;
+
+				if (buf_ptr + sizeof(int) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((int *)buf_ptr);
+				buf_ptr += sizeof(int);
+				ret = snprintf(out_ptr, remaining, "%d", val);
+			}
+			des_advance(ret, &out_ptr, &remaining);
+			break;
+		}
+		case 'u': {
+			if (is_long_long) {
+				unsigned long long val;
+
+				if (buf_ptr + sizeof(unsigned long long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned long long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long long);
+				ret = snprintf(out_ptr, remaining, "%llu", val);
+			} else if (is_long) {
+				unsigned long val;
+
+				if (buf_ptr + sizeof(unsigned long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long);
+				ret = snprintf(out_ptr, remaining, "%lu", val);
+			} else {
+				unsigned int val;
+
+				if (buf_ptr + sizeof(unsigned int) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned int *)buf_ptr);
+				buf_ptr += sizeof(unsigned int);
+				ret = snprintf(out_ptr, remaining, "%u", val);
+			}
+			des_advance(ret, &out_ptr, &remaining);
+			break;
+		}
+		case 'o':
+		case 'x':
+		case 'X': {
+			const char *num_fmt;
+
+			if (*fmt_ptr == 'o')
+				num_fmt = is_long_long ? "%llo" : is_long ? "%lo" : "%o";
+			else if (*fmt_ptr == 'x')
+				num_fmt = is_long_long ? "%llx" : is_long ? "%lx" : "%x";
+			else
+				num_fmt = is_long_long ? "%llX" : is_long ? "%lX" : "%X";
+
+			if (is_long_long) {
+				unsigned long long val;
+
+				if (buf_ptr + sizeof(unsigned long long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned long long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long long);
+				ret = snprintf(out_ptr, remaining, num_fmt, val);
+			} else if (is_long) {
+				unsigned long val;
+
+				if (buf_ptr + sizeof(unsigned long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long);
+				ret = snprintf(out_ptr, remaining, num_fmt, val);
+			} else {
+				unsigned int val;
+
+				if (buf_ptr + sizeof(unsigned int) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned int *)buf_ptr);
+				buf_ptr += sizeof(unsigned int);
+				ret = snprintf(out_ptr, remaining, num_fmt, val);
+			}
+			des_advance(ret, &out_ptr, &remaining);
+			break;
+		}
+		case 'p': {
+			void *ptr;
+
+			if (buf_ptr + sizeof(void *) > buf_end)
+				return -EBADMSG;
+
+			ptr = (void *)(unsigned long)get_unaligned((unsigned long *)buf_ptr);
+			buf_ptr += sizeof(void *);
+
+			/*
+			 * Skip kernel %p sub-specifiers (U, I, d, D, etc.).
+			 * bout/boutc do not support %p extensions; call sites
+			 * must pre-format them with snprintf and pass %s.
+			 */
+			while (fmt_ptr[1] && isalpha(fmt_ptr[1]))
+				fmt_ptr++;
+
+			ret = snprintf(out_ptr, remaining, "%p", ptr);
+			des_advance(ret, &out_ptr, &remaining);
+			break;
+		}
+		case 'c': {
+			char val;
+
+			if (buf_ptr + sizeof(int) > buf_end)
+				return -EBADMSG;
+
+			val = (char)get_unaligned((int *)buf_ptr);
+			buf_ptr += sizeof(int);
+
+			if (remaining > 0) {
+				*out_ptr++ = val;
+				remaining--;
+			}
+			break;
+		}
+		default:
+			pr_err_ratelimited("%s: unsupported format specifier '%%%c' at argument %zu\n",
+				       __func__, *fmt_ptr, arg_count);
+			return -EINVAL;
+		}
+
+		fmt_ptr++;
+		arg_count++;
+	}
+
+	/* Null-terminate the output */
+	*out_ptr = '\0';
+
+	return out_ptr - out;
+}
-- 
2.34.1

