From: Jonathan Proulx <jon@jonproulx.com>
Subject: Re: Why cephx rather then kerberos?
Date: Wed, 12 Dec 2012 21:04:24 -0500
Message-ID: <CABZB-sgyibPsGBxsB6ecDA1pLUy-Or_mH=5Z8ObOASx9oYROhA@mail.gmail.com>
References: <CABZB-sig_O-s1cXZ5k4QMu5DZBgTUERg+HLGoe24AwLvwtxbJA@mail.gmail.com>
	<CAC-hyiEWwBahOEuuvfWyCy216A=0muLPCHWt7DCXMw6B+=STwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50699 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab2LMCEZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 21:04:25 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1555742oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 18:04:24 -0800 (PST)
In-Reply-To: <CAC-hyiEWwBahOEuuvfWyCy216A=0muLPCHWt7DCXMw6B+=STwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Dec 10, 2012 at 1:57 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Sun, Dec 9, 2012 at 12:03 PM, Jonathan Proulx <jon@jonproulx.com> wrote:

> The ceph auth scheme is somewhat extensible, and the code is modular
> and has been written with alternative implementations in mind.
> Originally we considered doing kerberos from the start, but there were
> a few issues that made us having develop cephx. Note that cephx is
> basically kerberos tailored into ceph.

I did see later that while not pluggable at the configuration layer
for external authentication types, the auth code does have a nice
clean switch between cephx and none that would make adding other auth
types to the code base relatively easy

> 1. Single point of failure
>
> You mentioned it, though you pointed that it might not be the case
> with Kerberos (OTOH, you pointed at the admin server as a single point
> of failure -- with a lesser impact).
>
> 2. Service tied to a single machine
>
> In Kerberos, services are tied to usually a single machine, usually
> defined by one or more IP addresses. This means that the tickets
> information holds the IP address of the destination and is not
> flexible enough to work well in a dynamic environment such as ceph. We
> wanted to avoid requiring the clients obtaining a ticket for every
> entity it contacted, as this wouldn't have scaled well.

Yes I can imagine that might become a problem I'd only though about
the server load.  Given a large number of ceph servers and a large
number of clients the Kerberos credential cache might get ugly, it
might not, but it is much different than other case I've used.

> 3. Simplify configuration
>
> While it wasn't a design goal, we preferred (at the time), to lower
> the installation bar, which would have required installing and setting
> up kerberos.

I can see that though I'm not convinced it's lower so much as a longer
gentler slope, but as you say it's not a design goal so no point
splitting hairs

> I've probably forgotten a point or two, Sage might remember more. I
> think that the time to develop a kerberos solution looked
> significantly longer at the time due to (1) and (2), and given that we
> needed to implement the client side for both the userspace client and
> for the linux kernel side.
>
> That been said, we had kerberos in mind when we developed the ceph
> authentication scheme. We'd certainly be happy if a kerberos solution
> could be integrated in the future. Thinking about it, that might be a
> nice project for someone that wants to start diving into ceph.

A more than fair assessment, should ceph work for my immediate goals
and I find some copious free time I might do..maybe :)

Thanks!,
-Jon
