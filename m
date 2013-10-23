From: Loic Dachary <loic@dachary.org>
Subject: Re: Removing disks / OSDs
Date: Wed, 23 Oct 2013 15:45:49 +0200
Message-ID: <5267D30D.9080201@dachary.org>
References: <52655309.8070500@dachary.org> <CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com> <52661776.20803@dachary.org> <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com> <alpine.DEB.2.00.1310221029580.29488@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5Qv1EHAESuSB8NckcLrbx8iLW8t5PamDm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:44086 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab3JWNpw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Oct 2013 09:45:52 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 3059C26396
	for <ceph-devel@vger.kernel.org>; Wed, 23 Oct 2013 15:45:50 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1310221029580.29488@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Qv1EHAESuSB8NckcLrbx8iLW8t5PamDm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

As a conclusion to this thread and also because I realized that most peop=
le are unaware of the level of automation provided by ceph / udev, I just=
 posted a quick summary : http://dachary.org/?p=3D2428

Cheers

On 22/10/2013 19:31, Sage Weil wrote:
> On Tue, 22 Oct 2013, Gregory Farnum wrote:
>> On Mon, Oct 21, 2013 at 11:13 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>
>>>
>>> On 21/10/2013 18:49, Gregory Farnum wrote:
>>>> I'm not quite sure what questions you're actually asking here...
>>>> In general, the OSD is not removed from the system without explicit
>>>> admin intervention. When it is removed, all traces of it should be
>>>> zapped (including its key), so it can't reconnect.
>>>> If it hasn't been removed, then indeed it will continue working
>>>> properly even if moved to a different box.
>>>
>>> If there is an external journal, the device containing the journal ne=
eds to be moved with the device containing the data. If I read ceph/src/u=
pstart/ceph-osd.conf correctly, when the data device is plugged in the ne=
w machine it will fail to start because the journal is not there yet. Whe=
n the journal device is plugged in, the ceph-osd.conf would be called bec=
ause udev rule in ceph/udev/95-ceph-osd.rules call ceph-disk activate-jou=
rnal.
>>>
>>> Is my understanding correct ?
>>
>> Well, after being wrong last time I'm a little reluctant to make
>> pronouncements from memory, but that definitely sounds correct to me.
>=20
> Yep, that's how it's supposed to work.  The activate-journal piece is=20
> somewhat recent though (I think maybe it wasn't in place for cuttlefish=
?).
>=20
>> :) If I were doing an audit I'd want to look at what happens if there
>> is a wrong journal in the correct location, etc.
>=20
> The ceph-osd will fail on start because the uuid/fsid doesn't match.
>=20
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--5Qv1EHAESuSB8NckcLrbx8iLW8t5PamDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJn0w0ACgkQ8dLMyEl6F20CTgCfQ1XUne2DB2UT+UcMcUHNzN03
Ev4AoIuC4tyKv/dtB1ccd8U93hPsf/p6
=Bk//
-----END PGP SIGNATURE-----

--5Qv1EHAESuSB8NckcLrbx8iLW8t5PamDm--
