From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: Feedback: default FS pools and newfs behavior
Date: Mon, 26 May 2014 22:57:33 +0200
Message-ID: <E3137601-1032-4942-B692-1C128FC140AD@enovance.com>
References: <CAGd4Wr21kmRhJz=uXw4EgLY_UK2NoLMj3e7qKmN3+=ukHa8FdQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/signed; boundary="Apple-Mail=_A630AC40-18D4-4C19-B7BC-FEB73F83A946"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:47964 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbaEZVPH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 May 2014 17:15:07 -0400
In-Reply-To: <CAGd4Wr21kmRhJz=uXw4EgLY_UK2NoLMj3e7qKmN3+=ukHa8FdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_A630AC40-18D4-4C19-B7BC-FEB73F83A946
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi John,

Thanks for you work!
=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

On 21 May 2014, at 17:32, John Spray <john.spray@inktank.com> wrote:

> In response to #8010[1], I'm looking at making it possible to
> explicitly disable CephFS, so that the (often unused) filesystem pools
> don't hang around if they're unwanted.
>=20
> The administrative behavior would change such that:
> * To enable the filesystem it is necessary to create two pools and
> use "ceph newfs <metadata> <data>"
> * There's a new "ceph rmfs" command to disable the filesystem and
> allow removing its pools
> * Initially, the filesystem is disabled and the 'data' and 'metadata'
> pools are not created by default
>=20
> There's an initial cut of this on a branch:
> https://github.com/ceph/ceph/commits/wip-nullfs
>=20
> Questions:
> * Are there strong opinions about whether the CephFS pools should
> exist by default?  I think it makes life simpler if they don't,
> avoiding "what the heck is the 'data' pool?" type questions from
> newcomers.

+1

> * Is it too unfriendly to require users to explicitly create pools
> before running newfs, or do we need to auto-create pools when they run
> newfs?  Auto-creating some pools from newfs is a bit awkward
> internally because it requires modifying both OSD and MDS maps in one
> command.

I believe it is legitimate to create these 2 pools. Having this part of =
the process looks good to me.

The only question I have is: why don=92t we have a similar behaviour for =
the RBD pool?
Usually even if you need RBD, you will create another pool that matches =
a use case.

Cheers.

>=20
> Cheers,
> John
>=20
> 1. http://tracker.ceph.com/issues/8010
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_A630AC40-18D4-4C19-B7BC-FEB73F83A946
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTg6q9AAoJECPrkYfpbtGTiZYH/j3r5xvm7/1r79Oc9UB0e4FI
eeLBy8eik1XIXlX0Q7JIeY4UKmK72TtwpHPSuOGlC2plG05XiwhKU154aEwHDdpZ
E4JD1Yark+YikCJHD4qtmwlOUEsIg/BpeAB3LCMDlzzhF1r8kgUdVL0rn107XNDV
Ax/jITHFCX/DbwX4Z/aKOBg0Bj+ariX+KJBS0bYCV8kSC60DVY7lgEjFsrlFIwed
tSL5zdpig/kndVqH4pIqdbGpgI2tDgrt+Irw7nwWJaBaP7H1P436fpo6G/CbM4px
hbZnz2j31CvhNuHkAzZPZWYmhhmXsHIxyHEt6NWv03il1j7Zz/AHGqPHcYBjiNw=
=bzGM
-----END PGP SIGNATURE-----

--Apple-Mail=_A630AC40-18D4-4C19-B7BC-FEB73F83A946--
