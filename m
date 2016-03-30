From: Sage Weil <sage@newdream.net>
Subject: Re: Adding compression support for bluestore.
Date: Wed, 30 Mar 2016 08:47:01 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603300840560.22014@cpach.fuggernut.com>
References: <56C1FCF3.4030505@mirantis.com> <56C3BAA3.3070804@mirantis.com> <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com> <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com> <56D08E30.20308@mirantis.com> <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com> <56E9A727.1030400@mirantis.com> <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <56EACAAD.90002@mirantis.com> <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com> <56EC248E.3060502@mirantis.com> <CY1PR0201MB1897035E6E09FE518ACC2DDCE88D0@CY1PR0201MB1897.namprd02.prod.outlook.com> <56F013FB.4040002@mirantis.com>
 <alpine.DEB.2.11.1603211141560.23875@cpach.fuggernut.com> <56F3E157.2090004@mirantis.com> <alpine.DEB.2.11.1603291602330.6473@cpach.fuggernut.com> <56FBC684.6090700@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49357 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbcC3MrL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 08:47:11 -0400
In-Reply-To: <56FBC684.6090700@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 30 Mar 2016, Igor Fedotov wrote:
> On 29.03.2016 23:19, Sage Weil wrote:
> > On Thu, 24 Mar 2016, Igor Fedotov wrote:
> > > Sage, Allen et. al.
> > > 
> > > Please find some follow-up on our discussion below.
> > > 
> > > Your past and future comments are highly appreciated.
> > > 
> > > WRITE/COMPRESSION POLICY and INTERNAL BLUESTORE STRUCTURES OVERVIEW.
> > > 
> > > Used terminology:
> > > Extent - basic allocation unit. Variable in size, maximum size is limited
> > > by
> > > lblock length (see below), alignment: min_alloc_unit param (configurable,
> > > expected range: 4-64 Kb .
> > > Logical Block (lblock) - standalone traceable data unit. Min size
> > > unspecified.
> > > Alignment unspecified. Max size limited by max_logical_unit param
> > > (configurable, expected range: 128-512 Kb)
> > > 
> > > Compression to be applied on per-extent basis.
> > > Multiple lblocks can refer specific region within a single extent.
> > This (and the what's below) sound right to me.  My main concern is around
> > naming.  I don't much like "extent" vs "lblock" (which is which?).  Maybe
> > extent and extent_ref?
> > 
> > Also, I don't think we need the size limits you mention above.  When
> > compression is enabled, we'll limit the size of the disk extents by
> > policy, but the structures themselves needn't enforce that.  Similarly, I
> > don't think the lblocks (extent refs?  logical extents?) need a max size
> > either.
> Actually structures themselves don't have explicit limits except length fields
> width. But I'd prefer to enforce such a limit in the code ( add a policy?)
> that handles write (or perform merge ) to avoid huge l(p)extents for both
> compressed and uncompressed cases.
> The rationale for that is potentially ineffective space usage. Partially
> overlapped writes occlude previous extents thus the larger they are the more
> probable such occluding take place and more space is wasted. Moreover IMHO
> leaving the control over extent granularity ( if we don't enforce any limit
> they totally depend on the user write pattern) isn't a good idea in any case.

I'm thinking of the uncompressed case, where we can deallocate whatever 
min_alloc_size-aligned portion of the pextext we overwrite.  Similarly, in 
the checksum case, the size of the piece we have to r/m/w will depend on 
the checksum granularity.  Right now that code assumes it's always a 
single block, but I think it will become a function of the pextent 
properties (what size portion of the pextent can be modified?  
block-aligned, or checksum-block aligned, or is the entire pextent a 
single unit?).

> Would you like to have new data structures completely ready at this stage?
> With all checksum/compression/flag fields present?
> As for me I'd prefer to add them incrementally when specific feature (
> compression, checksum verification etc.) is implemented.
> It might be hard to design all of them at once. And probably blocks the
> implementation until all the discussions completion.

Just placeholder fields are fine. The main thing we want to not forget is 
that the pextent may be big (due to checksums), but we've already settled 
on a pextent/lextent approach that addresses that issue.  The other thing 
is that the checksum granuarity might vary, making the overwrite/update 
unit a function of the pextent, as I mentioned above.

Just a lot of considerations to juggle, and even a placeholder will help 
remind us. :)

sage
