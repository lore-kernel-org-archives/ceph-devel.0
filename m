From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] libceph: cleanup old messages according to reconnect seq
Date: Fri,  5 May 2017 19:08:18 +0800
Message-ID: <20170505110818.28010-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdEELI0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 May 2017 07:08:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E67780E7A
        for <ceph-devel@vger.kernel.org>; Fri,  5 May 2017 11:08:25 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, idryomov@redhat.com, "Yan, Zheng" <zyan@redhat.com>

when reopen a connection, use 'reconnect seq' to clean up
messages that have already been received by peer.

Fixes: http://tracker.ceph.com/issues/18690
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 net/ceph/messenger.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f76bb33..af9c5a1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2230,10 +2230,17 @@ static void process_ack(struct ceph_connection *con)
 	struct ceph_msg *m;
 	u64 ack = le64_to_cpu(con->in_temp_ack);
 	u64 seq;
-
-	while (!list_empty(&con->out_sent)) {
-		m = list_first_entry(&con->out_sent, struct ceph_msg,
-				     list_head);
+	bool reconnect = (con->in_tag == CEPH_MSGR_TAG_SEQ);
+	struct list_head *list = reconnect ? &con->out_queue : &con->out_sent;
+	/*
+	 * In the reconnect case, con_fault() has requeued messages
+	 * in out_sent. We should cleanup old messages according to
+	 * the reconnect seq.
+	 */
+	while (!list_empty(list)) {
+		m = list_first_entry(list, struct ceph_msg, list_head);
+		if (reconnect && m->needs_out_seq)
+			break;
 		seq = le64_to_cpu(m->hdr.seq);
 		if (seq > ack)
 			break;
@@ -2242,6 +2249,7 @@ static void process_ack(struct ceph_connection *con)
 		m->ack_stamp = jiffies;
 		ceph_msg_remove(m);
 	}
+
 	prepare_read_tag(con);
 }
 
-- 
2.9.3

