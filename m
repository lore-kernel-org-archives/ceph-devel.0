From: Guanjun He <heguanbo@gmail.com>
Subject: [PATCH 1/1] prevent the race of incoming work during teardown
Date: Tue, 26 Jun 2012 16:41:28 +0800
Message-ID: <1340700088-9556-1-git-send-email-gjhe@suse.com>
References: <Re: [PATCH] net/ceph/osd_client.c add sem to osdmap destroy>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42639 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2FZImO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 04:42:14 -0400
Received: by weyu7 with SMTP id u7so3397432wey.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 01:42:13 -0700 (PDT)
In-Reply-To: <Re: [PATCH] net/ceph/osd_client.c add sem to osdmap destroy>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: Guanjun He <gjhe@suse.com>

	As you suggested in last e_mail: "The trick here is that I think 
we want to set a flag to discard incoming messages and then flush the workqueue, 
do all this other tear down for osd_client etc., and then tear down the messenger.  
I don't think we can tear down the msgr fully before that, though, because 
osd_client etc have their fingers in it.  We just need to prevent the race 
of incoming work during teardown..."

	We can not tear down the msgr fully, but we can set flag to discard the 
incoming messages. And the following is the description of this patch:
	Add a bool variable 'teardowning' as flag in struct ceph_messenger, init value
is set to false, and set this flag to true in function ceph_destroy_client(), and add 
the condition code in function ceph_data_ready() to test the flag value, if true, just return.

Signed-off-by: Guanjun He <gjhe@suse.com>
---
 include/linux/ceph/messenger.h |    1 +
 net/ceph/ceph_common.c         |    4 +++-
 net/ceph/messenger.c           |    6 ++++++
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 2521a95..61bb8e5 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -54,6 +54,7 @@ struct ceph_messenger {
 	struct ceph_entity_addr my_enc_addr;
 
 	bool nocrc;
+	bool teardowning;
 
 	/*
 	 * the global_seq counts connections i (attempt to) initiate
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index a776f75..3756afc 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -501,6 +501,9 @@ void ceph_destroy_client(struct ceph_client *client)
 {
 	dout("destroy_client %p\n", client);
 
+	client->msgr->teardowning = true;
+	ceph_msgr_flush();
+
 	/* unmount */
 	ceph_osdc_stop(&client->osdc);
 
@@ -509,7 +512,6 @@ void ceph_destroy_client(struct ceph_client *client)
 	 * auth module, which is needed to free those connections'
 	 * ceph_authorizers.
 	 */
-	ceph_msgr_flush();
 
 	ceph_monc_stop(&client->monc);
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 524f4e4..fe8881e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -157,6 +157,10 @@ static void ceph_data_ready(struct sock *sk, int count_unused)
 {
 	struct ceph_connection *con = sk->sk_user_data;
 
+	if (con->msgr->teardowning) {
+		return;
+	}
+
 	if (sk->sk_state != TCP_CLOSE_WAIT) {
 		dout("ceph_data_ready on %p state = %lu, queueing work\n",
 		     con, con->state);
@@ -2281,6 +2285,8 @@ struct ceph_messenger *ceph_messenger_create(struct ceph_entity_addr *myaddr,
 	get_random_bytes(&msgr->inst.addr.nonce, sizeof(msgr->inst.addr.nonce));
 	encode_my_addr(msgr);
 
+	msgr->teardowning = false;
+
 	dout("messenger_create %p\n", msgr);
 	return msgr;
 }
-- 
1.7.3.4

