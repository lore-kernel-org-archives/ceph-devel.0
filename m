From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH RFC 1/6] Add support for userspace ceph DECODE_START.
Date: Tue, 30 Jun 2015 13:27:56 -0700
Message-ID: <3f553015bc14a3ed984ba62b5237c05f3f236714.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbbF3U35 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 16:29:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id D78EB8F277
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 20:29:56 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5UKTrti018417
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 16:29:56 -0400
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/ceph/decode.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index a6ef9cc..b55c7fd 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -255,5 +255,28 @@ static inline void ceph_encode_string(void **p, void *end,
 		ceph_encode_string(p, end, s, n);		\
 	} while (0)
 
+/**
+ * ceph_start_decoding - start a decoding block
+ * @p: buffer to decode
+ * @end: end of buffer
+ * @curr_ver: current version of the encoding that the code supports/encode
+ * @len: buffer to return len of data in buffer
+ */
+static inline int ceph_start_decoding(void **p, void *end, u8 curr_ver,
+				      u32 *len)
+{
+	u8 struct_ver, struct_compat;
+
+	ceph_decode_8_safe(p, end, struct_ver, fail);
+	ceph_decode_8_safe(p, end, struct_compat, fail);
+
+	if (curr_ver < struct_compat)
+		return -EINVAL;
+
+	ceph_decode_32_safe(p, end, *len, fail);
+	return 0;
+fail:
+	return -ERANGE;
+}
 
 #endif
-- 
1.9.3

