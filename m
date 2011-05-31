From: djlee064 <djlee064@gmail.com>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 14:26:35 +1200
Message-ID: <BANLkTi=Pew-stDVCxUQoa5t2s5P8pWRomA@mail.gmail.com>
References: <4DE41F34.8020504@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57412 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab1EaC0g convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 May 2011 22:26:36 -0400
Received: by pvg12 with SMTP id 12so1815183pvg.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 May 2011 19:26:35 -0700 (PDT)
In-Reply-To: <4DE41F34.8020504@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

A bit off, but can you Fyodor, and all of devs run

dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D10000   (10gb)
dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D50000   (50gb)
dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D100000 (100gb)

and continue to 200gb,... 500gb

see the MB/s difference,  expecting an enormous difference, e.g.,
starts ~200MB/s and drops down to well less than 50MB/s or even less
(Depending on the #disk, but about 12MB/s per-disk is what I have
analyzed)
I feel that Fyodor's and the rest of you are testing only a very small
part, the high rate at the start is likely to be due to the journal
size.
Again, I need a correction.
Thanks, DJ

On Tue, May 31, 2011 at 10:50, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi!
>
> Fresh 0.28.2 cluster.
>
> Why reading two times slower than the writing by dd, but rados show
> different.
> (Second question - why rados bench crash on read test?)
>
>
> root@gate0:/mnt# dd if=3D/dev/zero of=3Daaa bs=3D1024000 count=3D1000=
0
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 64.5598 s, 159 MB/s
>
> root@gate0:/mnt# dd if=3Daaa of=3D/dev/null bs=3D1024000
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 122.513 s, 83.6 MB/s
> root@gate0:/mnt#
>
> root@gate0:/etc/ceph# rados -p test bench 20 write
> Maintaining 16 concurrent writes of 4194304 bytes for at least 20 sec=
onds.
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0las=
t lat =A0 avg lat
> =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A01 =A0 =A0 =A016 =A0 =A0 =A0 =A047 =A0 =A0 =A0 =A031 =A0 123.96=
6 =A0 =A0 =A0 124 =A00.445371 =A00.360663
> =A0 =A02 =A0 =A0 =A016 =A0 =A0 =A0 =A082 =A0 =A0 =A0 =A066 =A0 131.96=
7 =A0 =A0 =A0 140 =A00.160564 =A0 0.32065
> =A0 =A03 =A0 =A0 =A016 =A0 =A0 =A0 111 =A0 =A0 =A0 =A095 =A0 126.637 =
=A0 =A0 =A0 116 =A00.116967 =A00.349943
> =A0 =A04 =A0 =A0 =A016 =A0 =A0 =A0 142 =A0 =A0 =A0 126 =A0 =A0125.97 =
=A0 =A0 =A0 124 =A00.176179 =A00.369969
> =A0 =A05 =A0 =A0 =A015 =A0 =A0 =A0 169 =A0 =A0 =A0 154 =A0 =A0123.17 =
=A0 =A0 =A0 112 =A0 0.12449 =A00.411138
> =A0 =A06 =A0 =A0 =A016 =A0 =A0 =A0 202 =A0 =A0 =A0 186 =A0 123.971 =A0=
 =A0 =A0 128 =A00.175033 =A00.442003
> =A0 =A07 =A0 =A0 =A016 =A0 =A0 =A0 241 =A0 =A0 =A0 225 =A0 128.541 =A0=
 =A0 =A0 156 =A00.163481 =A00.421575
> =A0 =A08 =A0 =A0 =A016 =A0 =A0 =A0 271 =A0 =A0 =A0 255 =A0 =A0127.47 =
=A0 =A0 =A0 120 =A00.162152 =A00.444525
> =A0 =A09 =A0 =A0 =A016 =A0 =A0 =A0 305 =A0 =A0 =A0 289 =A0 128.415 =A0=
 =A0 =A0 136 =A00.100893 =A00.456108
