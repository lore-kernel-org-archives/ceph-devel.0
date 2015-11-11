From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Increasing # Shards vs multi-OSDs per device
Date: Wed, 11 Nov 2015 15:01:37 -0600
Message-ID: <5643ACB1.6040102@redhat.com>
References: <3649A15A2562B54294DE14BCE5AC79120B8ED66F@ORSMSX160.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbbKKVBl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Nov 2015 16:01:41 -0500
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120B8ED66F@ORSMSX160.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sjust@redhat.com>, Kyle Bader <kbader@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>

Hi Stephen,

That's about what I expected to see, other than the write performance 
drop with more shards.  We clearly still have some room for improvement.

Good job doing the testing!

Mark

On 11/11/2015 02:57 PM, Blinick, Stephen L wrote:
> Sorry about the microphone issues in the performance meeting today today.   This is a followup to the 11/4 performance meeting where we discussed increasing the worker thread count in the OSD's vs making multiple OSD's (and partitions/filesystems) per device.     We did the high level experiment and have some results which I threw into a ppt/pdf, and shared them here:
>
> http://www.docdroid.net/UbmvGnH/increasing-shards-vs-multiple-osds.pdf.html
>
> Doing 20-shard OSD's vs 4 OSD's per device with default 5 shards yielded about half of the performance improvement for random 4k reads.  For writes performance is actually worse than just 1 OSD per device and the default # of shards.  The throttles should be large enough for the 20-shard use case as they are 10x the defaults, although if you see anything we missed let us know.
>
> I had the cluster moved to Infernalis release (with JEMalloc) yesterday, so hopefully we'll have some early results on the same 5-node cluster soon.
>
> Thanks,
>
> Stephen
>
>
