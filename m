From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: kfree() in put_osd() shouldn't depend on authorizer
Date: Wed, 18 Feb 2015 16:27:19 +0300
Message-ID: <1424266039-40851-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:44058 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbBRN13 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 08:27:29 -0500
Received: by lams18 with SMTP id s18so1049945lam.11
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 05:27:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

a255651d4cad ("ceph: ensure auth ops are defined before use") made
kfree() in put_osd() conditional on the authorizer.  A mechanical
mistake most likely - fix it.

Cc: Alex Elder <elder@linaro.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f693a2f8ac86..41a4abc7e98e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1035,10 +1035,11 @@ static void put_osd(struct ceph_osd *osd)
 {
 	dout("put_osd %p %d -> %d\n", osd, atomic_read(&osd->o_ref),
 	     atomic_read(&osd->o_ref) - 1);
-	if (atomic_dec_and_test(&osd->o_ref) && osd->o_auth.authorizer) {
+	if (atomic_dec_and_test(&osd->o_ref)) {
 		struct ceph_auth_client *ac = osd->o_osdc->client->monc.auth;
 
-		ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
+		if (osd->o_auth.authorizer)
+			ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
 		kfree(osd);
 	}
 }
-- 
1.9.3

