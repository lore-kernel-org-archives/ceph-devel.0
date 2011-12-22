From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH 2/3] monmap: iterate over addr_name when printing summary
Date: Thu, 22 Dec 2011 18:48:29 +0800
Message-ID: <1324550909-8077-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60366 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab1LVKsp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 05:48:45 -0500
Received: by yenm11 with SMTP id m11so5131811yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 02:48:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

The rank is now ordered by IP address. We should iterate over
addr_name.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 src/mon/MonMap.cc |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/mon/MonMap.cc b/src/mon/MonMap.cc
index 89c6666..69de6a2 100644
--- a/src/mon/MonMap.cc
+++ b/src/mon/MonMap.cc
@@ -45,10 +45,10 @@ void MonMap::print(ostream& out) const
   out << "last_changed " << last_changed << "\n";
   out << "created " << created << "\n";
   unsigned i = 0;
-  for (map<string,entity_addr_t>::const_iterator p = mon_addr.begin();
-       p != mon_addr.end();
+  for (map<entity_addr_t,string>::const_iterator p = addr_name.begin();
+       p != addr_name.end();
        p++)
-    out << i++ << ": " << p->second << " mon." << p->first << "\n";
+    out << i++ << ": " << p->first << " mon." << p->second << "\n";
 }
 
 void MonMap::dump(Formatter *f) const
@@ -59,13 +59,13 @@ void MonMap::dump(Formatter *f) const
   f->dump_stream("created") << created;
   f->open_array_section("mons");
   int i = 0;
-  for (map<string,entity_addr_t>::const_iterator p = mon_addr.begin();
-       p != mon_addr.end();
+  for (map<entity_addr_t,string>::const_iterator p = addr_name.begin();
+       p != addr_name.end();
        ++p, ++i) {
     f->open_object_section("mon");
     f->dump_int("rank", i);
-    f->dump_string("name", p->first);
-    f->dump_stream("addr") << p->second;
+    f->dump_string("name", p->second);
+    f->dump_stream("addr") << p->first;
     f->close_section();
   }
   f->close_section();
-- 
1.7.4.1

