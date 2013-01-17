From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Single host VM limit when using RBD
Date: Thu, 17 Jan 2013 11:42:05 +0300
Message-ID: <CABYiri94ZzEDhvvZg=AUyJcDfgBZ9s8vh+4727OQyE5K4DN1nQ@mail.gmail.com>
References: <38A500831D3DE24B90BD200D6C8701351BB3AA15@Exchange2010-2.corit.local>
 <38A500831D3DE24B90BD200D6C8701351BB3AF0F@Exchange2010-2.corit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:55697 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab3AQIm0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 03:42:26 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so2329826oag.23
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 00:42:25 -0800 (PST)
In-Reply-To: <38A500831D3DE24B90BD200D6C8701351BB3AF0F@Exchange2010-2.corit.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Anderson <matthewa@base3.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Matthew,

Seems to a low value in /proc/sys/kernel/threads-max value.

On Thu, Jan 17, 2013 at 12:37 PM, Matthew Anderson
<matthewa@base3.com.au> wrote:
> I've run into a limit on the maximum number of RBD backed VM's that I'm able to run on a single host. I have 20 VM's (21 RBD volumes open) running on a single host and when booting the 21st machine I get the below error from libvirt/QEMU. I'm able to shut down a VM and start another in it's place so there seems to be a hard limit on the amount of volumes I'm able to have open.  I did some googling and the error 11 from pthread_create seems to mean 'resource unavailable' so I'm probably running into a thread limit of some sort. I did try increasing the max_thread kernel option but nothing changed. I moved a few VM's to a different empty host and they start with no issues at all.
>
> This machine has 4 OSD's running on it in addition to the 20 VM's. Kernel 3.7.1. Ceph 0.56.1 and QEMU 1.3.0. There is currently 65GB of 96GB free ram and no swap.
>
> Can anyone suggest where the limit might be or anything I can do to narrow down the problem?
>
> Thanks
> -Matt
> -------------------------
>
> Error starting domain: internal error Process exited while reading console log output: char device redirected to /dev/pts/23
> Thread::try_create(): pthread_create failed with error 11common/Thread.cc: In function 'void Thread::create(size_t)' thread 7f4eb5a65960 time 2013-01-17 02:32:58.096437
> common/Thread.cc: 110: FAILED assert(ret == 0)
> ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
> 1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
> 2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
> 3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
> 4: (()+0xa0290) [0x7f4eb5b27290]
> 5: (()+0x879dd) [0x7f4eb5b0e9dd]
> 6: (()+0x87c1b) [0x7f4eb5b0ec1b]
> 7: (()+0x87ae1) [0x7f4eb5b0eae1]
> 8: (()+0x87d50) [0x7f4eb5b0ed50]
> 9: (()+0xb37b2) [0x7f4eb5b3a7b2]
> 10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
> 11: (()+0x1ab54a) [0x7f4eb5c3254a]
> 12: (main()+0x9da) [0x7f4eb5c72a3a]
> 13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
> 14: (()+0x710b9) [0x7f4eb5af80b9]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> terminate called after
>
> Traceback (most recent call last):
>   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 96, in cb_wrapper
>     callback(asyncjob, *args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 117, in tmpcb
>     callback(*args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/domain.py", line 1090, in startup
>     self._backend.create()
>   File "/usr/lib/python2.7/dist-packages/libvirt.py", line 620, in create
>     if ret == -1: raise libvirtError ('virDomainCreate() failed', dom=self)
> libvirtError: internal error Process exited while reading console log output: char device redirected to /dev/pts/23
> Thread::try_create(): pthread_create failed with error 11common/Thread.cc: In function 'void Thread::create(size_t)' thread 7f4eb5a65960 time 2013-01-17 02:32:58.096437
> common/Thread.cc: 110: FAILED assert(ret == 0)
> ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
> 1: (()+0x2aaa8f) [0x7f4eb2de8a8f]
> 2: (SafeTimer::init()+0x95) [0x7f4eb2cd2575]
> 3: (librados::RadosClient::connect()+0x72c) [0x7f4eb2c689dc]
> 4: (()+0xa0290) [0x7f4eb5b27290]
> 5: (()+0x879dd) [0x7f4eb5b0e9dd]
> 6: (()+0x87c1b) [0x7f4eb5b0ec1b]
> 7: (()+0x87ae1) [0x7f4eb5b0eae1]
> 8: (()+0x87d50) [0x7f4eb5b0ed50]
> 9: (()+0xb37b2) [0x7f4eb5b3a7b2]
> 10: (()+0x1e83eb) [0x7f4eb5c6f3eb]
> 11: (()+0x1ab54a) [0x7f4eb5c3254a]
> 12: (main()+0x9da) [0x7f4eb5c72a3a]
> 13: (__libc_start_main()+0xfd) [0x7f4eb1ab4cdd]
> 14: (()+0x710b9) [0x7f4eb5af80b9]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> terminate called after
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
