From: Sage Weil <sweil@redhat.com>
Subject: Re: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 13:30:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410101330170.28531@cobra.newdream.net>
References: <5437A6C0.3000005@dachary.org> <alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net> <5438134E.7050009@dachary.org> <alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net> <CA+Hcz5_gwQdZ15EyJBfzxU05bDp0Pbdcgfqtv_=N5Q9Zm62FdQ@mail.gmail.com>
 <5438307C.4060701@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37169 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaJJUax (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 16:30:53 -0400
In-Reply-To: <5438307C.4060701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Noah Watkins <noah.watkins@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 10 Oct 2014, Loic Dachary wrote:
> Hi Noah,
> 
> My focus is to create centos7 and ubuntu-14.04 packages at this point. 
> And somehow find a way to convince teuthology to use them instead of 
> what http://ceph.com/gitbuilder.cgi creates, but that's a separate 
> issue.
> 
> What kind of output would you like to get from these arm7 machines ?

What we did previously was use one set (~20 nodes?) for build, and the 
remainder for any testing.  We can probably just resurrect that 
arrangement?

sage


> 
> Cheers
> 
> On 10/10/2014 19:55, Noah Watkins wrote:
> > On Fri, Oct 10, 2014 at 10:14 AM, Sage Weil <sweil@redhat.com> wrote:
> >> On Fri, 10 Oct 2014, Loic Dachary wrote:
> >>> On 10/10/2014 17:11, Sage Weil wrote:
> >>>> On Fri, 10 Oct 2014, Loic Dachary wrote:
> >>>>> Hi Sandon,
> >>>>>
> >>>>> Would it be possible to resurect / create an arm7 gitbuilder for
> >>>>> whatever distribution is more convenient ? Janne made a great
> >>>>> contribution to erasure code optimization on NEON (
> >>>>> https://bitbucket.org/jannau/gf-complete/branch/neon ) and it would make
> >>>>> it easier to have a gitbuilder to run it throught teuthology and torture
> >>>>> it ;-) If that's complicated or there is another way to run teuthology
> >>>>> jobs for this purpose, I'm open to suggestions.
> >>>>
> >>>> We have a bunch of armv7l nodes that used to run distcc and a gitbuilder.
> >>>> It's a bit of a time suck to maintain, though.  Is there an interested
> >>>> party we can set up with lab access that can help administer these on an
> >>>> ongoing basis?  Sandon is a highly contended resource.  :)
> >>>
> >>> Long term I'm not sure. I'll try to setup something temporary and see
> >>> where it goes. Is there a risk that these machines go away in the next 6
> >>> months ? 3 months ?
> > 
> > I am an interested party, and at least in the short term would
> > dedicate some time to getting arm7 builds working too.
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
