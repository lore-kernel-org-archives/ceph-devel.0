From: Loic Dachary <loic@dachary.org>
Subject: Re: s3test firefly failing
Date: Wed, 15 Jul 2015 06:56:39 +0200
Message-ID: <55A5E807.1000805@dachary.org>
References: <55A4C004.4000205@dachary.org> <750240441.7103382.1436903250651.JavaMail.zimbra@redhat.com> <1272169661.45947518.1436935476950.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1eSuoOqcJpj6JrJrEWpWX7vUbdLaE46QG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50173 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750946AbbGOE4u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2015 00:56:50 -0400
In-Reply-To: <1272169661.45947518.1436935476950.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tmuthami@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1eSuoOqcJpj6JrJrEWpWX7vUbdLaE46QG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for taking a look. I'll hack something to display the domain name =
that fails to be looked up and resolve that mystery. It's most certainly =
something I did wrong :-)

Cheers

On 15/07/2015 06:44, Tamil Muthamizhan wrote:
> Hi Loic,
>=20
> I looked into the failing cases and looks like the failures are mostly =
from the independent perl scripts which has the domain name and port no h=
ard coded to host_fqdn of the current host on which script is running  an=
d "7280" respectively.=20
>=20
> Regards,
> Tamil
>=20
>=20
> ----- Original Message -----
> From: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> To: "Loic Dachary" <loic@dachary.org>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, July 14, 2015 12:47:30 PM
> Subject: Re: s3test firefly failing
>=20
> Doesn't ring a bell. There should be a config file it uses to determine=
 where to connect to.
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yehuda Sadeh" <yehuda@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Tuesday, July 14, 2015 12:53:40 AM
>> Subject: s3test firefly failing
>>
>> Hi Yehuda,
>>
>> When running the firefly rgw suite in a teuthology setup outside of th=
e Ceph
>> community lab, I'm seeing a lot of errors like the following. Although=
 the
>> traceback does not give any indication as to what domain name could no=
t be
>> resolved, I suspect it is a hardcoded value somewhere that needs to be=

>> defined in the DNS in order to work. I kind of remember S3 has all kin=
ds of
>> hardcoded domain names since it's not supposed to be used outside of A=
WS.
>>
>> Does that ring a bell ?
>>
>> Cheers
>>
>> http://integration.ceph.dachary.org:8081/ubuntu-2015-07-13_23:33:20-rg=
w-firefly-backports---basic-openstack/
>> has
>> http://integration.ceph.dachary.org/ubuntu-2015-07-13_23:33:20-rgw-fir=
efly-backports---basic-openstack/79/teuthology.log
>>
>> 2015-07-14T04:35:42.762 INFO:teuthology.orchestra.run.ovh237095:Runnin=
g:
>> '/home/ubuntu/cephtest/s3-tests/virtualenv/bin/s3tests-test-readwrite'=

>> 2015-07-14T04:35:42.899 INFO:teuthology.orchestra.run.ovh237095.stderr=
:Using
>> random seeds: {'writer': 3920086541, 'main': 1490942677, 'names': 9052=
70384,
>> 'contents': 501048982, 'reader': 823656287}
>> 2015-07-14T04:35:45.306
>> INFO:teuthology.orchestra.run.ovh237095.stderr:Created bucket: rwtest
>> 2015-07-14T04:35:45.311
>> INFO:teuthology.orchestra.run.ovh237095.stderr:Creating random file na=
mes
>> 2015-07-14T04:35:45.312
>> INFO:teuthology.orchestra.run.ovh237095.stderr:Uploading initial set o=
f 10
>> files
>> 2015-07-14T04:36:15.542
>> INFO:teuthology.orchestra.run.ovh237095.stderr:Traceback (most recent =
call
>> last):
>> 2015-07-14T04:36:15.547 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-pa=
ckages/gevent/greenlet.py",
>> line 390, in run
>> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> result =3D self._run(*self.args, **self.kwargs)
>> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/s3tests/readwrite.py", line 126, in
>> write_file
>> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> key.set_contents_from_file(fp)
>> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-pa=
ckages/boto/s3/key.py",
>> line 1293, in set_contents_from_file
>> 2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> chunked_transfer=3Dchunked_transfer, size=3Dsize)
>> 2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-pa=
ckages/boto/s3/key.py",
>> line 750, in send_file
>> 2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> chunked_transfer=3Dchunked_transfer, size=3Dsize)
>> 2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-pa=
ckages/boto/s3/key.py",
>> line 951, in _send_file_internal
>> 2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> query_args=3Dquery_args
>> 2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-pa=
ckages/boto/s3/connection.py",
>> line 664, in make_request
>> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> retry_handler=3Dretry_handler
>> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-pa=
ckages/boto/connection.py",
>> line 1071, in make_request
>> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> retry_handler=3Dretry_handler)
>> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr=
:  File
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-pa=
ckages/boto/connection.py",
>> line 1030, in _mexe
>> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stderr=
:
>> raise ex
>> 2015-07-14T04:36:15.556
>> INFO:teuthology.orchestra.run.ovh237095.stderr:DNSError: [Errno 3] nam=
e does
>> not exist
>> 2015-07-14T04:36:15.556
>> INFO:teuthology.orchestra.run.ovh237095.stderr:<Greenlet at 0x7fbd8f8c=
64b0:
>> write_file(fp=3D<tempfile.SpooledTemporaryFile instance at 0x7fbd8,
>> file_name=3D'ctygneslkqtdbzs', bucket=3D<Bucket: rwtest>)> failed with=
 DNSError
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1eSuoOqcJpj6JrJrEWpWX7vUbdLaE46QG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWl6AcACgkQ8dLMyEl6F23S8ACgieVB/QzWS40MyEn2lSRm0IiV
3joAnA0OmHUWbsdtDX0c56+xK0urNjTj
=TmaV
-----END PGP SIGNATURE-----

--1eSuoOqcJpj6JrJrEWpWX7vUbdLaE46QG--
