From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Re: Ceph Performance puzzle.
Date: Fri, 8 May 2015 11:13:04 -0700
Message-ID: <CAKKTCLUuOWOzz0hNxc0jsL2kawNNTvHUN+epO3sa3oE+87NL8A@mail.gmail.com>
References: <CAKKTCLV2deJU-s=GubM9xcNNd8bfLZ0OE1xEZD5s4E0dyci4Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34921 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbbEHSNZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 14:13:25 -0400
Received: by obcus9 with SMTP id us9so31657204obc.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2015 11:13:25 -0700 (PDT)
In-Reply-To: <CAKKTCLV2deJU-s=GubM9xcNNd8bfLZ0OE1xEZD5s4E0dyci4Zg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>, zhiqiang.wang@intel.com

Little more data..
First I am trying to eliminate network/filesystem/disk issues on why I
am seeing performance drop going from 16k to 32k object size.
Everything is pointing me to CEPH.

1. FIlesystem Test.

I am using EXT4 as my base FS for CEPH, just to eliminate the FS
issue, I wrote a small program
which creates files(OSYNC) of varying sizes totaling to to .5 GB on
each filesystem. Though XFS is better than
EXT4 I did not see any of the FS performance going down as the
filesize increased.

16 threads
fSize:8192 FS:XFS  totalsize:512 MB sec:294 Throughput:1 MB/sec
Latency/f:4483 us
fSize:8192 FS:EXT4 totalsize:512 MB sec:398 Throughput:1 MB/sec
Latency/f:6079 us

fSize:16384 FS:XFS  totalsize:512 MB sec:159 Throughput:3 MB/sec
Latency/f:4859 us
fSize:16384 FS:EXT4 totalsize:512 MB sec:178 Throughput:2 MB/sec
Latency/f:5452 us

fSize:32768 FS:XFS  totalsize:512 MB sec:97  Throughput:5 MB/sec
Latency/f:5897 us
fSize:32768 FS:EXT4 totalsize:512 MB sec:101 Throughput:5 MB/sec Latency:6142 us

fSize:65536 FS:XFS  totalsize:512 MB sec:65 Throughput:7 MB/sec
Latency/f:7941 us
fSize:65536 FS:EXT4 totalsize:512 MB sec:71 Throughput:7 MB/sec
Latency/f:8681 us

fSize:131072 FS:XFS  totalsize:512 MB sec:47 Throughput:10 MB/sec
Latency/f:11427 us
fSize:131072 FS:EXT4 totalsize:512 MB sec:52 Throughput:9 MB/sec
Latency/f:12664 us

2. Ntwork Test

vjujjuri@wsl6:~$ iperf -c wsl2 -P 16
[SUM]  0.0-10.1 sec  1.11 GBytes   945 Mbits/sec

vjujjuri@wsl6:~$ iperf -c wsl3 -P 16
[SUM]  0.0-10.1 sec  1.11 GBytes   946 Mbits/sec
vjujjuri@wsl6:~$ iperf -c wsl4 -P 16
[SUM]  0.0-10.1 sec  1.11 GBytes   944 Mbits/sec

So netowrk is consistent for 1Gb NIC.

3.
As I mentioned above, OSD bench gave consistent results. i.e as the
object size increases I am getting better throughput.

4.
I tried rados bench with 1 thread. , which also saw increase in
bandwidth with object size.
1 Thread
8k   Bandwidth (MB/sec):     1.651  Average Latency:        0.00467157
16k  Bandwidth (MB/sec):     3.241  Average Latency:        0.00481853
64k  Bandwidth (MB/sec):     9.878  Average Latency:        0.00632447


5. I tried with 10 threads, which is flat. At least no degradation.
10 Thread
16k Bandwidth (MB/sec):     32.826    Average Latency:        0.00380627
64k Bandwidth (MB/sec):     32.981    Average Latency:        0.0151577

6. But, at 16 threads I see 16k peaks and falls drastically after
that. and the puzzle continues...

SIze     BandWidth   Latency
1M         39.916          0.400774
512k      32.797            0.243906
64k        28.98             0.03449
32k        41.56             0.0120
16k         47.545           0.005
8k           17.078          0.0072

Thanks,
JV


On Thu, May 7, 2015 at 11:38 AM, Venkateswara Rao Jujjuri
<jujjuri@gmail.com> wrote:
> Hope someone sheds light. Not able to reason out what I am seeing.
> OSD bench shows that bandwidth is increasing with BlockSize.
> While librados bench shows bandwidth is falling after 16k.
> I have 3 SSD  OSDs in SSD pool.
>
> vjujjuri@wsl6:~$ iperf -csl2 -P 16
>  [SUM]  0.0-10.1 sec  1.11 GBytes   945 Mbits/sec
>
> vjujjuri@wsl13:/media/data$ ceph --version
> ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
>
>
> vjujjuri@wsl13:/media/data$ ceph tell osd.0 bench 10485760 8192
> {
>     "bytes_written": 10485760,
>     "blocksize": 8192,
>     "bytes_per_sec": 47176008.000000
> }
>
> vjujjuri@wsl13:/media/data$ ceph tell osd.0 bench 10485760 16384
> {
>     "bytes_written": 10485760,
>     "blocksize": 16384,
>     "bytes_per_sec": 109491958.000000
> }
>
> vjujjuri@wsl13:/media/data$ ceph tell osd.0 bench 10485760 32768
> {
>     "bytes_written": 10485760,
>     "blocksize": 32768,
>     "bytes_per_sec": 242963276.000000
> }
>
> Where as the bench:
> vjujjuri@wsl13:/media/data$ rados bench -p sfdc_ssd -b 8192 10 write
> --no-cleanup
> Bandwidth (MB/sec):     25.878
>
> vjujjuri@wsl13:/media/data$ rados bench -p sfdc_ssd -b 16384 10 write
> --no-cleanup
> Bandwidth (MB/sec):     48.425
>
> vjujjuri@wsl13:/media/data$ rados bench -p sfdc_ssd -b 32768 10 write
> --no-cleanup
> Bandwidth (MB/sec):     35.750
>
> Thanks in advance
>
>
> --
> Jvrao
> ---
> First they ignore you, then they laugh at you, then they fight you,
> then you win. - Mahatma Gandhi



-- 
Jvrao
---
First they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
