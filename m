From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor performance
Date: Sun, 04 Nov 2012 06:29:28 -0600
Message-ID: <50965FA8.7040501@inktank.com>
References: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34235 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab2KDM33 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 07:29:29 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6809661iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 04:29:29 -0800 (PST)
In-Reply-To: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksey Samarin <nrg3tik@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/04/2012 03:58 AM, Aleksey Samarin wrote:
> Hi all
>
> Im planning use ceph for cloud storage.
> My test setup is 2 servers connected via infiniband 40Gb, 6x2Tb disks per node.
> Centos 6.2
> Ceph 0.52 from http://ceph.com/rpms/el6/x86_64
> This is my config http://pastebin.com/Pzxafnsm

One thing that may be problematic is that I don't think centos 6.2 has a 
new enough version of glibc to support syncfs (Assuming it's even 
backported in their kernel).  You may want to try moving the mons off to 
another node, and reducing each node down to a single OSD/disk and test 
it out to see what happens.  Also, we are starting to ship some tools 
Sam wrote to test underlying filestore performance.  I think Gary has 
been working on getting some of those tools packaged up.

> journal on tmpfs
> well, im create bench pool and test it:
> ceph osd pool create bench
> rados -p bench bench 30 write
>
>   Total time run:         43.258228
>   Total writes made:      151
>   Write size:             4194304
>   Bandwidth (MB/sec):     13.963
>   Stddev Bandwidth:       26.307
>   Max bandwidth (MB/sec): 128
>   Min bandwidth (MB/sec): 0
>   Average Latency:        4.48605
>   Stddev Latency:         8.17709
>   Max latency:            29.7957
>   Min latency:            0.039435
>
> when i do rados -p bench bench 30 seq
>   Total time run:        20.626935
>   Total reads made:     275
>   Read size:            4194304
>   Bandwidth (MB/sec):    53.328
>   Average Latency:       1.19754
>   Max latency:           7.0215
>   Min latency:           0.011647
>
> I tested the single drive via dd if=/dev/zero of=/mnt/hdd2/testfile
> bs=1024k count=20000
> result:  158 MB/sec
>
> Anyone can tell me why such a weak performance? Maybe I missed something?
>
> All the best, Alex!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

