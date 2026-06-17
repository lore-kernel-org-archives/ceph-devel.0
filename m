Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E744E021
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708404; cv=none; b=SWHAV+8d3Zb4jwth8yuYI+RWJbIHVc0eGZQREAQdBhVo6WY1OVdAOxS4pzhxN1Fm33dMVabAn0WlKjFGBVePWb2yGEtjXMS2wnlL8Qe93kwQRaTsaVCqTHnIHdiyuRKrBCNbG4IStT6M+jF/s6DYnvGn+9cCPQ3Z5G2e+jLrzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708404; c=relaxed/simple;
	bh=BDR+k3FnpTUvjtEwTlqpw4II27fS9PeaTURMETJl5+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhVtrPcV/ysBrqiX9MaN+uns5xbmlvD8hA84lBOJR0OvS7d4g4iuJt95rTbqN5y+PgLxLFfyqrj6Qc0+eEHOTOGJ4qsvCKh3kgIHSHxLcDpWuVg2My2XX0IHlKSYUXbUAlnmg8UvG1f4MlM5rmjtgyTVUpIw1Pfi6T7bX+qUXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUvM1Lzq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sF+uzOUQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUvM1Lzq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sF+uzOUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzFQyhRQ+rWkiR2RH4qrP7Bu7RPE2wGF2f7aNAkrXWM=;
	b=QUvM1Lzq+5mX8DBJDRSKoNe/+Hw9BwWtnrP0RgHidSWRM5ZV177NY/bbj91qcr3ihkzWLd
	fKLpd/bKw91QubIoDx5pSN0W74RmzV6owDuHiGA8o1dlmCrJkZE6VNJU+VKt6wT2oeRs+h
	tzdFKoGcUz30mmSAHhCjJCTxdfIGTHw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-ONleGGCPOAOiTH8gzZALDg-1; Wed, 17 Jun 2026 11:00:00 -0400
X-MC-Unique: ONleGGCPOAOiTH8gzZALDg-1
X-Mimecast-MFC-AGG-ID: ONleGGCPOAOiTH8gzZALDg_1781708399
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6d78299e9so11916035a34.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708399; x=1782313199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzFQyhRQ+rWkiR2RH4qrP7Bu7RPE2wGF2f7aNAkrXWM=;
        b=sF+uzOUQw1vUv3emRJgDhL6b/wFUgezpkjC3Bl6WvlL/fK2y4Xy8CzAUR34l0aS7AV
         OofmKBMNVPc9HZWdN6d1lV9VZjYYYnELzjzXbMTE9aKdPIsoI/Y39a+rc3ztCqs5xfsk
         hdLShk83qYR4EmZhQAs0qFBu8IU3LvHMSW7xImzTzxUi+LFgmE3v6vpmoHohLyxWD/d5
         SIwZzs8DilrnlkEOdqGPAoIwbt9y5N+4dSH4IsWwgVLKDKVSpdshiu8pH/uD15nAkisx
         mZ5rspQp4lkGVHdwOlXaUJ0QuPFeuY4tC2y4fQ8PTz3cEGSQAZpvrjhbmdjFDWiLelJJ
         vtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708399; x=1782313199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzFQyhRQ+rWkiR2RH4qrP7Bu7RPE2wGF2f7aNAkrXWM=;
        b=Bskx92tJx5JzZA62gTx+gRURYfkIAx7tXaaaVSx6se4AaGm1NMyWJuPtaGyJoyb2TX
         +67IZ5sjRnwJgPF1YVECixCHzpmq4zXDCM3g5rVR0hjZRjQ3lGCXfwwZUaL3Ya64N8R7
         AR5xlp+WCW7ZlI3clDNbHhPsUN1T4tlcH5gKnwi2c0FpweMTMjz8e+wZQiqey3rzGeih
         qhVTmbM/uoLi85eE9+GnFEG/a8DdE8kURhuBlpHSLvRlTgMHWn4SxXzqdD+tAXhMOAPo
         e+WLJyKlY5ckAnyqgFD1tv2llDe5QMiqTbsjFcDxM7GbeJ4EeJg0lKVQYWnA5raipFYf
         U6mw==
