From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: widening Messenger::create
Date: Thu, 29 Jan 2015 12:23:02 -0500 (EST)
Message-ID: <773946604.70.1422552182027.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1917094814.68.1422552099121.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1331 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbbA2RXF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jan 2015 12:23:05 -0500
In-Reply-To: <1917094814.68.1422552099121.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I was going to do a proplist arg type thing?  I'll adapt it until hopefully shared happiness breaks out...

Matt

----- "Sage Weil" <sage@newdream.net> wrote:

> On Thu, 29 Jan 2015, Matt W. Benjamin wrote:
> > Hi,
> > 
> > ----- "Sage Weil" <sage@newdream.net> wrote:
> > 
> > > On Thu, 29 Jan 2015, Matt W. Benjamin wrote:
> > > > Hi,
> > > > 
> > > > I'm looking at ways to pass potentially messenger-specific
> options 
> > > > through the Messenger factory. The immediate parameter I need to
> 
> > > > provide is the number of Accelio portals to set up (this should
> vary 
> > > > by Messenger instance), but I expect others will be needed in 
> > > > future.  I don't think this fits cleanly on to the Policy
> mechanism, 
> > > > though I looked at that.  I think I'd like to provide a
> generalized 
> > > > argument to the Messenger factory, which can do the right thing
> for 
> > > > a given Messenger (e.g., constructor).
> > > 
> > > In the past we've mostly gotten away with impl-specific config
> > > options.  
> > > Is that not sufficient here?  Because you need to pass different 
> > > parameters to different instances maybe?
> > 
> > Yes, exactly.
> 
> Hmm, in that case I'd say if you can make it as generic as possible
> that's 
> about all we can do that this point.  Just a single arg now?  We can 
> easily expand the interface to a param struct later.  (Or do that now
> if 
> you prefer.. whatever works and looks reasonable!)
> 
> sage

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
