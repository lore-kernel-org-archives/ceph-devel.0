From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] config: Remove debug output in conf_get
Date: Thu, 28 Apr 2011 15:03:08 +0200
Message-ID: <1303995788-31867-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:54708 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab1D1NDP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 09:03:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/common/config.cc |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/common/config.cc b/src/common/config.cc
index 695e039..8b4ce85 100644
--- a/src/common/config.cc
+++ b/src/common/config.cc
@@ -734,7 +734,6 @@ get_val(const char *key, char **buf, int len) const
   // In key names, leading and trailing whitespace are not significant.
   string k(ConfFile::normalize_key_name(key));
 
-  cout << "get_val(key='" << key << "'): k = '" << k << "'" << std::endl;
   for (int i = 0; i < NUM_CONFIG_OPTIONS; ++i) {
     const config_option *opt = &config_optionsp[i];
     if (strcmp(opt->name, k.c_str()))
-- 
1.7.0.4

