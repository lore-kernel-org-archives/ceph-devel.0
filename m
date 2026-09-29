Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38692B9B7
	for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691148; cv=none; b=s4QbW54u69g6LMBiEmgrUdDpAtzGGdUs/zdsMs+at8QPEzFok4Gb5jh/XGhHpa4E3eAyzF7NMfhQ7EAXfAnIKAkeC9yIPydCz33nNChVmRruaDCimlwfV71iJ+lCoC5IOiFL3wFOacb/1DUSHgfvsOoZ1Ht/AzCyRJEqN61CjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691148; c=relaxed/simple;
	bh=6E4596pydF75nPyiwylN7IN/FZNu7MBmB221GMR2UHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHAowKat20ibY/i5fX+Izk1hg9GyM2zqPT4UbUA0jvpGxFF9AKILPnYkXCsv2x59h9NiSwPrC7OBPpnjGOjon0vXRTQfp3geNXcTE18e2Y4Op/aae4mnLcLFR1914MFrTHx46VMt5KlYfFtw5i7cIM4gs+iDtY/iv/matIhBnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=zYlQFH/D; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="zYlQFH/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1790691064; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=6E4596pydF75nPyiwylN7IN/FZNu7MBmB221GMR2UHQ=;
 b=zYlQFH/DvQnB0FQY7eE9S6McX6/16XQbU1OihSTajMHpL375p2R1CEze/7njuMhPWY9Ye
 EHRXFbJMh9Pt16yzM4iEUhrr0nJ1nQPLVBRGkCnrgaSf50siNb2g+24XlSGNrrpYQ8WvPBc
 Fr954rVPzntUVK5U2ZDIm9BdAlZu8J/q1N87emvSsvIyaKSH7+Enc+WzyTI/G9/5JRRI0Q4
 wWX7LSaU2nniI1jvOkXbUqk2qCcU+uEmXWb54/g4CQdrgd9wMnrZbV0Wo2b74B85O49akkl
 QQfqYm/61PCahYNgWYQHtG1UkHXmOcG3D3c2+YCSw2sHLSBdhl1r3HNgVGEw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 604D35FD4A;
	Tue, 29 Sep 2026 16:11:04 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 37E525FA49;
	Tue, 29 Sep 2026 16:11:03 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Only allocate new front segment for oversized reply messages
Date: Tue, 29 Sep 2026 16:10:42 +0200
Message-ID: <20260929141042.80544-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_reply() and get_generic_reply() are used to get an already allocated
message buffer for a reply message. Incoming messages with oversized
front segments are handled by allocating a new message and replacing the
previously allocated one. If the reply message previously contained data
items, they are lost after this reallocation. CEPH_MSG_OSD_OPREPLY
messages, handled in get_reply, often contain a data segment and are in
this case always discarded after the message buffer is reallocated.
Furthermore, the max_data_items value is set to zero in the newly
allocated buffer, which can trigger a BUG_ON assertion in
ceph_msg_data_add() when later attempting to resend the request.

This patch fixes the issue by modifying the handling of oversized front
segments in get_reply() and get_generic_reply(). Instead of allocating
a new message, only a new front segment buffer is allocated to replace
the one in the reply message.

Fixes: c16e786927b9 ("ceph: use single osd op reply msg")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/mon_client.c | 38 ++++++++++++++++++++------------------
 net/ceph/osd_client.c | 16 +++++++++++-----
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index c83a868e0890..b6c2965bec56 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -721,17 +721,15 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	struct ceph_mon_generic_request *req;
 	u64 tid = le64_to_cpu(hdr->tid);
-	int type = le16_to_cpu(hdr->type);
 	int front_len = le32_to_cpu(hdr->front_len);
 	u32 data_len = le32_to_cpu(hdr->data_len);
-	struct ceph_msg *m;
+	struct ceph_msg *m = NULL;
 
 	mutex_lock(&monc->mutex);
 	req = lookup_generic_request(&monc->generic_request_tree, tid);
 	if (!req) {
-		dout("get_generic_reply %lld dne\n", tid);
+		dout("%s %lld dne\n", __func__, tid);
 		*skip = 1;
-		m = NULL;
 		goto out;
 	}
 
@@ -739,7 +737,6 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated %zu, skipping\n",
 				    tid, data_len, req->reply->data_length);
 		*skip = 1;
-		m = NULL;
 		goto out;
 	}
 
@@ -748,22 +745,27 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		pr_warn_ratelimited("tid %llu front %d > prealloc %d\n",
 				    tid, front_len,
 				    req->reply->front_alloc_len);
-		m = ceph_msg_new(type, front_len, GFP_NOFS, true);
-		if (m) {
-			ceph_msg_put(req->reply);
-			req->reply = m;
-			m = ceph_msg_get(req->reply);
+		kvfree(req->reply->front.iov_base);
+		req->reply->front.iov_base = kvmalloc(front_len, GFP_NOFS);
+		if (!req->reply->front.iov_base) {
+			dout("%s can't allocate %d bytes\n",
+			     __func__, front_len);
+			req->reply->front_alloc_len = 0;
+			req->reply->front.iov_len = 0;
+			goto out;
 		}
-	} else {
-		dout("get_generic_reply %lld got %p\n", tid, req->reply);
-		m = ceph_msg_get(req->reply);
-		/*
-		 * we don't need to track the connection reading into
-		 * this reply because we only have one open connection
-		 * at a time, ever.
-		 */
+		req->reply->front_alloc_len = front_len;
+		req->reply->front.iov_len = front_len;
 	}
 
+	dout("%s %lld got %p\n", __func__, tid, req->reply);
+	m = ceph_msg_get(req->reply);
+	/*
+	 * we don't need to track the connection reading into
+	 * this reply because we only have one open connection
+	 * at a time, ever.
+	 */
+
 out:
 	mutex_unlock(&monc->mutex);
 	return m;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ea0b49f1a231..5f2c561ff4e2 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5497,12 +5497,18 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 		pr_warn("%s osd%d tid %llu front %d > preallocated %d\n",
 			__func__, osd->o_osd, req->r_tid, front_len,
 			req->r_reply->front_alloc_len);
-		m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front_len, GFP_NOFS,
-				 false);
-		if (!m)
+		kvfree(req->r_reply->front.iov_base);
+		req->r_reply->front.iov_base = kvmalloc(front_len, GFP_NOFS);
+		if (!req->r_reply->front.iov_base) {
+			dout("%s can't allocate %d bytes\n",
+			     __func__, front_len);
+			req->r_reply->front_alloc_len = 0;
+			req->r_reply->front.iov_len = 0;
+			*skip = 0;
 			goto out_unlock_session;
-		ceph_msg_put(req->r_reply);
-		req->r_reply = m;
+		}
+		req->r_reply->front_alloc_len = front_len;
+		req->r_reply->front.iov_len = front_len;
 	}
 
 	srlen = sparse_data_requested(req);
-- 
2.47.3

