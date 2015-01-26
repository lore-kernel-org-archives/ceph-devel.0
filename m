From: Loic Dachary <loic@dachary.org>
Subject: Re: upcoming dumpling v0.67.12
Date: Mon, 26 Jan 2015 18:49:48 +0100
Message-ID: <54C67E3C.1030303@dachary.org>
References: <54C65F3D.5020200@dachary.org> <CAJBxG-u=ffbwSkwdtiUM7NSnGdnaXjb_VOmOVfkA8LTX9ANYWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nCTKaB4x2hR0E1vDgenRReS9VFwGD9wOc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47305 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756168AbbAZRtv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 12:49:51 -0500
In-Reply-To: <CAJBxG-u=ffbwSkwdtiUM7NSnGdnaXjb_VOmOVfkA8LTX9ANYWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nCTKaB4x2hR0E1vDgenRReS9VFwGD9wOc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for letting me know about the upgrade tests results, it's encourag=
ing :-) I'll let you know when the tests make progress.

On 26/01/2015 18:00, Yuri Weinstein wrote:
> Loic,
>=20
> Thanks for the update.
> I ran upgrade/dumpling last week (and all 42 jobs passed in octo and
> sepia) to establish a base line.  And today running another one,
> assuming it will pick up the already merged pull requests.
>=20
> Let me know when you ready for next steps.
>=20
> Thx
> YuriW
>=20
> On Mon, Jan 26, 2015 at 7:37 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Yuri,
>>
>> Here is a short update on the progress of the upcoming dumpling v0.67.=
12.
>>
>> It is tracked with http://tracker.ceph.com/issues/10560. In the invent=
ory part, there is a list of all pull requests that are already merged in=
 the dumpling branch. There only is one pull request waiting to be merged=
 and three issues waiting for backports. While these last three are being=
 worked on, I started rbd, rgw and rados suites.
>>
>> I chose to display the inventory by pull request because I figured it =
would be more convenient to read because sometimes a single pull request =
spans multiple issues ( https://github.com/ceph/ceph/pull/2611 for instan=
ce fixes two issues ).
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nCTKaB4x2hR0E1vDgenRReS9VFwGD9wOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTGfjwACgkQ8dLMyEl6F23exwCgtBMM26pSVu17bu2oAW3v6oeq
u8kAnjajVxnonzI+QMceJSzFY7hlkYks
=WaK0
-----END PGP SIGNATURE-----

--nCTKaB4x2hR0E1vDgenRReS9VFwGD9wOc--
