From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] Ceph on RHEL 7 using teuthology
Date: Mon, 10 Nov 2014 10:30:21 +0100
Message-ID: <546085AD.9030204@dachary.org>
References: <CAFUgD7imyVMGnavAhdJ0-t+1k=JLd8YW5XpSj0uW+p7bpmg=vw@mail.gmail.com>	<54606A59.8050608@dachary.org> <CAFUgD7jUfKjwkujMfHdy3-m+r44gFdjqa6hf2XzS5Fjte6HF4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QsePo7gF7Wvwu3VuCu7eWegi6aLCgemS5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34013 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752425AbaKJJa3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 04:30:29 -0500
In-Reply-To: <CAFUgD7jUfKjwkujMfHdy3-m+r44gFdjqa6hf2XzS5Fjte6HF4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sarang G <2639431@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QsePo7gF7Wvwu3VuCu7eWegi6aLCgemS5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

It looks like there are broken packages on the target machine even before=
 teuthology tries to install new packages. Do you see similar errors when=
 trying to install a package manually ?

Cheers

On 10/11/2014 09:59, Sarang G wrote:
> Hi,=20
>=20
> 1. Created an instance on AWS using AMI: ami-99bef1a9
> 2. All the settings related to root access to sudo, passwordless ssh wa=
s configured.
> 3. started teuthology with basic yaml configuration:
>=20
> check-locks: false
> os_type: rhel
> os_version: '7.0'
> roles:
> - - mon.a
>   - mon.b
>   - mon.c
>   - osd.0
>   - osd.1
>   - osd.2
>   - client.0
> suite_path: /home/pras/ceph-qa-suite
> targets:
>   <user>@<hostname>: ssh-rsa <ssh-key>
>=20
> tasks:
> - install: null
> - ceph: null
> - interactive: null
>=20
> Teuthology log attached.
>=20
> ~Pras
>=20
>=20
>=20
>=20
> On Mon, Nov 10, 2014 at 1:03 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     [moving the thread to ceph-devel]
>=20
>     Hi,
>=20
>     It would be useful if you could upload the full log somewhere and p=
rovide details about what you did on the machine prior to seeing this err=
or. That would help figure out what is wrong.
>=20
>     Cheers
>=20
>     On 10/11/2014 07:20, Sarang G wrote:
>     > Hi,
>     >
>     > I am trying to install ceph on RHEL 7 AWS instance using teutholo=
gy.
>     >
>     > I am facing some dependency issues:
>     >
>     > 2014-11-09 22:10:57,269.269 DEBUG:teuthology.orchestra.run:Runnin=
g [10.15.17.91]: 'sudo yum install ceph-radosgw-0.87 -y'
>     > 2014-11-09 22:10:58,223.223 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: Loaded plugins: amazon-id, rhui-lb
>     > 2014-11-09 22:10:59,008.008 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: Resolving Dependencies
>     > 2014-11-09 22:10:59,010.010 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Running transaction check
>     > 2014-11-09 22:10:59,010.010 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package ceph-radosgw.x86_64 1:0.87-665.gb8ec7d7.el7 wi=
ll be installed
>     > 2014-11-09 22:10:59,028.028 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: librados2 =3D 1:0.87-665.gb8ec7d=
7.el7 for package: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,086.086 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: ceph-common =3D 1:0.87-665.gb8ec=
7d7.el7 for package: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,088.088 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: librados.so.2()(64bit) for packa=
ge: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,089.089 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: libfcgi.so.0()(64bit) for packag=
e: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,089.089 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Running transaction check
>     > 2014-11-09 22:10:59,090.090 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package ceph-common.x86_64 1:0.87-665.gb8ec7d7.el7 wil=
l be installed
>     > 2014-11-09 22:10:59,103.103 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: python-ceph =3D 1:0.87-665.gb8ec=
7d7.el7 for package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: librbd1 =3D 1:0.87-665.gb8ec7d7.=
el7 for package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: libtcmalloc.so.4()(64bit) for pa=
ckage: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: librbd.so.1()(64bit) for package=
: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,255.255 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: libboost_thread-mt.so.1.53.0()(6=
4bit) for package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: libboost_system-mt.so.1.53.0()(6=
4bit) for package: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package ceph-radosgw.x86_64 1:0.87-665.gb8ec7d7.el7 wi=
ll be installed
>     > 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: libfcgi.so.0()(64bit) for packag=
e: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package librados2.x86_64 1:0.87-665.gb8ec7d7.el7 will =
be installed
>     > 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Running transaction check
>     > 2014-11-09 22:10:59,256.256 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package boost-system.x86_64 0:1.53.0-18.el7 will be in=
stalled
>     > 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package boost-thread.x86_64 0:1.53.0-18.el7 will be in=
stalled
>     > 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package ceph-common.x86_64 1:0.87-665.gb8ec7d7.el7 wil=
l be installed
>     > 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: libtcmalloc.so.4()(64bit) for pa=
ckage: 1:ceph-common-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package ceph-radosgw.x86_64 1:0.87-665.gb8ec7d7.el7 wi=
ll be installed
>     > 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Processing Dependency: libfcgi.so.0()(64bit) for packag=
e: 1:ceph-radosgw-0.87-665.gb8ec7d7.el7.x86_64
>     > 2014-11-09 22:10:59,257.257 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package librbd1.x86_64 1:0.87-665.gb8ec7d7.el7 will be=
 installed
>     > 2014-11-09 22:10:59,258.258 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: ---> Package python-ceph.x86_64 1:0.87-665.gb8ec7d7.el7 wil=
l be installed
>     > 2014-11-09 22:10:59,376.376 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]: --> Finished Dependency Resolution
>     > 2014-11-09 22:10:59,385.385 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]:  You could try using --skip-broken to work around the probl=
em
>     > 2014-11-09 22:10:59,873.873 INFO:teuthology.orchestra.run.out:[10=
=2E15.17.91]:  You could try running: rpm -Va --nofiles --nodigest
>     > 2014-11-09 22:10:59,900.900 ERROR:teuthology.parallel:Exception i=
n parallel execution
>     > Traceback (most recent call last):
>     >   File "/home/pras/storm-1-0-test/qe/teuthology/teuthology/parall=
el.py", line 82, in __exit__
>     >
>     >
>     > Please let me know if there are any modules to be installed befor=
e starting teuthology?
>     >
>     > Regards,
>     > Pras
>     >
>     >
>     > _______________________________________________
>     > ceph-users mailing list
>     > ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>     > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>     >
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QsePo7gF7Wvwu3VuCu7eWegi6aLCgemS5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRgha0ACgkQ8dLMyEl6F22YYwCgndcVOlI+zfw/o+OT7FLQAvz/
kdwAoLsP8wW2JY5T9E5qDHup4LLiN4SH
=ieEN
-----END PGP SIGNATURE-----

--QsePo7gF7Wvwu3VuCu7eWegi6aLCgemS5--
