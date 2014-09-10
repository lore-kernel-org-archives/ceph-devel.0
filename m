From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/3] libceph: gracefully handle large reply messages from the mon
Date: Wed, 10 Sep 2014 11:54:29 +0400
Message-ID: <1410335671-4581-2-git-send-email-ilya.dryomov@inktank.com>
References: <1410335671-4581-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:42760 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaIJHyi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 03:54:38 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so3796476lbd.29
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 00:54:36 -0700 (PDT)
In-Reply-To: <1410335671-4581-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@redhat.com>

From: Sage Weil <sage@redhat.com>

We preallocate a few of the message types we get back from the mon.  If we
get a larger message than we are expecting, fall back to trying to allocate
a new one instead of blindly using the one we have.

CC: stable@vger.kernel.org
Signed-off-by: Sage Weil <sage@redhat.com>
---
 net/ceph/mon_client.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 067d3af2eaf6..61fcfc304f68 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1181,7 +1181,15 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 	if (!m) {
 		pr_info("alloc_msg unknown type %d\n", type);
 		*skip = 1;
+	} else if (front_len > m->front_alloc_len) {
+		pr_warning("mon_alloc_msg front %d > prealloc %d (%u#%llu)\n",
+			   front_len, m->front_alloc_len,
+			   (unsigned int)con->peer_name.type,
+			   le64_to_cpu(con->peer_name.num));
+		ceph_msg_put(m);
+		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
 	}
+
 	return m;
 }
 
-- 
1.7.10.4

