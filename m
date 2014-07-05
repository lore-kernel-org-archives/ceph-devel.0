From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: Firefly upgrade tests
Date: Sat, 5 Jul 2014 07:39:21 -0700
Message-ID: <CAJBxG-vZNs5nQWmP6GrSmjrEUF_u-pFT0S=V+hC1PRhafaGcSA@mail.gmail.com>
References: <53B5DBB2.90503@dachary.org>
	<53B8019B.3090909@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:34742 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaGEOjX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jul 2014 10:39:23 -0400
Received: by mail-ve0-f176.google.com with SMTP id db12so2492001veb.21
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jul 2014 07:39:22 -0700 (PDT)
In-Reply-To: <53B8019B.3090909@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I killed several runs that had been running for 2-3 days, hopefully it
will speed up your runs.

Thx
YuriW

On Sat, Jul 5, 2014 at 6:46 AM, Loic Dachary <loic@dachary.org> wrote:
>
> Hi,
>
> It looks like there is a shortage of VPS for some reason:
>
> http://pulpito.ceph.com/loic-2014-07-03_11:24:33-upgrade:firefly-x:st=
ress-split-wip-8475-testing-basic-vps/
>
> has a number of tests scheduled since ~48h and not making progress.
>
> Cheers
>
> On 04/07/2014 00:39, Loic Dachary wrote:
>> Hi Ceph,
>>
>> The firefly-x test upgrade suite is designed to check that upgrading=
 from Firefly to a newer version (master or a branch) works as expected=
=2E It was created it by copying dumpling-x and can be browsed at https=
://github.com/ceph/ceph-qa-suite/tree/master/suites/upgrade/firefly-x
>>
>> To establish a baseline, a run was scheduled to upgrade from firefly=
 to firefly (i.e. no upgrade really ;-) and it should therefore show th=
at when nothing happens all is well. It however fails in various ways a=
s can be seen here.
>>
>> ./virtualenv/bin/teuthology-suite --suite upgrade/firefly-x/stress-s=
plit  --suite-dir ~/software/ceph/ceph-qa-suite  --ceph firefly --machi=
ne-type vps --email loic@dachary.org http://pulpito.ceph.com/loic-2014-=
07-02_23:05:05-upgrade:firefly-x:stress-split-firefly-testing-basic-vps=
/
>>
>> * Command failed on vpm105 with status 1: 'sudo yum install -y http:=
//gitbuilder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/s=
ha1/8102ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'
>>   Does that mean kernels are not ready yet for this distribution and=
 the tests should be skipped ?
>> * Command failed on vpm058 with status 1: "SWIFT_TEST_CONFIG_FILE=3D=
/home/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/ceph=
test/swift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test=
/functional -v -a '!fails_on_rgw'"
>>   http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x=
:stress-split-firefly-testing-basic-vps/338941
>>
>>   Although it looks like http://tracker.ceph.com/issues/7808 which i=
s a duplicate of http://tracker.ceph.com/issues/7799 it is slightly dif=
ferent and http://tracker.ceph.com/issues/8735 was created to keep trac=
k of it.
>>
>> * Command failed on vpm070 with status 1: 'sudo adjust-ulimits ceph-=
coverage /home/ubuntu/cephtest/archive/coverage daemon-helper kill ceph=
-osd -f -i 1'    http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgra=
de:firefly-x:stress-split-firefly-testing-basic-vps/338904/
>>
>>    Although the root of the error seems to be that osd 1 cannot be k=
illed by the thrasher, I don't see meaningfull error messages. http://t=
racker.ceph.com/issues/8736 was filed to keep track of this condition.
>>
>> * timed out waiting for admin_socket to appear after osd.1 restart  =
  http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:st=
ress-split-firefly-testing-basic-vps/338908/
>>
>>    It looks like a race : the osd is killed at the same time it is r=
estarted by the thrasher and http://tracker.ceph.com/issues/8737 was op=
ened for this
>>
>> * hang on "INFO:teuthology.task.rados:joining rados"
>>   http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x=
:stress-split-firefly-testing-basic-vps/338915/
>>
>>   It looks like a bug and http://tracker.ceph.com/issues/8740 was fi=
led
>>
>> When the same suite is run to upgrade from firefly to master it give=
s http://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x:st=
ress-split-master-testing-basic-vps/ which shows the following errors:
>>
>> * Command failed on vpm105 with status 1: 'sudo yum install -y http:=
//gitbuilder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/s=
ha1/8102ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'   (same=
 as above)
>>
>> * Could not reconnect to ubuntu@vpm042.front.sepia.ceph.com  : it lo=
oks like a transient timeout problem that can be ignored
>>   http://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x=
:stress-split-master-testing-basic-vps/338891/
>>   2014-07-02T18:52:24.546 INFO:teuthology.orchestra.connection:{'use=
rname': u'ubuntu', 'hostname': u'vpm042.front.sepia.ceph.com', 'timeout=
': 60}
>>
>> * Command failed on vpm017 with status 1: "SWIFT_TEST_CONFIG_FILE=3D=
/home/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/ceph=
test/swift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test=
/functional -v -a '!fails_on_rgw'"
>>   One of which looks exactly as http://tracker.ceph.com/issues/7799 =
which was re-opened
>>
>> * hang on "INFO:teuthology.task.rados:joining rados" (same as above)
>>
>> Cheers
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
