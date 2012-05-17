From: Alex Elder <elder@inktank.com>
Subject: [PATCH 06/16] ceph: messenger: check prepare_write_connect() result
Date: Thu, 17 May 2012 09:04:33 -0500
Message-ID: <4FB50571.1030100@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47015 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761919Ab2EQOEa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:04:30 -0400
Received: by yenm10 with SMTP id m10so1787877yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:04:29 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

prepare_write_connect() can return an error, but only one of its
callers checks for it.  All the rest are in functions that already
return errors, so it should be fine to return the error if one
gets returned.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |   16 ++++++++++++----
  1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index cf29293..8e76936 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1409,7 +1409,9 @@ static int process_connect(struct ceph_connection 
*con)
  		       ceph_pr_addr(&con->peer_addr.in_addr));
  		reset_connection(con);
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con);
+		ret = prepare_write_connect(con);
+		if (ret < 0)
+			return ret;
  		prepare_read_connect(con);

  		/* Tell ceph about it. */
@@ -1433,7 +1435,9 @@ static int process_connect(struct ceph_connection 
*con)
  		     le32_to_cpu(con->in_connect.connect_seq));
  		con->connect_seq = le32_to_cpu(con->in_connect.connect_seq);
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con);
+		ret = prepare_write_connect(con);
+		if (ret < 0)
+			return ret;
  		prepare_read_connect(con);
  		break;

@@ -1448,7 +1452,9 @@ static int process_connect(struct ceph_connection 
*con)
  		get_global_seq(con->msgr,
  			       le32_to_cpu(con->in_connect.global_seq));
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con);
+		ret = prepare_write_connect(con);
+		if (ret < 0)
+			return ret;
  		prepare_read_connect(con);
  		break;

@@ -1854,7 +1860,9 @@ more:
  	if (con->sock == NULL) {
  		ceph_con_out_kvec_reset(con);
  		prepare_write_banner(con);
-		prepare_write_connect(con);
+		ret = prepare_write_connect(con);
+		if (ret < 0)
+			goto out;
  		prepare_read_banner(con);
  		set_bit(CONNECTING, &con->state);
  		clear_bit(NEGOTIATING, &con->state);
-- 
1.7.5.4

