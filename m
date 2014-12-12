From: Sage Weil <sweil@redhat.com>
Subject: Re: crush: straw is dead, long live straw2
Date: Fri, 12 Dec 2014 13:29:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412121327140.22847@cobra.newdream.net>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net> <20141212091408.GN4150@thinkpad.thebehrens.net> <alpine.DEB.2.00.1412120644340.23559@cobra.newdream.net> <548B0C16.4000509@gmail.com> <alpine.DEB.2.00.1412120814050.23559@cobra.newdream.net>
 <548B3191.4040605@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56015 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbaLLV3h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Dec 2014 16:29:37 -0500
In-Reply-To: <548B3191.4040605@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Landman <joe.landman@gmail.com>
Cc: Thorsten Behrens <tbehrens@suse.com>, ceph-devel@vger.kernel.org

On Fri, 12 Dec 2014, Joe Landman wrote:
> On 12/12/2014 11:20 AM, Sage Weil wrote:
> 
> > We can't use floating point. The code needs to run in the kernel. We also
> > need the rseults to be perfectly deterministic and consistent across all
> > architectures; I'm not sure if all floating point implementations (and log
> > implementations) will do that? 
> 
> Have a look at this (using the code I pointed to before):
> https://gist.github.com/joelandman/ec6f3abef9bc5f1c7b0e
> 
> Running on my desktop box, library double function (with casts) is about 3x
> slower than the local log_2 version.

It looks like the log_2 is only giving 5 or 6 bits of precision (counting 
0's), but we want a fixed-point output with more like 16 bits. The link 
Milosz sent looks like the most promising candidate I've seen so far...

sage
