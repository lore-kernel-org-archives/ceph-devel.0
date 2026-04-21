Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926F336897
	for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2026 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760067; cv=none; b=YxK2Br1H4BIFPmhqe25xyjhU7IjJfBb0P60F/xepHY13aXlsGOjzCgen47TSOyC/xboLP7DOYNUyk++7tpvB/K7nAALUJSQuB3ztoNR7fkU3ElF7wIOS2FIxJnSR2w+8b/AiG74GRsctE5p8Sh6DEMfHpnbkBleezGJcNSpZ/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760067; c=relaxed/simple;
	bh=85Qez9lY9hP6KZl4l7w5zMpst/amL2xXDDoPNQnw2zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+ksKbcaEnk4G834a93FFnJKzYkzNFOe1qqYBbdLrfCb3VCmIahvk2Xu0nL2EExHnmj/HpGR6mqAANOsqav2hduQ3rilHoQYaDYUkwk4Wwzqe6WVLVMFqOvbAzTqLU5h8y1khdYscfX0RM7f4CpuM2CImG6pSphPcWPAbg0jqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=aTtohBR1; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="aTtohBR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1776760062; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=85Qez9lY9hP6KZl4l7w5zMpst/amL2xXDDoPNQnw2zo=;
 b=aTtohBR1MdbEiAYgQH02VCIzr6HOf9YoJ54A4ll4gwbfGFpaQuYhsSvQGRq3I5u/eXmRz
 NEcvFKjD+tthmlgPhO2VDBc2MKOg5RFQ84XsHHTBHRkHs41Psoz+eEkUNAMMwfJtsaeTX3d
 Bp3v72dbIkjQZxHkE740YGXiDceaokorVKEKPb+Lp5RcZKAL2xmyX6WjdNt9YFDA3JW3XoL
 /GfI/rXuVUgVc/GY09Mp6ERA4km6itqy5nT/oYe1Fk2X7SRXo8Sp094cAgOpC0cBqnDsZ6g
 6lIRq884WMALl/VtvD4yVXauTBfpkf1U8xqrrUvbkIBg+HnYHz94YSL7eANw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 05BE260199;
	Tue, 21 Apr 2026 10:27:41 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id AB3865FB21;
	Tue, 21 Apr 2026 10:27:40 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix slab-out-of-bounds access in auth message processing
Date: Tue, 21 Apr 2026 10:27:01 +0200
Message-ID: <20260421082701.310432-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a (potentially corrupted) message of type CEPH_MSG_AUTH_REPLY
contains a positive value in its result field, it is treated as an
error code by ceph_handle_auth_reply() and returned to
handle_auth_reply(). Thereafter, an attempt is made to send the
preallocated message of type CEPH_MSG_AUTH, where the returned value is
interpreted as the size of the front segment to send. If the result
value in the message is greater than the size of the memory buffer
allocated for the front segment, an out-of-bounds access occurs, and
the content of the memory region beyond this buffer is sent out.

This patch fixes the issue by treating only negative values in the
result field as errors. Positive values are therefore treated as success
in the same way as a zero value. Additionally, a BUG_ON is added to
__send_prepared_auth_request() comparing the len parameter to
front_alloc_len to prevent sending the message if it exceeds the bounds
of the allocation and to make it easier to catch any logic flaws leading
to this.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/auth.c       | 2 +-
 net/ceph/mon_client.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index 3314705e5914..17660bde896b 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -257,7 +257,7 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
 		ac->negotiating = false;
 	}
 
-	if (result) {
+	if (result < 0) {
 		pr_err("auth protocol '%s' mauth authentication failed: %d\n",
 		       ceph_auth_proto_name(ac->protocol), result);
 		ret = result;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d5080530ce0c..51220f1a8f03 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -174,6 +174,7 @@ int ceph_monmap_contains(struct ceph_monmap *m, struct ceph_entity_addr *addr)
  */
 static void __send_prepared_auth_request(struct ceph_mon_client *monc, int len)
 {
+	BUG_ON(len > monc->m_auth->front_alloc_len);
 	monc->pending_auth = 1;
 	monc->m_auth->front.iov_len = len;
 	monc->m_auth->hdr.front_len = cpu_to_le32(len);
-- 
2.47.3

