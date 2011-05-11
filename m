From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: Kernel 2.6.38.6 page allocation failure (ixgbe)
Date: Wed, 11 May 2011 09:36:42 +0200
Message-ID: <BANLkTinjqK6pkjYig-NyWuJ2s2Tq3AHdnw@mail.gmail.com>
References: <BANLkTinr34qmAE8RWVY0Wq_XMfOc0jTUzg@mail.gmail.com>
	<BANLkTi=4DNyWaqqjK5sG5O9cNdfpuAqHWA@mail.gmail.com>
	<BANLkTi=jZ-GA30_54kay3ouoNJvkwbVQ4w@mail.gmail.com>
	<Pine.LNX.4.64.1105100900170.4299@cobra.newdream.net>
	<BANLkTi=kkFrvVms7a0vC-pRK96aPr-MDBQ@mail.gmail.com>
	<BANLkTi=x+BEeGtpBe2reG4erNxyeZweAQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59425 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab1EKRCA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 13:02:00 -0400
In-Reply-To: <BANLkTi=x+BEeGtpBe2reG4erNxyeZweAQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Sage,

after some digging we set
sysctl -w vm.min_free_kbytes=3D262144
default was around 16000

This solved our problem and rados bench survived a 5 minute torture
with no single failure:

min lat: 0.036177 max lat: 299.924 avg lat: 0.553904
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg l=
at
  300      40     61736     61696   822.498      1312   299.602  0.5539=
04
Total time run:        300.421378
Total writes made:     61736
Write size:            4194304
Bandwidth (MB/sec):    821.992

Average Latency:       0.621895
Max latency:           300.362
Min latency:           0.036177

Sorry for the noise, but i think you should mention this sysctl
modification in the ceph wiki (at least for 10GB/s deployments).

thanks

Stefan Majer


On Wed, May 11, 2011 at 8:58 AM, Stefan Majer <stefan.majer@gmail.com> =
wrote:
> Hi Sage,
>
> we were running rados bench like this:
> # rados -p data bench 60 write -t 128
> Maintaining 128 concurrent writes of 4194304 bytes for at least 60 se=
conds.
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0las=
t lat =A0 avg lat
> =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A01 =A0 =A0 128 =A0 =A0 =A0 296 =A0 =A0 =A0 168 =A0 671.847 =A0 =
=A0 =A0 672 =A00.051857 =A00.131839
> =A0 =A02 =A0 =A0 127 =A0 =A0 =A0 537 =A0 =A0 =A0 410 =A0 819.838 =A0 =
=A0 =A0 968 =A00.052679 =A00.115476
> =A0 =A03 =A0 =A0 128 =A0 =A0 =A0 772 =A0 =A0 =A0 644 =A0 858.516 =A0 =
=A0 =A0 936 =A00.043241 =A00.114372
> =A0 =A04 =A0 =A0 128 =A0 =A0 =A0 943 =A0 =A0 =A0 815 =A0 814.865 =A0 =
=A0 =A0 684 =A00.799326 =A00.121142
> =A0 =A05 =A0 =A0 128 =A0 =A0 =A01114 =A0 =A0 =A0 986 =A0 788.673 =A0 =
=A0 =A0 684 =A00.082748 =A0 0.13059
> =A0 =A06 =A0 =A0 128 =A0 =A0 =A01428 =A0 =A0 =A01300 =A0 866.526 =A0 =
=A0 =A01256 =A00.065376 =A00.119083
> =A0 =A07 =A0 =A0 127 =A0 =A0 =A01716 =A0 =A0 =A01589 =A0 907.859 =A0 =
=A0 =A01156 =A00.037958 =A0 0.11151
> =A0 =A08 =A0 =A0 127 =A0 =A0 =A01986 =A0 =A0 =A01859 =A0 =A0929.36 =A0=
 =A0 =A01080 =A00.063171 =A0 0.11077
> =A0 =A09 =A0 =A0 128 =A0 =A0 =A02130 =A0 =A0 =A02002 =A0 889.645 =A0 =
=A0 =A0 572 =A00.048705 =A00.109477
> =A0 10 =A0 =A0 127 =A0 =A0 =A02333 =A0 =A0 =A02206 =A0 882.269 =A0 =A0=
 =A0 816 =A00.062555 =A00.115842
> =A0 11 =A0 =A0 127 =A0 =A0 =A02466 =A0 =A0 =A02339 =A0 850.419 =A0 =A0=
 =A0 532 =A00.051618 =A00.117356
> =A0 12 =A0 =A0 128 =A0 =A0 =A02602 =A0 =A0 =A02474 =A0 824.545 =A0 =A0=
 =A0 540 =A0 0.06113 =A00.124453
> =A0 13 =A0 =A0 128 =A0 =A0 =A02807 =A0 =A0 =A02679 =A0 824.187 =A0 =A0=
 =A0 820 =A00.075126 =A00.125108
> =A0 14 =A0 =A0 127 =A0 =A0 =A02897 =A0 =A0 =A02770 =A0 791.312 =A0 =A0=
 =A0 364 =A00.077479 =A00.125009
> =A0 15 =A0 =A0 127 =A0 =A0 =A02955 =A0 =A0 =A02828 =A0 754.023 =A0 =A0=
 =A0 232 =A00.084222 =A00.123814
> =A0 16 =A0 =A0 127 =A0 =A0 =A02973 =A0 =A0 =A02846 =A0 711.393 =A0 =A0=
 =A0 =A072 =A00.078568 =A00.123562
