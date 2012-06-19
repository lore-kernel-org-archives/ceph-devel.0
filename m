From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix NULL dereference in reset_connection()
Date: Tue, 19 Jun 2012 08:57:10 -0500
Message-ID: <4FE08536.9040807@inktank.com>
References: <20120619103339.GB7596@elgon.mountain> <4FE07E37.7000203@inktank.com> <20120619133316.GR4400@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36838 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab2FSN5N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 09:57:13 -0400
Received: by yhmm54 with SMTP id m54so4769724yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 06:57:12 -0700 (PDT)
In-Reply-To: <20120619133316.GR4400@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

I have already incorporated the following in the Ceph master
branch (which is used for the -next build).  We will also send
this to Linus soon.

					-Alex
=========

We dereference "con->in_msg" on the line after it was set to NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5e9f61d..23073cf 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -440,7 +440,7 @@ static void reset_connection(struct ceph_connection
*con)
 		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
-		ceph_con_put(con->in_msg->con);
+		ceph_con_put(con);
 	}

 	con->connect_seq = 0;



