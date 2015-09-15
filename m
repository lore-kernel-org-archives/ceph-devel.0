From: Loic Dachary <loic@dachary.org>
Subject: Re: [Hammer Backports] Status of https://github.com/ceph/ceph/pull/5888
Date: Tue, 15 Sep 2015 13:06:24 +0200
Message-ID: <55F7FBB0.4040605@dachary.org>
References: <CAP3mxSx8ziqAhQH58eEim1MvwSj6f-A0bBkEey_YA7AtkZCLCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Hcx9vTeUSjM6FLkmQRv4odT3giDdIMjlM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55671 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751423AbbIOLG1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 07:06:27 -0400
In-Reply-To: <CAP3mxSx8ziqAhQH58eEim1MvwSj6f-A0bBkEey_YA7AtkZCLCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>, abhishek.lekshmanan@gmail.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ncutler@suse.cz

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hcx9vTeUSjM6FLkmQRv4odT3giDdIMjlM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/09/2015 12:36, Abhishek Varshney wrote:
> Hi Loic/Abhishek,
>=20
> Here are a few backport PRs which I created and some of them have run-m=
ake-check failures. I have tried to triage them and this is the summary o=
f what I could make of. It would be nice if you can have a look at them a=
nd help me in how to proceed ahead with them.
>=20
>   * https://github.com/ceph/ceph/pull/5888 run-make-check status FAILUR=
E
>       o It may require commit 90e5f410ee35a614e1d49771226064d012d8b85e =
to be in hammer, as per my understanding.
>=20

This is probably non trivial: you could ask for help with a pull request =
comment like:

@XinzeChi this commit does not apply cleanly, would you mind taking a loo=
k ?

http://jenkins.ceph.dachary.org/job/ceph/LABELS=3Dcentos-7&&x86_64/7703/c=
onsole
<pre>
osd/ReplicatedPG.cc:11761:76: error: expected '}' at end of input
 void intrusive_ptr_release(ReplicatedPG::RepGather *repop) { repop->put(=
); }
                                                                         =
   ^
osd/ReplicatedPG.cc:11761:76: error: expected '}' at end of input
</pre>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Hcx9vTeUSjM6FLkmQRv4odT3giDdIMjlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX3+7AACgkQ8dLMyEl6F20JYACeLuTq2uKu2W4hKkd6MKqYQh6N
UukAn0WPg1O05G0woVmkZzw3wr1RtYTq
=C72x
-----END PGP SIGNATURE-----

--Hcx9vTeUSjM6FLkmQRv4odT3giDdIMjlM--
