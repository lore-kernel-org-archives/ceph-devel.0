From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/12] libceph: clear CONNECTING in ceph_con_close()
Date: Thu, 21 Jun 2012 09:21:37 -0500
Message-ID: <4FE32DF1.9020903@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33143 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab2FUOVj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:21:39 -0400
Received: by ghrr11 with SMTP id r11so498842ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:21:38 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A connection that is closed will no longer be connecting.  So
clear the CONNECTING state bit in ceph_con_close().  Similarly,
if the socket has been closed we no longer are in connecting
state (a new connect sequence will need to be initiated).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -462,6 +462,7 @@ void ceph_con_close(struct ceph_connecti
 	dout("con_close %p peer %s\n", con,
 	     ceph_pr_addr(&con->peer_addr.in_addr));
 	clear_bit(NEGOTIATING, &con->state);
+	clear_bit(CONNECTING, &con->state);
 	clear_bit(STANDBY, &con->state);  /* avoid connect_seq bump */
 	set_bit(CLOSED, &con->state);

@@ -2214,7 +2215,7 @@ static void con_work(struct work_struct
 	mutex_lock(&con->mutex);
 restart:
 	if (test_and_clear_bit(SOCK_CLOSED, &con->flags)) {
-		if (test_bit(CONNECTING, &con->state))
+		if (test_and_clear_bit(CONNECTING, &con->state))
 			con->error_msg = "connection failed";
 		else
 			con->error_msg = "socket closed";
