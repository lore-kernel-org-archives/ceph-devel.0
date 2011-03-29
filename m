From: Dan Carpenter <error27@gmail.com>
Subject: [patch 2/2] ceph: unlock on error in ceph_osdc_start_request()
Date: Tue, 29 Mar 2011 06:25:59 +0300
Message-ID: <20110329032559.GF9856@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53173 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab1C2D0P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 23:26:15 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

There was a missing unlock on the error path if __map_request() failed.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b6776cb..03740e8 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1672,7 +1672,7 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
 	if (req->r_sent == 0) {
 		rc = __map_request(osdc, req);
 		if (rc < 0)
-			return rc;
+			goto out_unlock;
 		if (req->r_osd == NULL) {
 			dout("send_request %p no up osds in pg\n", req);
 			ceph_monc_request_next_osdmap(&osdc->client->monc);
@@ -1689,6 +1689,8 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
 			}
 		}
 	}
+
+out_unlock:
 	mutex_unlock(&osdc->request_mutex);
 	up_read(&osdc->map_sem);
 	return rc;
