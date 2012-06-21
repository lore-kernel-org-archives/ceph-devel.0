From: Alex Elder <elder@inktank.com>
Subject: [PATCH 07/12] libceph: define and use an explicit CONNECTED state
Date: Thu, 21 Jun 2012 09:22:04 -0500
Message-ID: <4FE32E0C.2080503@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64146 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758374Ab2FUOWG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:22:06 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so496672yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:22:06 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no state explicitly defined when a ceph connection is fully
operational.  So define one.

It's set when the connection sequence completes successfully, and is
cleared when the connection gets closed.

Be a little more careful when examining the old state when a socket
disconnect event is reported.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    1 +
 net/ceph/messenger.c           |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

Index: b/include/linux/ceph/messenger.h
===================================================================
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -120,6 +120,7 @@ struct ceph_msg_pos {
  */
 #define CONNECTING	1
 #define NEGOTIATING	2
+#define CONNECTED	5
 #define STANDBY		8  /* no outgoing messages, socket closed.  we keep
 			    * the ceph_connection around to maintain shared
 			    * state with the peer. */
Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -463,6 +463,7 @@ void ceph_con_close(struct ceph_connecti
 	     ceph_pr_addr(&con->peer_addr.in_addr));
 	clear_bit(NEGOTIATING, &con->state);
 	clear_bit(CONNECTING, &con->state);
+	clear_bit(CONNECTED, &con->state);
 	clear_bit(STANDBY, &con->state);  /* avoid connect_seq bump */
 	set_bit(CLOSED, &con->state);

@@ -1588,6 +1589,7 @@ static int process_connect(struct ceph_c
 		}
 		clear_bit(NEGOTIATING, &con->state);
 		clear_bit(CONNECTING, &con->state);
+		set_bit(CONNECTED, &con->state);
 		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
 		con->connect_seq++;
 		con->peer_features = server_feat;
@@ -2139,6 +2141,7 @@ more:
 			prepare_read_ack(con);
 			break;
 		case CEPH_MSGR_TAG_CLOSE:
+			clear_bit(CONNECTED, &con->state);
 			set_bit(CLOSED, &con->state);   /* fixme */
 			goto out;
 		default:
@@ -2215,11 +2218,13 @@ static void con_work(struct work_struct
 	mutex_lock(&con->mutex);
 restart:
 	if (test_and_clear_bit(SOCK_CLOSED, &con->flags)) {
-		if (test_and_clear_bit(CONNECTING, &con->state)) {
+		if (test_and_clear_bit(CONNECTED, &con->state))
+			con->error_msg = "socket closed";
+		else if (test_and_clear_bit(CONNECTING, &con->state)) {
 			clear_bit(NEGOTIATING, &con->state);
 			con->error_msg = "connection failed";
 		} else {
-			con->error_msg = "socket closed";
+			con->error_msg = "unrecognized con state";
 		}
 		goto fault;
 	}
