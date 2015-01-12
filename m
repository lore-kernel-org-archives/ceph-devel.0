From: Loic Dachary <loic@dachary.org>
Subject: Re: Testing the next giant release
Date: Mon, 12 Jan 2015 15:23:29 +0100
Message-ID: <54B3D8E1.8020907@dachary.org>
References: <54AD3C8B.4030705@dachary.org> <54AE5066.2000102@dachary.org> <54AEABE8.9030605@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kBvJ8Qt8eXgplUOIlGIrTHibhhJB3QlUn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37328 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750991AbbALOXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 09:23:32 -0500
In-Reply-To: <54AEABE8.9030605@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kBvJ8Qt8eXgplUOIlGIrTHibhhJB3QlUn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

I analyzed the errors from the rbd run at http://pulpito.ceph.com/loic-20=
15-01-08_10:36:47-rbd-giant-backports-testing-basic-vps/ and summarized m=
y findings in the description of http://tracker.ceph.com/issues/10501

It would be great if you could let me know if these look familiar. They a=
ll seem to relate to something that's not from the backports, except for =
http://tracker.ceph.com/issues/10513 because it looks new.

Cheers

On 08/01/2015 17:10, Loic Dachary wrote:
> Hi Tamil,
>=20
> The test completed with a number of failures. I compared them with the =
latest giant / rbd run (which is on the red hat private lab). The number =
of failure is comparable (40 failed out of 102 january 6th 2015). However=
 the failures are mostly different and I'm not sure what to do next.
>=20
> http://pulpito.ceph.redhat.com/teuthology-2015-01-06_02:00:01-rbd-giant=
-distro-basic-magna/ shows
>=20
> Command failed on magna094 with status 1: 'sudo yum install ceph-radosg=
w-0.87 -y'=20
>=20
> (a number of times)
>=20
> Command failed on magna065 with status 1: 'adjust-ulimits ceph-coverage=
 /home/ubuntu/cephtest/archive/coverage daemon-helper term qemu-system-x8=
6_64 -enable-kvm -nographic -m 4096 -drive file=3D/home/ubuntu/cephtest/q=
emu/base.client.0.qcow2,format=3Dqcow2,if=3Dvirtio -cdrom /home/ubuntu/ce=
phtest/qemu/client.0.iso -fsdev local,id=3Dlog,path=3D/home/ubuntu/cephte=
st/archive/qemu/client.0,security_model=3Dnone -device virtio-9p-pci,fsde=
v=3Dlog,mount_tag=3Dtest_log -drive file=3Drbd:rbd/client.0.0:id=3D0,form=
at=3Draw,if=3Dvirtio,cache=3Dwritethrough -drive file=3Drbd:rbd/client.0.=
1:id=3D0,format=3Draw,if=3Dvirtio,cache=3Dwritethrough'
>=20
> (a few times).
>=20
> On 08/01/2015 10:39, Loic Dachary wrote:
>> Hi,
>>
>> The giant-backports branch has been built by gitbuilders tonight
>>
>> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basi=
c/#origin/giant-backports
>> etc.
>>
>> and I scheduled a rbd suite with
>>
>> ./virtualenv/bin/teuthology-suite --teuthology-branch giant --suite rb=
d --suite-branch giant --machine-type vps --distro ubuntu --email loic@da=
chary.org --owner loic@dachary.org  --ceph giant-backports
>>
>> which shows at
>>
>> http://pulpito.ceph.com/loic-2015-01-08_10:36:47-rbd-giant-backports-t=
esting-basic-vps/
>>
>> To be continued !
>>
>> On 07/01/2015 15:02, Loic Dachary wrote:
>>> Hi Tamil,
>>>
>>> I've merged / integrated the giant backports found at
>>>
>>> https://github.com/ceph/ceph/pull/3186
>>> https://github.com/ceph/ceph/pull/3178
>>> https://github.com/ceph/ceph/pull/2954
>>> https://github.com/ceph/ceph/pull/3191
>>> https://github.com/ceph/ceph/pull/3168
>>> https://github.com/ceph/ceph/pull/3289
>>>
>>> into=20
>>>
>>> http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6710f4694=
54ab3f964bfa7c9d2
>>>
>>> and successfully ran make check on it
>>>
>>> http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backports
>>>
>>> If I'm not mistaken the next step would be to run teuthology. If I'm =
to do it, would you be so kind as to let me know which suites are most re=
levant ? If someone else will take care of it, should I push the integrat=
ion branch somewhere ?
>>>
>>> Cheers
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--kBvJ8Qt8eXgplUOIlGIrTHibhhJB3QlUn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSz2OEACgkQ8dLMyEl6F22+HgCfdyN4/ZtSex/580TsfDZFnmQ2
vN4An0+EPQ20n8R120HCC7dbj/lesaSI
=R+4H
-----END PGP SIGNATURE-----

--kBvJ8Qt8eXgplUOIlGIrTHibhhJB3QlUn--
