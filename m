From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V5 3/6] Initialize ceph_mon trace, blkin (LTTng + Zipkin) tracing
Date: Mon,  2 Mar 2015 16:35:12 -0800
Message-ID: <1425342915-12553-4-git-send-email-agshew@gmail.com>
References: <1425342915-12553-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34852 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbbCCAfM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 19:35:12 -0500
Received: by pabli10 with SMTP id li10so18900590pab.2
        for <ceph-devel@vger.kernel.org>; Mon, 02 Mar 2015 16:35:12 -0800 (PST)
In-Reply-To: <1425342915-12553-1-git-send-email-agshew@gmail.com>
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

