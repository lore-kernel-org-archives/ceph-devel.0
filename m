From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/9] libceph: don't close socket in OPENING state
Date: Fri, 22 Jun 2012 17:48:30 -0500
Message-ID: <4FE4F63E.6040902@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53187 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2FVWs3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:29 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1973383ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:29 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The only way a socket enters OPENING state is via ceph_con_open().

The only times ceph_con_open() is called are:
  - In fs/ceph/mds_client.c:register_session(), where it occurs
    soon after a call to ceph_con_init().
  - In fs/ceph/mds_client.c:send_mds_reconnect().  This is
    called in two places.
    - In fs/ceph/mds_client.c:check_new_map(), it is called
      after a call to ceph_con_close()
    - Or in fs/ceph/mds_client.c:peer_reset(), which is also only
      called after reset_connection, which includes a call to
      ceph_con_close().
  - In net/ceph/mon_client.c:__open_session(), where it's called
    right after a call to ceph_con_init().
  - In net/ceph/osd_client.c:__reset_osd(), right after a call
    to ceph_con_close().
  - In net/ceph/osd_client.c:__map_request(), shortly after a call
    to create_osd(), which includes a call to ceph_con_init().

After a call to ceph_con_init(), the state of a ceph connection is
CLOSED, and its socket pointer is null.

Similarly, after a call to ceph_con_close(), the state of the
connection is CLOSED, the underlying socket is closed, and the
connection's socket pointer is null.

Therefore, there is no reason to call con_close_socket() when a
connection is found to be in OPENING state in con_work(), because
the socket will already be closed, and the connection will already
be in CLOSED state.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2387,7 +2387,6 @@ restart:
 	if (test_and_clear_bit(OPENING, &con->state)) {
 		/* reopen w/ new peer */
 		dout("con_work OPENING\n");
-		con_close_socket(con);
 	}

 	ret = try_read(con);
