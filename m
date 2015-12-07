From: Martin Millnert <martin@millnert.se>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Mon, 07 Dec 2015 16:31:13 +0100
Message-ID: <1449502273.29564.145.camel@millnert.se>
References: <1449173601.2291.84.camel@millnert.se>
	 <CAJ4mKGZvgaEtLF=EX0t_74KS4-yxFMmR4oJUUx7YZhpXb-9EeQ@mail.gmail.com>
	 <1449495369.29564.113.camel@millnert.se>
	 <CAJ4mKGYFd41M_2ucr-d8y8g_HK4RN6ckdk=LGOSKgo-p9fvwsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:45481 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932965AbbLGPbR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Dec 2015 10:31:17 -0500
In-Reply-To: <CAJ4mKGYFd41M_2ucr-d8y8g_HK4RN6ckdk=LGOSKgo-p9fvwsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 2015-12-07 at 06:48 -0800, Gregory Farnum wrote:
<snip>
> >> I'm probably just being dense here, but I don't quite understand what
> >> all this is trying to accomplish. It looks like it's essentially
> >> trying to set up VLANs (with different rules) over a single physical
> >> network interface, that is still represented to userspace as a single
> >> device with a single IP. Is that right?
> >
> > That's almost what it is, with two differences:
> >  1) there are separated route tables per VLAN,
> >  2) Each VLAN interface (public, cluster) has its own address.
> 
> Okay, but if each interface has its own interface, why do you need
> Ceph to do anything at all? You can specify the public and cluster
> addresses, they'll bind to the appropriate interface, and then you can
> do stuff based on the interface/VLAN it's part of. Right?
> -Greg

Yes. And in the generic case: almost good enough.

In the case I'm discussing, with also separate Linux kernel routing
tables, we need to steer the route lookups that happens once the tcp
stack has performed its packetization, into the correct table.

Depending on how Ceph behaves with interface/IP binding for outbound
connections, this may be easy!
I.e. if Ceph binds to the specific address, not only on the listening
socket, but also when creating outbound sockets, we can create "ip
rule"'s that uses the source address and AFAIU "we're home" - at this
level.
Do you know if this is how Ceph manages the sockets in this case?

But if we instead end up with the kernel trying to figure which address
to use ( https://tools.ietf.org/html/rfc6724 ), it gets a whole lot
trickier.

For monitors that live only on the public network (as per
documentation), the situation is simpler; we can mark traffic outside of
Ceph using e.g. iptables.

/Martin

