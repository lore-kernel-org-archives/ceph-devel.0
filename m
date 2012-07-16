From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Poor read performance in KVM
Date: Sun, 15 Jul 2012 23:16:44 -0700
Message-ID: <5003B1CC.4060909@inktank.com>
References: <5002C215.108@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60338 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2GPGQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 02:16:46 -0400
Received: by yenl2 with SMTP id l2so4681945yen.19
        for <ceph-devel@vger.kernel.org>; Sun, 15 Jul 2012 23:16:45 -0700 (PDT)
In-Reply-To: <5002C215.108@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On 07/15/2012 06:13 AM, Vladimir Bashkirtsev wrote:
> Hello,
>
> Lately I was trying to get KVM to perform well on RBD. But it still
> appears elusive.
>
> [root@alpha etc]# rados -p rbd bench 120 seq -t 8
>
> Total time run:        16.873277
> Total reads made:     302
> Read size:            4194304
> Bandwidth (MB/sec):    71.592
>
> Average Latency:       0.437984
> Max latency:           3.26817
> Min latency:           0.015786
>
> Fairly good performance. But when I run in KVM:
>
> [root@mail ~]# hdparm -tT /dev/vda
>
> /dev/vda:
>   Timing cached reads:   8808 MB in  2.00 seconds = 4411.49 MB/sec

This is just the guest page cache - it's reading the first two
megabytes of the device repeatedly.

>   Timing buffered disk reads:  10 MB in  6.21 seconds =   1.61 MB/sec

This is a sequential read, so readahead in the guest should help here.

> Not even close to what rados bench show! I even seen 900KB/sec
> performance. Such slow read performance of course affecting guests.
>
> Any ideas where to start to look for performance boost?

Do you have rbd caching enabled? It would also be interesting to see
how the guest reads are translating to rados reads. hdparm is doing
2MiB sequential reads of the block device. If you add
admin_socket=/var/run/ceph/kvm.asok to the rbd device on the qemu
command line) you can see number of requests, latency, and
request size info while the guest is running via:

ceph --admin-daemon /var/run/ceph/kvm.asok perf dump

Josh
