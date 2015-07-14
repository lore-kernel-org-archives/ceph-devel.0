From: Loic Dachary <loic@dachary.org>
Subject: s3test firefly failing
Date: Tue, 14 Jul 2015 09:53:40 +0200
Message-ID: <55A4C004.4000205@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UjFdarnGs8nPea7gjHNae26d3JfjBqc9x"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49634 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751277AbbGNHxv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2015 03:53:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UjFdarnGs8nPea7gjHNae26d3JfjBqc9x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

When running the firefly rgw suite in a teuthology setup outside of the C=
eph community lab, I'm seeing a lot of errors like the following. Althoug=
h the traceback does not give any indication as to what domain name could=
 not be resolved, I suspect it is a hardcoded value somewhere that needs =
to be defined in the DNS in order to work. I kind of remember S3 has all =
kinds of hardcoded domain names since it's not supposed to be used outsid=
e of AWS.

Does that ring a bell ?=20

Cheers

http://integration.ceph.dachary.org:8081/ubuntu-2015-07-13_23:33:20-rgw-f=
irefly-backports---basic-openstack/
has
http://integration.ceph.dachary.org/ubuntu-2015-07-13_23:33:20-rgw-firefl=
y-backports---basic-openstack/79/teuthology.log

2015-07-14T04:35:42.762 INFO:teuthology.orchestra.run.ovh237095:Running: =
'/home/ubuntu/cephtest/s3-tests/virtualenv/bin/s3tests-test-readwrite'
2015-07-14T04:35:42.899 INFO:teuthology.orchestra.run.ovh237095.stderr:Us=
ing random seeds: {'writer': 3920086541, 'main': 1490942677, 'names': 905=
270384, 'contents': 501048982, 'reader': 823656287}
2015-07-14T04:35:45.306 INFO:teuthology.orchestra.run.ovh237095.stderr:Cr=
eated bucket: rwtest
2015-07-14T04:35:45.311 INFO:teuthology.orchestra.run.ovh237095.stderr:Cr=
eating random file names
2015-07-14T04:35:45.312 INFO:teuthology.orchestra.run.ovh237095.stderr:Up=
loading initial set of 10 files
2015-07-14T04:36:15.542 INFO:teuthology.orchestra.run.ovh237095.stderr:Tr=
aceback (most recent call last):
2015-07-14T04:36:15.547 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-=
packages/gevent/greenlet.py", line 390, in run
2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  result =3D self._run(*self.args, **self.kwargs)
2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/s3tests/readwrite.py", line 126, in =
write_file
2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  key.set_contents_from_file(fp)
2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-=
packages/boto/s3/key.py", line 1293, in set_contents_from_file
2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  chunked_transfer=3Dchunked_transfer, size=3Dsize)
2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-=
packages/boto/s3/key.py", line 750, in send_file
2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  chunked_transfer=3Dchunked_transfer, size=3Dsize)
2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-=
packages/boto/s3/key.py", line 951, in _send_file_internal
2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  query_args=3Dquery_args
2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-=
packages/boto/s3/connection.py", line 664, in make_request
2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  retry_handler=3Dretry_handler
2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-=
packages/boto/connection.py", line 1071, in make_request
2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  retry_handler=3Dretry_handler)
2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
File "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-=
packages/boto/connection.py", line 1030, in _mexe
2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr:  =
  raise ex
2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr:DN=
SError: [Errno 3] name does not exist
2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr:<G=
reenlet at 0x7fbd8f8c64b0: write_file(fp=3D<tempfile.SpooledTemporaryFile=
 instance at 0x7fbd8, file_name=3D'ctygneslkqtdbzs', bucket=3D<Bucket: rw=
test>)> failed with DNSError

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UjFdarnGs8nPea7gjHNae26d3JfjBqc9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWkwAQACgkQ8dLMyEl6F21C/QCfUmkhKzJ6gAVWB/CVf3/JW5L1
LjUAn19uImvo8cbU5qk3mD543y+jfYNX
=sOht
-----END PGP SIGNATURE-----

--UjFdarnGs8nPea7gjHNae26d3JfjBqc9x--
