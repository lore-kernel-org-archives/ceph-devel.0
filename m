From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/2] libceph: some simple changes
Date: Tue, 28 Feb 2012 20:55:45 -0800
Message-ID: <4F4DAFD1.7000100@dreamhost.com>
References: <4F4DAF00.5020908@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59910 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab2B2Ezq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:55:46 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E743B24324
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:55:45 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id B0D8F2431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:55:45 -0800 (PST)
In-Reply-To: <4F4DAF00.5020908@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Nothing too big here.
     - define the size of the buffer used for consuming ignored
       incoming data using a symbolic constant
     - simplify the condition determining whether to unmap the page
       in write_partial_msg_pages(): do it for crc but not if the
       page is the zero page

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   13 +++++++++----
  1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 63f281f..27a1364 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -38,6 +38,11 @@ static char tag_keepalive = CEPH_MSGR_TAG_KEEPALIVE;
  static struct lock_class_key socket_class;
  #endif

+/*
+ * When skipping (ignoring) a block of input we read it into a "skip
+ * buffer," which is this many bytes in size.
+ */
+#define SKIP_BUF_SIZE	1024

  static void queue_con(struct ceph_connection *con);
  static void con_work(struct work_struct *);
@@ -889,8 +894,7 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  				      MSG_DONTWAIT | MSG_NOSIGNAL |
  				      MSG_MORE);

-		if (do_crc &&
-		    (msg->pages || msg->pagelist || msg->bio || in_trail))
+		if (do_crc && kaddr != zero_page_address)
  			kunmap(page);

  		if (ret == -EAGAIN)
@@ -1979,8 +1983,9 @@ more:
  		 *
  		 * FIXME: there must be a better way to do this!
  		 */
-		static char buf[1024];
-		int skip = min(1024, -con->in_base_pos);
+		static char buf[SKIP_BUF_SIZE];
+		int skip = min((int) sizeof buf, -con->in_base_pos);
+
  		dout("skipping %d / %d bytes\n", skip, -con->in_base_pos);
  		ret = ceph_tcp_recvmsg(con->sock, buf, skip);
  		if (ret <= 0)
-- 
1.7.5.4

