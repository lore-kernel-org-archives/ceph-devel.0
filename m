From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: dpkg-buildpackage failed on Ubuntu 16.4 - 'override_dh_auto_build'
 failed
Date: Tue, 19 Jul 2016 09:09:51 +0000
Message-ID: <DB5PR05MB1607AA6E7B4D217AA82E6DCDA9370@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:9680
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753451AbcGSOmU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 10:42:20 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

What is the recommended way to install my builds of ceph?

Following ceph instruction here http://docs.ceph.com/docs/master/install/build-ceph/ on a Ubuntu 16.4 machine, I got the following errors from dpkg-buildpackage -j32 (after 1-2 hours of waiting :-( ):

   dh_auto_build: make -j32 returned exit code 2
   debian/rules:28: recipe for target 'override_dh_auto_build' failed
   make[1]: *** [override_dh_auto_build] Error 2
   make[1]: Leaving directory '/mnt/sdb/avnerb/ceph'
   debian/rules:22: recipe for target 'build' failed
   make: *** [build] Error 2
   dpkg-buildpackage: error: debian/rules build gave error exit status 2

According to debian here https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=777814 this error might be related to gcc-5.

Anyhow, I only want to use the recommended way for installing my builds of ceph (Preferred one that can be installed over a cluster that was deployed using ceph-deploy)

I tried "make install" and encountered errors.
dpkg-buildpackage also failed for me

Can someone advise please

TIA,
  Avner
