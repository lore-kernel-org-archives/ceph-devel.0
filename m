From: Sage Weil <sage@newdream.net>
Subject: Re: [IANA #821110] Application for a Port Number and/or Service Name
 "ceph" (fwd)
Date: Wed, 29 Apr 2015 10:34:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504291032480.25514@cobra.newdream.net>
References: <alpine.DEB.2.00.1504290959540.24030@cobra.newdream.net> <5541155B.7090609@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60074 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031251AbbD2Re0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 13:34:26 -0400
In-Reply-To: <5541155B.7090609@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 29 Apr 2015, Mark Nelson wrote:
> On 04/29/2015 12:02 PM, Sage Weil wrote:
> > So, I picked 6789 way back in commit
> > dc38de9b14c5386f9f446124ca6d6673eb8a1e20 because it was unused according
> > to nmap-services.  It's there now, in use by smc-https (whatever that is),
> > and says it was registered in 2002.  I guess the nmap-services file I
> > looked at at the time was out of date?
> > 
> > In any case, if we want an IANA assigned number, we'll need to change it.
> > 
> > We should be able to make a transition reasonably painless by making
> > clients try both ports when none is specified for some period.
> > 
> > I'm assuming it's worth the effort... what do you think?
> 
> Yes, I think it's worth it.  Better now than when we are 10x bigger than
> <large storage vendor> right? ;)

Hmm, we could go for something < 1024 too, but that will make non-root 
ceph-mon's more annoying, I suspect.

http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=unassigned

sage
