From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Questions about hash functions of CRUSH
Date: Fri, 13 Apr 2012 08:55:54 -0700
Message-ID: <CAORUGqCZ8U5aEHNP+--ZVm5FS2A-Jp9cV-DU9Qr0QMHzVpVSrg@mail.gmail.com>
References: <CALwGbPJPxT+q0ThYQ0H+Th4j=J0PE=q+byCf4YTw=THtCdkqpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51523 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab2DMP4P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 11:56:15 -0400
Received: by vbbff1 with SMTP id ff1so2165058vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Apr 2012 08:56:14 -0700 (PDT)
In-Reply-To: <CALwGbPJPxT+q0ThYQ0H+Th4j=J0PE=q+byCf4YTw=THtCdkqpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 13, 2012 at 02:36, =E8=83=A1=E7=80=9A=E6=A3=AE <softrank.ne=
t@gmail.com> wrote:
> Hi everyone.
>
> I'm still reading CRUSH source code.
>
> When reading src/crush/hash.c, I've got some questions about the hash=
 function.
>
> 1. There are several magic numbers there, like=C2=A01315423911, 23123=
2,
> 1232. Are they arbitrary or do they really mean something in theory?
>
> 2.=C2=A0crush_hashmix macro is a part of Jenkins hash function. In th=
e
> series of crush_hash_rjenkins1_* functions, why input parameters are
> mixed this way instead of something else?=C2=A0Are they arbitrary or =
do
> they really mean something in theory?

Typically, hash functions have primes and similar magic numbers, and
carefully-chosen mixing functions, to strike a balance between result
uniformity, collision avoidance, and performance. CRUSH uses what is
known as a Jenkins hash, which is one of the de facto standard "fast
hashes".

See more:
http://en.wikipedia.org/wiki/Jenkins_hash_function
http://burtleburtle.net/bob/hash/evahash.html

> 3. I read the phrase "funneling hash", but I don't quite understand
> what does it mean.

=46unneling is an undesirable property in a hash function, where when
input changes in only a few bit locations, the output also changes in
only a few bit locations. More desirable is that even a single bit
change in the input causes a "big disturbance" in the output.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
