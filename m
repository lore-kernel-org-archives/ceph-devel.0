From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 13/15] src/osd/osd_types.h: pass function parameter by reference
Date: Thu,  7 Feb 2013 20:42:01 +0100
Message-ID: <1360266123-28972-14-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34188 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422653Ab3BGTsw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:48:52 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix "(performance) Function parameter 'e' should be passed by reference."
from cppchecker.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/osd/osd_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/osd/osd_types.h b/src/osd/osd_types.h
index e068057..b193c2b 100644
--- a/src/osd/osd_types.h
+++ b/src/osd/osd_types.h
@@ -496,7 +496,7 @@ inline bool operator>(const eversion_t& l, const eversion_t& r) {
 inline bool operator>=(const eversion_t& l, const eversion_t& r) {
   return (l.epoch == r.epoch) ? (l.version >= r.version):(l.epoch >= r.epoch);
 }
-inline ostream& operator<<(ostream& out, const eversion_t e) {
+inline ostream& operator<<(ostream& out, const eversion_t& e) {
   return out << e.epoch << "'" << e.version;
 }
 
-- 
1.8.1.2

