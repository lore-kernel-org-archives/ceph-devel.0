From: mchristi@redhat.com
Subject: [PATCH 02/10] ceph: add start/finish encoding helpers
Date: Tue, 28 Apr 2015 17:05:39 -0500
Message-ID: <1430258747-12506-3-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030444AbbD1WFv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5o7Y024541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:50 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbN013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:50 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch adds helpers to encode/decode the starting blocks
locking code. They are the equivalent of ENCODE_START and
DECODE_START_LEGACY_COMPAT_LEN in the userspace ceph code.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/ceph/decode.h | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index a6ef9cc..96ec43d 100644
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
+					     u8 compat_ver, u8 len_ver, u32 *len)
+{
+	u8 struct_ver, struct_compat;
+
+	ceph_decode_8_safe(p, end, struct_ver, fail);
+	if (struct_ver >= curr_ver) {
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
1.8.3.1

