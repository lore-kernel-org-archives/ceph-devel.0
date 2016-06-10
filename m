From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or
 Jerasure
Date: Fri, 10 Jun 2016 06:06:03 +0200 (CEST)
Message-ID: <711784903.786182263.1465531563144.JavaMail.zimbra@oxygem.tv>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com> <57518551.2030604@polytech.univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:56734 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcFJEGG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 00:06:06 -0400
In-Reply-To: <57518551.2030604@polytech.univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Parrein <benoit.parrein@polytech.univ-nantes.fr>
Cc: Chandan Kumar Singh <chandan.kr.singh@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>We compared to CephFS (in replication mode) and outperform it.=20
>>Particularly, in random I/Os where the 4KB (or 8KB) blocks structure =
is=20
>>well suited for Rozo.=20

I have found your paper here

https://departements.telecom-bretagne.eu/data/elec/SITES/PublicElec/Ben=
oitParrein_interGDR.pdf

100k 4k randread, an 80k 4k iops randwrite, not too bad with 4 nodes !=20

What was the bottleneck ? cpu ?




----- Mail original -----
De: "Beno=C3=AEt Parrein" <benoit.parrein@polytech.univ-nantes.fr>
=C3=80: "Chandan Kumar Singh" <chandan.kr.singh@gmail.com>, "ceph-devel=
" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Vendredi 3 Juin 2016 15:25:37
Objet: Re: Mojette based Erasure Code is more performant than ISA-L or =
Jerasure

Hi Chandan,=20

thanks you for your post=20

indeed we observe in our experiment that Mojette erasure coding has=20
better performance than ISA-L (thanks to the discrete geometry and=20
Mojette transform). A systematic/standard version exists. It is a paten=
t=20
(as couples of erasure coding). We are few cycles above memcopy=20
instructions.=20
A paper is currently under revision and will appear soon on this.=20

Moreover RozoFS is alive! see on github https://github.com/rozofs/rozof=
s=20
(last commit 6 days ago).=20
8 peoples are working daily to improve this fully posix DFS which is=20
today the only one on the earth erasure coding based (at our best=20
knowledge).=20
We compared to CephFS (in replication mode) and outperform it.=20
Particularly, in random I/Os where the 4KB (or 8KB) blocks structure is=
=20
well suited for Rozo.=20
Same. A paper will appear soon on this point.=20

Best regards=20
bparrein, University of Nantes=20



Le 20/04/2016 10:52, Chandan Kumar Singh a =C3=A9crit :=20
> Hi=20
>=20
> The authors of Mojette Erasure Encoding claim that this EC has higher=
=20
> performance than ISA-L and Jerasure and can be used for hot storage=20
> use cases. Their EC is used in open source RozoFS. What is your=20
> evaluation of it? It will be nice if it is available as another EC=20
> plugin.=20
>=20
> Regards=20
> Chandan=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20

--=20
----------------=20
Beno=C3=AEt Parrein=20
Ma=C3=AEtre de Conf=C3=A9rences (HDR)=20
Universit=C3=A9 de Nantes (Polytech Nantes), laboratoire IRCCyN=20
web: http://www.irccyn.ec-nantes.fr/~parrein/=20
tel: +33(0)240683050=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
