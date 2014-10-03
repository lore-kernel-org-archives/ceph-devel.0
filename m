From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] Ceph Developer Summit: Hammer
Date: Fri, 03 Oct 2014 11:09:08 +0200 (CEST)
Message-ID: <71a5f972-bbc0-4f46-98c8-896c16c1e595@mailpro>
References: <CAP8Oy=J90nuAyY5+1V9gUGYFLYyRnq5wVE6rZruFfOS98RAJiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:60224 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbaJCJJV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Oct 2014 05:09:21 -0400
In-Reply-To: <CAP8Oy=J90nuAyY5+1V9gUGYFLYyRnq5wVE6rZruFfOS98RAJiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <patrick@inktank.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph-User <ceph-users@ceph.com>, Ceph Devel <ceph-devel@vger.kernel.org>

Thanks Patrick,

It's really a usefull feature for disaster recovery. (export/import wit=
h snapshot is working, but it's really difficult to maintain in product=
ion)

----- Mail original -----=20

De: "Patrick McGarry" <patrick@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Sage Weil" <sweil@redhat.com>, "Ceph-User" <ceph-users@ceph.com>, =
"Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Vendredi 3 Octobre 2014 01:00:21=20
Objet: Re: [ceph-users] Ceph Developer Summit: Hammer=20

Hey Alexandre,=20

Sounds like work has started on this (under the title "RBD Mirroring")=20
and is continuing in Hammer. I have updated the title and moved it to=20
Hammer so there will be a design discussion at CDS. Thanks!=20

https://wiki.ceph.com/Planning/Blueprints/Hammer/RBD%3A_Mirroring=20


Best Regards,=20

Patrick McGarry=20
Director Ceph Community || Red Hat=20
http://ceph.com || http://community.redhat.com=20
@scuttlemonkey || @ceph=20


On Wed, Oct 1, 2014 at 4:47 PM, Alexandre DERUMIER <aderumier@odiso.com=
> wrote:=20
> Hi,=20
>=20
> any news about this blueprint ?=20
>=20
> https://wiki.ceph.com/Planning/Blueprints/Giant/rbd%3A_journaling=20
>=20
>=20
> Regards,=20
>=20
> Alexandre=20
> ----- Mail original -----=20
>=20
> De: "Sage Weil" <sweil@redhat.com>=20
> =C3=80: "Patrick McGarry" <patrick@inktank.com>=20
> Cc: "Ceph-User" <ceph-users@ceph.com>, ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Mercredi 1 Octobre 2014 22:32:30=20
> Objet: Re: [ceph-users] Ceph Developer Summit: Hammer=20
>=20
> [adding ceph-devel]=20
>=20
>> On Tue, Sep 30, 2014 at 5:30 PM, Yann Dupont <yd@objoo.org> wrote:=20
>> >=20
>> > Le 30/09/2014 22:55, Patrick McGarry a ?crit :=20
>> >>=20
>> >> Hey cephers,=20
>> >>=20
>> >> The schedule and call for blueprints is now up for our next CDS a=
s we=20
>> >> aim for the Hammer release:=20
>> >>=20
>> >> http://ceph.com/community/ceph-developer-summit-hammer/=20
>> >>=20
>> >> If you have any work that you plan on submitting through the end =
of=20
>> >> the year, please fill out a Blueprint (the big red button) as soo=
n as=20
>> >> possible. Each blueprint will get a planning session with Sage an=
d=20
>> >> the community to make sure all work is well coordinated and plann=
ed.=20
>> >>=20
>> >> If you have questions, or would like my help on the Blueprint pro=
cess,=20
>> >> please don't hesitate to contact me. Thanks!=20
>> >>=20
>> > Hi patrick (and other cephers)=20
>> > Before making any new blueprint, I was reviewing some past ones, i=
n=20
>> > particular :=20
>> >=20
>> > https://wiki.ceph.com/Planning/Blueprints/Giant/librados%3A_suppor=
t_parallel_reads=20
>> > (I made some comments yesterday)=20
>=20
> Not implemented=20
>=20
>> > and even an older one (somewhat related):=20
>> >=20
>> > https://wiki.ceph.com/Planning/Blueprints/Emperor/librados%2F%2Fob=
jecter%3A_smarter_localized_reads=20
>=20
> Implemented!=20
>=20
>> > Is there a way to know if those blueprints are implemented, or in =
active=20
>> > developpement ? In case of postponed blueprints, is there a way to=
 promote=20
>> > them again, to get consideration for hammer ?=20
>=20
> Hmm, Patrick, I think what we've done in the past is to move the=20
> still-useful blueprints to the sideboard? You probably already asked =
me=20
> to do that... :)=20
>=20
> sage=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
