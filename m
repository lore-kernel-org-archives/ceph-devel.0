From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Single host VM limit when using RBD
Date: Thu, 17 Jan 2013 11:55:17 -0700
Message-ID: <50F84915.60104@sandia.gov>
References: <38A500831D3DE24B90BD200D6C8701351BB3AA15@Exchange2010-2.corit.local>
 <38A500831D3DE24B90BD200D6C8701351BB3AF0F@Exchange2010-2.corit.local>
 <CABYiri94ZzEDhvvZg=AUyJcDfgBZ9s8vh+4727OQyE5K4DN1nQ@mail.gmail.com>
 <38A500831D3DE24B90BD200D6C8701351BB3AF77@Exchange2010-2.corit.local>
 <406175B4-665C-4D05-B97C-986593D1647F@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:37948 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab3AQSzr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 13:55:47 -0500
In-Reply-To: <406175B4-665C-4D05-B97C-986593D1647F@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Matthew Anderson <matthewa@base3.com.au>, Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/17/2013 11:36 AM, Dan Mick wrote:
> How about RLIMIT_NPROC, or memory exhaustion?

Also, check /proc/sys/kernel/pid_max.

I've solved a similar pthread_create problem by increasing this
to 256k, up from 32k.

-- Jim

>=20
> On Jan 17, 2013, at 12:47 AM, Matthew Anderson <matthewa@base3.com.au=
> wrote:
>=20
>> Hi Audrey,
>>
>> I did try your suggestion beforehand and it doesn't appear to fix th=
e issue.=20
>>
>> [root@KVM04 ~]# cat  /proc/sys/kernel/threads-max=20
>> 2549635
>> [root@KVM04 ~]# echo 5549635 > /proc/sys/kernel/threads-max
>> [root@KVM04 ~]# virsh start EX03
>> error: Failed to start domain EX03
>> error: internal error Process exited while reading console log outpu=
t: char device redirected to /dev/pts/23
>> Thread::try_create(): pthread_create failed with error 11common/Thre=
ad.cc: In function 'void Thread::create(size_t)' thread 7f5ec9706960 ti=
me 2013-01-17 16:46:50.935681
>> common/Thread.cc: 110: FAILED assert(ret =3D=3D 0)
>> ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>> 1: (()+0x2aaa8f) [0x7f5ec6a89a8f]
>> 2: (SafeTimer::init()+0x95) [0x7f5ec6973575]
>> 3: (librados::RadosClient::connect()+0x72c) [0x7f5ec69099dc]
>> 4: (()+0xa0290) [0x7f5ec97c8290]
>> 5: (()+0x879dd) [0x7f5ec97af9dd]
>> 6: (()+0x87c1b) [0x7f5ec97afc1b]
>> 7: (()+0x87ae1) [0x7f5ec97afae1]
>> 8: (()+0x87d50) [0x7f5ec97afd50]
>> 9: (()+0xb37b2) [0x7f5ec97db7b2]
>> 10: (()+0x1e83eb) [0x7f5ec99103eb]
>> 11: (()+0x1ab54a) [0x7f5ec98d354a]
>> 12: (main()+0x9da) [0x7f5ec9913a3a]
>> 13: (__libc_start_main()+0xfd) [0x7f5ec5755cdd]
>> 14: (()+0x710b9) [0x7f5ec97990b9]
>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
>> terminate called after
>>    =20
>>
>>
>> -----Original Message-----
>> From: Andrey Korolyov [mailto:andrey@xdel.ru]=20
>> Sent: Thursday, 17 January 2013 4:42 PM
>> To: Matthew Anderson
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: Single host VM limit when using RBD
>>
>> Hi Matthew,
>>
>> Seems to a low value in /proc/sys/kernel/threads-max value.
>>
>> On Thu, Jan 17, 2013 at 12:37 PM, Matthew Anderson <matthewa@base3.c=
om.au> wrote:
>>> I've run into a limit on the maximum number of RBD backed VM's that=
 I'm able to run on a single host. I have 20 VM's (21 RBD volumes open)=
 running on a single host and when booting the 21st machine I get the b=
elow error from libvirt/QEMU. I'm able to shut down a VM and start anot=
her in it's place so there seems to be a hard limit on the amount of vo=
lumes I'm able to have open.  I did some googling and the error 11 from=
 pthread_create seems to mean 'resource unavailable' so I'm probably ru=
