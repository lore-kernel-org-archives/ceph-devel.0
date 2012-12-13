From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/9] libceph: avoid using freed osd in __kick_osd_requests()
Date: Thu, 13 Dec 2012 11:01:42 -0600
Message-ID: <50CA09F6.9080606@inktank.com>
References: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65258 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab2LMRBp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:01:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so4281511ieb.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:01:45 -0800 (PST)
In-Reply-To: <50CA0915.1090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If an osd has no requests and no linger requests, __reset_osd()
will just remove it with a call to __remove_osd().  That drops
a reference to the osd, and therefore the osd may have been free
by the time __reset_osd() returns.  That function offers no
indication this may have occurred, and as a result the osd will
continue to be used even when it's no longer valid.

Change__reset_osd() so it returns an error (ENODEV) when it
deletes the osd being reset.  And change __kick_osd_requests() so it
returns immediately (before referencing osd again) if __reset_osd()
returns *any* error.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ac7be72..60c74c1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -581,7 +581,7 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,

 	dout("__kick_osd_requests osd%d\n", osd->o_osd);
 	err = __reset_osd(osdc, osd);
-	if (err == -EAGAIN)
+	if (err)
 		return;

 	list_for_each_entry(req, &osd->o_requests, r_osd_item) {
@@ -745,6 +745,7 @@ static int __reset_osd(struct ceph_osd_client *osdc,
struct ceph_osd *osd)
 	if (list_empty(&osd->o_requests) &&
 	    list_empty(&osd->o_linger_requests)) {
 		__remove_osd(osdc, osd);
+		ret = -ENODEV;
 	} else if (memcmp(&osdc->osdmap->osd_addr[osd->o_osd],
 			  &osd->o_con.peer_addr,
 			  sizeof(osd->o_con.peer_addr)) == 0 &&
-- 
1.7.9.5

