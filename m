From: Loic Dachary <loic@dachary.org>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or
 Jerasure
Date: Wed, 20 Apr 2016 19:58:31 +0700
Message-ID: <57177CF7.1090600@dachary.org>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp26.services.sfr.fr ([93.17.128.163]:59419 "EHLO
	smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcDTM6k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2016 08:58:40 -0400
In-Reply-To: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chandan Kumar Singh <chandan.kr.singh@gmail.com>, ceph-devel@vger.kernel.org

Hi,

On 20/04/2016 15:52, Chandan Kumar Singh wrote:
> Hi
>=20
> The authors of  Mojette Erasure Encoding claim that this EC has highe=
r
> performance than ISA-L and Jerasure and can be used for hot storage
> use cases. Their EC is used in open source RozoFS. What is your
> evaluation of it? It will be nice if it is available as another EC
> plugin.

RozoFS is no longer developped (last commit was july last year). It wou=
ld be nice to have an alternative implementation of the same algorithm,=
 well maintained. It's sad to see Free Software being frozen. But Free =
Software is never dead, all it needs is good will and a little work to =
be resurected ! I've never seen any benchmark regarding performances, t=
hat would be the first step.

Cheers
=20
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
