From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: perf counters from a performance discrepancy
Date: Wed, 23 Sep 2015 13:39:01 -0700
Message-ID: <CAJ4mKGap3+xK5yecofei-H7upgt4waiRH2fAPmVLEXdrAmUxjQ@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33099 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbbIWUjD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 16:39:03 -0400
Received: by wiclk2 with SMTP id lk2so1364777wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 13:39:01 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 9:33 AM, Deneau, Tom <tom.deneau@amd.com> wrote:
> Hi all --
>
> Looking for guidance with perf counters...
> I am trying to see whether the perf counters can tell me anything about the following discrepancy
>
> I populate a number of 40k size objects in each of two pools, poolA and poolB.
> Both pools cover osds on a single node, 5 osds total.
>
>    * Config 1 (1p):
>       * use single rados bench client with 32 threads to do seq read of 20000 objects from poolA.
>
>    * Config 2 (2p):
>       * use two concurrent rados bench clients (running on same client node) with 16 threads each,
>            one reading 10000 objects from poolA,
>            one reading 10000 objects from poolB,
>
> So in both configs, we have 32 threads total and the number of objects read is the same.
> Note: in all cases, we drop the caches before doing the seq reads
>
> The combined bandwidth (MB/sec) for the 2 clients in config 2 is about 1/3 of the bandwidth for
> the single client in config 1.
>
>
> I gathered perf counters before and after each run and looked at the difference of
> the before and after counters for both the 1p and 2p cases.  Here are some things I noticed
> that are different between the two runs.  Can someone take a look and let me know
> whether any of these differences are significant.  In particular, for the
> throttle-msgr_dispatch_throttler ones, since I don't know the detailed definitions of these fields.
> Note: these are the numbers for one of the 5 osds, the other osds are similar...
>
> * The field osd/loadavg is always about 3 times higher on the 2p c
>
> some latency-related counters
> ------------------------------
> osd/op_latency/sum 1p=6.24801117205061, 2p=579.722513078945
> osd/op_process_latency/sum 1p=3.48506945394911, 2p=42.6278494549915
> osd/op_r_latency/sum 1p=6.2480111719924, 2p=579.722513079003
> osd/op_r_process_latency/sum 1p=3.48506945399276, 2p=42.6278494550061

So if you've got 20k objects and 5 OSDs then each OSD is getting ~4k
reads during this test. Which if I'm reading these properly means
OSD-side latency is something like 1.5 milliseconds for the single
client and...144 milliseconds for the two-client case! You might try
dumping some of the historic ops out of the admin socket and seeing
where the time is getting spent (is it all on disk accesses?). And
trying to reproduce something like this workload on your disks without
Ceph involved.
-Greg
