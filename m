From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Thu, 10 Dec 2015 18:38:18 -0800
Message-ID: <CAJ4mKGYjr2_3gOwy2PhMCQvJLWC9Q0+wzyZskF9vJ3bOdC-OpQ@mail.gmail.com>
References: <1449173601.2291.84.camel@millnert.se>
	<CAJ4mKGZvgaEtLF=EX0t_74KS4-yxFMmR4oJUUx7YZhpXb-9EeQ@mail.gmail.com>
	<1449495369.29564.113.camel@millnert.se>
	<CAJ4mKGYFd41M_2ucr-d8y8g_HK4RN6ckdk=LGOSKgo-p9fvwsg@mail.gmail.com>
	<1449502273.29564.145.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36216 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbbLKCiT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Dec 2015 21:38:19 -0500
Received: by mail-wm0-f47.google.com with SMTP id n186so10632144wmn.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Dec 2015 18:38:19 -0800 (PST)
In-Reply-To: <1449502273.29564.145.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 7, 2015 at 7:31 AM, Martin Millnert <martin@millnert.se> wrote:
> On Mon, 2015-12-07 at 06:48 -0800, Gregory Farnum wrote:
> <snip>
>> >> I'm probably just being dense here, but I don't quite understand what
>> >> all this is trying to accomplish. It looks like it's essentially
>> >> trying to set up VLANs (with different rules) over a single physical
>> >> network interface, that is still represented to userspace as a single
>> >> device with a single IP. Is that right?
>> >
>> > That's almost what it is, with two differences:
>> >  1) there are separated route tables per VLAN,
>> >  2) Each VLAN interface (public, cluster) has its own address.
>>
>> Okay, but if each interface has its own interface, why do you need
>> Ceph to do anything at all? You can specify the public and cluster
>> addresses, they'll bind to the appropriate interface, and then you can
>> do stuff based on the interface/VLAN it's part of. Right?
>> -Greg
>
> Yes. And in the generic case: almost good enough.
>
> In the case I'm discussing, with also separate Linux kernel routing
> tables, we need to steer the route lookups that happens once the tcp
> stack has performed its packetization, into the correct table.
>
> Depending on how Ceph behaves with interface/IP binding for outbound
> connections, this may be easy!
> I.e. if Ceph binds to the specific address, not only on the listening
> socket, but also when creating outbound sockets, we can create "ip
> rule"'s that uses the source address and AFAIU "we're home" - at this
> level.
> Do you know if this is how Ceph manages the sockets in this case?
>
> But if we instead end up with the kernel trying to figure which address
> to use ( https://tools.ietf.org/html/rfc6724 ), it gets a whole lot
> trickier.

Mmm, yeah, I think it makes the kernel pick each time. But if you've
got the same IP on both I would hope that's not a problem. I haven't
dug into it though. :/
-Greg



>
> For monitors that live only on the public network (as per
> documentation), the situation is simpler; we can mark traffic outside of
> Ceph using e.g. iptables.
>
> /Martin
>
