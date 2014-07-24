From: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
Subject: [PATCH 1/3] rgw: format help options to align with the rest
Date: Thu, 24 Jul 2014 20:30:41 +0530
Message-ID: <1406214043-23730-2-git-send-email-abhishek.lekshmanan@gmail.com>
References: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47716 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759339AbaGXPBc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 11:01:32 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so4085334pab.20
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 08:01:31 -0700 (PDT)
Received: from localhost.localdomain ([49.32.0.91])
        by mx.google.com with ESMTPSA id uj2sm21604517pab.14.2014.07.24.08.01.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jul 2014 08:01:29 -0700 (PDT)
In-Reply-To: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Whitespace removal to make all help options align in a similar fashion

Signed-off-by: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
---
 src/rgw/rgw_main.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/rgw/rgw_main.cc b/src/rgw/rgw_main.cc
index f6257d7..51cfebe 100644
--- a/src/rgw/rgw_main.cc
+++ b/src/rgw/rgw_main.cc
@@ -724,8 +724,8 @@ int usage()
 {
   cerr << "usage: radosgw [options...]" << std::endl;
   cerr << "options:\n";
-  cerr << "   --rgw-region=<region>     region in which radosgw runs\n";
-  cerr << "   --rgw-zone=<zone>         zone in which radosgw runs\n";
+  cerr << "  --rgw-region=<region>     region in which radosgw runs\n";
+  cerr << "  --rgw-zone=<zone>         zone in which radosgw runs\n";
   generic_server_usage();
   return 0;
 }
-- 
1.9.1

