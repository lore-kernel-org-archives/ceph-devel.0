From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/5] libceph: only call kernel_sendpage() via helper
Date: Mon, 12 Mar 2012 17:40:16 -0500
Message-ID: <4F5E7B50.6040509@dreamhost.com>
References: <4F5E79C6.6040301@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58502 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab2CLWkN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:40:13 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A472D243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:40:47 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 776DA2439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:40:47 -0700 (PDT)
In-Reply-To: <4F5E79C6.6040301@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make ceph_tcp_sendpage() be the only place kernel_sendpage() is
used, by using this helper in write_partial_msg_pages().

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |    8 ++------
  1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9207a8c..adca1e6 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -904,17 +904,13 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  			con->out_msg->footer.data_crc = cpu_to_le32(crc);
  			con->out_msg_pos.did_page_crc = true;
  		}
-		ret = kernel_sendpage(con->sock, page,
+		ret = ceph_tcp_sendpage(con->sock, page,
  				      con->out_msg_pos.page_pos + page_shift,
-				      len,
-				      MSG_DONTWAIT | MSG_NOSIGNAL |
-				      MSG_MORE);
+				      len, 1);

  		if (do_datacrc && kaddr != zero_page_address)
  			kunmap(page);

-		if (ret == -EAGAIN)
-			ret = 0;
  		if (ret <= 0)
  			goto out;

-- 
1.7.5.4

