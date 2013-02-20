From: Sage Weil <sage@inktank.com>
Subject: Re: Hadoop DNS/topology details
Date: Tue, 19 Feb 2013 16:39:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu> <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com> <16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37260 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757532Ab3BTAj2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:39:28 -0500
In-Reply-To: <16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joe Buck <jbbuck@gmail.com>

On Tue, 19 Feb 2013, Noah Watkins wrote:
> On Feb 19, 2013, at 2:22 PM, Gregory Farnum <greg@inktank.com> wrote:
> > On Tue, Feb 19, 2013 at 2:10 PM, Noah Watkins <jayhawk@cs.ucsc.edu> 
> > wrote:
> > 
> > That is just truly annoying. Is this described anywhere in their docs?
> 
> Not really. It's just there in the code--I can figure out the metric if 
> you're interested. I suspect it is local node, local rack, off rack 
> ordering, with no special tie breakers.
> 
> > I don't think it would be hard to sort, if we had some mechanism for 
> > doing so (crush map nearness, presumably?),
> 
> Topology information from the bucket hierarchy? I think it's always some 
> sort of heuristic.
> 
> >> 1. Expand CephFS interface to return IP and hostname
> > 
> > Ceph doesn't store hostnames anywhere ? it really can't do this. All 
> > it has is IPs associated with OSD ID numbers. :) Adding hostnames 
> > would be a monitor and map change, which we could do, but given the 
> > issues we've had with hostnames in other contexts I'd really rather 
> > not.
> 
> What is the fate of hostnames used in ceph.conf? Could that information 
> be leveraged, when specified by the cluster admin?

Those went hte way of the Dodo.

However, we do have host and rack information in the crush map, at least 
for non-customized installations.  How about something like

  string ceph_get_osd_crush_location(int osd, string type);

or similar.  We could call that with "host" and "rack" and get exactly 
what we need, without making any changes to the data structures.

sage
