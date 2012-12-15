From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: report connection fault with warning
Date: Fri, 14 Dec 2012 20:30:23 -0600
Message-ID: <50CBE0BF.4060204@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:64777 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab2LOCa0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 21:30:26 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3750616iay.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 18:30:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a connection's socket disconnects, or if there's a protocol
error of some kind on the connection, a fault is signaled and
the connection is reset (closed and reopened, basically).  We
currently get an error message on the log whenever this occurs.

A ceph connection will attempt to reestablish a socket connection
repeatedly if a fault occurs.  This means that these error messages
will get repeatedly added to the log, which is undesirable.

Change the error message to be a warning, so they don't get
logged by default.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 4b04ccc..4d111fd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2377,7 +2377,7 @@ fault:
 static void ceph_fault(struct ceph_connection *con)
 	__releases(con->mutex)
 {
-	pr_err("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
+	pr_warning("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
 	       ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg);
 	dout("fault %p state %lu to peer %s\n",
 	     con, con->state, ceph_pr_addr(&con->peer_addr.in_addr));
-- 
1.7.9.5

