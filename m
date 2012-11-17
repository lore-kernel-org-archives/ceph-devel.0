From: Chen Baozi <baozich@gmail.com>
Subject: Fail to build the latest ceph tree on Fedora 17
Date: Sat, 17 Nov 2012 19:29:00 +0800
Message-ID: <20121117112900.GA23992@cbz-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34110 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2KQL3H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 06:29:07 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2483795pbc.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 03:29:07 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, everyone.

I was tring to build the latest ceph tree on my fedora 17 box.
However, there is an error message when linking radosgw as following:

  CXXLD  radosgw
  /usr/bin/ld: radosgw-rgw_resolve.o: undefined reference to symbol
  '__res_nquery@@GLIBC_2.2.5'
  /usr/bin/ld: note: '__res_nquery@@GLIBC_2.2.5' is defined in DSO
  /lib64/libresolv.so.2 so try adding it to the linker command line
  /lib64/libresolv.so.2: could not read symbols: Invalid operation
  collect2: error: ld returned 1 exit status
  make[3]: *** [radosgw] Error 1
  make[3]: Leaving directory `/home/cbz/src/ceph/src'
  make[2]: *** [all-recursive] Error 1
  make[2]: Leaving directory `/home/cbz/src/ceph/src'
  make[1]: *** [all] Error 2
  make[1]: Leaving directory `/home/cbz/src/ceph/src'
  make: *** [all-recursive] Error 1

I've also tried build the version 0.53 which is checked out from
fedora's pkg repo. And it can pass the building process without this
error.

Any suggestion?

Yours,

        Chen Baozi
