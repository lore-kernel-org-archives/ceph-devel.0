From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH] ceph: remove req from unsafe list before calling __unregister_request
Date: Thu,  9 Feb 2017 07:18:15 -0500
Message-ID: <20170209121815.4244-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbdBIMmQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 07:42:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

...and while we're at it, let's ensure that no one inadvertantly
leaves this thing on the unsafe list. There's no reason it should
ever be on a s_unsafe list but not in the request tree.

Cc: stable@vger.kernel.org
Link: http://tracker.ceph.com/issues/18474
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 52521f339745..b47e97680a66 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -628,6 +628,8 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 {
 	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
 
+	WARN_ON_ONCE(!list_empty(&req->r_unsafe_item));
+
 	if (req->r_tid == mdsc->oldest_tid) {
 		struct rb_node *p = rb_next(&req->r_node);
 		mdsc->oldest_tid = 0;
@@ -3512,6 +3514,7 @@ static void wait_requests(struct ceph_mds_client *mdsc)
 		while ((req = __get_oldest_req(mdsc))) {
 			dout("wait_requests timed out on tid %llu\n",
 			     req->r_tid);
+			list_del_init(&req->r_unsafe_item);
 			__unregister_request(mdsc, req);
 		}
 	}
-- 
2.9.3

