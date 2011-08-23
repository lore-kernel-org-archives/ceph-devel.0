From: Christian Brunner <chb@muc.de>
Subject: Re: rbd snapshot copy
Date: Tue, 23 Aug 2011 14:19:37 +0200
Message-ID: <CAO47_-_zoCOM=R=y4Zp4MSfBBCR8MfD9TwOmuVGPc-2CG3SZ8A@mail.gmail.com>
References: <CAO47_-8Lx=uBk5AiXJ=ute_x62USqF-ZjURbJ1ww38afaTCMWg@mail.gmail.com>
	<CAORUGqCsWGjMvjigNxFTh4a11Jspphjm5f59mc7f6N1ZyC-mcA@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44198 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1HWMTi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2011 08:19:38 -0400
Received: by vws1 with SMTP id 1so32101vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2011 05:19:37 -0700 (PDT)
In-Reply-To: <CAORUGqCsWGjMvjigNxFTh4a11Jspphjm5f59mc7f6N1ZyC-mcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sage,

I saw your patches in the git repository and have now tested them.
Everything is looking good so far.

Thanks,
Christian

2011/8/19 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Fri, Aug 19, 2011 at 01:46, Christian Brunner <chb@muc.de> wrote:
>> I tried using rbd snapshots for the first time today. Creating a
>> snapshot works, but I'm not able to copy the snapshot to a new volum=
e
>> (I'm still using 0.32).
>>
>> Here is what I get:
>>
>> # rbd snap create --snap=3Dmysnapshot myimage
>> # rbd cp --snap=3Dmysnapshot myimage mysnapcopy
>> *** Caught signal (Segmentation fault) **
>> =A0in thread 0x7fd91280a720
>> =A0ceph version 0.32 (commit:c08d08baa6a945d989427563e46c992f757ad5e=
b)
>> =A01: rbd() [0x449034]
>> =A02: (()+0xf520) [0x7fd911e00520]
>> =A03: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10) [0x7fd=
9123eb6a0]
>> =A04: (main()+0x49f) [0x443bcf]
>> =A05: (__libc_start_main()+0xfd) [0x7fd9109f4c9d]
>> =A06: rbd() [0x440f29]
>> Segmentation fault
>>
>>
>> Is this a bug or am I using the wrong syntax?
>
> I'm not 100% sure whether that syntax is meant to work, but it most
> definitely should not crash.
>
> The crash is completely reproducible. On my vstart dev environment:
>
> $ ./rbd create test --size=3D10
> $ ./rbd ls
> test
> $ ./rbd snap create --snap=3Dstest test
> $ ./rbd cp --snap=3Dstest test stest2
> *** Caught signal (Segmentation fault) **
> =A0in thread 0x7f03b296d720
> =A0ceph version 0.32-238-g75e6731
> (commit:75e673180ad48398b6995a4c27d973bf27ee376f)
> =A01: /home/tv/src/ceph.git/src/.libs/lt-rbd() [0x446d24]
> =A02: (()+0xfb40) [0x7f03b1f69b40]
> =A03: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10) [0x7f03=
b25682f0]
> =A04: (main()+0x47f) [0x44197f]
> =A05: (__libc_start_main()+0xfe) [0x7f03b098fd8e]
> =A06: /home/tv/src/ceph.git/src/.libs/lt-rbd() [0x43ed49]
>
> Segmentation fault (core dumped)
>
>
> I opened a ticket for this: http://tracker.newdream.net/issues/1416
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
