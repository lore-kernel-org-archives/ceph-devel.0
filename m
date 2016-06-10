From: Sage Weil <sweil@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 10 Jun 2016 07:04:36 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com> <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com> <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com> <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com> <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com> <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbcFJLEM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 07:04:12 -0400
In-Reply-To: <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, Marcus Watts <mwatts@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 6 Jun 2016, Gregory Farnum wrote:
> On Fri, Jun 3, 2016 at 10:33 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Sat, 4 Jun 2016, Haomai Wang wrote:
> >> On Fri, Jun 3, 2016 at 9:24 PM, Sage Weil <sweil@redhat.com> wrote:
> >> > I updated the PR with an additional commit that simplifies the
> >> > confounder.  It seems like we only need the confoudner at teh beginning of
> >> > the session, not for every message, since the signature and encryption
> >> > state is chained from the previous frame.  Is that right?
> >> >
> >> >         https://github.com/ceph/ceph/pull/9461/commits/45766fed1864733c5216a7b50f11cce256338170
> >> >
> >> > Full PR:
> >> >
> >> >         https://github.com/ceph/ceph/pull/9461
> >> >
> >> > --
> >> >
> >> > Also, I just realized that now might be a good time to address the ability
> >> > to multiplex different endpoints (sessions) into the same connection.  We
> >> > could add it later with the msgr feature bits, but it'll probably be
> >> > simpler not to have to support two variants of the protocol.  On the other
> >> > hand, it's a lot more complicated.  :(
> >>
> >> What's the use case? different session shares the same connection? Do
> >> you mean different messenger instance will share the same connection
> >> pool?
> >
> > Many OSD's in the same unix process, sharing the same messenger connection
> > pool, eventually using SPDK/DPDK.
> 
> Oof, yes, if we want to make that happen it should be in this design phase.
> 
> So, what features do we want/need to include here? Is it just the
> ability to send messages which represent different entities on a tag
> basis? Full streams with their own encryption settings?
> Do we want to do interleaving on some block size, or do
> messages/streams on a full frame basis?
> 
> I've thought about these some and am mixed-to-clueless on these, but
> we need some targets.

I tried to spec this out (see latest wip-msgr2 commit,

	https://github.com/liewegas/ceph/commit/wip-msgr2

Basically a single connection just multiplexes multiple streams, and 
everything we talked about before (except for the banner) is per-stream.  
Each frame has a stream id, frame length, and then the rest is the 
same.

It mostly works, but there is one thing to point out: if we do 
this, the encryption happens within a stream, not the outer framing 
protocol.  That means that the size of frames is no longer secret.  This 
could probably already be inferred by packet boundaries and timing in most 
circumstances, so I don't think it's a problem, but it's worth 
pointing out.  You can also tell which frames belong to which stream, but 
that would also be true if they were over separate connections, so I don't 
think that matters either.

The end goal of this is that:

 - a single process could most many entities (OSDs is the target)
 - entities could come and go, independent of the connection lifecycle
 - things like mark_down would terminate streams.  I think this would be 
just be a TAG_CLOSE message inside a given stream.

How the implementation's Messenger objects would be instantiated and 
handle the sharing of connections is not important at this layer, as far 
as I can tell.  I can imagine a couple different options that seem fine.

sage
