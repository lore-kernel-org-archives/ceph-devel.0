From: Sage Weil <sweil@redhat.com>
Subject: RE: BlueStore Performance issue
Date: Wed, 9 Mar 2016 10:38:19 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603091033200.14377@cpach.fuggernut.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com> <CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51726 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbcCIPil (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Mar 2016 10:38:41 -0500
In-Reply-To: <CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 9 Mar 2016, Allen Samuels wrote:
> > Stage 3 is serious bottleneck in that it guarantees that you will
> > never exceed QD=1 for your logging device. We believe there is no need
> > to serialize the KV commit operations.
> 
> It's potentially a bottleneck, yes, but it's also what keeps the commit 
> rate self-throttling.  If we assume that there are generally lots of 
> other IOs in flight because every op isn't metadata-only the QD will be 
> higher.
>
> If it's a separate log device, though, yes.. it will have QD=1.  In 
> those situations, though, the log device is probably faster than the 
> other devices, and a shallow QD probably isn't going to limit 
> throughput--just marginally increase latency?
> 
> [Allen] No a shallow queue depth will directly impact BW on many 
> (most?/all?) SSDs. I agree that in a hybrid model (DB on flash, data on 
> HDD) that the delivered performance delta may not be large. As for the 
> throttling, we haven't focused on that area yet (just enough to put it 
> on the list of future things to investigate).

FWIW in the single-device non-hybrid case, the QD=1 for *kv* IOs, but 
there will generally be a whole bunch of non-kv reads and writes also in 
flight.  I wouldn't expect us to ever actually have a QD of 1 unless 
*every* operation is pure-kv (say, omap operations).

For example, say we have 4 KB random writes, and the QD at the OSD level 
is 64.  In that case, BlueStore should have up to 64 4 KB aio writes and 0 
to 1 64*whatever kv writes in flight.

My intuition says that funneling the txn commits like this will in 
practice maybe halve the effective QD at the device (compared to the QD at 
the OSD)... does that seem about right?  Maybe it'd stay about the same, 
since 1 OSD IO is actually between 1 and 2 device IOs (the aio write + the 
[maybe batched] txn commit).

sage
