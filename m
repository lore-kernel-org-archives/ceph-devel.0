From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 2/2] mds: Release resource before return
Date: Mon, 18 Nov 2013 15:40:19 +0800
Message-ID: <29600d7aede767b7f10879bd858ec1003cadc477.1384760071.git.liwang@ubuntukylin.com>
References: <cover.1384760071.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:40048 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3KRHkl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 02:40:41 -0500
In-Reply-To: <cover.1384760071.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1384760071.git.liwang@ubuntukylin.com>
References: <cover.1384760071.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Close file before return.
Fix coverity issue: CID 1019571

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Reported-by: Xianxia Xiao <xianxiaxiao@ubuntukylin.com>
---
 src/mds/MDCache.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index ae59c26..17d4ce4 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -11731,7 +11731,7 @@ void MDCache::dump_cache(const char *fn)
     std::string s = ss.str();
     r = safe_write(fd, s.c_str(), s.length());
     if (r < 0)
-      return;
+      goto out;
 
     list<CDir*> dfs;
     in->get_dirfrags(dfs);
-- 
1.7.9.5

