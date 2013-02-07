From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 07/15] common/config.cc: fix -Wgnu-designator
Date: Thu,  7 Feb 2013 20:41:55 +0100
Message-ID: <1360266123-28972-8-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33783 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932178Ab3BGTmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:08 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix 'struct ceph_file_layout g_default_file_layout' related
-Wgnu-designator warning from clang(++):

common/config.cc:61:2: warning: use of GNU old-style field
  designator extension [-Wgnu-designator]

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/config.cc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/common/config.cc b/src/common/config.cc
index 87b74ed..384c4b3 100644
--- a/src/common/config.cc
+++ b/src/common/config.cc
@@ -58,13 +58,13 @@ const char *CEPH_CONF_FILE_DEFAULT = "/etc/ceph/$cluster.conf, ~/.ceph/$cluster.
 
 // file layouts
 struct ceph_file_layout g_default_file_layout = {
- fl_stripe_unit: init_le32(1<<22),
- fl_stripe_count: init_le32(1),
- fl_object_size: init_le32(1<<22),
- fl_cas_hash: init_le32(0),
- fl_object_stripe_unit: init_le32(0),
- fl_unused: init_le32(-1),
- fl_pg_pool : init_le32(-1),
+ .fl_stripe_unit = init_le32(1<<22),
+ .fl_stripe_count = init_le32(1),
+ .fl_object_size = init_le32(1<<22),
+ .fl_cas_hash = init_le32(0),
+ .fl_object_stripe_unit = init_le32(0),
+ .fl_unused = init_le32(-1),
+ .fl_pg_pool = init_le32(-1),
 };
 
 #define _STR(x) #x
-- 
1.8.1.2

