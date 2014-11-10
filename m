From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] Ceph on RHEL 7 using teuthology
Date: Mon, 10 Nov 2014 08:33:45 +0100
Message-ID: <54606A59.8050608@dachary.org>
References: <CAFUgD7imyVMGnavAhdJ0-t+1k=JLd8YW5XpSj0uW+p7bpmg=vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oO7IILdisFn0BAOAqiIpfxkAjsu42JmAa"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33967 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751707AbaKJHd5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 02:33:57 -0500
In-Reply-To: <CAFUgD7imyVMGnavAhdJ0-t+1k=JLd8YW5XpSj0uW+p7bpmg=vw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sarang G <2639431@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oO7IILdisFn0BAOAqiIpfxkAjsu42JmAa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[moving the thread to ceph-devel]

Hi,

It would be useful if you could upload the full log somewhere and provide=
 details about what you did on the machine prior to seeing this error. Th=
at would help figure out what is wrong.

Cheers

On 10/11/2014 07:20, Sarang G wrote:
> Hi,=20
>=20
> I am trying to install ceph on RHEL 7 AWS instance using teuthology.
>=20
> I am facing some dependency issues:
>=20
> 2014-11-09 22:10:57,269.269 DEBUG:teuthology.orchestra.run:Running [10.=
15.17.91]: 'sudo yum install ceph-radosgw-0.87 -y'
> 2014-11-09 22:10:58,223.223 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: Loaded plugins: amazon-id, rhui-lb
> 2014-11-09 22:10:59,008.008 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: Resolving Dependencies
> 2014-11-09 22:10:59,010.010 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Running transaction check
> 2014-11-09 22:10:59,010.010 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package ceph-radosgw.x86_64 1:0.87-665.gb8ec7d7.el7 will be =
installed
> 2014-11-09 22:10:59,028.028 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: librados2 =3D 1:0.87-665.gb8ec7d7.el7 =
for package: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,086.086 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: ceph-common =3D 1:0.87-665.gb8ec7d7.el=
7 for package: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,088.088 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: librados.so.2()(64bit) for package: 1:=
ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,089.089 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: libfcgi.so.0()(64bit) for package: 1:c=
eph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,089.089 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Running transaction check
> 2014-11-09 22:10:59,090.090 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package ceph-common.x86_64 1:0.87-665.gb8ec7d7.el7 will be i=
nstalled
> 2014-11-09 22:10:59,103.103 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: python-ceph =3D 1:0.87-665.gb8ec7d7.el=
7 for package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: librbd1 =3D 1:0.87-665.gb8ec7d7.el7 fo=
r package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: libtcmalloc.so.4()(64bit) for package:=
 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: librbd.so.1()(64bit) for package: 1:ce=
ph-common-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: libboost_thread-mt.so.1.53.0()(64bit) =
for package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: libboost_system-mt.so.1.53.0()(64bit) =
for package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package ceph-radosgw.x86_64 1:0.87-665.gb8ec7d7.el7 will be =
installed
> 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: libfcgi.so.0()(64bit) for package: 1:c=
eph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package librados2.x86_64 1:0.87-665.gb8ec7d7.el7 will be ins=
talled
> 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Running transaction check
> 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package boost-system.x86_64 0:1.53.0-18.el7 will be installe=
d
> 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package boost-thread.x86_64 0:1.53.0-18.el7 will be installe=
d
> 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package ceph-common.x86_64 1:0.87-665.gb8ec7d7.el7 will be i=
nstalled
> 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: libtcmalloc.so.4()(64bit) for package:=
 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package ceph-radosgw.x86_64 1:0.87-665.gb8ec7d7.el7 will be =
installed
> 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Processing Dependency: libfcgi.so.0()(64bit) for package: 1:c=
eph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
> 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package librbd1.x86_64 1:0.87-665.gb8ec7d7.el7 will be insta=
lled
> 2014-11-09 22:10:59,258.258 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: ---> Package python-ceph.x86_64 1:0.87-665.gb8ec7d7.el7 will be i=
nstalled
> 2014-11-09 22:10:59,376.376 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]: --> Finished Dependency Resolution
> 2014-11-09 22:10:59,385.385 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]:  You could try using --skip-broken to work around the problem
> 2014-11-09 22:10:59,873.873 INFO:teuthology.orchestra.run.out:[10.15.17=
=2E91]:  You could try running: rpm -Va --nofiles --nodigest
> 2014-11-09 22:10:59,900.900 ERROR:teuthology.parallel:Exception in para=
llel execution
> Traceback (most recent call last):
>   File "/home/pras/storm-1-0-test/qe/teuthology/teuthology/parallel.py"=
, line 82, in __exit__
>=20
>=20
> Please let me know if there are any modules to be installed before star=
ting teuthology?
>=20
> Regards,
> Pras
>=20
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre




--oO7IILdisFn0BAOAqiIpfxkAjsu42JmAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRgalkACgkQ8dLMyEl6F20srACgusQERkZ6bzSJiXyTZPAulZ18
wrwAniFwr0bUXP3nuG5CmXsc5dIYzWIT
=fYmo
-----END PGP SIGNATURE-----

--oO7IILdisFn0BAOAqiIpfxkAjsu42JmAa--
