From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph Benchmark HowTo
Date: Wed, 01 Aug 2012 09:06:44 -0500
Message-ID: <501937F4.4080401@inktank.com>
References: <20120724144300.GA3317@mail.sileht.net> <20120731123106.GA29835@mail.sileht.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:65497 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab2HAOGs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 10:06:48 -0400
Received: by ggnl2 with SMTP id l2so47180ggn.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 07:06:47 -0700 (PDT)
In-Reply-To: <20120731123106.GA29835@mail.sileht.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mehdi Abaakouk <sileht@sileht.net>
Cc: ceph-devel@vger.kernel.org

On 7/31/12 7:31 AM, Mehdi Abaakouk wrote:
> Hi all,
>
> I have updated the how-to here:
> http://ceph.com/wiki/Benchmark
>
> And published the results of my latest tests:
> http://ceph.com/wiki/Benchmark#First_Example

I haven't actually used bonnie++ myself, but I've read some rather bad 
reports from various other people in the industry.  Not sure how much 
it's changed since then...

https://blogs.oracle.com/roch/entry/decoding_bonnie
http://www.quora.com/What-are-some-file-system-benchmarks
http://scalability.org/?p=1685
http://scalability.org/?p=1688

I'd say to just take extra care to make sure that that it's behaving the 
way you intended it to (probably good advice no matter which benchmark 
you use!)

>
> All results are good, my benchmark is clearly limited by my network
> connection ~ 110MB/s.

Gigabit Ethernet is definitely going to be a limitation with large block 
sequential IO for most modern disks.  I'm concerned with your 6 client 
numbers though.  I assume those numbers are per client?  Even so, with 
10 OSDs that performance is pretty bad!  Are you getting a good 
distribution of writes across all OSDs?  Consistent throughput over time 
on each?

>
> In exception of the rest-api bench, the value seems really low.

We've especially noticed that radosgw performance is lower with small IO 
sizes.  There's a lot of potential places where this could be happening 
between the client, radosgw, and Apache.  It's something we're going to 
be looking at over the next couple of months.

>
> I have configured radosgw with this:
> http://ceph.com/docs/master/radosgw/config/
> I clean disk cache on all servers before the bench,
> and start rest-bench for 900 seconds with default value.
>
> Is my rest-bench result normal ? Have I missed something ?

You may want to try increasing the number of concurrent rest-bench 
operations.  Also I'd explicitly specify the number of PGs for the pool 
you create to make sure that you are getting a good distribution.

>
> Don't hesitate if you need more informations on my setup.
>
> And then, I have another question about how is the Standard Deviation
> calculated with rados bench and rest-bench ? with the reported value
> printed each second by the benchmark client ?
> If yes, when latency is too high, the reported bandwith is sometime zero,
> then has the calculated StdDev for bandwith a sens ?
>

Good question!  I'll ping the author of that code to respond.

>
> Cheers,
>

Thanks,
Mark
