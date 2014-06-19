From: Sage Weil <sage@inktank.com>
Subject: Re: Company affiliation transition
Date: Thu, 19 Jun 2014 10:04:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406191003470.7220@cobra.newdream.net>
References: <53A20ABB.4090406@dachary.org> <alpine.DEB.2.00.1406190837100.3251@cobra.newdream.net> <53A306AA.9090602@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38233 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbaFSREI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jun 2014 13:04:08 -0400
In-Reply-To: <53A306AA.9090602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 19 Jun 2014, Loic Dachary wrote:
> On 19/06/2014 17:39, Sage Weil wrote:
> > On Wed, 18 Jun 2014, Loic Dachary wrote:
> >> Hi,
> >>
> >> The simplest solution to keep the .organizationmap[1] file up to date 
> >> regarding the Red Hat / InkTank acquisition would be to just wait for 
> >> developers with an @inktank.com email to move to a @redhat.com email. I 
> >> guess the same could be applied to other company affiliation change, as 
> >> long as all the company is absorbed. It does not work well when a single 
> >> individual moves from one company to another and keeps using her/his 
> >> personal email.
> > 
> > I think it would be ideal if the same individual's contributions can be 
> > attributed to multiple organizations depending on which email they 
> > used, for exactly this reason.  The way that .organizationmap and .mailmap 
> > are chained together makes this impossible, as far as I can tell?
> >  
> >> Does anyone see a problem with this approach ?
> > 
> > I'm not sure exactly what you're proposing...
> 
> Hi,
> 
> Sorry for being unclear, a commit will hopefully be better:
> 
> https://github.com/dachary/ceph/commit/de09adad2f9ede76727a87030c141236793d997f
> 
> This associates all @inktank.com to Intkank and all @redhat.com to Red 
> Hat. If you use your @redhat.com email a commit will count as Red Hat. 
> Otherwise it counts as Inktank.
> 
> The .mailmap normalizes names to cope with mistakes but does not force a 
> given individual to show under a single email.

Ah, perfect.  Yeah, this sounds good!

sage
