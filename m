From: michael rodriguez <michael@newdream.net>
Subject: [PATCH] update amazonaws xmlns to correct url
Date: Tue, 07 Feb 2012 20:35:22 -0800
Message-ID: <4F31FB8A.3000606@newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050401070108040908080502"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57267 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949Ab2BHEfW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2012 23:35:22 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 641B6BCAE2
	for <ceph-devel@vger.kernel.org>; Tue,  7 Feb 2012 20:35:22 -0800 (PST)
Received: from inez.local (unknown [12.248.40.138])
	by cobra.newdream.net (Postfix) with ESMTPSA id 50CA8BC77D
	for <ceph-devel@vger.kernel.org>; Tue,  7 Feb 2012 20:35:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050401070108040908080502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------050401070108040908080502
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="0001-update-amazonaws-xmlns-to-correct-url.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-update-amazonaws-xmlns-to-correct-url.patch"

From 93b4d576e555411de072ca0182fe3fed23b22182 Mon Sep 17 00:00:00 2001
From: michael rodriguez <michael@newdream.net>
Date: Tue, 7 Feb 2012 20:07:21 -0800
Subject: [PATCH] update amazonaws xmlns to correct url

---
 src/rgw/rgw_rest_s3.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/rgw/rgw_rest_s3.cc b/src/rgw/rgw_rest_s3.cc
index f420ada..44e3a9c 100644
--- a/src/rgw/rgw_rest_s3.cc
+++ b/src/rgw/rgw_rest_s3.cc
@@ -17,7 +17,7 @@ using namespace ceph::crypto;
 void list_all_buckets_start(struct req_state *s)
 {
   s->formatter->open_array_section_in_ns("ListAllMyBucketsResult",
-			      "http://doc.s3.amazonaws.com/2006-03-01");
+			      "http://s3.amazonaws.com/doc/2006-03-01/");
 }
 
 void list_all_buckets_end(struct req_state *s)
-- 
1.7.2.5



--------------050401070108040908080502--
