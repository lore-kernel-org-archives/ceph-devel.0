From: Sage Weil <sage@newdream.net>
Subject: Re: [wip-addr-features] make sure I am doing the right thing
Date: Mon, 16 May 2016 12:29:45 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605161228390.30956@cpach.fuggernut.com>
References: <CAEG8a3LQuro2zXu90im0aQ58XxdGLDQvLxnjkJ+Rd8C6k70QVw@mail.gmail.com> <alpine.DEB.2.11.1605160446150.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54998 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbcEPQ3a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2016 12:29:30 -0400
In-Reply-To: <alpine.DEB.2.11.1605160446150.30956@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junwang Zhao <zhjwpku@gmail.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 16 May 2016, Sage Weil wrote:
> Hi Junwang,
> 
> On Mon, 16 May 2016, Junwang Zhao wrote:
> > Hi Sage, Haomai,
> > 
> > I am working on the require-features-patch, I use 'make' to see the conflicts,
> > and change the code to fit the required-feature-patch, [1] is a huge patch
> > that I am still working on, it has not been finished. I really need to check
> > with you whether I am doing it right, since it seems the errors are endless.
> > 
> > There are some comments where I am not sure in the patch, like 'not sure'.
> 
> I skimmed through this and it looks mostly right, but I see a few cases 
> where features aren't needed, e.g. cls_refcount_get in 
> cls_refcount_client.cc (there's no addr being encoded in 
> cls_refcount_get_op, so no need to make the encoding featureful).
>  
> > I didn't split this huge patch into small ones, I am not sure is that a 
> > must, if yes, I will split it into small ones.
> 
> The end result needs to be a series of small patches, but that doesn't 
> have to happen right away.  I think it might be useful to do a few small 
> sets of changes first just to show what the goal is, though.
> 
> I will take the patch below and pull a few sample changes out so you can 
> see.  Traveling at the moment, but I'll have something pushed today (that 
> is also rebased on top of the latest wip-addr-cleanup branch).

I went on a bit of a binge and have a wip-addr-work branch that is mostly 
there.  The last thing (I think) is updating msg/simple and msg/async.  
These ones should explicitly encode with features 0 since the protocol is 
defined in terms of the legacy encoding.

sage
