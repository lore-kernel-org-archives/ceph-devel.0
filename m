From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph disk
Date: Tue, 07 Apr 2015 15:20:30 +0200
Message-ID: <5523D99E.3010106@dachary.org>
References: <ruevn0vmi9p4p1m5biuhx7sc.1427804698773@email.android.com>	 <1427827660.6486.7.camel@debian> <551AFD59.70209@dachary.org> <1428412676.22152.101.camel@NAC>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="atPFNJRl4p6WlVf6La2E26EV6HJ7dhpNB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42756 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755863AbbDGNUd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 09:20:33 -0400
In-Reply-To: <1428412676.22152.101.camel@NAC>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kewaan Ejaz <kewaan.ejaz@office.nacamar.de>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--atPFNJRl4p6WlVf6La2E26EV6HJ7dhpNB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/04/2015 15:17, Kewaan Ejaz wrote:
>=20
> Hi Folks,
>=20
> Sorry for the lack of updates from my side. Actually, we had a few cras=
hes in our openstack cluster (nothing out of the norm) but due to easter =
holidays, manpower has been quite tight. I am also working on recovering/=
setting up those lost compute nodes to make the resources available for o=
ur environment. I will update you all
> once the pressure is gone. Thanks for your understanding!

Thanks for the update !

>=20
> Best Regards,
> Kewaan.
> On Tue, 2015-03-31 at 22:02 +0200, Loic Dachary wrote:
>> [cc'ing ceph-devel public mailing list]
>>
>> Hi,
>>
>> On 31/03/2015 20:47, Kewaan Ejaz wrote:
>>> Hello Loic,
>>>
>>> Thank you again for the opportunity to contribute to ceph. I am not s=
ure
>>> how am I suppose to proceed but I have the following things in mind;
>>
>> Thanks for proposing to help :-)
>>
>>> 1) Fully understanding the ceph-disk code
>>> 2) I would start using the ceph-disk in my sandbox environment
>>> (Virtualbox)
>>
>> You'll find that it's fairly straightforward: one file, all in it. The=
re is room for improvement.
>>
>> https://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/ceph-disk.sh =
are the tests that make check will run=20
>> https://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/ceph-disk-roo=
t.sh are the tests that make check will run if ./configure --enable-root-=
make-check is used but you can also run one manually with cd src ; sudo t=
est/ceph-disk.sh test_activate_dev and it will use the /dev/loop device t=
o simulate a disk. A few sanity checks were added recently to verify that=
 the loop device has been loaded with the necessary loop.max_part=3D16 (o=
r more) parameter and that /dev/disk/part-byuuid is populated as expected=
=2E=20
>>
>>> I think I would require a week to get back to you. But other than tha=
t,
>>> let me know what kind of VM do you have in mind. For example,
>>>
>>> 1) What kind of OS would you prefer from the Openstack cluster?
>>
>> I feel more confortable with Debian or Ubuntu but CentOS or Fedora are=
 also fine. What is required for test purposes is a dedicated tenant with=
 the ability to run two virtual machines, 1GB RAM, 10GB disk, 1core. We w=
ould need a variety of images to test against (Ubuntu 12.04 + 14.04, Debi=
an jessie, CentOS 7 + 6, Fedora 20 + 21, OpenSUSE 13.2).
>>
>>> 2) We are not using Cinder or Swift in our Openstack cluster. Is that=
 a
>>> Problem?
>>
>> That will be fine: the loop device can be used as a spare disk instead=
 of provisioning one with cinder.=20
>>
>> As soon as you can have that OpenStack tenant ready, it can be used wi=
th https://github.com/osynge/whatenv to run tests for https://github.com/=
ceph/ceph/pull/4036 and verify that the detection system actually works a=
s expected.=20
>>
>> And once it's done, we could make it so this test is run whenever a pu=
ll request is posted that modifies ceph-disk and ensure we're not risking=
 a regression. It would be a very valuable service. Not too CPU intensive=
 either since we're not seeing more than a few patches on ceph-disk every=
 month.
>>
>> Cheers
>>
>>> Best Regards,
>>> Kewaan.
>>
>>
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--atPFNJRl4p6WlVf6La2E26EV6HJ7dhpNB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUj2Z4ACgkQ8dLMyEl6F21U9ACgr5ucrtWAncPU/tWsYcW0QYHW
xXUAoLb53TFk7+rW58vnhr06j9i58GNi
=IN8Q
-----END PGP SIGNATURE-----

--atPFNJRl4p6WlVf6La2E26EV6HJ7dhpNB--
