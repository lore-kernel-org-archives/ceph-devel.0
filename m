From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rbd snapshot copy
Date: Fri, 19 Aug 2011 08:57:13 -0700
Message-ID: <CAORUGqCsWGjMvjigNxFTh4a11Jspphjm5f59mc7f6N1ZyC-mcA@mail.gmail.com>
References: <CAO47_-8Lx=uBk5AiXJ=ute_x62USqF-ZjURbJ1ww38afaTCMWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36728 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab1HSP5f convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2011 11:57:35 -0400
Received: by gwaa12 with SMTP id a12so1732534gwa.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2011 08:57:35 -0700 (PDT)
In-Reply-To: <CAO47_-8Lx=uBk5AiXJ=ute_x62USqF-ZjURbJ1ww38afaTCMWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 19, 2011 at 01:46, Christian Brunner <chb@muc.de> wrote:
> I tried using rbd snapshots for the first time today. Creating a
> snapshot works, but I'm not able to copy the snapshot to a new volume
> (I'm still using 0.32).
>
> Here is what I get:
>
> # rbd snap create --snap=3Dmysnapshot myimage
> # rbd cp --snap=3Dmysnapshot myimage mysnapcopy
> *** Caught signal (Segmentation fault) **
> =C2=A0in thread 0x7fd91280a720
> =C2=A0ceph version 0.32 (commit:c08d08baa6a945d989427563e46c992f757ad=
5eb)
> =C2=A01: rbd() [0x449034]
> =C2=A02: (()+0xf520) [0x7fd911e00520]
> =C2=A03: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10) [0x7=
fd9123eb6a0]
> =C2=A04: (main()+0x49f) [0x443bcf]
> =C2=A05: (__libc_start_main()+0xfd) [0x7fd9109f4c9d]
> =C2=A06: rbd() [0x440f29]
> Segmentation fault
>
>
> Is this a bug or am I using the wrong syntax?

I'm not 100% sure whether that syntax is meant to work, but it most
definitely should not crash.

The crash is completely reproducible. On my vstart dev environment:

$ ./rbd create test --size=3D10
$ ./rbd ls
test
$ ./rbd snap create --snap=3Dstest test
$ ./rbd cp --snap=3Dstest test stest2
*** Caught signal (Segmentation fault) **
 in thread 0x7f03b296d720
 ceph version 0.32-238-g75e6731
(commit:75e673180ad48398b6995a4c27d973bf27ee376f)
 1: /home/tv/src/ceph.git/src/.libs/lt-rbd() [0x446d24]
 2: (()+0xfb40) [0x7f03b1f69b40]
 3: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10) [0x7f03b256=
82f0]
 4: (main()+0x47f) [0x44197f]
 5: (__libc_start_main()+0xfe) [0x7f03b098fd8e]
 6: /home/tv/src/ceph.git/src/.libs/lt-rbd() [0x43ed49]

Segmentation fault (core dumped)


I opened a ticket for this: http://tracker.newdream.net/issues/1416
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
