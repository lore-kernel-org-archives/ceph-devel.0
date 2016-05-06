From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph-disk broken????
Date: Fri, 6 May 2016 11:05:12 +0200
Message-ID: <d85e83bc-7420-9197-21dd-86d33509cc56@digiware.nl>
References: <5e9940d6-d9bb-e9b4-0af8-49e0f0cbb0f5@digiware.nl>
 <CAJE9aOM2HmZP79JumjD5+oAypye3fvFx-nfO1=uYjdg+_+z9Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:25843 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbcEFJFW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 05:05:22 -0400
In-Reply-To: <CAJE9aOM2HmZP79JumjD5+oAypye3fvFx-nfO1=uYjdg+_+z9Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <ldachary@redhat.com>

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

Right,

Adding /usr/local/bin did "fix" this problem for me.
And I think it is because of python being in /usr/local/bin. (FreeBSD)

--WjW
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
