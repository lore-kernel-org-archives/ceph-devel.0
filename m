From: Sage Weil <sage@newdream.net>
Subject: Re: widening Messenger::create
Date: Thu, 29 Jan 2015 09:13:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501290856020.13723@cobra.newdream.net>
References: <572257343.60.1422549896361.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60309 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbbA2RNK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 12:13:10 -0500
In-Reply-To: <572257343.60.1422549896361.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 29 Jan 2015, Matt W. Benjamin wrote:
> Hi,
> 
> ----- "Sage Weil" <sage@newdream.net> wrote:
> 
> > On Thu, 29 Jan 2015, Matt W. Benjamin wrote:
> > > Hi,
> > > 
> > > I'm looking at ways to pass potentially messenger-specific options 
> > > through the Messenger factory. The immediate parameter I need to 
> > > provide is the number of Accelio portals to set up (this should vary 
> > > by Messenger instance), but I expect others will be needed in 
> > > future.  I don't think this fits cleanly on to the Policy mechanism, 
> > > though I looked at that.  I think I'd like to provide a generalized 
> > > argument to the Messenger factory, which can do the right thing for 
> > > a given Messenger (e.g., constructor).
> > 
> > In the past we've mostly gotten away with impl-specific config
> > options.  
> > Is that not sufficient here?  Because you need to pass different 
> > parameters to different instances maybe?
> 
> Yes, exactly.

Hmm, in that case I'd say if you can make it as generic as possible that's 
about all we can do that this point.  Just a single arg now?  We can 
easily expand the interface to a param struct later.  (Or do that now if 
you prefer.. whatever works and looks reasonable!)

sage
