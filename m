From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/8] libceph: minor byte order problems in
Date: Sat, 09 Mar 2013 09:13:47 -0600
Message-ID: <513B51AB.2060804@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:52025 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288Ab3CIPNv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:13:51 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so2407634iaf.0
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:13:50 -0800 (PST)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Some values printed are not (necessarily) in CPU order.  We already
have a copy of the converted versions, so use them.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b8d0da5..d9ace97 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1916,7 +1916,7 @@ static int read_partial_message(struct
ceph_connection *con)
 		int skip = 0;

 		dout("got hdr type %d front %d data %d\n", con->in_hdr.type,
-		     con->in_hdr.front_len, con->in_hdr.data_len);
+		     front_len, data_len);
 		ret = ceph_con_in_msg_alloc(con, &skip);
 		if (ret < 0)
 			return ret;
-- 
1.7.9.5

