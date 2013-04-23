From: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Subject: Re: Unique bug in ceph start script
Date: Tue, 23 Apr 2013 08:41:01 +0200
Message-ID: <20130423064101.GA24976@upset.ux.pdb.fsc.net>
References: <20130422150612.GA22006@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304220836140.15710@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:45234 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab3DWGlX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Apr 2013 02:41:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1304220836140.15710@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mo, Apr 22, 2013 at 08:39:03 -0700, Sage Weil wrote:

Hi Sage,

...
> Thanks for the report!  I think this doesn't quite solve the problem, 
> though.  If all the items for a given target are processed in order, then 
> $unique will be correct, but if you get hosta, hostb, hosta then it will 
> be wrong.
...

sorry, but I don't recognize why it would be wrong:

Applying my patch the code would do the following:

1. hosta:
   Create ceph.conf.uniq1, copy it to hosta and use
   ceph.conf.uniq1.

2. hostb:
   Create ceph.conf.uniq2, copy it to hostb and use
   ceph.conf.uniq2.

3. hosta:
   Create ceph.conf.uniq3, copy it to hosta and use
   ceph.conf.uniq3.

So in this example two config files with different names but the same
content would be copied to hosta. This is not very pretty but it 
should work without error.

Andreas
