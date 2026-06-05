Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D647D950
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jun 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647009; cv=none; b=YiUQRE4TYgeH88MqCKDLkEIogUV+ar2KD8ndhh+fMkh69kzTPAjXCXMBU2ujK7tEFvir28+NMei1vvgpmL9p9psSwSW8jIRtnI1yJDrG1GIysoCFnHYISLybrz0OPIvU7FhlK/Pq7Vp0zGwvUlJoA06hyYyI1US5LX3AcjDAIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647009; c=relaxed/simple;
	bh=61k3xCoUKsm5G0o5Rbw7DRMteNKCgIDIrdF+9MsR5cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jh782+JB3aIo3JClhwG9taIrCsQDXv/kUqv6xF91IiARGWrOJ9sRq6pP3sZBrWBlZsvoKlLzn7MUreXPZnn0fvIqnshYh0cxvVcLrOPAl/Das8+kGVzvosEVXW4DCF39ulIwMJfXKRLUNq3+eVT7eI0zCNkXMi64ixU2g970p2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=T1XIhUIg; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="T1XIhUIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780647005; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=61k3xCoUKsm5G0o5Rbw7DRMteNKCgIDIrdF+9MsR5cU=;
 b=T1XIhUIgwQnDxvATA3uGTdTSsw6l+PaER2rCtb48LqN7mueQCDNlMV0nZ8jdHAfOODZ8u
 rAVQvZ+5PAtwrDbKfMkujvt3JNGfTYIVS056jy59UhDF1Z79GTXXMKyijnXdPDI6D9IteG8
 XuzE2uPIUppvUyADFP5UtWxBzi3BTYa47A3V22rtO6vcwJd0pAPbRC+HJHH3zYSZpKVZf4D
 80ebcMtNSyXJPFsZFcSeVkADRgFpoV4GDx+j/RHLKUAXrztkeqhI1xRAL5PsnP87K5E8UDN
 6OZURJXJ8joAKbw3QHqx/j0VfLPG2e3qZtlN5CybhSa4tfYt84VORHjDUtYQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 962695FDA5;
	Fri,  5 Jun 2026 10:10:05 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 8031F5FB21;
	Fri,  5 Jun 2026 10:10:05 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v5] libceph: Fix out-of-bounds writes with oversized monitor reply messages
Date: Fri,  5 Jun 2026 10:10:00 +0200
Message-ID: <20260605081000.647658-1-raphael.zimmer@tu-ilmenau.de>
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

Fixes: 3143edd3a185 ("ceph: clean up statfs")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/mon_client.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 66c0d6d6b33d..b299f6016eb4 100644
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
+		m = ceph_msg_new(type, front_len, GFP_NOFS, true);
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

