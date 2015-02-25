From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH 3/6] Initialize ceph_mon trace, blkin (LTTng + Zipkin) tracing
Date: Wed, 25 Feb 2015 12:59:24 -0800
Message-ID: <1424897967-879-4-git-send-email-agshew@gmail.com>
References: <1424897967-879-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:46893 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbbBYU7g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 15:59:36 -0500
Received: by pdjy10 with SMTP id y10so7475848pdj.13
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 12:59:35 -0800 (PST)
In-Reply-To: <1424897967-879-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 src/ceph_mon.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
index e0ca6e2..6c3f03f 100644
--- a/src/ceph_mon.cc
+++ b/src/ceph_mon.cc
@@ -509,6 +509,8 @@ int main(int argc, const char **argv)
       prefork.exit(1);
   }
 
+  BLKIN_ZTRACE_INIT();
+
   MonitorDBStore *store = new MonitorDBStore(g_conf->mon_data);
   err = store->open(std::cerr);
   if (err < 0) {
-- 
2.1.0

