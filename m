From: Loic Dachary <loic@dachary.org>
Subject: Re: librados AIO problem diagnostic
Date: Wed, 01 Oct 2014 10:31:35 +0200
Message-ID: <542BBBE7.4000806@dachary.org>
References: <542BA6D4.4070207@dachary.org> <1412148537.6822.11.camel@sebmain.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="f5jue9OHDQ2m1MmbJidjNveD012sbB3Lp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35584 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbaJAIbn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 04:31:43 -0400
In-Reply-To: <1412148537.6822.11.camel@sebmain.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Ponce <sebastien.ponce@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f5jue9OHDQ2m1MmbJidjNveD012sbB3Lp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/10/2014 09:28, Sebastien Ponce wrote:
> Thanks for this effort !
> I'll look at all that this afternoon (it's mid morning here).

Same here : I'm in Paris ;-)

> Concerning configure and autogen, I do the standard (naive ?)
> "./autogen.sh; ./configure; make" given by the readme.

Could you try with

=2E/autogen.sh ; ./configure --disable-static --with-debug CC=3D'ccache g=
cc' CXX=3D'ccache g++' CFLAGS=3D"-Wall -g" CXXFLAGS=3D"-Wall -g" ; make

and let me know if you see a problem when running

cd src
rm -fr dev out ;  mkdir -p dev ; CEPH_NUM_MON=3D1 CEPH_NUM_OSD=3D3 ./vsta=
rt.sh -d -n -X -l mon osd
=2E/ceph_test_rados_striper_api_aio

I'm trying with your "./configure" on my end to check if this changes som=
ething.

It's going to be a fun one ;-)

Cheers

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


--f5jue9OHDQ2m1MmbJidjNveD012sbB3Lp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQru+cACgkQ8dLMyEl6F20iigCfc1DVb1sz2Q7FUv2brDGkSzLU
Bd8An07sWRQoDZmA0f6NdTEiGVAUGg7m
=2nXQ
-----END PGP SIGNATURE-----

--f5jue9OHDQ2m1MmbJidjNveD012sbB3Lp--
