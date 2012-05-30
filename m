From: Alex Elder <elder@inktank.com>
Subject: [PATCH 10/13] libceph: provide osd number when creating osd
Date: Wed, 30 May 2012 14:35:10 -0500
Message-ID: <4FC6766E.4050007@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61639 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab2E3TfK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:35:10 -0400
Received: by yenm10 with SMTP id m10so176756yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:35:10 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Pass the osd number to the create_osd() routine, and move the
initialization of fields that depend on it therein.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/osd_client.c |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cca4c7f..e30efbc 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -624,7 +624,7 @@ static void osd_reset(struct ceph_connection *con)
  /*
   * Track open sessions with osds.
   */
-static struct ceph_osd *create_osd(struct ceph_osd_client *osdc)
+static struct ceph_osd *create_osd(struct ceph_osd_client *osdc, int onum)
  {
  	struct ceph_osd *osd;

@@ -634,6 +634,7 @@ static struct ceph_osd *create_osd(struct 
ceph_osd_client *osdc)

  	atomic_set(&osd->o_ref, 1);
  	osd->o_osdc = osdc;
+	osd->o_osd = onum;
  	INIT_LIST_HEAD(&osd->o_requests);
  	INIT_LIST_HEAD(&osd->o_linger_requests);
  	INIT_LIST_HEAD(&osd->o_osd_lru);
@@ -643,6 +644,7 @@ static struct ceph_osd *create_osd(struct 
ceph_osd_client *osdc)
  	osd->o_con.private = osd;
  	osd->o_con.ops = &osd_con_ops;
  	osd->o_con.peer_name.type = CEPH_ENTITY_TYPE_OSD;
+	osd->o_con.peer_name.num = cpu_to_le64(onum);

  	INIT_LIST_HEAD(&osd->o_keepalive_item);
  	return osd;
@@ -998,15 +1000,13 @@ static int __map_request(struct ceph_osd_client 
*osdc,
  	req->r_osd = __lookup_osd(osdc, o);
  	if (!req->r_osd && o >= 0) {
  		err = -ENOMEM;
-		req->r_osd = create_osd(osdc);
+		req->r_osd = create_osd(osdc, o);
  		if (!req->r_osd) {
  			list_move(&req->r_req_lru_item, &osdc->req_notarget);
  			goto out;
  		}

  		dout("map_request osd %p is osd%d\n", req->r_osd, o);
-		req->r_osd->o_osd = o;
-		req->r_osd->o_con.peer_name.num = cpu_to_le64(o);
  		__insert_osd(osdc, req->r_osd);

  		ceph_con_open(&req->r_osd->o_con, &osdc->osdmap->osd_addr[o]);
-- 
1.7.5.4

