From: nikita.gerasimov@oracle.com
Subject: [PATCH] ceph-detect-init: Adds Oracle Linux Server and Oracle VM Server detection
Date: Mon, 27 Feb 2017 21:06:07 +0300
Message-ID: <1488218767-14618-1-git-send-email-nikita.gerasimov@oracle.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:29794 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdB0SI1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 13:08:27 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
        by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1RI7pLG021887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 18:07:51 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1RI6N3s030017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 18:06:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v1RI6NOq005132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 18:06:23 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v1RI6MfT031195
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 18:06:23 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Nikita Gerasimov <nikita.gerasimov@oracle.com>

Oracle Linux Server is API/ABI compatible with RHEL/CentOS Linux distro.
Oracle VM Server is Xen based VM server. Which modern versions Dom0 is based on Oracle Linux 6

Signed-off-by: Nikita Gerasimov <nikita.gerasimov@oracle.com>
---
 src/ceph-detect-init/ceph_detect_init/__init__.py      | 18 ++++++++++++++++--
 .../ceph_detect_init/oraclevm/__init__.py              | 11 +++++++++++
 src/ceph-detect-init/tests/test_all.py                 |  8 ++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py

diff --git a/src/ceph-detect-init/ceph_detect_init/__init__.py b/src/ceph-detect-init/ceph_detect_init/__init__.py
index aad3eee..c057409 100644
--- a/src/ceph-detect-init/ceph_detect_init/__init__.py
+++ b/src/ceph-detect-init/ceph_detect_init/__init__.py
@@ -24,6 +24,7 @@ from ceph_detect_init import suse
 from ceph_detect_init import gentoo
 from ceph_detect_init import freebsd
 from ceph_detect_init import docker
+from ceph_detect_init import oraclevm
 import os
 import logging
 import platform
@@ -44,7 +45,8 @@ def get(use_rhceph=False):
     module.normalized_name = _normalized_distro_name(distro_name)
     module.distro = module.normalized_name
     module.is_el = module.normalized_name in ['redhat', 'centos',
-                                              'fedora', 'scientific']
+                                              'fedora', 'scientific',
+                                              'oraclel']
     module.release = release
     module.codename = codename
     module.init = module.choose_init()
@@ -64,6 +66,8 @@ def _get_distro(distro, use_rhceph=False):
         'linuxmint': debian,
         'centos': centos,
         'scientific': centos,
+        'oraclel': centos,
+        'oraclevm': oraclevm,
         'redhat': centos,
         'fedora': fedora,
         'suse': suse,
@@ -90,6 +94,10 @@ def _normalized_distro_name(distro):
         return 'suse'
     elif distro.startswith('centos'):
         return 'centos'
+    elif distro.startswith('oracle linux'):
+        return 'oraclel'
+    elif distro.startswith('oracle vm'):
+        return 'oraclevm'
     elif distro.startswith(('gentoo', 'funtoo', 'exherbo')):
         return 'gentoo'
     return distro
@@ -128,7 +136,8 @@ def platform_information():
         raise exc.UnsupportedPlatform(platform.system(), '', '')
 
     # this could be an empty string in Debian
-    if not codename and 'debian' in distro.lower():
+    distro_lower = distro.lower()
+    if not codename and 'debian' in distro_lower:
         debian_codenames = {
             '8': 'jessie',
             '7': 'wheezy',
@@ -136,6 +145,11 @@ def platform_information():
         }
         major_version = release.split('.')[0]
         codename = debian_codenames.get(major_version, '')
+    # this is an empty string in Oracle
+    elif distro_lower.startswith('oracle linux'):
+        codename = 'OL' + release
+    elif distro_lower.startswith('oracle vm'):
+        codename = 'OVM' + release
 
         # In order to support newer jessie/sid or wheezy/sid strings
         # we test this if sid is buried in the minor, we should use
diff --git a/src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py b/src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py
new file mode 100644
index 0000000..f7bf85b
--- /dev/null
+++ b/src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py
@@ -0,0 +1,11 @@
+distro = None
+release = None
+codename = None
+
+
+def choose_init():
+    """Select a init system
+
+    Returns the name of a init system (upstart, sysvinit ...).
+    """
+    return 'sysvinit'
diff --git a/src/ceph-detect-init/tests/test_all.py b/src/ceph-detect-init/tests/test_all.py
index d2733c3..d621943 100644
--- a/src/ceph-detect-init/tests/test_all.py
+++ b/src/ceph-detect-init/tests/test_all.py
@@ -35,6 +35,7 @@ from ceph_detect_init import suse
 from ceph_detect_init import gentoo
 from ceph_detect_init import freebsd
 from ceph_detect_init import docker
+from ceph_detect_init import oraclevm
 
 logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s',
                     level=logging.DEBUG)
@@ -54,6 +55,9 @@ class TestCephDetectInit(testtools.TestCase):
     def test_docker(self):
         self.assertEqual('none', docker.choose_init())
 
+    def test_oraclevm(self):
+        self.assertEqual('sysvinit', oraclevm.choose_init())
+
     def test_centos(self):
         with mock.patch('ceph_detect_init.centos.release',
                         '7.0'):
@@ -207,6 +211,8 @@ class TestCephDetectInit(testtools.TestCase):
         self.assertEqual(debian, g('ubuntu'))
         self.assertEqual(centos, g('centos'))
         self.assertEqual(centos, g('scientific'))
+        self.assertEqual(centos, g('Oracle Linux Server'))
+        self.assertEqual(oraclevm, g('Oracle VM server'))
         self.assertEqual(fedora, g('fedora'))
         self.assertEqual(suse, g('suse'))
         self.assertEqual(rhel, g('redhat', use_rhceph=True))
@@ -222,6 +228,8 @@ class TestCephDetectInit(testtools.TestCase):
         self.assertEqual('scientific', n('Scientific'))
         self.assertEqual('scientific', n('Scientific Linux'))
         self.assertEqual('scientific', n('scientific linux'))
+        self.assertEqual('oraclel', n('Oracle Linux Server'))
+        self.assertEqual('oraclevm', n('Oracle VM server'))
         self.assertEqual('suse', n('SUSE'))
         self.assertEqual('suse', n('suse'))
         self.assertEqual('suse', n('openSUSE'))
-- 
1.8.3.1

