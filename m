From: Gregory Farnum <greg@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Mon, 2 Jul 2012 09:51:47 -0700
Message-ID: <CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro>
	<4FF13BEB.8080906@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34412 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab2GBQvs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 12:51:48 -0400
Received: by bkwj10 with SMTP id j10so894015bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 09:51:47 -0700 (PDT)
In-Reply-To: <4FF13BEB.8080906@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

On Sun, Jul 1, 2012 at 11:12 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 02.07.2012 07:02, schrieb Alexandre DERUMIER:
>
>> Hi,
>> my 2cent,
>> maybe with lower range (like 100MB) of random io,
>> you have more chance to aggregate them in 4MB block ?
>
>
> Yes maybe. If you have just a range of 100MB the chance you'll hit th=
e same
> 4MB block again is very high.
>
> @sage / mark
> How does the aggregation work? Does it work 4MB blockwise or target n=
ode
> based?
Aggregation is based on the 4MB blocks, and if you've got caching
enabled then it's also not going to flush them out to disk very often
if you're continuously updating the block =97 I don't remember all the
conditions, but=A0essentially, you'll run into dirty limits and it will
asynchronously flush out the data based on a combination of how old it
is, and how long it's been since some version of it was stable on
disk.


On Mon, Jul 2, 2012 at 6:19 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hello,
>
> i just want to report back some test results.
>
> Just some results from a sheepdog test using the same hardware.
>
> Sheepdog:
>
> 1 VM:
> =A0 write: io=3D12544MB, bw=3D142678KB/s, iops=3D35669, runt=3D 90025=
msec
> =A0 read : io=3D14519MB, bw=3D165186KB/s, iops=3D41296, runt=3D 90003=
msec
> =A0 write: io=3D16520MB, bw=3D185842KB/s, iops=3D45, runt=3D 91026mse=
c
> =A0 read : io=3D102936MB, bw=3D1135MB/s, iops=3D283, runt=3D 90684mse=
c
>
> 2 VMs:
> =A0 write: io=3D7042MB, bw=3D80062KB/s, iops=3D20015, runt=3D 90062ms=
ec
> =A0 read : io=3D8672MB, bw=3D98661KB/s, iops=3D24665, runt=3D 90004ms=
ec
> =A0 write: io=3D14008MB, bw=3D157443KB/s, iops=3D38, runt=3D 91107mse=
c
> =A0 read : io=3D43924MB, bw=3D498462KB/s, iops=3D121, runt=3D 90234ms=
ec
>
> =A0 write: io=3D6048MB, bw=3D68772KB/s, iops=3D17192, runt=3D 90055ms=
ec
> =A0 read : io=3D9151MB, bw=3D104107KB/s, iops=3D26026, runt=3D 90006m=
sec
> =A0 write: io=3D12716MB, bw=3D142693KB/s, iops=3D34, runt=3D 91253mse=
c
> =A0 read : io=3D59616MB, bw=3D675648KB/s, iops=3D164, runt=3D 90353ms=
ec
>
>
> Ceph:
> 2 VMs:
> =A0 write: io=3D2234MB, bw=3D25405KB/s, iops=3D6351, runt=3D 90041mse=
c
> =A0 read : io=3D4760MB, bw=3D54156KB/s, iops=3D13538, runt=3D 90007ms=
ec
> =A0 write: io=3D56372MB, bw=3D638402KB/s, iops=3D155, runt=3D 90421ms=
ec
> =A0 read : io=3D86572MB, bw=3D981225KB/s, iops=3D239, runt=3D 90346ms=
ec
>
> =A0 write: io=3D2222MB, bw=3D25275KB/s, iops=3D6318, runt=3D 90011mse=
c
> =A0 read : io=3D4747MB, bw=3D54000KB/s, iops=3D13500, runt=3D 90008ms=
ec
> =A0 write: io=3D55300MB, bw=3D626733KB/s, iops=3D153, runt=3D 90353ms=
ec
> =A0 read : io=3D84992MB, bw=3D965283KB/s, iops=3D235, runt=3D 90162ms=
ec

I can't quite tell what's going on here, can you describe the test in
more detail?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
