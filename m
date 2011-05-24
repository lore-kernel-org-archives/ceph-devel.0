From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: qemu librbd patches
Date: Tue, 24 May 2011 13:10:56 -0700
Message-ID: <4DDC10D0.2060004@dreamhost.com>
References: <BANLkTim4jTVJH5y6o5rHq8pm_KfH0Jiz0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35876 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab1EXUK5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 16:10:57 -0400
In-Reply-To: <BANLkTim4jTVJH5y6o5rHq8pm_KfH0Jiz0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On 05/09/2011 01:59 AM, Christian Brunner wrote:
> Hi,
>
> after upgrading to qemu with josh's librbd patches I'm triggering the
> following assertion, when I'm running "yum upgrade" inside a guest.
>
> I suspect there is a race condition somewhere, but I don't have a clue
> at the moment.
>
> Regards,
> Christian
>
> common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread '0x7fea16b36700'
> common/Mutex.h: 118: FAILED assert(r == 0)
> common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread '0x7fea16b36700'
> common/Mutex.h: 118: FAILED assert(r == 0)
>   ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff)
>   1: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>   2: /usr/bin/qemu-kvm() [0x46a165]
>   3: /usr/bin/qemu-kvm() [0x46a1d0]
>   4: /usr/bin/qemu-kvm() [0x44349f]
>   ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff)
>   1: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>   2: /usr/bin/qemu-kvm() [0x46a165]
>   3: /usr/bin/qemu-kvm() [0x46a1d0]
>   4: /usr/bin/qemu-kvm() [0x44349f]
>   ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff)
>   1: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>   2: /usr/bin/qemu-kvm() [0x46a165]
>   3: /usr/bin/qemu-kvm() [0x46a1d0]
>   4: /usr/bin/qemu-kvm() [0x44349f]
>   ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff)
>   1: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>   2: /usr/bin/qemu-kvm() [0x46a165]
>   3: /usr/bin/qemu-kvm() [0x46a1d0]
>   4: /usr/bin/qemu-kvm() [0x44349f]
> terminate called after throwing an instance of 'ceph::FailedAssertion'

Hi Christian,

Could you try to get a core file for this? I still haven't been able to 
reproduce it.

Thanks,
Josh
