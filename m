From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Mon, 29 Nov 2010 19:18:26 -0800
Message-ID: <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
References: <1291001135.1872.106.camel@cephhost>
	<AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	<1291085741.1809.25.camel@cephhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35381 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab0K3DS2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Nov 2010 22:18:28 -0500
Received: by ewy5 with SMTP id 5so2484768ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Nov 2010 19:18:27 -0800 (PST)
In-Reply-To: <1291085741.1809.25.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>

On Mon, Nov 29, 2010 at 6:55 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
>> Could you run "ceph osd tell * bench", then run "ceph -w", and repor=
t
>> the results? (That'll just run local benchmarking on the OSD to repo=
rt
>> the approximate write speed it's capable of.)
>
> I run six times for the command: "$ sudo ceph osd tell 0/1 bench "
> use "$ sudo ceph -w" to get the following results:
>
> osd0 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 12.906598 s=
ec
> at 49775 KB/sec
> osd1 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 21.023294 s=
ec
> at 49384 KB/sec
> osd0 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 12.834682 s=
ec
> at 51535 KB/sec
> osd1 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 20.792697 s=
ec
> at 37547 KB/sec
> osd0 =A0: [INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.05841=
2 sec
> at 77191 KB/sec
> osd1 =A0: [INF] bench: wrote 1024 MB in blocks of 4096 KB in 21.11361=
2 sec
> at 47369 KB/sec
Okay, those are a bit slow but reasonable. Based on these I'd expect
you to generally manage about 40-50MB/s (since everything is
replicated; in a 2-disk configuration it'll just be the speed of your
slowest disk), assuming a properly configured system.

>> You can also run "rados -p data bench 60 write", and then "rados -p
>> data bench 0 seq" to get a simpler (better understood) performance
>> test.
>
> I run twice for the command: "rados -p data bench 60 write" ,
> Get the results:
> $ sudo rados -p data bench 60 write
> ..........................
> ..........................
>
> Total time run: =A0 =A0 =A0 =A076.182225
> Total writes made: =A0 =A0 121
> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
> Bandwidth (MB/sec): =A0 =A06.219
>
> Average Latency: =A0 =A0 =A0 13.3068
> Max latency: =A0 =A0 =A0 =A0 =A0 23.9986
> Min latency: =A0 =A0 =A0 =A0 =A0 7.01847
WOAH. That's a lot of latency. Rather more than I'd expect to get just
from seek times in a non-journaled environment. What's the round-trip
time to ping the OSDs from your client? Are your disks okay?

> but run =A0"$ sudo rados -p data bench 0 seq"
> fail to get the results, Maybe it's a bug,ceph version 0.23.
Oh right, sorry. We put in a quick fix to make the write benchmark
scale across multiple client writers and forgot to adjust the read
benchmark. *oops*
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
