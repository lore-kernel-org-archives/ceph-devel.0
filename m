From: Loic Dachary <loic@dachary.org>
Subject: Re: Testing the next giant release
Date: Thu, 08 Jan 2015 17:10:16 +0100
Message-ID: <54AEABE8.9030605@dachary.org>
References: <54AD3C8B.4030705@dachary.org> <54AE5066.2000102@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="B7qdEWvsn6iudMePD9UleJpuGugCwdmgO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35441 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753877AbbAHQKS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jan 2015 11:10:18 -0500
In-Reply-To: <54AE5066.2000102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B7qdEWvsn6iudMePD9UleJpuGugCwdmgO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tamil,

The test completed with a number of failures. I compared them with the la=
test giant / rbd run (which is on the red hat private lab). The number of=
 failure is comparable (40 failed out of 102 january 6th 2015). However t=
he failures are mostly different and I'm not sure what to do next.

http://pulpito.ceph.redhat.com/teuthology-2015-01-06_02:00:01-rbd-giant-d=
istro-basic-magna/ shows

Command failed on magna094 with status 1: 'sudo yum install ceph-radosgw-=
0.87 -y'=20

(a number of times)

Command failed on magna065 with status 1: 'adjust-ulimits ceph-coverage /=
home/ubuntu/cephtest/archive/coverage daemon-helper term qemu-system-x86_=
64 -enable-kvm -nographic -m 4096 -drive file=3D/home/ubuntu/cephtest/qem=
u/base.client.0.qcow2,format=3Dqcow2,if=3Dvirtio -cdrom /home/ubuntu/ceph=
test/qemu/client.0.iso -fsdev local,id=3Dlog,path=3D/home/ubuntu/cephtest=
/archive/qemu/client.0,security_model=3Dnone -device virtio-9p-pci,fsdev=3D=
log,mount_tag=3Dtest_log -drive file=3Drbd:rbd/client.0.0:id=3D0,format=3D=
raw,if=3Dvirtio,cache=3Dwritethrough -drive file=3Drbd:rbd/client.0.1:id=3D=
0,format=3Draw,if=3Dvirtio,cache=3Dwritethrough'

(a few times).

On 08/01/2015 10:39, Loic Dachary wrote:
> Hi,
>=20
> The giant-backports branch has been built by gitbuilders tonight
>=20
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basic=
/#origin/giant-backports
> etc.
>=20
> and I scheduled a rbd suite with
>=20
> ./virtualenv/bin/teuthology-suite --teuthology-branch giant --suite rbd=
 --suite-branch giant --machine-type vps --distro ubuntu --email loic@dac=
hary.org --owner loic@dachary.org  --ceph giant-backports
>=20
> which shows at
>=20
> http://pulpito.ceph.com/loic-2015-01-08_10:36:47-rbd-giant-backports-te=
sting-basic-vps/
>=20
> To be continued !
>=20
> On 07/01/2015 15:02, Loic Dachary wrote:
>> Hi Tamil,
>>
>> I've merged / integrated the giant backports found at
>>
>> https://github.com/ceph/ceph/pull/3186
>> https://github.com/ceph/ceph/pull/3178
>> https://github.com/ceph/ceph/pull/2954
>> https://github.com/ceph/ceph/pull/3191
>> https://github.com/ceph/ceph/pull/3168
>> https://github.com/ceph/ceph/pull/3289
>>
>> into=20
>>
>> http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6710f46945=
4ab3f964bfa7c9d2
>>
>> and successfully ran make check on it
>>
>> http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backports
>>
>> If I'm not mistaken the next step would be to run teuthology. If I'm t=
o do it, would you be so kind as to let me know which suites are most rel=
evant ? If someone else will take care of it, should I push the integrati=
on branch somewhere ?
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--B7qdEWvsn6iudMePD9UleJpuGugCwdmgO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSuq+gACgkQ8dLMyEl6F219nACfYZCwHj+FDmezrMx6mE1C8iVg
c2sAoIzHT6hsli72h9gsd5Kzf0BB2jsU
=Tk5b
-----END PGP SIGNATURE-----

--B7qdEWvsn6iudMePD9UleJpuGugCwdmgO--
