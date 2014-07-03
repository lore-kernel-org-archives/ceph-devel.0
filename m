From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: Intel ISA-L EC plugin
Date: Thu, 3 Jul 2014 21:24:59 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE748075@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:50343 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbaGCVZD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 17:25:03 -0400
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,=20

I have chosen after benchmarking to use the LRU cache for the decoding =
matrix. I can cache easily all decoding matrices (worst case scenario) =
for configurations up to (10,4) without trashing it. I will restrict th=
e (k,m) in case of the vandermonde matrix to the ones which are inverti=
ble, for cauchy they are all invertible anyway.

I will rebase to your branch wip-7238-lrc then!

Cheers Andreas.


________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 02 July 2014 20:33
To: Andreas Joachim Peters; ceph-devel@vger.kernel.org
Subject: Re: FW: Intel ISA-L EC plugin

Hi Andreas,

On 02/07/2014 19:54, Andreas Joachim Peters wrote:> Hi Sage & Loic et a=
l ...
> getting some support from Paul Luse I have finished the refactoring o=
f the EC ISA-L plug-in.
>
>
> The essential ISA-L v 2.10 sources are now part of the source tree an=
d it builds a single shared library which is portable on platforms with=
 varying CPU extensions (SSE2, AVX, AVX2). I tested on various Intel & =
AMD processor types.
>
> The build of the plug-in is coupled to the presence of 'yasm' similia=
r to the crc32c extension in common/ ... (I couldn't build ISA-L on ARM=
).
>
> It supports two encoding matrices Vandermonde & Cauchy. The technique=
s are called similar to the one used by Loic in Jerasure "reed_sol_van"=
 & "cauchy". "cauchy" is the default.
>
> Greg Tucker from Intel pointed me to the proper ( and faster ) way of=
 decoding if parity chunks are missing.

Great !

> ??? How do we proceed? I currently rebase against firefly and use its=
 API definition or should this be for a later release with Loic's refac=
tored interface? Shall I make a pull request or shall I hand it over to=
 Loic and he takes care to do the integration including QA etc ...?

It would be great if you could rebase against https://github.com/dachar=
y/ceph/tree/wip-7238-lrc. It contains the base class that will help us =
share code common to plugins. I hope it will be merged in the next few =
days. During the last CDS the remapping of the data chunks has been agr=
eed on and the only reason why it is not yet merged is that integration=
 tests must first show it does not break anything and is fully backward=
 compatible.

Cheers

> ??? I have still an open question on the library optimization for dec=
oding(=3Drepair). If you call decoding for a certain set one needs to d=
o a matrix inversion coupled to the given set. If the payload is like 1=
M the computation of the decoding matrix does not
>  play a role. If the payload is 4k it plays a role. Can I assume that=
 the plugin will be called concurrently for the same object with the sa=
me set of chunks or would the plugin be called interleaved for many obj=
ects with changing chunk configurations? Is the
>  EC object called single-threaded or by a thread pool? Will backfilll=
 use 4k IOs or larger?
>
> I would either commit the simple cache mechanism caching the last com=
puted erasure configuration & corresponding matrix or put an LRU cache =
for the last computed matrices. I prototyped both, but would stick to t=
he simplest required.
>
> Cheers Andreas.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
