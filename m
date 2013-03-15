From: Sage Weil <sage@inktank.com>
Subject: Re: Direct IO on CephFS for blocks larger than 8MB
Date: Fri, 15 Mar 2013 09:33:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303150931160.23110@cobra.newdream.net>
References: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com>, <alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net> <F9E1A4A5-FE26-460B-A228-99033A36ECF8@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35782 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab3COQd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Mar 2013 12:33:59 -0400
In-Reply-To: <F9E1A4A5-FE26-460B-A228-99033A36ECF8@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Huang, Xiwei" <xiwei.huang@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 15 Mar 2013, Huang, Xiwei wrote:
> ok. Thanks. Is there any documentation for ceph fs client arch as a 
> reference if I'd like to look into this?

Not really.

The code you are interested in is fs/ceph/file.c.  The direct io path 
should be pretty clear; it'll build up a list of pages and pass it 
directly to the code in net/ceph/osd_client.c to go out over the wire.  
Enabling debugging (echo module ceph +p > 
/sys/kernel/debug/dynamic_debug/control, same for module libceph) and 
doing a single large direct-io write should show you where things are 
going wrong.

sage


> 
> ???? iPhone
> 
> ? 2013-3-14?23:23?"Sage Weil" <sage@inktank.com> ???
> 
> > On Thu, 14 Mar 2013, Huang, Xiwei wrote:
> >> Hi, all, 
> >>     I noticed that CephFS fails to support Direct IO for blocks larger than 8MB, say:
> >>            sudo dd if=/dev/zero of=mnt/cephfs/foo bs=16M count=1 oflag=direct
> >>            dd: writing `mnt/cephfs/foo: Bad address
> >>            1+0 records in
> >>            0+0 records out
> >>            0 bytes (0 B) copied, 0.213948 s, 0.0 kB/s
> >>    My version Ceph is 0.56.1. 
> >> ??I also found the bug has been already reported as Bug #2657.
> >>    Is this fixed in the new 0.58 version?
> > 
> > I'm pretty sure this is a problem on the kernel client side of things, not 
> > the server side (which by default handles writes up to ~100MB or so).  I 
> > suspect it isn't terribly difficult to fix, but hasn't been prioritized...
> > 
> > sage
> 
