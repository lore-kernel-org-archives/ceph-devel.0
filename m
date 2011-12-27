From: Leander Yu <leander.yu@gmail.com>
Subject: Re: Some Question Regarding to RBD performance
Date: Tue, 27 Dec 2011 22:16:18 +0800
Message-ID: <CAA9wQNd6YhCVcgN__Mgotw15HH0kMXxaT=1MD1R+iDDNeS+GPA@mail.gmail.com>
References: <CAA9wQNfSH=8ei6Kk8VQ6nWELhL5SV0eXFHv58WkPL4bFQsjtqg@mail.gmail.com>
	<Pine.LNX.4.64.1112260819590.3637@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50195 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab1L0OQT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Dec 2011 09:16:19 -0500
Received: by iaeh11 with SMTP id h11so20454334iae.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Dec 2011 06:16:18 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1112260819590.3637@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Thanks for the feedback. We found the performance issue actually from
the journal writing. even we separate journal into the other SATA HDD,
it didn't shows any performance difference.
At the end , we use SSD to store the journal file which give us the
performance 52.3MB/s with oflag=3Ddirect. compare SATA 6MB/s
I didn't have chance to trace the code for journal writing , however I
am wondering that is there a way to improve the journal writing so we
can get better performance in SATA HDD.

Thanks.

Regards,
Leander Yu.

On Tue, Dec 27, 2011 at 12:27 AM, Sage Weil <sage@newdream.net> wrote:
> Hi Leander,
>
> On Mon, 26 Dec 2011, Leander Yu wrote:
>> Hi all,
>> I have a question regarding to RBD performance. Recently I test RBD =
in
>> 2 cluster, using dd if=3D/dev/zero of=3D/dev/rbd5 bs=3D4M count=3D10=
24
>> oflag=3Ddirect. I got 33.4MB/s in one cluster , however got only 6MB=
/s
>> in the other cluster.
>>
>> I have confirmed that the network bandwidth is ok. and osd bench sho=
ws
>> around 32 ~ 40 MB/s on all OSD. Is this performance normal? if not ,
>> how can I troubleshoot it?
>> I have move journal to ramdisk for testing and get performance boost
>> to 7x MB/s. Does this means the HDD is the bottleneck ?
>>
>> The other cluster that got 33.4 MB/s , it's osd bench shows around
>> 44MB/s. The major difference between those two cluster is the better
>> performed one use SAS with RAID controller the other use SATA with n=
o
>> RAID control.
>
> If you are using the kernel client, each 4M write is fully synchronou=
s,
> which means (among other things) that the client is completely idle w=
hile
> the write is being replicated by the OSDs. =A0This makes the performa=
nce
> very sensitive to the write latency; it's not really testing write
> throughput. =A0Your SAS RAID controller is probably doing writeback c=
aching
> of some kind that keeps the write latency low, while the SATA disks
> clearly are not.
>
> 'dd oflag=3Ddirect' is probably not the benchmark you want; no applic=
ation
> should do a single synchronous IO at a time and expect good throughpu=
t.
> The more interesting number would be steady-state buffered write
> throughput when you have a file system on top, or something along tho=
se
> lines.
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
