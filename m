From: Sage Weil <sage@newdream.net>
Subject: Re: claims to be ... - wrong node!
Date: Fri, 12 Nov 2010 10:09:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011121005350.13140@cobra.newdream.net>
References: <AANLkTikN49QYMDw4WhatqtcQjBn_8cFsDfm+VPjyud0x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52136 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab0KLSFp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Nov 2010 13:05:45 -0500
In-Reply-To: <AANLkTikN49QYMDw4WhatqtcQjBn_8cFsDfm+VPjyud0x@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 12 Nov 2010, Christian Brunner wrote:
> Presumably I'm doing something wrong here, but I don't have clue what to...
> 
> After restarting one of our osd-servers I get the following messages
> in the cosd-log:
> 
> 2010-11-12 10:24:31.965058 7f5bac380710 -- 10.255.0.60:6802/17175 >>
> 10.255.0.60:6800/15859 pipe(0x7f5b98089300 sd=26 pgs=0 cs=0
> l=0).connect claims to be 0.0.0.0:6800/17108 not
> 10.255.0.60:6800/15859 - wrong node!
> 2010-11-12 10:24:32.489423 7f5b955ea710 -- 10.255.0.60:6803/17175 >>
> 10.255.0.60:6801/17108 pipe(0x7f5b98000d40 sd=30 pgs=0 cs=0
> l=0).connect claims to be 0.0.0.0:6801/17108 not
> 10.255.0.60:6801/17108 - presumably this is the same node!

Hmm.  Some of these messages come up normally, but this sequence doesn't 
look quite right.  What usually happens is:

B restarts.
A's connection to B drops.
A reconnects to B's old address, reaches the new B, and gets 'wrong node!'
A gets a new osdmap with B's new address 
A connects to new B.

What doesn't make sense to me here is that we then get 0.0.0.0:6801/17108, 
because B doesn't yet know it's address.  But in fact B must, because it's 
address was published in the map.

Is this reproducible?  Can you reproduce with
	debug ms = 20
	debug osd = 20
on the OSD, and
	debug mon = 20
	debug ms = 1
on the monitor, and send the logs from the mon and both OSDs?

Thanks!
sage


> 
> The wrong node message is repeated a vew more times.
> 
> After this every write to the osd seems to block. What is the right
> way to handle this?
> 
> Thanks,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

