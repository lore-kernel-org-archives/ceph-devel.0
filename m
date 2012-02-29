From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/2] libceph: small refactor in write_partial_kvec()
Date: Tue, 28 Feb 2012 20:55:43 -0800
Message-ID: <4F4DAFCF.5090205@dreamhost.com>
References: <4F4DAF00.5020908@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59902 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592Ab2B2Ezn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:55:43 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A5D5C24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:55:43 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 96046242C3
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:55:43 -0800 (PST)
In-Reply-To: <4F4DAF00.5020908@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make a small change in the code that counts down kvecs consumed by
a ceph_tcp_sendmsg() call.  Same functionality, just blocked out
a little differently.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   23 ++++++++++++-----------
  1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 693be64..63f281f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -744,17 +744,18 @@ static int write_partial_kvec(struct 
ceph_connection *con)
  		con->out_kvec_bytes -= ret;
  		if (con->out_kvec_bytes == 0)
  			break;            /* done */
-		while (ret > 0) {
-			if (ret >= con->out_kvec_cur->iov_len) {
-				ret -= con->out_kvec_cur->iov_len;
-				con->out_kvec_cur++;
-				con->out_kvec_left--;
-			} else {
-				con->out_kvec_cur->iov_len -= ret;
-				con->out_kvec_cur->iov_base += ret;
-				ret = 0;
-				break;
-			}
+
+		/* account for full iov entries consumed */
+		while (ret >= con->out_kvec_cur->iov_len) {
+			BUG_ON(!con->out_kvec_left);
+			ret -= con->out_kvec_cur->iov_len;
+			con->out_kvec_cur++;
+			con->out_kvec_left--;
+		}
+		/* and for a partially-consumed entry */
+		if (ret) {
+			con->out_kvec_cur->iov_len -= ret;
+			con->out_kvec_cur->iov_base += ret;
  		}
  	}
  	con->out_kvec_left = 0;
-- 
1.7.5.4

