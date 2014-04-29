From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: default filestore max sync interval
Date: Tue, 29 Apr 2014 20:46:53 +0000
Message-ID: <70a525545ab4d5616b0a79471d565485@webmail.vanderster.com>
References: <53600D67.1000501@profihost.ag>
 <3B502314D0477C4F9478870C279E14E60118278B1F@CERNXCHG51.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:33118 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758509AbaD2Uqz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Apr 2014 16:46:55 -0400
In-Reply-To: <53600D67.1000501@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

April 29 2014 10:36 PM, "Stefan Priebe"  wrote: 

> Hi Dan,
> 
> Am 29.04.2014 22:10, schrieb Dan Van Der Ster:
> 
> 
>> Hi all,
>> Why is the default max sync interval only 5 seconds?
>> 
>> Today we realized what a huge difference that increasing this to 30 or 60s can do for the small write latency. Basically, with a 5s interval our 4k write latency is above 30-35ms and once we increase it to 30s we can get under 10ms (using spinning disks for journal and data.)
>> 
>> See the attached plot for the affect of this on a running cluster (the plot shows the max, avg, min write latency from a short rados bench every 10 mins). The change from 5s to 60s was applied at noon today. (And our journals are large enough, don't worry).
>> 
>> In the interest of having sensible defaults, is there any reason not to increase this to 30s?
>> 
> 
> 
> I was playing with them too but didn't get any viewable results. How do
> you get / graph the ceph latency?

That plot is from

   rados bench -p test 10 write -b 65536 -t 1

run every 10 minutes and fed into some rrdtool thing.

But anyway, any single-threaded rados bench test with 1k or 4k objects shows a big obvious difference when I change the interval between 5s and 30s. If you don't observe that then perhaps this isn't as general as I thought.

Cheers, Dan

> 
> Greets,
> Stefan
>
