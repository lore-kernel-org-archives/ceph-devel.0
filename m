From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 6/8] include/xlist.h: fix C-style pointer casting
Date: Tue,  5 Feb 2013 23:52:28 +0100
Message-ID: <1360104750-16098-7-git-send-email-danny.al-gaaf@bisect.de>
References: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:50850 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756400Ab3BEWwh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 17:52:37 -0500
In-Reply-To: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Replace C-style pointer casting with correct static_cast<>().

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/include/xlist.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/include/xlist.h b/src/include/xlist.h
index 5c2bf03..5384561 100644
--- a/src/include/xlist.h
+++ b/src/include/xlist.h
@@ -132,8 +132,8 @@ public:
     assert((bool)_front == (bool)_size);
   }
 
-  T front() { return (T)_front->_item; }
-  T back() { return (T)_back->_item; }
+  T front() { return static_cast<T>(_front->_item); }
+  T back() { return static_cast<T>(_back->_item); }
 
   void pop_front() {
     assert(!empty());
@@ -149,7 +149,7 @@ public:
     item *cur;
   public:
     iterator(item *i = 0) : cur(i) {}
-    T operator*() { return (T)cur->_item; }
+    T operator*() { return static_cast<T>(cur->_item); }
     iterator& operator++() {
       assert(cur);
       assert(cur->_list);
-- 
1.8.1.2

