From: Loic Dachary <loic@dachary.org>
Subject: Re: librados AIO problem diagnostic
Date: Wed, 01 Oct 2014 10:33:33 +0200
Message-ID: <542BBC5D.8080304@dachary.org>
References: <542BA6D4.4070207@dachary.org> <1412148537.6822.11.camel@sebmain.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2tLR1mD5Hfw1eK5DakwcXaGqog54o2KU7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35590 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750782AbaJAIdk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 04:33:40 -0400
In-Reply-To: <1412148537.6822.11.camel@sebmain.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Ponce <sebastien.ponce@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2tLR1mD5Hfw1eK5DakwcXaGqog54o2KU7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Which kernel are you running accord to uname -a ? I have:

Linux 0a2ad46b4fb5 3.13.0-23-generic #45-Ubuntu SMP Fri Apr 4 06:58:38 UT=
C 2014 x86_64 x86_64 x86_64 GNU/Linux

On 01/10/2014 09:28, Sebastien Ponce wrote:
> Thanks for this effort !
> I'll look at all that this afternoon (it's mid morning here).
> Concerning configure and autogen, I do the standard (naive ?)
> "./autogen.sh; ./configure; make" given by the readme.
>=20
> Sebastien
>=20
>=20
> On Wed, 2014-10-01 at 09:01 +0200, Loic Dachary wrote:
>> Hi Sebastien,
>>
>> In the context of http://tracker.ceph.com/issues/9356 I'm trying to co=
llect as much information as I can in an environment that can be reconstr=
ucted to avoid interferences. Could you please let me know which ./config=
ure line you are using ? Or which do_autogen.sh command you are using.
>>
>> Thanks in advance :-)
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2tLR1mD5Hfw1eK5DakwcXaGqog54o2KU7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQrvF0ACgkQ8dLMyEl6F226UACfXqVktWi/1FIa3XN71clmRbp6
mk4AnjxVel1t0T1pANjYRBRLe2bs1Iop
=jFIs
-----END PGP SIGNATURE-----

--2tLR1mD5Hfw1eK5DakwcXaGqog54o2KU7--
