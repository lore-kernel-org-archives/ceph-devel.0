From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer is frozen
Date: Fri, 06 Feb 2015 14:06:30 +0100
Message-ID: <54D4BC56.9070402@dachary.org>
References: <alpine.DEB.2.00.1502041242400.27042@cobra.newdream.net> <870DE8DBB716524BAE51B2D499EC81E40AA6BE81@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DTGxlrO24niHHpq5M35IK0g8LQ4SAUI5j"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39879 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752756AbbBFNGg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 08:06:36 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA6BE81@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DTGxlrO24niHHpq5M35IK0g8LQ4SAUI5j
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

In my opinion this should have been merged: it was ready before the featu=
re freeze.

Cheers

On 06/02/2015 13:25, Miyamae, Takeshi wrote:
> Hi Sage,
>=20
>> If there is something exceptional that hasn't made it in yet and is lo=
w-risk,
>> plea your case,
>=20
> We would like to contribute our following code to the nearest stable re=
lease
> Hammer, and we believe that our code has sufficiently low risk.
>=20
>  mSHEC : multiple Shingled Erasure Code #3534
>  https://github.com/ceph/ceph/pull/3534
>=20
> One of the reasons why we think it has low risk is that we have already=

> finished extended tests shown below assuming a product use case.
>=20
>  Test items done:
>   * erasure code plugin I/F tests (TestErasureCodeShec.cc)
>   * exhaustive parity layouts tests (TestErasureCodeShec_all.cc)
>   * thread safety tests (TestErasureCodeShec_thread.cc)
>   * tests on a real ceph cluster
>      - pool creation/deletion
>      - read/write
>      - recovery (up to N multiple failures)
>=20
> Another reason is that the code is just a plugin, which is completely
> isolated from the core of Ceph and has no risks for users who do not
> need to use it.
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Sage Weil
> Sent: Thursday, February 5, 2015 5:51 AM
> To: ceph-devel@vger.kernel.org
> Subject: hammer is frozen
>=20
> I created the branch on Monday, but am traveling and forgot to send an =
email.  This means we're not merging new features until we have a handle =
on the testing and the QA results are looking good.
>=20
> Specifically:
>=20
> - There is a 'hammer' ceph.git branch.  Please target any bug fixes at
>   this.
>=20
> - The 'next' branch is deleted for the time being (see above)
>=20
> - Do not merge any new features to master; not yet.  It's too confusing=

>   and we have enough work to do stabilizing things.
>=20
> - There are still several pull requests open that are bug fixes and tar=
get
>   master that should get merged once they are tested, so we will probab=
ly
>   merge hammer and master together periodically to avoid doing all the
>   merged manually.  (Another reason not to merge any new code into mast=
er
>   that does not target hammer.)
>=20
> - We're using the 'hammer' milestone on github to track what to pay
>   attention to.  Please help keep it in sync with the open pull
>   requests that are hammer-bound vs future work for infernalis.
>=20
> If there is something exceptional that hasn't made it in yet and is low=
-risk, plea your case, but no promises.  Bribery in the form of fixes for=
 open bugs can be effective.  :)
>=20
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo info =
at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--DTGxlrO24niHHpq5M35IK0g8LQ4SAUI5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTUvFYACgkQ8dLMyEl6F20qdgCdGfzCTiTCTzxgRmW/6OsgOlsA
UF4An07RH42uri7tteqZrDorq/HFraIN
=PKox
-----END PGP SIGNATURE-----

--DTGxlrO24niHHpq5M35IK0g8LQ4SAUI5j--
