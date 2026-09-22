Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553D3769EB
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085665; cv=none; b=HLxQfnSNX2Zw8pK5Lk+Mf+NvmDSHun9w0q3S/B9dr35xT+qFvXOCDto3SaMVlxCD1qUtcelxEtnOF+sVgpwrDT++SU5jxHg6g/vMDdt4VvkHKfXBQS49VzXFgs7AiTkaAIV95xY7/2qKWgl9ni6dQKv1UVOL67HN0ZMXNJY3hIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085665; c=relaxed/simple;
	bh=rGYZudHnXB2kakW7ng20xVymOZf65arzyn8JpDXsaTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPp0DBtMH2GLhUxmezO6/QD+eXXAwIxU7gPzIdTZssVkivP735QxOQL++bYawMcShVcEgCkB8ByylEWrPxUYREqgRZYKxUXaegO5cLPgBMmHXw9d1Gk6pkCkPJyk/M3UxFFgQ4xB2eYbXFvqA9Dh5bm7t+Kin3X/651/v+27STk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBfZLEqv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrO+ZqwI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBfZLEqv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrO+ZqwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHt/oeY8nlOaXif4+wd1XaEmPdPd8hLUzUlRc8pfOlA=;
	b=RBfZLEqvg1IhT0nwLCcmXXUC0zh1M9N6jNevnPn+pFD5gotQgSKGZ+sCk/7LrdCoIBNSZl
	zNe+caTBh/FCr7Porku/7uRgfMDbB82GFT/FNgKRIlqFSpwPRZwKjFPLOj32O7l4H+SKSa
	VTId4nWCjV0aM3a1L1bgAZecZPmrpIA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-njdOKOBkPm-cxJHr5slgZA-1; Tue, 22 Sep 2026 10:01:00 -0400
X-MC-Unique: njdOKOBkPm-cxJHr5slgZA-1
X-Mimecast-MFC-AGG-ID: njdOKOBkPm-cxJHr5slgZA_1790085660
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a01d1d1b6so621447885a.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085660; x=1790690460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHt/oeY8nlOaXif4+wd1XaEmPdPd8hLUzUlRc8pfOlA=;
        b=YrO+ZqwITG3/Kw6sj1dYaVwbktGrCyz8TkHn3V6I5hrUm605y8EHM8cLD5NXREuNqW
         +Dtho821sz5RFf275fbTu673Dmufy3u9IaZnJbCeRl0EgISjqmLKX9+TMFs0mslul92j
         36tAKnCuZAMpz+chiSlkG9VNBevdhE1bjsfqi3LNOS/Fqq92m6Lwz9ThkBhL3IK01G1p
         JiGo9iVtOZzkPgbrhX8trXNUzzfwJsmljd0cGZXrFRgBoKM3o79n1I9oJZ9X+g7SJdDy
         XE4KgdeQqrcf7ngF9eYkiV6/LqxivN5Of+JYkuKCMGdI2JF/7C6Q+07mibalBvybfWDR
         wDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085660; x=1790690460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHt/oeY8nlOaXif4+wd1XaEmPdPd8hLUzUlRc8pfOlA=;
        b=esHjYkmrxUUIUfcOYFTTUzdE9Aq009K9qMqgMqt7ArEWKbXYULDrXSq91woxPt3uYz
         jItsYqiUKgwS/E6x9ViYlNF6TiaSMhylxYEgfO1HXOm0Qfq1wOMy6sznhaWbrg9Ginca
         grAcEdzaXl9ljqCYrxRSr253aXeDcrGlN8tkNsXSfSb3dyBqgI3/oZuoT7KXSSrXh7gU
         LUqiEjf8qn5Z6RONuduaaRa+0VbjL1wYkRvGNw4d5YAfO3plKLsZNNaYSZvRxbqRVv7K
         doqxxGo1tlZwT16ZTECCsOZGyJ9aVABo7BvsCHDMCHopiO+1GymZVeT0HSFNwA1GsqX/
         aTKA==
