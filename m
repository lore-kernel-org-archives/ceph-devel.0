From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Single host VM limit when using RBD
Date: Thu, 17 Jan 2013 10:36:54 -0800
Message-ID: <406175B4-665C-4D05-B97C-986593D1647F@inktank.com>
References: <38A500831D3DE24B90BD200D6C8701351BB3AA15@Exchange2010-2.corit.local> <38A500831D3DE24B90BD200D6C8701351BB3AF0F@Exchange2010-2.corit.local> <CABYiri94ZzEDhvvZg=AUyJcDfgBZ9s8vh+4727OQyE5K4DN1nQ@mail.gmail.com> <38A500831D3DE24B90BD200D6C8701351BB3AF77@Exchange2010-2.corit.local>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34032 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab3AQShB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 13:37:01 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1625489pad.4
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 10:37:00 -0800 (PST)
In-Reply-To: <38A500831D3DE24B90BD200D6C8701351BB3AF77@Exchange2010-2.corit.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Anderson <matthewa@base3.com.au>
Cc: Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

How about RLIMIT_NPROC, or memory exhaustion?

On Jan 17, 2013, at 12:47 AM, Matthew Anderson <matthewa@base3.com.au> =
wrote:

> Hi Audrey,
>=20
> I did try your suggestion beforehand and it doesn't appear to fix the=
 issue.=20
>=20
> [root@KVM04 ~]# cat  /proc/sys/kernel/threads-max=20
> 2549635
> [root@KVM04 ~]# echo 5549635 > /proc/sys/kernel/threads-max
> [root@KVM04 ~]# virsh start EX03
> error: Failed to start domain EX03
> error: internal error Process exited while reading console log output=
: char device redirected to /dev/pts/23
> Thread::try_create(): pthread_create failed with error 11common/Threa=
d.cc: In function 'void Thread::create(size_t)' thread 7f5ec9706960 tim=
e 2013-01-17 16:46:50.935681
> common/Thread.cc: 110: FAILED assert(ret =3D=3D 0)
> ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
> 1: (()+0x2aaa8f) [0x7f5ec6a89a8f]
> 2: (SafeTimer::init()+0x95) [0x7f5ec6973575]
> 3: (librados::RadosClient::connect()+0x72c) [0x7f5ec69099dc]
> 4: (()+0xa0290) [0x7f5ec97c8290]
> 5: (()+0x879dd) [0x7f5ec97af9dd]
> 6: (()+0x87c1b) [0x7f5ec97afc1b]
> 7: (()+0x87ae1) [0x7f5ec97afae1]
> 8: (()+0x87d50) [0x7f5ec97afd50]
> 9: (()+0xb37b2) [0x7f5ec97db7b2]
> 10: (()+0x1e83eb) [0x7f5ec99103eb]
> 11: (()+0x1ab54a) [0x7f5ec98d354a]
> 12: (main()+0x9da) [0x7f5ec9913a3a]
> 13: (__libc_start_main()+0xfd) [0x7f5ec5755cdd]
> 14: (()+0x710b9) [0x7f5ec97990b9]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is nee=
ded to interpret this.
> terminate called after
>    =20
>=20
>=20
> -----Original Message-----
> From: Andrey Korolyov [mailto:andrey@xdel.ru]=20
> Sent: Thursday, 17 January 2013 4:42 PM
> To: Matthew Anderson
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Single host VM limit when using RBD
>=20
> Hi Matthew,
>=20
> Seems to a low value in /proc/sys/kernel/threads-max value.
>=20
> On Thu, Jan 17, 2013 at 12:37 PM, Matthew Anderson <matthewa@base3.co=
m.au> wrote:
>> I've run into a limit on the maximum number of RBD backed VM's that =
I'm able to run on a single host. I have 20 VM's (21 RBD volumes open) =
running on a single host and when booting the 21st machine I get the be=
low error from libvirt/QEMU. I'm able to shut down a VM and start anoth=
er in it's place so there seems to be a hard limit on the amount of vol=
umes I'm able to have open.  I did some googling and the error 11 from =
pthread_create seems to mean 'resource unavailable' so I'm probably run=
ning into a thread limit of some sort. I did try increasing the max_thr=
ead kernel option but nothing changed. I moved a few VM's to a differen=
t empty host and they start with no issues at all.
>>=20
>> This machine has 4 OSD's running on it in addition to the 20 VM's. K=
ernel 3.7.1. Ceph 0.56.1 and QEMU 1.3.0. There is currently 65GB of 96G=
B free ram and no swap.
>>=20
>> Can anyone suggest where the limit might be or anything I can do to =
narrow down the problem?
>>=20
>> Thanks
>> -Matt
>> -------------------------
>>=20
>> Error starting domain: internal error Process exited while reading=20
>> console log output: char device redirected to /dev/pts/23
>> Thread::try_create(): pthread_create failed with error=20
>> 11common/Thread.cc: In function 'void Thread::create(size_t)' thread=
=20
>> 7f4eb5a65960 time 2013-01-17 02:32:58.096437
>> common/Thread.cc: 110: FAILED assert(ret =3D=3D 0) ceph version 0.56=
=2E1=20
>> (e4a541624df62ef353e754391cbbb707f54b16f7)
>> 1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
>> 2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
>> 3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
>> 4: (()+0xa0290) [0x7f4eb5b27290]
>> 5: (()+0x879dd) [0x7f4eb5b0e9dd]
>> 6: (()+0x87c1b) [0x7f4eb5b0ec1b]
>> 7: (()+0x87ae1) [0x7f4eb5b0eae1]
>> 8: (()+0x87d50) [0x7f4eb5b0ed50]
>> 9: (()+0xb37b2) [0x7f4eb5b3a7b2]
>> 10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
>> 11: (()+0x1ab54a) [0x7f4eb5c3254a]
>> 12: (main()+0x9da) [0x7f4eb5c72a3a]
>> 13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
>> 14: (()+0x710b9) [0x7f4eb5af80b9]
>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
>> terminate called after
>>=20
>> Traceback (most recent call last):
>>  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 96, in=
 cb_wrapper
