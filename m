From: Loic Dachary <loic@dachary.org>
Subject: Re: code coverage and teuthology
Date: Wed, 16 Jan 2013 13:52:01 +0100
Message-ID: <50F6A271.9060503@dachary.org>
References: <50EF49C4.1020909@dachary.org> <50F43FAB.2050609@inktank.com> <50F52B23.4090903@dachary.org> <50F58FFF.6020508@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5EA54840800BFCFCCD4E2BC1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42864 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3APMwF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 07:52:05 -0500
In-Reply-To: <50F58FFF.6020508@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5EA54840800BFCFCCD4E2BC1
Content-Type: multipart/mixed;
 boundary="------------040700000804000407060303"

This is a multi-part message in MIME format.
--------------040700000804000407060303
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2013 06:21 PM, Josh Durgin wrote:
> On 01/15/2013 02:10 AM, Loic Dachary wrote:
>> On 01/14/2013 06:26 PM, Josh Durgin wrote:
>>>
>>> Looking at how it's run automatically might help:
>>>
>>> https://github.com/ceph/teuthology/blob/master/teuthology/coverage.py=
#L88
>>>
>>>
>>> You should also add 'coverage: true' for the ceph task overrides.
>>> This way daemons are killed with SIGTERM, and the atexit function
>>> that outputs coverage information will run.
>>>
>>> Then you don't need your patch changing the flavor either.
>>> For each task X, the docstring for teuthology.task.X.task documents
>>> example usage and extra options like this.
>> Hi,
>>
>> That helped a lot, thanks :-) I think I'm almost there. After running:=

>>
>> ./virtualenv/bin/teuthology --archive /tmp/a1 /srv/3node_rgw.yaml
>>
>> wget -O /tmp/build/tmp.tgz http://gitbuilder.ceph.com/ceph-tarball-pre=
cise-x86_64-gcov/sha1/$(cat /tmp/a1/ceph-sha1)/ceph.x86_64.tgz
>>
>> echo ceph_build_output_dir: /tmp/build >> ~/.teuthology.yaml
>>
>> ./virtualenv/bin/teuthology-coverage -v --html-output /tmp/html --lcov=
-output /tmp/lcov --cov-tools-dir /srv/teuthology/coverage /tmp
>>
>> I get
>>
>> INFO:teuthology.coverage:initializing coverage data...
>> Retrieving source and .gcno files...
>> Initializing lcov files...
>> Deleting all .da files in /tmp/lcov/ceph/src and subdirectories
>> Done.
>> Capturing coverage data from /tmp/lcov/ceph/src
>> Found gcov version: 4.7.2
>> Scanning /tmp/lcov/ceph/src for .gcno files ...
>> Found 692 graph files in /tmp/lcov/ceph/src
>> Processing src/test_libhadoopcephfs_build-AuthMethodList.gcno
>> geninfo: ERROR: /tmp/lcov/ceph/src/test_libhadoopcephfs_build-AuthMeth=
odList.gcno: reached unexpected end of file
>>
>> root@ceph:/srv/teuthology# ls -l /tmp/lcov/ceph/src/test_libhadoopceph=
fs_build-AuthMethodList.gcno
>> -rw-r--r-- 1 root root 41088 Jan 15 09:49 /tmp/lcov/ceph/src/test_libh=
adoopcephfs_build-AuthMethodList.gcno
>>
>> I'm using
>>
>> lcov: LCOV version 1.9
>>
>> The only problem I can think of is that the machine I'm running lcov o=
n is a Debian GNU/Linux Wheezy, trying to analyze coverage for binaries c=
reated for Ubuntu Precise. They are both amd64 but .gcno files may have d=
ependencies to the toolchain.
>>
>> Did you ever run into similar problems ?
>
> I think I did when I built and ran on debian, and it was fixed with a
> later version of lcov (I think 1.9-2). I didn't try doing the coverage
> analysis on a different distribution from where ceph was built and run
> though, so that may also cause some issues.
It was indeed a compatibility problem : running lcov on precise works fin=
e.

Thanks :-)
>
> Josh
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------040700000804000407060303
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
--------------040700000804000407060303--

--------------enig5EA54840800BFCFCCD4E2BC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlD2onEACgkQ8dLMyEl6F20zcgCgtXu/t3+pkzvZ33MeoWjvJgeG
CV0AoIRhvJSziVKerJByKuszSJN2htQs
=Hzpm
-----END PGP SIGNATURE-----

--------------enig5EA54840800BFCFCCD4E2BC1--
