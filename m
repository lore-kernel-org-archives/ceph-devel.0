From: Marcin Szukala <szukala.marcin@gmail.com>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Fri, 11 Jan 2013 23:02:12 +0100
Message-ID: <CA+-7kDBDWCv=dZN1Avc+BqLfxz5KKGNMHOjZvq5D7SnM6RSjvA@mail.gmail.com>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
	<CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com>
	<CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com>
	<CAPYLRzje19sAjtyRq8PX2zV0=GHpnzWdqOMk04UVUaRn2T7TOg@mail.gmail.com>
	<CA+-7kDCODuG-mWXEHv_QFdo1Guow55dd55+yPz85hKN+5rU1Gw@mail.gmail.com>
	<CAPYLRzhu1Tdj_MQnVJOQj6rFpVGDyiokx9k-ysb+jpbh_3F9wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34941 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab3AKWHx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jan 2013 17:07:53 -0500
Received: by mail-la0-f45.google.com with SMTP id ep20so2214974lab.4
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jan 2013 14:07:51 -0800 (PST)
In-Reply-To: <CAPYLRzhu1Tdj_MQnVJOQj6rFpVGDyiokx9k-ysb+jpbh_3F9wA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

The filesystem remains, but all of the data is lost.

Regards,
Marcin

2013/1/11 Gregory Farnum <greg@inktank.com>:
> On Fri, Jan 11, 2013 at 3:07 AM, Marcin Szukala
> <szukala.marcin@gmail.com> wrote:
>> 2013/1/10 Gregory Farnum <greg@inktank.com>:
>>> On Thu, Jan 10, 2013 at 8:56 AM, Marcin Szukala
>>> <szukala.marcin@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> Scenario is correct but the last line. I can mount the image, but the
>>>> data that was written to the image before power failure is lost.
>>>>
>>>> Currently the ceph cluster is not healthy, but i dont think its
>>>> related because I had this issue before the cluster itsef had issues
>>>> (about that I will write in different post not to mix topics).
>>>
>>> This sounds like one of two possibilities:
>>> 1) You aren't actually committing data to RADOS very often and so when
>>> the power fails you lose several minutes of writes. How much data are
>>> you losing, how's it generated, and is whatever you're doing running
>>> any kind of fsync or sync? And what filesystem are you using?
>>> 2) Your cluster is actually not accepting writes and so RBD never
>>> manages to do a write but you aren't doing much and so you don't
>>> notice. What's the output of ceph -s?
>>> -Greg
>>
>> Hi,
>>
>> Today I have created new ceph cluster from scratch.
>> root@ceph-1:~# ceph -s
>>    health HEALTH_OK
>>    monmap e1: 3 mons at
>> {a=10.3.82.102:6789/0,b=10.3.82.103:6789/0,d=10.3.82.105:6789/0},
>> election epoch 4, quorum 0,1,2 a,b,d
>>    osdmap e65: 56 osds: 56 up, 56 in
>>     pgmap v3892: 13744 pgs: 13744 active+clean; 73060 MB data, 147 GB
>> used, 51983 GB / 52131 GB avail
>>    mdsmap e1: 0/0/1 up
>>
>> The issue persisst.
>> I`am losing all of data on the image.
>
> So you mean you mount the image, format it with 5 XFS filesystems as
> below, run it for a while, and then the power on the system fails.
> Then you turn the system back on, attach the image, and it has no
> filesystems on it at all? Or the filesystems remain and can be mounted
> but they have no data?
> -Greg
>
>> On the mounted image I have 5 logical volumes.
>>
>> root@compute-9:~# mount
>> (snip)
>> /dev/mapper/compute--9-nova on /var/lib/nova type xfs (rw)
>> /dev/mapper/compute--9-tmp on /tmp type xfs (rw)
>> /dev/mapper/compute--9-libvirt on /etc/libvirt type xfs (rw)
>> /dev/mapper/compute--9-log on /var/log type xfs (rw)
>> /dev/mapper/compute--9-openvswitch on /var/lib/openvswitch type xfs (rw)
>>
>> So I have directories with little to none data writes and with a lot
>> of writes (logs). No fsync or sync. Filesystem is xfs.
