From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: default filestore max sync interval
Date: Tue, 29 Apr 2014 22:35:57 +0200
Message-ID: <53600D2D.2070900@profihost.ag>
References: <3B502314D0477C4F9478870C279E14E60118278B1F@CERNXCHG51.cern.ch> <CAPYLRzgEvr73iCYDyCvtrrF29iW1=PkEBEpr0GPeHpzRjG+hRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:40732 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaD2Umd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Apr 2014 16:42:33 -0400
In-Reply-To: <CAPYLRzgEvr73iCYDyCvtrrF29iW1=PkEBEpr0GPeHpzRjG+hRw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

H Greg,


Am 29.04.2014 22:23, schrieb Gregory Farnum:
> On Tue, Apr 29, 2014 at 1:10 PM, Dan Van Der Ster
> <daniel.vanderster@cern.ch> wrote:
>> Hi all,
>> Why is the default max sync interval only 5 seconds?
>>
>> Today we realized what a huge difference that increasing this to 30 or 60s can do for the small write latency. Basically, with a 5s interval our 4k write latency is above 30-35ms and once we increase it to 30s we can get under 10ms (using spinning disks for journal and data.)
>>
>> See the attached plot for the affect of this on a running cluster (the plot shows the max, avg, min write latency from a short rados bench every 10 mins). The change from 5s to 60s was applied at noon today. (And our journals are large enough, don't worry).
>>
>> In the interest of having sensible defaults, is there any reason not to increase this to 30s?
>
> If you've got reasonable confidence in the quality of your
> measurements across the workloads you serve, you should bump it up.
> Part of what might be happening here is simply that fewer of your
> small-io writes are running into a sync interval.
> I suspect that most users will see improvement by bumping up the
> limits and occasionally agitate to change the defaults, but Sam has
> always pushed back against doing so for reasons I don't entirely
> recall. :) (The potential for a burstier throughput profile?)
> -Greg

What is about those?

         filestore queue max ops = 500
         filestore_queue_committing_max_ops = 5000
         filestore_queue_max_bytes = 419430400
         filestore_queue_committing_max_bytes = 419430400

   filestore_wbthrottle_xfs_bytes_start_flusher = 125829120
   filestore_wbthrottle_xfs_bytes_hard_limit = 419430400
   filestore_wbthrottle_xfs_ios_start_flusher = 5000
   filestore_wbthrottle_xfs_ios_hard_limit = 50000
   filestore_wbthrottle_xfs_inodes_start_flusher = 1000
   filestore_wbthrottle_xfs_inodes_hard_limit = 10000

They should be adjusted too? right?

Stefan
