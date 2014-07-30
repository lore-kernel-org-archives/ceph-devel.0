From: Sage Weil <sweil@redhat.com>
Subject: Re: giant and hammer dates
Date: Wed, 30 Jul 2014 07:22:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407300706441.18917@cobra.newdream.net>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net> <53D87BBF.2020408@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57955 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbaG3OWk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 10:22:40 -0400
In-Reply-To: <53D87BBF.2020408@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On Wed, 30 Jul 2014, Loic Dachary wrote:
> Hi Sage,
> 
> From my (biased) point of view, the upside is that it will give me more 
> time to complete the locally repairable code for Giant ;-). The downside 
> is that it puts a little less pressure to improve the tools and methods 
> that make a rapid release cycles possible (i.e. unit tests, bug 
> tracking, patch acceptance workflow, package building/gitbuilder, 
> teuthology, pulpito, upgrades testing, ...). In a perfect world Ceph 
> could sustain a three month release cycle without inconveniencing 
> anyone. A longer release cycle (five or six months) would encourage even 
> more complex / bigger changes within a release cycle. It would also 
> probably encourage Ceph developers to forget about the release process 
> tools during two or three months and not improve them as they should be.
> 
> IMHO the test cycle is significantly slowing down the release process 
> and a faster, more comprehensive test cycle would help a lot.

No argument here. :)

I should clarify that this is the "stable release cycle" for the named 
released.  I still think we should maintain a ~2 week "development release 
cycle" where we are continuously integrating changes and regularly putting 
out a usable release.  The 'next' or 'last' branches should be recent and 
stable starting points for doing any new work so that the integration 
tests, when run, will reflect bugs in your code and not stuff that was 
already there.  We've slipped a bit here (0.82 to 0.83 was 5 weeks); this 
is partly because the release process itself is still pretty expensive in 
terms of effort and we don't want to eat up more of Alfredo's and Sandon's 
time than we need to, but it is getting better.

In any case, the real point of a longer "stable release cycle" is just 
that there are fewer stable releases in flight that we are backporting 
fixes too.  In practice, having all of dumpling, emperor, and firefly 
outstanding hasn't worked particularly well (IMO).  We backport to 
dumpling and firefly and urge people away from emperor to avoid the 
cognitive overhead of keeping track of another release.  Going from 3 to 4 
months means only 3 stable releases per year, which I think is enough...?

> Each commit should be unit / functional tested within seconds, locally 
> (see 
> https://github.com/ceph/ceph/blob/master/src/test/osd/types.cc#L1295 for 
> instance). It is usually more difficult to diagnose / fix a border case 
> when it is discovered during integration tests (i.e. teuthology) rather 
> than with a unit / functional test designed for it. Creating unit tests 
> is often problematic because some of the code base cannot be easily 
> isolated. With a continuous effort to re-arrange parts of the code to be 
> more test friendly, this can eventually be resolved.
> 
> Every commit proposed to master should be run against the relevant 
> teuthology suite to help the reviewer. The problem here is that it 
> requires more resources than what Ceph currently has. Harvesting more 
> machines, making it possible for people and organizations amicable to 
> Ceph to easily donate virtual machines could probably help.

Zack is making good progress on rejiggering the way that teuthology 
separates the core task locking and task runners from the tasks themselves 
(which get versioned along with the test suite for firefly, dumpling, 
etc.).  This is all groundwork to enable the important bits, like pulling 
machine locking into a single, easy to deploy process, and plugging in 
different providers (in addition to bare metal and downburst) like 
OpenStack.  The end goal is to make teuthology much easier to deploy in 
other environments.  I'm hoping we can get to a place similar to openstack 
where organizations can hang their CI deployment off the 'upstream' 
build/CI infrastructure and supplement by running the same suites on 
different hardware or by adding their own test suites...

> This deserves a separate discussions but I wanted to expand on what I 
> meant by "test cycle" and its impact on the release cycle.

We had a discussion during the G/H CDS about doing an ephemeral 
'integration' branch to group things together for full testing by the 
teuthology test suites that you probably caught.  There was a follow-on 
internal discussion while you were gone on how to get this rolling and Sam 
is currently working on a tool to easily build an integration branch 
merging pending work on a nightly so that it can go through the tests 
before getting merged into master.  I think this will help.

We also have our first batch of new hardware ordered inside Red Hat 
(another ~130 machines) that will expand our testing throughput, and 
Sandon is working on reclaiming a lot of existing machines that aren't 
getting put to good use (burnupi) so that we can expand the size of the 
existing test pool.

Alfredo recently did some background research on what other projects are 
doing for CI and releases, and he and Sandon have some work in flight to 
move some of the bursty release builds into openstack VMs.  Unfortunately 
nobody has their full bandwidth allocated to improving the state of 
things, but I think we're making some slow progress.

sage


> 
> Cheers
> 
> On 30/07/2014 05:11, Sage Weil wrote:
> > We've talked a bit about moving to a ~4 month (instead of 3 month) 
> > cadence.  I'm still inclined in this direction because it means fewer 
> > stable releases that we will be maintaining and a longer and (hopefully) 
> > more productive interval to do real work in between.
> > 
> > The other key point is that we don't want a repeat of the firefly delay.  
> > I think we should stay as close to a train model as we can.  If something 
> > isn't ready by freeze, let it wait for the next cycle.  We shouldn't be 
> > cramming things in at the end, especially big things.  As a general rule, 
> > big things should be merged early in the cycle so that we have lots of 
> > time to shake out the issues that only come out of lots of testing and 
> > aren't obvious from code review.
> > 
> > Anyway, how about:
> > 
> >           Freeze         Approx Release
> >   Giant   Mon Sep  1     Mon Sep 29
> >   Hammer  Mon Jan  4     Mon Feb  2
> > 
> > That gives us another month for Giant, then September to shake out 
> > anything issues.  And then three full months before the Hammer freeze.
> > 
> > What say ye?
> > sage
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
