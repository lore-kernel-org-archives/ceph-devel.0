From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/9] libceph: close connection on reset tag
Date: Fri, 22 Jun 2012 17:48:49 -0500
Message-ID: <4FE4F651.5000507@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:51215 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab2FVWsu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:50 -0400
Received: by mail-yw0-f51.google.com with SMTP id n12so2326227yhn.10
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:49 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

When a CEPH_MSGR_TAG_RESETSESSION tag is received, the connection
should be reset, dropping any pending messages and preparing for
a new connection to be negotiated.

Currently, reset_connection() is called to do this, but that only
drops messages.  To really get the connection fully reset, call
ceph_con_close() instead.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1533,7 +1533,8 @@ static int process_connect(struct ceph_c
 		pr_err("%s%lld %s connection reset\n",
 		       ENTITY_NAME(con->peer_name),
 		       ceph_pr_addr(&con->peer_addr.in_addr));
-		reset_connection(con);
+		ceph_con_close(con);
+
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
