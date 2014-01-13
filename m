From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/3] libceph: fix preallocation check in get_reply()
Date: Mon, 13 Jan 2014 12:58:41 +0200
Message-ID: <1389610721-5280-4-git-send-email-ilya.dryomov@inktank.com>
References: <1389610721-5280-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:41990 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaAMK7m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jan 2014 05:59:42 -0500
Received: by mail-ee0-f41.google.com with SMTP id e49so1380695eek.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jan 2014 02:59:41 -0800 (PST)
In-Reply-To: <1389610721-5280-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

The check that makes sure that we have enough memory allocated to read
in the entire header of the message in question is currently busted.
It compares front_len of the incoming message with iov_len field of
ceph_msg::front structure, which is used primarily to indicate the
amount of data already read in, and not the size of the allocated
buffer.  Under certain conditions (e.g. a short read from a socket
followed by that socket's shutdown and owning ceph_connection reset)
this results in a warning similar to

[85688.975866] libceph: get_reply front 198 > preallocated 122 (4#0)

and, through another bug, leads to forever hung tasks and forced
reboots.  Fix this by comparing front_len with front_alloc_len field of
struct ceph_msg, which stores the actual size of the buffer.

Fixes: http://tracker.ceph.com/issues/5425

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/messenger.c  |    3 +--
 net/ceph/osd_client.c |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 331f8e4c8a75..c4238e85989a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3131,7 +3131,6 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 	INIT_LIST_HEAD(&m->data);
 
 	/* front */
-	m->front_alloc_len = front_len;
 	if (front_len) {
 		if (front_len > PAGE_CACHE_SIZE) {
 			m->front.iov_base = __vmalloc(front_len, flags,
@@ -3148,7 +3147,7 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 	} else {
 		m->front.iov_base = NULL;
 	}
-	m->front.iov_len = front_len;
+	m->front_alloc_len = m->front.iov_len = front_len;
 
 	dout("ceph_msg_new %p front %d\n", m, front_len);
 	return m;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index bf1b418cc06d..600d3dc0fb66 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2532,9 +2532,9 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 		goto out;
 	}
 
-	if (front_len > req->r_reply->front.iov_len) {
+	if (front_len > req->r_reply->front_alloc_len) {
 		pr_warning("get_reply front %d > preallocated %d (%u#%llu)\n",
-			   front_len, (int)req->r_reply->front.iov_len,
+			   front_len, req->r_reply->front_alloc_len,
 			   (unsigned int)con->peer_name.type,
 			   le64_to_cpu(con->peer_name.num));
 		m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front_len, GFP_NOFS,
-- 
1.7.10.4

