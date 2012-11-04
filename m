From: Gregory Farnum <greg@inktank.com>
Subject: Re: poor performance
Date: Sun, 4 Nov 2012 12:00:16 +0100
Message-ID: <CAPYLRzipAsNdEO6BKrSofPjmWp9F0dL_iH18VaC054TeA=9EBg@mail.gmail.com>
References: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57828 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab2KDLAR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 06:00:17 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6773544iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 03:00:16 -0800 (PST)
In-Reply-To: <CAFjNkqRPC7MDm86LBYCD+reXePNjWzZBPz7yPn9pv553TYHPjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksey Samarin <nrg3tik@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Ryan <mike.ryan@inktank.com>

On Sun, Nov 4, 2012 at 10:58 AM, Aleksey Samarin <nrg3tik@gmail.com> wrote:
> Hi all
>
> Im planning use ceph for cloud storage.
> My test setup is 2 servers connected via infiniband 40Gb, 6x2Tb disks per node.
> Centos 6.2
> Ceph 0.52 from http://ceph.com/rpms/el6/x86_64
> This is my config http://pastebin.com/Pzxafnsm
> journal on tmpfs
> well, im create bench pool and test it:
> ceph osd pool create bench
> rados -p bench bench 30 write
>
>  Total time run:         43.258228
>  Total writes made:      151
>  Write size:             4194304
>  Bandwidth (MB/sec):     13.963
>  Stddev Bandwidth:       26.307
>  Max bandwidth (MB/sec): 128
>  Min bandwidth (MB/sec): 0
>  Average Latency:        4.48605
>  Stddev Latency:         8.17709
>  Max latency:            29.7957
>  Min latency:            0.039435
>
> when i do rados -p bench bench 30 seq
>  Total time run:        20.626935
>  Total reads made:     275
>  Read size:            4194304
>  Bandwidth (MB/sec):    53.328
>  Average Latency:       1.19754
>  Max latency:           7.0215
>  Min latency:           0.011647
>
> I tested the single drive via dd if=/dev/zero of=/mnt/hdd2/testfile
> bs=1024k count=20000
> result:  158 MB/sec
>
> Anyone can tell me why such a weak performance? Maybe I missed something?

Can you run "ceph tell osd \* bench" and report the results? (It'll go
to the "central log" which you can keep an eye on if you run "ceph -w"
in another terminal.)
I think you also didn't create your bench pool correctly; it probably
only has 8 PGs which is not going to perform very well with your disk
count. Try "ceph pool create bench2 120" and run the benchmark against
that pool. The extra number at the end tells it to create 120
placement groups.
-Greg
