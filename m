From: Loic Dachary <loic@dachary.org>
Subject: Re: Removing disks / OSDs
Date: Wed, 23 Oct 2013 08:29:43 +0200
Message-ID: <52676CD7.50509@dachary.org>
References: <52655309.8070500@dachary.org>	<CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com>	<52661776.20803@dachary.org> <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="h3GmfHE8J0sgJKGTa7mrt2tib8ko1xfG1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:43716 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3JWG3t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Oct 2013 02:29:49 -0400
In-Reply-To: <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3GmfHE8J0sgJKGTa7mrt2tib8ko1xfG1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 22/10/2013 19:26, Gregory Farnum wrote:
> On Mon, Oct 21, 2013 at 11:13 PM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>>
>> On 21/10/2013 18:49, Gregory Farnum wrote:
>>> I'm not quite sure what questions you're actually asking here...
>>> In general, the OSD is not removed from the system without explicit
>>> admin intervention. When it is removed, all traces of it should be
>>> zapped (including its key), so it can't reconnect.
>>> If it hasn't been removed, then indeed it will continue working
>>> properly even if moved to a different box.
>>
>> If there is an external journal, the device containing the journal nee=
ds to be moved with the device containing the data. If I read ceph/src/up=
start/ceph-osd.conf correctly, when the data device is plugged in the new=
 machine it will fail to start because the journal is not there yet. When=
 the journal device is plugged in, the ceph-osd.conf would be called beca=
use udev rule in ceph/udev/95-ceph-osd.rules call ceph-disk activate-jour=
nal.
>>
>> Is my understanding correct ?
>=20
> Well, after being wrong last time I'm a little reluctant to make
> pronouncements from memory, but that definitely sounds correct to me.
> :) If I were doing an audit I'd want to look at what happens if there
> is a wrong journal in the correct location, etc.

Thanks. It makes things real simple from the configuration point of view =
:-)

Cheers

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--h3GmfHE8J0sgJKGTa7mrt2tib8ko1xfG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJnbNcACgkQ8dLMyEl6F23BcACeOkO1kXt6onnqINyRSlxtPlZF
VZcAmQEp39OaW0qWRuNvEUTc5FqFn9Ep
=tTMq
-----END PGP SIGNATURE-----

--h3GmfHE8J0sgJKGTa7mrt2tib8ko1xfG1--
