From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: no need for alignment for mds message
Date: Mon, 04 Mar 2013 12:12:28 -0600
Message-ID: <5134E40C.1090303@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E3AD.4080906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:61686 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191Ab3CDSM2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:12:28 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so6568524ieb.15
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:12:27 -0800 (PST)
In-Reply-To: <5134E3AD.4080906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently, incoming mds messages never use page data, which means
there is no need to set the page_alignment field in the message.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a4b986a..afb9dc9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3486,7 +3486,6 @@ static struct ceph_msg *mds_alloc_msg(struct
ceph_connection *con,
 		       type, front_len);
 		return NULL;
 	}
-	msg->page_alignment = (unsigned int) le16_to_cpu(hdr->data_off);

 	return msg;
 }
-- 
1.7.9.5

