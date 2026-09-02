Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7A4AA3F2
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366490; cv=none; b=COqMhOktuOktabdaEKVXOwffvq+KMz01H3XHsKSzmRPwUCqcJ43wp4a2HDURs3N7D94GqMKLioSnJuTE1UGd5ncrKHI+Sm8VCXrJxTkioC8IPiqGvMFLK0JLnSJDUFSKAvPVn1tHbwloFnriNbNlD4ZWdvdPAJe/+ia29YUlknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366490; c=relaxed/simple;
	bh=qY+kEul6M2tzYqXfXn+y41rFQiyi2Hlwl7JOyogmcgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sg45emTthHct1uW2bq+iv/IWLgzS8hiwy2EWVyNtalxmM62/mj1HFJ4iVvi8YwsKTRTZEI3Jlo5RDXvUXs/TzCGUFySCvSL4W1f699MHCuORgscc4KzJt05W29WUXU/nddmdjG/8pRIeYjHvjjEDkyqUypawePJP2x/MYd5ehYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2OqNiTU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wg0f5nEd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2OqNiTU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg0f5nEd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
	b=W2OqNiTUhO7yp0rqQl6FaUiuLB/KCTrab/0IZA/hi2f1q8zWhWH1nJQoALah2+tt404I9s
	cc+iS4PkUzr/+Nl6MZ4EpvHuJguPFuDHG0/nJ7KbJuvPTyjnOMS+MiJQVJeqOZ0Sb6OJpg
	US7zXx/J4Tj6Hq98adRQek8/kGv9hCw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563--MXKgwvwP1WAhKa_-zveZg-1; Wed, 02 Sep 2026 12:28:05 -0400
X-MC-Unique: -MXKgwvwP1WAhKa_-zveZg-1
X-Mimecast-MFC-AGG-ID: -MXKgwvwP1WAhKa_-zveZg_1788366484
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2192261d79so122715666b.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366484; x=1788971284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
        b=Wg0f5nEdtq1OAJwVPvaEoEAZ6vektk5Z56KfajJ6JMi+Ne9xXYpvKRuKoCJRvd8EXq
         drG6lTO+nXgG9QPo5b76x2gwrnTRjMLYvk22zcfJcDKRtLwb5FxJthCH+ebJyL7UzqnW
         UO8LcqO7AL1UgapXXOkqQJR6tcKAui9GiqrVkTk0yE5Fkt5DEc2TB9r6mSgCfHJIq9qB
         NOmKiS+zQ/0rQ6MUW4h4ms9w45Bybf74cfYRGu96fDUaEE7RoJ66ASLQ6JhrjdMbThmR
         4v+XPw9qzarNjzH47757fyt6ew6DArr0362Pbt1V0IfytbK353u3BSkWc+AWxRALSdVu
         lK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366484; x=1788971284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
        b=cjhl92KyA7YQfDTGaatL6WUDAdVI0l67y1xxQaiVTVtOYNG3YzZpJSzOUEnVlTWAOl
         ArnscimEJdxFv/9Q5XvGJteWRquCeZUm0x1t+qR6pq/qWBlRkXrN6ocCPmYl74/w8gm9
         QMbU58ri546MzdL7RVf/dsMQvRtb4JdHkE0E7e2bPj6ZniBLkWvaNVzfU60cohfJxlPN
         ZTJ8Z7HtkzhHk9S6EPP8itbEdltK67lcrFEGkOMyjqeaMDRfcndZQRO6t+19v+bq5Ge8
         TpH147G6fZ/fYPqZQV48BRS9REyy+7l0iPBULDVt7wSMGazufmsUQOMw050Nbr2KId0e
         XtKQ==
X-Gm-Message-State: AFuF++muHxsMbR4Lc5Sk/TZZW0uIUJ1ArSOl4LsG3XiFdXgzDKmyywy5
	ZnUrf7IHphaKjJfyhTAZA3PGKk8u7CRX1oWmrZZjgnxi+DjQYAxgsW01TV0XeIU3Kz13g81kn4R
	gxgP/jL4LGxMP7dEkt2EOjODv3N7AsjaHY3CU0uQesgJDQGM9eHlRHQtz/9hlSB8pSZ8Vu6ZabQ
	7r332dRvLcS3CoWxPronUvh1d0at9aCgQVDVOVtfFdqsrUCuslig==
X-Gm-Gg: AYBFou1DUNrLha5RAlq+HA9aSXfBeifzFxhojGMJ3AjkZgABop3X2zWsdnHbc74sr+0
	dE41y/snWShPz+H3hN7qMQD5kXsSIXbSsUcTo08U2Q475QQwcIOxrkBO65vkkwMpC83PcQQ1ef4
	kqKU3cp1b3PiHejeQ9HhfzEZPwmBJpj36Xav1hKd427wb6BatPfFvyx/Mst2tAyNDJx/C58mWLl
	yB3rVOx6BjuqVy13gUnpkU+IIvcdPrfS+Sf83ONUYEjbrvi42sHz7bFnyb8JUycEDMHb15A9UG+
	BRT1IL2lvmVxygkXeuLHDvXkV4heA+XkNpEipV4Zl5EqRvYUdebSavVYLDyJOltqMdzQi5AY/7F
	h5HQ5y/vixmKv2rSujnHs0SjqOcpHyLnXZrUl/3HDIeRcLxM5XbUomVYNmBOFQ6dvbMSvX9MKMY
	GxpdC67tLeuaorqg==
X-Received: by 2002:a17:907:7287:b0:c25:4612:2efd with SMTP id a640c23a62f3a-c25d54546a6mr418716966b.9.1788366484354;
        Wed, 02 Sep 2026 09:28:04 -0700 (PDT)
X-Received: by 2002:a17:907:7287:b0:c25:4612:2efd with SMTP id a640c23a62f3a-c25d54546a6mr418710966b.9.1788366483655;
        Wed, 02 Sep 2026 09:28:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:03 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 02/14] ceph: add BLOG deserialization support
Date: Wed,  2 Sep 2026 16:27:48 +0000
Message-Id: <20260902162800.3197342-3-amarkuze@redhat.com>
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
index 000000000000..772e60c63be1
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
+	*out_ptr = '\0';
+
+	return out_ptr - out;
+}
-- 
2.34.1

