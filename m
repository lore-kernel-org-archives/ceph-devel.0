From: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
Subject: [PATCH 3/3] doc: update radosgw man page with available opts
Date: Thu, 24 Jul 2014 20:30:43 +0530
Message-ID: <1406214043-23730-4-git-send-email-abhishek.lekshmanan@gmail.com>
References: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44016 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759339AbaGXPBg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 11:01:36 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so4102930pad.13
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 08:01:35 -0700 (PDT)
Received: from localhost.localdomain ([49.32.0.91])
        by mx.google.com with ESMTPSA id uj2sm21604517pab.14.2014.07.24.08.01.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jul 2014 08:01:34 -0700 (PDT)
In-Reply-To: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Fixes:#8112
Signed-off-by: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
---
 doc/man/8/radosgw.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/man/8/radosgw.rst b/doc/man/8/radosgw.rst
index 5e5e3c0..7aa9655 100644
--- a/doc/man/8/radosgw.rst
+++ b/doc/man/8/radosgw.rst
@@ -32,10 +32,38 @@ Options
    Connect to specified monitor (instead of looking through
    ``ceph.conf``).
 
+.. option:: -i ID, --id ID
+
+   Set the ID portion of name for radosgw
+
+.. option:: -n TYPE.ID, --name TYPE.ID
+
+   Set the name for rados gateway (eg. client.radosgw.gateway)
+
+.. option:: --cluster NAME
+
+   Set the cluster name (default: ceph)
+
+.. option:: -d
+
+   Run in foreground, log to stderr
+
+.. option:: -f
+
+   Run in foreground, log to usual location
+
 .. option:: --rgw-socket-path=path
 
    Specify a unix domain socket path.
 
+.. option:: --rgw-region=region
+
+   The region where radosgw runs
+
+.. option:: --rgw-zone=zone
+
+   The zone where radosgw runs
+
 
 Configuration
 =============
-- 
1.9.1

