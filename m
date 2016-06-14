From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: RocksDB tuning
Date: Tue, 14 Jun 2016 21:17:55 +0000
Message-ID: <BLUPR0201MB1524BE77AEB217D1A4F9D60AE8540@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
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
 <BLUPR0201MB1524FD851D0B04D64DC4944BE8540@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606141702470.27470@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0070.outbound.protection.outlook.com ([157.56.111.70]:42447
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932121AbcFNVR6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 17:17:58 -0400
In-Reply-To: <alpine.DEB.2.11.1606141702470.27470@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Tuesday, June 14, 2016 2:09 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Mark Nelson <mnelson@redhat.com>; Igor Fedotov
> <ifedotov@mirantis.com>; Somnath Roy <Somnath.Roy@sandisk.com>;
> Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>; Ceph
> Development <ceph-devel@vger.kernel.org>
> Subject: RE: RocksDB tuning
> 
> On Tue, 14 Jun 2016, Allen Samuels wrote:
> > For flash what we want to do is leave min_alloc_size at 4K and figure
> > out how to shrink the oNode so that the KV commit fits into a minimal
> > number of writes.
> >
> > There are two obvious things to do w.r.t. shrinking the oNode size:
> >
> > (1) sophisticated encode/decode function. I've talked about this
> > before, hopefully I'll have more time to dig into this shortly.
> >
> > (2) Reducing the stripe size. A larger stripe size tends to improve
> > sequential read/write speeds when the application is doing large I/O
> > operations (less I/O fracturing). It will also reduce metadata size by
> > amortizing the fixed size of an oNode (i.e., the stuff in an oNode
> > that doesn't scale with the object size) across fewer oNodes. Both of
> > these phenomenon provide decreasing benefits as the stripe size
> increases.
> > However, larger oNodes cost more to read/write them for random I/O
> > operations. I believe that for flash, the current default stripe size
> > of 4MB is too large in that the gains for sequential operations are
> > minimal and the penalty on random operations is too large... This
> > believe should be subjected to experimental verification AFTER we've
> > shrunk the oNode using (1). It's also possible that the optimal stripe
> > size (for flash) is HW dependent -- since the variance in performance
> > characteristics between different flash devices can be rather large.
> 
> Agreed on both of these.
> 
> Not mutually exclusive with (3), though: increase blob size via larger
> min_alloc_size.  4K random write benchmark write-amp aside, I still think we
> may end up with an onode size where the lower write latency and half to
> quarter-size lextent/blob map reduces metadata compaction overhead
> enough to offset the larger initial txn sizes.  We'll see when we benchmark.

Yes, we will see. I believe that on flash you'll still lose because you're writing the data twice. But let the benchmarking proceed!

(I'm assuming an oNode diet has already happended).

> 
> sage
