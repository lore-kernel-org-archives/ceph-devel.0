From: Loic Dachary <loic@dachary.org>
Subject: Re: Keeping up with the backports
Date: Thu, 19 Mar 2015 16:44:13 +0100
Message-ID: <550AEECD.1000201@dachary.org>
References: <550AE0D9.8080107@dachary.org> <CABYiri8cCavc0LqG8OAb_Obxpr51nKnwXTaLhwX639vUXECurQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XhUkg24Q8RSBRQ0J7Ff9wbVDopUEEwkLu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32782 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750932AbbCSPoQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 11:44:16 -0400
In-Reply-To: <CABYiri8cCavc0LqG8OAb_Obxpr51nKnwXTaLhwX639vUXECurQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XhUkg24Q8RSBRQ0J7Ff9wbVDopUEEwkLu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On 19/03/2015 15:53, Andrey Korolyov wrote:
> On Thu, Mar 19, 2015 at 5:44 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Alistair & Jean-Charles,
>>
>> Thanks a lot for volunteering to work on the backports !
>>
>> I have good news: the backlog of backports is almost empty. New backpo=
rts are being added every day and we are going to make sure they are hand=
led on a weekly basis so that point releases can be published every month=
 or so, if needed. To start small and learn as we make progress, I propos=
e to mentor you on a given point release, starting with cherry-picking ba=
ckports and preparing an integration branch as described at http://tracke=
r.ceph.com/projects/ceph-releases/wiki/Wiki (which is linked from the htt=
p://tracker.ceph.com/projects/ceph-releases/ landing page). The idea is t=
hat once you feel confortable you can keep going on your own.
>>
>> If you agree we can arrange an IRC meeting next week to bootstrap that=
=2E Since we have multiple stable releases in flight at any given time, i=
t can conveniently be parallelized. If that's ok with you, Alistair could=
 start with Firefly and Jean-Charles with Dumpling.
>>
>> Please let me know if you have any question :-)
>>
>> Cheers
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
> Hi Loic,
>=20
> Sage said recently that dumpling will be a less likely target to
> receive backports in a near future, was the point changed since then?

Dumpling was published about 18 month ago and that was its expected life =
time. Therefore, yes, in theory Dumpling 0.67.12 ( http://tracker.ceph.co=
m/issues/10560 ) is likely to be the last point release. It's however the=
 first LTS to reach "end of life" and I guess we may have another one, in=
 case an interesting backport shows up.

> Or Dumpling will be still maintained but only by a community effort?

If someone from the community is willing to make that commitment to Dumpl=
ing, I'll help her/him as much as I can. I also think it would make sense=
 for the Ceph project to provide the technical infrastructure for that, b=
ut it's not a discussion we had yet. For instance say there are 15 intere=
sting patches pending for Firefly in three years from now. The teuthology=
/package building/release publishing machinery for Firefly could be saved=
 somewhere for the benefit of someone willing to revive them and publish =
a new Firefly version.=20

It could be argued that it does not make sense to keep going after the en=
d of life of a stable release. But it's not true in some cases, as can be=
 seen for instance with qemu where a some release are packaged on so many=
 patches that it looks like a new release. I guess Ceph will be facing th=
at kind of challenges in the near future.

Cheers

> Thanks!
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--XhUkg24Q8RSBRQ0J7Ff9wbVDopUEEwkLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUK7s0ACgkQ8dLMyEl6F21ZCACffrFeQdIL2+/kKRIYlQ+TXhjq
QbMAniADMF/XQsD4SMKOxqvja9JakzVI
=ONBG
-----END PGP SIGNATURE-----

--XhUkg24Q8RSBRQ0J7Ff9wbVDopUEEwkLu--
