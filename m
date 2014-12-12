From: Sage Weil <sweil@redhat.com>
Subject: Re: crush: straw is dead, long live straw2
Date: Fri, 12 Dec 2014 06:46:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412120644340.23559@cobra.newdream.net>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net> <20141212091408.GN4150@thinkpad.thebehrens.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36106 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967941AbaLLOq3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Dec 2014 09:46:29 -0500
In-Reply-To: <20141212091408.GN4150@thinkpad.thebehrens.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thorsten Behrens <tbehrens@suse.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 12 Dec 2014, Thorsten Behrens wrote:
> Sage Weil wrote:
> > Calculating the ln() function is a bit annoying because it is a floating 
> > point function and CRUSH is all fixed-point arithmetic (integer-based).  
> > The current draft implementation uses a 128 KB lookup table (2 bytes per 
> > entry for 16 bits of input precision).  It seems to be about 25% slower 
> > than the original straw code in my simple microbenchmark, but I'm not sure 
> > that's a number we should trust since it loops through a zillion inputs 
> > and will pull most of the lookup table into the processor caches.
> > 
> > We could probably try a few others things:
> > 
> [snip]
> 
> My Hacker's Delight copy has a number of further variants (on
> pp. 215), unfortunately only covering log_2 (which is trivially the
> number of leading zeros in the binary representation) and log_10. But
> since the logarithms are simply related by a multiplicative constant,
> something clever might be doable here with a bit of thinking.

Any log will definitely do; the next steps are to do a division and then 
take the max.  Simply counting 0's isn't precise enough, though.. we need 
a lot more precision than that.

The table lookup is (I think) on the order of 50-100 cycles with a cold 
cache; that's what we need to beat!

sage

