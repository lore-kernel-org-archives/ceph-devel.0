From: Sage Weil <sage@inktank.com>
Subject: Re: Unique bug in ceph start script
Date: Tue, 23 Apr 2013 10:01:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304231001160.19511@cobra.newdream.net>
References: <20130422150612.GA22006@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304220836140.15710@cobra.newdream.net> <20130423064101.GA24976@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47509 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab3DWRBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Apr 2013 13:01:54 -0400
In-Reply-To: <20130423064101.GA24976@upset.ux.pdb.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 23 Apr 2013, Andreas Friedrich wrote:
> On Mo, Apr 22, 2013 at 08:39:03 -0700, Sage Weil wrote:
> 
> Hi Sage,
> 
> ...
> > Thanks for the report!  I think this doesn't quite solve the problem, 
> > though.  If all the items for a given target are processed in order, then 
> > $unique will be correct, but if you get hosta, hostb, hosta then it will 
> > be wrong.
> ...
> 
> sorry, but I don't recognize why it would be wrong:
> 
> Applying my patch the code would do the following:
> 
> 1. hosta:
>    Create ceph.conf.uniq1, copy it to hosta and use
>    ceph.conf.uniq1.
> 
> 2. hostb:
>    Create ceph.conf.uniq2, copy it to hostb and use
>    ceph.conf.uniq2.
> 
> 3. hosta:
>    Create ceph.conf.uniq3, copy it to hosta and use
>    ceph.conf.uniq3.
> 
> So in this example two config files with different names but the same
> content would be copied to hosta. This is not very pretty but it 
> should work without error.

It's because of the $pushed_to list.. for #3 it wouldn't re-push 
ceph.conf.  I pushed a patch that just skips that optimization entirely:

https://github.com/ceph/ceph/commit/ccbc4dbc6edf09626459ca52a53a72682f541e86

Look okay to you?

Thanks!
sage
