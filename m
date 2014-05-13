From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: crash in rbd_img_request_create
Date: Tue, 13 May 2014 23:39:11 +0200
Message-ID: <CABt9es8aiqOyozL9YnXtxCUVmx_DNhs+LEwQ8-ryC+-V4u85_A@mail.gmail.com>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>
	<536EEA5C.70503@ieee.org>
	<CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com>
	<53704F70.3090800@ieee.org>
	<CABt9es8snhMJ5jg9OkiYVmXU6iX9aj3jAG8_XL1Th_BmJpgonQ@mail.gmail.com>
	<537211AD.9070209@ieee.org>
	<CABt9es_dd3VjuBaHUkM9qRW6aJDujHE3yN1FvkojtXXXQhcsqQ@mail.gmail.com>
	<alpine.DEB.2.00.1405131357250.12608@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:59667 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbaEMVjM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 17:39:12 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so775580lan.9
        for <ceph-devel@vger.kernel.org>; Tue, 13 May 2014 14:39:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1405131357250.12608@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, Thorwald Lundqvist <thorwald@jumpstarter.io>

On Tue, May 13, 2014 at 10:58 PM, Sage Weil <sage@inktank.com> wrote:
>
> Note that there was a patch a week or so ago fixing a problem in RBD when
> running ZFS on top of RBD (IIRC it had to do with length 0 bios or
> something?).  Was this ZFS on RBD or ZFS underneat the ceph-osd daemons?
>

Sorry if I was unclear on this. ZFS was running underneath the
ceph-osds. Today we switched to ext4 instead.

More specifically we where interested in the compression features of
ZFS since people claim it can both increase throughput, lower latency
and lower disk usage with no significant drawbacks. This is because
LZO (and other algos of the same class, like google snappy)
immediately aborts if the data doesn't look trivially compressible
which make it comparable in speed to memcpy. It would be interesting
to look at experimentally supporting this in the osds themselves. It
could have theoretical huge benefits when storing disk images and
large binary files which tend to contain a lot of uninitialized
regions full of zeroes.

Let's take a super biased example, a really fresh mysql innodb
database with wordpress installed:

> $ent ibdata1
> Entropy = 0.950773 bits per byte.
> Optimum compression would reduce the size
> of this 18874368 byte file by 88 percent.
> Chi square distribution for 18874368 samples is 3847986113.90, and randomly
> would exceed this value 0.01 percent of the times.
> Arithmetic mean value of data bytes is 16.0581 (127.5 = random).
> Monte Carlo value for Pi is 3.832257589 (error 21.98 percent).
> Serial correlation coefficient is 0.972634 (totally uncorrelated = 0.0).
---------

As you can see, according to ent this reference innodb data file is
very compressable. Standard LZO on a tmpfs:

> $time lzop ibdata1
> 0.01user 0.00system 0:00.04elapsed 35%CPU (0avgtext+0avgdata 1160maxresident)k
> 0inputs+0outputs (0major+372minor)pagefaults 0swaps
> $ls -l
> 18874368 May 13 23:20 ibdata1
> 536126 May 13 23:20 ibdata1.lzo

The time to compress is even hard to measure for 19 MB of data because
it's so fast the signal disappears in the noise.

This reply got a bit long but I wanted to share some thoughts I had.

Thank you for your time,
Hannes
