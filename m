From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Rados faster than KVM block device?
Date: Thu, 28 Jun 2012 23:17:09 +0200
Message-ID: <4FECC9D5.9050202@profihost.ag>
References: <4FEC57BE.9060703@profihost.ag> <4FEC8252.90208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59658 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2F1VRL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 17:17:11 -0400
In-Reply-To: <4FEC8252.90208@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 28.06.2012 18:12, schrieb Josh Durgin:
> On 06/28/2012 06:10 AM, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> my cluster is now pretty stable i'm just wondering about the sequential
>> write values.
>>
>> With rados bench command and 16 threads i get totally different values
>> than with KVM and rbd block device.
>>
>> rados -p kvmpool bench 60 write -t 16:
>> pool size 2: Bandwidth (MB/sec):     1137.294
>> pool size 3: Bandwidth (MB/sec):     846.983
>>
>> Inside KVM with fio:
>>
>> fio --filename=$DISK --direct=1 --rw=write --bs=4M --size=200G
>> --numjobs=16 --runtime=60 --group_reporting --name=file1:
>
> There are a number of differences between running that in a vm on rbd
> and rados bench.
>
> Keep in mind it's running on a filesystem, so requests go through the
> guest fs and block layer before getting into librbd.
No it doesn't i'm testing directly the block device.

> If you don't use direct I/O, and you enable rbd writeback caching,
> librbd will be able to merge many of the smaller requests and
> you should see much better throughput.
I'm already using rbd writeback and it works good for random 4k writes, 
But it doesn't make sense for sequential 4M writes.

Stefan
