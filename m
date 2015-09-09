From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk pyudev implementation
Date: Wed, 09 Sep 2015 13:03:41 +0200
Message-ID: <55F0120D.7080300@dachary.org>
References: <9E914F5BD7F48A4782456CEB550A422824EC8564@SACMBXIP02.sdcorp.global.sandisk.com> <55EFE129.8030502@dachary.org> <9E914F5BD7F48A4782456CEB550A422824EC86DC@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="528Eo29Dj6NWUQAhEIIHSkblTTkjGsK4h"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52417 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751886AbbIILDq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 07:03:46 -0400
In-Reply-To: <9E914F5BD7F48A4782456CEB550A422824EC86DC@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--528Eo29Dj6NWUQAhEIIHSkblTTkjGsK4h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Inline as well

On 09/09/2015 12:37, Chaitanya Huilgol wrote:
> Inline
>=20
>> -----Original Message-----
>> From: Loic Dachary [mailto:loic@dachary.org]
>> Sent: Wednesday, September 09, 2015 1:05 PM
>> To: Chaitanya Huilgol; Ceph Development
>> Subject: Re: ceph-disk pyudev implementation
>>
>> Hi,
>>
>> The approach you describe makes sense to me. And you've done a nice jo=
b
>> with the refactor.
>>
>> I'm not familiar with pyudev though and other Ceph developers may alre=
ady
>> have an opinion (or answers). When adding new dependencies to Ceph, I
>> think we need to assert how stable / reliable those dependencies are. =
How
>> well tested do you think it is ?
>> https://github.com/pyudev/pyudev/blob/master/Vagrantfile suggests ther=
e
>> are tests with good coverage, https://github.com/pyudev/pyudev/pulls a=
nd
>> https://github.com/pyudev/pyudev/issues?q=3Dis%3Aopen+is%3Aissue have
>> few open issues and a number of resolved ones. The timeline is a bit s=
trange
>> : a burst of recent commits and a large gap back to 2012. But maybe it=
's
>> widely used and this really is not a concern ?
>>
>=20
> Did not hit any pyudev issues in our tests, but cannot comment on the o=
verall stability.
> Almost all major distros package this and hence inferred that it must b=
e stable enough.
> However, there is no list of projects using this package in the project=
 site, but lot of references and downloads https://crate.io/packages/pyud=
ev/#history
>=20

On Ubuntu 14.04 there is one package depending on pyudev.

loic@fold:~$ apt-cache rdepends python-pyudev
python-pyudev
Reverse Depends:
  solaar

>=20
>> Is there a particular reason why you did not re-use the json format fo=
r ceph-
>> disk list ?
>>
> Its ported from a slightly dated giant version, will add this when port=
ing to master

Ha, cool.

>> Could you make your new ceph-disk into a pull request so that it can r=
un
>> integration tests ?
>=20
> Yes, will merge it with master and send out a pull request after tests.=


I suggest you create the pull request even before testing anything. Such =
a large refactor is easier to handle with baby steps. I think we will end=
 up splitting your pull request in a series of smaller pull request that =
can gradually be integrated in the existing code base.

It's very exciting to go in this direction and I look forward to a better=
 codebase for ceph-disk :-)

Cheers

>>
>> Cheers
>>
>> On 09/09/2015 08:52, Chaitanya Huilgol wrote:
>>> Hi Loic,
>>>
>>> As discussed in the multipath tracker, please find the port of ceph-d=
isk
>> which is based on pyudev (https://pyudev.readthedocs.org/en/latest/
>> python libudev binding)
>>>
>>> Here is a short summary on the approach:
>>> - Current ceph-disk determines various properties on block device by =
path
>> string manipulations and /sys/dev properties
>>> - These are difficult to implement and fragile for device types such =
as DM
>> multipath.
>>> - Since different code needs to be added based on the device type, a =
Block
>> device class based approach has been used.
>>> - Based on the device type supplied a block device object is instanti=
ated
>> (currently GenericBlockDev or DMBlockDev).
>>> - Each class implements device specific functionality as an implement=
ation
>> of the abstract BlockDevBase base class.
>>>         a. Get partition device from base device
>>>         b. Get base device from partition
>>>         c. Get Part UUID and Type
>>>         d. Determine if device path is partition
>>>         e. Determine if device is referenced
>>>          f. Get HW sector size
>>>         g. List partitions
>>>
>>> In Prepare/Activate/List code paths, the required device object is
>> instantiated and hence these code paths remain clean
>>>
>>> This port also support multipath devices with the DMBlockDev Class.
>>>
>>> https://github.com/chaitanyahuilgol/ceph-disk-udev.git
>>>
>>> Let us know your thoughts.
>>>
>>> Regards,
>>> Chaitanya
>>>
>>>
>>> ________________________________
>>>
>>> PLEASE NOTE: The information contained in this electronic mail messag=
e is
>> intended only for the use of the designated recipient(s) named above. =
If the
>> reader of this message is not the intended recipient, you are hereby n=
otified
>> that you have received this message in error and that any review,
>> dissemination, distribution, or copying of this message is strictly pr=
ohibited. If
>> you have received this communication in error, please notify the sende=
r by
>> telephone or e-mail (as shown above) immediately and destroy any and a=
ll
>> copies of this message in your possession (whether hard copies or
>> electronically stored copies).
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. =
If the reader of this message is not the intended recipient, you are here=
by notified that you have received this message in error and that any rev=
iew, dissemination, distribution, or copying of this message is strictly =
prohibited. If you have received this communication in error, please noti=
fy the sender by telephone or e-mail (as shown above) immediately and des=
troy any and all copies of this message in your possession (whether hard =
copies or electronically stored copies).
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--528Eo29Dj6NWUQAhEIIHSkblTTkjGsK4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXwEg0ACgkQ8dLMyEl6F23CbwCgtOqilXwoxCRq+eCWioa85MfD
FTgAoI+Bo2GgHxc0pA9f4wHeY6ovpISO
=syGO
-----END PGP SIGNATURE-----

--528Eo29Dj6NWUQAhEIIHSkblTTkjGsK4h--
