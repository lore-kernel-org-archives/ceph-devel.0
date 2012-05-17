From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/16] ceph: don't set WRITE_PENDING too early
Date: Thu, 17 May 2012 09:04:27 -0500
Message-ID: <4FB5056B.7040200@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34817 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761802Ab2EQOEY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:04:24 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1802686ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:04:23 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

prepare_write_connect() prepares a connect message, then sets
WRITE_PENDING on the connection.  Then *after* this, it calls
prepare_connect_authorizer(), which updates the content of the
connection buffer already queued for sending.  It's also possible it
will result in prepare_write_connect() returning -EAGAIN despite the
WRITE_PENDING big getting set.

Fix this by preparing the connect authorizer first, setting the
WRITE_PENDING bit only after that is done.

Partially addresses http://tracker.newdream.net/issues/2424

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |    6 +++++-
  1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 47499dc..cf29293 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -697,6 +697,7 @@ static int prepare_write_connect(struct 
ceph_connection *con)
  {
  	unsigned global_seq = get_global_seq(con->msgr, 0);
  	int proto;
+	int ret;

  	switch (con->peer_name.type) {
  	case CEPH_ENTITY_TYPE_MON:
@@ -723,11 +724,14 @@ static int prepare_write_connect(struct 
ceph_connection *con)
  	con->out_connect.flags = 0;

  	ceph_con_out_kvec_add(con, sizeof (con->out_connect), &con->out_connect);
+	ret = prepare_connect_authorizer(con);
+	if (ret)
+		return ret;

  	con->out_more = 0;
  	set_bit(WRITE_PENDING, &con->state);

-	return prepare_connect_authorizer(con);
+	return 0;
  }

  /*
-- 
1.7.5.4

