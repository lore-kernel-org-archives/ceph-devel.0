From: Sam Lang <samlang@gmail.com>
Subject: [PATCH 2/2] Fix typo in usage output for --num-osds
Date: Wed,  8 Jun 2011 12:59:12 -0500
Message-ID: <1307555952-10340-2-git-send-email-samlang@gmail.com>
References: <1307555952-10340-1-git-send-email-samlang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44462 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1FHR7U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2011 13:59:20 -0400
Received: by qyg14 with SMTP id 14so411224qyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jun 2011 10:59:20 -0700 (PDT)
In-Reply-To: <1307555952-10340-1-git-send-email-samlang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sam Lang <samlang@gmail.com>

This patch fixes the typo in the usage description to match the actual argument string.

Signed-off-by: Sam Lang <samlang@gmail.com>
---
 src/crushtool.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/crushtool.cc b/src/crushtool.cc
index 64b2b4f..4ea7e79 100644
--- a/src/crushtool.cc
+++ b/src/crushtool.cc
@@ -750,7 +750,7 @@ void usage()
   cout << "   --compile|-c map.txt  compile a map from source\n";
   cout << "   [-o outfile [--clobber]]\n";
   cout << "                         specify output for for (de)compilation\n";
-  cout << "   --build --num_osd N layer1 ...\n";
+  cout << "   --build --num_osds N layer1 ...\n";
   cout << "                         build a new map, where each 'layer' is\n";
   cout << "                           'name (uniform|straw|list|tree) size'\n";
   cout << "   --test mapfn          test a range of inputs on the map\n";
-- 
1.7.1

