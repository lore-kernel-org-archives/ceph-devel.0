From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Intel Erasure Code library
Date: Mon, 16 Dec 2013 13:10:26 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6ABD29@PLOXCHG03.cern.ch>
References: <52AECE62.9030102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:9241 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab3LPNKa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 08:10:30 -0500
In-Reply-To: <52AECE62.9030102@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20
this looks excellent on new INTEL hardware .... certainly ;-)

I was just running some benchmarks on different platforms. It should be=
 extremely simple to make a plugin ... the API is simple ...

I configured (10+4):

1)
model name	: Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz
stepping	: 7
cpu MHz		: 2001.000
cache size	: 20480 KB

(cold cache)
erasure_code_encode_cold: runtime =3D     684410 usecs, bandwidth 3199 =
MB in 0.6844 sec =3D 4902.61 MB/s
erasure_code_decode_cold: runtime =3D     340002 usecs, bandwidth 2239 =
MB in 0.3400 sec =3D 6908.12 MB/s (recover 3)
erasure_code_decode_cold: runtime =3D     176811 usecs, bandwidth 1599 =
MB in 0.1768 sec =3D 9488.64 MB/s (recover 1)

(warm cache)
erasure_code_encode_warm: runtime =3D    1744615 usecs, bandwidth 9985 =
MB in 1.7446 sec =3D 6001.55 MB/s
erasure_code_decode_warm: runtime =3D     860179 usecs, bandwidth 6989 =
MB in 0.8602 sec =3D 8520.65 MB/s (recover 3)


2)
model name      : AMD Opteron(TM) Processor 6276                =20
stepping        : 2
cpu MHz         : 2300.000
cache size      : 2048 KB

(cold cache)
erasure_code_encode_cold: runtime =3D    1769806 usecs, bandwidth 3199 =
MB in 1.7698 sec =3D 1895.91 MB/s
erasure_code_decode_cold: runtime =3D    1135461 usecs, bandwidth 2239 =
MB in 1.1355 sec =3D 2068.56 MB/s (recover 3)
erasure_code_decode_cold: runtime =3D     553315 usecs, bandwidth 1599 =
MB in 0.5533 sec =3D 3032.08 MB/s (recover 1)

(warm cache)
erasure_code_encode_warm: runtime =3D    2158180 usecs, bandwidth 9985 =
MB in 2.1582 sec =3D 4851.50 MB/s
erasure_code_decode_warm: runtime =3D    1133059 usecs, bandwidth 6989 =
MB in 1.1331 sec =3D 6468.58 MB/s (recover 3)


3) [running in a virtual machine!!!]

model name	: Intel Core i7 9xx (Nehalem Class Core i7)
stepping	: 3
cpu MHz		: 2266.746
cache size	: 4096 KB

(cold cache)
erasure_code_encode_cold: runtime =3D    1125543 usecs, bandwidth 3199 =
MB in 1.1255 sec =3D 2981.13 MB/s
erasure_code_decode_cold: runtime =3D     554727 usecs, bandwidth 2239 =
MB in 0.5547 sec =3D 4234.11 MB/s (recover 3)
erasure_code_decode_cold: runtime =3D     324933 usecs, bandwidth 1599 =
MB in 0.3249 sec =3D 5163.21 MB/s (recover 1)

(warm cache)
erasure_code_encode_warm: runtime =3D    2636439 usecs, bandwidth 9985 =
MB in 2.6364 sec =3D 3971.42 MB/s
erasure_code_decode_warm: runtime =3D    1263597 usecs, bandwidth 6989 =
MB in 1.2636 sec =3D 5800.33 MB/s (recover 3)

4)
model name      : Intel(R) Xeon(R) CPU           L5520  @ 2.27GHz
stepping        : 5
cpu MHz         : 1600.000
cache size      : 8192 KB

(cold cache)
erasure_code_encode_cold: runtime =3D    1166904 usecs, bandwidth 3199 =
MB in 1.1669 sec =3D 2875.47 MB/s
erasure_code_decode_cold: runtime =3D     345337 usecs, bandwidth 1599 =
MB in 0.3453 sec =3D 4858.14 MB/s (recover 1)
erasure_code_decode_cold: runtime =3D     575194 usecs, bandwidth 2239 =
MB in 0.5752 sec =3D 4083.45 MB/s (recover 3)

(warm cache)
erasure_code_encode_warm: runtime =3D    2686134 usecs, bandwidth 9985 =
MB in 2.6861 sec =3D 3897.94 MB/s
erasure_code_decode_warm: runtime =3D     777904 usecs, bandwidth 4992 =
MB in 0.7779 sec =3D 6729.88 MB/s (recover 1)
erasure_code_decode_warm: runtime =3D    1278117 usecs, bandwidth 6989 =
MB in 1.2781 sec =3D 5734.44 MB/s (recover 3)

5)
model name	: Intel(R) Xeon(R) CPU           L5520  @ 2.27GHz
stepping	: 5
cpu MHz		: 1600.000
cache size	: 8192 KB

(cold cache)
erasure_code_encode_cold: runtime =3D     956274 usecs, bandwidth 3199 =
MB in 0.9563 sec =3D 3508.82 MB/s
erasure_code_decode_cold: runtime =3D     264835 usecs, bandwidth 1599 =
MB in 0.2648 sec =3D 6334.87 MB/s (recover 1)
erasure_code_decode_cold: runtime =3D     463120 usecs, bandwidth 2239 =
MB in 0.4631 sec =3D 5071.63 MB/s (recover 3)


(warm cache)
erasure_code_encode_warm: runtime =3D    2601232 usecs, bandwidth 9985 =
MB in 2.6012 sec =3D 4025.17 MB/s
erasure_code_decode_warm: runtime =3D     683921 usecs, bandwidth 4992 =
MB in 0.6839 sec =3D 7654.69 MB/s (recover 1)
erasure_code_decode_warm: runtime =3D    1258408 usecs, bandwidth 6989 =
MB in 1.2584 sec =3D 5824.25 MB/s (recover 3)

___________________________________
=46rom: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.=
org] on behalf of Loic Dachary [loic@dachary.org]
Sent: 16 December 2013 10:56
To: Ceph Development
Subject: Intel Erasure Code library

Hi,

A new Erasure Code library has been released as Free Software

https://01.org/storage-acceleration-library/downloads/2013/isa-l-open-s=
ource-release

It is quite tempting to write a Ceph erasure code plugin for it and see=
 how it performs :-)

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
