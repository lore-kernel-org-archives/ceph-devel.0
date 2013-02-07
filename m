From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 03/15] src/msg/msg_types.h: pass function parameter by reference
Date: Thu,  7 Feb 2013 20:41:51 +0100
Message-ID: <1360266123-28972-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33786 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932179Ab3BGTmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:08 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix "Function parameter 'm' should be passed by reference." from cppchecker.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/msg/msg_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/msg/msg_types.h b/src/msg/msg_types.h
index 8f3d74b..e80639e 100644
--- a/src/msg/msg_types.h
+++ b/src/msg/msg_types.h
@@ -142,7 +142,7 @@ inline std::ostream& operator<<(std::ostream& out, const ceph_entity_name& addr)
 namespace __gnu_cxx {
   template<> struct hash< entity_name_t >
   {
-    size_t operator()( const entity_name_t m ) const
+    size_t operator()( const entity_name_t &m ) const
     {
       return rjhash32(m.type() ^ m.num());
     }
-- 
1.8.1.2

