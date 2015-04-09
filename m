From: Loic Dachary <loic@dachary.org>
Subject: Re: Call for jenkins slaves to improve multi operating system support
Date: Thu, 09 Apr 2015 14:55:50 +0200
Message-ID: <552676D6.9040206@dachary.org>
References: <55250954.1010305@dachary.org> <A9F57F2ABA6BB2469F01E127557C6C9B112CC572@SHSMSX104.ccr.corp.intel.com> <55252DEE.105@dachary.org> <A9F57F2ABA6BB2469F01E127557C6C9B112D04C9@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1aoee67HqILSCGwflULOItv0vmGbp1p11"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44051 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751613AbbDIM4A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Apr 2015 08:56:00 -0400
In-Reply-To: <A9F57F2ABA6BB2469F01E127557C6C9B112D04C9@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Duan, Jiangang" <jiangang.duan@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1aoee67HqILSCGwflULOItv0vmGbp1p11
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/04/2015 12:30, Duan, Jiangang wrote:
> Got you.
> Let me see if we can help - it may take some time - we have the servers=
 but need find some people to set it up.=20

Thanks a lot, I'm looking forward to that :-)

> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Wednesday, April 08, 2015 9:33 PM
> To: Duan, Jiangang; Ceph Development
> Subject: Re: Call for jenkins slaves to improve multi operating system =
support
>=20
>=20
>=20
> On 08/04/2015 15:21, Duan, Jiangang wrote:
>> Loric,
>>
>> do you mean we need give the servers to you or we just build the testi=
ng inside our own server room to do all the testing?
>=20
> Thanks for asking, I realize that was not clear.=20
>=20
> The idea is not to donate hardware, because that would require manpower=
 and extra costs to connect to the net.=20
>=20
> What would be useful is a machine connected to the net and dedicated to=
 running a jenkins slave. It receives a build from the jenkins master (ht=
tp://jenkins.ceph.dachary.org/) via ssh (possibly with a tunnel if behind=
 a NAT), clone http://github.com/ceph/ceph, execute the run-make-check.sh=
 script that is found at the root of the repository and reports failure /=
 success back to the jenkins master.
>=20
> Does that make sense ?
>=20
>>
>> -jiangang
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.k=
ernel.org] On Behalf Of Loic Dachary
>> Sent: Wednesday, April 08, 2015 6:56 PM
>> To: Ceph Development
>> Subject: Call for jenkins slaves to improve multi operating system sup=
port
>>
>> Hi Ceph,
>>
>> When a contribution is proposed to Ceph [1], a bot compiles and run te=
sts with it to provide feedback to the developer [2]. When something goes=
 wrong the failure can be repeated on the developer machine [3] for debug=
=2E This also helps the reviewer who knows the code compiles and does not=
 break anything that would be detected by "make check".
>>
>> The bot runs on CentOS 7 and Ubuntu 14.04 only, and problems related t=
o older operating systems (headers, compiler version, etc.) may be detect=
ed later, when building packages [4] and after the pull request has been =
merged in master. This is rare but requires extra attention from the revi=
ewer and needs to be dealt with urgently when it happens.
>>
>> If you can spare a machine to help expand the operating systems on whi=
ch tests can run, it would be a great help. The minimum hardware configur=
ation to run a slave is:
>>
>> *  x86_64 architecture for CentOS 6, Fedora 21, OpenSUSE 13.2, Debian =
GNU/Linux Jessie, Ubuntu 14.02
>>
>>   32 GB RAM
>>   200 GB SSD
>>   8 core > 2.5Ghz
>>
>> *  i386 architecture for CentOS 7, CentOS 6, Fedora 21, Debian GNU/Lin=
ux Jessie, Ubuntu 14.04, Ubuntu 14.02
>>
>>   4 GB RAM
>>   200 GB disk
>>   2 core
>>
>> *  armv7, armv8 architecture for Ubuntu 14.04
>>
>>   4 GB RAM
>>   200 GB disk
>>   2 core=20
>>
>> Note that since the make check bot can run in a docker container, x86_=
64 machines can be used to run any of the operating systems for which a d=
ocker file has been prepared [5].
>>
>> Cheers
>>
>> [1] pull requests https://github.com/ceph/ceph/pulls
>> [2] make check bot feedback https://github.com/ceph/ceph/pull/4296#iss=
uecomment-90812064
>> [3] run-make-check.sh https://github.com/ceph/ceph/blob/master/run-mak=
e-check.sh#L44
>> [4] gitbuilder http://ceph.com/gitbuilder.cgi [5] https://ceph.com/git=
/?p=3Dceph.git;a=3Dblob;f=3Dsrc/test/Makefile.am;hb=3Dhammer#l91
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1aoee67HqILSCGwflULOItv0vmGbp1p11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUmdtYACgkQ8dLMyEl6F21BCQCcCj4eMPpJurVWcbThu9S9iS2c
n2MAn3seGBRQ4XPXT2cCSrF1GvpsysHU
=zdXT
-----END PGP SIGNATURE-----

--1aoee67HqILSCGwflULOItv0vmGbp1p11--
