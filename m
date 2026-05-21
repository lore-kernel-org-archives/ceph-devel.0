Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED33CDBDD
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2026 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365789; cv=none; b=lo4ofL/fQgPQ5gdQJ6vQ6TiNNlmHhXXNj19SewVMpOi+hJoaM8faPWfOLFcsiYi4Ezxb3FmzIa+iMkihl01NWaBlIeSKq58oSOK3NMc+KaX2t7gcUgTUedb6CiCwyqrek5/klL3cs5nLtNLiUrjoquHh39z5sI1UACZjQiZjuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365789; c=relaxed/simple;
	bh=tslDXuw0ll4niWOM67RFcURSgFuWwMOc4bYtxjwgW08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSFRMNJ52A4M4mmXMb9EIUR0epI5SHKf8ujQeNLND7O0SwSctkIbhVnvSD2XPvoSm4eDE/HncDq9pD+C2nsiadDeclKPEiSE0j2LqN/JgxiFq5BKq9n8CTo5YTmi/Y40Gd4tTmAgrVoGz4XEnpOohkNm/jwH1KLLEjCqMnlzAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=Id2xpyjq; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="Id2xpyjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779365711; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=tslDXuw0ll4niWOM67RFcURSgFuWwMOc4bYtxjwgW08=;
 b=Id2xpyjqL4vqRYAfvOnu1DjrHEbDgXR6iKNYx1EBngj4ScLn8hBpUjOFiZ+fe9OQs9UJg
 9SjFIUTNVoSa0PIsSpBrfTCUKeAEKn8n65m0hbDsskog+wdWKxtZCQSFPYV4TmWrVNlbLjH
 6rBUEK+toEsbVs8wHQQnEfklLG1BLuxo9gDWcM0tCvxjhJHvoNm/xL6wZMb17aEUVqcOFFK
 FZ4FxKQsifCAT8L71+fAMMnpX1i9hNr3QTIJW/65WeCUq04JrnDCO5Q5ej47jTjsHeC8sau
 UvoP+a1x8rWIDUzaMOTvj1H4ciC1Ao/JkQydNjIV6pLLZsNN2Tb/ZII6LAUA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 871FC60087;
	Thu, 21 May 2026 14:15:11 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3488F5FB7B;
	Thu, 21 May 2026 14:15:11 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Fix out-of-bounds writes with oversized monitor reply messages
Date: Thu, 21 May 2026 14:14:24 +0200
Message-ID: <20260521121424.2869056-1-raphael.zimmer@tu-ilmenau.de>
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
index 66c0d6d6b33d..852ed0cae660 100644
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
+		pr_warn_ratelimited("tid %llu front %d > prealloc %d\n",
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

