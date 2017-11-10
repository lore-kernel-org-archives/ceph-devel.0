From: Sage Weil <sweil@redhat.com>
Subject: C++11, std::list::size(), and trusty
Date: Fri, 10 Nov 2017 17:47:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbdKJRrZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Nov 2017 12:47:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com
Cc: kchai@redhat.com, ncutler@suse.com, james.page@ubuntu.com

We noticed a big performance regression when switching some code to 
use list::size() because although C++11 promizes that it is O(1), some of 
the libstdc++'s out there are still O(n).  This PR aims to fix that

	https://github.com/ceph/ceph/pull/18863

by adding the various devtoolset packages as dependencies to pull in 
updated build toolchains.  For el7 that's devtoolset-7-{binutils,gcc-c++}.

I'm not sure what the requirement for deb-based distros is.  
ubuntu-toolchain-r?

My preference would to move our build requirements forward so that you 
have to have a modern libstdc++ in order to build, allowing us to make 
C++11-ish assumptions (like an O(1) list::size()).

1) Is this needed for xenial, or just trusty?

2) If only trusty, should we do something weird here to keep 
buliding for it post-luminous, or can we (finally!) drop the trusty 
builds?

sage
