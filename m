From: Sage Weil <sage@inktank.com>
Subject: Re: [RFC] add rocksdb support
Date: Tue, 20 May 2014 18:19:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405201814330.1689@cobra.newdream.net>
References: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35520 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaEUBTD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 May 2014 21:19:03 -0400
In-Reply-To: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Xinxin,

I've pushed an updated wip-rocksdb to github/liewegas/ceph.git that 
includes the latest set of patches with the groundwork and your rocksdb 
patch.  There is also a commit that adds rocksdb as a git submodule.  I'm 
thinking that, since there aren't any distro packages for rocksdb at this 
point, this is going to be the easiest way to make this usable for people.

If you can wire the submodule into the makefile, we can merge this in so 
that rocksdb support is in the ceph.com packages on ceph.com.  I suspect 
that the distros will prefer to turns this off in favor of separate shared 
libs, but they can do this at their option if/when they include rocksdb in 
the distro. I think the key is just to have both --with-librockdb and 
--with-librocksdb-static (or similar) options so that you can either use 
the static or dynamically linked one.

Has your group done further testing with rocksdb?  Anything interesting to 
share?

Thanks!
sage

