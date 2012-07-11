From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Wed, 11 Jul 2012 22:23:34 +0200
Message-ID: <4FFDE0C6.50807@univ-nantes.fr>
References: <4FF6A27B.7020808@univ-nantes.fr> <4FF705BA.4080501@univ-nantes.fr> <4FF77FE8.9040408@inktank.com> <4FFB0CBA.6090806@univ-nantes.fr> <4FFB0F2A.6070601@univ-nantes.fr> <CAPYLRzj0=hs5BYrG2veYMBUOaU1HmAJoBRPdwj1y3PuMUveb0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:42612 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751571Ab2GKUXr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 16:23:47 -0400
In-Reply-To: <CAPYLRzj0=hs5BYrG2veYMBUOaU1HmAJoBRPdwj1y3PuMUveb0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 10/07/2012 19:46, Gregory Farnum a =E9crit :
>
>
> Each time, at the exact date, a bad CRC (they are the only ones for t=
his
> day, so it seems related)
> Yes; a bad CRC should cause the socket to close =97 that's intended
> behavior (although you might want to look into why that's happening,
ah ! very interesting ! 3.2 is ok, 3.4 not (even with latest ceph-clien=
t=20
patch).
the 8 nodes are similar (poweredge M610, intel 10 Gb), but the client i=
s=20
not : Also M610 (older) but with brocade 10Gb.

I'll also try another client with intel 10Gb and 3.4 kernel, to see if=20
that change things.
And then I'll narrow the gap between working & not working, and try to=20
bisect that.

> since it's not something we've seen locally at all). Not handling tha=
t
> socket close is definitely a bug in the kernel that needs to get
> tracked down, though.
Ok, the oops is not the root cause, just an unfortunate consequence

Thanks,
Cheers

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
