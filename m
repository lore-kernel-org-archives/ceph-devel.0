From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Fix memory leak in Backtrace::print()
Date: Wed, 30 Oct 2013 16:18:10 +0800
Message-ID: <1383121090-18727-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:46877 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab3J3ISW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 04:18:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Free already allocated memory if short of memory

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/common/BackTrace.cc |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/common/BackTrace.cc b/src/common/BackTrace.cc
index 6cace65..886ed6a 100644
--- a/src/common/BackTrace.cc
+++ b/src/common/BackTrace.cc
@@ -36,8 +36,10 @@ void BackTrace::print(std::ostream& out)
     if (begin && end) {
       int len = end - begin;
       char *foo = (char *)malloc(len+1);
-      if (!foo)
-        return;
+      if (!foo) {
+	free(function);
+	return;
+      }
       memcpy(foo, begin, len);
       foo[len] = 0;
 
-- 
1.7.9.5

