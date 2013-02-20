From: Sage Weil <sage@inktank.com>
Subject: Re: Hadoop DNS/topology details
Date: Wed, 20 Feb 2013 09:31:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302200930060.26205@cobra.newdream.net>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu> <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com> <16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu> <alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net>
 <E6DCD080-3F18-40D2-95F1-EE66B1C468CB@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44011 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934295Ab3BTRbV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 12:31:21 -0500
In-Reply-To: <E6DCD080-3F18-40D2-95F1-EE66B1C468CB@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joe Buck <jbbuck@gmail.com>

On Wed, 20 Feb 2013, Noah Watkins wrote:
> 
> On Feb 19, 2013, at 4:39 PM, Sage Weil <sage@inktank.com> wrote:
> 
> > However, we do have host and rack information in the crush map, at least 
> > for non-customized installations.  How about something like
> > 
> >  string ceph_get_osd_crush_location(int osd, string type);
> > 
> > or similar.  We could call that with "host" and "rack" and get exactly 
> > what we need, without making any changes to the data structures.
> 
> This would then be used in conjunction with an interface:
> 
>  ceph_offset_to_osds(offset, vector<int>& osds)
>     ...
>     osdmpa->pg_to_acting_osds(osds)
>     ...
> 
> or something like this that replaces the current extent-to-sockaddr 
> interface? The proposed interface about would do the host/ip mapping, as 
> well as the topology mapping?

Yeah.  The ceph_offset_to_osds should probably also have an (optional?) 
out argument that tells you how long the extent is starting from offset 
that is on those devices.  Then you can do another call at offset+len to 
get the next segment.

sage

