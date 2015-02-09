From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next dumpling release
Date: Mon, 09 Feb 2015 14:10:25 +0100
Message-ID: <54D8B1C1.6060106@dachary.org>
References: <54D3F0E5.8060906@dachary.org> <974116011.8222626.1423177154743.JavaMail.zimbra@redhat.com> <54D3F7C5.6030701@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HLmoX4530bsIkNqfBrOl48rOlRck8qQcc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41082 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755759AbbBINK2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 08:10:28 -0500
In-Reply-To: <54D3F7C5.6030701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HLmoX4530bsIkNqfBrOl48rOlRck8qQcc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

Your backport of https://github.com/ceph/ceph/commit/a9dd4af401328e8f9071=
dee52470a0685ceb296b at https://github.com/ceph/ceph/pull/3645 was added =
to the dumpling-backports branch and the RGW suite run came back green.

http://tracker.ceph.com/issues/10560#teuthology-runs-on-3944c77c404c4a058=
86fe8276d5d0dd7e4f20410-6-february

I should add that because of environmental instability (IMHO) I ran the s=
uite twice. That produced at least one successful run of each job. For th=
e record the first run is:

http://tracker.ceph.com/issues/10560#teuthology-runs-on-b5e871fe027db3b25=
f9129ae3e5b2326a89467c5-6-february

Do you think rgw is ready for the next dumpling point release ?

Cheers


On 06/02/2015 00:07, Loic Dachary wrote:
> Thanks !
>=20
> On 05/02/2015 23:59, Yehuda Sadeh-Weinraub wrote:
>>
>> ----- Original Message -----
>>> From: "Loic Dachary" <loic@dachary.org>
>>> To: "Yehuda Sadeh" <yehuda@redhat.com>
>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Sent: Thursday, February 5, 2015 2:38:29 PM
>>> Subject: rgw and the next dumpling release
>>>
>>> Hi Yehuda,
>>>
>>> The rados teuthology suite for the next dumpling release as found in
>>> https://github.com/ceph/ceph/commits/dumpling-backports came back gre=
en
>>> http://pulpito.ceph.com/loic-2015-02-03_14:46:09-rgw-dumpling-backpor=
ts---basic-multi/.
>>> Do you think it is ready for QE to start their own round of testing ?=

>>>
>>
>> We should also backport a9dd4af401328e8f9071dee52470a0685ceb296b to du=
mpling. I think I saw a dumpling run failing due to the lack of this one,=
 and since we now run on environments that use apache 2.4. Looking at thi=
s commit, it's not going to be applied trivially, so I'm preparing one fo=
r dumpling now.
>>
>> Yehuda
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--HLmoX4530bsIkNqfBrOl48rOlRck8qQcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTYscEACgkQ8dLMyEl6F2244gCfbuQGAL6YPQXEC3pmuSC25i3+
Te0An2zHUk9Bmjcx4yujWknA9BokvlU5
=2G6E
-----END PGP SIGNATURE-----

--HLmoX4530bsIkNqfBrOl48rOlRck8qQcc--
