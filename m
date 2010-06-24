From: Sage Weil <sage@newdream.net>
Subject: Re: crushmap rule issue: choose vs. chooseleaf
Date: Thu, 24 Jun 2010 11:20:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006241059570.30180@cobra.newdream.net>
References: <1277320801.29400.26.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1006231327140.21486@cobra.newdream.net>
 <1277330264.29400.34.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33176 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab0FXST2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jun 2010 14:19:28 -0400
In-Reply-To: <1277330264.29400.34.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

Okay, I fixed another bug and am now able to use your map without 
problems.  The fix is pushed to the unstable branch in ceph.git.

I'm surprised we didn't run into this before.. it looks like it's been 
broken for a while.  I'm adding a tracker item to set up some unit tests 
for this stuff so we can avoid this sort of regression.. the crush code 
should be really easy to check.

sage


On Wed, 23 Jun 2010, Jim Schutt wrote:

> 
> On Wed, 2010-06-23 at 15:20 -0600, Sage Weil wrote:
> > On Wed, 23 Jun 2010, Jim Schutt wrote:
> > > I've been trying to get custom CRUSH maps to work, based on
> > > http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
> > > 
> > > I've not had any success until I dumped the map from
> > > a simple 4 device setup.  I noticed that map had a
> > > rule using:
> > >   step choose firstn 0 type device
> > > 
> > > whereas all the custom maps I was trying to build used
> > > chooseleaf rather than choose.  So I modified those
> > > default 4 device map rules to be:
> > >   step chooseleaf firstn 0 type device
> > 
> > Hmm.  It's non-obvious, and should probably work, but chooseleaf on a 
> > 'device' (which is the leaf) currently doesn't work.  If you have a 
> > hiearchy like
> > 
> > root
> > host
> > controller
> > disk
> > device
> > 
> > You can either
> > 
> >          step take root
> >          step choose firstn 0 type controller
> >          step choose firstn 1 type device
> >          step emit
> > 
> > to get N distinct controllers, and then for each of those, choose 1 
> > device.  Or,
> > 
> >          step take root
> >          step chooseleaf firstn 0 type controller
> >          step emit
> > 
> > to choose (a device nested beneath) N distinct controllers.  The 
> > difference is the latter will try to pick a nested device for each 
> > controller and, if it can't find one, reject the controller choice and 
> > continue.  It prevents situations where you have a controller with no 
> > usable devices beneath it, the first rules picks one of those controllers 
> > in the 'choose firstn 0 type controller' step, but then can't find a 
> > device and you end up with (n-1) results.
> > 
> > The first problem you had was a bug when chooseleaf was given the leaf 
> > type (device).  It normally takes intermediate type in the heirarchy, not 
> > the leaf type.  That's now fixed, and should give an identical result to 
> > 'choose' in that case.
> 
> OK, thanks.
> 
> > 
> > 
> > > Based on that, I reworked some of test maps with deeper device
> > > hierarchies I had been trying, and got them to work
> > > (i.e. the file system started) when I avoided chooseleaf rules.
> > > 
> > > E.g. with a device hierarchy like this
> > > (a device here is a partition, as I am still
> > > testing on limited hardware):
> > > 
> > > type 0 device
> > > type 1 disk
> > > type 2 controller
> > > type 3 host
> > > type 4 root
> > > 
> > > a map with rules like this worked:
> > > 
> > > rule data {
> > >         ruleset 0
> > >         type replicated
> > >         min_size 2
> > >         max_size 2
> > >         step take root
> > >         step choose firstn 0 type host
> > >         step choose firstn 0 type controller
> > >         step choose firstn 0 type disk
> > >         step choose firstn 0 type device
> > >         step emit
> > > }
> 
> Based on your above explanation, I suspect this wasn't
> doing what I wanted.
> 
> > > 
> > > but a map with rules like this didn't:
> > > 
> > > rule data {
> > >         ruleset 0
> > >         type replicated
> > >         min_size 2
> > >         max_size 2
> > >         step take root
> > >         step chooseleaf firstn 0 type controller
> > >         step emit
> > > }
> > 
> > Hmm, this should work (assuming there are actually nodes of type 
> > controller in the tree).  Can you send along the actual map you're trying?
> 
> Sure.  I've been using multiple partitions
> per disk for learning about CRUSH maps, so 
> in this map a device is a partition.
> 
> Here it is:
> 
> # begin crush map
> 
> # devices
> device 0 device0
> device 1 device1
> device 2 device2
> device 3 device3
> 
> # types
> type 0 device
> type 1 disk
> type 2 controller
> type 3 host
> type 4 root
> 
> # buckets
> disk disk0 {
> 	id -1		# do not change unnecessarily
> 	alg uniform	# do not change bucket size (1) unnecessarily
> 	hash 0	# rjenkins1
> 	item device0 weight 1.000 pos 0
> }
> disk disk1 {
> 	id -2		# do not change unnecessarily
> 	alg uniform	# do not change bucket size (1) unnecessarily
> 	hash 0	# rjenkins1
> 	item device1 weight 1.000 pos 0
> }
> disk disk2 {
> 	id -3		# do not change unnecessarily
> 	alg uniform	# do not change bucket size (1) unnecessarily
> 	hash 0	# rjenkins1
> 	item device2 weight 1.000 pos 0
> }
> disk disk3 {
> 	id -4		# do not change unnecessarily
> 	alg uniform	# do not change bucket size (1) unnecessarily
> 	hash 0	# rjenkins1
> 	item device3 weight 1.000 pos 0
> }
> controller controller0 {
> 	id -5		# do not change unnecessarily
> 	alg uniform	# do not change bucket size (2) unnecessarily
> 	hash 0	# rjenkins1
> 	item disk0 weight 1.000 pos 0
> 	item disk1 weight 1.000 pos 1
> }
> controller controller1 {
> 	id -6		# do not change unnecessarily
> 	alg uniform	# do not change bucket size (2) unnecessarily
> 	hash 0	# rjenkins1
> 	item disk2 weight 1.000 pos 0
> 	item disk3 weight 1.000 pos 1
> }
> host host0 {
> 	id -7		# do not change unnecessarily
> 	alg uniform	# do not change bucket size (2) unnecessarily
> 	hash 0	# rjenkins1
> 	item controller0 weight 2.000 pos 0
> 	item controller1 weight 2.000 pos 1
> }
> root root {
> 	id -8		# do not change unnecessarily
> 	alg straw
> 	hash 0	# rjenkins1
> 	item host0 weight 4.000
> }
> 
> # rules
> rule data {
> 	ruleset 0
> 	type replicated
> 	min_size 2
> 	max_size 2
> 	step take root
> 	step chooseleaf firstn 0 type controller
> 	step emit
> }
> rule metadata {
> 	ruleset 1
> 	type replicated
> 	min_size 2
> 	max_size 2
> 	step take root
> 	step chooseleaf firstn 0 type controller
> 	step emit
> }
> rule casdata {
> 	ruleset 2
> 	type replicated
> 	min_size 2
> 	max_size 2
> 	step take root
> 	step chooseleaf firstn 0 type controller
> 	step emit
> }
> rule rbd {
> 	ruleset 3
> 	type replicated
> 	min_size 2
> 	max_size 2
> 	step take root
> 	step chooseleaf firstn 0 type controller
> 	step emit
> }
> 
> # end crush map
> 
> When I try to start a file system built with the above map,
> the monitor never accepts connections (from either ceph -w
> or the cosd instances).
> 
> Thanks for taking a look.
> 
> -- Jim
> 
> > 
> > Thanks-
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
