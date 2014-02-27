From: Sage Weil <sage@inktank.com>
Subject: Re: firefly branches
Date: Thu, 27 Feb 2014 13:51:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402271350570.17508@cobra.newdream.net>
References: <alpine.DEB.2.00.1402211141100.17322@cobra.newdream.net> <530F915F.2010608@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40920 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbaB0VvV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Feb 2014 16:51:21 -0500
In-Reply-To: <530F915F.2010608@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 27 Feb 2014, Danny Al-Gaaf wrote:
> Hi Sage,
> 
> since firefly is frozen and the task is now to focus on stabilization:
> how do you plan to handle it on the coverity side?
> 
> Is Coverity able use the firefly branch instead of master to get
> everything checked on regular bases for the next stable release?
> 
> The last Coverity check was Jan 22, 2014

I'll run it on firefly right now.  I'm not sure why my cron hasn't been 
working; will poke that too.

Thanks!
sage


> 
> Danny
> 
> Am 21.02.2014 20:46, schrieb Sage Weil:
> > Now that firefly is frozen, we're going to keep things interesting and 
> > do things slight different that we did for emperor.  It's closer to what 
> > we normally do, though, so hopefully this will be simpler.
> > 
> >  master == new stuff for post-firefly v0.79.  this shouldn't see much new 
> >    code since we're focusing on stabilization right now.
> > 
> >  next == <deleted>.  use firefly instead.
> > 
> >  firefly == what will become firefly 0.78.  this is the branch the nightly 
> >    qa is focusing on.
> > 
> > Periodically we can merge firefly back into master (as we normally do with 
> > next), but this isn't particularly important since the all QA is running 
> > against firefly.
> > 
> > There are now firefly branches in teuthology.git and ceph-qa-suites.git to 
> > match.
> > 
> > In the past we had both next and the stable-release-to-be branch but it 
> > was awkward to keep them in sync.  This avoid that ambiguity by just 
> > having one branch and calling it firefly to make it crystal clear to 
> > everyone what is what.
> > 
> > That's all!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
