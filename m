From: Loic Dachary <loic@dachary.org>
Subject: Re: code coverage and teuthology
Date: Tue, 15 Jan 2013 11:10:43 +0100
Message-ID: <50F52B23.4090903@dachary.org>
References: <50EF49C4.1020909@dachary.org> <50F43FAB.2050609@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig21E4EB6C53E8A86251E5D276"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:49886 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab3AOKKq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 05:10:46 -0500
In-Reply-To: <50F43FAB.2050609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21E4EB6C53E8A86251E5D276
Content-Type: multipart/mixed;
 boundary="------------010203060708060107070400"

This is a multi-part message in MIME format.
--------------010203060708060107070400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/14/2013 06:26 PM, Josh Durgin wrote:
>
> Looking at how it's run automatically might help:
>
> https://github.com/ceph/teuthology/blob/master/teuthology/coverage.py#L=
88
>
>
> You should also add 'coverage: true' for the ceph task overrides.
> This way daemons are killed with SIGTERM, and the atexit function
> that outputs coverage information will run.
>
> Then you don't need your patch changing the flavor either.
> For each task X, the docstring for teuthology.task.X.task documents
> example usage and extra options like this.
Hi,

That helped a lot, thanks :-) I think I'm almost there. After running:

=2E/virtualenv/bin/teuthology --archive /tmp/a1 /srv/3node_rgw.yaml

wget -O /tmp/build/tmp.tgz http://gitbuilder.ceph.com/ceph-tarball-precis=
e-x86_64-gcov/sha1/$(cat /tmp/a1/ceph-sha1)/ceph.x86_64.tgz

echo ceph_build_output_dir: /tmp/build >> ~/.teuthology.yaml

=2E/virtualenv/bin/teuthology-coverage -v --html-output /tmp/html --lcov-=
output /tmp/lcov --cov-tools-dir /srv/teuthology/coverage /tmp

I get

INFO:teuthology.coverage:initializing coverage data...
Retrieving source and .gcno files...
Initializing lcov files...
Deleting all .da files in /tmp/lcov/ceph/src and subdirectories
Done.
Capturing coverage data from /tmp/lcov/ceph/src
Found gcov version: 4.7.2
Scanning /tmp/lcov/ceph/src for .gcno files ...
Found 692 graph files in /tmp/lcov/ceph/src
Processing src/test_libhadoopcephfs_build-AuthMethodList.gcno
geninfo: ERROR: /tmp/lcov/ceph/src/test_libhadoopcephfs_build-AuthMethodL=
ist.gcno: reached unexpected end of file

root@ceph:/srv/teuthology# ls -l /tmp/lcov/ceph/src/test_libhadoopcephfs_=
build-AuthMethodList.gcno
-rw-r--r-- 1 root root 41088 Jan 15 09:49 /tmp/lcov/ceph/src/test_libhado=
opcephfs_build-AuthMethodList.gcno

I'm using

lcov: LCOV version 1.9

The only problem I can think of is that the machine I'm running lcov on i=
s a Debian GNU/Linux Wheezy, trying to analyze coverage for binaries crea=
ted for Ubuntu Precise. They are both amd64 but .gcno files may have depe=
ndencies to the toolchain.

Did you ever run into similar problems ?

Cheers

-----------------------------
check-locks: false
interactive-on-error: true
overrides:
  ceph:
    branch: master
    flavor: gcov
    coverage: true
    fs: xfs
roles:
- - mon.a
  - mon.c
  - osd.0
- - mon.b
  - mds.a
  - osd.1
- - client.0
tasks:
- ceph:
   coverage: true

targets:
=2E..


--------------010203060708060107070400
Content-Type: text/x-vcard; charset=utf-8;
 name="loic.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="loic.vcf"

YmVnaW46dmNhcmQNCmZuOkxvaWMgRGFjaGFyeQ0KbjpEYWNoYXJ5O0xvaWMNCm9yZzpBcnRp
c2FuIExvZ2ljaWVsIExpYnJlDQphZHI6OzsxMiBiZCBNYWdlbnRhO1BhcmlzOzs3NTAxMDtG
cmFuY2UNCmVtYWlsO2ludGVybmV0OmxvaWNAZGFjaGFyeS5vcmcNCnRpdGxlOlNlbmlvciBE
ZXZlbG9wZXINCnRlbDt3b3JrOiszMyA0IDg0IDI1IDA4IDA1DQp0ZWw7aG9tZTorMzMgOSA1
MSAxOCA0MyAzOA0KdGVsO2NlbGw6KzMzIDYgNjQgMDMgMjkgMDcNCm5vdGU6Qm9ybiAxMzE0
MTQ0MDQgYmVmb3JlIEVQT0NILg0KdXJsOmh0dHA6Ly9kYWNoYXJ5Lm9yZy8NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------010203060708060107070400--

--------------enig21E4EB6C53E8A86251E5D276
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlD1KyMACgkQ8dLMyEl6F22OyQCfa3qnBELB9TxlvNmi2TVXKYaE
MF4An1nmhOEwqRUJ9gqQ2az3Qy2tV0jy
=QWRB
-----END PGP SIGNATURE-----

--------------enig21E4EB6C53E8A86251E5D276--
