From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Looking to improve small I/O performance
Date: Sun, 7 Jun 2015 00:44:28 +0800
Message-ID: <CACJqLyZdm-hgR0Z9b=08mnbMJdxiNWd1OfkAsC7+nVg3xM74hA@mail.gmail.com>
References: <CAANLjFrL_KcmiCkbKjqMNoCY3hByEap2JYBFRJFeH3MG41qWrg@mail.gmail.com>
	<90559C83A9C7FA45B5846C975DFA612DDB4B031512@ABGEX73E.FSC.NET>
	<CAANLjFqtyQEDQXWF-sC-Qc2ewWyNyfEMSxiH9QBm=Q-Pi=zhTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33063 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbbFFQo2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jun 2015 12:44:28 -0400
Received: by padev16 with SMTP id ev16so10563952pad.0
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2015 09:44:28 -0700 (PDT)
In-Reply-To: <CAANLjFqtyQEDQXWF-sC-Qc2ewWyNyfEMSxiH9QBm=Q-Pi=zhTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

We could wait for the next benchmark until this
PR(https://github.com/ceph/ceph/pull/4775) merged

On Sat, Jun 6, 2015 at 11:06 PM, Robert LeBlanc <robert@leblancnet.us> =
wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> I found similar results in my testing as well. Ceph is certainly grea=
t
> at large I/O, but our workloads are in the small I/O range. I
> understand that latency plays a huge role when I/O is small. Since we
> have 10 and 40 Gb Ethernet, we can't get much lower in latency that
> way (Infiniband is not an option right now). So I was poking around t=
o
> see if there was some code optimizations that might reduce latency
> (not that I'm smart enough to do the coding myself).
>
> I was surprised when enabling QEMU writeback cache and set the cache
> to the working set size, I really didn't get any additional
> performance. After the first run the QEMU process allocated almost al=
l
> the memory. I believe after several runs, there was some improvement,
> but not what I expected.
>
> What is the status of the async messenger, it looks like it is
> experimental in the code? How do you enable it, I can't seem to find =
a
> config option, does Ceph have to be compiled with it? I would like to
> test it on my dev cluster.

Yes, it's a experimental and you only need to enable this in config
value. No other need to do for compiling.



>
> Thanks,
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v0.13.1
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJVcwxfCRDmVDuy+mK58QAAIJ0P/iz05KKuNw1Ypk3xsg/v
> 7MzrSw70+RZMJd4qOs8OFrBC+IiX1KBOlgrrtAjKRygWgYgK3Aqzw5DEu1RN
> 2tJiGai9e5Vch/wl+OHhP7S07Q2eN7fJJS+OFtA481XBNeFGhdywhOYenJjk
> RcDSJcVPgcrPB5SI90UqycwxLjH+XBotFHycuwyHj4LqkHXf4tM4Nbi4A1RV
> xOhVPQxWlaregwOaS8b8kwFUzkLQic1mMNgSMizpSiPnLuXUnfI7pjtvjOYU
> ld6QmZgu+xKC/qIJm8ToOJUVD3IkSbpv8Ngs73K12h/3C8mj4+uY4qJWouG4
> RU3sFMfKgVeNDPSIsjO7Zy9s5/lp64RqPcblj72+3yYC+YJ4ZhLAwRyhtSvO
> VXkLheZRtMemWbrOCQKinWAlH+m0dwAHv816oFFvkFdOYl/xmmiTo9ctNBqC
> MVK9tm01DRqA23MFFNQ25lvHzFv3zZ7aPWLeqRin8F7dddwBauva/J7GyFC0
> bk0mPi83++LQt3r+PUMYCOS+aG+0f8oM8/uValUfEGr4+pcjyI/dZk1k0Q6c
> cImb2cmy16OgrfzN7isYt7z37dUlQT/2rC74LvTscIIdf1dZQHWwXHelRm49
> y1pxq07V7LlL6gM+zA6Zskm9QwlJ3D81mH7QpiaixKX8cEzcVifD7WUzP/YV
> Go8K
> =3DgB4o
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Sat, Jun 6, 2015 at 12:07 AM, Da=C5=82ek, Piotr
> <Piotr.Dalek@ts.fujitsu.com> wrote:
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>>
>>> I'm digging into perf and the code to see here/how I might be able =
to
>>> improve performance for small I/O around 16K.
>>>
>>> I ran fio with rados and used perf to record. Looking through the r=
eport,
>>> there is a very substantial amount of time creating threads (or so =
it looks, but
>>> I'm really new to perf). It seems to point to messenger, so I looke=
d in the
>>> code. From perf if looks like thread pooling isn't happening, but f=
rom what I
>>> can gather from the code, it should.
>>> [..]
>>
>> This is so because you use SimpleMessenger, which can't handle small=
 I/O well.
>> Indeed, threads are problematic with it, as well as memory allocatio=
n. I did some
>> benchmarking some time ago and the gist of it is that you could try =
going for
>> AsyncMessenger and see if it helps. You can also see my results here=
:
>> http://stuff.predictor.org.pl/chunksize.xlsx
>> From there you can see that most of the time of small I/Os in Simple=
Messenger
>> Is spent in tcmalloc code, and also there's a performance drop aroun=
d 64k
>> Blocksize in Async Messenger.
>>
>> With best regards / Pozdrawiam
>> Piotr Da=C5=82ek
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
