From: nikita.gerasimov@oracle.com
Subject: [PATCH] ceph-detect-init: Adds Oracle Linux Server and Oracle VM Server detection
Date: Thu,  2 Mar 2017 19:51:52 +0300
Message-ID: <1488473512-4374-1-git-send-email-nikita.gerasimov@oracle.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:33158 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbdCBR2R (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 12:28:17 -0500
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
        by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v22Gr750013483
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Thu, 2 Mar 2017 16:53:07 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v22Gq5X3016970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Thu, 2 Mar 2017 16:52:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v22Gq4qR025203
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Thu, 2 Mar 2017 16:52:05 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v22Gq4b4004781
        for <ceph-devel@vger.kernel.org>; Thu, 2 Mar 2017 16:52:04 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Nikita Gerasimov <nikita.gerasimov@oracle.com>

Oracle Linux Server is API/ABI compatible with RHEL/CentOS Linux distro.
Oracle VM Server is Xen based VM server. Which modern versions Dom0 is based on el6

Signed-off-by: Nikita Gerasimov <nikita.gerasimov@oracle.com>

run-make-check.sh: http://paste.ubuntu.com/24096418/
---
 install-deps.sh                                        |  2 +-
 src/ceph-detect-init/ceph_detect_init/__init__.py      | 18 ++++++++++++++++--
 .../ceph_detect_init/oraclevms/__init__.py             | 11 +++++++++++
 src/ceph-detect-init/tests/test_all.py                 | 18 ++++++++++++++++++
 4 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py

diff --git a/install-deps.sh b/install-deps.sh
index 41d393d..e1e8722 100755
--- a/install-deps.sh
+++ b/install-deps.sh
@@ -88,7 +88,7 @@ else
 	$SUDO env DEBIAN_FRONTEND=noninteractive apt-get -y remove ceph-build-deps
 	if [ -n "$backports" ] ; then rm $control; fi
         ;;
-    centos|fedora|rhel)
+    centos|fedora|rhel|ol)
         yumdnf="yum"
         builddepcmd="yum-builddep -y"
         if test "$(echo "$VERSION_ID >= 22" | bc)" -ne 0; then
diff --git a/src/ceph-detect-init/ceph_detect_init/__init__.py b/src/ceph-detect-init/ceph_detect_init/__init__.py
index aad3eee..9abc421 100644
--- a/src/ceph-detect-init/ceph_detect_init/__init__.py
+++ b/src/ceph-detect-init/ceph_detect_init/__init__.py
@@ -24,6 +24,7 @@ from ceph_detect_init import suse
 from ceph_detect_init import gentoo
 from ceph_detect_init import freebsd
 from ceph_detect_init import docker
+from ceph_detect_init import oraclevms
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
+        'oraclevms': oraclevms,
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
+        return 'oraclevms'
     elif distro.startswith(('gentoo', 'funtoo', 'exherbo')):
         return 'gentoo'
     return distro
@@ -127,8 +135,9 @@ def platform_information():
     else:
         raise exc.UnsupportedPlatform(platform.system(), '', '')
 
+    distro_lower = distro.lower()
     # this could be an empty string in Debian
-    if not codename and 'debian' in distro.lower():
+    if not codename and 'debian' in distro_lower:
         debian_codenames = {
             '8': 'jessie',
             '7': 'wheezy',
@@ -146,6 +155,11 @@ def platform_information():
                 codename = minor
             else:
                 codename = major
+    # this is an empty string in Oracle
+    elif distro_lower.startswith('oracle linux'):
+        codename = 'OL' + release
+    elif distro_lower.startswith('oracle vm'):
+        codename = 'OVS' + release
 
     return (
         str(distro).rstrip(),
diff --git a/src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py b/src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py
new file mode 100644
index 0000000..f7bf85b
--- /dev/null
+++ b/src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py
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
index d2733c3..eb48bb4 100644
--- a/src/ceph-detect-init/tests/test_all.py
+++ b/src/ceph-detect-init/tests/test_all.py
@@ -35,6 +35,7 @@ from ceph_detect_init import suse
 from ceph_detect_init import gentoo
 from ceph_detect_init import freebsd
 from ceph_detect_init import docker
+from ceph_detect_init import oraclevms
 
 logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s',
                     level=logging.DEBUG)
@@ -54,6 +55,9 @@ class TestCephDetectInit(testtools.TestCase):
     def test_docker(self):
         self.assertEqual('none', docker.choose_init())
 
+    def test_oraclevms(self):
+        self.assertEqual('sysvinit', oraclevms.choose_init())
+
     def test_centos(self):
         with mock.patch('ceph_detect_init.centos.release',
                         '7.0'):
@@ -207,6 +211,8 @@ class TestCephDetectInit(testtools.TestCase):
         self.assertEqual(debian, g('ubuntu'))
         self.assertEqual(centos, g('centos'))
         self.assertEqual(centos, g('scientific'))
+        self.assertEqual(centos, g('Oracle Linux Server'))
+        self.assertEqual(oraclevms, g('Oracle VM server'))
         self.assertEqual(fedora, g('fedora'))
         self.assertEqual(suse, g('suse'))
         self.assertEqual(rhel, g('redhat', use_rhceph=True))
@@ -222,6 +228,8 @@ class TestCephDetectInit(testtools.TestCase):
         self.assertEqual('scientific', n('Scientific'))
         self.assertEqual('scientific', n('Scientific Linux'))
         self.assertEqual('scientific', n('scientific linux'))
+        self.assertEqual('oraclel', n('Oracle Linux Server'))
+        self.assertEqual('oraclevms', n('Oracle VM server'))
         self.assertEqual('suse', n('SUSE'))
         self.assertEqual('suse', n('suse'))
         self.assertEqual('suse', n('openSUSE'))
@@ -266,6 +274,16 @@ class TestCephDetectInit(testtools.TestCase):
             self.assertEqual(('debian', 'sid/jessie', 'sid'),
                              ceph_detect_init.platform_information())
 
+        with mock.patch('platform.linux_distribution',
+                        lambda **kwargs: (('Oracle Linux Server', '7.3', ''))):
+            self.assertEqual(('Oracle Linux Server', '7.3', 'OL7.3'),
+                             ceph_detect_init.platform_information())
+
+        with mock.patch('platform.linux_distribution',
+                        lambda **kwargs: (('Oracle VM server', '3.4.2', ''))):
+            self.assertEqual(('Oracle VM server', '3.4.2', 'OVS3.4.2'),
+                             ceph_detect_init.platform_information())
+
     @mock.patch('platform.linux_distribution')
     def test_platform_information_container(self, mock_linux_dist):
         import sys
-- 
1.8.3.1

