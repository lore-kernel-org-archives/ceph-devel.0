From: Sage Weil <sage@inktank.com>
Subject: Re: kclient: Missing directories
Date: Fri, 16 Aug 2013 13:12:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308161310370.22762@cobra.newdream.net>
References: <CANP1eJHZE0dFysqTraocaRSF=7-ieBag8hjNVYKTOJ8YqfmPdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49306 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872Ab3HPWkC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 18:40:02 -0400
In-Reply-To: <CANP1eJHZE0dFysqTraocaRSF=7-ieBag8hjNVYKTOJ8YqfmPdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Milosz,

On Fri, 16 Aug 2013, Milosz Tanski wrote:
> I've been experiencing some weird issues with the kclient that I don't
> know how to debug. In some cases the kclient is only seeing part of
> the directory tree.
> 
> For example earlier today one clients was not seeing a top level
> directory (with around 100G of data) that's been created on the ceph
> cluster for 2 months now. After I removed another unrelated directory
> (also at the top level) in a different node this node started seeing
> this.
> 
> I don't really know how to debug this issue as it seams intermittent
> and comes and goes (as you see). Usually re-mounting helps.
> 
> If you have any pointers how to deal / debug with this when file /
> directory becomes invisible I would greatly appreciate it.

This sounds like it might http://tracker.ceph.com/issues/5927.  I just 
pushed a patch from Yan into the testing branch that hopefully resoles an 
issue with d_prune in the VFS, so we'll hopefully know shortly if that 
resolves the problem.  Unfortunately in our QA it's not something that 
triggers very often so only time will tell.  If this is something you can 
reproduce easily, that is good news...

sage


