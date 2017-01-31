From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
        <bartlomiej.swiecki@corp.ovh.com>
Subject: Re: Proposition - latency histogram
Date: Tue, 31 Jan 2017 16:22:47 +0100
Message-ID: <985bd632-be25-e281-9249-d4ef5772c821@corp.ovh.com>
References: <69bf4eec-3959-f021-ad8f-d1b6d3e2ceaf@corp.ovh.com>
 <b2b52f75-0e26-2dac-df6a-ea7bfd91a973@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mo302.mail-out.ovh.net ([137.74.110.2]:39928 "EHLO
        mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdAaPXw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2017 10:23:52 -0500
Received: from EX4.OVH.local (gw1.corp.ovh.com [51.255.55.226])
        by mo302.mail-out.ovh.net (Postfix) with ESMTPS id ED9A9D1CC
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2017 16:22:56 +0100 (CET)
In-Reply-To: <b2b52f75-0e26-2dac-df6a-ea7bfd91a973@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Bringing back performance histograms: 
https://github.com/ceph/ceph/pull/12829
I've updated the PR, rebased on master and made internal changes less 
aggressive.

All ctest tests passing and I haven't seen any issues with performance
(and I can actually see much better what the performance characteristics are

Waiting for your comments,
Bartek



Looking

On 01/09/2017 12:27 PM, Bartłomiej Święcki wrote:
> Hi,
>
> I've made a simple implementation of performance histograms. 
> Implementation is not very sophisticated
> but I think it could be a good start for more detailed discussion.
>
> Here's the PR: https://github.com/ceph/ceph/pull/12829
>
>
> Regards,
> Bartek
>
>
> On 11/28/2016 05:22 PM, Bartłomiej Święcki wrote:
>> Hi,
>>
>>
>> Currently we can query OSD for op latency but it's given as an 
>> average. Average may not give
>> the bets information in this case - i.e. spikes can easily get hidden 
>> there.
>>
>> Instead of an average we could easily do a simple histogram - 
>> quantize the latency into
>> predefined set of time intervals, for each of them have a simple 
>> performance counter,
>> at each op increase one of them. Since those are per OSD, we could 
>> have pretty high resolution
>> with fractional memory usage, performance impact should be negligible 
>> since only one (two if split
>> into read and write) of those counters would be incremented per one 
>> osd op.
>>
>> In addition we could also do this in 2D - each counter matching given 
>> latency range and op size range.
>> having such 2D table would show both latency histogram, request size 
>> histogram and combinations of those
>> (i.e. latency histogram of ~4k ops only).
>>
>> What do you think about this idea? I can prepare some code - a simple 
>> proof of concept looks really
>> straightforward to implement.
>>
>>
>> Bartek
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

