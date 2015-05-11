From: Sage Weil <sage@newdream.net>
Subject: Re: rados bench single instance vs. multiple instances
Date: Mon, 11 May 2015 10:03:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55974 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbEKRDz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 13:03:55 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 11 May 2015, Deneau, Tom wrote:
> I have noticed the following while running rados bench seq read tests with a 40M object size
> 
>     single rados bench, 4 concurrent ops,                     bandwidth = 190 MB/s
>     4 copies of rados bench, 1 concurrent op each,  aggregate bandwidth = 310 MB/s
> 
> and in fact the single rados bench seems limited to 190, no matter how many concurrent ops.
> 
> I don't see this kind of behavior with a 4M object size.
> 
> (The above are with caches dropped on the osd targets)
> 
> It doesn't seem to be related to the total number of bytes being processed by the single 
> because if I don't drop the caches, both the single rados bench and the 4-copy rados bench
> get much higher numbers (600 vs. 900) but still the single rados bench appears limited, no matter
> how many concurrent ops are used.
> 
> Is there kind of throttling going on by design here?

It might be the librados throttles:

OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max in-flight data (both directions)
OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max in-flight ios

IIRC these only affect librados.. which would include 'rados bench'.

sage


