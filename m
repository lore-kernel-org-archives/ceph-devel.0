From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Interesting results
Date: Mon, 2 Jul 2012 08:04:48 -0600
Message-ID: <4FF1AA80.4070009@sandia.gov>
References: <4FECDCB0.7080406@sandia.gov>
 <4FF0AB99.4060103@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35841 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2GBOFI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 10:05:08 -0400
In-Reply-To: <4FF0AB99.4060103@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/01/2012 01:57 PM, Stefan Priebe wrote:
> thanks for sharing. Which btrfs mount options did you use?

  -o noatime

is all I use.

-- Jim

>
> Am 29.06.2012 00:37, schrieb Jim Schutt:
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
>> dd conv=fdatasync if=/dev/zero
>> of=/mnt/ceph/stripe-4M/1/zero0.`hostname -s` bs=4k count=65536k
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
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


