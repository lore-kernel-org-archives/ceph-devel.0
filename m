From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 05/15] common/AsyncReserver.h: use empty() instead of size()
Date: Thu,  7 Feb 2013 20:41:53 +0100
Message-ID: <1360266123-28972-6-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33795 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932204Ab3BGTmK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:10 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix warning for usage of queue.size() in do_queues(). Use empty()
since it should be prefered as it has, following the standard, a
constant time complexity regardless of the containter type. The
same is not guaranteed for size().

warning from cppchecker was:
[common/AsyncReserver.h:40]: (performance) Possible inefficient
  checking for 'queue' emptiness.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/AsyncReserver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/AsyncReserver.h b/src/common/AsyncReserver.h
index 8cc2258..638bfb3 100644
--- a/src/common/AsyncReserver.h
+++ b/src/common/AsyncReserver.h
@@ -37,7 +37,7 @@ class AsyncReserver {
 
   void do_queues() {
     while (in_progress.size() < max_allowed &&
-           queue.size()) {
+           !queue.empty()) {
       pair<T, Context*> p = queue.front();
       queue_pointers.erase(p.first);
       queue.pop_front();
-- 
1.8.1.2

