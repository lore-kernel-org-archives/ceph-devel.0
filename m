From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 06/15] common/WorkQueue.h: use empty() instead of size()
Date: Thu,  7 Feb 2013 20:41:54 +0100
Message-ID: <1360266123-28972-7-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33793 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932193Ab3BGTmJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:09 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix warning for usage of out->size() in _void_dequeue(). Use empty()
since it should be prefered as it has, following the standard, a
constant time complexity regardless of the containter type. The
same is not guaranteed for size().

warning from cppchecker was:
[common/WorkQueue.h:97]: (performance) Possible inefficient
  checking for 'queue' emptiness.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/WorkQueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/WorkQueue.h b/src/common/WorkQueue.h
index b19a6a2..ced952c 100644
--- a/src/common/WorkQueue.h
+++ b/src/common/WorkQueue.h
@@ -94,7 +94,7 @@ public:
     void *_void_dequeue() {
       list<T*> *out(new list<T*>);
       _dequeue(out);
-      if (out->size()) {
+      if (!out->empty()) {
 	return (void *)out;
       } else {
 	delete out;
-- 
1.8.1.2

