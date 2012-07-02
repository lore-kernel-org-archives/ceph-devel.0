From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Mon, 02 Jul 2012 13:30:19 -0700
Message-ID: <4FF204DB.80709@inktank.com>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro> <4FF13BEB.8080906@profihost.ag> <CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com> <4FF1F4F6.4030403@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34534 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2GBUdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 16:33:09 -0400
Received: by pbbrp8 with SMTP id rp8so8010765pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 13:33:09 -0700 (PDT)
In-Reply-To: <4FF1F4F6.4030403@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Gregory Farnum <greg@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

On 07/02/2012 12:22 PM, Stefan Priebe wrote:
> Am 02.07.2012 18:51, schrieb Gregory Farnum:
>> On Sun, Jul 1, 2012 at 11:12 PM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>>> @sage / mark
>>> How does the aggregation work? Does it work 4MB blockwise or target=
 node
>>> based?
>> Aggregation is based on the 4MB blocks, and if you've got caching
>> enabled then it's also not going to flush them out to disk very ofte=
n
>> if you're continuously updating the block =97 I don't remember all t=
he
>> conditions, but essentially, you'll run into dirty limits and it wil=
l
>> asynchronously flush out the data based on a combination of how old =
it
>> is, and how long it's been since some version of it was stable on
>> disk.
> Is there any way to check if rbd caching works correctly? For me the =
I/O
> values do not change if i switch writeback on or of and it also doesn=
't
> matter how large i set the cache size.
>
> ...

If you add admin_socket=3D/path/to/admin_socket for your client running
qemu (in that client's ceph.conf section or manually in the qemu
command line) you can check that caching is enabled:

ceph --admin-daemon /path/to/admin_socket show config | grep rbd_cache

And see statistics it generates (look for cache) with:

ceph --admin-daemon /path/to/admin_socket perfcounters_dump

Josh

>>> Ceph:
>>> 2 VMs:
>>> write: io=3D2234MB, bw=3D25405KB/s, iops=3D6351, runt=3D 90041msec
>>> read : io=3D4760MB, bw=3D54156KB/s, iops=3D13538, runt=3D 90007msec
>>> write: io=3D56372MB, bw=3D638402KB/s, iops=3D155, runt=3D 90421msec
>>> read : io=3D86572MB, bw=3D981225KB/s, iops=3D239, runt=3D 90346msec
>>>
>>> write: io=3D2222MB, bw=3D25275KB/s, iops=3D6318, runt=3D 90011msec
>>> read : io=3D4747MB, bw=3D54000KB/s, iops=3D13500, runt=3D 90008msec
>>> write: io=3D55300MB, bw=3D626733KB/s, iops=3D153, runt=3D 90353msec
>>> read : io=3D84992MB, bw=3D965283KB/s, iops=3D235, runt=3D 90162msec
>>
>> I can't quite tell what's going on here, can you describe the test i=
n
>> more detail?
>
> I've network booted my VM and then run the following command:
> export DISK=3D/dev/vda; (fio --filename=3D$DISK --direct=3D1 --rw=3Dr=
andwrite
> --bs=3D4k --size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporti=
ng
> --name=3Dfile1;fio --filename=3D$DISK --direct=3D1 --rw=3Drandread --=
bs=3D4k
> --size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=3D=
file1;fio
> --filename=3D$DISK --direct=3D1 --rw=3Dwrite --bs=3D4M --size=3D200G =
--numjobs=3D50
> --runtime=3D90 --group_reporting --name=3Dfile1;fio --filename=3D$DIS=
K
> --direct=3D1 --rw=3Dread --bs=3D4M --size=3D200G --numjobs=3D50 --run=
time=3D90
> --group_reporting --name=3Dfile1 )|egrep " read| write"
>
> - write random 4k I/O
> - read random 4k I/O
> - write seq 4M I/O
> - read seq 4M I/O
>
> Stefan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
