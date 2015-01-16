From: Wido den Hollander <wido@42on.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Fri, 16 Jan 2015 11:55:55 +0100
Message-ID: <54B8EE3B.70506@42on.com>
References: <54B7D2D6.4020503@42on.com> <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com> <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net> <101AEAEE-F428-4425-87CE-A20B3030FF55@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41410 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbbAPKz6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Jan 2015 05:55:58 -0500
In-Reply-To: <101AEAEE-F428-4425-87CE-A20B3030FF55@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>, Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/16/2015 10:50 AM, Sebastien Han wrote:
> Hum if I understand correctly you=E2=80=99re all more in favour of a =
conf setting in the ceph.conf;
> The problem for me is that this will apply to all the pools by defaul=
t and I=E2=80=99ll have to inject an arg to change this.
> Injecting the arg will remove this =E2=80=9Clock" and then all of the=
 sudden all the pools become deletable through the lib again (who knows=
 what users can do simultaneously)
>=20

No, from what I understand it's easier to implement, not the better way=
=2E

> I=E2=80=99m more in favour of a new flag to set to the pool, somethin=
g like:
>=20
> ceph osd pool set foo protect true
> ceph osd pool delete foo foo =E2=80=94yes=E2=80=A6.
> ERROR: pool foo is protected against deletion
>=20
> ceph osd pool delete foo protect false
> ceph osd pool delete foo foo =E2=80=94yes=E2=80=A6.
> Pool successfully deleted
>

Something like that per pool seems better to me as well. But I'd then
opt for a 'feature' which can be set on a pool.

ceph osd pool set foo nodelete
ceph osd pool set foo nopgchange
ceph osd pool set foo nosizechange


> The good thing with that is that owners of the pool (or admin), will =
be able to set this flag or remove it.
> We stick with the "ceph osd pool delete foo foo =E2=80=94yes=E2=80=A6=
=2E=E2=80=9D command as well, so we don=E2=80=99t change too much thing=
s.
>=20
> Moreover we can also make use of a config option to protect all new c=
reated pools by default:
>=20
> mon protect pool default =3D true
>=20
> This automatically set the protected flag to a new pool.
>=20
> What do you think?
>=20

Setting a nodelete flag or something like that by default is fine with
me. Like Sage mentioned earlier, almost nobody will have ephemeral pool=
s
in their cluster. You don't want to loose data because you accidentally
removed a pool.

Wido

>> On 15 Jan 2015, at 18:24, Sage Weil <sage@newdream.net> wrote:
>>
>> Then secondary question is whether the cluster should implicitly cle=
ar the=20
>> allow-delete after some time period (maybe 'pending-delete' would ma=
ke=20
>> more sense in that case), or whether we deny IO during that period. =
 Seems=20
>> perhaps too complicated.
>=20
>=20
> Cheers.
> =E2=80=93=E2=80=93=E2=80=93=E2=80=93=20
> S=C3=A9bastien Han=20
> Cloud Architect=20
>=20
> "Always give 100%. Unless you're giving blood."
>=20
> Phone: +33 (0)1 49 70 99 72=20
> Mail: sebastien.han@enovance.com=20
> Address : 11 bis, rue Roqu=C3=A9pine - 75008 Paris
> Web : www.enovance.com - Twitter : @enovance=20
>=20


--=20
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
