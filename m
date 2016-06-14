From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: RocksDB tuning
Date: Tue, 14 Jun 2016 15:01:33 +0000
Message-ID: <BLUPR0201MB1524754F10E72CDD83E55D89E8540@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
 <BL2PR02MB2115DF8FF9EF7CF822C838BAF4500@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606100533300.6221@cpach.fuggernut.com>
 <BLUPR0201MB15246B72324C2D633EBCB21AE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606101052190.6221@cpach.fuggernut.com>
 <BLUPR0201MB15247A41BDD4C4D49FD7AA8AE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <BL2PR02MB2115E53F772F80B3CBA36842F4500@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606101139590.6221@cpach.fuggernut.com>
 <9b9e6fb5-250c-0b8e-b356-f0814103bcc5@mirantis.com>
 <BLUPR0201MB1524B3804817815A542A44EBE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <393863fe-933c-738b-79b6-8338bc94b240@mirantis.com>
 <alpine.DEB.2.11.1606101415320.6221@cpach.fuggernut.com>
 <5b255c4f-58a2-034b-e2cb-1aa28b1ea217@mirantis.com>
 <alpine.DEB.2.11.1606140712270.29071@cpach.fuggernut.com>
 <b6610943-8380-8bff-baf3-839057f3b4da@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0095.outbound.protection.outlook.com ([207.46.100.95]:15360
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750968AbcFNPQm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 11:16:42 -0400
In-Reply-To: <b6610943-8380-8bff-baf3-839057f3b4da@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Tuesday, June 14, 2016 4:54 AM
> To: Sage Weil <sweil@redhat.com>; Igor Fedotov <ifedotov@mirantis.com>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; Somnath Roy
> <Somnath.Roy@sandisk.com>; Manavalan Krishnan
> <Manavalan.Krishnan@sandisk.com>; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: Re: RocksDB tuning
> 
> 
> 
> On 06/14/2016 06:17 AM, Sage Weil wrote:
> > On Tue, 14 Jun 2016, Igor Fedotov wrote:
> >> This result are for compression = none and write block size limited
> >> to 4K.
> >
> > I've been thinking more about this and I'm wondering if we should
> > revisit the choice to use a min_alloc_size of 4K on flash.  If it's
> > 4K, then a 4K write means
> >
> >  - 4K write (to newly allocated block)
> >  - bdev flush
> >  - kv commit (4k-ish?)
> >  - bdev flush
> 
> AFAIK these flushes should happen async under the hood (ie almost free) on
> devices with proper power loss protection.

Correct, from the device perspective. However, you're still burning CPU time on the host which is often the bottleneck for flash performance.

It'll pay to have a toggle to disable the bdev flushes when you're known to be running with enterprise-grade devices (i.e., "proper power loss protection")

> 
> >
> > which puts a 2 write lower bound on latency.  If we have
> > min_alloc_size of 8K or 16K, then a 4K write is
> >
> >  - kv commit (4K + 4k-ish)
> >  - bdev flush
> >  - [async] 4k write
> 
> Given what I've seen about how rocksdb behaves (even on ramdisk), I think
> this is actually going to be worse than above in a lot of cases.
> I could be wrong though.  For SSDs that don't have PLP this might be
> significantly faster.
> 
> >
> > Fewer bdev flushes, and only marginally more writes to the device.  I
> > guess the question is is whether write-amp is really that important for a
> > 4k workload?
> >
> > The upside of a larger min_alloc_size is the worst case metadata (onode)
> > size is 1/2 or 1/4.  The sequential read cost of a previously
> > random-written object will also be better (fewer IOs).
> >
> > There is probably a case where 4k min_alloc_size is the right choice but
> > it feels like we're optimizing for write-amp to the detriment of other
> > more important things.  For example, even after we improve the onode
> > encoding, it may be that the larger metadata results in more write-amp
> > than the WAL for the 4k writes does.
> >
> > sage
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