X-Gm-Message-State: AFuF++kRvqsiImNRFMlSlDLT+1wKdyOdORKDIB5tIA6ZkcnVAo1oHnui
	iLDc/4nTQnjBdtEbQbfrndoQMcZEVVDdibJ0t5kn7KFP8vKg5jHg4GaMs2YqZQFRjnDTkr2Qolq
	4vs0q/5rwXo9oxEb8MFzk9NRupwTn2Sc2CGqdb/Hea8/Y1pUyRojzBr1esi8PMT32GfmuvCdJe0
	RsxovYOhgY4EHe/6pbjPJlz5Wbc8aAajo825DJiBkw+pC4446y3Q==
X-Gm-Gg: AYBFou12RS992ZEHk1YBwllyHGlomhsB2W6T6ww4VDhqddTRTp8VS4wuUaSh7uzspwp
	uPMIsSwqBkahTuJPRPSuH3LQFGTQlIQfko636BpDEtjZialGTUYMPUG8vHu+xsVU4CmjGg+7Vnq
	crkIXzu2eRMJnIyvX9rap4geIJ7q5M6XqkHP9zZPwGNc7T1xxNYWwH6/70NWdduM7/dW5tsXj35
	3Ih2U68StCzOVH/jO9KIqCykMgCFeBDaG0VmUE42NozI7IBZfdvYz5Y+GlTR2K46uQn0FSq7VvQ
	ylya33Ig7SR0v2WBUgXYdjvxlpGiKrMHWYcvSRxTaQ5ajwcKFCM4JzWueWIl2o3+v5qqI2KVExr
	e93zTNME9EQ24uOfzGl5ggDI9XOcsA268vvO30eFJZWVE2h5HWPT3Buxbt4B79AWxexYPd+nfet
	bIcH2yagFvhk0DJQ==
X-Received: by 2002:a05:620a:2607:b0:939:a0f3:6aef with SMTP id af79cd13be357-93c198c3be6mr371735285a.23.1790085659674;
        Tue, 22 Sep 2026 07:00:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2607:b0:939:a0f3:6aef with SMTP id af79cd13be357-93c198c3be6mr371714985a.23.1790085657235;
        Tue, 22 Sep 2026 07:00:57 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03c47asm150009685a.13.2026.09.22.07.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:00:56 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v6 02/14] ceph: add BLOG deserialization support
Date: Tue, 22 Sep 2026 14:00:35 +0000
Message-Id: <20260922140047.794405-3-amarkuze@redhat.com>
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

Add blog_des.c implementing the binary record deserialization engine
used by the debugfs read paths.  Supports %d, %i, %u, %o, %x, %X,
%s, %p, %c, and length modifiers (l, ll, h, hh, z).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_des.c | 335 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)
 create mode 100644 fs/ceph/blog_des.c

diff --git a/fs/ceph/blog_des.c b/fs/ceph/blog_des.c
new file mode 100644
index 000000000000..b83212dee856
--- /dev/null
+++ b/fs/ceph/blog_des.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BLOG record deserialization.
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
+	while (*fmt_ptr && remaining > 0) {
+		int is_long;
+		int is_long_long;
+		int alt_form = 0;
+		int dyn_width = -1;
+		int dyn_precision = -1;
+
+		if (*fmt_ptr != '%') {
+			*out_ptr++ = *fmt_ptr++;
+			remaining--;
+			continue;
+		}
+
+		fmt_ptr++;
+
+		if (*fmt_ptr == '%') {
+			*out_ptr++ = '%';
+			fmt_ptr++;
+			remaining--;
+			continue;
+		}
+
+		/* Skip flags (-+#0 space); remember '#' for hex/octal. */
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
+				 * boutc does not support %p extensions; call sites
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
+	*out_ptr = '\0';
+
+	return out_ptr - out;
+}
-- 
2.34.1

