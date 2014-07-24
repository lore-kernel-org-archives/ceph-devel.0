From: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
Subject: [PATCH 2/3] rgw: list all available options during help()
Date: Thu, 24 Jul 2014 20:30:42 +0530
Message-ID: <1406214043-23730-3-git-send-email-abhishek.lekshmanan@gmail.com>
References: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50288 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759335AbaGXPBd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 11:01:33 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so3816410pdj.16
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 08:01:33 -0700 (PDT)
Received: from localhost.localdomain ([49.32.0.91])
        by mx.google.com with ESMTPSA id uj2sm21604517pab.14.2014.07.24.08.01.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jul 2014 08:01:32 -0700 (PDT)
In-Reply-To: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Adding the available help arguments from the man page

Fixes: #8112
Signed-off-by: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
---
 src/rgw/rgw_main.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/rgw/rgw_main.cc b/src/rgw/rgw_main.cc
index 51cfebe..29d6577 100644
--- a/src/rgw/rgw_main.cc
+++ b/src/rgw/rgw_main.cc
@@ -726,7 +726,13 @@ int usage()
   cerr << "options:\n";
   cerr << "  --rgw-region=<region>     region in which radosgw runs\n";
   cerr << "  --rgw-zone=<zone>         zone in which radosgw runs\n";
+  cerr << "  --rgw-socket-path=<path>  specify a unix domain socket path\n";
   generic_server_usage();
+  cerr << "  -m monaddress[:port]      connect to specified monitor\n";
+  cerr << "  --keyring=<path>          path to radosgw keyring\n";
+  cerr << "  --logfile=<logfile>       file to log debug output\n";
+  cerr << "  --debug-rgw=<log-level>/<memory-level>  Set radosgw debug level\n";
+
   return 0;
 }
 
-- 
1.9.1

