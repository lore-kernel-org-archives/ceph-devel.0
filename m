From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Looking to improve small I/O performance
Date: Sat, 6 Jun 2015 17:38:43 +0800
Message-ID: <CACJqLyb-o+8kC_UWX8nBKohkV=C_ySAMe1UADGTMWyxfSN24iA@mail.gmail.com>
References: <CAANLjFrL_KcmiCkbKjqMNoCY3hByEap2JYBFRJFeH3MG41qWrg@mail.gmail.com>
	<90559C83A9C7FA45B5846C975DFA612DDB4B031512@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34027 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbFFJio convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jun 2015 05:38:44 -0400
Received: by payr10 with SMTP id r10so64800130pay.1
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2015 02:38:44 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB4B031512@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Jun 6, 2015 at 2:07 PM, Da=C5=82ek, Piotr <Piotr.Dalek@ts.fujit=
su.com> wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>
>> I'm digging into perf and the code to see here/how I might be able t=
o
>> improve performance for small I/O around 16K.
>>
>> I ran fio with rados and used perf to record. Looking through the re=
port,
>> there is a very substantial amount of time creating threads (or so i=
t looks, but
>> I'm really new to perf). It seems to point to messenger, so I looked=
 in the
>> code. From perf if looks like thread pooling isn't happening, but fr=
om what I
>> can gather from the code, it should.
>> [..]
>
> This is so because you use SimpleMessenger, which can't handle small =
I/O well.
> Indeed, threads are problematic with it, as well as memory allocation=
=2E I did some
> benchmarking some time ago and the gist of it is that you could try g=
oing for
> AsyncMessenger and see if it helps. You can also see my results here:
> http://stuff.predictor.org.pl/chunksize.xlsx
> From there you can see that most of the time of small I/Os in SimpleM=
essenger
> Is spent in tcmalloc code, and also there's a performance drop around=
 64k
> Blocksize in Async Messenger.
>

Thanks for your benchmark, I submit new performance enhanced patchset
for AsyncMessenger. It should solve original stress test performance
degraded problem :-)

> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