> =A0 17 =A0 =A0 127 =A0 =A0 =A02975 =A0 =A0 =A02848 =A0 670.011 =A0 =A0=
 =A0 =A0 8 =A00.923208 =A00.124123
>
> as you can see, the transferrate drops suddenly down to 8 and even to=
 0.
>
> Memory consumption during this is low:
>
> top - 08:52:24 up 18:12, =A01 user, =A0load average: 0.64, 3.35, 4.17
> Tasks: 203 total, =A0 1 running, 202 sleeping, =A0 0 stopped, =A0 0 z=
ombie
> Cpu(s): =A00.0%us, =A00.3%sy, =A00.0%ni, 99.7%id, =A00.0%wa, =A00.0%h=
i, =A00.0%si, =A00.0%st
> Mem: =A024731008k total, 24550172k used, =A0 180836k free, =A0 =A0791=
36k buffers
> Swap: =A0 =A0 =A0 =A00k total, =A0 =A0 =A0 =A00k used, =A0 =A0 =A0 =A0=
0k free, 22574812k cached
>
> =A0PID USER =A0 =A0 =A0PR =A0NI =A0VIRT =A0RES =A0SHR S %CPU %MEM =A0=
 =A0TIME+ =A0COMMAND
> 22203 root =A0 =A0 =A020 =A0 0 =A0581m 284m 2232 S =A00.0 =A01.2 =A0 =
0:44.34 cosd
> 21922 root =A0 =A0 =A020 =A0 0 =A0577m 281m 2148 S =A00.0 =A01.2 =A0 =
0:39.91 cosd
> 22788 root =A0 =A0 =A020 =A0 0 =A0576m 213m 2084 S =A00.0 =A00.9 =A0 =
0:44.10 cosd
> 22476 root =A0 =A0 =A020 =A0 0 =A0509m 204m 2156 S =A00.0 =A00.8 =A0 =
0:33.92 cosd
>
> And after we hit this, ceph -w still reports clean state, all cosd ar=
e
> still running.
>
> We have no clue :-(
>
> Greetings
> Stefan Majer
>
>
> On Tue, May 10, 2011 at 6:06 PM, Stefan Majer <stefan.majer@gmail.com=
> wrote:
>> Hi Sage,
>>
>>
>> On Tue, May 10, 2011 at 6:02 PM, Sage Weil <sage@newdream.net> wrote=
:
>>> Hi Stefan,
>>>
>>> On Tue, 10 May 2011, Stefan Majer wrote:
>>>> Hi,
>>>>
>>>> On Tue, May 10, 2011 at 4:20 PM, Yehuda Sadeh Weinraub
>>>> <yehudasa@gmail.com> wrote:
>>>> > On Tue, May 10, 2011 at 7:04 AM, Stefan Majer <stefan.majer@gmai=
l.com> wrote:
>>>> >> Hi,
>>>> >>
>>>> >> im running 4 nodes with ceph on top of btrfs with a dualport In=
tel
>>>> >> X520 10Gb Ethernet Card with the latest 3.3.9 ixgbe driver.
>>>> >> during benchmarks i get the following stack.
>>>> >> I can easily reproduce this by simply running rados bench from =
a fast
>>>> >> machine using this 4 nodes as ceph cluster.
>>>> >> We saw this with stock ixgbe driver from 2.6.38.6 and with the =
latest
>>>> >> 3.3.9 ixgbe.
>>>> >> This kernel is tainted because we use fusion-io iodrives as jou=
rnal
>>>> >> devices for btrfs.
>>>> >>
>>>> >> Any hints to nail this down are welcome.
>>>> >>
>>>> >> Greetings Stefan Majer
>>>> >>
>>>> >> May 10 15:26:40 os02 kernel: [ 3652.485219] cosd: page allocati=
on
>>>> >> failure. order:2, mode:0x4020
>>>> >
>>>> > It looks like the machine running the cosd is crashing, is that =
the case?
>>>>
>>>> No the machine is still running. Even the cosd is still there.
>>>
>>> How much memory is (was?) cosd using? =A0Is it possible for you to =
watch RSS
>>> under load when the errors trigger?
>>
>> I will look on this tomorrow
>> just for the record:
>> each machine has 24GB of RAM and 4 cosd with 1 btrfs formated disks
>> each, which is a raid5 over 3 2TB spindles.
>>
>> The rados bench reaches a constant rate of about 1000Mb/sec !
>>
>> Greetings
>>
>> Stefan
>>> The osd throttles incoming client bandwidth, but it doesn't throttl=
e
>>> inter-osd traffic yet because it's not obvious how to avoid deadloc=
k.
>>> It's possible that one node is getting significantly behind the
>>> others on the replicated writes and that is blowing up its memory
>>> footprint. =A0There are a few ways we can address that, but I'd lik=
e to make
>>> sure we understand the problem first.
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>>
>>>> > Are you running both ceph kernel module on the same machine by a=
ny
>>>> > chance? If not, it can be some other fs bug (e.g., the underlyin=
g
>>>> > btrfs). Also, the stack here is quite deep, there's a chance for=
 a
>>>> > stack overflow.
>>>>
>>>> There is only the cosd running on these machines. We have 3 sepera=
te
>>>> mons and clients which uses qemu-rbd.
>>>>
>>>>
>>>> > Thanks,
>>>> > Yehuda
>>>> >
>>>>
>>>>
>>>> Greetings
>>>> --
>>>> Stefan Majer
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>>
>>>
>>
>>
>>
>> --
>> Stefan Majer
>>
>
>
>
> --
> Stefan Majer
>



--=20
Stefan Majer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
