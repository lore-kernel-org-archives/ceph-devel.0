From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH 2/6] Initialize blkin tracing in ceph_mon
Date: Wed, 12 Nov 2014 16:20:13 -0700
Message-ID: <20141112232013.GC6892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50117 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbaKLXUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 18:20:17 -0500
Received: by mail-pd0-f178.google.com with SMTP id fp1so13140653pdb.37
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 15:20:16 -0800 (PST)
Received: from localhost (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id vt8sm2922733pbc.66.2014.11.12.15.20.15
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 15:20:15 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 src/ceph_mon.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
index 4e84b4d..8b1784a 100644
--- a/src/ceph_mon.cc
+++ b/src/ceph_mon.cc
@@ -418,6 +418,8 @@ int main(int argc, const char **argv)
     global_init_chdir(g_ceph_context);
   }
 
+  ZTracer::ztrace_init();
+
   MonitorDBStore *store = new MonitorDBStore(g_conf->mon_data);
 
   Monitor::StoreConverter converter(g_conf->mon_data, store);
-- 
2.1.0

