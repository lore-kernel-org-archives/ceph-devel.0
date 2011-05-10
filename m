From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: Kernel 2.6.38.6 page allocation failure (ixgbe)
Date: Tue, 10 May 2011 18:06:15 +0200
Message-ID: <BANLkTi=kkFrvVms7a0vC-pRK96aPr-MDBQ@mail.gmail.com>
References: <BANLkTinr34qmAE8RWVY0Wq_XMfOc0jTUzg@mail.gmail.com>
	<BANLkTi=4DNyWaqqjK5sG5O9cNdfpuAqHWA@mail.gmail.com>
	<BANLkTi=jZ-GA30_54kay3ouoNJvkwbVQ4w@mail.gmail.com>
	<Pine.LNX.4.64.1105100900170.4299@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64767 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457Ab1EJQGR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 12:06:17 -0400
In-Reply-To: <Pine.LNX.4.64.1105100900170.4299@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Sage,


On Tue, May 10, 2011 at 6:02 PM, Sage Weil <sage@newdream.net> wrote:
> Hi Stefan,
>
> On Tue, 10 May 2011, Stefan Majer wrote:
>> Hi,
>>
>> On Tue, May 10, 2011 at 4:20 PM, Yehuda Sadeh Weinraub
>> <yehudasa@gmail.com> wrote:
>> > On Tue, May 10, 2011 at 7:04 AM, Stefan Majer <stefan.majer@gmail.=
com> wrote:
>> >> Hi,
>> >>
>> >> im running 4 nodes with ceph on top of btrfs with a dualport Inte=
l
>> >> X520 10Gb Ethernet Card with the latest 3.3.9 ixgbe driver.
>> >> during benchmarks i get the following stack.
>> >> I can easily reproduce this by simply running rados bench from a =
fast
>> >> machine using this 4 nodes as ceph cluster.
>> >> We saw this with stock ixgbe driver from 2.6.38.6 and with the la=
test
>> >> 3.3.9 ixgbe.
>> >> This kernel is tainted because we use fusion-io iodrives as journ=
al
>> >> devices for btrfs.
>> >>
>> >> Any hints to nail this down are welcome.
>> >>
>> >> Greetings Stefan Majer
>> >>
>> >> May 10 15:26:40 os02 kernel: [ 3652.485219] cosd: page allocation
>> >> failure. order:2, mode:0x4020
>> >
>> > It looks like the machine running the cosd is crashing, is that th=
e case?
>>
>> No the machine is still running. Even the cosd is still there.
>
> How much memory is (was?) cosd using? =A0Is it possible for you to wa=
tch RSS
> under load when the errors trigger?

I will look on this tomorrow
just for the record:
each machine has 24GB of RAM and 4 cosd with 1 btrfs formated disks
each, which is a raid5 over 3 2TB spindles.

The rados bench reaches a constant rate of about 1000Mb/sec !

Greetings

Stefan
> The osd throttles incoming client bandwidth, but it doesn't throttle
> inter-osd traffic yet because it's not obvious how to avoid deadlock.
> It's possible that one node is getting significantly behind the
> others on the replicated writes and that is blowing up its memory
> footprint. =A0There are a few ways we can address that, but I'd like =
to make
> sure we understand the problem first.
>
> Thanks!
> sage
>
>
>
>> > Are you running both ceph kernel module on the same machine by any
>> > chance? If not, it can be some other fs bug (e.g., the underlying
>> > btrfs). Also, the stack here is quite deep, there's a chance for a
>> > stack overflow.
>>
>> There is only the cosd running on these machines. We have 3 seperate
>> mons and clients which uses qemu-rbd.
>>
>>
>> > Thanks,
>> > Yehuda
>> >
>>
>>
>> Greetings
>> --
>> Stefan Majer
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>



--=20
Stefan Majer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
