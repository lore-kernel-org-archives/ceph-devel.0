From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about CRUSH
Date: Thu, 7 Oct 2010 13:50:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010071344240.16416@cobra.newdream.net>
References: <1286482123.2633.17.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48589 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0JGUru (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 16:47:50 -0400
In-Reply-To: <1286482123.2633.17.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi Wido!

On Thu, 7 Oct 2010, Wido den Hollander wrote:
> Hi,
> 
> I'm working on a crushmap where I have my hosts spread out over 3 racks
> (leafs).
> 
> I have 9 physical machines, each with one OSD, spread out over three
> racks.
> 
> The replication level I intend to use is 3, my goal with this crushmap
> is to prevent two replicas being stored in the same rack.
> 
> Now, this map seems fine to me, but what if one of the racks fails and
> the cluster starts to fix itself, then I would get two replicas in the
> same rack, wouldn't I?

Right.

> Is it better to have: leafs at root = (max replication level + 1) ?
> 
> So, if I have my replication level set to 3, I should have 4 racks with
> each 3 OSD's, then the cluster could restore from a complete rack
> failure, without compromising my data safety.
> 
> When a complete leaf (rack) fails, the other leafs should be able to
> store all the data, so if my replication level is set to 3, I should
> always have at least 1/3 of free space, otherwise a full recovery won't
> be possible, correct? (OSD's run out of disk space).
> 
> Am I missing something here or is this the right approach?

Yeah, I think this is the right approach. 

> And I'm not completely sure about:
> 
> rule placein3racks {
rule placeinNracks {
>         ruleset 0
>         type replicated
>         min_size 2
>         max_size 2
	min_size 2
	max_size 10
>         step take root
>         step chooseleaf firstn 0 type rack
>         step emit
> }
>
> Is that correct? Here I say that the first step should be to choose a
> rack where the replica should be saved. Should I also specify to choose
> a host afterwards?

The rule generalizes to N replicas, where N can be 2..10 (that's what the 
min/max size fields are for).  And the chooseleaf line is correct.  That 
chooses N leaves/devices that are nested beneath N distinct racks.  Which 
is what you want!

You could also do

	step take root
	step choose firstn 0 type rack
	step choose firstn 1 type device
	step emit

That would choose N racks, and then for each rack, choose a nested device.  
The problem is when one of the racks it chooses has no (or few) online 
devices beneath it, we fail to find a usable device, and the result set 
will have <N devices.  Chooseleaf doesn't have that problem.

sage
