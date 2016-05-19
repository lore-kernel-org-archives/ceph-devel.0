From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Min alloc size according to media type
Date: Thu, 19 May 2016 20:29:47 +0000
Message-ID: <BLUPR0201MB1524D22BDBA93E7F438D4382E84A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605191515090.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0081.outbound.protection.outlook.com ([65.55.169.81]:33849
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933159AbcESUo5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 16:44:57 -0400
In-Reply-To: <alpine.DEB.2.11.1605191515090.6221@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Thursday, May 19, 2016 12:20 PM
> To: Ramesh Chander <Ramesh.Chander@sandisk.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Min alloc size according to media type
> 
> On Thu, 19 May 2016, Ramesh Chander wrote:
> > Hi Sage,
> >
> > I am doing changes in Bluestore related to minimum allocation size
> > according to ssd and hdd. This change involves:
> >
> > 1. There are three min alloc sizes now:
> >                 a. min_alloc_size: old one, default changed to 0
> >                 b. min_alloc_size_hdd: for rotational media, default 64k
> >                 c. min_alloc_size_ssd: for ssd, default 4k.
> >
> > 2. Making changes in BlockDevice to maintain its own min_alloc_size.
> > It allows to maintain different min_alloc_size for different devices.
> >
> > 3. Making changes in allocator(stupid, bitmap) interfaces to take
> > min_alloc_size from the corresponding devices.
> 
> This makes sense if some devices are hdd and some are ssd (e.g., main vs
> db/wal), but in practice the only separation currently possible is to have a
> separate device for WAL and for rocksdb, both of which hare managed by
> bluefs and not bluestore directly.  Ane bluefs currently has a min_alloc_size
> of 1MB since all files are generally big (usually 4MB each), there are no
> random writes, etc.
> 
> Unless we want to make bluestore smart enough to push object data on a
> fast device (i.e., do ssd/hdd tiering internally), I'm not sure we need per-
> device min_alloc_size.

I think this is / will be valuable -- in the future. I don't see that this item significantly simplifies the future problem.

> 
> > I have following questions regarding this parameter and use of it in
> > bluestore:
> >
> > 1. I assume this parameter is transient and does not have effect on
> > different values (say changed from 4k to 64k or vice versa) across
> > reboots or different ceph versions?
> >                 Is it ondisk anywhere in metadata or in freelist manager
> >                 in direct or indirect manner? Because having on disk
> >                 presence could cause confusions by having new options
> >                 when existing users move to build with this change.
> 
> Currently it is transient everywhere, and so far I've been trying to keep it that
> way.  However, we might want to change this: if we make min_alloc_size
> fixed at mkfs time, we could possibly collapse down the size of the allocation
> bitmap(s) by a factor of 16 on HDD (1 bit per min_alloc_size instead of per
> block).  I'm not sure that it's worth it, though... thoughts?

Collapsing the bitmap provides little DRAM savings and probably not much CPU time savings (though some additional (low risk) coding might be required to make this statement true), so I don't see much point in it.
Seems like extra complexity with little value.

> 
> > 2. While figuring out the min_alloc_size for devices, I give
> > preferences to old config parameter so that existing configs
> >                 are not changed by this code change. Is this right or
> > this is not required?
> 
> Don't worry about legacy at all since bluestore has no users.  :)
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
