From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH] crushtool: fix args parsing
Date: Fri, 23 Sep 2011 00:39:20 +0800
Message-ID: <1316709560-6521-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51914 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab1IVQjl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2011 12:39:41 -0400
Received: by yib18 with SMTP id 18so2029105yib.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2011 09:39:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

Fix --add-item and --loc args parsing.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 src/crushtool.cc |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/src/crushtool.cc b/src/crushtool.cc
index 51531aa..f0ccb9b 100644
--- a/src/crushtool.cc
+++ b/src/crushtool.cc
@@ -872,9 +872,6 @@ int main(int argc, const char **argv)
       }
       if (i == args.end())
 	usage();
-      i = args.erase(i);
-      if (i == args.end())
-	usage();
       add_weight = atof(*i);
       i = args.erase(i);
       if (i == args.end())
@@ -885,9 +882,6 @@ int main(int argc, const char **argv)
       std::string type(val);
       if (i == args.end())
 	usage();
-      i = args.erase(i);
-      if (i == args.end())
-	usage();
       std::string name(*i);
       i = args.erase(i);
       add_loc[type] = name;
@@ -897,9 +891,6 @@ int main(int argc, const char **argv)
       reweight_name = val;
       if (i == args.end())
 	usage();
-      i = args.erase(i);
-      if (i == args.end())
-	usage();
       reweight_weight = atof(*i);
       i = args.erase(i);
     } else if (ceph_argparse_flag(args, i, "--build", (char*)NULL)) {
@@ -954,10 +945,8 @@ int main(int argc, const char **argv)
       int dev = tmp;
       if (i == args.end())
 	usage();
-      i = args.erase(i);
-      if (i == args.end())
-	usage();
       float f = atof(*i);
+      i = args.erase(i);
       int w = (int)(f * 0x10000);
       if (w < 0)
 	w = 0;
-- 
1.7.4.1

