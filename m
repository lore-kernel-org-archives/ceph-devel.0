From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 02/15] common/config.h: declaration of config_option as struct
Date: Thu,  7 Feb 2013 20:41:50 +0100
Message-ID: <1360266123-28972-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33774 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932171Ab3BGTmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:08 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Change declaration of config_option from 'class' to 'struct' since
it's defined as struct and used this way (access members). The declaration
as class doesn't change the behaviour.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/config.h b/src/common/config.h
index 9bf04fe..cf397bb 100644
--- a/src/common/config.h
+++ b/src/common/config.h
@@ -33,7 +33,7 @@ extern struct ceph_file_layout g_default_file_layout;
 #define OSD_REP_SPLAY   1
 #define OSD_REP_CHAIN   2
 
-class config_option;
+struct config_option;
 class CephContext;
 
 extern const char *CEPH_CONF_FILE_DEFAULT;
-- 
1.8.1.2

