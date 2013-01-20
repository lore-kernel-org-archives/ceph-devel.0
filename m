From: Gregory Farnum <greg@inktank.com>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 15:17:16 -0800
Message-ID: <BA913A5056344C77AE4476417C3197A3@inktank.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
 <CAJH6TXi40uB5Xup3xob+zVJaf6q=4dKjdgs4+NkD-fa5Bh2z0Q@mail.gmail.com>
 <6C6B937F81BD480D8B439B27D504FE9C@inktank.com>
 <CAJH6TXiutMfJ51G3itP83=-eSX+W9xtdPftNj0j0xcg+rHANmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:53594 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3ATXRU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 18:17:20 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so2424056dad.36
        for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 15:17:20 -0800 (PST)
In-Reply-To: <CAJH6TXiutMfJ51G3itP83=-eSX+W9xtdPftNj0j0xcg+rHANmw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

On Sunday, January 20, 2013 at 2:43 PM, Gandalf Corvotempesta wrote:
> 2013/1/20 Gregory Farnum <greg@inktank.com (mailto:greg@inktank.com)>=
:
> > This is a bit embarrassing, but if you're actually using two networ=
ks and the cluster network fails but the client network stays up, thing=
s behave pretty badly (the OSDs will keep insisting it's failed, while =
the monitor will insist it's still working). I believe there's a branch=
 working on this problem, but I haven't been involved with it.
> > It's not necessary to have split networks though, no.
> =20
> =20
> =20
> Ok.
> =20
> > Does that answer your question?
> =20
> Absolutely, but usually cluster network is faster than client network
> and being forced to use two cluster network is very very expensive.

I'm not quite sure what you mean=E2=80=A6the use of the "cluster networ=
k" and "public network" are really just intended as conveniences for pe=
ople with multiple NICs on their box. There's nothing preventing you fr=
om running everything on the same network=E2=80=A6(and more specificall=
y, from different speed grades to different boxes, but keeping them all=
 on the same network).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
