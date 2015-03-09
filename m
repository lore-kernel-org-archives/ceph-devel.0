From: Loic Dachary <loic@dachary.org>
Subject: Re: advice on adding the rhel6-server-optional repo
Date: Mon, 09 Mar 2015 19:32:50 +0100
Message-ID: <54FDE752.2040706@dachary.org>
References: <54FB59A7.8080304@dachary.org> <54FDDC71.8090307@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cHDAWxO29Kb2j0cRHpNwPEjrSdmGiffsx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55311 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752449AbbCIScx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 14:32:53 -0400
In-Reply-To: <54FDDC71.8090307@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cHDAWxO29Kb2j0cRHpNwPEjrSdmGiffsx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

Thanks for the detailed explanation. I updated https://github.com/ceph/ce=
ph/pull/3871 accordingly (I think ;-)

Cheers

On 09/03/2015 18:46, Ken Dreyer wrote:
> On 03/07/2015 01:03 PM, Loic Dachary wrote:
>>
>> which I eventually found in [rhel6-server-optional] as installed
>> with http://tracker.ceph.com/issues/11061#note-2
>>
>> How do you suggest I script this in
>> https://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dinstall-deps.sh so peo=
ple
>> don't worry about it ?
>>
>=20
> Hi Loic,
>=20
> Thanks for asking. I've replied in the ticket
> (http://tracker.ceph.com/issues/11061).
>=20
> - Ken
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--cHDAWxO29Kb2j0cRHpNwPEjrSdmGiffsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT951MACgkQ8dLMyEl6F21KHQCdGvKkKJlS4Slq3QHq7Loi9MH1
HsgAn0Cqw5vHHvqILeXwgl7GB9K8cAcm
=P3oM
-----END PGP SIGNATURE-----

--cHDAWxO29Kb2j0cRHpNwPEjrSdmGiffsx--
