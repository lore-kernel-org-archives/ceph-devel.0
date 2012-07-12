From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Thu, 12 Jul 2012 23:07:52 +0200
Message-ID: <4FFF3CA8.6070801@univ-nantes.fr>
References: <4FF6A27B.7020808@univ-nantes.fr> <4FF705BA.4080501@univ-nantes.fr> <4FF77FE8.9040408@inktank.com> <4FFB0CBA.6090806@univ-nantes.fr> <4FFB0F2A.6070601@univ-nantes.fr> <CAPYLRzj0=hs5BYrG2veYMBUOaU1HmAJoBRPdwj1y3PuMUveb0w@mail.gmail.com> <4FFDE0C6.50807@univ-nantes.fr> <4FFE7998.9020002@univ-nantes.fr> <4FFF318E.9090603@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:49458 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932936Ab2GLVH6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 17:07:58 -0400
In-Reply-To: <4FFF318E.9090603@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Gregory Farnum <greg@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 12/07/2012 22:20, Yann Dupont a =E9crit :
>
>
> Tomorrow I'll try to see if I made errors on my git bisect. I'll also=
=20
> try to format the rbd with xfs to see if it's really ext4 related.
>

Well. I can confirm it's a race between ext4 & rbd (or maybe just a=20
plain ext4 bug, but could it explain the crc bugs ?)
With a rbd block device formatted with xfs on vanilla kernel 3.4.4, all=
=20
is working well. With ext4 I have the socket closed syndrom / kernel=20
oops very fast.


Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
