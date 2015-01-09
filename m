From: Sage Weil <sage@newdream.net>
Subject: Re: Some gitbuilders not working
Date: Fri, 9 Jan 2015 07:16:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501090710500.10525@cobra.newdream.net>
References: <54AF7B4C.6010305@inktank.com> <54AFAE7D.5070402@dachary.org> <54AFDA69.2080002@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55864 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848AbbAIPQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 10:16:46 -0500
In-Reply-To: <54AFDA69.2080002@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, David Zafman <david.zafman@inktank.com>, ceph-devel@vger.kernel.org

On Fri, 9 Jan 2015, Ken Dreyer wrote:
> On 01/09/2015 03:33 AM, Loic Dachary wrote:
> > On 09/01/2015 07:55, David Zafman wrote:
> >>
> >> We are seeing gitbuilder failures.  This is what I saw on one.
> >>
> >> error: Failed build dependencies:
> >> xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64
> > 
> > This is because https://github.com/ceph/ceph/pull/3036 was recently merged.
> > However, https://github.com/ceph/autobuild-ceph/pull/19 added xmlstarlet
> > about a month ago. Maybe some gitbuilder machines were not updated
> > accordingly. If I'm not mistaken this is a manual process but I'm not sure
> > exactly how to do it myself.
> 
> I'm not entirely sure of the SOP to apply fabfile changes across our
> infrastructure, either. Is there a simple "push this fabfile change
> everywhere" command for gitbuilder?

Not really, but it is high time we established one.

At the top of the fabfile all of the targets are defined, so that if you 
run bin/fab w/o arguments it should run on *all* of them. Unfortunately 
IIRC it's a bit disruptive as it restarts the autobuild service which will 
interrupt and restart the current build.

But, that list isn't well-maintained, so it doesn't map to the current set 
of gitbuilders.  That's probably pretty easy to fix.  Even if we 
do, though, I think fab isn't super great about skipping targets that are 
down?  Not sure.

In any case, the way I've run it in practice is on specific targets taht 
need updating, like so

 bin/fab gitbuilder_auto:host=user@foo

(or something like that, I forget the exact syntax).  Often on a 
host that isn't in the master list.

More frequently the procedure has been:

 - add a dependency to the fabfile for future builders
 - manually install the package on the existing ones to avoid the above 
pain

which mostly works but doesn't regularly verify that the fabfile is 
sufficient and correct.
 
> In the long term we'll want to get to a point where we're building
> Ceph's RPM packages using mock [1] instead of rpmbuild so that mock can
> resolve these sort of things automatically without having to deal with
> installing new BuildRequires by hand.

That sounds great, although I wonder if it is slow?  We used to do 
all of our debian builds with pbuilder which does a similar thing, 
but it is way slow because it reinstalls deps on every run.  We moved 
to doing native dpkg builds because time is of the essence for test 
builds and use pbuilder only for releases...

sage
