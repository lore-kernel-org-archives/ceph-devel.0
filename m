From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH RFC 2/6] ceph: add start/finish encoding helpers
Date: Tue, 30 Jun 2015 13:27:57 -0700
Message-ID: <8aad09e3d9015854ddfd1c4a65febd2142238a88.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbbF3U35 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 16:29:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id ECDA0371B58
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 20:29:56 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5UKTrtj018417
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 16:29:56 -0400
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch adds helpers to encode/decode the starting blocks
locking code. They are the equivalent of ENCODE_START and
DECODE_START_LEGACY_COMPAT_LEN in the userspace ceph code.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
[djf: added fixup from mailing list]
Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/decode.h | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index b55c7fd..c81f096 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -217,6 +217,61 @@ static inline void ceph_encode_string(void **p, void *end,
 	*p += len;
 }
 
+/*
+ * version and length starting block encoders/decoders
+ */
+
+/* current code version (u8) + compat code version (u8) + len of struct (u32) */
+#define CEPH_ENCODING_START_BLK_LEN 6
+
+/**
+ * ceph_start_encoding - start encoding block
+ * @p: buffer to encode data in
+ * @curr_ver: current (code) version of the encoding
+ * @compat_ver: oldest code version that can decode it
+ * @len: length of data that will be encoded in buffer
+ */
+static inline void ceph_start_encoding(void **p, u8 curr_ver, u8 compat_ver,
+				       u32 len)
+{
+	ceph_encode_8(p, curr_ver);
+	ceph_encode_8(p, compat_ver);
+	ceph_encode_32(p, len);
+}
+
+/**
+ * ceph_start_decoding_compat - decode block with legacy support for older schemes
+ * @p: buffer to decode
+ * @end: end of decode buffer
+ * @curr_ver: current version of the encoding that the code supports/encode
+ * @compat_ver: oldest version that includes a __u8 compat version field
+ * @len_ver: oldest version that includes a __u32 length wrapper
+ * @len: buffer to return len of data in buffer
+ */
+static inline int ceph_start_decoding_compat(void **p, void *end, u8 curr_ver,
+					    u8 compat_ver, u8 len_ver, u32 *len)
+{
+	u8 struct_ver, struct_compat;
+
+	ceph_decode_8_safe(p, end, struct_ver, fail);
+	if (struct_ver >= compat_ver) {
+		ceph_decode_8_safe(p, end, struct_compat, fail);
+		if (curr_ver < struct_compat)
+			return -EINVAL;
+	}
+
+	if (struct_ver >= len_ver) {
+		ceph_decode_32_safe(p, end, *len, fail);
+	} else {
+		*len = 0;
+	}
+
+	return 0;
+fail:
+	return -ERANGE;
+}
+
+
 #define ceph_encode_need(p, end, n, bad)			\
 	do {							\
 		if (!likely(ceph_has_room(p, end, n)))		\
-- 
1.9.3

