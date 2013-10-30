From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] ceph: Release resource before return in BackedObject::download()
Date: Wed, 30 Oct 2013 21:32:34 +0800
Message-ID: <1383139954-21951-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:52867 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3J3Ncl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 09:32:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Close file before return

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/tools/rados/rados_sync.cc |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/tools/rados/rados_sync.cc b/src/tools/rados/rados_sync.cc
index 03293d3..d2d6ab5 100644
--- a/src/tools/rados/rados_sync.cc
+++ b/src/tools/rados/rados_sync.cc
@@ -579,6 +579,7 @@ int BackedUpObject::download(IoCtx &io_ctx, const char *path)
     if (rlen < 0) {
       cerr << ERR_PREFIX << "download: io_ctx.read(" << rados_name << ") returned "
 	   << rlen << std::endl;
+      fclose(fp);
       return rlen;
     }
     if (rlen < CHUNK_SZ)
-- 
1.7.9.5

