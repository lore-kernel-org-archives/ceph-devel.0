From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V2 3/6] Initialize blkin tracing in ceph_mon
Date: Tue, 25 Nov 2014 10:54:25 -0800
Message-ID: <1416941668-26150-4-git-send-email-agshew@gmail.com>
References: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:64986 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaKYSyZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 13:54:25 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so1101882pdb.32
        for <ceph-devel@vger.kernel.org>; Tue, 25 Nov 2014 10:54:24 -0800 (PST)
In-Reply-To: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Andrew Shewmaker <agshew@gmail.com>, Marios-Evaggelos Kogias <marioskogias@gmail.com>, Filippos Giannakos <philipgian@grnet.gr>

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 src/ceph_mon.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
index 4e84b4d..f16366c 100644
--- a/src/ceph_mon.cc
+++ b/src/ceph_mon.cc
@@ -418,6 +418,8 @@ int main(int argc, const char **argv)
     global_init_chdir(g_ceph_context);
   }
 
+  BLKIN_ZTRACE_INIT();
+
   MonitorDBStore *store = new MonitorDBStore(g_conf->mon_data);
 
   Monitor::StoreConverter converter(g_conf->mon_data, store);
-- 
2.1.0

