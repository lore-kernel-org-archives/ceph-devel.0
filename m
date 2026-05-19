Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3564A33E7
	for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189252; cv=none; b=qYcEDSDpoJBIdN41QgaBEsfHTNdrzIq7D8ynXSpUp3kUeTGCvjFHUtHPLGYmCXaR6iW7Zxj0KHFOF1HNc+yb6Smvo/OWwb9qHx+kYwe8QxPBw2pV7vwN3e7Xrs5M+S/x9PMRPFgKbEYCVxp9pSw8/hnl5mjxWUUGpbSOAcgHLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189252; c=relaxed/simple;
	bh=JicSbTs+p80/EH4LmtE355Kd4+kpzImbjTEQjFWBH/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IElSTqzelKMIYC6c9OLGkj+0DHjsd8fNj0mPWFb/OzR3/qAWEq7azt4MlblQlmDzXk1AbTsrUsjsk/0SL+zwRIfuVhucGhhUbHIdZHM0SAffbxoG4EpMoU9fIcSJKPVbmLq7PSv+46e4RnV2t6ZfxZ26HBCbw9vpIw/xJNilZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=GBSSEykn; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="GBSSEykn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779189249; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=JicSbTs+p80/EH4LmtE355Kd4+kpzImbjTEQjFWBH/8=;
 b=GBSSEyknaaAa+ykZUSbeJC33MGbdd48dAmwdViPNUtmTRiXeNLYaIRSqVuXskjOkGAL6J
 3DdgIT+G+y0dBYV+3QH1D9+oBlHQhfznPDhI2MMN3s+izBZbvC8u1Aj3V57rje84kNSij55
 yg1lsxxEZl6PtGAO/Kv7NNNdEqxcFHLlC1WFWt5PTRbtyOKl7yoRMWVUXFBBcGVinFbhRr2
 Z2Tarv0f4/RfKaXW6GUFXEyTW+roqcXciOe80g/qiz+92WaKVj+/5/lDQaAeqC5Pys9UuQY
 cLYVaf2n46dm5zEL//CkqTA4vLZ2ewksgdfACN9dX68KdmyDIdpVhOq2DR8Q==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 3477F5FB5B;
	Tue, 19 May 2026 13:14:09 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 1B7F85FA3E;
	Tue, 19 May 2026 13:14:09 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix out-of-bounds writes with oversized monitor reply messages
Date: Tue, 19 May 2026 13:14:07 +0200
Message-ID: <20260519111407.2191040-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing an incoming reply message of type CEPH_MSG_STATFS_REPLY,
CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY on the
monitor connection, an already allocated reply message for the given
transaction ID is used (if existing). Such a message has a preallocated
front segment with a fixed length of 64, 512, or 32 bytes, depending on
the message type it was allocated for. The actual length to receive into
this buffer is read from the message. If this value exceeds the
allocation size, data received from the network is written beyond the
end of the allocated buffer.

This patch fixes the issue by adding a check that compares the needed
front segment length to the previously allocated length when retrieving
the message buffer. If the needed length exceeds the allocation, a new
message buffer with the needed size is allocated to replace the previous
one.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/mon_client.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 66c0d6d6b33d..267dfadfbf8e 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -712,6 +712,8 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	struct ceph_mon_generic_request *req;
 	u64 tid = le64_to_cpu(hdr->tid);
+	int type = le16_to_cpu(hdr->type);
+	int front_len = le32_to_cpu(hdr->front_len);
 	u32 data_len = le32_to_cpu(hdr->data_len);
 	struct ceph_msg *m;
 
@@ -721,6 +723,17 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		dout("get_generic_reply %lld dne\n", tid);
 		*skip = 1;
 		m = NULL;
+	} else if (front_len > req->reply->front_alloc_len) {
+		pr_warn_ratelimited("get_generic_reply %llu front %d > prealloc %d\n",
+				    tid, front_len,
+				    req->reply->front_alloc_len);
+		*skip = 0;
+		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
+		if (m) {
+			ceph_msg_put(req->reply);
+			req->reply = m;
+			m = ceph_msg_get(req->reply);
+		}
 	} else if (data_len > req->reply->data_length) {
 		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated %zu, skipping\n",
 				    tid, data_len, req->reply->data_length);
-- 
2.47.3

