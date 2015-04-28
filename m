From: mchristi@redhat.com
Subject: [PATCH 05/10] ceph: decode start helper
Date: Tue, 28 Apr 2015 17:05:42 -0500
Message-ID: <1430258747-12506-6-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030986AbbD1WFw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5qnq023753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:52 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbQ013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:52 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

Add support for userspace ceph DECODE_START.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/ceph/decode.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 96ec43d..4f551b8 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -271,6 +271,29 @@ fail:
 	return -ERANGE;
 }
 
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
 
 #define ceph_encode_need(p, end, n, bad)			\
 	do {							\
-- 
1.8.3.1

