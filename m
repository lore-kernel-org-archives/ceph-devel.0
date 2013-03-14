From: Greg Farnum <greg@inktank.com>
Subject: Re: Direct IO on CephFS for blocks larger than 8MB
Date: Thu, 14 Mar 2013 08:44:15 -0700
Message-ID: <1868F843065B483E80E7B83A24F389D2@inktank.com>
References: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:34606 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933550Ab3CNPoU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 11:44:20 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so2396711pbc.2
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 08:44:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Huang=2C_Xiwei?= <xiwei.huang@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thursday, March 14, 2013 at 8:20 AM, Sage Weil wrote:
> On Thu, 14 Mar 2013, Huang, Xiwei wrote:
> > Hi, all, 
> > I noticed that CephFS fails to support Direct IO for blocks larger than 8MB, say:
> > sudo dd if=/dev/zero of=mnt/cephfs/foo bs=16M count=1 oflag=direct
> > dd: writing `mnt/cephfs/foo: Bad address
> > 1+0 records in
> > 0+0 records out
> > 0 bytes (0 B) copied, 0.213948 s, 0.0 kB/s
> > My version Ceph is 0.56.1. 
> > ??I also found the bug has been already reported as Bug #2657.
> > Is this fixed in the new 0.58 version? 
> 
> 
> 
> I'm pretty sure this is a problem on the kernel client side of things, not 
> the server side (which by default handles writes up to ~100MB or so). I 
> suspect it isn't terribly difficult to fix, but hasn't been prioritized...
> 
> sage 
My guess too. Are direct IO writes of that size a common thing or of great import to you?
Either way, a comment on the tracker saying you've run into it will promote it up when we're doing bug scrubs and backlog reviews. :) 
-Greg

