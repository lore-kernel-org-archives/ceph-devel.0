From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch -next] libceph: fix NULL dereference in reset_connection()
Date: Tue, 19 Jun 2012 13:33:39 +0300
Message-ID: <20120619103339.GB7596@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:47357 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab2FSKdw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 06:33:52 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

We dereference "con->in_msg" on the line after it was set to NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5e9f61d..6aa671c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -437,10 +437,10 @@ static void reset_connection(struct ceph_connection *con)
 
 	if (con->in_msg) {
 		BUG_ON(con->in_msg->con != con);
+		ceph_con_put(con->in_msg->con);
 		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
-		ceph_con_put(con->in_msg->con);
 	}
 
 	con->connect_seq = 0;
