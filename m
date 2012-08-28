From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph benchmarks
Date: Tue, 28 Aug 2012 06:46:22 -0500
Message-ID: <503CAF8E.5090106@inktank.com>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com> <503C2A86.8080503@inktank.com> <503C48A6.5060205@catalyst.net.nz> <CAOLwVUkxo5pzvHmmr1PBW98wBWuVJW==Tk34wUMNedKxNQf+4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64027 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2H1LqZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 07:46:25 -0400
Received: by ialo24 with SMTP id o24so10446091ial.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 04:46:24 -0700 (PDT)
In-Reply-To: <CAOLwVUkxo5pzvHmmr1PBW98wBWuVJW==Tk34wUMNedKxNQf+4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/28/2012 03:32 AM, S=E9bastien Han wrote:
> @Alexandre: I don't have all the machines anymore, I'll see what I ca=
n
> do :). Only the commodity cluster remains
>
> @Mark Nelson: 2) Which bench? The RADOS one?
> 3) Sorry the RAID controller doesn't support JBOD...
> 5) I still have the commodity cluster, I'll perform some little rados=
 benchmarks

Ah, that's the problem we have with our H700s.  We do single drive=20
raid0s to get around it, but it's not ideal.  Do you have two drives in=
=20
a raid1 or just a single drive?

Some other things we've noticed on our Dell machines:

- Writeback cache is pretty much faster than writethrough cache on all=20
of our tests, even sequential writes.
- Concurrent writers to a single raid group seem to tank performance.  =
I=20
still don't know why this is, but it's making buffered IO and any direc=
t=20
IO with more than one writer top out at about 95MB/s regardless of the=20
number of drives in the raid group.  (And more writers slower=20
performance more).

Mark

>
> Cheers!
>
> On Tue, Aug 28, 2012 at 6:27 AM, Mark Kirkwood
> <mark.kirkwood@catalyst.net.nz>  wrote:
>> +1 to that. I've been seeing 4-6 MB/s for 4K writes for 1 OSD with 1=
 SSD for
>> journal and another for data [1]. Interestingly I did see some nice =
scaling
>> with 4K random reads: 2-4 MB/s per thread for up to 8 threads (looke=
d like
>> it plateaued thereafter).
>>
>> Cheers
>>
>> Mark
>>
>> [1] FYI not on the box I posted about before - on a more modern pc w=
ith
>> 6Bbit/s SATA.
>>
>>
>> On 28/08/12 14:18, Mark Nelson wrote:
>>>
>>> 5) rados bench tests with smaller requests could be interesting on =
15k
>>> drives.  I typically see about 1-2MB/s per OSD for 4k requests with=
 7200rpm
>>> SATA disks.
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
