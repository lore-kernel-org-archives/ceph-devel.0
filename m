From: Sage Weil <sage@newdream.net>
Subject: Re: Some gitbuilders not working
Date: Wed, 14 Jan 2015 09:30:08 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501140927510.26676@cobra.newdream.net>
References: <54AF7B4C.6010305@inktank.com> <54AFAE7D.5070402@dachary.org> <54AFDA69.2080002@redhat.com> <alpine.DEB.2.00.1501090710500.10525@cobra.newdream.net> <54B69FAB.3020504@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37440 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbbANRaJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jan 2015 12:30:09 -0500
In-Reply-To: <54B69FAB.3020504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, David Zafman <david.zafman@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 14 Jan 2015, Ken Dreyer wrote:
> On 01/09/2015 08:16 AM, Sage Weil wrote:
> > On Fri, 9 Jan 2015, Ken Dreyer wrote:
> >> On 01/09/2015 03:33 AM, Loic Dachary wrote:
> >>> On 09/01/2015 07:55, David Zafman wrote:
> >>>>
> >>>> We are seeing gitbuilder failures.  This is what I saw on one.
> >>>>
> >>>> error: Failed build dependencies:
> >>>> xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64
> >>>
> >>> This is because https://github.com/ceph/ceph/pull/3036 was recently merged.
> >>> However, https://github.com/ceph/autobuild-ceph/pull/19 added xmlstarlet
> >>> about a month ago. Maybe some gitbuilder machines were not updated
> >>> accordingly. If I'm not mistaken this is a manual process but I'm not sure
> >>> exactly how to do it myself.
> >>
> >> I'm not entirely sure of the SOP to apply fabfile changes across our
> >> infrastructure, either. Is there a simple "push this fabfile change
> >> everywhere" command for gitbuilder?
> > 
> > Not really, but it is high time we established one.
> > 
> > At the top of the fabfile all of the targets are defined, so that if you 
> > run bin/fab w/o arguments it should run on *all* of them. Unfortunately 
> > IIRC it's a bit disruptive as it restarts the autobuild service which will 
> > interrupt and restart the current build.
> > 
> > But, that list isn't well-maintained, so it doesn't map to the current set 
> > of gitbuilders.  That's probably pretty easy to fix.  Even if we 
> > do, though, I think fab isn't super great about skipping targets that are 
> > down?  Not sure.
> > 
> > In any case, the way I've run it in practice is on specific targets taht 
> > need updating, like so
> > 
> >  bin/fab gitbuilder_auto:host=user@foo
> > 
> > (or something like that, I forget the exact syntax).  Often on a 
> > host that isn't in the master list.
> > 
> > More frequently the procedure has been:
> > 
> >  - add a dependency to the fabfile for future builders
> >  - manually install the package on the existing ones to avoid the above 
> > pain
> > 
> > which mostly works but doesn't regularly verify that the fabfile is 
> > sufficient and correct.
> >  
> >> In the long term we'll want to get to a point where we're building
> >> Ceph's RPM packages using mock [1] instead of rpmbuild so that mock can
> >> resolve these sort of things automatically without having to deal with
> >> installing new BuildRequires by hand.
> > 
> > That sounds great, although I wonder if it is slow?  We used to do 
> > all of our debian builds with pbuilder which does a similar thing, 
> > but it is way slow because it reinstalls deps on every run.  We moved 
> > to doing native dpkg builds because time is of the essence for test 
> > builds and use pbuilder only for releases...
> 
> It sounds like we should research exactly how much time mock and
> pbuilder would add. Mock implements caching at a lot of levels, though
> it's true that it won't be as fast as just running plain rpmbuild. We
> should get some hard numbers so we know how painful the speed hit would be.
> 
> I'm weighing the time that mock would slow down the builds against the
> time and energy that it takes to
>  - Duplicate the BuildRequires in autobuild-ceph.git
>  - Review the change for correctness and merge the autobuild-ceph.git
>    pull request
>  - Deploy the autobuild-ceph.git changes out to the appropriate
>    gitbuilders
> 
> And then there's the "people stuff", like comprehending that all of the
> above is even necessary, or communicating about this on mailing lists
> like this thread, etc.
> 
> The fact that pbuilders are introduced very late (only during releases)
> means that we encounter errors during a release day when Alfredo or I
> have tried to get a release out the door. The pbuilder stuff isn't
> touched until we try to do a release, and in the mean time, it breaks
> because it's not getting continually tested. We're paying the "slow"
> penalty in other areas down the road.
> 
> I'm not looking to purposefully slow down other people's work, so I'll
> continue to mull over how we can balance speed with correctness.

I agree this woudl vastly simplify things.  Let's see what the performancd 
delta is on the new build boxes (which have lots of modern cores, RAM, and 
SSDs).

Also/alternatively, a step that installs all the BuildRequires on the host 
(even during each run) should be quick in the usual case but similarly 
avoid breakage... Even just making make an install-deps.sh that will Do 
The Right Thing might do the trick?  (Also usefulf or devs checking out 
the source who want to get their environment going quickly.)

sag

