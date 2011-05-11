From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: Kernel 2.6.38.6 page allocation failure (ixgbe)
Date: Wed, 11 May 2011 08:58:53 +0200
Message-ID: <BANLkTi=x+BEeGtpBe2reG4erNxyeZweAQA@mail.gmail.com>
References: <BANLkTinr34qmAE8RWVY0Wq_XMfOc0jTUzg@mail.gmail.com>
	<BANLkTi=4DNyWaqqjK5sG5O9cNdfpuAqHWA@mail.gmail.com>
	<BANLkTi=jZ-GA30_54kay3ouoNJvkwbVQ4w@mail.gmail.com>
	<Pine.LNX.4.64.1105100900170.4299@cobra.newdream.net>
	<BANLkTi=kkFrvVms7a0vC-pRK96aPr-MDBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58536 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1EKPmo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 11:42:44 -0400
In-Reply-To: <BANLkTi=kkFrvVms7a0vC-pRK96aPr-MDBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Sage,

we were running rados bench like this:
# rados -p data bench 60 write -t 128
Maintaining 128 concurrent writes of 4194304 bytes for at least 60 seco=
nds.
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg l=
at
    0       0         0         0         0         0         -        =
 0
    1     128       296       168   671.847       672  0.051857  0.1318=
39
    2     127       537       410   819.838       968  0.052679  0.1154=
76
    3     128       772       644   858.516       936  0.043241  0.1143=
72
    4     128       943       815   814.865       684  0.799326  0.1211=
42
    5     128      1114       986   788.673       684  0.082748   0.130=
59
    6     128      1428      1300   866.526      1256  0.065376  0.1190=
83
    7     127      1716      1589   907.859      1156  0.037958   0.111=
51
    8     127      1986      1859    929.36      1080  0.063171   0.110=
77
    9     128      2130      2002   889.645       572  0.048705  0.1094=
77
   10     127      2333      2206   882.269       816  0.062555  0.1158=
42
   11     127      2466      2339   850.419       532  0.051618  0.1173=
56
   12     128      2602      2474   824.545       540   0.06113  0.1244=
53
   13     128      2807      2679   824.187       820  0.075126  0.1251=
08
   14     127      2897      2770   791.312       364  0.077479  0.1250=
09
   15     127      2955      2828   754.023       232  0.084222  0.1238=
14
   16     127      2973      2846   711.393        72  0.078568  0.1235=
62
   17     127      2975      2848   670.011         8  0.923208  0.1241=
23

as you can see, the transferrate drops suddenly down to 8 and even to 0=
=2E

Memory consumption during this is low:

top - 08:52:24 up 18:12,  1 user,  load average: 0.64, 3.35, 4.17
Tasks: 203 total,   1 running, 202 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.3%sy,  0.0%ni, 99.7%id,  0.0%wa,  0.0%hi,  0.0%si, =
 0.0%st
Mem:  24731008k total, 24550172k used,   180836k free,    79136k buffer=
s
Swap:        0k total,        0k used,        0k free, 22574812k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
22203 root      20   0  581m 284m 2232 S  0.0  1.2   0:44.34 cosd
21922 root      20   0  577m 281m 2148 S  0.0  1.2   0:39.91 cosd
22788 root      20   0  576m 213m 2084 S  0.0  0.9   0:44.10 cosd
22476 root      20   0  509m 204m 2156 S  0.0  0.8   0:33.92 cosd

And after we hit this, ceph -w still reports clean state, all cosd are
still running.

We have no clue :-(

Greetings
Stefan Majer


On Tue, May 10, 2011 at 6:06 PM, Stefan Majer <stefan.majer@gmail.com> =
wrote:
> Hi Sage,
>
>
> On Tue, May 10, 2011 at 6:02 PM, Sage Weil <sage@newdream.net> wrote:
>> Hi Stefan,
>>
>> On Tue, 10 May 2011, Stefan Majer wrote:
>>> Hi,
>>>
>>> On Tue, May 10, 2011 at 4:20 PM, Yehuda Sadeh Weinraub
>>> <yehudasa@gmail.com> wrote:
>>> > On Tue, May 10, 2011 at 7:04 AM, Stefan Majer <stefan.majer@gmail=
=2Ecom> wrote:
>>> >> Hi,
>>> >>
>>> >> im running 4 nodes with ceph on top of btrfs with a dualport Int=
el
>>> >> X520 10Gb Ethernet Card with the latest 3.3.9 ixgbe driver.
>>> >> during benchmarks i get the following stack.
>>> >> I can easily reproduce this by simply running rados bench from a=
 fast
>>> >> machine using this 4 nodes as ceph cluster.
>>> >> We saw this with stock ixgbe driver from 2.6.38.6 and with the l=
atest
>>> >> 3.3.9 ixgbe.
>>> >> This kernel is tainted because we use fusion-io iodrives as jour=
nal
>>> >> devices for btrfs.
>>> >>
>>> >> Any hints to nail this down are welcome.
>>> >>
>>> >> Greetings Stefan Majer
>>> >>
>>> >> May 10 15:26:40 os02 kernel: [ 3652.485219] cosd: page allocatio=
n
>>> >> failure. order:2, mode:0x4020
>>> >
>>> > It looks like the machine running the cosd is crashing, is that t=
he case?
>>>
>>> No the machine is still running. Even the cosd is still there.
>>
>> How much memory is (was?) cosd using? =A0Is it possible for you to w=
atch RSS
>> under load when the errors trigger?
>
> I will look on this tomorrow
> just for the record:
> each machine has 24GB of RAM and 4 cosd with 1 btrfs formated disks
> each, which is a raid5 over 3 2TB spindles.
>
> The rados bench reaches a constant rate of about 1000Mb/sec !
>
> Greetings
>
> Stefan
>> The osd throttles incoming client bandwidth, but it doesn't throttle
>> inter-osd traffic yet because it's not obvious how to avoid deadlock=
=2E
>> It's possible that one node is getting significantly behind the
>> others on the replicated writes and that is blowing up its memory
>> footprint. =A0There are a few ways we can address that, but I'd like=
 to make
>> sure we understand the problem first.
>>
>> Thanks!
>> sage
>>
>>
>>
>>> > Are you running both ceph kernel module on the same machine by an=
y
>>> > chance? If not, it can be some other fs bug (e.g., the underlying
>>> > btrfs). Also, the stack here is quite deep, there's a chance for =
a
>>> > stack overflow.
>>>
>>> There is only the cosd running on these machines. We have 3 seperat=
e
>>> mons and clients which uses qemu-rbd.
>>>
>>>
>>> > Thanks,
>>> > Yehuda
>>> >
>>>
>>>
>>> Greetings
>>> --
>>> Stefan Majer
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>>
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
