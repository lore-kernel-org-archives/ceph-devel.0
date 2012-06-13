From: Sage Weil <sage@inktank.com>
Subject: Re: debian updates
Date: Wed, 13 Jun 2012 08:53:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206130851230.25437@cobra.newdream.net>
References: <Pine.LNX.4.64.1206111939390.10716@cobra.newdream.net>
 <1339471174.7726.71.camel@julia> <Pine.LNX.4.64.1206121004050.6742@cobra.newdream.net>
 <1339563927.7726.90.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36370 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab2FMPxa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 11:53:30 -0400
In-Reply-To: <1339563927.7726.90.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

On Wed, 13 Jun 2012, Laszlo Boszormenyi (GCS) wrote:
> On Tue, 2012-06-12 at 10:06 -0700, Sage Weil wrote:
> > On Tue, 12 Jun 2012, Laszlo Boszormenyi (GCS) wrote:
> > > I can package it if
> > > you want. Now my fingers are crossed to accept libs3 soon, it's freeze
> > > for Wheezy soon[1]. Ceph 0.47.2 is waiting for that to be in Wheezy.
>  libs3 got accepted into the archives and being built on all
> architectures. In 12 hours the binaries will be available for the build
> network itself. This means I can upload Ceph 0.47.2 soon.
> 
> > Great!  Let me know if there's anything else that can be fixed up on this 
> > end.
>  I had a minor issue with building system libs3 and leveldb libraries.
> The build system of Ceph was still looking for
> $(BUILDDIR)/src/leveldb/libleveldb.a . Put a symlink there
> to /usr/lib/$(ARCH)/libleveldb.a and it was built. I'll recheck this
> issue in the afternoon.

The wip-leveldb branch should fix this.  Once I verify it builds correctly 
everywhere I'll push it to master.

Also, 0.48 will be released in a few more days.  If there isn't a rush on 
getting this in, it is probably worth waiting to put that in wheezy.  It 
looks like 0.48 will also be the basis for one of our first 'stable' 
releases.

sage
