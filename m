From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Thu, 12 Jul 2012 09:15:36 +0200
Message-ID: <4FFE7998.9020002@univ-nantes.fr>
References: <4FF6A27B.7020808@univ-nantes.fr> <4FF705BA.4080501@univ-nantes.fr> <4FF77FE8.9040408@inktank.com> <4FFB0CBA.6090806@univ-nantes.fr> <4FFB0F2A.6070601@univ-nantes.fr> <CAPYLRzj0=hs5BYrG2veYMBUOaU1HmAJoBRPdwj1y3PuMUveb0w@mail.gmail.com> <4FFDE0C6.50807@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:34435 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752759Ab2GLHPm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 03:15:42 -0400
In-Reply-To: <4FFDE0C6.50807@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Gregory Farnum <greg@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 11/07/2012 22:23, Yann Dupont a =E9crit :
> Le 10/07/2012 19:46, Gregory Farnum a =E9crit :
>>
>>
>> Each time, at the exact date, a bad CRC (they are the only ones for =
this
>> day, so it seems related)
>> Yes; a bad CRC should cause the socket to close =97 that's intended
>> behavior (although you might want to look into why that's happening,
> ah ! very interesting ! 3.2 is ok, 3.4 not (even with latest=20
> ceph-client patch).
> the 8 nodes are similar (poweredge M610, intel 10 Gb), but the client=
=20
> is not : Also M610 (older) but with brocade 10Gb.
>
It is broadcom 10 Gb, not brocade . sorry for the confusion

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
