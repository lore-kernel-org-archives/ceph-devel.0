From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Why cephx rather then kerberos?
Date: Mon, 10 Dec 2012 10:57:55 -0800
Message-ID: <CAC-hyiEWwBahOEuuvfWyCy216A=0muLPCHWt7DCXMw6B+=STwQ@mail.gmail.com>
References: <CABZB-sig_O-s1cXZ5k4QMu5DZBgTUERg+HLGoe24AwLvwtxbJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:47145 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2LJS5z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 13:57:55 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4574515iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 10:57:55 -0800 (PST)
In-Reply-To: <CABZB-sig_O-s1cXZ5k4QMu5DZBgTUERg+HLGoe24AwLvwtxbJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Proulx <jon@jonproulx.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Dec 9, 2012 at 12:03 PM, Jonathan Proulx <jon@jonproulx.com> wrote:
> Hi All,
>
> the docs continuously describe cephx as Kerberos-like, curious why
> Kereros isn't used instead.
>
> Developing new security protocols is almost always a bad idea from a
> security perspective.  I haven't looked deeply into cephx to see how
> much is novel (and likely to contain novel bugs) ans how much is reuse
> of well worn crypto.  So this is just a first impression concern.
>
> More importantly to me I already have a Kerberos infrastructure all my
> users have principals all my hosts have keytabs and I would really
> like to reuse that for securing data access rather than managing yet
> another a separate set of credentials.
>
> The only reason I can see documented is "Unlike Kerberos, each monitor
> can authenticate users and distribute keys, so there is no single
> point of failure or bottleneck when using chepx."  Kerberos using
> multiple KDCs  needn't have a single point of failure, and "each
> monitor" probably means 3-5 systems in practice which is a typical
> scale for production Kerberos deployments.  Now it's true with
> Kerberos if the admin server goes down I can't add new principals
> (users) or perform other administrative functions, but authentication
> continues and users (human and daemon) don't really care.
>
> Am I missing something? Any plans to either add Kerberos as an
> authentication method or provide a pluggable authentication scheme?
>
> I'm fairly excited about all things Ceph from a design and direction
> perspective, but this piece (IMO) is the one thing that is just
> painfully close but not quite right.
>

The ceph auth scheme is somewhat extensible, and the code is modular
and has been written with alternative implementations in mind.
Originally we considered doing kerberos from the start, but there were
a few issues that made us having develop cephx. Note that cephx is
basically kerberos tailored into ceph.

1. Single point of failure

You mentioned it, though you pointed that it might not be the case
with Kerberos (OTOH, you pointed at the admin server as a single point
of failure -- with a lesser impact).

2. Service tied to a single machine

In Kerberos, services are tied to usually a single machine, usually
defined by one or more IP addresses. This means that the tickets
information holds the IP address of the destination and is not
flexible enough to work well in a dynamic environment such as ceph. We
wanted to avoid requiring the clients obtaining a ticket for every
entity it contacted, as this wouldn't have scaled well.

3. Simplify configuration

While it wasn't a design goal, we preferred (at the time), to lower
the installation bar, which would have required installing and setting
up kerberos.

I've probably forgotten a point or two, Sage might remember more. I
think that the time to develop a kerberos solution looked
significantly longer at the time due to (1) and (2), and given that we
needed to implement the client side for both the userspace client and
for the linux kernel side.

That been said, we had kerberos in mind when we developed the ceph
authentication scheme. We'd certainly be happy if a kerberos solution
could be integrated in the future. Thinking about it, that might be a
nice project for someone that wants to start diving into ceph.

Yehuda
