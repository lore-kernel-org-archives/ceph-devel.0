From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 8/8] msg/Message.h: fix C-style pointer casting
Date: Wed,  6 Feb 2013 12:02:51 +0100
Message-ID: <1360148571-6984-9-git-send-email-danny.al-gaaf@bisect.de>
References: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:32967 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328Ab3BFLC4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:02:56 -0500
In-Reply-To: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Gary Lowell <gary.lowell@inktank.com>

Replace C-style pointer casting with correct static_cast<>().

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/msg/Message.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/msg/Message.h b/src/msg/Message.h
index 5bdd4d4..5e2b4f5 100644
--- a/src/msg/Message.h
+++ b/src/msg/Message.h
@@ -188,7 +188,7 @@ public:
   }
 
   Connection *get() {
-    return (Connection *)RefCountedObject::get();
+    return static_cast<Connection *>(RefCountedObject::get());
   }
 
   void set_priv(RefCountedObject *o) {
@@ -329,7 +329,7 @@ public:
   }
 
   Message *get() {
-    return (Message *)RefCountedObject::get();
+    return static_cast<Message *>(RefCountedObject::get());
   }
 
 protected:
-- 
1.8.1.2

