From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: ./make-debs.sh / dpkg-buildpackage failed because of
 override_dh_auto_configure from debian/rules
Date: Wed, 3 Aug 2016 11:42:31 +0000
Message-ID: <DB5PR05MB1607E14365A8266A29A7E260A9060@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0065.outbound.protection.outlook.com ([104.47.2.65]:33862
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752496AbcHDFb3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2016 01:31:29 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

Running ./make-debs.sh from Ceph master branch on Ubuntu-16.04 produces the error below:
=====
    debian/rules:25: recipe for target 'override_dh_auto_configure' failed
    make[1]: *** [override_dh_auto_configure] Error 2
    make[1]: Leaving directory '/mnt/sdh/avnerb/deb-v11.0.0/Ubuntu/WORKDIR/ceph-11.0.0-1228-gc162a8a'
    debian/rules:22: recipe for target 'build' failed
    make: *** [build] Error 2
    dpkg-buildpackage: error: debian/rules build gave error exit status 2
=====
I saw that recently there were changes in this area for gitbuilder to enable cmake. Perhaps it is related??

Anyhow, is there a way to create deb packages? Or, is there a plan to fix this situation?
TIA,
  Avner