> =A0 10 =A0 =A0 =A016 =A0 =A0 =A0 337 =A0 =A0 =A0 321 =A0 128.371 =A0 =
=A0 =A0 128 =A00.107163 =A00.467081
> =A0 11 =A0 =A0 =A016 =A0 =A0 =A0 370 =A0 =A0 =A0 354 =A0 128.698 =A0 =
=A0 =A0 132 =A00.147602 =A00.455438
> =A0 12 =A0 =A0 =A016 =A0 =A0 =A0 400 =A0 =A0 =A0 384 =A0 127.971 =A0 =
=A0 =A0 120 =A00.163287 =A00.454927
> =A0 13 =A0 =A0 =A016 =A0 =A0 =A0 433 =A0 =A0 =A0 417 =A0 128.279 =A0 =
=A0 =A0 132 =A00.176282 =A00.451909
> =A0 14 =A0 =A0 =A016 =A0 =A0 =A0 459 =A0 =A0 =A0 443 =A0 126.544 =A0 =
=A0 =A0 104 =A0 3.02971 =A00.465092
> =A0 15 =A0 =A0 =A016 =A0 =A0 =A0 492 =A0 =A0 =A0 476 =A0 126.906 =A0 =
=A0 =A0 132 =A00.183307 =A00.473582
> =A0 16 =A0 =A0 =A016 =A0 =A0 =A0 523 =A0 =A0 =A0 507 =A0 126.722 =A0 =
=A0 =A0 124 =A00.170459 =A00.465038
> =A0 17 =A0 =A0 =A016 =A0 =A0 =A0 544 =A0 =A0 =A0 528 =A0 124.208 =A0 =
=A0 =A0 =A084 =A00.160463 =A00.462053
> =A0 18 =A0 =A0 =A016 =A0 =A0 =A0 574 =A0 =A0 =A0 558 =A0 123.973 =A0 =
=A0 =A0 120 =A0 0.10411 =A00.478344
> =A0 19 =A0 =A0 =A016 =A0 =A0 =A0 607 =A0 =A0 =A0 591 =A0 124.395 =A0 =
=A0 =A0 132 =A00.126514 =A0 0.48624
> min lat: 0.095185 max lat: 3.9695 avg lat: 0.488688
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0las=
t lat =A0 avg lat
> =A0 20 =A0 =A0 =A016 =A0 =A0 =A0 638 =A0 =A0 =A0 622 =A0 124.372 =A0 =
=A0 =A0 124 =A0 2.85047 =A00.488688
> Total time run: =A0 =A0 =A0 =A020.547165
> Total writes made: =A0 =A0 639
> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
> Bandwidth (MB/sec): =A0 =A0124.397
>
> Average Latency: =A0 =A0 =A0 0.513493
> Max latency: =A0 =A0 =A0 =A0 =A0 3.9695
> Min latency: =A0 =A0 =A0 =A0 =A0 0.095185
> root@gate0:/etc/ceph#
>
> root@gate0:/etc/ceph# rados -p test bench 20 seq
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0las=
t lat =A0 avg lat
> =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 0
> =A0 =A01 =A0 =A0 =A016 =A0 =A0 =A0 =A058 =A0 =A0 =A0 =A042 =A0 167.96=
6 =A0 =A0 =A0 168 =A00.085676 =A00.279929
> =A0 =A02 =A0 =A0 =A016 =A0 =A0 =A0 101 =A0 =A0 =A0 =A085 =A0 =A0169.9=
7 =A0 =A0 =A0 172 =A00.785072 =A00.323728
> =A0 =A03 =A0 =A0 =A016 =A0 =A0 =A0 145 =A0 =A0 =A0 129 =A0 171.969 =A0=
 =A0 =A0 176 =A00.141833 =A00.331852
> =A0 =A04 =A0 =A0 =A016 =A0 =A0 =A0 193 =A0 =A0 =A0 177 =A0 176.969 =A0=
 =A0 =A0 192 =A0 0.75847 =A00.335484
> =A0 =A05 =A0 =A0 =A015 =A0 =A0 =A0 240 =A0 =A0 =A0 225 =A0 =A0179.97 =
=A0 =A0 =A0 192 =A00.114137 =A00.332022
> =A0 =A06 =A0 =A0 =A016 =A0 =A0 =A0 288 =A0 =A0 =A0 272 =A0 181.303 =A0=
 =A0 =A0 188 =A0 0.54563 =A00.339292
> =A0 =A07 =A0 =A0 =A016 =A0 =A0 =A0 335 =A0 =A0 =A0 319 =A0 182.256 =A0=
 =A0 =A0 188 =A00.531714 =A00.341969
> =A0 =A08 =A0 =A0 =A016 =A0 =A0 =A0 380 =A0 =A0 =A0 364 =A0 =A0181.97 =
=A0 =A0 =A0 180 =A00.101676 =A00.339337
> =A0 =A09 =A0 =A0 =A016 =A0 =A0 =A0 427 =A0 =A0 =A0 411 =A0 182.634 =A0=
 =A0 =A0 188 =A00.216583 =A00.339264
> =A0 10 =A0 =A0 =A016 =A0 =A0 =A0 471 =A0 =A0 =A0 455 =A0 181.968 =A0 =
=A0 =A0 176 =A00.803917 =A00.341281
> =A0 11 =A0 =A0 =A016 =A0 =A0 =A0 515 =A0 =A0 =A0 499 =A0 181.422 =A0 =
=A0 =A0 176 =A00.112194 =A00.343552
> =A0 12 =A0 =A0 =A016 =A0 =A0 =A0 559 =A0 =A0 =A0 543 =A0 180.968 =A0 =
=A0 =A0 176 =A00.241835 =A00.345668
> =A0 13 =A0 =A0 =A016 =A0 =A0 =A0 600 =A0 =A0 =A0 584 =A0 =A0179.66 =A0=
 =A0 =A0 164 =A00.088883 =A00.347034
> read got -2
> error during benchmark: -5
> error 5: Input/output error
> root@gate0:/etc/ceph#
>
>
> WBR,
> =A0 =A0Fyodor.
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
