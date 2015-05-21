From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Rbd: support copy-on-read option
Date: Thu, 21 May 2015 15:16:05 +0800
Message-ID: <1432192565-11811-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:45618 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbbEUHXj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 03:23:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>

From: Min Chen <minchen@ubuntukylin.com>

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Reviewed-by: Li Wang <liwang@ubuntukylin.com>
---
 doc/man/8/rbd.rst | 1 +
 src/rbd.cc        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
index 4552951..3fb747f 100644
--- a/doc/man/8/rbd.rst
+++ b/doc/man/8/rbd.rst
@@ -430,6 +430,7 @@ the running kernel.
 
 * ro - Map the image read-only.  Equivalent to --read-only.
 
+* ro - Map the image with copy-on-read turned on.
 
 Examples
 ========
diff --git a/src/rbd.cc b/src/rbd.cc
index 4355c4f..fdc35ba 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -2545,6 +2545,8 @@ static int parse_map_options(char *options)
         return 1;
     } else if (!strcmp(this_char, "rw") || !strcmp(this_char, "ro")) {
       put_map_option("rw", this_char);
+    } else if (!strcmp(this_char, "cor")) {
+      put_map_option("cor", this_char);
     } else {
       cerr << "rbd: unknown map option '" << this_char << "'" << std::endl;
       return 1;
-- 
1.9.1

