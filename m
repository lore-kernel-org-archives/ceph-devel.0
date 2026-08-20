Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA9427F9E
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230587; cv=none; b=sI8XKcE1uTKwax9ucxrDGLIxB8uUkuwATXy9H/apJpo6i73W83c6fkokJ4nCChJNXQqRWwf9wE2BWK2bdsRvNv/hX3FKI0xsW7Vm7DPeuWxkypB0HXiRi9UaZ7gjnixZ7s+Ra2g4mztUXBR31ZYny2bRnTVtL3ubbTB8I8RaUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230587; c=relaxed/simple;
	bh=J1r26Ew4NGZtvCQRncUJLaxleAdiuoxVL2ep3/Hlxxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9jnjwgGZjUQP0SfoTtf6jna2tbBMCBkJJSl31RNdFijEMrDQqctwKpBS1FXqtxUkQ0BQ9Lsp/5+tJUgp9MQ5ov6ymXEjwG/u2wHi62omy8PofAG3idTMI71Qxvgq9tI4AL84VQGTPz345ogRkmJmH4LkIZNTcBcO4V/pHOTLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSoTxeTM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbHVzm2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSoTxeTM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbHVzm2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIl5y4JIf2XBTT//r90Kc946fUF3l8yzfuTM0vDanxM=;
	b=fSoTxeTMxDHtdPnXa5A09uyZDwr1I03iuXSo4d8uba1dwpoo+T1sbrpFeELa6//8qCpcie
	fSsm/W+rmdOh5/3BiRZDL28S+bFwf4HtJYxOSkszkkzDpVhDDrSQXrKGO1c2ZTPoVA/ie+
	B1jejwhsaIAvlu4LGN12qlWIEvrzjG4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-kst9cS2kNkq9FQLZukLG7A-1; Thu, 20 Aug 2026 08:56:23 -0400
X-MC-Unique: kst9cS2kNkq9FQLZukLG7A-1
X-Mimecast-MFC-AGG-ID: kst9cS2kNkq9FQLZukLG7A_1787230582
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a3ef31687dso2077793a12.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230582; x=1787835382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIl5y4JIf2XBTT//r90Kc946fUF3l8yzfuTM0vDanxM=;
        b=TbHVzm2edInDQJ0yf/IYykoihMDee8xfeA86j23zwCzbuNO6OU3RdRPmwTBbz5I5Nv
         1V8g9Yall/cyyC68KRsi8eRHAQLvIN9rJzHBpodd2Yh2apAD2Bz3FWa25qpqDgl2Efgz
         sdSc0qVm/655JxjQgUGZ+wYc3qiZVmfkcopFYBGZ3YtjjmwHjNEAeWUEp5ddDgIcCgqH
         CXopynyaXudmoeSMqzoeWyxOH0CecsaETEVk+zw5rQRVLkF4ZfnYeB3RBEWoJomxMV20
         n6wJXrxGMfxKPJq7FlwweCcq1fSr2/CcVKbOa7e/51ehklVNKNf1r//P8XntdqvT7l3C
         JQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230582; x=1787835382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TIl5y4JIf2XBTT//r90Kc946fUF3l8yzfuTM0vDanxM=;
        b=TBTQ5kINUm0s930NsxsmNxliWchcHsFW863waOPyXroIg/mrln9PAUf3qlLwzQ80xC
         Qp+pZq7KUtvrxSj4lrhvaH4Q+3EX712f5TwDS5RpIdng97LRalWgilXXKsyVrGIsJW1t
         8QVNAnco3kwahRgC5Diuh2vlbTNP29+FnhrREasf7IuQ6OTGpS67v+bnDwxFeRbpnHcU
         BQ497YO1OFeYEodFKgqOWlmrUBbH2xVbvSCqq+MRfGipq17HTMUeR+HM78CWCB2xM4BL
         01jNDNpAL93eKCOI5g4L1gWMDOZP3K+giaEd7FkCwCFtR5y7K+FWiHafLvGfAR7e7pld
         bJbQ==
X-Gm-Message-State: AFuF++kJ9G5F545CALdisEC251X+3vVQGFUISilJcbXKOFLmwvt5yeJk
	hs4Zxw4Sdjj5qu7lPsoRIoDCDO+mEghTrHdkugCoNEs0XHI6SpnNll7Z551P842TBde4N5jhFrD
	SlNgc+1bfrqfAuXtcPNBajTqFpq3xBpeTVaTB5k3dAPkHHpq6CTZwG+hFnx/EubOQqZa2Cr7c0p
	Op7QVwv162m6Nz6m0wFnu5exF1VCNKLhFmNBrg8uJ7T7bjhJyIJA==
X-Gm-Gg: AR+sD12rqcwtZPcEYyzowAXGx80gAw/iRFmwUjoIjM+rXY/YI6EkHEQODFtNG0DApkD
	STvatlMO5q14hYX/lTrk3ovWBY0wL4GcbnXaZyYKjucR9nafHVViqrQyrYEBnWR5WKmB48RMP4B
	Kgjq5vpVtiqKbF/WTaLCHxMtvW65MkVwIgw/ia7t3TpXekq8ADq3GkFNyErCH5DoWqUe1TCMvJh
	RzKDqK0j52yMV0FOExP3smOV4jrqbJ9l+LTrmBqORKhiRsQo4P0GXMYnAOyWYZx3A+m+w9Ehyz1
	sZ7weNLyA08RMJ0HmBd/p0P0To2SO6curndRNJGtSVxib3qKgOISWT9dEw7Ewh1bpLw1nl41CQ3
	+ktQ5tD+L2OEZ68Goj2FNocZEhQtSkK/Rxg==
