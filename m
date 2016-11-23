From: Sage Weil <sweil@redhat.com>
Subject: Re: Static analysis
Date: Wed, 23 Nov 2016 14:23:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611231411060.21102@piezo.us.to>
References: <20161123070637.GF26846@rskikr.localdomain> <20161123072524.GE26997@predictor>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-769008010-1479910545=:21102"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936229AbcKWObm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 23 Nov 2016 09:31:42 -0500
In-Reply-To: <20161123072524.GE26997@predictor>
Content-ID: <alpine.DEB.2.11.1611231421540.21102@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <branch@predictor.org.pl>
Cc: Brad Hubbard <bhubbard@redhat.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-769008010-1479910545=:21102
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1611231421541.21102@piezo.us.to>

On Wed, 23 Nov 2016, Piotr Da³ek wrote:
> On Wed, Nov 23, 2016 at 05:06:37PM +1000, Brad Hubbard wrote:
> > I did a run of the Clang Static Analyzer and it turned up multiple issues which
> > Kefu gobbled up :) The reports are quite detailed and walk you through how the
> > issue can present.
> > 
> > See https://github.com/ceph/ceph/pull/12145 and
> > https://github.com/ceph/ceph/pull/12148
> > 
> > Given how easy it is to run [1] (although slow) would it be a good idea to be
> > running this regulary, perhaps in addition to coverity scans?
> > 
> > [1] mkdir build && cd build && scan-build cmake .. && scan-build make -jX
> 
> +1. Certainly this will help finding out obscure bugs that show up later in
> unexpected places.

Yes!

I tried to get a coverity run through but ran into problems.  Perhaps 
someone else has time to look into it?

I've updated the run-coverity script and I have this out of tree to run 
from cron, something like

#!/bin/sh -x
cd ~/src
rm -rf ceph.coverity
git clone git://github.com/ceph/ceph ceph.coverity
cd ceph.coverity
src/script/run-coverity

There is a coverity.build.pass.txt you can grab offline in order to submit 
the results to scan.coverity.com, but currently it complains that not 
enough compilation units succeeded, so we need to fix that first.  In 
build/cov-int/build-log.txt you find errors like

"/usr/lib/gcc/x86_64-redhat-linux/6.2.1/../../../../include/c++/6.2.1/bits/stl_tree.h", line 1437: error #20: 
          identifier "_Compare" is undefined
             && is_nothrow_move_assignable<_Compare>::value)
                                           ^

"/usr/lib/gcc/x86_64-redhat-linux/6.2.1/../../../../include/c++/6.2.1/bits/stl_tree.h", line 1778: error #20: 
          identifier "_Compare" is undefined
      _GLIBCXX_NOEXCEPT_IF(__is_nothrow_swappable<_Compare>::value)
      ^

"/usr/lib/gcc/x86_64-redhat-linux/6.2.1/../../../../include/c++/6.2.1/bits/hashtable.h", line 1239: error #20: 
          identifier "_H1" is undefined
      noexcept(__is_nothrow_swappable<_H1>::value
                                      ^

"/usr/lib/gcc/x86_64-redhat-linux/6.2.1/../../../../include/c++/6.2.1/bits/hashtable.h", line 1240: error #20: 
          identifier "_Equal" is undefined
             && __is_nothrow_swappable<_Equal>::value)
                                       ^

4 errors detected in the compilation of "/home/sage/src/ceph.coverity/src/kv/LevelDBStore.cc".
Emit for file '/home/sage/src/ceph.coverity/src/kv/LevelDBStore.cc' complete.
WARNING: cov-emit returned with code 1

for pretty much every file.  This is on Fedora 24.  Someone want to try on 
another platform?

sage

--8323329-769008010-1479910545=:21102--
