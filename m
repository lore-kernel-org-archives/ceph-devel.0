From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/6] libceph: don't call ->reencode_message() more than once per message
Date: Fri, 28 Jul 2017 14:41:26 +0200
Message-ID: <1501245690-2362-3-git-send-email-idryomov@gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36073 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdG1Mrh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 08:47:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id 184so27304447wmo.3
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 05:47:37 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c13sm8263773wrc.7.2017.07.28.05.41.39
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 05:41:39 -0700 (PDT)
In-Reply-To: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Reencoding an already reencoded message is a bad idea.  This could
happen on Policy::stateful_server connections (!CEPH_MSG_CONNECT_LOSSY),
such as MDS sessions.

This didn't pop up in testing because currently only OSD requests are
reencoded and OSD sessions are always lossy.

Fixes: 98ad5ebd1505 ("libceph: ceph_connection_operations::reencode_message() method")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b7cc615d42ef..a67298c7e0cd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1287,10 +1287,10 @@ static void prepare_write_message(struct ceph_connection *con)
 	if (m->needs_out_seq) {
 		m->hdr.seq = cpu_to_le64(++con->out_seq);
 		m->needs_out_seq = false;
-	}
 
-	if (con->ops->reencode_message)
-		con->ops->reencode_message(m);
+		if (con->ops->reencode_message)
+			con->ops->reencode_message(m);
+	}
 
 	dout("prepare_write_message %p seq %lld type %d len %d+%d+%zd\n",
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
-- 
2.4.3

