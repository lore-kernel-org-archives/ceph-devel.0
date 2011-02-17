From: cclien <cclien@gmail.com>
Subject: [PATCH] rgw: Lighttpd compatibity.
Date: Thu, 17 Feb 2011 19:20:02 +0800
Message-ID: <AANLkTikEd8UUyy3ncf2DiDqR1Aa0UNDy3AVVGnVSyCxK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60452 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab1BQLUD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 06:20:03 -0500
Received: by vxb37 with SMTP id 37so1017425vxb.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 Feb 2011 03:20:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all

I just tried to deploy a rados gateway with Lighttpd.
But it have some trouble parsing object names.

Here's what I found in debug log on the non-working copy:
    RADOS S3 Gateway: SCRIPT_NAME=/mybucket
    RADOS S3 Gateway: REQUEST_URI=/mybucket/ceph.tgz

I think it will be better to retrive user's request from REQUEST_URI.

So I took some advantage on some unused variable, and then made this
patch (maybe a workaround).

Please help to review this, hope this patch helps.

Happy Hacking!

-CC


---
 src/rgw/rgw_rest.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/rgw/rgw_rest.cc b/src/rgw/rgw_rest.cc
index b923c42..1669e6f 100644
--- a/src/rgw/rgw_rest.cc
+++ b/src/rgw/rgw_rest.cc
@@ -493,7 +493,7 @@ void init_entities_from_header(struct req_state *s)
     }
   } else s->host_bucket = NULL;

-  const char *req_name = s->path_name;
+  const char *req_name = s->path_name_url.c_str();
   const char *p;

   if (*req_name == '?') {
-- 
1.7.0.4
