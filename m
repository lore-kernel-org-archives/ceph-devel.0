From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/9] libceph: init osd->o_node in create_osd()
Date: Thu, 13 Dec 2012 11:02:07 -0600
Message-ID: <50CA0A0F.5070101@inktank.com>
References: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:52852 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab2LMRCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:02:11 -0500
Received: by mail-ia0-f181.google.com with SMTP id s32so2115616iak.40
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:02:10 -0800 (PST)
In-Reply-To: <50CA0915.1090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It turns out to be harmless but the red-black node o_node in the
ceph osd structure is not initialized in create_osd().  Add a
call to rb_init_node() initialize it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 60c74c1..470816c 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -642,6 +642,7 @@ static struct ceph_osd *create_osd(struct
ceph_osd_client *osdc, int onum)
 	atomic_set(&osd->o_ref, 1);
 	osd->o_osdc = osdc;
 	osd->o_osd = onum;
+	rb_init_node(&osd->o_node);
 	INIT_LIST_HEAD(&osd->o_requests);
 	INIT_LIST_HEAD(&osd->o_linger_requests);
 	INIT_LIST_HEAD(&osd->o_osd_lru);
-- 
1.7.9.5

