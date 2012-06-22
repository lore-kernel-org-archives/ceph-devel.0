From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/9] libceph: close the connection's socket on reset
Date: Fri, 22 Jun 2012 17:48:23 -0500
Message-ID: <4FE4F637.4040404@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42424 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab2FVWsY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:24 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so1973211yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:23 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

When a ceph connection is reset, all its state is cleared.  However
the underlying socket never actually gets closed.  Do that, to
essentially make the reset process complete.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -492,6 +492,7 @@ static void reset_connection(struct ceph
 	}
 	con->in_seq = 0;
 	con->in_seq_acked = 0;
+	con_close_socket(con);
 }

 /*
