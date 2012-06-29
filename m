From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Interesting results
Date: Fri, 29 Jun 2012 08:54:25 -0600
Message-ID: <4FEDC1A1.9050808@sandia.gov>
References: <4FECDCB0.7080406@sandia.gov> <4FECE068.1010701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:54818 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab2F2Oyr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 10:54:47 -0400
In-Reply-To: <4FECE068.1010701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/28/2012 04:53 PM, Mark Nelson wrote:
> On 06/28/2012 05:37 PM, Jim Schutt wrote:
>> Hi,
>>
>> Lots of trouble reports go by on the list - I thought
>> it would be useful to report a success.
>>
>> Using a patch (https://lkml.org/lkml/2012/6/28/446)
>> on top of 2.5-rc4 for my OSD servers, the same kernel
>> for my Linux clients, and a recent master branch
>> tip (git://github.com/ceph/ceph commit 4142ac44b3f),
>> I was able to sustain streaming writes from 166 linux
>> clients for 2 hours:
>>
>> On 166 clients:
>> dd conv=fdatasync if=/dev/zero of=/mnt/ceph/stripe-4M/1/zero0.`hostname
>> -s` bs=4k count=65536k
>>
>> Elapsed time: 7274.55 seconds
>> Total data: 45629732.553 MB (43515904 MiB)
>> Aggregate rate: 6272.516 MB/s
>>
>> That kernel patch was critical; without it this test
>> runs into trouble after a few minutes because the
>> kernel runs into trouble looking for pages to merge
>> during page compaction. Also critical were the ceph
>> tunings I mentioned here:
>> http://www.spinics.net/lists/ceph-devel/msg07128.html
>>
>> -- Jim
>
> Nice! Did you see much performance degradation over time? Internally I've sen some slow downs (especially at smaller block sizes) as the osds fill up. How many servers and how many drives?
>

This result is from 12 servers, 24 OSDs/server, starting
from a freshly-built filesystem. I use 64KB btrfs metadata
nodes.

There is some performance degradation during such runs.
During the initial 10 TB or so, each server sustains ~2.2 GB/s,
as reported by vmstat.

Nearer the end of the run, data rate on each server is
much more variable, with peaks at ~2 GB/s and valleys at
~1.5 GB/s.

I am suspecting that some of that variability comes from
the OSDs not filling up uniformly; here's low/high utilization
at the end of the run:

server                     1K-blocks      Used Available Use% Mounted on

cs42:                      939095640 258202860 662416404  29% /ram/mnt/ceph/data.osd.261
cs38:                      939095640 259052468 661568524  29% /ram/mnt/ceph/data.osd.154
cs39:                      939095640 264803592 655825592  29% /ram/mnt/ceph/data.osd.174
cs34:                      939095640 265911256 654711400  29% /ram/mnt/ceph/data.osd.52
cs41:                      939095640 270588260 650049820  30% /ram/mnt/ceph/data.osd.238

cs33:                      939095640 345327760 575399472  38% /ram/mnt/ceph/data.osd.47
cs40:                      939095640 351180832 569558176  39% /ram/mnt/ceph/data.osd.205
cs35:                      939095640 351372096 569365696  39% /ram/mnt/ceph/data.osd.89
cs41:                      939095640 352522904 568214632  39% /ram/mnt/ceph/data.osd.217
cs33:                      939095640 358181684 562561740  39% /ram/mnt/ceph/data.osd.35

  max/min: 1.3872

Note that I am using osd_pg_bits=7, osd_pgp_bits=7.  I have plans
to push that to see what happens.  I've also got another dozen
servers on a truck somewhere on their way to here....

The under-utilized OSDs finish early, which I believe contributes
to performance tailing off at the end of such a run.  I don't have
any data on how big this effect might be.

I haven't yet tested filling my filesystem to capacity, so I have no
data regarding what happens as the disks fill up.

> Still, those are the kinds of numbers I like to see. Congrats! :)

Thanks - I think it's pretty cool that testing
Ceph found a performance issue in the kernel.

-- Jim

>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


