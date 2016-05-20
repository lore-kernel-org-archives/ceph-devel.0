From: Sage Weil <sweil@redhat.com>
Subject: RE: Min alloc size according to media type
Date: Fri, 20 May 2016 16:32:23 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605201626590.6221@cpach.fuggernut.com>
References: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com> <alpine.DEB.2.11.1605191515090.6221@cpach.fuggernut.com> <BLUPR0201MB1524D22BDBA93E7F438D4382E84A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CY1PR0201MB1820EC5C25417E8F1EA1CF1E854B0@CY1PR0201MB1820.namprd02.prod.outlook.com> <alpine.DEB.2.11.1605200604440.6221@cpach.fuggernut.com> <4047211f-426c-69eb-2028-893d5197511a@redhat.com> <BLUPR0201MB152483D22FC798F752C78BBEE84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605201502280.6221@cpach.fuggernut.com> <BLUPR0201MB1524C282653376B0DA7CAF06E84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36702 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbcETUcG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 May 2016 16:32:06 -0400
In-Reply-To: <BLUPR0201MB1524C282653376B0DA7CAF06E84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 20 May 2016, Allen Samuels wrote:
> > On Fri, 20 May 2016, Allen Samuels wrote:
> > > > > I think having bluestore_min_alloc_size,
> > > > > bluestore_min_alloc_size_hdd, and bluestore_min_alloc_size_ssd
> > > > > still makes it easier to change for users. It'll only go in one
> > > > > bit of code that updates the BlueStore min_alloc_size member.
> > > >
> > > > If we really want to go down this road, would it make sense to
> > > > create storage class templates rather than global configuration
> > parameters?
> > > > Presumably you might want different compression, read ahead, or
> > > > writeback caching depending on the device class as well.
> > >
> > > I believe that administratively, you want to do this on a per-pool
> > > basis rather than on a device class basis.
> > 
> > For min_alloc_size, I'm not sure we would vary this per-pool.. it seems like
> > it's a property of the device, not the data set.
> 
> Agreed, I didn't proof-read what I sent. I was focused on the more data- 
> and access-oriented things like compression, read-ahead, etc. Yes, block 
> sizes are per-device not per-pool....

Excellent

> > However, for compression and checksums, *definitely*.  We just
> > brainstormed a bunch of bluestore config options to do this for compression,
> > but you're right that pretty much all of this should really be a per-pool thing.
> > 
> > I think that means we want to construct a bit of the ObjectStore interface
> > that passes the profile down to each Collection, and store it there.  Then the
> > profile options would be interpreted there by BlueStore.  These would
> > probably be
> > 
> >  compression mode = force | aggressive | passive | none
> >  compression algorithm = snappy | zlib
> >  compression min blob size = 262144
> >  compression max blob size = 4194304
> 
> Let's make the per-pool thing more expressive and extensible than just 
> for blue-store (maybe a JSON blob?). I believe that are LOTS more places 
> where configuration information should be provided on a per-pool basis.

So we do already have an extensible pool property mechanism:

	https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L959

It's not JSON, but it's extensible key/value pairs with values of int, 
double, or string, which I think is enough here.

> > The osd options are still useful for testing purposes, I think. Maybe a simple
> > policy that the per-pool options will just override the config option if they are
> > specified is sufficient?  If we can keep the pool and config options 1:1
> > (modulo the bluestore_ prefix, perhaps) that would keep things
> > understandable.
> 
> +1

If we do this, we need to make a nice way to plumb hte pool 
properties down to teh ObjectStore collections, but the nice thing is that 
if we map 1:1 to config options we can focus on the bluestore 
functionality now without that blocking us.

sage
