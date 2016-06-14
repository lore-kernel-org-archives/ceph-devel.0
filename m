From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: RocksDB tuning
Date: Tue, 14 Jun 2016 14:55:56 +0000
Message-ID: <BLUPR0201MB1524FD851D0B04D64DC4944BE8540@BLUPR0201MB1524.namprd02.prod.outlook.com>
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
 <0b91d95a-b933-0a21-1003-7dd7ac22e8a3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0069.outbound.protection.outlook.com ([157.56.111.69]:57754
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750789AbcFNO4A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 10:56:00 -0400
In-Reply-To: <0b91d95a-b933-0a21-1003-7dd7ac22e8a3@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Tuesday, June 14, 2016 6:01 AM
> To: Sage Weil <sweil@redhat.com>; Igor Fedotov <ifedotov@mirantis.com>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; Somnath Roy
> <Somnath.Roy@sandisk.com>; Manavalan Krishnan
> <Manavalan.Krishnan@sandisk.com>; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: Re: RocksDB tuning
> 
> 
> 
> On 06/14/2016 06:53 AM, Mark Nelson wrote:
> >
> >
> > On 06/14/2016 06:17 AM, Sage Weil wrote:
> >> On Tue, 14 Jun 2016, Igor Fedotov wrote:
> >>> This result are for compression = none and write block size limited
> >>> to 4K.
> >>
> >> I've been thinking more about this and I'm wondering if we should
> >> revisit the choice to use a min_alloc_size of 4K on flash.  If it's
> >> 4K, then a 4K write means
> >>
> >>  - 4K write (to newly allocated block)
> >>  - bdev flush
> >>  - kv commit (4k-ish?)
> >>  - bdev flush
> >
> > AFAIK these flushes should happen async under the hood (ie almost
> > free) on devices with proper power loss protection.
> >
> >>
> >> which puts a 2 write lower bound on latency.  If we have
> >> min_alloc_size of 8K or 16K, then a 4K write is
> >>
> >>  - kv commit (4K + 4k-ish)
> >>  - bdev flush
> >>  - [async] 4k write
> >
> > Given what I've seen about how rocksdb behaves (even on ramdisk), I
> > think this is actually going to be worse than above in a lot of cases.
> > I could be wrong though.  For SSDs that don't have PLP this might be
> > significantly faster.
> 
> Sage pointed out that the smaller min_alloc_size will increase the size of the
> onode.  More than anything this would probably be the reason imho to
> increase the min_alloc_size (so long as we can keep the extra data from
> moving out of the WAL).

For flash what we want to do is leave min_alloc_size at 4K and figure out how to shrink the oNode so that the KV commit fits into a minimal number of writes.

There are two obvious things to do w.r.t. shrinking the oNode size:

(1) sophisticated encode/decode function. I've talked about this before, hopefully I'll have more time to dig into this shortly.
(2) Reducing the stripe size. A larger stripe size tends to improve sequential read/write speeds when the application is doing large I/O operations (less I/O fracturing). It will also reduce metadata size by amortizing the fixed size of an oNode (i.e., the stuff in an oNode that doesn't scale with the object size) across fewer oNodes. Both of these phenomenon provide decreasing benefits as the stripe size increases. However, larger oNodes cost more to read/write them for random I/O operations. I believe that for flash, the current default stripe size of 4MB is too large in that the gains for sequential operations are minimal and the penalty on random operations is too large... This believe should be subjected to experimental verification AFTER we've shrunk the oNode using (1). It's also po
 ssible that the optimal stripe size (for flash) is HW dependent -- since the variance in performance characteristics between different flash devices can be rather large.

> 
> >
> >>
> >> Fewer bdev flushes, and only marginally more writes to the device.  I
> >> guess the question is is whether write-amp is really that important
> >> for a 4k workload?
> >>
> >> The upside of a larger min_alloc_size is the worst case metadata
> >> (onode) size is 1/2 or 1/4.  The sequential read cost of a previously
> >> random-written object will also be better (fewer IOs).
> >>
> >> There is probably a case where 4k min_alloc_size is the right choice
> >> but it feels like we're optimizing for write-amp to the detriment of
> >> other more important things.  For example, even after we improve the
> >> onode encoding, it may be that the larger metadata results in more
> >> write-amp than the WAL for the 4k writes does.
> >>
> >> sage
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >> in the body of a message to majordomo@vger.kernel.org More
> majordomo
> >> info at  http://vger.kernel.org/majordomo-info.html
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
