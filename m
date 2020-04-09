From: Abhishek <abhishek@suse.com>
Subject: v15.2.1 Octopus released
Date: Thu, 09 Apr 2020 19:36:31 +0200
Message-ID: <57f63719d6aaa7990b158e657b2fa822@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDIRgc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:36:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.io, ceph-users@ceph.io, dev@ceph.io, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.io

This is the first bugfix release of Ceph Octopus, we recommend all 
Octopus users
upgrade. This release fixes an upgrade issue and also has 2 security 
fixes

Notable Changes
~~~~~~~~~~~~~~~

* issue#44759: Fixed luminous->nautilus->octopus upgrade asserts
* CVE-2020-1759: Fixed nonce reuse in msgr V2 secure mode
* CVE-2020-1760: Fixed XSS due to RGW GetObject header-splitting

For the full changelog please refer to the official release blog entry 
at https://ceph.io/releases/v15-2-1-octopus-released/, for upgrades from 
previous versions, please follow the relevant section of the upgrade 
docs at 
https://docs.ceph.com/docs/master/releases/octopus/#upgrading-from-mimic-or-nautilus


Getting Ceph
------------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-15.2.1.tar.gz
* For packages, see 
http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 9fd2f65f91d9246fae2c841a6222d34d121680ee
