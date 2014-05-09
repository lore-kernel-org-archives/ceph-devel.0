From: Sage Weil <sage@inktank.com>
Subject: [PATCH] rules: add by-parttypeuuid rule for GPT labeled partitions
Date: Fri,  9 May 2014 14:31:37 -0700
Message-ID: <1399671097-32015-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40028 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900AbaEIVbn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 May 2014 17:31:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: systemd-devel@lists.freedesktop.org
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

The Ceph OSD initialization relies on identifying GPT partitions by type
in order to mount data volumes and start daemons.  Currently we ship this
rule separately, but it is awkward to duplicate the conditional logic that
precedes this block and it would be much simpler if it were simply included
in the upstream rules.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 rules/60-persistent-storage.rules |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rules/60-persistent-storage.rules b/rules/60-persistent-storage.rules
index 475b151..42f5edb 100644
--- a/rules/60-persistent-storage.rules
+++ b/rules/60-persistent-storage.rules
@@ -80,9 +80,10 @@ ENV{ID_FS_USAGE}=="filesystem|other", ENV{ID_FS_LABEL_ENC}=="?*", SYMLINK+="disk
 ENV{DEVTYPE}=="disk", ENV{ID_WWN_WITH_EXTENSION}=="?*", SYMLINK+="disk/by-id/wwn-$env{ID_WWN_WITH_EXTENSION}"
 ENV{DEVTYPE}=="partition", ENV{ID_WWN_WITH_EXTENSION}=="?*", SYMLINK+="disk/by-id/wwn-$env{ID_WWN_WITH_EXTENSION}-part%n"
 
-# by-partlabel/by-partuuid links (partition metadata)
+# by-partlabel/by-partuuid/by-parttypeuuid links (partition metadata)
 ENV{ID_PART_ENTRY_SCHEME}=="gpt", ENV{ID_PART_ENTRY_UUID}=="?*", SYMLINK+="disk/by-partuuid/$env{ID_PART_ENTRY_UUID}"
 ENV{ID_PART_ENTRY_SCHEME}=="gpt", ENV{ID_PART_ENTRY_NAME}=="?*", SYMLINK+="disk/by-partlabel/$env{ID_PART_ENTRY_NAME}"
+ENV{ID_PART_ENTRY_SCHEME}=="gpt", ENV{ID_PART_ENTRY_TYPE}=="?*", ENV{ID_PART_ENTRY_UUID}=="?*", SYMLINK+="disk/by-parttypeuuid/$env{ID_PART_ENTRY_TYPE}.$env{ID_PART_ENTRY_UUID}"
 
 # add symlink to GPT root disk
 ENV{ID_PART_ENTRY_SCHEME}=="gpt", ENV{ID_PART_GPT_AUTO_ROOT}=="1", SYMLINK+="gpt-auto-root"
-- 
1.7.9.5

