From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or
 Jerasure
Date: Fri, 10 Jun 2016 05:31:08 +0200 (CEST)
Message-ID: <462511107.786164040.1465529468615.JavaMail.zimbra@oxygem.tv>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com> <57177CF7.1090600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:54318 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcFJDbM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2016 23:31:12 -0400
In-Reply-To: <57177CF7.1090600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Chandan Kumar Singh <chandan.kr.singh@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic,

>>RozoFS is no longer developped (last commit was july last year)

Seem that they have released rozofs 2.0 the 21th april 2016
https://github.com/rozofs/rozofs/releases

and they are activity in the git since then.


I don't think the project is dead, because they are doing a lot of comm=
ercial communication recently


http://www.theregister.co.uk/2015/12/01/rozo_aiming_to_fill_scaleout_na=
s_object_scalability_gap/

with a roadmap up to 2017.

v2.1 Jun 2016 =E2=80=93 Fast indexing, versioning, metadata re-use on f=
ile deletion*
v2.2 Dec 2016 =E2=80=93 Per-directory snapshots (possibly), storage QoS=
 (possible throttling)
V2.3 Jun 2017 =E2=80=93 Fast disk encryption, SSD caching


Regards,

Alexandre


----- Mail original -----
De: "Loic Dachary" <loic@dachary.org>
=C3=80: "Chandan Kumar Singh" <chandan.kr.singh@gmail.com>, "ceph-devel=
" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 20 Avril 2016 14:58:31
Objet: Re: Mojette based Erasure Code is more performant than ISA-L or =
Jerasure

Hi,=20

On 20/04/2016 15:52, Chandan Kumar Singh wrote:=20
> Hi=20
>=20
> The authors of Mojette Erasure Encoding claim that this EC has higher=
=20
> performance than ISA-L and Jerasure and can be used for hot storage=20
> use cases. Their EC is used in open source RozoFS. What is your=20
> evaluation of it? It will be nice if it is available as another EC=20
> plugin.=20

RozoFS is no longer developped (last commit was july last year). It wou=
ld be nice to have an alternative implementation of the same algorithm,=
 well maintained. It's sad to see Free Software being frozen. But Free =
Software is never dead, all it needs is good will and a little work to =
be resurected ! I've never seen any benchmark regarding performances, t=
hat would be the first step.=20

Cheers=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre=20

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