nning into a thread limit of some sort. I did try increasing the max_th=
read kernel option but nothing changed. I moved a few VM's to a differe=
nt empty host and they start with no issues at all.
>>>
>>> This machine has 4 OSD's running on it in addition to the 20 VM's. =
Kernel 3.7.1. Ceph 0.56.1 and QEMU 1.3.0. There is currently 65GB of 96=
GB free ram and no swap.
>>>
>>> Can anyone suggest where the limit might be or anything I can do to=
 narrow down the problem?
>>>
>>> Thanks
>>> -Matt
>>> -------------------------
>>>
>>> Error starting domain: internal error Process exited while reading=20
>>> console log output: char device redirected to /dev/pts/23
>>> Thread::try_create(): pthread_create failed with error=20
>>> 11common/Thread.cc: In function 'void Thread::create(size_t)' threa=
d=20
>>> 7f4eb5a65960 time 2013-01-17 02:32:58.096437
>>> common/Thread.cc: 110: FAILED assert(ret =3D=3D 0) ceph version 0.5=
6.1=20
>>> (e4a541624df62ef353e754391cbbb707f54b16f7)
>>> 1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
>>> 2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
>>> 3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
>>> 4: (()+0xa0290) [0x7f4eb5b27290]
>>> 5: (()+0x879dd) [0x7f4eb5b0e9dd]
>>> 6: (()+0x87c1b) [0x7f4eb5b0ec1b]
>>> 7: (()+0x87ae1) [0x7f4eb5b0eae1]
>>> 8: (()+0x87d50) [0x7f4eb5b0ed50]
>>> 9: (()+0xb37b2) [0x7f4eb5b3a7b2]
>>> 10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
>>> 11: (()+0x1ab54a) [0x7f4eb5c3254a]
>>> 12: (main()+0x9da) [0x7f4eb5c72a3a]
>>> 13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
>>> 14: (()+0x710b9) [0x7f4eb5af80b9]
>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is n=
eeded to interpret this.
>>> terminate called after
>>>
>>> Traceback (most recent call last):
>>>  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 96, i=
n cb_wrapper
>>>    callback(asyncjob, *args, **kwargs)
>>>  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 117, =
in tmpcb
>>>    callback(*args, **kwargs)
>>>  File "/usr/share/virt-manager/virtManager/domain.py", line 1090, i=
n startup
>>>    self._backend.create()
>>>  File "/usr/lib/python2.7/dist-packages/libvirt.py", line 620, in c=
reate
>>>    if ret =3D=3D -1: raise libvirtError ('virDomainCreate() failed'=
,=20
>>> dom=3Dself)
>>> libvirtError: internal error Process exited while reading console l=
og=20
>>> output: char device redirected to /dev/pts/23
>>> Thread::try_create(): pthread_create failed with error=20
>>> 11common/Thread.cc: In function 'void Thread::create(size_t)' threa=
d=20
>>> 7f4eb5a65960 time 2013-01-17 02:32:58.096437
>>> common/Thread.cc: 110: FAILED assert(ret =3D=3D 0) ceph version 0.5=
6.1=20
>>> (e4a541624df62ef353e754391cbbb707f54b16f7)
>>> 1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
>>> 2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
>>> 3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
>>> 4: (()+0xa0290) [0x7f4eb5b27290]
>>> 5: (()+0x879dd) [0x7f4eb5b0e9dd]
>>> 6: (()+0x87c1b) [0x7f4eb5b0ec1b]
>>> 7: (()+0x87ae1) [0x7f4eb5b0eae1]
>>> 8: (()+0x87d50) [0x7f4eb5b0ed50]
>>> 9: (()+0xb37b2) [0x7f4eb5b3a7b2]
>>> 10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
>>> 11: (()+0x1ab54a) [0x7f4eb5c3254a]
>>> 12: (main()+0x9da) [0x7f4eb5c72a3a]
>>> 13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
>>> 14: (()+0x710b9) [0x7f4eb5af80b9]
>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is n=
eeded to interpret this.
>>> terminate called after
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"=20
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o=20
>>> info at  http://vger.kernel.org/majordomo-info.html
>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=
=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!=EF=BF=BDi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
