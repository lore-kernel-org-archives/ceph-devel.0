From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Kernel 2.6.38.6 page allocation failure (ixgbe)
Date: Tue, 10 May 2011 07:26:13 -0700
Message-ID: <BANLkTimjVsfWg1Anz44ek-Stsgvu=1f36A@mail.gmail.com>
References: <BANLkTinr34qmAE8RWVY0Wq_XMfOc0jTUzg@mail.gmail.com>
	<BANLkTi=4DNyWaqqjK5sG5O9cNdfpuAqHWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=4DNyWaqqjK5sG5O9cNdfpuAqHWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Majer <stefan.majer@gmail.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, May 10, 2011 at 7:20 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Tue, May 10, 2011 at 7:04 AM, Stefan Majer <stefan.majer@gmail.com> wrote:
>> Hi,
>>
>> im running 4 nodes with ceph on top of btrfs with a dualport Intel
>> X520 10Gb Ethernet Card with the latest 3.3.9 ixgbe driver.
>> during benchmarks i get the following stack.
>> I can easily reproduce this by simply running rados bench from a fast
>> machine using this 4 nodes as ceph cluster.
>> We saw this with stock ixgbe driver from 2.6.38.6 and with the latest
>> 3.3.9 ixgbe.
>> This kernel is tainted because we use fusion-io iodrives as journal
>> devices for btrfs.
>>
>> Any hints to nail this down are welcome.
>>
>> Greetings Stefan Majer
>>
>> May 10 15:26:40 os02 kernel: [ 3652.485219] cosd: page allocation
>> failure. order:2, mode:0x4020
>
> It looks like the machine running the cosd is crashing, is that the case?
> Are you running both ceph kernel module on the same machine by any

that should be "both the osd and the kernel module"

> chance? If not, it can be some other fs bug (e.g., the underlying
> btrfs). Also, the stack here is quite deep, there's a chance for a
> stack overflow.
>
> Thanks,
> Yehuda
>
