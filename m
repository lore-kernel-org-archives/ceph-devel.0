From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: don't access invalid memory in keepalive2 path
Date: Mon, 14 Sep 2015 16:50:26 +0300
Message-ID: <1442238626-13714-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33416 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbINNvC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 09:51:02 -0400
Received: by wiclk2 with SMTP id lk2so141789419wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2015 06:51:01 -0700 (PDT)
Received: from orange.local.localdomain ([109.110.66.71])
        by smtp.gmail.com with ESMTPSA id uc12sm14490237wib.13.2015.09.14.06.51.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2015 06:51:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This

    struct ceph_timespec ceph_ts;
    ...
    con_out_kvec_add(con, sizeof(ceph_ts), &ceph_ts);

wraps ceph_ts into a kvec and adds it to con->out_kvec array, yet
ceph_ts becomes invalid on return from prepare_write_keepalive().  As
a result, we send out bogus keepalive2 stamps.  Fix this by encoding
into a ceph_timespec member, similar to how acks are read and written.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/messenger.h | 4 +++-
 net/ceph/messenger.c           | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 7e1252e97a30..b2371d9b51fa 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -238,6 +238,8 @@ struct ceph_connection {
 	bool out_kvec_is_msg; /* kvec refers to out_msg */
 	int out_more;        /* there is more data after the kvecs */
 	__le64 out_temp_ack; /* for writing an ack */
+	struct ceph_timespec out_temp_keepalive2; /* for writing keepalive2
+						     stamp */
 
 	/* message in temps */
 	struct ceph_msg_header in_hdr;
@@ -248,7 +250,7 @@ struct ceph_connection {
 	int in_base_pos;     /* bytes read */
 	__le64 in_temp_ack;  /* for reading an ack */
 
-	struct timespec last_keepalive_ack;
+	struct timespec last_keepalive_ack; /* keepalive2 ack stamp */
 
 	struct delayed_work work;	    /* send|recv work */
 	unsigned long       delay;          /* current delay interval */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 525f454f7531..b9b0e3b5da49 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1353,11 +1353,12 @@ static void prepare_write_keepalive(struct ceph_connection *con)
 	dout("prepare_write_keepalive %p\n", con);
 	con_out_kvec_reset(con);
 	if (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2) {
-		struct timespec ts = CURRENT_TIME;
-		struct ceph_timespec ceph_ts;
-		ceph_encode_timespec(&ceph_ts, &ts);
+		struct timespec now = CURRENT_TIME;
+
 		con_out_kvec_add(con, sizeof(tag_keepalive2), &tag_keepalive2);
-		con_out_kvec_add(con, sizeof(ceph_ts), &ceph_ts);
+		ceph_encode_timespec(&con->out_temp_keepalive2, &now);
+		con_out_kvec_add(con, sizeof(con->out_temp_keepalive2),
+				 &con->out_temp_keepalive2);
 	} else {
 		con_out_kvec_add(con, sizeof(tag_keepalive), &tag_keepalive);
 	}
-- 
1.9.3

