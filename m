From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Rados faster than KVM block device?
Date: Thu, 28 Jun 2012 09:12:02 -0700
Message-ID: <4FEC8252.90208@inktank.com>
References: <4FEC57BE.9060703@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41658 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab2F1QMF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 12:12:05 -0400
Received: by yenl2 with SMTP id l2so1969009yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 09:12:04 -0700 (PDT)
In-Reply-To: <4FEC57BE.9060703@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/28/2012 06:10 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> my cluster is now pretty stable i'm just wondering about the sequential
> write values.
>
> With rados bench command and 16 threads i get totally different values
> than with KVM and rbd block device.
>
> rados -p kvmpool bench 60 write -t 16:
> pool size 2: Bandwidth (MB/sec):     1137.294
> pool size 3: Bandwidth (MB/sec):     846.983
>
> Inside KVM with fio:
>
> fio --filename=$DISK --direct=1 --rw=write --bs=4M --size=200G
> --numjobs=16 --runtime=60 --group_reporting --name=file1:

There are a number of differences between running that in a vm on rbd
and rados bench.

Keep in mind it's running on a filesystem, so requests go through the
guest fs and block layer before getting into librbd. These two layers
can break up those 4M writes, so you end up doing a bunch more small
I/Os which degrades performance a bunch. Running those 16 processes in
does not directly translate to 16 I/Os in flight from the guest kernel,
like rados bench is doing. If you use blktrace on the guest, or just
add --debug-ms 1, you can track the requests the guest is sending by
looking at the lines with 'osd_op\(.*'.

If you don't use direct I/O, and you enable rbd writeback caching,
librbd will be able to merge many of the smaller requests and
you should see much better throughput.

Josh

> pool size 2:
>    write: io=32984MB, bw=562046KB/s, iops=137 , runt= 60094msec
> pool size 3:
>    write: io=29124MB, bw=496024KB/s, iops=121 , runt= 60124msec
>
> Even when i change the pool size to 3 i get with fio 520MB/s.
>
> Any ideas? Is this expected?
>
> Greets
> Stefan


