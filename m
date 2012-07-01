From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Interesting results
Date: Sun, 01 Jul 2012 21:57:13 +0200
Message-ID: <4FF0AB99.4060103@profihost.ag>
References: <4FECDCB0.7080406@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:32830 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab2GAT5M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jul 2012 15:57:12 -0400
In-Reply-To: <4FECDCB0.7080406@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

thanks for sharing. Which btrfs mount options did you use?

Am 29.06.2012 00:37, schrieb Jim Schutt:
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
>    dd conv=fdatasync if=/dev/zero
> of=/mnt/ceph/stripe-4M/1/zero0.`hostname -s` bs=4k count=65536k
>
> Elapsed time:   7274.55 seconds
> Total data:     45629732.553 MB (43515904 MiB)
> Aggregate rate: 6272.516 MB/s
>
> That kernel patch was critical; without it this test
> runs into trouble after a few minutes because the
> kernel runs into trouble looking for pages to merge
> during page compaction.  Also critical were the ceph
> tunings I mentioned here:
>    http://www.spinics.net/lists/ceph-devel/msg07128.html
>
> -- Jim
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

