From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: widening Messenger::create
Date: Thu, 29 Jan 2015 11:44:56 -0500 (EST)
Message-ID: <572257343.60.1422549896361.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1501290841420.13723@cobra.newdream.net>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2956 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072AbbA2QpL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jan 2015 11:45:11 -0500
In-Reply-To: <alpine.DEB.2.00.1501290841420.13723@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

----- "Sage Weil" <sage@newdream.net> wrote:

> On Thu, 29 Jan 2015, Matt W. Benjamin wrote:
> > Hi,
> > 
> > I'm looking at ways to pass potentially messenger-specific options
> through the Messenger factory.
> > The immediate parameter I need to provide is the number of Accelio
> portals to set up (this should
> > vary by Messenger instance), but I expect others will be needed in
> future.  I don't think this fits
> > cleanly on to the Policy mechanism, though I looked at that.  I
> think I'd like to provide a
> > generalized argument to the Messenger factory, which can do the
> right thing for a given Messenger
> > (e.g., constructor).
> 
> In the past we've mostly gotten away with impl-specific config
> options.  
> Is that not sufficient here?  Because you need to pass different 
> parameters to different instances maybe?

Yes, exactly.

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
