From: edward6@linux.ibm.com
Subject: [PATCH] ceph: fix up endian bug in managing feature bits
Date: Mon, 27 Apr 2020 23:46:26 +0200
Message-ID: <1588023986-23672-1-git-send-email-edward6@linux.ibm.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbgD0VrH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:47:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RLWOb6073354
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2020 17:47:06 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhq7ju16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2020 17:47:06 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03RLjP4u013565
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2020 21:47:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7v807-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2020 21:47:03 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Ulrich.Weigand@de.ibm.com, Tuan.Hoang1@ibm.com, Eduard Shishkin <edward6@linux.ibm.com>

From: Eduard Shishkin <edward6@linux.ibm.com>

In the function handle_session() variable @features always
contains little endian order of bytes. Just because the feature
bits are packed bytewise from left to right in
encode_supported_features().

However, test_bit(), called to check features availability, assumes
the host order of bytes in that variable. This leads to problems on
big endian architectures. Specifically it is impossible to mount
ceph volume on s390.

This patch adds conversion from little endian to the host order
of bytes, thus fixing the problem.

Signed-off-by: Eduard Shishkin <edward6@linux.ibm.com>
---
 fs/ceph/mds_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 486f91f..190598d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3252,7 +3252,7 @@ static void handle_session(struct ceph_mds_session *session,
 	struct ceph_mds_session_head *h;
 	u32 op;
 	u64 seq;
-	unsigned long features = 0;
+	__le64 features = 0;
 	int wake = 0;
 	bool blacklisted = false;
 
@@ -3301,7 +3301,7 @@ static void handle_session(struct ceph_mds_session *session,
 		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
 			pr_info("mds%d reconnect success\n", session->s_mds);
 		session->s_state = CEPH_MDS_SESSION_OPEN;
-		session->s_features = features;
+		session->s_features = le64_to_cpu(features);
 		renewed_caps(mdsc, session, 0);
 		wake = 1;
 		if (mdsc->stopping)
-- 
1.8.3.1
