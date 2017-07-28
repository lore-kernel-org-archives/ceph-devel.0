From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/6] libceph: make encode_request_*() work with r_mempool requests
Date: Fri, 28 Jul 2017 14:41:25 +0200
Message-ID: <1501245690-2362-2-git-send-email-idryomov@gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36712 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdG1Mll (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 08:41:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id 184so27285584wmo.3
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 05:41:40 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c13sm8263773wrc.7.2017.07.28.05.41.39
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 05:41:39 -0700 (PDT)
In-Reply-To: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Messages allocated out of ceph_msgpool have a fixed front length
(pool->front_len).  Asserting that the entire front has been filled
while encoding is thus wrong.

Fixes: 8cb441c0545d ("libceph: MOSDOp v8 encoding (actual spgid + full hash)")
Reported-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 901bb8221366..b5f016cb9569 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1918,10 +1918,12 @@ static void encode_request_partial(struct ceph_osd_request *req,
 	}
 
 	ceph_encode_32(&p, req->r_attempts); /* retry_attempt */
-	BUG_ON(p != end - 8); /* space for features */
+	BUG_ON(p > end - 8); /* space for features */
 
 	msg->hdr.version = cpu_to_le16(8); /* MOSDOp v8 */
 	/* front_len is finalized in encode_request_finish() */
+	msg->front.iov_len = p - msg->front.iov_base;
+	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 	msg->hdr.data_len = cpu_to_le32(data_len);
 	/*
 	 * The header "data_off" is a hint to the receiver allowing it
@@ -1937,11 +1939,12 @@ static void encode_request_partial(struct ceph_osd_request *req,
 static void encode_request_finish(struct ceph_msg *msg)
 {
 	void *p = msg->front.iov_base;
+	void *const partial_end = p + msg->front.iov_len;
 	void *const end = p + msg->front_alloc_len;
 
 	if (CEPH_HAVE_FEATURE(msg->con->peer_features, RESEND_ON_SPLIT)) {
 		/* luminous OSD -- encode features and be done */
-		p = end - 8;
+		p = partial_end;
 		ceph_encode_64(&p, msg->con->peer_features);
 	} else {
 		struct {
@@ -1984,7 +1987,7 @@ static void encode_request_finish(struct ceph_msg *msg)
 		oid_len = p - oid;
 
 		tail = p;
-		tail_len = (end - p) - 8;
+		tail_len = partial_end - p;
 
 		p = msg->front.iov_base;
 		ceph_encode_copy(&p, &head.client_inc, sizeof(head.client_inc));
-- 
2.4.3

