From: Sage Weil <sage@newdream.net>
Subject: Re: crushmap rule issue: choose vs. chooseleaf
Date: Wed, 23 Jun 2010 14:20:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006231327140.21486@cobra.newdream.net>
References: <1277320801.29400.26.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44182 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab0FWVS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jun 2010 17:18:58 -0400
In-Reply-To: <1277320801.29400.26.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 23 Jun 2010, Jim Schutt wrote:
> I've been trying to get custom CRUSH maps to work, based on
> http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
> 
> I've not had any success until I dumped the map from
> a simple 4 device setup.  I noticed that map had a
> rule using:
>   step choose firstn 0 type device
> 
> whereas all the custom maps I was trying to build used
> chooseleaf rather than choose.  So I modified those
> default 4 device map rules to be:
>   step chooseleaf firstn 0 type device

Hmm.  It's non-obvious, and should probably work, but chooseleaf on a 
'device' (which is the leaf) currently doesn't work.  If you have a 
hiearchy like

root
host
controller
disk
device

You can either

         step take root
         step choose firstn 0 type controller
         step choose firstn 1 type device
         step emit

to get N distinct controllers, and then for each of those, choose 1 
device.  Or,

         step take root
         step chooseleaf firstn 0 type controller
         step emit

to choose (a device nested beneath) N distinct controllers.  The 
difference is the latter will try to pick a nested device for each 
controller and, if it can't find one, reject the controller choice and 
continue.  It prevents situations where you have a controller with no 
usable devices beneath it, the first rules picks one of those controllers 
in the 'choose firstn 0 type controller' step, but then can't find a 
device and you end up with (n-1) results.

The first problem you had was a bug when chooseleaf was given the leaf 
type (device).  It normally takes intermediate type in the heirarchy, not 
the leaf type.  That's now fixed, and should give an identical result to 
'choose' in that case.


> Based on that, I reworked some of test maps with deeper device
> hierarchies I had been trying, and got them to work
> (i.e. the file system started) when I avoided chooseleaf rules.
> 
> E.g. with a device hierarchy like this
> (a device here is a partition, as I am still
> testing on limited hardware):
> 
> type 0 device
> type 1 disk
> type 2 controller
> type 3 host
> type 4 root
> 
> a map with rules like this worked:
> 
> rule data {
>         ruleset 0
>         type replicated
>         min_size 2
>         max_size 2
>         step take root
>         step choose firstn 0 type host
>         step choose firstn 0 type controller
>         step choose firstn 0 type disk
>         step choose firstn 0 type device
>         step emit
> }
> 
> but a map with rules like this didn't:
> 
> rule data {
>         ruleset 0
>         type replicated
>         min_size 2
>         max_size 2
>         step take root
>         step chooseleaf firstn 0 type controller
>         step emit
> }

Hmm, this should work (assuming there are actually nodes of type 
controller in the tree).  Can you send along the actual map you're trying?

Thanks-
sage
