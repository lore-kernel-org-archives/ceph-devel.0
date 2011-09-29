From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH] rgw: set xmlns on ListBucketResult element
Date: Thu, 29 Sep 2011 15:35:23 +0800
Message-ID: <1317281723-3928-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45912 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab1I2Hfj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 03:35:39 -0400
Received: by ggnv2 with SMTP id v2so22662ggn.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2011 00:35:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

Certain S3 clients (e.g., s3fs) require the xmlns to parse the
results correctly.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 src/rgw/rgw_rest_s3.cc |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/rgw/rgw_rest_s3.cc b/src/rgw/rgw_rest_s3.cc
index 38dcff1..666e831 100644
--- a/src/rgw/rgw_rest_s3.cc
+++ b/src/rgw/rgw_rest_s3.cc
@@ -125,7 +125,8 @@ void RGWListBucket_REST_S3::send_response()
   if (ret < 0)
     return;
  
-  s->formatter->open_object_section("ListBucketResult");
+  s->formatter->open_object_section_in_ns("ListBucketResult",
+                  "http://s3.amazonaws.com/doc/2006-03-01/");
   s->formatter->dump_format("Name", s->bucket_name);
   if (!prefix.empty())
     s->formatter->dump_format("Prefix", prefix.c_str());
-- 
1.7.4.1

