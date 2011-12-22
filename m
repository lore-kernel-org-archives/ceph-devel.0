From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH 1/3] interval_set: fix truncation of _size
Date: Thu, 22 Dec 2011 18:47:25 +0800
Message-ID: <1324550845-8031-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49246 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab1LVKsM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 05:48:12 -0500
Received: by yhr47 with SMTP id 47so5837493yhr.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 02:48:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

_size is type of int64_t. Use int to store the value of _size
will cause value truncation.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 src/include/interval_set.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/include/interval_set.h b/src/include/interval_set.h
index ae1c7ff..bfc62a9 100644
--- a/src/include/interval_set.h
+++ b/src/include/interval_set.h
@@ -361,7 +361,7 @@ class interval_set {
 
   void swap(interval_set<T>& other) {
     m.swap(other.m);
-    int t = _size;
+    int64_t t = _size;
     _size = other._size;
     other._size = t;
   }    
-- 
1.7.4.1

