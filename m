From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: RBD layering design draft
Date: Fri, 22 Jun 2012 16:37:12 +0200
Message-ID: <2294446.qgV7dgiTVM@pc10>
References: <4FDB9FBB.9000807@inktank.com> <4FE3976C.5000508@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:34373 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933085Ab2FVOhO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jun 2012 10:37:14 -0400
In-Reply-To: <4FE3976C.5000508@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com, ceph-devel <ceph-devel@vger.kernel.org>

> On 06/15/2012 03:48 PM, Josh Durgin wrote:

> > Then you can perform the clone:
> >     $ rbd clone --parent pool/parent@snap pool2/child1
> 
> Based on my comments above, if the parent had not been "preserved"
> it would automatically be at this point, by virtue of the fact it
> has a clone associated with it.
> 
> Since there is always exactly one parent and one child, I'd say
> drop the "--parent" and just have the parent and child be
> defined by their position.  If the parent could be optionally
> skipped for some reason, then make it be the second one.

I think that would be a very bad idea. clone <source> <target> would be a good 
idea; nearly all similar commandline utilities (cp, mv, ln) work like that. 
clone <target> <source> would be counterintuitive and probably lead to 
otherwise avoidable mistakes.

        Guido
