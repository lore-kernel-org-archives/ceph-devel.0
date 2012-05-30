From: Alex Elder <elder@inktank.com>
Subject: [PATCH 03/13] libceph: delete useless SOCK_CLOSED manipulations
Date: Wed, 30 May 2012 14:34:29 -0500
Message-ID: <4FC67645.1050609@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34496 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab2E3Tea (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:34:30 -0400
Received: by mail-vc0-f174.google.com with SMTP id f11so125386vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:34:30 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In con_close_socket(), SOCK_CLOSED is set in the connection state,
then cleared again after shutting down the socket.  Nothing between
the setting and clearing of that bit will ever be affected by it,
so there's no point in setting/clearing it at all.  So don't.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |    2 --
  1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 07af994..fe3c2a1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -338,11 +338,9 @@ static int con_close_socket(struct ceph_connection 
*con)
  	dout("con_close_socket on %p sock %p\n", con, con->sock);
  	if (!con->sock)
  		return 0;
-	set_bit(SOCK_CLOSED, &con->state);
  	rc = con->sock->ops->shutdown(con->sock, SHUT_RDWR);
  	sock_release(con->sock);
  	con->sock = NULL;
-	clear_bit(SOCK_CLOSED, &con->state);
  	return rc;
  }

-- 
1.7.5.4

