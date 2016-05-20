From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Min alloc size according to media type
Date: Fri, 20 May 2016 20:21:56 +0000
Message-ID: <BLUPR0201MB1524C282653376B0DA7CAF06E84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605191515090.6221@cpach.fuggernut.com>
 <BLUPR0201MB1524D22BDBA93E7F438D4382E84A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CY1PR0201MB1820EC5C25417E8F1EA1CF1E854B0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605200604440.6221@cpach.fuggernut.com>
 <4047211f-426c-69eb-2028-893d5197511a@redhat.com>
 <BLUPR0201MB152483D22FC798F752C78BBEE84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605201502280.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0057.outbound.protection.outlook.com ([157.56.111.57]:9312
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750795AbcETUV7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 May 2016 16:21:59 -0400
In-Reply-To: <alpine.DEB.2.11.1605201502280.6221@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> On Fri, 20 May 2016, Allen Samuels wrote:
> > > > I think having bluestore_min_alloc_size,
> > > > bluestore_min_alloc_size_hdd, and bluestore_min_alloc_size_ssd
> > > > still makes it easier to change for users. It'll only go in one
> > > > bit of code that updates the BlueStore min_alloc_size member.
> > >
> > > If we really want to go down this road, would it make sense to
> > > create storage class templates rather than global configuration
> parameters?
> > > Presumably you might want different compression, read ahead, or
> > > writeback caching depending on the device class as well.
> >
> > I believe that administratively, you want to do this on a per-pool
> > basis rather than on a device class basis.
> 
> For min_alloc_size, I'm not sure we would vary this per-pool.. it seems like
> it's a property of the device, not the data set.

Agreed, I didn't proof-read what I sent. I was focused on the more data- and access-oriented things like compression, read-ahead, etc. Yes, block sizes are per-device not per-pool.... 
> 
> However, for compression and checksums, *definitely*.  We just
> brainstormed a bunch of bluestore config options to do this for compression,
> but you're right that pretty much all of this should really be a per-pool thing.
> 
> I think that means we want to construct a bit of the ObjectStore interface
> that passes the profile down to each Collection, and store it there.  Then the
> profile options would be interpreted there by BlueStore.  These would
> probably be
> 
>  compression mode = force | aggressive | passive | none  compression
> algorithm = snappy | zlib  compression min blob size = 262144  compression
> max blob size = 4194304

Let's make the per-pool thing more expressive and extensible than just for blue-store (maybe a JSON blob?). I believe that are LOTS more places where configuration information should be provided on a per-pool basis.

> 
> ?
> 
> The osd options are still useful for testing purposes, I think. Maybe a simple
> policy that the per-pool options will just override the config option if they are
> specified is sufficient?  If we can keep the pool and config options 1:1
> (modulo the bluestore_ prefix, perhaps) that would keep things
> understandable.

+1

> 
> sage
