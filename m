From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Package issue in hammer branch on ubuntu
Date: Mon, 17 Aug 2015 09:58:32 +0000
Message-ID: <C226B0AB34511445928D9882AA519F601C46FF47@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0066.outbound.protection.outlook.com ([65.55.169.66]:12458
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754671AbbHQLag convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 07:30:36 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

When I tried to build and install the packages on hammer branch. Facing the issue mentioned below.

$dpkg -i ceph-common_0.94.2-1_amd64.deb
Selecting previously unselected package ceph-common.
(Reading database ... 57855 files and directories currently installed.)
Preparing to unpack .../ceph-common_0.94.2-1_amd64.deb ...
Unpacking ceph-common (0.94.2-1) ...
Setting up ceph-common (0.94.2-1) ...
Processing triggers for ureadahead (0.100.0-16) ...
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...

$dpkg -i ceph_0.94.2-1_amd64.deb
Selecting previously unselected package ceph.
(Reading database ... 57891 files and directories currently installed.)
Preparing to unpack .../ceph//ceph_0.94.2-1_amd64.deb ...
Unpacking ceph (0.94.2-1) ...
 dpkg: dependency problems prevent configuration of ceph:
  ceph depends on ceph-common (>= 0.94.2-2); however:
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
   Version of ceph-common on system is 0.94.2-1.
  ceph-common (0.94.2-1) breaks ceph (<< 0.94.2-2) and is installed.
   Version of ceph to be configured is 0.94.2-1.

 dpkg: error processing package ceph (--install):
 dependency problems - leaving unconfigured
Processing triggers for ureadahead (0.100.0-16) ...
 Errors were encountered while processing:
  ceph
 command returned non-zero exit status: 1


Seems in debian/control , ceph version is mentioned as 0.94.2-2 than 0.94.2-1. Change log files contains the build till 0.94.2-1. Made the following change, my installation went through.

diff --git a/debian/control b/debian/control
index 246bebc..0f6ad2a 100644
--- a/debian/control
+++ b/debian/control
@@ -60,7 +60,7 @@ Standards-Version: 3.9.3
 Package: ceph
 Architecture: linux-any
 Depends: binutils,
-         ceph-common (>= 0.94.2-2),
+         ceph-common (>= 0.94.2-1),
          cryptsetup-bin | cryptsetup,
          gdisk,
          parted,
@@ -92,8 +92,8 @@ Architecture: linux-any
 Section: debug
 Priority: extra
 Depends: ceph (= ${binary:Version}), ${misc:Depends}
-Replaces: ceph-test-dbg (<< 0.94.2-2)
-Breaks: ceph-test-dbg (<< 0.94.2-2)
+Replaces: ceph-test-dbg (<< 0.94.2-1)
+Breaks: ceph-test-dbg (<< 0.94.2-1)
 Description: debugging symbols for ceph
  Ceph is a distributed storage system designed to provide excellent
  performance, reliability, and scalability.
@@ -191,10 +191,10 @@ Depends: librbd1 (= ${binary:Version}), ${misc:Depends}, ${shlibs:Depends},
         python-requests
 Conflicts: ceph-client-tools
 Replaces: ceph-client-tools,
-         ceph (<< 0.94.2-2),
+         ceph (<< 0.94.2-1),
          python-ceph (<< 0.92-1223),
          librbd1 (<< 0.92-1238)
-Breaks: ceph (<< 0.94.2-2),
+Breaks: ceph (<< 0.94.2-1),
        python-ceph (<< 0.92-1223),
        librbd1 (<< 0.92-1238)
 Suggests: ceph, ceph-mds


Not sure if that is the correct change, anyone facing same issue?

Varada

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

