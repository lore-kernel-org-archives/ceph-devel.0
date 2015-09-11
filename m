From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot failures (2 hours today)
Date: Fri, 11 Sep 2015 17:12:21 +0200
Message-ID: <55F2EF55.3030405@dachary.org>
References: <55F2D137.9090401@dachary.org> <CAL-2WbF9TuPK_H5kTu9jVxRjgQg9P8B2zvjgcibeyubYhkgAWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VSMjmSnPXI3LCsGlQGjjQEU2TeQ6mGWSV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53861 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875AbbIKPMX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 11:12:23 -0400
In-Reply-To: <CAL-2WbF9TuPK_H5kTu9jVxRjgQg9P8B2zvjgcibeyubYhkgAWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gryniewicz <dang@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VSMjmSnPXI3LCsGlQGjjQEU2TeQ6mGWSV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11/09/2015 15:53, Daniel Gryniewicz wrote:
> Maybe periodically run git gc on the clone out-of-line?  Git runs it
> occasionally when it thinks it's necessary, and that can take a while
> on large and/or fragmented repos.

I did git prune + git gc on the clone on both sides (receiving and sendin=
g) but it did not help. But I did dig deeper than that.

>=20
> Daniel
>=20
> On Fri, Sep 11, 2015 at 9:03 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ceph,
>>
>> The make check bot failed a number of pull request verifications today=
=2E Each of them was notified as false negative (you should have received=
 a short note if your pull request is concerned). The problem is now fixe=
d[1] and all should be back to normal. If you want to schedule another ru=
n, you just need to rebase your pull request and re-push it, the bot will=
 notice.
>>
>> Sorry for the inconvenience and thanks for your patience :-)
>>
>> P.S. I'm not sure what it was exactly. Just that git fetch took too lo=
ng to answer and failed. Reseting the git clone from which the bot works =
fixed the problem. It happened a few times in the past but did not show u=
p in the past six month or so.
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


--VSMjmSnPXI3LCsGlQGjjQEU2TeQ6mGWSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXy71UACgkQ8dLMyEl6F20sSACePPdf6XlcolZe/+cwg/TM9wK4
kXQAoIErCHOcW3VCsj8AJrWZS6x3gpDJ
=5sAh
-----END PGP SIGNATURE-----

--VSMjmSnPXI3LCsGlQGjjQEU2TeQ6mGWSV--
