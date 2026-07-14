Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF89392C5F
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029909; cv=none; b=q6XzUPhoLl0He85ClspTsGp9e2mg0HaSk1MUFnKzFpaartXeITEhQFS76cmOSWdrhcBpqGk7xHeom36f/C9n5q3xO0wuAjAVoRD393N1C/a0htD0YCxtDndWHGkVnAGl3CSkAItws9T5wwUEekPEw+2GPSKzV981Ca0ZjYJZbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029909; c=relaxed/simple;
	bh=p2+stEBi4BElrza3ht2ZDPtC7TCuwqQDOOPe33VgEbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx5cYchp1gNiVxGEF8SrMWeHRcDkDYQj1+ul50H3imFwhAew9jkJIoiHpCPWhVanlYMOrXipeb6t8j1dViuqysS0lrp6ymgHwyHrHsid4lslsau+GLkbhwRhHZCkH8iy0jYZe+3qUoX0Klft5rxCBsTxgtdZ4FrfemZoJu0mbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9nPdpiy; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9nPdpiy"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92f0b5ed131so134759385a.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029907; x=1784634707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3h+GE7dRUK0jTaidLd+LkoAa9P1Kl0QyikD71h1Zag=;
        b=o9nPdpiyiWXVHL+eDWUnoXmzHcjcAMp5jc7cjAFEfNb9VytbgL2UY0hJ9AUZ4QKvqY
         cXCJB5oXzLiB2NLov8NP1jHW7m+aiy5JKgEkivx830ryj95sieaNbfglAxojSXdqVmZr
         dPsoQ47rHBjEkLKhGuhK79aR3PJfptT3HUpl/Fa56VJk+Bp3tmHk/t28OloJ8+VrVXZ6
         9HvqLb+6seXlOeJR/jnWsRk1sgufNEJQHSJ9JAB7kZ9/xWIgF1h+vRRIDN2WT+2eOVRc
         DMHOpeYu/z7nXyOLov2dh/nFvtIyJJzZTn9qPpVqlsuhay5wBzyWv+UcyPGkg9bCRfS8
         KGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029907; x=1784634707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y3h+GE7dRUK0jTaidLd+LkoAa9P1Kl0QyikD71h1Zag=;
        b=KVANn8oXaFgOaQ7oc8ssZmiUC+7S6ooIlAgcv2rJuY2RRK8Xf78nBknIVgBzGiSi2L
         kvh3pTFOsUYcE+BBVspb8AvFU3m9O1Ex/j5C8x97gcNxi0b2Ewjpm2IP6FRSSXeMoX+K
         dZVhOgnZxYCzpFT/2+/CQrcDz1E8X11OO4yEIjl2F3XCOOO97D6pdTyUafM3ZDR3IEGH
         xXNRq5uxfIvdvth4qCW4Emn5rElAVMWdE3bSDpnVk+SAmR+g6ZMI625bVFCs0UNOyTCA
         I827bwPvCN65uQWCymBf/bIy5/STxy5NpS9zOEPOkzXUsgZnJnXS6GTeb56s7FG8gx5y
         RkJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlPn1Gc5PEYPLd3uyOCeM/1vATgb2pGUb78c3ypIwDFd0taRe8PVQD49Oc78iIHFq9b+1c9PT2AKQV@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8JnZ4VZyPs6ppkBgKoC2tXb6IDh0I5vyXt1y9CREa6xA+q1Y
	5iARE9Wx9gOPA/SWBhMoq+RihPH6Q3Mrf2noN7f+8fiWiIJUTNcJpuN/
X-Gm-Gg: AfdE7ckqZvjnvIeAT3HfL+AMBfHgsxAzLHcmfmyKoF0MRMeU8O75BOOUOLjWk+1UrJZ
	TBBxlXMclrt6n7h//CKOlSHzwRI9Jcj80kRp1qh28DE0vD7qAYClfqFg8dAkw+Inq31PBTDhXDH
	MPhzQaC3fmCPmt5po9EdU3i7A2jQkK1umXsPAyYqFwusjG+gJNbSPxTd/JHdl1jmbtJFPXmqLFG
	9f55aBMxL0f6zJbinhQ1X7gETLGwfo1H9vH5umIuxcZh3J9Sl9A9VxwDysXhl37buiqlWEgL4rL
	EnbOzXwELeyfs54IKEbOrg+QJGl/O4h9UTMuJ+8AF24NDBUcAVvB+hInvVVoH3fVo2f5Mb6hYlm
	oudzBX6GQymNvYvuuwxd2W1zx9hcdYYBZEp0AIEKxiPmjoNCQB4/PVOk8x7+2S6OpDDJOoyH8/E
	KCp6zxcTTs407Ekr/0MpKUy0BjufjVLwSjzuJrw0ASYClsh90Ig736wQyW1VK/xueFPoW7u0v5g
	i6rYf2eHg==
