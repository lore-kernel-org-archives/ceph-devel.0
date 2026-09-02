Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64B3AA4E4
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365059; cv=none; b=q2Rz9uL3kXGSYH3RbsCIIQOLVUBvvDqQ/ti2GSr6JHUePCFuZUeiNXv2TKmdVvGOc0BzjQyjnguKKKHalWKUBbzuhsscatujfXjUq6cPLqKyhgcU/puuAd8pQ84tmc6kkRbtGN7SRWDsCHG1aioozjVMxrw7pTF2LOCWE6qp3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365059; c=relaxed/simple;
	bh=qY+kEul6M2tzYqXfXn+y41rFQiyi2Hlwl7JOyogmcgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpTCFjamv/tJQErMW8YlXY3QcIemCXrgIYLcl/WgVj/zMvdjDIzvkfZUoh8I2Z5Yh5eXFHGKGTa4fGQ9g0cXzUxvnxqc0kI7kER32YU8V3jxVPPlWbK8r3U0FeMHP2YiMRO8FnKxXGF5ZCVFMIRWuJAHz0/O5+09Yx8/TsWZuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eimMAmRn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdoricwp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eimMAmRn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdoricwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788365055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
	b=eimMAmRnGFRjwwYosJoinMUH1z+a3hH3FivIla1F9HxDa7lcxI4nEPLcOT6ZeTg2aGZPK3
	UdTDLyL6qIR9SqxxT5a3QD12dKvibvZiGaQ6VM+KPmjIPgMow6qefL3OYvjUpgAQtezbbW
	yEIZkGXgDt9RCLTUwzQME4s27St0RCI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-I-gMipUXMMS_lilqXGb5vQ-1; Wed, 02 Sep 2026 12:04:14 -0400
X-MC-Unique: I-gMipUXMMS_lilqXGb5vQ-1
X-Mimecast-MFC-AGG-ID: I-gMipUXMMS_lilqXGb5vQ_1788365053
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1c4715cf0eso95331566b.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788365053; x=1788969853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
        b=hdoricwpyYdHUMccg6ohp+c2lMve9mnqYPBgiyz+VmvWsB+LEqSDm3O3FavRc0ASVP
         L9JhGEAiEkGj3A1X09sOgykTd/+RpzQ7SCW3VbrfzxEjW4QvFkumNeKgkTxQqIBGCwGD
         OCWISjrcKEuZMTO5EtDgth3Z5BFnJb/7/fRcc04Kc9SSfRk+Gxod88YYUoKtOZykIe0K
         0nMJsTpN2lRjN8xcwUxNxRnqxMDR6Ikz2T+ZEPUnTNK/rQ3OTDHl9Rbq4uIyyDjDNd2l
         hjPTu4Gw37D5CqgS3/gwqCsvVeDmq7M9QTvshaz58AU1Rzmx2PdrqLfxiVGW59Cl4BiN
         eHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365053; x=1788969853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dc0OLQo8HrTBQZG+oYdeLYkHl2/FElZFnzDfd0zQQSQ=;
        b=IMAvr8TjWz8AgD2lREdH1VZpVhkjawahDjx/QTFlli3LB+asTb1emO1HgGcyASg6AL
         HwiDMJT10UgcHLqxkDnm3t7eA5JfIHIqQ6b+pU4WZF89Bu65xzbx/d09JRpLm3ZkiFD4
         4vJ32SEx96PVxJ8Fu+TBG+Sa82Bj48TCXLODhpEMvJ/m7GIR3E8JpU270sTFsKNWDk9C
         NOldcGOCCgUOAQQndzjZVzxeGu8ACG7mWuljHHBPDkym1mk31EjFu2mEQV2I7/0HlxzQ
         t/TAaWuXDv6klLyeCby8+DGbpSUOKbe3URu3rkn9AHZ1JcyjL2NOH1qOhX5PNwtoaoI7
         LSvg==
X-Gm-Message-State: AFuF++nbK/G/CwiQ4lBG/MAymQLbTzGI/lqxKZwn7O2QJ06GQJEOHjWu
	iaCYFrMBjfbkwXVlDvxi4eV4YotGM4qZ543ZLgYwfLRzjdo1187zL2yZZvkRHbiNiB8esLHNNK3
	tTOVNpXeukPXmCw1a38oNeWFK+O+tjPlkfrMwFEdhi8YdjZgywpyeV3n39V5e1RWfRHDJG5Z+Cm
	jvSk/CviAUjEM+qC1j0uyK7ZCz57z8aEMc43/k9oQDu9jdjCo=
X-Gm-Gg: AYBFou1GQ/Dfm6er0kwGStwsPKDhh/ZXzwOwI9WIgshXuZM9S7FEDEw2KFl7K5JwJFT
	Fji+iFZR8V/k+nYZFZbt8K+oIOMfidyprn0pGj33yUh984O//8Cycls5W3Pmx6Z5cKRvnvC+r4N
	KRmkvPBJVLAwtr3RVgFz18UwzBnzEzcHQimIfo0KvV/iw6EYYYx/LOznD05r5pHhf31QdYgZ2NH
	NHG6mhNx6IEWp0QBCTCpOyyaHc105cMW2BqzBeZcQbtjNAEZs5uSZWZV4FoUx9jiuubNk+5MFx+
	Co/RgGRO1nFn99eld3Pk76UqdhQgnOAHPrp0mZzqEi5g/UYNvAq2+ApZDrb0G/uWEXMEkL4QIfL
	VllnnNkM569yKuQ5irlLwHnsg9uHgkrASiz417hxesZvS3wRmh6MdwAR6cFEtiy39IJaNyeoycn
	PWEgDLuhPh7gwPvA==
X-Received: by 2002:a17:907:97cd:b0:c25:4cff:5d01 with SMTP id a640c23a62f3a-c25d54f7e85mr359295766b.18.1788365052852;
        Wed, 02 Sep 2026 09:04:12 -0700 (PDT)
X-Received: by 2002:a17:907:97cd:b0:c25:4cff:5d01 with SMTP id a640c23a62f3a-c25d54f7e85mr359289066b.18.1788365052351;
        Wed, 02 Sep 2026 09:04:12 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7108sm165874566b.10.2026.09.02.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:04:11 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 02/14] ceph: add BLOG deserialization support
Date: Wed,  2 Sep 2026 16:03:55 +0000
Message-Id: <20260902160407.3196013-3-amarkuze@redhat.com>
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

