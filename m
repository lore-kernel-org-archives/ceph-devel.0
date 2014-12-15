From: Loic Dachary <loic@dachary.org>
Subject: Re: Recovery long tail investigation
Date: Mon, 15 Dec 2014 18:30:21 +0100
Message-ID: <548F1AAD.7030701@dachary.org>
References: <548B61F5.3010305@redhat.com> <5F401C8095B99D4FABC1B919C1BE599A0121CBD94B@EXMBNJE1.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FpjQEQTpP59Vxv50IE4lpBDgKBjSLmRPo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53339 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750712AbaLORaZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 12:30:25 -0500
In-Reply-To: <5F401C8095B99D4FABC1B919C1BE599A0121CBD94B@EXMBNJE1.ad.twosigma.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vit Yenukas <Vit.Yenukas@twosigma.com>
Cc: Sheldon Mustard <sheldon.mustard@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FpjQEQTpP59Vxv50IE4lpBDgKBjSLmRPo
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Thanks for the update, that helps :-)

On 15/12/2014 18:18, Vit Yenukas wrote:
> Hi Loic,
>=20
> It was set to default (i.e. =3D=3D 10 for v0.80.5 as well, IIRC) - we d=
idn't=20
> think that it'd help the "long tail" problem to tweak it.
>=20
> On 12/12/2014 04:45 PM, Loic Dachary wrote:
>=20
>> In the context of http://tracker.ceph.com/issues/9566 do you remember =
what the value of max_backfills was ? https://github.com/ceph/ceph/blob/g=
iant/src/common/config_opts.h#L409 It probably makes a difference if it i=
s set to 1 instead of the default.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--FpjQEQTpP59Vxv50IE4lpBDgKBjSLmRPo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSPGq4ACgkQ8dLMyEl6F23CfgCeMCDmAktgNY1vBRMjzYhMpnZZ
0jgAn3vlrPMjOpdMGd84ldpEDtra+w/1
=lcu/
-----END PGP SIGNATURE-----

--FpjQEQTpP59Vxv50IE4lpBDgKBjSLmRPo--
