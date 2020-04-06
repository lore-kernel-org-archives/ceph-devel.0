From: Jeff Layton <jlayton@kernel.org>
Subject: Re: 5.4.20 - high load - lots of incoming data - small data read.
Date: Mon, 06 Apr 2020 07:45:12 -0400
Message-ID: <db72c749125519b9c042c9664918eacbe8744985.camel@kernel.org>
References: <CAED-sidS3jt5f0nTvLp6_xL+sgk0FFJGaX-X7cCDav-8nwj4TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbgDFLpO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:45:14 -0400
In-Reply-To: <CAED-sidS3jt5f0nTvLp6_xL+sgk0FFJGaX-X7cCDav-8nwj4TA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesper Krogh <jesper.krogh@gmail.com>, ceph-devel@vger.kernel.org

On Mon, 2020-04-06 at 10:04 +0200, Jesper Krogh wrote:
> This is a CephFS client - its only purpose is to run the "filedaemon" of bacula
> and transport data to the tape-library from CephFS - below 2 threads is
> essentially doing something equivalent to
> 
> find /cephfs/ -type f | xargs cat | nc server
> 
> 2 threads only, load exploding and the "net read vs net write" has
> more than 100x difference.
> 

Makes sense. You're basically just reading in all of the data on this
cephfs, so the receive is going to be much larger than the send.

> Can anyone explain this as "normal" behaviour?
> Server is a  VM with 16 "vCPU" and 16GB memory running libvirt/qemu
> 
> jk@wombat:~$ w
>  07:50:33 up 11:25,  1 user,  load average: 206.43, 76.23, 50.58
> USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
> jk       pts/0    10.194.133.42    06:54    0.00s  0.05s  0.00s w
> jk@wombat:~$ dstat -ar
> --total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system-- --io/total-
> usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw | read  writ
>   0   0  98   1   0|  14k   34k|   0     0 |   3B   27B| 481   294 |0.55  0.73
>   1   1   0  98   0|   0     0 |  60M  220k|   0     0 |6402  6182 |   0     0
>   0   1   0  98   0|   0     0 |  69M  255k|   0     0 |7305  4339 |   0     0
>   1   2   0  98   0|   0     0 |  76M  282k|   0     0 |7914  4886 |   0     0
>   1   1   0  99   0|   0     0 |  70M  260k|   0     0 |7293  4444 |   0     0
>   1   1   0  98   0|   0     0 |  80M  278k|   0     0 |8018  4931 |   0     0
>   0   1   0  98   0|   0     0 |  60M  221k|   0     0 |6435  5951 |   0     0
>   0   1   0  99   0|   0     0 |  59M  211k|   0     0 |6163  3584 |   0     0
>   0   1   0  98   0|   0     0 |  64M  323k|   0     0 |6653  3881 |   0     0
>   1   0   0  99   0|   0     0 |  61M  243k|   0     0 |6822  4401 |   0     0
>   0   1   0  99   0|   0     0 |  55M  205k|   0     0 |5975  3518 |   0     0
>   1   1   0  98   0|   0     0 |  68M  242k|   0     0 |7094  6544 |   0     0
>   0   1   0  99   0|   0     0 |  58M  230k|   0     0 |6639  4178 |   0     0
>   1   2   0  98   0|   0     0 |  61M  243k|   0     0 |7117  4477 |   0     0
>   0   1   0  99   0|   0     0 |  61M  228k|   0     0 |6500  4078 |   0     0
>   0   1   0  99   0|   0     0 |  65M  234k|   0     0 |6595  3914 |   0     0
>   0   1   0  98   0|   0     0 |  64M  219k|   0     0 |6507  5755 |   0     0
>   1   1   0  99   0|   0     0 |  64M  233k|   0     0 |6869  4153 |   0     0
>   1   2   0  98   0|   0     0 |  63M  232k|   0     0 |6632  3907 |
> 0     0 ^C

Load average is high, but it looks like it's all just waiting on I/O. 

> jk@wombat:~$ w
>  07:50:56 up 11:25,  1 user,  load average: 221.35, 88.07, 55.02
> USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
> jk       pts/0    10.194.133.42    06:54    0.00s  0.05s  0.00s w
> jk@wombat:~$
> 
-- 
Jeff Layton <jlayton@kernel.org>
