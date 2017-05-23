From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/5] libceph: validate blob_struct_v in process_one_ticket()
Date: Tue, 23 May 2017 18:33:57 +0200
Message-ID: <1495557238-1077-5-git-send-email-idryomov@gmail.com>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35972 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935721AbdEWQeP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 12:34:15 -0400
Received: by mail-qk0-f196.google.com with SMTP id y128so23471582qka.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 09:34:15 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm784055qki.47.2017.05.23.09.34.13
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 09:34:14 -0700 (PDT)
In-Reply-To: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

None of these are validated in userspace, but since we do validate
reply_struct_v in ceph_x_proc_ticket_reply(), tkt_struct_v (first) and
CephXServiceTicket struct_v (second) in process_one_ticket(), validate
CephXTicketBlob struct_v as well.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 2034fb926670..d0126df33f1f 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -215,6 +215,9 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	dout(" ticket blob is %d bytes\n", dlen);
 	ceph_decode_need(ptp, tpend, 1 + sizeof(u64), bad);
 	blob_struct_v = ceph_decode_8(ptp);
+	if (blob_struct_v != 1)
+		goto bad;
+
 	new_secret_id = ceph_decode_64(ptp);
 	ret = ceph_decode_buffer(&new_ticket_blob, ptp, tpend);
 	if (ret)
-- 
2.4.3

