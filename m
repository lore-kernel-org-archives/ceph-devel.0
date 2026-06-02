Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AB3CF04F
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2026 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413075; cv=none; b=dZmO7KB8fLB1yHh4GxCh20RW6Jp/Z+L+cF7hPlw0cbvVylhLO1IKtpyGm+NRi1MsRrfoF3UOCBLJFvZGYzgWZWInNTiNVe5f32u4z3fLZVvJdXGwA/9WoFeqp/jp7qdnfC4Eq5ZAFOubPOW2mWfkhufuk50Df4Fyz0jpy84KNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413075; c=relaxed/simple;
	bh=csHYxc1qxclSQqtrilBLHKuOaz/nw74VWOt6aQQdRxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0u5NEKQRsZ4FWgUMlhb5ekY8vBiz7bDaMZIBuqoC8OUiUY3T8LE2GyH+Eo2w65M8KEnUPOeq/K2Fb8BqFpgvUEnnl38AMhPy8SBOc7uQS9fIiXTLtEuLmW40ayImn8YCDwsVmZLcme+DIiOwala8dLvXLOgYFa4rmdjqpA4y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=d6iMA99w; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="d6iMA99w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780413070; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=csHYxc1qxclSQqtrilBLHKuOaz/nw74VWOt6aQQdRxk=;
 b=d6iMA99wCty8nz6XfxQwieXLYFwhSyc6VSGl7pnD1oCPWfUemaUUnK/KaQMxPamRcuTdw
 2Z6fV5lUWumijGR3qbnqEaf02gsHxuIjgTQ3f59snCYkgP10Oi6prQ04LladwHCHPz0AFbx
 vZXDWqUwkCrI4LDPSGz+7P1Q7qjwOxUSnIi4ob6V+m8bDya6SrcVGVl6CKz4U8x8szr3QUJ
 htBiFvD8hwajp4fyHMHTUXPzeVTvMMj14JLFgjFGWBJxad662rapKZo1Gyer9xDFq/mMxYa
 zoV4o9s+rvx0ZlM4cNKVvf/3Nq3fJ36Bldh2RL1iIe8tu4zjsdfjoO0yg22Q==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B83885FB5C;
	Tue,  2 Jun 2026 17:11:10 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 97ECA5FB82;
	Tue,  2 Jun 2026 17:11:10 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v4] libceph: Fix out-of-bounds writes with oversized monitor reply messages
Date: Tue,  2 Jun 2026 17:10:25 +0200
Message-ID: <20260602151025.4145216-1-raphael.zimmer@tu-ilmenau.de>
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
 net/ceph/mon_client.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 66c0d6d6b33d..b33ae17546f8 100644
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
 
@@ -721,14 +723,30 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		dout("get_generic_reply %lld dne\n", tid);
 		*skip = 1;
 		m = NULL;
-	} else if (data_len > req->reply->data_length) {
+		goto out;
+	}
+
+	if (data_len > req->reply->data_length) {
 		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated %zu, skipping\n",
 				    tid, data_len, req->reply->data_length);
 		*skip = 1;
 		m = NULL;
+		goto out;
+	}
+
+	*skip = 0;
+	if (front_len > req->reply->front_alloc_len) {
+		pr_warn_ratelimited("tid %llu front %d > prealloc %d\n",
+				    tid, front_len,
+				    req->reply->front_alloc_len);
+		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
+		if (m) {
+			ceph_msg_put(req->reply);
+			req->reply = m;
+			m = ceph_msg_get(req->reply);
+		}
 	} else {
 		dout("get_generic_reply %lld got %p\n", tid, req->reply);
-		*skip = 0;
 		m = ceph_msg_get(req->reply);
 		/*
 		 * we don't need to track the connection reading into
@@ -736,6 +754,8 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		 * at a time, ever.
 		 */
 	}
+
+out:
 	mutex_unlock(&monc->mutex);
 	return m;
 }
-- 
2.47.3

