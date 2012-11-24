From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: syncfs via syscall doesn not work
Date: Sat, 24 Nov 2012 21:24:33 +0100
Message-ID: <50B12D01.3030308@profihost.ag>
References: <50AF31AB.1050402@profihost.ag> <alpine.DEB.2.00.1211231907330.23552@cobra.newdream.net> <7D302B0D-898C-45F6-A60A-A43DB78C7479@profihost.ag> <alpine.DEB.2.00.1211240859340.23552@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35389 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab2KXUYc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 15:24:32 -0500
In-Reply-To: <alpine.DEB.2.00.1211240859340.23552@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.11.2012 18:16, schrieb Sage Weil:
> On Sat, 24 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> At the machine compiling? Yes!
>
> Hmm, I just tested on my wonky wheezy machine (glibc 2.13, 3.2) and
> system(SYS_syncfs, ..) works for me.  But the #define is in libc6-dev:

But that means your glibc supports it. Then we don't need the syscall at 
all.

To me it's only present in the kernel headers (linux-libc-dev) like this:

[pb64: ~]# grep -r syncfs /usr/include
/usr/include/asm/unistd_64.h:#define __NR_syncfs 
      306
/usr/include/asm/unistd_64.h:__SYSCALL(__NR_syncfs, sys_syncfs)
/usr/include/asm/unistd_32.h:#define __NR_syncfs             344
/usr/include/asm-generic/unistd.h:#define __NR_syncfs 267
/usr/include/asm-generic/unistd.h:__SYSCALL(__NR_syncfs, sys_syncfs)

Greets,
Stefan
