From: Alex Elder <elder@inktank.com>
Subject: [PATCH 01/16] libceph: don't reset kvec in prepare_write_banner()
Date: Thu, 17 May 2012 09:03:24 -0500
Message-ID: <4FB5052C.60508@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55240 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761207Ab2EQODV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:03:21 -0400
Received: by yenm10 with SMTP id m10so1786673yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:03:21 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move the kvec reset for a connection out of prepare_write_banner and
into its only caller.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |    4 +---
  1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a659b4d..bcbd409 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -686,7 +686,6 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  static void prepare_write_banner(struct ceph_messenger *msgr,
  				 struct ceph_connection *con)
  {
-	ceph_con_out_kvec_reset(con);
  	ceph_con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER);
  	ceph_con_out_kvec_add(con, sizeof (msgr->my_enc_addr),
  					&msgr->my_enc_addr);
@@ -726,10 +725,9 @@ static int prepare_write_connect(struct 
ceph_messenger *msgr,
  	con->out_connect.protocol_version = cpu_to_le32(proto);
  	con->out_connect.flags = 0;

+	ceph_con_out_kvec_reset(con);
  	if (include_banner)
  		prepare_write_banner(msgr, con);
-	else
-		ceph_con_out_kvec_reset(con);
  	ceph_con_out_kvec_add(con, sizeof (con->out_connect), &con->out_connect);

  	con->out_more = 0;
-- 
1.7.5.4

