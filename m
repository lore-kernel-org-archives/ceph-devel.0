From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: print more info for short message header
Date: Wed, 29 May 2013 15:51:11 -0500
Message-ID: <51A66A3F.4040707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:45984 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966493Ab3E2Uu5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 16:50:57 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so1588123vea.30
        for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 13:50:56 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id bk7sm29361870ved.0.2013.05.29.13.50.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 13:50:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If an osd client response message arrives that has a front section
that's too big for the buffer set aside to receive it, a warning
gets reported and a new buffer is allocated.

The warning says nothing about which connection had the problem.
Add the peer type and number to what gets reported, to be a bit more
informative.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e0abb83..61147fe 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2454,8 +2454,10 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 	ceph_msg_revoke_incoming(req->r_reply);

 	if (front > req->r_reply->front.iov_len) {
-		pr_warning("get_reply front %d > preallocated %d\n",
-			   front, (int)req->r_reply->front.iov_len);
+		pr_warning("get_reply front %d > preallocated %d (%u#%llu)\n",
+			   front, (int)req->r_reply->front.iov_len,
+			   (unsigned int)con->peer_name.type,
+			   le64_to_cpu(con->peer_name.num));
 		m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front, GFP_NOFS, false);
 		if (!m)
 			goto out;
-- 
1.7.9.5

