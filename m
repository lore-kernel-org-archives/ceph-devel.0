From: Alex Elder <elder@inktank.com>
Subject: [PATCH 01/13] libceph: eliminate connection state "DEAD"
Date: Wed, 30 May 2012 14:34:16 -0500
Message-ID: <4FC67638.9050104@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39470 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2E3TeR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:34:17 -0400
Received: by yhmm54 with SMTP id m54so184923yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:34:16 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The ceph connection state "DEAD" is never set and is therefore not
needed.  Eliminate it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  include/linux/ceph/messenger.h |    1 -
  net/ceph/messenger.c           |    6 ------
  2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 2521a95..aa506ca 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -119,7 +119,6 @@ struct ceph_msg_pos {
  #define CLOSED		10 /* we've closed the connection */
  #define SOCK_CLOSED	11 /* socket state changed to closed */
  #define OPENING         13 /* open connection w/ (possibly new) peer */
-#define DEAD            14 /* dead, about to kfree */
  #define BACKOFF         15

  /*
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1a80907..42ca8aa 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2087,12 +2087,6 @@ bad_tag:
   */
  static void queue_con(struct ceph_connection *con)
  {
-	if (test_bit(DEAD, &con->state)) {
-		dout("queue_con %p ignoring: DEAD\n",
-		     con);
-		return;
-	}
-
  	if (!con->ops->get(con)) {
  		dout("queue_con %p ref count 0\n", con);
  		return;
-- 
1.7.5.4


