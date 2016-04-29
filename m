From: Jesse Williamson <jwilliamson@suse.com>
Subject: Re. building boost statically
Date: Fri, 29 Apr 2016 16:16:09 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1604291354300.21305@ancalagon.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:36890 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbcD2XQV (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 29 Apr 2016 19:16:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thu, 2016-04-28 at 18:47 -0400, Sage Weil wrote:

Hi folks,

> We'd really like to use the latest boost, mainly so that we can use
> small_vector in a zillion places and avoid extra memory allocations.

There are other advantages to upgrading Boost as well, like optimizations 
in libraries such as Spirit Classic and of course bugfixes. Since Boost is 
free to make breaking changes across versions, having control over the 
exact version we build against may benefit is in terms of stability as 
well.

Another idea: The "bcp" utility that comes with Boost allows you extract 
modules from the rest of the tree, so if we have our own submodule we 
don't necessarily even need to build everything. Finally, most of Boost is 
header-only, so with the exception (ha-hah!) of the libraries you've 
already mentioned I'd guess there's not a ton to do in terms of packaging.

Another alternative is to add an autoconf configure option to target a 
specific directory. (I'm looking at this now, actually-- it's easy to get 
the top-level configure.ac to do this, but I'm not that great with 
autoconf so the lower-level Makefile.am macros aren't showing up for me 
quite yet.)

I think that being able to link it dynamically makes the most sense-- 
others have already mentioned the binary size issue, might as well nip 
anything further in the bud if we can.

That's my two bits,

-Jesse
