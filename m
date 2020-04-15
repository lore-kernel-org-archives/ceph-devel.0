From: Abhishek <abhishek@suse.com>
Subject: v14.2.9 Nautilus released
Date: Wed, 15 Apr 2020 08:28:04 +0200
Message-ID: <0b3e826b07b4561d9553bc3e21aa264b@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634828AbgDOG2H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:28:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.io, ceph-users@ceph.io, dev@ceph.io, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.io

This is the ninth bugfix release of Nautilus. This release fixes a 
couple of security issues in RGW & Messenger V2. We recommend all users 
to upgrade to this release. The official release blog entry is at 
https://ceph.io/releases/v14-2-9-nautilus-released/

Notable Changes:
- CVE-2020-1759: Fixed nonce reuse in msgr V2 secure mode
- CVE-2020-1760: Fixed XSS due to RGW GetObject header-splitting

Getting Ceph
------------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-14.2.9.tar.gz
* For packages, see
http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 581f22da52345dba46ee232b73b990f06029a2a0

Best,
Abhishek
