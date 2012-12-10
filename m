From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] libceph: init osd->o_node in create_osd()
Date: Sun, 09 Dec 2012 18:36:35 -0600
Message-ID: <50C52E93.8070100@inktank.com>
References: <50C52DE5.9070602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36033 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab2LJAgi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 19:36:38 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6461626ieb.19
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 16:36:38 -0800 (PST)
In-Reply-To: <50C52DE5.9070602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It turns out to be harmless but the red-black node o_node in the
ceph osd structure is not initialized in create_osd().  Add a
call to rb_init_node() initialize it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1a42701..c018e52 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -568,6 +568,7 @@ static struct ceph_osd *create_osd(struct
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