X-Received: by 2002:a05:620a:a1c5:b0:92b:6805:91bc with SMTP id af79cd13be357-92ef2c83ec3mr1042554585a.68.1784029907021;
        Tue, 14 Jul 2026 04:51:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1479415585a.46.2026.07.14.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:51:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] libceph: add KUnit coverage for OSD sparse-read extent validation
Date: Tue, 14 Jul 2026 07:51:40 -0400
Message-ID: <20260714115141.3768034-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115141.3768034-1-michael.bommarito@gmail.com>
References: <20260714115141.3768034-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add KUnit coverage for the sparse-read extent-map validation added by the
previous patch. The tests drive the real osd_sparse_read() state machine
over a synthesized OSD reply (no OSD or network): an in-range single
extent is accepted and advances the cursor, and an extent whose offset
lies outside the original request range is rejected with -EREMOTEIO before
the message-data cursor is advanced.

The suite is included from osd_client.c so it can exercise the static
sparse-read parser and cursor-advance helpers without exporting test-only
symbols, guarded by CONFIG_CEPH_LIB_KUNIT_TEST.

Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ceph/Kconfig            |  12 +++
 net/ceph/osd_client-kunit.c | 146 ++++++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c       |   4 +
 3 files changed, 162 insertions(+)
 create mode 100644 net/ceph/osd_client-kunit.c

diff --git a/net/ceph/Kconfig b/net/ceph/Kconfig
index 7e2528cde4b94..6b78fe4a0f8a4 100644
--- a/net/ceph/Kconfig
+++ b/net/ceph/Kconfig
@@ -45,3 +45,15 @@ config CEPH_LIB_USE_DNS_RESOLVER
 	  Documentation/networking/dns_resolver.rst
 
 	  If unsure, say N.
