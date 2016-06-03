From: =?UTF-8?Q?Beno=c3=aet_Parrein?=
	<benoit.parrein@polytech.univ-nantes.fr>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or
 Jerasure
Date: Fri, 3 Jun 2016 15:25:37 +0200
Message-ID: <57518551.2030604@polytech.univ-nantes.fr>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:42117 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932612AbcFCNei (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 09:34:38 -0400
In-Reply-To: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chandan Kumar Singh <chandan.kr.singh@gmail.com>, ceph-devel@vger.kernel.org

Hi Chandan,

thanks you for your post

indeed we observe in our experiment that Mojette erasure coding has=20
better performance than ISA-L (thanks to the discrete geometry and=20
Mojette transform). A systematic/standard version exists. It is a paten=
t=20
(as couples of erasure coding). We are few cycles above memcopy=20
instructions.
A paper is currently under revision and will appear soon on this.

Moreover RozoFS is alive! see on github https://github.com/rozofs/rozof=
s=20
(last commit 6 days ago).
8 peoples are working daily to improve this fully posix DFS which is=20
today the only one on the earth erasure coding based (at our best=20
knowledge).
We compared to CephFS (in replication mode) and outperform it.=20
Particularly, in random I/Os where the 4KB (or 8KB) blocks structure is=
=20
well suited for Rozo.
Same. A paper will appear soon on this point.

Best regards
bparrein, University of Nantes



Le 20/04/2016 10:52, Chandan Kumar Singh a =C3=A9crit :
> Hi
>
> The authors of  Mojette Erasure Encoding claim that this EC has highe=
r
> performance than ISA-L and Jerasure and can be used for hot storage
> use cases. Their EC is used in open source RozoFS. What is your
> evaluation of it? It will be nice if it is available as another EC
> plugin.
>
> Regards
> Chandan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--=20
----------------
Beno=C3=AEt Parrein
Ma=C3=AEtre de Conf=C3=A9rences (HDR)
Universit=C3=A9 de Nantes (Polytech Nantes), laboratoire IRCCyN
web: http://www.irccyn.ec-nantes.fr/~parrein/
tel: +33(0)240683050

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
