From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Re: Example of RADOS AIO?
Date: Wed, 22 Dec 2010 00:39:11 +0900
Message-ID: <404DCABB-9967-4ACA-B42C-FD1F654DABAD@gmail.com>
References: <7D2A2270-AEE9-4FE2-810F-E84BC0B2BD6A@gmail.com> <Pine.LNX.4.64.1012191116560.10950@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54366 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0LUPjU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 10:39:20 -0500
Received: by pva4 with SMTP id 4so853395pva.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Dec 2010 07:39:20 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1012191116560.10950@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


Hi Sage, 

Thanks for your advice. Yes, I was talking about write-ahead journal, and it was good to know synchronous commit can be faster in some cases. 

> If you have a writeahead journal,
> the commit always comes first.  And if you have a fast journal device
> (SSD, NVRAM, RAID card with NVRAM, etc.) it will also be predictably fast.
> 
> And if it's a journal you rely on for consistency, I'd be very careful
> about relaxing your safety guarantees!

I know what you mean. But, I'll let HBase users to choose speed v.s. safety tradeoff on each write. 

Right now, HBase users can specify the level of consistency guarantees on each write. They can choose either writing journal to the in-memory buffer of HDFS or not writing journal at all. There is no option to commit journal to the disk on each write because HDFS doesn't have necessary feature to do that. HDFS only flushes the buffer to disk when the file is closed or the file size reaches to the block size (64MB)  We think it's still safe because there are 3 replicas in HDFS memory. 

But with Ceph / RADOS, I could create another option to commit journal to the disk for the maximum safety. And if it runs faster in some cases, that could be a great option. 

Thanks, 
Tatsuya 



2010/12/20 Sage Weil <sage@newdream.net>:
> On Sun, 19 Dec 2010, Tatsuya Kawano wrote:
>> Is there any example of asynchronous IO on RADOS (librados)? When I
>> write some bytes to an object, I'm only interested on the ack, which
>> means writes are applied to all the OSDs within the same placement group
>> but not yet committed to the disks. I'll use this feature to write HBase
>> journals.
>
> There is an example in the rados_bencher.h file, and in
> testrados[pp].c[c].
>
> One thing to keep in mind, though, is that in some cases commit is
> actually faster.  Sometimes writing to the fs can be bursty (latency
> spikes while btrfs is doing a commit).  If you have a writeahead journal,
> the commit always comes first.  And if you have a fast journal device
> (SSD, NVRAM, RAID card with NVRAM, etc.) it will also be predictably fast.
>
> And if it's a journal you rely on for consistency, I'd be very careful
> about relaxing your safety guarantees!
>
> sage

