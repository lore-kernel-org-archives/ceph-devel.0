From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] libceph: move prepare_write_banner()
Date: Tue, 28 Feb 2012 20:43:24 -0800
Message-ID: <4F4DACEC.4000400@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47103 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964853Ab2B2EnY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:43:24 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id B0B9424318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:43:24 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A6C2624314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:43:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One of the arguments to prepare_write_connect() indicates whether it
is being called immediately after a call to prepare_write_banner().
Move the prepare_write_banner() call inside prepare_write_connect(),
and reinterpret (and rename) the "after_banner" argument so it
indicates that prepare_write_connect() should *make* the call
rather than should know it has already been made.

This was split out from the next patch to highlight this change in
logic.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |    7 ++++---
  1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c410c55..2404a5a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -672,7 +672,7 @@ static void prepare_write_banner(struct 
ceph_messenger *msgr,

  static int prepare_write_connect(struct ceph_messenger *msgr,
  				 struct ceph_connection *con,
-				 int after_banner)
+				 int include_banner)
  {
  	unsigned global_seq = get_global_seq(con->msgr, 0);
  	int proto;
@@ -701,7 +701,9 @@ static int prepare_write_connect(struct 
ceph_messenger *msgr,
  	con->out_connect.protocol_version = cpu_to_le32(proto);
  	con->out_connect.flags = 0;

-	if (!after_banner) {
+	if (include_banner)
+		prepare_write_banner(msgr, con);
+	else {
  		con->out_kvec_left = 0;
  		con->out_kvec_bytes = 0;
  	}
@@ -1842,7 +1844,6 @@ more:

  	/* open the socket first? */
  	if (con->sock == NULL) {
-		prepare_write_banner(msgr, con);
  		prepare_write_connect(msgr, con, 1);
  		prepare_read_banner(con);
  		set_bit(CONNECTING, &con->state);
-- 
1.7.5.4