>>    callback(asyncjob, *args, **kwargs)
>>  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 117, i=
n tmpcb
>>    callback(*args, **kwargs)
>>  File "/usr/share/virt-manager/virtManager/domain.py", line 1090, in=
 startup
>>    self._backend.create()
>>  File "/usr/lib/python2.7/dist-packages/libvirt.py", line 620, in cr=
eate
>>    if ret =3D=3D -1: raise libvirtError ('virDomainCreate() failed',=
=20
>> dom=3Dself)
>> libvirtError: internal error Process exited while reading console lo=
g=20
>> output: char device redirected to /dev/pts/23
>> Thread::try_create(): pthread_create failed with error=20
>> 11common/Thread.cc: In function 'void Thread::create(size_t)' thread=
=20
>> 7f4eb5a65960 time 2013-01-17 02:32:58.096437
>> common/Thread.cc: 110: FAILED assert(ret =3D=3D 0) ceph version 0.56=
=2E1=20
>> (e4a541624df62ef353e754391cbbb707f54b16f7)
>> 1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
>> 2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
>> 3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
>> 4: (()+0xa0290) [0x7f4eb5b27290]
>> 5: (()+0x879dd) [0x7f4eb5b0e9dd]
>> 6: (()+0x87c1b) [0x7f4eb5b0ec1b]
>> 7: (()+0x87ae1) [0x7f4eb5b0eae1]
>> 8: (()+0x87d50) [0x7f4eb5b0ed50]
>> 9: (()+0xb37b2) [0x7f4eb5b3a7b2]
>> 10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
>> 11: (()+0x1ab54a) [0x7f4eb5c3254a]
>> 12: (main()+0x9da) [0x7f4eb5c72a3a]
>> 13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
>> 14: (()+0x710b9) [0x7f4eb5af80b9]
>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
>> terminate called after
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=
=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!=EF=BF=BDi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
