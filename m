From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Interesting results
Date: Thu, 28 Jun 2012 17:53:28 -0500
Message-ID: <4FECE068.1010701@inktank.com>
References: <4FECDCB0.7080406@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62367 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab2F1Wxs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 18:53:48 -0400
Received: by ghrr11 with SMTP id r11so2310596ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 15:53:47 -0700 (PDT)
In-Reply-To: <4FECDCB0.7080406@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/28/2012 05:37 PM, Jim Schutt wrote:
> Hi,
>
> Lots of trouble reports go by on the list - I thought
> it would be useful to report a success.
>
> Using a patch (https://lkml.org/lkml/2012/6/28/446)
> on top of 2.5-rc4 for my OSD servers, the same kernel
> for my Linux clients, and a recent master branch
> tip (git://github.com/ceph/ceph commit 4142ac44b3f),
> I was able to sustain streaming writes from 166 linux
> clients for 2 hours:
>
> On 166 clients:
> dd conv=fdatasync if=/dev/zero of=/mnt/ceph/stripe-4M/1/zero0.`hostname
> -s` bs=4k count=65536k
>
> Elapsed time: 7274.55 seconds
> Total data: 45629732.553 MB (43515904 MiB)
> Aggregate rate: 6272.516 MB/s
>
> That kernel patch was critical; without it this test
> runs into trouble after a few minutes because the
> kernel runs into trouble looking for pages to merge
> during page compaction. Also critical were the ceph
> tunings I mentioned here:
> http://www.spinics.net/lists/ceph-devel/msg07128.html
>
> -- Jim

Nice!  Did you see much performance degradation over time?  Internally 
I've sen some slow downs (especially at smaller block sizes) as the osds 
fill up.  How many servers and how many drives?

Still, those are the kinds of numbers I like to see.  Congrats! :)

Mark
