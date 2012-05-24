From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Thu, 24 May 2012 09:57:26 -0500
Message-ID: <4FBE4C56.4070704@inktank.com>
References: <4FBE415E.8030702@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63666 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab2EXO52 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 10:57:28 -0400
Received: by obbtb18 with SMTP id tb18so12624729obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 07:57:28 -0700 (PDT)
In-Reply-To: <4FBE415E.8030702@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

Were these both tested on fresh filesystems?  If you still have any 
3.0.30 available, could you try a couple of longer running tests (say 5 
minutes) and see how they compare?

Thanks,
Mark

On 05/24/2012 09:10 AM, Stefan Priebe - Profihost AG wrote:
> Hi list,
>
> today while testing btrfs i discovered a very poor osd performance using
> kernel 3.4.
>
> Underlying FS is XFS but it is the same with btrfs.
>
> 3.0.30:
> ~# rados -p data bench 10 write -t 16
> Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>      0       0         0         0         0         0         -         0
>      1      16        41        25   99.9767       100  0.586984  0.447293
>      2      16        71        55   109.979       120  0.934388  0.488375
>      3      16        99        83   110.647       112   1.15982  0.503111
>      4      16       130       114   113.981       124   1.05952  0.516925
>      5      16       159       143   114.382       116  0.149313  0.510734
>      6      16       188       172   114.649       116  0.287166   0.52203
>      7      16       215       199   113.697       108  0.151784  0.531461
>      8      16       242       226   112.984       108  0.623478  0.539896
>      9      16       265       249   110.651        92   0.50354  0.538504
>     10      16       296       280   111.984       124  0.155048  0.542846
> Total time run:        10.776153
> Total writes made:     297
> Write size:            4194304
> Bandwidth (MB/sec):    110.243
>
> Average Latency:       0.577534
> Max latency:           1.85499
> Min latency:           0.091473
>
>
> 3.4:
> ~# rados -p data bench 10 write -t 16
> Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>      0       0         0         0         0         0         -         0
>      1      16        40        24   95.9794        96  0.393196  0.455936
>      2      16        68        52   103.983       112  0.835652  0.517297
>      3      16        85        69   91.9849        68   1.00535  0.493058
>      4      16        96        80   79.9869        44  0.096564  0.577948
>      5      16       103        87   69.5879        28  0.092722  0.589147
>      6      16       117       101   67.3216        56  0.222175  0.675334
>      7      16       130       114   65.1321        52   0.15677  0.623806
>      8      16       144       128   63.9896        56  0.089157   0.56746
>      9      16       144       128   56.8794         0         -   0.56746
>     10      16       144       128   51.1912         0         -   0.56746
>     11      16       144       128   46.5373         0         -   0.56746
>     12      16       144       128   42.6591         0         -   0.56746
>     13      16       144       128   39.3776         0         -   0.56746
>     14      16       144       128   36.5649         0         -   0.56746
>     15      16       144       128   34.1272         0         -   0.56746
>     16      16       145       129   32.2443       0.5   11.3422  0.650985
> Total time run:        16.193871
> Total writes made:     145
> Write size:            4194304
> Bandwidth (MB/sec):    35.816
>
> Average Latency:       1.78467
> Max latency:           14.4744
> Min latency:           0.088753
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