X-Received: by 2002:a05:6402:42c5:b0:6a1:8d1a:816b with SMTP id 4fb4d7f45d1cf-6a4032f4513mr8100157a12.11.1787230582088;
        Thu, 20 Aug 2026 05:56:22 -0700 (PDT)
X-Received: by 2002:a05:6402:42c5:b0:6a1:8d1a:816b with SMTP id 4fb4d7f45d1cf-6a4032f4513mr8100108a12.11.1787230581576;
        Thu, 20 Aug 2026 05:56:21 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:21 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 02/14] ceph: add BLOG deserialization support
Date: Thu, 20 Aug 2026 12:56:05 +0000
Message-Id: <f32b6fb8101ccc3bebe52f3b9001cd53e518064e.1787229471.git.amarkuze@redhat.com>
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

Add blog_des.c implementing the binary record deserialization engine
used by the debugfs read paths.  Supports %d, %i, %u, %o, %x, %X,
%s, %p, %c, and length modifiers (l, ll, h, hh, z).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_des.c | 343 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 343 insertions(+)
 create mode 100644 fs/ceph/blog_des.c

diff --git a/fs/ceph/blog_des.c b/fs/ceph/blog_des.c
new file mode 100644
index 000000000000..1962fafd6fbd
--- /dev/null
+++ b/fs/ceph/blog_des.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Deserialization
+ */
+
+#include "blog_des.h"
+#include "blog.h"
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
+		if ((size_t)ret > *remaining)
+			ret = *remaining;
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
+	/* Payload budget; snprintf() is called with remaining + 1 so the
+	 * last character that still fits is not dropped for the NUL. */
+	size_t remaining = out_size - 1;
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
+		int alt_form = 0;
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
+		/* Skip flags (-+#0 space); remember '#' for hex/octal (P1.10). */
+		while (*fmt_ptr && (*fmt_ptr == '-' || *fmt_ptr == '+' || *fmt_ptr == '#' ||
+				   *fmt_ptr == '0' || *fmt_ptr == ' ')) {
+			if (*fmt_ptr == '#')
+				alt_form = 1;
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
+				ret = snprintf(out_ptr, remaining + 1, "%lld", val);
+			} else if (is_long) {
+				long val;
+
+				if (buf_ptr + sizeof(long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((long *)buf_ptr);
+				buf_ptr += sizeof(long);
+				ret = snprintf(out_ptr, remaining + 1, "%ld", val);
+			} else {
+				int val;
+
+				if (buf_ptr + sizeof(int) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((int *)buf_ptr);
+				buf_ptr += sizeof(int);
+				ret = snprintf(out_ptr, remaining + 1, "%d", val);
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
+				ret = snprintf(out_ptr, remaining + 1, "%llu", val);
+			} else if (is_long) {
+				unsigned long val;
+
+				if (buf_ptr + sizeof(unsigned long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long);
+				ret = snprintf(out_ptr, remaining + 1, "%lu", val);
+			} else {
+				unsigned int val;
+
+				if (buf_ptr + sizeof(unsigned int) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned int *)buf_ptr);
+				buf_ptr += sizeof(unsigned int);
+				ret = snprintf(out_ptr, remaining + 1, "%u", val);
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
+				num_fmt = is_long_long ? (alt_form ? "%#llo" : "%llo") :
+					  is_long ? (alt_form ? "%#lo" : "%lo") :
+					  (alt_form ? "%#o" : "%o");
+			else if (*fmt_ptr == 'x')
+				num_fmt = is_long_long ? (alt_form ? "%#llx" : "%llx") :
+					  is_long ? (alt_form ? "%#lx" : "%lx") :
+					  (alt_form ? "%#x" : "%x");
+			else
+				num_fmt = is_long_long ? (alt_form ? "%#llX" : "%llX") :
+					  is_long ? (alt_form ? "%#lX" : "%lX") :
+					  (alt_form ? "%#X" : "%X");
+
+			if (is_long_long) {
+				unsigned long long val;
+
+				if (buf_ptr + sizeof(unsigned long long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned long long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long long);
+				ret = snprintf(out_ptr, remaining + 1, num_fmt, val);
+			} else if (is_long) {
+				unsigned long val;
+
+				if (buf_ptr + sizeof(unsigned long) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long);
+				ret = snprintf(out_ptr, remaining + 1, num_fmt, val);
+			} else {
+				unsigned int val;
+
+				if (buf_ptr + sizeof(unsigned int) > buf_end)
+					return -EBADMSG;
+				val = get_unaligned((unsigned int *)buf_ptr);
+				buf_ptr += sizeof(unsigned int);
+				ret = snprintf(out_ptr, remaining + 1, num_fmt, val);
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
+			while (fmt_ptr[1] && isalnum(fmt_ptr[1]))
+				fmt_ptr++;
+
+			ret = snprintf(out_ptr, remaining + 1, "%p", ptr);
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

