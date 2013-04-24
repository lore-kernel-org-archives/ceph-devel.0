From: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Subject: Re: Unique bug in ceph start script
Date: Wed, 24 Apr 2013 09:56:30 +0200
Message-ID: <20130424075630.GA7395@upset.ux.pdb.fsc.net>
References: <20130422150612.GA22006@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304220836140.15710@cobra.newdream.net> <20130423064101.GA24976@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304231001160.19511@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:64158 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757249Ab3DXH4w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Apr 2013 03:56:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1304231001160.19511@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Di, Apr 23, 2013 at 10:01:53 -0700, Sage Weil wrote:
...
> > So in this example two config files with different names but the same
> > content would be copied to hosta. This is not very pretty but it 
> > should work without error.
> 
> It's because of the $pushed_to list.. for #3 it wouldn't re-push 
> ceph.conf.  I pushed a patch that just skips that optimization entirely:
> 
> https://github.com/ceph/ceph/commit/ccbc4dbc6edf09626459ca52a53a72682f541e86
> 
> Look okay to you?

Yes, but I'm not happy with the trap instruction:

  trap "ssh $host rm /tmp/ceph.conf.$unique" EXIT

If the start script exits with or without error, the remote config 
file will be removed from <remote-host>:/tmp - but only for the last 
host (the former trap calls will be overwritten by the last trap
call)! This makes no sense to me.

Best regards
Andreas
