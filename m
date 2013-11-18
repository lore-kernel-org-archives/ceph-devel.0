From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 1/2] rbd: Release resource before return
Date: Mon, 18 Nov 2013 15:40:18 +0800
Message-ID: <144b72fe66a7e9b851c551fd929648d470674a46.1384760071.git.liwang@ubuntukylin.com>
References: <cover.1384760071.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:40037 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3KRHkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 02:40:42 -0500
In-Reply-To: <cover.1384760071.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1384760071.git.liwang@ubuntukylin.com>
References: <cover.1384760071.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Close file before return.
Fix coverity issue: CID 1019579

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Reported-by: Xianxia Xiao <xianxiaxiao@ubuntukylin.com>
---
 src/rbd.cc |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/rbd.cc b/src/rbd.cc
index 41cd243..9556fb8 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -1125,8 +1125,10 @@ static int do_export_diff(librbd::Image& image, const char *fromsnapname,
     ::encode(endsize, bl);
 
     r = bl.write_fd(fd);
-    if (r < 0)
+    if (r < 0) {
+      close(fd);
       return r;
+    }
   }
 
   ExportContext ec(&image, fd, info.size);
@@ -1139,8 +1141,6 @@ static int do_export_diff(librbd::Image& image, const char *fromsnapname,
     bufferlist bl;
     ::encode(tag, bl);
     r = bl.write_fd(fd);
-    if (r < 0)
-      return r;
   }
 
  out:
-- 
1.7.9.5

