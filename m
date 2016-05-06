From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph-disk broken????
Date: Fri, 6 May 2016 09:34:37 +0200
Message-ID: <bda59c5a-f957-3775-72b9-312c95849851@digiware.nl>
References: <5e9940d6-d9bb-e9b4-0af8-49e0f0cbb0f5@digiware.nl>
 <CAJE9aOM2HmZP79JumjD5+oAypye3fvFx-nfO1=uYjdg+_+z9Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:44852 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcEFHeq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 03:34:46 -0400
In-Reply-To: <CAJE9aOM2HmZP79JumjD5+oAypye3fvFx-nfO1=uYjdg+_+z9Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

On 6-5-2016 06:49, kefu chai wrote:
> On Thu, May 5, 2016 at 4:44 AM, Willem Jan Withagen <wjw@digiware.nl>=
 wrote:
>> Hi
>>
>> Setup:
>>   Fresh VM with CentOS7
>>   standard ceph/ceph clone
>>   building with run-make-check.sh
>>      So the dependancies are installed by install-deps.sh
>>
>> I have several tests that fail with:
>>
>>  run_osd:  ceph-disk --statedir=3Dtestdir/osd-crush
>> --sysconfdir=3Dtestdir/osd-crush --prepend-to-path=3D prepare
>> testdir/osd-crush/0
>> Traceback (most recent call last):
>>   File "/tmp/ceph-disk-virtualenv/bin/ceph-disk", line 5, in <module=
>
>>     from pkg_resources import load_entry_point
>>   File
>> "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources=
=2Epy",
>> line 3007, in <module>
>>     working_set.require(__requires__)
>>   File
>> "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources=
=2Epy",
>> line 728, in require
>>     needed =3D self.resolve(parse_requirements(requirements))
>>   File
>> "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources=
=2Epy",
>> line 626, in resolve
>>     raise DistributionNotFound(req)
>> pkg_resources.DistributionNotFound: ceph-disk=3D=3D1.0.0
>>
>> Looks like ceph-disk is not in the fresh install in tmp...
>>
>> Ran into this with my development fork, but then also with a regular=
 HEAD
>> Did I miss something?
>
> Willem, you are not missing anything. the problem you are facing is w=
hat
> happens in our jenkins sometimes. for example, see
> https://jenkins.ceph.com/job/ceph-pull-requests/5222/consoleFull . Lo=
=C3=AFc tried
> to root cause this, and found that it only happens in rhel7.0.

And FreeBSD... :(
Could this be a PATH issue... I do remember adding a /usr/local/bin/=20
path to
ceph-disk.sh to get it to find python in the FreeBSD tree.

--WjW

diff --git a/src/ceph-disk/tests/ceph-disk.sh=20
b/src/ceph-disk/tests/ceph-disk.sh
index 60280c6..b1c4391 100755
--- a/src/ceph-disk/tests/ceph-disk.sh
+++ b/src/ceph-disk/tests/ceph-disk.sh
@@ -69,7 +69,7 @@ CEPH_DISK_ARGS+=3D" --statedir=3D$DIR"
  CEPH_DISK_ARGS+=3D" --sysconfdir=3D$DIR"
  CEPH_DISK_ARGS+=3D" --prepend-to-path=3D"
  CEPH_DISK_ARGS+=3D" --verbose"
-TIMEOUT=3D120
+TIMEOUT=3D300

  cat=3D$(which cat)
  timeout=3D$(which timeout)
@@ -201,7 +201,7 @@ function test_path() {
  }

  function test_no_path() {
-    ( export=20
PATH=3D../ceph-detect-init/virtualenv/bin:virtualenv/bin:..:/usr/bin:/b=
in=20
; test_activate_dir ) || return 1
+    ( export=20
PATH=3D../ceph-detect-init/virtualenv/bin:virtualenv/bin:..:/usr/bin:/b=
in:/usr/local/bin=20
; test_activate_dir ) || return 1
  }

  function run_timeout() {
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
