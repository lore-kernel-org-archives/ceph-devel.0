From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Mon, 02 Jul 2012 21:22:30 +0200
Message-ID: <4FF1F4F6.4030403@profihost.ag>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro> <4FF13BEB.8080906@profihost.ag> <CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:46306 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2GBTWd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 15:22:33 -0400
In-Reply-To: <CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 02.07.2012 18:51, schrieb Gregory Farnum:
> On Sun, Jul 1, 2012 at 11:12 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> @sage / mark
>> How does the aggregation work? Does it work 4MB blockwise or target =
node
>> based?
> Aggregation is based on the 4MB blocks, and if you've got caching
> enabled then it's also not going to flush them out to disk very often
> if you're continuously updating the block =97 I don't remember all th=
e
> conditions, but essentially, you'll run into dirty limits and it will
> asynchronously flush out the data based on a combination of how old i=
t
> is, and how long it's been since some version of it was stable on
> disk.
Is there any way to check if rbd caching works correctly? For me the I/=
O=20
values do not change if i switch writeback on or of and it also doesn't=
=20
matter how large i set the cache size.

=2E..

>> Ceph:
>> 2 VMs:
>>    write: io=3D2234MB, bw=3D25405KB/s, iops=3D6351, runt=3D 90041mse=
c
>>    read : io=3D4760MB, bw=3D54156KB/s, iops=3D13538, runt=3D 90007ms=
ec
>>    write: io=3D56372MB, bw=3D638402KB/s, iops=3D155, runt=3D 90421ms=
ec
>>    read : io=3D86572MB, bw=3D981225KB/s, iops=3D239, runt=3D 90346ms=
ec
>>
>>    write: io=3D2222MB, bw=3D25275KB/s, iops=3D6318, runt=3D 90011mse=
c
>>    read : io=3D4747MB, bw=3D54000KB/s, iops=3D13500, runt=3D 90008ms=
ec
>>    write: io=3D55300MB, bw=3D626733KB/s, iops=3D153, runt=3D 90353ms=
ec
>>    read : io=3D84992MB, bw=3D965283KB/s, iops=3D235, runt=3D 90162ms=
ec
>
> I can't quite tell what's going on here, can you describe the test in
> more detail?

I've network booted my VM and then run the following command:
export DISK=3D/dev/vda; (fio --filename=3D$DISK --direct=3D1 --rw=3Dran=
dwrite=20
--bs=3D4k --size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting=
=20
--name=3Dfile1;fio --filename=3D$DISK --direct=3D1 --rw=3Drandread --bs=
=3D4k=20
--size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=3D=
file1;fio=20
--filename=3D$DISK --direct=3D1 --rw=3Dwrite --bs=3D4M --size=3D200G --=
numjobs=3D50=20
--runtime=3D90 --group_reporting --name=3Dfile1;fio --filename=3D$DISK=20
--direct=3D1 --rw=3Dread --bs=3D4M --size=3D200G --numjobs=3D50 --runti=
me=3D90=20
--group_reporting --name=3Dfile1 )|egrep " read| write"

- write random 4k I/O
- read random 4k I/O
- write seq 4M I/O
- read seq 4M I/O

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
