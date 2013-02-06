From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 7/8] messages/MOSDRepScrub.h: initialize member variable in constructor
Date: Wed,  6 Feb 2013 12:02:50 +0100
Message-ID: <1360148571-6984-8-git-send-email-danny.al-gaaf@bisect.de>
References: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:32955 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757303Ab3BFLC4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:02:56 -0500
In-Reply-To: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Gary Lowell <gary.lowell@inktank.com>

Initialize chunky and deep bool member variables in the constructor
with false.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/messages/MOSDRepScrub.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/messages/MOSDRepScrub.h b/src/messages/MOSDRepScrub.h
index 2d3a66d..86edbe2 100644
--- a/src/messages/MOSDRepScrub.h
+++ b/src/messages/MOSDRepScrub.h
@@ -36,7 +36,10 @@ struct MOSDRepScrub : public Message {
   hobject_t end;         // upper bound of scrub, exclusive
   bool deep;             // true if scrub should be deep
 
-  MOSDRepScrub() : Message(MSG_OSD_REP_SCRUB, HEAD_VERSION, COMPAT_VERSION) { }
+  MOSDRepScrub() : Message(MSG_OSD_REP_SCRUB, HEAD_VERSION, COMPAT_VERSION), 
+      chunky(false),
+      deep(false) { } 
+
   MOSDRepScrub(pg_t pgid, eversion_t scrub_from, eversion_t scrub_to,
 	       epoch_t map_epoch)
     : Message(MSG_OSD_REP_SCRUB, HEAD_VERSION, COMPAT_VERSION),
-- 
1.8.1.2

