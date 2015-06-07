From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Looking to improve small I/O performance
Date: Sun, 7 Jun 2015 00:06:20 -0600
Message-ID: <CAANLjFpJHR0RmHF4TfS1H4YRSQmyH20Sfh7kwOv7JKeD0mNYGg@mail.gmail.com>
References: <CAANLjFrL_KcmiCkbKjqMNoCY3hByEap2JYBFRJFeH3MG41qWrg@mail.gmail.com>
	<90559C83A9C7FA45B5846C975DFA612DDB4B031512@ABGEX73E.FSC.NET>
	<CAANLjFqtyQEDQXWF-sC-Qc2ewWyNyfEMSxiH9QBm=Q-Pi=zhTA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9BF3A@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35488 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbFGGGV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Jun 2015 02:06:21 -0400
Received: by wgme6 with SMTP id e6so80833662wgm.2
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2015 23:06:20 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9BF3A@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

This is the test that we are running that simulates the workload size
and ratios of our typical servers. Of course we are not doing direct
I/O on our real workloads and the threads and jobs is arbitrary, but
it gives us an idea of the performance we could expect.

fio --name fio_test --rw randrw --bssplit
4k/85:32k/11:512/3:1m/1,4k/89:32k/10:512k/1 --ioengine libaio
--iodepth 8 --numjobs 8 --direct 1 --rwmixread 72 --norandommap
--minimal --size=3D2500MB --runtime=3D300 --time_based --thread

Right now we are spindle with SSD journals. We have not configured SSD
tiering, but I'm not sure it will help much given the low ratio of SSD
to spindle.

I'll do some tests on our dev cluster and see what I come up with.
Would doing this test be pretty pointless with 0.94.1, should I be
looking at master because there are significant improvements?

Thanks,
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVc99ZCRDmVDuy+mK58QAALJ8P/jDohnzb6PB+OxHSjwqx
MPBuhdgkEzFa3s0Kk7PGR/ZKQUg+KR6nAWy8Ja8Ee0ToMN9vOjZOXtKcdI3a
EEZh3BdmyArjOvIdZiUP9Dkl9wQhkJgDnA/Ssg1s+3KkamFh7MfS+rzj0KiX
ivg+0SZos3Y3J1Lt1MFbbCRAbjMquHhDOe1YgPg+uETJlOkRjtgxTMN8FCWI
VZYWn3uzSeMOoGGLMfE6H2p4WMMTPQdTEYz1ofi2hYC9GbAnUdk8hHUj5Np7
kqA9nJUZ+TIMS3sFg62Vy01iBlk//TUJIexanprzRsjQT03sju/QIcsAqksy
Cvtc+VF8HJgr9eWryyVS1k5tpmP6bk+l3v1zIjBugTgxFj0p3frizhVXmz2s
O00bsgenrdrzu/W7lK43V2Jhrt8UM2qVfZfJKYfpo+VGLvA/FSxYfpPJKbd3
gS2oE4ldRDjg7k0+GafO4bONBo9MmSmwRzjiBl/RScqn1GzX2mqaaokr12+E
H9ZJ4B8u3UkI+VyLdRCOYxTuPtnByvOlkIQRQvG/p2Au8fQPuzV0iB2d1Zu8
BEcI2LpDxzzsXHI6HXnMqEkXtK/XoEhYDc4RL2cdByQocsqCUZU4RKWKoUEJ
wOKDGCh66g5BynnvoRo6dx/NcN5z10A1YkIP0v0rBgK+X80dZ/yZMr3jB5o6
7Ghj
=3Dp3Iq
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Sat, Jun 6, 2015 at 10:44 AM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:
> Robert,
> You can try the following config option to enable asyn messenger.
>
> ms_type =3D async
> enable_experimental_unrecoverable_data_corrupting_features =3D ms-typ=
e-async
>
> BTW, what kind of workload you are trying , random read or write ?
> Also, is this SSD or HDD cluster ?
>
> Thanks & Regards
> Somnath
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Robert LeBlanc
> Sent: Saturday, June 06, 2015 8:06 AM
> To: Da=C5=82ek, Piotr
> Cc: ceph-devel
> Subject: Re: Looking to improve small I/O performance
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> I found similar results in my testing as well. Ceph is certainly grea=
t at large I/O, but our workloads are in the small I/O range. I underst=
and that latency plays a huge role when I/O is small. Since we have 10 =
and 40 Gb Ethernet, we can't get much lower in latency that way (Infini=
band is not an option right now). So I was poking around to see if ther=
e was some code optimizations that might reduce latency (not that I'm s=
mart enough to do the coding myself).
>
> I was surprised when enabling QEMU writeback cache and set the cache =
to the working set size, I really didn't get any additional performance=
=2E After the first run the QEMU process allocated almost all the memor=
y. I believe after several runs, there was some improvement, but not wh=
at I expected.
>
> What is the status of the async messenger, it looks like it is experi=
mental in the code? How do you enable it, I can't seem to find a config=
 option, does Ceph have to be compiled with it? I would like to test it=
 on my dev cluster.
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
> On Sat, Jun 6, 2015 at 12:07 AM, Da=C5=82ek, Piotr <Piotr.Dalek@ts.fu=
jitsu.com> wrote:
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>>
>>> I'm digging into perf and the code to see here/how I might be able =
to
>>> improve performance for small I/O around 16K.
>>>
>>> I ran fio with rados and used perf to record. Looking through the
>>> report, there is a very substantial amount of time creating threads
>>> (or so it looks, but I'm really new to perf). It seems to point to
>>> messenger, so I looked in the code. From perf if looks like thread
>>> pooling isn't happening, but from what I can gather from the code, =
it should.
>>> [..]
>>
>> This is so because you use SimpleMessenger, which can't handle small=
 I/O well.
>> Indeed, threads are problematic with it, as well as memory allocatio=
n.
>> I did some benchmarking some time ago and the gist of it is that you
>> could try going for AsyncMessenger and see if it helps. You can also=
 see my results here:
>> http://stuff.predictor.org.pl/chunksize.xlsx
>> From there you can see that most of the time of small I/Os in
>> SimpleMessenger Is spent in tcmalloc code, and also there's a
>> performance drop around 64k Blocksize in Async Messenger.
>>
>> With best regards / Pozdrawiam
>> Piotr Da=C5=82ek
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
