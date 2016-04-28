From: Sage Weil <sage@newdream.net>
Subject: Re: building boost statically
Date: Thu, 28 Apr 2016 19:14:15 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604281908430.25990@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com> <robbat2-20160428T225021-424429122Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39796 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbcD1XOJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2016 19:14:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTPS id 2B1D38004B
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 16:14:08 -0700 (PDT)
In-Reply-To: <robbat2-20160428T225021-424429122Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thu, 28 Apr 2016, Robin H. Johnson wrote:
> On Thu, Apr 28, 2016 at 06:47:55PM -0400,  Sage Weil wrote:
> > Hi all,
> > 
> > We'd really like to use the latest boost, mainly so that we can use 
> > small_vector in a zillion places and avoid extra memory allocations.  The 
> > distros, as always, are behind.
>
> From a distribution perspective, LESS static building is better, so this
> proposal is a concern, but I do realize that the Gentoo/ArchLinux/CoreOS
> perspective is very different than the Ubuntu LTS perspective.
> 
> What's the state of having a more-up-to-date Boost in things like Ubuntu
> backports, so that you don't have the overhead of having to maintain
> your own boost packages or statically link?
>
> If support for statically linking a newer Boost is brought it, please,
> please keep dynamic boost builds as fully supported, for distributions
> that can keep up to date. As a bonus, at some point in the future, when
> the slower distributions catch up, you might be able to escape the
> static again.

Yeah, having the option to either build statically or dynamically against 
an up-to-date distro is probably the right carrot/stick combination to 
incentivize the distros to move to a newer boost.

Being able to conditionally not use the new stuff (e.g., typedef 
small_vector<> back to vector<>) may or may not work well, depending on 
which new thing we're trying to use.

FWIW, we made the static -> dynamic transition with leveldb because the 
distros complained and it was nothing but sadness--so so many hours wasted 
chasing bugs in ancient distro versions of leveldb, and a huge matrix of 
version possibilities that made it difficult to reproduce user issues.  I 
can't tell if there was ever an instance where it actually gained us 
anything (e.g., security update in leveldb), but I kind of doubt it.

sage
