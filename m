From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 5/8] include/types.h: change operator<< function parameter
Date: Wed,  6 Feb 2013 12:02:48 +0100
Message-ID: <1360148571-6984-6-git-send-email-danny.al-gaaf@bisect.de>
References: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:32984 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757370Ab3BFLC5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:02:57 -0500
In-Reply-To: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Gary Lowell <gary.lowell@inktank.com>

Fix "Function parameter 'v' should be passed by reference." from cppchecker.
Use 'const pair<A,B>& v' similar to the other operator<< in this file.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/include/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/include/types.h b/src/include/types.h
index c783b6e..dff47ac 100644
--- a/src/include/types.h
+++ b/src/include/types.h
@@ -120,7 +120,7 @@ namespace __gnu_cxx {
 // -- io helpers --
 
 template<class A, class B>
-inline ostream& operator<<(ostream& out, const pair<A,B> v) {
+inline ostream& operator<<(ostream& out, const pair<A,B>& v) {
   return out << v.first << "," << v.second;
 }
 
-- 
1.8.1.2

