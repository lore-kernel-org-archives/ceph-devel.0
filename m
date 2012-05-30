From: Alex Elder <elder@inktank.com>
Subject: [PATCH 02/13] libceph: kill bad_proto ceph connection op
Date: Wed, 30 May 2012 14:34:23 -0500
Message-ID: <4FC6763F.90203@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34496 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2E3TeW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:34:22 -0400
Received: by vcbf11 with SMTP id f11so125386vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:34:21 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

No code sets a bad_proto method in its ceph connection operations
vector, so just get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  include/linux/ceph/messenger.h |    3 ---
  net/ceph/messenger.c           |    5 -----
  2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index aa506ca..74f6c9b 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -31,9 +31,6 @@ struct ceph_connection_operations {
  	int (*verify_authorizer_reply) (struct ceph_connection *con, int len);
  	int (*invalidate_authorizer)(struct ceph_connection *con);

-	/* protocol version mismatch */
-	void (*bad_proto) (struct ceph_connection *con);
-
  	/* there was some error on the socket (disconnect, whatever) */
  	void (*fault) (struct ceph_connection *con);

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 42ca8aa..07af994 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1356,11 +1356,6 @@ static void fail_protocol(struct ceph_connection 
*con)
  {
  	reset_connection(con);
  	set_bit(CLOSED, &con->state);  /* in case there's queued work */
-
-	mutex_unlock(&con->mutex);
-	if (con->ops->bad_proto)
-		con->ops->bad_proto(con);
-	mutex_lock(&con->mutex);
  }

  static int process_connect(struct ceph_connection *con)
-- 
1.7.5.4

