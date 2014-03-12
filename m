From: Loic Dachary <loic@dachary.org>
Subject: Re: erasured PG always "peering"
Date: Thu, 13 Mar 2014 00:03:55 +0100
Message-ID: <5320E7DB.7070103@dachary.org>
References: <CAKD2hyHsCTTLWtTR8O6GYMgk=qRw38r_JGz=vAY+yA1DonqYyQ@mail.gmail.com>	<5320BE0B.4090507@dachary.org> <CAKD2hyGc0QtKBj6EVGF7EmDYjfDUoLmAYZdbyYmNJX0TDcGtgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="O2MNiMdv5xfEWa4wh6S9qqglPnN888qdG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41557 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbaCLXD5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 19:03:57 -0400
In-Reply-To: <CAKD2hyGc0QtKBj6EVGF7EmDYjfDUoLmAYZdbyYmNJX0TDcGtgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?= <llpamies@pamies.cat>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O2MNiMdv5xfEWa4wh6S9qqglPnN888qdG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Glad to hear it's working for you now ;-)

There are important bug fixes daily: it is worth getting the latest Firef=
ly from https://github.com/ceph/ceph/tree/firefly

If you run into a problem again, it would be great if you could preserve =
the environment in which it happens and post a bug report (even a terse o=
ne) at http://tracker.ceph.com/projects/ceph/issues/new

Cheers

On 12/03/2014 21:41, Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez wrote:
> Thanks Loic,
>=20
> Noted the indep change.
>=20
> The thing is that I deleted the pool and created it again and now it
> works well (both for indep and firstn...). The cluster hasn't change
> since I had the problem before nor have I restarted any of the
> daemons. I wander if maybe the OSDs needed a "few hours" for
> peering...
>=20
> I'm using a version I cloned from github a few days ago:
> ceph version 0.77-623-gd67a9ad (d67a9adae31da3d07a697b73878c368d2127f1d=
a)
>=20
> Best,
> Lluis
>=20
>=20
> On Wed, Mar 12, 2014 at 1:05 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi
>>
>> On 12/03/2014 18:40, Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez wrote:
>>> Hi ceph-devel,
>>>
>>> I have been playing with the new erasure code functionality and I hav=
e
>>> noticed that the erasure coded PG remains in "peering" state forever.=
 Is
>>> that normal?
>>>
>>> I have a scenario with four servers each with two OSDs (total of eigh=
t
>>> OSDs). Then I define the extra crush rule to get four different OSDs =
across
>>> hosts:
>>>
>>> rule reedsol_ruleset {
>>>     ruleset 1
>>>     type erasure
>>>     min_size 4
>>>     max_size 4
>>>     step take default
>>>     step chooseleaf firstn 0 type host
>>
>> You want to s/firstn/indep/ here. But I don't think it's the source of=
 your problem.
>>
>> From what version are you running (hash of the last commit) ?
>>
>> Cheers
>>
>>>     step emit
>>> }
>>>
>>> And create a simple pool by:
>>> sudo ceph osd pool create cauchy 1 1 erasure erasure-code-plugin=3Dje=
rasure
>>> erasure-code-k=3D2 erasure-code-m=3D2 erasure-code-technique=3Dcauchy=
_good
>>> crush_ruleset=3Dreedsol_ruleset
>>>
>>> After that, the PG status jumps from "creating" to "peering" and stay=
s
>>> there forever. With "sudo ceph pg dump_stuck" I can see:
>>>
>>> pg_stat objects mip degr unf bytes log disklog state state_stamp v re=
ported
>>> up up_primary acting acting_primary last_scrub scrub_stamp last_deep_=
scrub
>>> deep_scrub_stamp
>>> 5.0 0 0 0 0 0 0 0 peering 2014-03-12 10:30:36.717544 0'0 58:3 [0,6,2,=
5] 0
>>> [0,6,2,5] 0 0'0 2014-03-12 10:30:36.715589 0'0 2014-03-12 10:30:36.71=
5589
>>>
>>> I guess that this is not normal and I'm probably doing something wron=
g. Any
>>> ideas?
>>>
>>> Thanks,
>>> Llu=C3=ADs
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--O2MNiMdv5xfEWa4wh6S9qqglPnN888qdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMg59sACgkQ8dLMyEl6F23AgACdF9zhMuLENIgsQs3rjeHVH9p2
B9wAn1hKEIE/m4egTt61DYISbN/SkJyF
=TZ7H
-----END PGP SIGNATURE-----

--O2MNiMdv5xfEWa4wh6S9qqglPnN888qdG--
