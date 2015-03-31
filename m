From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph disk
Date: Tue, 31 Mar 2015 22:02:33 +0200
Message-ID: <551AFD59.70209@dachary.org>
References: <ruevn0vmi9p4p1m5biuhx7sc.1427804698773@email.android.com> <1427827660.6486.7.camel@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GoWISoa4Tlkx0X38Ibc38XTf1sIdEOBl4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39881 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754620AbbCaUCg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Mar 2015 16:02:36 -0400
In-Reply-To: <1427827660.6486.7.camel@debian>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kewaan Ejaz <kewaan.ejaz@office.nacamar.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GoWISoa4Tlkx0X38Ibc38XTf1sIdEOBl4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[cc'ing ceph-devel public mailing list]

Hi,

On 31/03/2015 20:47, Kewaan Ejaz wrote:
> Hello Loic,
>=20
> Thank you again for the opportunity to contribute to ceph. I am not sur=
e
> how am I suppose to proceed but I have the following things in mind;

Thanks for proposing to help :-)

> 1) Fully understanding the ceph-disk code
> 2) I would start using the ceph-disk in my sandbox environment
> (Virtualbox)

You'll find that it's fairly straightforward: one file, all in it. There =
is room for improvement.

https://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/ceph-disk.sh are=
 the tests that make check will run=20
https://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/ceph-disk-root.s=
h are the tests that make check will run if ./configure --enable-root-mak=
e-check is used but you can also run one manually with cd src ; sudo test=
/ceph-disk.sh test_activate_dev and it will use the /dev/loop device to s=
imulate a disk. A few sanity checks were added recently to verify that th=
e loop device has been loaded with the necessary loop.max_part=3D16 (or m=
ore) parameter and that /dev/disk/part-byuuid is populated as expected.=20

> I think I would require a week to get back to you. But other than that,=

> let me know what kind of VM do you have in mind. For example,
>=20
> 1) What kind of OS would you prefer from the Openstack cluster?

I feel more confortable with Debian or Ubuntu but CentOS or Fedora are al=
so fine. What is required for test purposes is a dedicated tenant with th=
e ability to run two virtual machines, 1GB RAM, 10GB disk, 1core. We woul=
d need a variety of images to test against (Ubuntu 12.04 + 14.04, Debian =
jessie, CentOS 7 + 6, Fedora 20 + 21, OpenSUSE 13.2).

> 2) We are not using Cinder or Swift in our Openstack cluster. Is that a=

> Problem?

That will be fine: the loop device can be used as a spare disk instead of=
 provisioning one with cinder.=20

As soon as you can have that OpenStack tenant ready, it can be used with =
https://github.com/osynge/whatenv to run tests for https://github.com/cep=
h/ceph/pull/4036 and verify that the detection system actually works as e=
xpected.=20

And once it's done, we could make it so this test is run whenever a pull =
request is posted that modifies ceph-disk and ensure we're not risking a =
regression. It would be a very valuable service. Not too CPU intensive ei=
ther since we're not seeing more than a few patches on ceph-disk every mo=
nth.

Cheers

> Best Regards,
> Kewaan.


--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--GoWISoa4Tlkx0X38Ibc38XTf1sIdEOBl4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUa/VkACgkQ8dLMyEl6F22d1ACgv5Z04MvLPmkECNFWMODfLjzO
UlwAoKxstCtNviXsKnYwRXmLGYG6AWz9
=jbdb
-----END PGP SIGNATURE-----

--GoWISoa4Tlkx0X38Ibc38XTf1sIdEOBl4--
