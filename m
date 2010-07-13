From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] Re: [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Tue, 13 Jul 2010 11:27:03 -0700
Message-ID: <AANLkTilnN7SXDXIulNICT5kjdgYJuVJIWYhKr6RVP_7K@mail.gmail.com>
References: <20100531193140.GA13993@chb-desktop>
	<4C1293B7.1060307@gmail.com>
	<AANLkTimQ8voPJC6krCAsvlzoOZOZ-1LDXXI6_asbO9xT@mail.gmail.com>
	<4C1B45DB.4000502@redhat.com>
	<AANLkTilSXVV6JzLXGBZ0OvVuut9wad7TLkZtxEmXmrEy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <AANLkTilSXVV6JzLXGBZ0OvVuut9wad7TLkZtxEmXmrEy@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Christian Brunner <chb@muc.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Simone Gotti <simone.gotti@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sat, Jun 19, 2010 at 8:48 AM, Christian Brunner <chb@muc.de> wrote:
>>
>> Are you going to send a final version which includes Simone's patch or
>> should I apply them as two patches and just accept that rbd is broken
>> after the first one? Or were there any other problems that need to be
>> solved first?
>
> I'll send a final version, when I've tested everything.
>
> There is another problem with very large i/o requests. I suspect that
> this can be triggered only
> with qemu-io and not in kvm, but I'll try to get a proper solution it anyway.
>

Have you made any progress with this issue? Just note that there were
a few changes we introduced recently (a format change that allows
renaming of rbd images, and some snapshots support), so everything
will needed to be reposted once we figure out the aio issue.

Thanks,
Yehuda
