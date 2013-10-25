From: Loic Dachary <loic@dachary.org>
Subject: Re: Removing disks / OSDs
Date: Fri, 25 Oct 2013 15:11:09 +0200
Message-ID: <526A6DED.8090202@dachary.org>
References: <52655309.8070500@dachary.org> <CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com> <52661776.20803@dachary.org> <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com> <alpine.DEB.2.00.1310221029580.29488@cobra.newdream.net> <5267D30D.9080201@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Rgow8rom1EOKpQX7grKi107Up9MgJlbSE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46243 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab3JYNLL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Oct 2013 09:11:11 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 58DC326399
	for <ceph-devel@vger.kernel.org>; Fri, 25 Oct 2013 15:11:09 +0200 (CEST)
In-Reply-To: <5267D30D.9080201@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rgow8rom1EOKpQX7grKi107Up9MgJlbSE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

If a disk containing an OSD is moved to another host, it is entirely poss=
ible that the objects it contains are violating a crush rule imposing tha=
t no object is replicated on the same host. Will this be taken care of as=
 a side effect of updating the place of the OSD in the map ( https://gith=
ub.com/ceph/ceph/blob/v0.61.9/src/upstart/ceph-osd.conf#L29 ) ?=20

Cheers

On 23/10/2013 15:45, Loic Dachary wrote:
> Hi,
>=20
> As a conclusion to this thread and also because I realized that most pe=
ople are unaware of the level of automation provided by ceph / udev, I ju=
st posted a quick summary : http://dachary.org/?p=3D2428
>=20
> Cheers
>=20
> On 22/10/2013 19:31, Sage Weil wrote:
>> On Tue, 22 Oct 2013, Gregory Farnum wrote:
>>> On Mon, Oct 21, 2013 at 11:13 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>>>
>>>>
>>>> On 21/10/2013 18:49, Gregory Farnum wrote:
>>>>> I'm not quite sure what questions you're actually asking here...
>>>>> In general, the OSD is not removed from the system without explicit=

>>>>> admin intervention. When it is removed, all traces of it should be
>>>>> zapped (including its key), so it can't reconnect.
>>>>> If it hasn't been removed, then indeed it will continue working
>>>>> properly even if moved to a different box.
>>>>
>>>> If there is an external journal, the device containing the journal n=
eeds to be moved with the device containing the data. If I read ceph/src/=
upstart/ceph-osd.conf correctly, when the data device is plugged in the n=
ew machine it will fail to start because the journal is not there yet. Wh=
en the journal device is plugged in, the ceph-osd.conf would be called be=
cause udev rule in ceph/udev/95-ceph-osd.rules call ceph-disk activate-jo=
urnal.
>>>>
>>>> Is my understanding correct ?
>>>
>>> Well, after being wrong last time I'm a little reluctant to make
>>> pronouncements from memory, but that definitely sounds correct to me.=

>>
>> Yep, that's how it's supposed to work.  The activate-journal piece is =

>> somewhat recent though (I think maybe it wasn't in place for cuttlefis=
h?).
>>
>>> :) If I were doing an audit I'd want to look at what happens if there=

>>> is a wrong journal in the correct location, etc.
>>
>> The ceph-osd will fail on start because the uuid/fsid doesn't match.
>>
>> sage
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--Rgow8rom1EOKpQX7grKi107Up9MgJlbSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJqbe0ACgkQ8dLMyEl6F23j2QCeK5ZOMNyz83U9wvM9b2eakLnN
qg8AoIKYh1Aro/u72EzTJZznl0/1PnqL
=XBzW
-----END PGP SIGNATURE-----

--Rgow8rom1EOKpQX7grKi107Up9MgJlbSE--
