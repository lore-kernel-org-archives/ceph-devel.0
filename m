From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 06/15] libceph: tweak calcu_signature() a little
Date: Mon, 12 Dec 2016 21:48:51 +0100
Message-ID: <1481575740-1834-7-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35996 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbcLLUuJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:09 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so13588164wjb.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:08 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.06
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:07 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

- replace an ad-hoc array with a struct
- rename to calc_signature() for consistency

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index ef1423294517..78c1675b0df7 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -707,35 +707,48 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
 	invalidate_ticket(ac, CEPH_ENTITY_TYPE_AUTH);
 }
 
-static int calcu_signature(struct ceph_x_authorizer *au,
-			   struct ceph_msg *msg, __le64 *sig)
+static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
+			  __le64 *psig)
 {
-	int ret;
 	char tmp_enc[40];
-	__le32 tmp[5] = {
-		cpu_to_le32(16), msg->hdr.crc, msg->footer.front_crc,
-		msg->footer.middle_crc, msg->footer.data_crc,
-	};
-	ret = ceph_x_encrypt(&au->session_key, &tmp, sizeof(tmp),
+	struct {
+		__le32 len;
+		__le32 header_crc;
+		__le32 front_crc;
+		__le32 middle_crc;
+		__le32 data_crc;
+	} __packed sigblock;
+	int ret;
+
+	sigblock.len = cpu_to_le32(4*sizeof(u32));
+	sigblock.header_crc = msg->hdr.crc;
+	sigblock.front_crc = msg->footer.front_crc;
+	sigblock.middle_crc = msg->footer.middle_crc;
+	sigblock.data_crc =  msg->footer.data_crc;
+	ret = ceph_x_encrypt(&au->session_key, &sigblock, sizeof(sigblock),
 			     tmp_enc, sizeof(tmp_enc));
 	if (ret < 0)
 		return ret;
-	*sig = *(__le64*)(tmp_enc + 4);
+
+	*psig = *(__le64 *)(tmp_enc + sizeof(u32));
 	return 0;
 }
 
 static int ceph_x_sign_message(struct ceph_auth_handshake *auth,
 			       struct ceph_msg *msg)
 {
+	__le64 sig;
 	int ret;
 
 	if (ceph_test_opt(from_msgr(msg->con->msgr), NOMSGSIGN))
 		return 0;
 
-	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
-			      msg, &msg->footer.sig);
-	if (ret < 0)
+	ret = calc_signature((struct ceph_x_authorizer *)auth->authorizer,
+			     msg, &sig);
+	if (ret)
 		return ret;
+
+	msg->footer.sig = sig;
 	msg->footer.flags |= CEPH_MSG_FOOTER_SIGNED;
 	return 0;
 }
@@ -749,9 +762,9 @@ static int ceph_x_check_message_signature(struct ceph_auth_handshake *auth,
 	if (ceph_test_opt(from_msgr(msg->con->msgr), NOMSGSIGN))
 		return 0;
 
-	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
-			      msg, &sig_check);
-	if (ret < 0)
+	ret = calc_signature((struct ceph_x_authorizer *)auth->authorizer,
+			     msg, &sig_check);
+	if (ret)
 		return ret;
 	if (sig_check == msg->footer.sig)
 		return 0;
-- 
2.4.3

