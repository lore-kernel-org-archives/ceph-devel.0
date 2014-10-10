From: Sage Weil <sweil@redhat.com>
Subject: Re: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 10:14:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net>
References: <5437A6C0.3000005@dachary.org> <alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net> <5438134E.7050009@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35497 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbaJJROg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 13:14:36 -0400
In-Reply-To: <5438134E.7050009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sandon Van Ness <sandon@inktank.com>, Janne Grunau <j@jannau.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 10 Oct 2014, Loic Dachary wrote:
> On 10/10/2014 17:11, Sage Weil wrote:
> > On Fri, 10 Oct 2014, Loic Dachary wrote:
> >> Hi Sandon,
> >>
> >> Would it be possible to resurect / create an arm7 gitbuilder for 
> >> whatever distribution is more convenient ? Janne made a great 
> >> contribution to erasure code optimization on NEON ( 
> >> https://bitbucket.org/jannau/gf-complete/branch/neon ) and it would make 
> >> it easier to have a gitbuilder to run it throught teuthology and torture 
> >> it ;-) If that's complicated or there is another way to run teuthology 
> >> jobs for this purpose, I'm open to suggestions.
> > 
> > We have a bunch of armv7l nodes that used to run distcc and a gitbuilder.  
> > It's a bit of a time suck to maintain, though.  Is there an interested 
> > party we can set up with lab access that can help administer these on an 
> > ongoing basis?  Sandon is a highly contended resource.  :)
> 
> Long term I'm not sure. I'll try to setup something temporary and see 
> where it goes. Is there a risk that these machines go away in the next 6 
> months ? 3 months ?

No risk!  :)

sage
