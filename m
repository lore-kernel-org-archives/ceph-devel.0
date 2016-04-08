From: Loic Dachary <loic@dachary.org>
Subject: Re: releasing hammer v0.94.7 ?
Date: Fri, 8 Apr 2016 09:40:24 +0200
Message-ID: <57076068.9060004@dachary.org>
References: <57067073.9040200@dachary.org>
 <1755778347.2548.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59355 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbcDHHkb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 03:40:31 -0400
In-Reply-To: <1755778347.2548.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Wido,

On 08/04/2016 08:35, Wido den Hollander wrote:
>=20
>> Op 7 april 2016 om 16:36 schreef Loic Dachary <loic@dachary.org>:
>>
>>
>> Hi Sage,
>>
>> Here are the issues that would be in hammer v0.94.7 if we decided to=
 release
>> it now: http://tracker.ceph.com/versions/511
>> And here is the backport queue :
>> http://tracker.ceph.com/projects/ceph/issues?query_id=3D78
>>
>> Do you think it is time to cut the release and ask QE to start testi=
ng ?
>>
>=20
> As this might be the last Hammer release I wonder if we could fix thi=
s bug:
> http://tracker.ceph.com/issues/15348

This will not be the last hammer release.=20

Once jewel is released, people will want to upgrade from hammer to jewe=
l. This will uncover some problems (hopefully minor) that will need fix=
ing and require a new hammer release. When jewel matures, more and more=
 people will migrate to jewel: this will take a few months. Eventually,=
 as it happened with firefly, the number of hammer clusters in producti=
on will be reduced and the bug reports regarding upgrade and operations=
 will be reduced in proportion. At some point there won't be much incen=
tive to publish a new hammer release and they will be less and less fre=
quent. Until it's decided to just stop. In http://docs.ceph.com/docs/ma=
ster/releases/ I estimated it will happen around november this year, gi=
ve or take a few months.

> I already submitted a PR for it: https://github.com/ceph/ceph/pull/84=
41
>=20
> I backported it on a production cluster to Hammer and it works fine. =
Might be
> something we can squeeze in?

This is something you can certainly discuss with Yehuda :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