X-Gm-Message-State: AOJu0Yy39yObnE0ioaR5eUGD0tk1nULMPapy56tLJ4O1rKE/MxpnO1te
	1KjZtktV+u9/rN5be5UsU5eEbaHkQcRYlTmDC+IyP6aWjKTq5DceaSdApcEf9XkhmdKBU47oEJ2
	c86DueNO0w7zkMXrnyHQ+oldwhawshucGlc1R7NGjPJ0KljrPIiBO68VQle8K4tpptcZzHZ2kje
	oGZa7ASetQ9d/dW3jdnMqivU/RjmMf5Fy6NcrcJ5rvkyttOIQN4w==
X-Gm-Gg: Acq92OFTDOTCxXW63Q9+XTAU86eTo0J2uY2n5yUVpxIpWCmnIfDCKaYiXH8wzcX38/J
	/edGxKA+6Z/jAw8tVb7ujl9kEFQ+TKJGcBFDXY2JSif3tSt4fp8cRoxDrd3sx4Hd5mH9LwD0wId
	R3l9RKNZbJ4L1yKM6YLYWHBec9xHRbUktZUCxt82jk265tf0UhugFF0+6gJ0HiiHd4pq52Gk4F6
	IUb9knBdC06OHlynpnV74d1nGkIF4QBnNlLCJwdnw7CvfbSwFIW9uuwb2SgghmJvYiL2TZrz084
	waJLf13GpJEu4qdWVB9O80YYfhlS3uTHyik5cvlAsr+TNgUk1i1CXIjXUJeDJba7u4l2+wvCMpD
	6dZ7Dc/ZaZqcZbulsSyIx/h8IFbl4/OyLleMO+PGZ24RW
X-Received: by 2002:a05:6830:25d0:b0:7e6:d0ef:e5b3 with SMTP id 46e09a7af769-7e90b390475mr3880690a34.14.1781708399072;
        Wed, 17 Jun 2026 07:59:59 -0700 (PDT)
X-Received: by 2002:a05:6830:25d0:b0:7e6:d0ef:e5b3 with SMTP id 46e09a7af769-7e90b390475mr3880663a34.14.1781708398425;
        Wed, 17 Jun 2026 07:59:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:59:58 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 02/15] ceph: add BLOG deserialization support
Date: Wed, 17 Jun 2026 14:59:32 +0000
Message-Id: <20260617145945.1912736-3-amarkuze@redhat.com>
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

Add blog_des.c implementing the binary record deserialization engine
used by the debugfs read paths.  Supports %d, %i, %u, %o, %x, %X,
%s, %p, %c, and length modifiers (l, ll, h, hh, z).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_des.c | 342 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)
 create mode 100644 fs/ceph/blog_des.c

