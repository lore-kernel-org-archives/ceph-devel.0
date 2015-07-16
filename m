From: Sebastien Han <seb@redhat.com>
Subject: Re: CephX key/secret generation
Date: Thu, 16 Jul 2015 17:32:36 +0200
Message-ID: <3500AC92-FA9E-4E99-B09F-F052FFA2833A@redhat.com>
References: <CACEfbZhXSNp0_WxyX2mwSeg2rdEdYSfVbGDZsrHKqPvAGa7oBQ@mail.gmail.com> <alpine.DEB.2.00.1507160745010.8878@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: multipart/signed; boundary="Apple-Mail=_D9614197-EED5-433A-968A-D484280E7AD1"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbbGPPc1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jul 2015 11:32:27 -0400
In-Reply-To: <alpine.DEB.2.00.1507160745010.8878@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Andrew Woodward <xarses@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_D9614197-EED5-433A-968A-D484280E7AD1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Awesome I=E2=80=99ve been looking for something similar for ceph-ansible =
too :)

> On 16 Jul 2015, at 16:46, Sage Weil <sage@newdream.net> wrote:
>=20
> Hi Andrew,
>=20
> On Wed, 15 Jul 2015, Andrew Woodward wrote:
>> Hi, I'm looking for help understanding how the cephx auth keys are
>> generated. I want to pre-create the keys for the cluster within my
>> deployment engine. It appears that we can use `ceph-athtool
>> --gen-print-key` in order to generate the keys and use them, however
>> the application runs inside a container and it seems silly to 150mb =
of
>> deps to get access to ceph-authtool.
>>=20
>> Looking through the code at a basic level, I see that it's calling
>> some AES functions, however it quickly goes over my ability to read =
C.
>>=20
>> Can some one go over the key construction requirements? Can we use =
any
>> string encoded with base64? Is the AES encoding needed? What is the
>> correct formula for the AES generation? It looks like the have the
>> same seed but I'm having problems reading it out of the code.
>=20
> Here's a bit of python to do it:
>=20
> 	=
https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/new.py#L21
>=20
> Hope that helps!
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers.
=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Senior Cloud Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris


--Apple-Mail=_D9614197-EED5-433A-968A-D484280E7AD1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJVp86VAAoJELTV9b7anxYRwzIQAL+PtJpQjAsfKnjsgFxBqTvg
z4DKX9Y06K1DDnvZB6hp7zVpbfi0vJiTRbzd39xrUxhoVl2yZG+sxDA9xISpBGca
BN5Vyl6d4+7TVmF0GT8lckMNitbMx0d664cNJ5/qLM0O90ueJsVY9LytEqXksto1
ZF0FqQUzu7L/6mqHhoivBlE3DRYfkWieylC+V8CwXnOH1sNgTruQTNKX+uU+3smM
P8TZhXM3wWDqexf+kk23gu2zGqsK+JJXh9rqoH5UfCA98apeiHSC+qo7yBJToiYC
2V/xUXXE5+BwTTAwQwzJL08ZVDMESWk7Q0Mug8zA26drJGZbhAdMPvJw2W0kuBrm
kmmvlfRN2BAzc231JjPzauDWYqkJrLSQJpiV5gx/HdpyYXBM5MHkyajAT9q35fry
KTl4sSJH6fz2AvzgbuaQ2WYUwN7Aj7AQU8y++2JltTL4qFwKU2yiqYIPjjz0N9qb
NncWgG4L7N5SHCmm8sr91a0forbIe0HS1jSw0at4jvMCoWs2sCJIILFGrwbPz3F6
yPmXjhvz39t2TtfbGedUuoXfmFX95kdra2aFORn3f7v97rwNyopENV3Pfl5diqJd
OPcO6XEmvdoorxeZQ7AEQw8juVB/3mD0xlNq6a2Wm+/d1NIPVw+cm/uUoq76D90/
B5cxZnq9N/bKBfoUJwbJ
=V2m5
-----END PGP SIGNATURE-----

--Apple-Mail=_D9614197-EED5-433A-968A-D484280E7AD1--
