Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05F559313
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958468; cv=none; b=TUj/UOcWyLn2vYOg4sXQ59K6jh+lj84ICJyl/m6N82qk6lBh4qMOTf0O4E2rguWPCtHGX8hSJ6tQcFswjTpD68c/X8avVg5VpUH5/RDxaviHF1TGezz5Uvlgz+lZuqiaLNWH7BnkOqhVN3w5QapIpr0DPEuWlGD9IxTnsiWKNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958468; c=relaxed/simple;
	bh=qY+kEul6M2tzYqXfXn+y41rFQiyi2Hlwl7JOyogmcgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mY46o2RFkEM61EI0EXhRd0RhaHei6A5KTtL7wnCFtMFyIBCYBMTnA41Quku3kamTmxFqCmqZrxfqjt/isY1Wzz23I8GPoZf5iPXxisYjJLZfzo7ZPXjRLcSbq7nOzjiRUgzoyRXIXrKuJ0Q+EH5+M7Qt8ssNRkTdj0d7hPh1nLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwzjCgeY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzz/D9s3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwzjCgeY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzz/D9s3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788958465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
	b=GwzjCgeYSGyEGwiF+kOH6UQ5D6OojmXaGjTq91armFZaah0cgPSffa2c35duiw72DdB2Pc
	/abmv0wf7MRHu8RVXLgjHdCvJo7nSay5UqqimhUXFU9Oh6SZtbgsWQoR7vaxP25+tSYj3J
	oKe/CWlczIezg3c9QkXbRdmiiVdVV4M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-xAlF9Ex3NMSDztwoN2SIdQ-1; Wed, 09 Sep 2026 08:54:23 -0400
X-MC-Unique: xAlF9Ex3NMSDztwoN2SIdQ-1
X-Mimecast-MFC-AGG-ID: xAlF9Ex3NMSDztwoN2SIdQ_1788958463
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e52306621so760779385a.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788958463; x=1789563263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
        b=bzz/D9s3hokhUhDPcqr3syGkppplKTtbUR2fHXB2ywviOc1C5/ygaAjLEi7kBrr8HD
         jFXHw7KBgupdrshXwCbnqvKXPw4FSDlR/WbNZpIUzcKqaXPN1TPPJlVKsFM/2ftDl7/C
         e5Q5M3k+EGsahmVicnPfhlgpcKt9D4OKrlbcqvgtl5I2hfY+SUEe0shcgq3pOc2GxJhb
         l7uDBWWtvF1PbIjD+rG6lMmyaxyg0FpCikQiZwYlSA2S9yGbqMA7zOvoEfZU1uXrmVU2
         sKXi1sLeo6Et8kNNAtX8kYGwQWgi7jALuc6pCifzMaCWEs9rkQIqkekknPZq29ncQzWF
         yBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958463; x=1789563263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
        b=XR/FciXqVrhLOuGlTpG9IBXHcbeKM0fwZWNdozCzoD+vp1be/ptYqG9W7iPawAzRmL
         HgyuE5ZIyRGl7dBr9JK9pmWqzoNjTAPbo9JFJw9VmOXQKakWw4gwcU7nrddDk31267Vd
         qreuctd7RTB4aPFpgu8pWXMQoHVd4CG2WwAhlqt1QLp1zY3wxPG7hbAlvtJbYnPMtFTs
         7s6EcYrBa1CMxdPZICxm3f3NXaMhxOlmDZkigvW6QeJayL5B0NCSrnNUAIGLvfwpU9B8
         fj77Dgv+19iaIbP7A7JdqS44tC8pMAqYaphtonNVGVr4Iamx7iCi8VgvfE5bR/wPzv0J
         dK7A==
X-Gm-Message-State: AFuF++k8pNf5EnLrbuEv0/4KEjNRj/cBhsPg0uXSOTVHqCmwFnLR6RqF
	ikv08iFNmDqpQp3kptgsQ53J1pe9YK2/rE3/qqr8GJMf2L4tGbp1hBqZ+eIxpw/2Vwf0RwkW2bs
	GPynQ73u/cFeBYq+uYWRPK6RnGAsIqRyFHcH2PovquI2ZfX6cpw2LWvhjF6EieOhMKZDPUf+ytt
	egE1HSy+b6lKymQgl4xyHGok6x93Js4oKScukiaenVLFqYguOgZA==
X-Gm-Gg: AYBFou2gQpnvn89uYZW2HFO8yq6yW9sLk+5tjWkcP/bDvz/OyxTEBCk1TpqdAGKlt4+
	pZIDrGNitB7mDe3bySw1rQyn+7GZF+6zkA+/wsJb8meVmXHUCFGXaVZlvgqkCT5EsGWZVp29QZD
	v83wjZjU7sHrcT1uLiZorxSBBC11ZBUwpYSgzsoht8xE7/bLVqA/JdsZkqnP7kNL5wxBx8l6hjZ
	lTUzAJNE5uhmvMY3eMPmgQrScOaOGLAdtKHLR9/SAi4GxFYbw0t+WOsXzknxLKFmyz8un8UYW38
	gyO5DQ23wTkpRmpui5gN4KBSWM7LWIT8gzZ9OTX1faprW6azVaMsADAb6T7FLM4nqkdmtvqIT8S
	ghI/3bOnU5AEOuqm7ARBonZzXNVWvXb4ZuX9XzofL2Z6MMHdAKhTEqX8d/2S00O/X+N0dszuUId
	E98OyFDYVy947B+w==
X-Received: by 2002:a05:620a:bc7:b0:939:8c80:669 with SMTP id af79cd13be357-939d4a5c734mr112709285a.42.1788958463102;
        Wed, 09 Sep 2026 05:54:23 -0700 (PDT)
X-Received: by 2002:a05:620a:bc7:b0:939:8c80:669 with SMTP id af79cd13be357-939d4a5c734mr112699985a.42.1788958462384;
        Wed, 09 Sep 2026 05:54:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm1117852185a.29.2026.09.09.05.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:54:21 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v5 02/14] ceph: add BLOG deserialization support
Date: Wed,  9 Sep 2026 12:54:04 +0000
Message-Id: <20260909125416.3969532-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909125416.3969532-1-amarkuze@redhat.com>
References: <20260909125416.3969532-1-amarkuze@redhat.com>
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

