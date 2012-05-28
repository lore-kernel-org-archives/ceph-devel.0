From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Mon, 28 May 2012 21:48:34 +0200
Message-ID: <4FC3D692.7090701@profihost.ag>
References: <d88e7ec1-2170-44e3-b90c-1d1e3453e5fc@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49728 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab2E1Tsh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 15:48:37 -0400
In-Reply-To: <d88e7ec1-2170-44e3-b90c-1d1e3453e5fc@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 28.05.2012 08:52, schrieb Alexandre DERUMIER:
>> I think filestore journal parallel works only with btrfs.
>> Other filesystem are writeahead.
>>> ... you might be right but i can't change ceph's implementation.
>
> See my schema,
> I think you see parallel writes, because you see flush write of first=
 wave to disk, in the same time
> of second wave write to journal.
Yes i fulll=C3=BD understand and agree - but still this should at least=
=20
result in a constant bandwidth near max of underlying disk.

>>> I totally aggree with you but this is just a test setup AND if you =
have
>>> a big log file to copy let's say 100GB your journal will never be b=
ig
>>> enough and the speed should never drop to 0MB/s. Also i see the cor=
rect
>>> behaviour with 3.0.X where the speed is maxed to the underlying dev=
ice.
>>> So i still see no reason that with 3.4 the speed drops to 0MB/s and=
 is
>>> mostly 10-20MB/s instead of 130MB/s.
>
> Maybe something is wrong with 3.4, then your disk write more slowly. =
(xfs bug, sata driver controller bug, ...)

This happens with ext4 or btrfs too.

Squential write speed to FS is exactly the same under 3.0 and 3.4 using=
=20
oflag=3Ddirect.

3.4:
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB) copied, 41,4899 s, 253 MB/s

3.0:
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB) copied, 40,861 s, 257 MB/s

> maybe some local benchmark of your ssd with 3.4 can give some tips ?

>>> How many disks (7,2K) do you have by osd ?
>>>> One intel 520 SSD per OSD.
>
> I see some benchmark on internet about 150-300MB/s (depend of the blo=
cksize).
bench OSD shows around 260MB/s

ceph osd tell X bench shows me a speed of 260MB/s under both kernels=20
which corresponds to the dd from above.

> Something must be wrong, Doing local benchmark can really help I thin=
k.
> You can use sysbench-tools
> https://github.com/tsuna/sysbench-tools
> It make bench compare with nice graphs.
Thx hopefully i'll find something.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
