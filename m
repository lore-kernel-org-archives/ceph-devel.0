From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: s3test firefly failing
Date: Tue, 14 Jul 2015 15:47:30 -0400 (EDT)
Message-ID: <750240441.7103382.1436903250651.JavaMail.zimbra@redhat.com>
References: <55A4C004.4000205@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:53515 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbbGNTsd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2015 15:48:33 -0400
In-Reply-To: <55A4C004.4000205@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Doesn't ring a bell. There should be a config file it uses to determine=
 where to connect to.

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, July 14, 2015 12:53:40 AM
> Subject: s3test firefly failing
>=20
> Hi Yehuda,
>=20
> When running the firefly rgw suite in a teuthology setup outside of t=
he Ceph
> community lab, I'm seeing a lot of errors like the following. Althoug=
h the
> traceback does not give any indication as to what domain name could n=
ot be
> resolved, I suspect it is a hardcoded value somewhere that needs to b=
e
> defined in the DNS in order to work. I kind of remember S3 has all ki=
nds of
> hardcoded domain names since it's not supposed to be used outside of =
AWS.
>=20
> Does that ring a bell ?
>=20
> Cheers
>=20
> http://integration.ceph.dachary.org:8081/ubuntu-2015-07-13_23:33:20-r=
gw-firefly-backports---basic-openstack/
> has
> http://integration.ceph.dachary.org/ubuntu-2015-07-13_23:33:20-rgw-fi=
refly-backports---basic-openstack/79/teuthology.log
>=20
> 2015-07-14T04:35:42.762 INFO:teuthology.orchestra.run.ovh237095:Runni=
ng:
> '/home/ubuntu/cephtest/s3-tests/virtualenv/bin/s3tests-test-readwrite=
'
> 2015-07-14T04:35:42.899 INFO:teuthology.orchestra.run.ovh237095.stder=
r:Using
> random seeds: {'writer': 3920086541, 'main': 1490942677, 'names': 905=
270384,
> 'contents': 501048982, 'reader': 823656287}
> 2015-07-14T04:35:45.306
> INFO:teuthology.orchestra.run.ovh237095.stderr:Created bucket: rwtest
> 2015-07-14T04:35:45.311
> INFO:teuthology.orchestra.run.ovh237095.stderr:Creating random file n=
ames
> 2015-07-14T04:35:45.312
> INFO:teuthology.orchestra.run.ovh237095.stderr:Uploading initial set =
of 10
> files
> 2015-07-14T04:36:15.542
> INFO:teuthology.orchestra.run.ovh237095.stderr:Traceback (most recent=
 call
> last):
> 2015-07-14T04:36:15.547 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-p=
ackages/gevent/greenlet.py",
> line 390, in run
> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> result =3D self._run(*self.args, **self.kwargs)
> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/s3tests/readwrite.py", line 126, in
> write_file
> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> key.set_contents_from_file(fp)
> 2015-07-14T04:36:15.548 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-p=
ackages/boto/s3/key.py",
> line 1293, in set_contents_from_file
> 2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> chunked_transfer=3Dchunked_transfer, size=3Dsize)
> 2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-p=
ackages/boto/s3/key.py",
> line 750, in send_file
> 2015-07-14T04:36:15.549 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> chunked_transfer=3Dchunked_transfer, size=3Dsize)
> 2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-p=
ackages/boto/s3/key.py",
> line 951, in _send_file_internal
> 2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> query_args=3Dquery_args
> 2015-07-14T04:36:15.555 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-p=
ackages/boto/s3/connection.py",
> line 664, in make_request
> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> retry_handler=3Dretry_handler
> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-p=
ackages/boto/connection.py",
> line 1071, in make_request
> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> retry_handler=3Dretry_handler)
> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stder=
r:  File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-p=
ackages/boto/connection.py",
> line 1030, in _mexe
> 2015-07-14T04:36:15.556 INFO:teuthology.orchestra.run.ovh237095.stder=
r:
> raise ex
> 2015-07-14T04:36:15.556
> INFO:teuthology.orchestra.run.ovh237095.stderr:DNSError: [Errno 3] na=
me does
> not exist
> 2015-07-14T04:36:15.556
> INFO:teuthology.orchestra.run.ovh237095.stderr:<Greenlet at 0x7fbd8f8=
c64b0:
> write_file(fp=3D<tempfile.SpooledTemporaryFile instance at 0x7fbd8,
> file_name=3D'ctygneslkqtdbzs', bucket=3D<Bucket: rwtest>)> failed wit=
h DNSError
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
