From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/8] libceph: change type of ceph_tcp_sendpage() "more"
Date: Sat, 09 Mar 2013 09:14:08 -0600
Message-ID: <513B51C0.8020409@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52596 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288Ab3CIPOL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:14:11 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so3166766iea.38
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:14:10 -0800 (PST)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change the type of the "more" parameter from int to bool.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d9ace97..962b2cd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -493,7 +493,7 @@ static int ceph_tcp_sendmsg(struct socket *sock,
struct kvec *iov,
 }

 static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
-		     int offset, size_t size, int more)
+		     int offset, size_t size, bool more)
 {
 	int flags = MSG_DONTWAIT | MSG_NOSIGNAL | (more ? MSG_MORE : MSG_EOR);
 	int ret;
@@ -1132,7 +1132,7 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 		}
 		ret = ceph_tcp_sendpage(con->sock, page,
 				      con->out_msg_pos.page_pos + bio_offset,
-				      len, 1);
+				      len, true);
 		if (ret <= 0)
 			goto out;

@@ -1161,7 +1161,7 @@ static int write_partial_skip(struct
ceph_connection *con)
 	while (con->out_skip > 0) {
 		size_t size = min(con->out_skip, (int) PAGE_CACHE_SIZE);

-		ret = ceph_tcp_sendpage(con->sock, zero_page, 0, size, 1);
+		ret = ceph_tcp_sendpage(con->sock, zero_page, 0, size, true);
 		if (ret <= 0)
 			goto out;
 		con->out_skip -= ret;
-- 
1.7.9.5

