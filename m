From: Alex Elder <elder@inktank.com>
Subject: [PATCH 9/9] libceph: set CONNECTING state even earlier
Date: Fri, 22 Jun 2012 17:49:06 -0500
Message-ID: <4FE4F662.7070805@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:51215 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab2FVWtF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:49:05 -0400
Received: by mail-yw0-f51.google.com with SMTP id n12so2326227yhn.10
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:49:05 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Move the setting of the CONNECTING state in a ceph connection
all the way back to where a connection first gets opened.  At
that point the connection's socket pointer is still null, and
the connection sequence is about to begin.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -533,6 +533,7 @@ void ceph_con_open(struct ceph_connectio
 	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
 	set_bit(OPENING, &con->state);
 	WARN_ON(!test_and_clear_bit(CLOSED, &con->state));
+	set_bit(CONNECTING, &con->state);

 	memcpy(&con->peer_addr, addr, sizeof(*addr));
 	con->delay = 0;      /* reset backoff memory */
@@ -1981,8 +1982,6 @@ static void process_message(struct ceph_
  */
 static int ceph_con_connect(struct ceph_connection *con)
 {
-	set_bit(CONNECTING, &con->state);
-
 	con_out_kvec_reset(con);
 	prepare_write_banner(con);
 	prepare_read_banner(con);
