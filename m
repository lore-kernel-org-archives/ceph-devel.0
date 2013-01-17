From: Matthew Anderson <matthewa@base3.com.au>
Subject: Single host VM limit when using RBD
Date: Thu, 17 Jan 2013 08:37:17 +0000
Message-ID: <38A500831D3DE24B90BD200D6C8701351BB3AF0F@Exchange2010-2.corit.local>
References: <38A500831D3DE24B90BD200D6C8701351BB3AA15@Exchange2010-2.corit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.base3.com.au ([27.106.198.3]:24252 "EHLO mail.base3.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759324Ab3AQIh3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 03:37:29 -0500
In-Reply-To: <38A500831D3DE24B90BD200D6C8701351BB3AA15@Exchange2010-2.corit.local>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've run into a limit on the maximum number of RBD backed VM's that I'm=
 able to run on a single host. I have 20 VM's (21 RBD volumes open) run=
ning on a single host and when booting the 21st machine I get the below=
 error from libvirt/QEMU. I'm able to shut down a VM and start another =
in it's place so there seems to be a hard limit on the amount of volume=
s I'm able to have open.=A0 I did some googling and the error 11 from p=
thread_create seems to mean 'resource unavailable' so I'm probably runn=
ing into a thread limit of some sort. I did try increasing the max_thre=
ad kernel option but nothing changed. I moved a few VM's to a different=
 empty host and they start with no issues at all.

This machine has 4 OSD's running on it in addition to the 20 VM's. Kern=
el 3.7.1. Ceph 0.56.1 and QEMU 1.3.0. There is currently 65GB of 96GB f=
ree ram and no swap.=20

Can anyone suggest where the limit might be or anything I can do to nar=
row down the problem?

Thanks
-Matt
-------------------------

Error starting domain: internal error Process exited while reading cons=
ole log output: char device redirected to /dev/pts/23
Thread::try_create(): pthread_create failed with error 11common/Thread.=
cc: In function 'void Thread::create(size_t)' thread 7f4eb5a65960 time =
2013-01-17 02:32:58.096437
common/Thread.cc: 110: FAILED assert(ret =3D=3D 0)
ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
4: (()+0xa0290) [0x7f4eb5b27290]
5: (()+0x879dd) [0x7f4eb5b0e9dd]
6: (()+0x87c1b) [0x7f4eb5b0ec1b]
7: (()+0x87ae1) [0x7f4eb5b0eae1]
8: (()+0x87d50) [0x7f4eb5b0ed50]
9: (()+0xb37b2) [0x7f4eb5b3a7b2]
10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
11: (()+0x1ab54a) [0x7f4eb5c3254a]
12: (main()+0x9da) [0x7f4eb5c72a3a]
13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
14: (()+0x710b9) [0x7f4eb5af80b9]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.
terminate called after

Traceback (most recent call last):
=A0 File "/usr/share/virt-manager/virtManager/asyncjob.py", line 96, in=
 cb_wrapper
=A0=A0=A0 callback(asyncjob, *args, **kwargs)
=A0 File "/usr/share/virt-manager/virtManager/asyncjob.py", line 117, i=
n tmpcb
=A0=A0=A0 callback(*args, **kwargs)
=A0 File "/usr/share/virt-manager/virtManager/domain.py", line 1090, in=
 startup
=A0=A0=A0 self._backend.create()
=A0 File "/usr/lib/python2.7/dist-packages/libvirt.py", line 620, in cr=
eate
=A0=A0=A0 if ret =3D=3D -1: raise libvirtError ('virDomainCreate() fail=
ed', dom=3Dself)
libvirtError: internal error Process exited while reading console log o=
utput: char device redirected to /dev/pts/23
Thread::try_create(): pthread_create failed with error 11common/Thread.=
cc: In function 'void Thread::create(size_t)' thread 7f4eb5a65960 time =
2013-01-17 02:32:58.096437
common/Thread.cc: 110: FAILED assert(ret =3D=3D 0)
ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
4: (()+0xa0290) [0x7f4eb5b27290]
5: (()+0x879dd) [0x7f4eb5b0e9dd]
6: (()+0x87c1b) [0x7f4eb5b0ec1b]
7: (()+0x87ae1) [0x7f4eb5b0eae1]
8: (()+0x87d50) [0x7f4eb5b0ed50]
9: (()+0xb37b2) [0x7f4eb5b3a7b2]
10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
11: (()+0x1ab54a) [0x7f4eb5c3254a]
12: (main()+0x9da) [0x7f4eb5c72a3a]
13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
14: (()+0x710b9) [0x7f4eb5af80b9]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.
terminate called after

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
