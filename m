From: Christian Brunner <chb@muc.de>
Subject: Re: qemu librbd patches
Date: Wed, 25 May 2011 21:09:20 +0200
Message-ID: <BANLkTinSnGqmBp6VfHwrTqMFqbme97hqPw@mail.gmail.com>
References: <BANLkTim4jTVJH5y6o5rHq8pm_KfH0Jiz0w@mail.gmail.com>
	<4DDC10D0.2060004@dreamhost.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62352 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab1EYTJY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 15:09:24 -0400
Received: by vxi39 with SMTP id 39so6025407vxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2011 12:09:21 -0700 (PDT)
In-Reply-To: <4DDC10D0.2060004@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm sorry. At the moment I don't have a core file available and my
colleagues don't allow me to reproduce it. ;-)

We should get a new server in one or two weeks. I will try to get a cor=
e then.

Christian

2011/5/24 Josh Durgin <josh.durgin@dreamhost.com>:
> On 05/09/2011 01:59 AM, Christian Brunner wrote:
>>
>> Hi,
>>
>> after upgrading to qemu with josh's librbd patches I'm triggering th=
e
>> following assertion, when I'm running "yum upgrade" inside a guest.
>>
>> I suspect there is a race condition somewhere, but I don't have a cl=
ue
>> at the moment.
>>
>> Regards,
>> Christian
>>
>> common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread
>> '0x7fea16b36700'
>> common/Mutex.h: 118: FAILED assert(r =3D=3D 0)
>> common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread
>> '0x7fea16b36700'
>> common/Mutex.h: 118: FAILED assert(r =3D=3D 0)
>> =A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b=
8ff)
>> =A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
>> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>> =A02: /usr/bin/qemu-kvm() [0x46a165]
>> =A03: /usr/bin/qemu-kvm() [0x46a1d0]
>> =A04: /usr/bin/qemu-kvm() [0x44349f]
>> =A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b=
8ff)
>> =A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
>> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>> =A02: /usr/bin/qemu-kvm() [0x46a165]
>> =A03: /usr/bin/qemu-kvm() [0x46a1d0]
>> =A04: /usr/bin/qemu-kvm() [0x44349f]
>> =A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b=
8ff)
>> =A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
>> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>> =A02: /usr/bin/qemu-kvm() [0x46a165]
>> =A03: /usr/bin/qemu-kvm() [0x46a1d0]
>> =A04: /usr/bin/qemu-kvm() [0x44349f]
>> =A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b=
8ff)
>> =A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
>> long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
>> =A02: /usr/bin/qemu-kvm() [0x46a165]
>> =A03: /usr/bin/qemu-kvm() [0x46a1d0]
>> =A04: /usr/bin/qemu-kvm() [0x44349f]
>> terminate called after throwing an instance of 'ceph::FailedAssertio=
n'
>
> Hi Christian,
>
> Could you try to get a core file for this? I still haven't been able =
to
> reproduce it.
>
> Thanks,
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