diff --git a/fs/ceph/blog_des.c b/fs/ceph/blog_des.c
new file mode 100644
index 000000000000..40cef157b888
--- /dev/null
+++ b/fs/ceph/blog_des.c
@@ -0,0 +1,342 @@
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
+		pr_err("blog_des_reconstruct: invalid params fmt=%p buffer=%p out=%p out_size=%zu\n",
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
+				return -EFAULT;
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
+					return -EFAULT;
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
+				pr_err("blog_des_reconstruct: string arg %zu overruns buffer (no space)\n",
+				       arg_count);
+				return -EFAULT;
+			}
+
+			str = buf_ptr;
+			max_scan_len = buf_end - buf_ptr;
+
+			str_len = strnlen(str, max_scan_len);
+			if (str_len == max_scan_len && str[str_len - 1] != '\0') {
+				pr_err("blog_des_reconstruct: unterminated string at arg %zu (fmt=%s)\n",
+				       arg_count, fmt);
+				return -EFAULT;
+			}
+
+			buf_ptr += round_up(str_len + 1, 4);
+			if (buf_ptr > buf_end) {
+				pr_err("blog_des_reconstruct: string arg %zu overruns buffer after copy (fmt=%s)\n",
+				       arg_count, fmt);
+				return -EFAULT;
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
+					return -EFAULT;
+				val = get_unaligned((long long *)buf_ptr);
+				buf_ptr += sizeof(long long);
+				ret = snprintf(out_ptr, remaining, "%lld", val);
+			} else if (is_long) {
+				long val;
+
+				if (buf_ptr + sizeof(long) > buf_end)
+					return -EFAULT;
+				val = get_unaligned((long *)buf_ptr);
+				buf_ptr += sizeof(long);
+				ret = snprintf(out_ptr, remaining, "%ld", val);
+			} else {
+				int val;
+
+				if (buf_ptr + sizeof(int) > buf_end)
+					return -EFAULT;
+				val = get_unaligned((int *)buf_ptr);
+				buf_ptr += sizeof(int);
+				ret = snprintf(out_ptr, remaining, "%d", val);
+			}
+			if (ret > 0) {
+				if (ret > remaining)
+					ret = remaining;
+				out_ptr += ret;
+				remaining -= ret;
+			}
+			break;
+		}
+		case 'u': {
+			if (is_long_long) {
+				unsigned long long val;
+
+				if (buf_ptr + sizeof(unsigned long long) > buf_end)
+					return -EFAULT;
+				val = get_unaligned((unsigned long long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long long);
+				ret = snprintf(out_ptr, remaining, "%llu", val);
+			} else if (is_long) {
+				unsigned long val;
+
+				if (buf_ptr + sizeof(unsigned long) > buf_end)
+					return -EFAULT;
+				val = get_unaligned((unsigned long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long);
+				ret = snprintf(out_ptr, remaining, "%lu", val);
+			} else {
+				unsigned int val;
+
+				if (buf_ptr + sizeof(unsigned int) > buf_end)
+					return -EFAULT;
+				val = get_unaligned((unsigned int *)buf_ptr);
+				buf_ptr += sizeof(unsigned int);
+				ret = snprintf(out_ptr, remaining, "%u", val);
+			}
+			if (ret > 0) {
+				if (ret > remaining)
+					ret = remaining;
+				out_ptr += ret;
+				remaining -= ret;
+			}
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
+					return -EFAULT;
+				val = get_unaligned((unsigned long long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long long);
+				ret = snprintf(out_ptr, remaining, num_fmt, val);
+			} else if (is_long) {
+				unsigned long val;
+
+				if (buf_ptr + sizeof(unsigned long) > buf_end)
+					return -EFAULT;
+				val = get_unaligned((unsigned long *)buf_ptr);
+				buf_ptr += sizeof(unsigned long);
+				ret = snprintf(out_ptr, remaining, num_fmt, val);
+			} else {
+				unsigned int val;
+
+				if (buf_ptr + sizeof(unsigned int) > buf_end)
+					return -EFAULT;
+				val = get_unaligned((unsigned int *)buf_ptr);
+				buf_ptr += sizeof(unsigned int);
+				ret = snprintf(out_ptr, remaining, num_fmt, val);
+			}
+			if (ret > 0) {
+				if (ret > remaining)
+					ret = remaining;
+				out_ptr += ret;
+				remaining -= ret;
+			}
+			break;
+		}
+		case 'p': {
+			void *ptr;
+
+			if (buf_ptr + sizeof(void *) > buf_end)
+				return -EFAULT;
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
+			if (ret > 0) {
+				if (ret > remaining)
+					ret = remaining;
+				out_ptr += ret;
+				remaining -= ret;
+			}
+			break;
+		}
+		case 'c': {
+			char val;
+
+			if (buf_ptr + sizeof(int) > buf_end)
+				return -EFAULT;
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
+			pr_err("%s: unsupported format specifier '%%%c' at argument %zu\n",
+			       __func__, *fmt_ptr, arg_count);
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

