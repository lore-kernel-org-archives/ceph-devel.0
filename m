From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: set page alignment in start_request()
Date: Mon, 25 Feb 2013 17:42:19 -0600
Message-ID: <512BF6DB.1040003@inktank.com>
References: <512BF683.5050905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34196 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759825Ab3BYXmW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:42:22 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so3760014iea.26
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:42:22 -0800 (PST)
In-Reply-To: <512BF683.5050905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The page alignment field for a request is currently set in
ceph_osdc_build_request().  It's not needed at that point
nor do either of its callers need that value assigned at
any point before they call ceph_osdc_start_request().

So move that assignment into ceph_osdc_start_request().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0a4d4a0..1bb2b59 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -369,7 +369,6 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 		data_len += len;
 	}
 	req->r_request->hdr.data_len = cpu_to_le32(data_len);
-	req->r_request->page_alignment = req->r_page_alignment;

 	BUG_ON(p > msg->front.iov_base + msg->front.iov_len);
 	msg_size = p - msg->front.iov_base;
@@ -1632,6 +1631,7 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,

 	req->r_request->pages = req->r_pages;
 	req->r_request->page_count = req->r_num_pages;
+	req->r_request->page_alignment = req->r_page_alignment;
 #ifdef CONFIG_BLOCK
 	req->r_request->bio = req->r_bio;
 #endif
-- 
1.7.9.5