+
+config CEPH_LIB_KUNIT_TEST
+	bool "KUnit tests for the Ceph core library" if !KUNIT_ALL_TESTS
+	depends on CEPH_LIB && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit coverage for selected Ceph core-library parser
+	  and state-machine helpers. The tests exercise internal libceph
+	  behavior with synthesized state and are intended for developer
+	  validation rather than production systems.
+
+	  If unsure, say N.
diff --git a/net/ceph/osd_client-kunit.c b/net/ceph/osd_client-kunit.c
new file mode 100644
index 0000000000000..713f24675f68f
--- /dev/null
+++ b/net/ceph/osd_client-kunit.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit coverage for net/ceph/osd_client.c internals.
+ *
+ * Included from osd_client.c so the test can drive the real static sparse-read
+ * parser and cursor-advance helper without exporting test-only symbols.
+ */
+
+#include <kunit/test.h>
+
+struct ceph_osd_sparse_read_test {
+	struct ceph_osd osd;
+	struct ceph_connection con;
+	struct ceph_msg *msg;
+	struct ceph_msg_data_cursor cursor;
+	struct ceph_osd_request *req;
+	struct page **pages;
+	struct page *page;
+};
+
+static int ceph_osd_sparse_read_test_init(struct kunit *test)
+{
+	struct ceph_osd_sparse_read_test *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->req = kunit_kzalloc(test, struct_size(ctx->req, r_ops, 1),
+				 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->req);
+
+	ctx->pages = kunit_kcalloc(test, 1, sizeof(*ctx->pages), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->pages);
+
+	ctx->page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->page);
+	ctx->pages[0] = ctx->page;
+
+	ctx->msg = ceph_msg_new2(CEPH_MSG_OSD_OPREPLY, 0, 1, GFP_KERNEL, true);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->msg);
+
+	osd_init(&ctx->osd);
+	ctx->osd.o_sparse_op_idx = -1;
+	ceph_init_sparse_read(&ctx->osd.o_sparse_read);
+
+	request_init(ctx->req);
+	ctx->req->r_tid = 1;
+	ctx->req->r_num_ops = 1;
+	osd_req_op_extent_init(ctx->req, 0, CEPH_OSD_OP_SPARSE_READ,
+			       0, PAGE_SIZE, 0, 0);
+	KUNIT_ASSERT_EQ(test, ctx->req->r_ops[0].op, CEPH_OSD_OP_SPARSE_READ);
+
+	insert_request(&ctx->osd.o_requests, ctx->req);
+
+	ctx->msg->hdr.tid = cpu_to_le64(ctx->req->r_tid);
+	ceph_msg_data_add_pages(ctx->msg, ctx->pages, PAGE_SIZE, 0, false);
+	ceph_msg_data_cursor_init(&ctx->cursor, ctx->msg, PAGE_SIZE);
+
+	ctx->con.private = &ctx->osd;
+	ctx->con.in_msg = ctx->msg;
+
+	test->priv = ctx;
+	return 0;
+}
+
+static void ceph_osd_sparse_read_test_exit(struct kunit *test)
+{
+	struct ceph_osd_sparse_read_test *ctx = test->priv;
+
+	if (!ctx)
+		return;
+
+	if (ctx->req && !RB_EMPTY_NODE(&ctx->req->r_node))
+		erase_request(&ctx->osd.o_requests, ctx->req);
+	ceph_init_sparse_read(&ctx->osd.o_sparse_read);
+	if (ctx->msg)
+		ceph_msg_put(ctx->msg);
+	if (ctx->page)
+		__free_page(ctx->page);
+}
+
+static int ceph_osd_sparse_read_feed_one_extent(struct kunit *test,
+						u64 off, u64 len, u32 datalen)
+{
+	struct ceph_osd_sparse_read_test *ctx = test->priv;
+	struct ceph_sparse_read *sr = &ctx->osd.o_sparse_read;
+	char *buf = NULL;
+	int ret;
+
+	ret = osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
+	KUNIT_ASSERT_EQ(test, ret, (int)sizeof(sr->sr_count));
+	KUNIT_ASSERT_PTR_EQ(test, buf, (char *)&sr->sr_count);
+
+	sr->sr_count = (__force u32)cpu_to_le32(1);
+	ret = osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
+	KUNIT_ASSERT_EQ(test, ret, (int)sizeof(*sr->sr_extent));
+	KUNIT_ASSERT_NOT_NULL(test, sr->sr_extent);
+	KUNIT_ASSERT_PTR_EQ(test, buf, (char *)sr->sr_extent);
+
+	sr->sr_extent[0].off = (__force u64)cpu_to_le64(off);
+	sr->sr_extent[0].len = (__force u64)cpu_to_le64(len);
+	ret = osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
+	KUNIT_ASSERT_EQ(test, ret, (int)sizeof(sr->sr_datalen));
+	KUNIT_ASSERT_PTR_EQ(test, buf, (char *)&sr->sr_datalen);
+
+	sr->sr_datalen = (__force u32)cpu_to_le32(datalen);
+	return osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
+}
+
+static void ceph_osd_sparse_read_in_range_extent(struct kunit *test)
+{
+	struct ceph_osd_sparse_read_test *ctx = test->priv;
+	struct ceph_sparse_read *sr = &ctx->osd.o_sparse_read;
+	int ret;
+
+	ret = ceph_osd_sparse_read_feed_one_extent(test, 0, 16, 16);
+
+	KUNIT_EXPECT_EQ(test, ret, 16);
+	KUNIT_EXPECT_EQ(test, sr->sr_pos, 16);
+	KUNIT_EXPECT_EQ(test, ctx->cursor.sr_resid, 16);
+	KUNIT_EXPECT_EQ(test, ctx->cursor.resid, PAGE_SIZE);
+}
+
+static void ceph_osd_sparse_read_rejects_out_of_range_extent(struct kunit *test)
+{
+	int ret;
+
+	ret = ceph_osd_sparse_read_feed_one_extent(test, PAGE_SIZE + 16, 16, 16);
+
+	KUNIT_EXPECT_EQ(test, ret, -EREMOTEIO);
+}
+
+static struct kunit_case ceph_osd_sparse_read_test_cases[] = {
+	KUNIT_CASE(ceph_osd_sparse_read_in_range_extent),
+	KUNIT_CASE(ceph_osd_sparse_read_rejects_out_of_range_extent),
+	{}
+};
+
+static struct kunit_suite ceph_osd_sparse_read_test_suite = {
+	.name = "ceph_osd_sparse_read",
+	.init = ceph_osd_sparse_read_test_init,
+	.exit = ceph_osd_sparse_read_test_exit,
+	.test_cases = ceph_osd_sparse_read_test_cases,
+};
+
+kunit_test_suite(ceph_osd_sparse_read_test_suite);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 76ba3abdad9b1..b9ab9608ec88e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5951,3 +5951,7 @@ static const struct ceph_connection_operations osd_con_ops = {
 	.handle_auth_done = osd_handle_auth_done,
 	.handle_auth_bad_method = osd_handle_auth_bad_method,
 };
+
+#ifdef CONFIG_CEPH_LIB_KUNIT_TEST
+#include "osd_client-kunit.c"
+#endif
-- 
2.53.0

