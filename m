From: Samuel Just <sam.just@inktank.com>
Subject: Re: rbd caching issue
Date: Thu, 20 Dec 2012 16:19:57 -0800
Message-ID: <CA+4uBUZG-f2UMbPhH0nG7xpZ3Hy-CVZLDBw6pfM-fBP5xCDEcg@mail.gmail.com>
References: <50D02B47.3030606@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:55829 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab2LUAT6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 19:19:58 -0500
Received: by mail-vb0-f50.google.com with SMTP id fr13so4446749vbb.23
        for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 16:19:57 -0800 (PST)
In-Reply-To: <50D02B47.3030606@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>, Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Josh,

Does this look like just more cpu usage due to caching?

-Sam

On Tue, Dec 18, 2012 at 12:37 AM, Jens Rehp=F6hler
<jens.rehpoehler@filoo.de> wrote:
> Hi folks,
>
> i just received a mail of a customer. He reclaimed that the "ping
> latency" of his VM rises, if he does a lot of IO
> inside of the VM. I have done the same with a test VM.
>
> I could reproduce this behavior. If i disable the rbd cache the VM IO=
 is
> slower but the latency is ok. Even SSH und other
> programs are affected .... so its not a problem of slow ICMP.
>
> Device Setting:
>
> virtio0:
> rbd:9997/vm-1171-disk-1.rbd:rbd_cache=3Dtrue:rbd_cache_size=3D1677721=
6:rbd_cache_max_dirty=3D8388608:rbd_cache_target_dirty=3D4194304,cache=3D=
none
>
> normal ping:
>
> 64 bytes from 109.75.x.x: icmp_seq=3D38 ttl=3D56 time=3D29.2 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D39 ttl=3D56 time=3D20.8 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D40 ttl=3D56 time=3D22.4 ms
>
> with lots of IO:
>
> 64 bytes from 109.75.x.x: icmp_seq=3D87 ttl=3D56 time=3D28.1 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D88 ttl=3D56 time=3D665 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D89 ttl=3D56 time=3D226 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D90 ttl=3D56 time=3D179 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D91 ttl=3D56 time=3D140 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D92 ttl=3D56 time=3D25.6 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D93 ttl=3D56 time=3D568 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D94 ttl=3D56 time=3D405 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D95 ttl=3D56 time=3D223 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D96 ttl=3D56 time=3D24.5 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D97 ttl=3D56 time=3D321 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D98 ttl=3D56 time=3D391 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D99 ttl=3D56 time=3D4200 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D101 ttl=3D56 time=3D2194 ms
>
> But if i disable caching:
>
> virtio0: rbd:9997/vm-1171-disk-1.rbd:rbd_cache=3Dfalse,cache=3Dwriteb=
ack
>
> with lots of IO:
>
> 64 bytes from 109.75.x.x: icmp_seq=3D62 ttl=3D56 time=3D22.1 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D63 ttl=3D56 time=3D26.5 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D64 ttl=3D56 time=3D30.7 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D65 ttl=3D56 time=3D24.8 ms
> 64 bytes from 109.75.x.x: icmp_seq=3D66 ttl=3D56 time=3D21.9 ms
>
> Can someone please explain me this behavior ? Why is the latency of t=
he
> VM spiky if i enable rbd caching ? I've played around with the cachin=
g
> parameters
> but with caching enabled its always the same.
>
> KVM Version: 1.2.1
> Ceph Version: ceph version 0.48.2argonaut
> (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
>
> Thanks a lot !!
>
> --
> mit freundlichen Gr=FCssen
>
> Jens Rehp=F6hler
>
> ---------------------------------------------------------------------=
-
> filoo GmbH
> Moltkestr. 25a
> 33330 G=FCtersloh
> HRB4355 AG G=FCtersloh
>
> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | Dr. C.Kunz
> Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
> Hotline: +49 5241 8673026| Fax: +49 5241 8673020
>
> Folgen Sie uns auf:
> Twitter: http://twitter.com/filoogmbh
> Facebook: http://facebook.com/filoogmbh
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
