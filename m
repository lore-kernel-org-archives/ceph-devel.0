From: David Zafman <dzafman@redhat.com>
Subject: Re: pg scrub check problem
Date: Wed, 28 Oct 2015 12:27:14 -0700
Message-ID: <56312192.3030204@redhat.com>
References: <000001d11164$7fa470a0$7eed51e0$@com>
 <CANE=7sXqUs=9TgZsO0A8n0aQKHex4OnCW9uikP=TkNdsj+bDrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756153AbbJ1T1P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Oct 2015 15:27:15 -0400
In-Reply-To: <CANE=7sXqUs=9TgZsO0A8n0aQKHex4OnCW9uikP=TkNdsj+bDrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, changtao381 <changtao381@163.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Initiating a manual deep-scrub like you are doing should always run.

The command you are running doesn't report any information it just=20
initiates a background process.  If you follow the command with ceph -w=
=20
you'll see what is happening:

After I corrupted one of my replicas I see this.

$ ceph pg deep-scrub 1.6; ceph -w
instructing pg 1.6 on osd.3 to deep-scrub
     cluster 8528c83b-0ff9-479c-af76-fc0ac5c595d3
      health HEALTH_OK
      monmap e1: 1 mons at {a=3D127.0.0.1:6789/0}
             election epoch 2, quorum 0 a
      osdmap e14: 4 osds: 4 up, 4 in
             flags sortbitwise
       pgmap v29: 16 pgs, 2 pools, 1130 bytes data, 1 objects
             83917 MB used, 30311 MB / 117 GB avail
                   16 active+clean

2015-10-28 12:23:17.724011 mon.0 [INF] from=3D'client.?=20
127.0.0.1:0/3672629479' entity=3D'client.admin' cmd=3D[{"prefix": "pg=20
deep-scrub", "pgid": "1.6"}]: dispatch
2015-10-28 12:23:19.787756 mon.0 [INF] pgmap v30: 16 pgs: 1=20
active+clean+inconsistent, 15 active+clean; 1130 bytes data, 83917 MB=20
used, 30310 MB / 117 GB avail
2015-10-28 12:23:18.274239 osd.3 [INF] 1.6 deep-scrub starts
2015-10-28 12:23:18.277332 osd.3 [ERR] 1.6 shard 2: soid=20
1/7fc1f406/foo/head data_digest 0xe84d3cdc !=3D known data_digest=20
0x74d68469 from auth shard 0, size 7 !=3D known size 1130
2015-10-28 12:23:18.277546 osd.3 [ERR] 1.6 deep-scrub 0 missing, 1=20
inconsistent objects
2015-10-28 12:23:18.277549 osd.3 [ERR] 1.6 deep-scrub 1 errors
^C


David

On 10/28/15 3:34 AM, =E6=B1=A0=E4=BF=A1=E6=B3=BD wrote:
> Are you sure the osd begin to scrub? maybe you could check it from os=
d
> log, or using 'ceph pg dump' to
> check whether the scrub stamp changes or not.
> Because there is some strategy which would reject the scrub command
> Such as the system load , osd_scrub_min_interval,
> osd_deep_scrub_interval and so on
>
> 2015-10-28 17:39 GMT+08:00 changtao381 <changtao381@163.com>:
>> Hi,
>>
>> I=E2=80=99m testing the deep-scrub function of ceph.  And the test s=
teps are below :
>>
>> 1)  I put an object on ceph using command :
>>   rados put test.txt test.txt =E2=80=93p testpool
>>
>> The size of testpool is 3, so there three replicates on three osds:
>>
>> osd.0:   /data1/ceph_data/osd.0/current/1.0_head/test.txt__head_8B0B=
6108__1
>> osd.1:   /data2/ceph_data/osd.1/current/1.0_head/test.txt__head_8B0B=
6108__1
>> osd.2    /data3/ceph_data/osd.2/current/1.0_head/test.txt__head_8B0B=
6108__1
>>
>> 2) I modified the content of one replica on osd.0 using vim editor d=
irectly on disk
>>
>> 3) I run the command
>> =E3=80=80ceph pg deep-scrub 1.0
>>
>> and expect it can check the inconsistent error out, but it fails. It=
 doesn=E2=80=99t find the error
>> why?
>>
>> Any suggestions will be appreciated! Thanks
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
