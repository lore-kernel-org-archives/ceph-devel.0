From: Alex Elder <elder@inktank.com>
Subject: [PATCH 02/16] ceph: messenger: reset connection kvec caller
Date: Thu, 17 May 2012 09:04:00 -0500
Message-ID: <4FB50550.2070106@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54559 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761232Ab2EQOD5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:03:57 -0400
Received: by yenm10 with SMTP id m10so1787303yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:03:57 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Reset a connection's kvec fields in the caller rather than in
prepare_write_connect().   This ends up repeating a few lines of
code but it's improving the separation between distinct operations
on the connection, which we can take advantage of later.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |    6 +++++-
  1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index bcbd409..cca3cf3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -725,7 +725,6 @@ static int prepare_write_connect(struct 
ceph_messenger *msgr,
  	con->out_connect.protocol_version = cpu_to_le32(proto);
  	con->out_connect.flags = 0;

-	ceph_con_out_kvec_reset(con);
  	if (include_banner)
  		prepare_write_banner(msgr, con);
  	ceph_con_out_kvec_add(con, sizeof (con->out_connect), &con->out_connect);
@@ -1389,6 +1388,7 @@ static int process_connect(struct ceph_connection 
*con)
  			return -1;
  		}
  		con->auth_retry = 1;
+		ceph_con_out_kvec_reset(con);
  		ret = prepare_write_connect(con->msgr, con, 0);
  		if (ret < 0)
  			return ret;
@@ -1409,6 +1409,7 @@ static int process_connect(struct ceph_connection 
*con)
  		       ENTITY_NAME(con->peer_name),
  		       ceph_pr_addr(&con->peer_addr.in_addr));
  		reset_connection(con);
+		ceph_con_out_kvec_reset(con);
  		prepare_write_connect(con->msgr, con, 0);
  		prepare_read_connect(con);

@@ -1432,6 +1433,7 @@ static int process_connect(struct ceph_connection 
*con)
  		     le32_to_cpu(con->out_connect.connect_seq),
  		     le32_to_cpu(con->in_connect.connect_seq));
  		con->connect_seq = le32_to_cpu(con->in_connect.connect_seq);
+		ceph_con_out_kvec_reset(con);
  		prepare_write_connect(con->msgr, con, 0);
  		prepare_read_connect(con);
  		break;
@@ -1446,6 +1448,7 @@ static int process_connect(struct ceph_connection 
*con)
  		     le32_to_cpu(con->in_connect.global_seq));
  		get_global_seq(con->msgr,
  			       le32_to_cpu(con->in_connect.global_seq));
+		ceph_con_out_kvec_reset(con);
  		prepare_write_connect(con->msgr, con, 0);
  		prepare_read_connect(con);
  		break;
@@ -1851,6 +1854,7 @@ more:

  	/* open the socket first? */
  	if (con->sock == NULL) {
+		ceph_con_out_kvec_reset(con);
  		prepare_write_connect(msgr, con, 1);
  		prepare_read_banner(con);
  		set_bit(CONNECTING, &con->state);
-- 
1.7.5.4

