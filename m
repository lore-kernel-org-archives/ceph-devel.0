From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 3/3] ceph-test.install: updated filelist
Date: Mon,  4 Feb 2013 18:22:44 +0100
Message-ID: <1359998564-27004-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:60025 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753696Ab3BDRWt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 12:22:49 -0500
In-Reply-To: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Don't install rest-bench twice, it's already part of the rest-bench package.

Add some files which are part of the ceph-test package on RPM based
distributions already: ceph_test_mon_workloadgen, ceph_rgw_jsonparser,
ceph_test_objectcacher_stress.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 debian/ceph-test.install | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/debian/ceph-test.install b/debian/ceph-test.install
index bc5137b..a3648c3 100644
--- a/debian/ceph-test.install
+++ b/debian/ceph-test.install
@@ -5,8 +5,8 @@ usr/bin/ceph_multi_stress_watch
 usr/bin/ceph_omapbench
 usr/bin/ceph_psim
 usr/bin/ceph_radosacl
-usr/bin/ceph_rest-bench
 usr/bin/ceph_rgw_multiparser
+usr/bin/ceph_rgw_jsonparser
 usr/bin/ceph_scratchtool
 usr/bin/ceph_scratchtoolpp
 usr/bin/ceph_smalliobench
@@ -31,8 +31,10 @@ usr/bin/ceph_test_keyvaluedb_iterators
 usr/bin/ceph_test_libcephfs
 usr/bin/ceph_test_librbd
 usr/bin/ceph_test_librbd_fsx
+usr/bin/ceph_test_mon_workloadgen
 usr/bin/ceph_test_mutate
 usr/bin/ceph_test_object_map
+usr/bin/ceph_test_objectcacher_stress
 usr/bin/ceph_test_rados_api_aio
 usr/bin/ceph_test_rados_api_cls
 usr/bin/ceph_test_rados_api_io
-- 
1.8.1.2

