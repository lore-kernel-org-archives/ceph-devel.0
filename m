From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] Re: [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Tue, 13 Jul 2010 12:41:17 -0700
Message-ID: <AANLkTikWM-990doMte8tKOxZ63vbzQVHpMefZmdD8B2_@mail.gmail.com>
References: <20100531193140.GA13993@chb-desktop>
	<4C1293B7.1060307@gmail.com>
	<AANLkTimQ8voPJC6krCAsvlzoOZOZ-1LDXXI6_asbO9xT@mail.gmail.com>
	<4C1B45DB.4000502@redhat.com>
	<AANLkTilSXVV6JzLXGBZ0OvVuut9wad7TLkZtxEmXmrEy@mail.gmail.com>
	<AANLkTilnN7SXDXIulNICT5kjdgYJuVJIWYhKr6RVP_7K@mail.gmail.com>
	<20100713192338.GA25126@sir.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20100713192338.GA25126@sir.home>
Sender: kvm-owner@vger.kernel.org
To: Christian Brunner <chb@muc.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Simone Gotti <simone.gotti@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 13, 2010 at 12:23 PM, Christian Brunner <chb@muc.de> wrote:
> On Tue, Jul 13, 2010 at 11:27:03AM -0700, Yehuda Sadeh Weinraub wrote:
>> >
>> > There is another problem with very large i/o requests. I suspect that
>> > this can be triggered only
>> > with qemu-io and not in kvm, but I'll try to get a proper solution it anyway.
>> >
>>
>> Have you made any progress with this issue? Just note that there were
>> a few changes we introduced recently (a format change that allows
>> renaming of rbd images, and some snapshots support), so everything
>> will needed to be reposted once we figure out the aio issue.
>
> Attached is a patch where I'm trying to solve the issue
> with pthreads locking. It works well with qemu-io, but I'm
> not sure if there are interferences with other threads in
> qemu/kvm (I didn't have time to test this, yet).
>
> Another thing I'm not sure about is the fact, that these
> large I/O requests only happen with qemu-io. I've never seen
> this happen inside a virtual machine. So do we really have
> to fix this, as it is only a warning message (laggy).
>

We can have it configurable, and by default not use it. We don't need
to feed the osds with more data that they can digest anyway, since
that will only increase our memory usage -- whether it's just a
warning or a real error. So a bounded approach that doesn't hurt
performance makes sense.
I'll merge this one into our tree so that it could get some broader
testing, however, I think the qemu code requires using the qemu_cond
wrappers instead of directly using the pthread_cond_*().

Thanks,
Yehuda
