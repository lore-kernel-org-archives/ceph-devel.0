From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 14/15] test_mon_workloadgen.cc: fix -Wgnu
Date: Thu,  7 Feb 2013 20:42:02 +0100
Message-ID: <1360266123-28972-15-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33900 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422639Ab3BGTnw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:43:52 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix warning from clang(++):

 test/mon/test_mon_workloadgen.cc:311:23: warning: in-class
 initializer for static data member of type 'const double' is
 a GNU extension [-Wgnu]

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/mon/test_mon_workloadgen.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/test/mon/test_mon_workloadgen.cc b/src/test/mon/test_mon_workloadgen.cc
index 6c9d2bb..e86d285 100644
--- a/src/test/mon/test_mon_workloadgen.cc
+++ b/src/test/mon/test_mon_workloadgen.cc
@@ -308,7 +308,7 @@ class OSDStub : public TestStub
   boost::uniform_int<> mon_osd_rng;
 
   utime_t last_boot_attempt;
-  static const double STUB_BOOT_INTERVAL = 10.0;
+  static const double STUB_BOOT_INTERVAL;
 
 
  public:
@@ -902,6 +902,7 @@ class OSDStub : public TestStub
   }
 };
 
+double const OSDStub::STUB_BOOT_INTERVAL = 10.0;
 
 #undef dout_prefix
 #define dout_prefix *_dout << "main "
-- 
1.8.1.2

