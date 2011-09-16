From: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
Subject: [PATCH 1/2] doc: Add section about changing config values
Date: Fri, 16 Sep 2011 14:58:28 -0700
Message-ID: <1316210308-13560-1-git-send-email-cmccabe@alumni.cmu.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47219 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab1IPWMo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 18:12:44 -0400
Received: by ywb5 with SMTP id 5so3232718ywb.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2011 15:12:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>, Colin McCabe <colin.mccabe@dreamhost.com>

Signed-off-by: Colin McCabe <colin.mccabe@dreamhost.com>
---
 doc/dev/config.rst |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/doc/dev/config.rst b/doc/dev/config.rst
index 59f1b92..a4fdb49 100644
--- a/doc/dev/config.rst
+++ b/doc/dev/config.rst
@@ -51,7 +51,7 @@ There are a few different metavariables:
  - $name: expands to $type.$id
 
 
-Interfacing with the Configuration Management System
+Readin configuration values
 ====================================================
 
 There are two ways for Ceph code to get configuration values. One way is to
@@ -75,3 +75,16 @@ The observer method should be preferred in new code because
 
 For these reasons, reading directly from g_conf should be considered deprecated
 and not done in new code.  Do not ever alter g_conf.
+
+Changing configuration values
+====================================================
+
+Configuration values can be changed by calling g_conf->set_val. After changing
+the configuration, you should call g_conf->apply_changes to re-run all the
+affected configuration observers. For convenience, you can call
+g_conf->set_val_or_die to make a configuration change which you think should
+never fail.
+
+Injectargs, parse_argv, and parse_env are three other functions which modify
+the configuration. Just like with set_val, you should call apply_changes after
+calling these functions to make sure your changes get applied.
-- 
1.7.2.5

