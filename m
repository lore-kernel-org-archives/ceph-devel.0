From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Questions about CRUSH
Date: Fri, 08 Oct 2010 20:41:13 +0200
Message-ID: <1286563273.3132.1.camel@wido-laptop.pcextreme.nl>
References: <1286482123.2633.17.camel@wido-laptop.pcextreme.nl>
	 <Pine.LNX.4.64.1010071344240.16416@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:59239 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369Ab0JHSlQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 14:41:16 -0400
In-Reply-To: <Pine.LNX.4.64.1010071344240.16416@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On Thu, 2010-10-07 at 13:50 -0700, Sage Weil wrote:
> Hi Wido!
> 
> On Thu, 7 Oct 2010, Wido den Hollander wrote:
> > Hi,
> > 
> > I'm working on a crushmap where I have my hosts spread out over 3 racks
> > (leafs).
> > 
> > I have 9 physical machines, each with one OSD, spread out over three
> > racks.
> > 
> > The replication level I intend to use is 3, my goal with this crushmap
> > is to prevent two replicas being stored in the same rack.
> > 
> > Now, this map seems fine to me, but what if one of the racks fails and
> > the cluster starts to fix itself, then I would get two replicas in the
> > same rack, wouldn't I?
> 
> Right.
> 
> > Is it better to have: leafs at root = (max replication level + 1) ?
> > 
> > So, if I have my replication level set to 3, I should have 4 racks with
> > each 3 OSD's, then the cluster could restore from a complete rack
> > failure, without compromising my data safety.
> > 
> > When a complete leaf (rack) fails, the other leafs should be able to
> > store all the data, so if my replication level is set to 3, I should
> > always have at least 1/3 of free space, otherwise a full recovery won't
> > be possible, correct? (OSD's run out of disk space).
> > 
> > Am I missing something here or is this the right approach?
> 
> Yeah, I think this is the right approach. 
> 
> > And I'm not completely sure about:
> > 
> > rule placein3racks {
> rule placeinNracks {
> >         ruleset 0
> >         type replicated
> >         min_size 2
> >         max_size 2
> 	min_size 2
> 	max_size 10
> >         step take root
> >         step chooseleaf firstn 0 type rack
> >         step emit
> > }
> >
> > Is that correct? Here I say that the first step should be to choose a
> > rack where the replica should be saved. Should I also specify to choose
> > a host afterwards?
> 
> The rule generalizes to N replicas, where N can be 2..10 (that's what the 
> min/max size fields are for).  And the chooseleaf line is correct.  That 
> chooses N leaves/devices that are nested beneath N distinct racks.  Which 
> is what you want!
> 
> You could also do
> 
> 	step take root
> 	step choose firstn 0 type rack
> 	step choose firstn 1 type device
> 	step emit

Shouldn't that be:

	step take root
	step choose firstn 0 type rack
	step choose firstn 1 type host
	step choose firstn 2 type device
	step emit

Or am I wrong here?

> 
> That would choose N racks, and then for each rack, choose a nested device.  
> The problem is when one of the racks it chooses has no (or few) online 
> devices beneath it, we fail to find a usable device, and the result set 
> will have <N devices.  Chooseleaf doesn't have that problem.

So chooseleaf rack should be safe enough in this case?

> 
> sage

Wido

