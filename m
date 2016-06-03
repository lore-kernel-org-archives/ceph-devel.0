From: Sage Weil <sweil@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 3 Jun 2016 13:33:56 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com> <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com> <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com> <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375AbcFCRdf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Jun 2016 13:33:35 -0400
In-Reply-To: <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Marcus Watts <mwatts@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 4 Jun 2016, Haomai Wang wrote:
> On Fri, Jun 3, 2016 at 9:24 PM, Sage Weil <sweil@redhat.com> wrote:
> > I updated the PR with an additional commit that simplifies the
> > confounder.  It seems like we only need the confoudner at teh beginning of
> > the session, not for every message, since the signature and encryption
> > state is chained from the previous frame.  Is that right?
> >
> >         https://github.com/ceph/ceph/pull/9461/commits/45766fed1864733c5216a7b50f11cce256338170
> >
> > Full PR:
> >
> >         https://github.com/ceph/ceph/pull/9461
> >
> > --
> >
> > Also, I just realized that now might be a good time to address the ability
> > to multiplex different endpoints (sessions) into the same connection.  We
> > could add it later with the msgr feature bits, but it'll probably be
> > simpler not to have to support two variants of the protocol.  On the other
> > hand, it's a lot more complicated.  :(
> 
> What's the use case? different session shares the same connection? Do
> you mean different messenger instance will share the same connection
> pool?

Many OSD's in the same unix process, sharing the same messenger connection 
pool, eventually using SPDK/DPDK.

sage
