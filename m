From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 13/15] libceph: verify authorize reply on connect
Date: Mon, 12 Dec 2016 21:48:58 +0100
Message-ID: <1481575740-1834-14-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36702 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932510AbcLLUuQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so13732291wma.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:15 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.13
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:13 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After sending an authorizer (ceph_x_authorize_a + ceph_x_authorize_b),
the client gets back a ceph_x_authorize_reply, which it is supposed to
verify to ensure the authenticity and protect against replay attacks.
The code for doing this is there (ceph_x_verify_authorizer_reply(),
ceph_auth_verify_authorizer_reply() + plumbing), but it is never
invoked by the the messenger.

AFAICT this goes back to 2009, when ceph authentication protocols
support was added to the kernel client in 4e7a5dcd1bba ("ceph:
negotiate authentication protocol; implement AUTH_NONE protocol").

The second param of ceph_connection_operations::verify_authorizer_reply
is unused all the way down.  Pass 0 to facilitate backporting, and kill
it in the next commit.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a5502898ea33..2efb335deada 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2027,6 +2027,19 @@ static int process_connect(struct ceph_connection *con)
 
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
+	if (con->auth_reply_buf) {
+		/*
+		 * Any connection that defines ->get_authorizer()
+		 * should also define ->verify_authorizer_reply().
+		 * See get_connect_authorizer().
+		 */
+		ret = con->ops->verify_authorizer_reply(con, 0);
+		if (ret < 0) {
+			con->error_msg = "bad authorize reply";
+			return ret;
+		}
+	}
+
 	switch (con->in_reply.tag) {
 	case CEPH_MSGR_TAG_FEATURES:
 		pr_err("%s%lld %s feature set mismatch,"
-- 
2.4.3

