From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH 3/3] monmap: clear addr_name map on calculating ranks
Date: Thu, 22 Dec 2011 18:49:04 +0800
Message-ID: <1324550944-8114-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42155 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab1LVKtO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 05:49:14 -0500
Received: by yhr47 with SMTP id 47so5837819yhr.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 02:49:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

We should clear addr_name before filling it. Otherwise, the removed
mon will stay there and cause incorrect rank assignment.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 src/mon/MonMap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/mon/MonMap.h b/src/mon/MonMap.h
index 651a146..ffeb572 100644
--- a/src/mon/MonMap.h
+++ b/src/mon/MonMap.h
@@ -40,6 +40,7 @@ class MonMap {
   void calc_ranks() {
     rank_name.resize(mon_addr.size());
     rank_addr.resize(mon_addr.size());
+    addr_name.clear();
     for (map<string,entity_addr_t>::iterator p = mon_addr.begin();
 	 p != mon_addr.end();
 	 p++) {
-- 
1.7.4.1

