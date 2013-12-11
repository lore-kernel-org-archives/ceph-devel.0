From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 11 Dec 2013 13:28:28 +0100
Message-ID: <52A85A6C.9050709@dachary.org>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch> <523C40B7.5060902@dachary.org> <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net> <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch> <52826E2D.2040503@dachary.org> <52A5F3A1.503@dachary.org>,<52A6D41A.3060205@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6A9C22@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EwQHlGUJqE7e0G76T1jITHDqh4bbNLXBj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:37072 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab3LKM23 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 07:28:29 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6A9C22@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EwQHlGUJqE7e0G76T1jITHDqh4bbNLXBj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 11/12/2013 10:49, Andreas Joachim Peters wrote:> Hi Loic,=20
> I am a little bit confused which kind of tool you actually want. You wa=
nt a simple benchmark to check for degradation or you want a full profile=
r tool?
>=20

I was not sure, hence the confusion.

> Most of the external tools have the problem that you measure the whole =
thing including buffer allocation and initialization. We probably don't w=
ant to measure how long it takes to allocate memory and write random numb=
ers into it.=20
>=20
> I would just o:
>=20
> < prepare memory>
> <take CPU/realtime>
> < run algorithm >
> <take CPU/realtime>
> < print result>
>=20

Ok, I'll do that.=20

I'm glad I learnt about the other tools in the process, even if only to c=
onclude that they are not needed.=20

Cheers

> Now one can also add to run the perf-stat tool after <prepare memory> a=
nd start it from within the test program pointing to the PID running <run=
 alogorithm>, so the benchmark would be:
>=20
> < prepare memory>
> < take CPU/realtime>
> < fork=3D>"perf stat -p <mypid>";
> < run algorithm n times>
> < take CPU/realtime>
> < SIGINT to fork>
> < print results>
>=20
> As an extension one could also add to have <run algorithm> with <n> thr=
eads in a thread pool.
>=20
> Cheers Andreas.
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--EwQHlGUJqE7e0G76T1jITHDqh4bbNLXBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKoWmwACgkQ8dLMyEl6F22zvACggZnjm9bjwCpRbioo2w2IAsAx
184An1Cobn1eRgyiFXuP8Y7qADUBjeTz
=l3dW
-----END PGP SIGNATURE-----

--EwQHlGUJqE7e0G76T1jITHDqh4bbNLXBj--
