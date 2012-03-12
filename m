From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/5] libceph: use kernel_sendpage() for sending zeroes
Date: Mon, 12 Mar 2012 17:40:12 -0500
Message-ID: <4F5E7B4C.8030002@dreamhost.com>
References: <4F5E79C6.6040301@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58497 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385Ab2CLWkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:40:09 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8A559243A4
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:40:43 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5A9D0243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:40:43 -0700 (PDT)
In-Reply-To: <4F5E79C6.6040301@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If a message queued for send gets revoked, zeroes are sent over the
wire instead of any unsent data.  This is done by constructing a
message and passing it to kernel_sendmsg() via ceph_tcp_sendmsg().

Since we are already working with a page in this case we can use
the sendpage interface instead.  Create a new ceph_tcp_sendpage()
helper that sets up flags to match the way ceph_tcp_sendmsg()
does now.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   20 +++++++++++++++-----
  1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 589b768..9207a8c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -321,6 +321,19 @@ static int ceph_tcp_sendmsg(struct socket *sock, 
struct kvec *iov,
  	return r;
  }

+static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
+		     int offset, size_t size, int more)
+{
+	int flags = MSG_DONTWAIT | MSG_NOSIGNAL | (more ? MSG_MORE : MSG_EOR);
+	int ret;
+
+	ret = kernel_sendpage(sock, page, offset, size, flags);
+	if (ret == -EAGAIN)
+		ret = 0;
+
+	return ret;
+}
+

  /*
   * Shutdown/close the socket for the given connection.
@@ -944,12 +957,9 @@ static int write_partial_skip(struct 
ceph_connection *con)
  	int ret;

  	while (con->out_skip > 0) {
-		struct kvec iov = {
-			.iov_base = zero_page_address,
-			.iov_len = min(con->out_skip, (int)PAGE_CACHE_SIZE)
-		};
+		size_t size = min(con->out_skip, (int) PAGE_CACHE_SIZE);

-		ret = ceph_tcp_sendmsg(con->sock, &iov, 1, iov.iov_len, 1);
+		ret = ceph_tcp_sendpage(con->sock, zero_page, 0, size, 1);
  		if (ret <= 0)
  			goto out;
  		con->out_skip -= ret;
-- 
1.7.5.4

