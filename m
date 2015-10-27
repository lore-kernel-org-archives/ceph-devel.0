From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Re: [ceph-users] Understanding the number of TCP connections
 between clients and OSDs
Date: Tue, 27 Oct 2015 13:36:11 +0800
Message-ID: <CACJqLyYQB0A7_AkKELWxMU44kiENc9za1ipLSfyjLe=EXNZfhw@mail.gmail.com>
References: <CAD76J01iYt1wVZZR655=KF+kRZATMc_yEB62QJOyRmRhMD8pFg@mail.gmail.com>
	<590F8B9C-DA15-41C2-9E37-8847F79D7F6B@schermer.cz>
	<562ECF89.709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36198 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbbJ0FgM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Oct 2015 01:36:12 -0400
Received: by vkex70 with SMTP id x70so112954508vke.3
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2015 22:36:11 -0700 (PDT)
In-Reply-To: <562ECF89.709@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hzwulibin <hzwulibin@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Oct 27, 2015 at 9:12 AM, hzwulibin <hzwulibin@gmail.com> wrote:
> Hi, develops
>
> I also concerns about this problem. And my problem is how many thread=
s will the qemu-system-x86 has?
> When will it cut down the threads?

It's because of network model, each connection will has two threads.
We are actually working on this to avoid.

BTW, for client level, maybe we can add a proxy for ceph message to
avoid too much tcp socket on client host. But it need let us improve
single connection's performance.

>
> From what i tested, it could between 100 to 800, yeah, maybe it has r=
elationship with the osd number. But it
> seems affect the performance when it has many threads. From what i te=
sted, 4k randwrite will reduce from 15k
> to 4k. That's really unacceptable!
>
> My evnironment:
>
> 1. nine OSD storage servers with two intel DC 3500 SSD on each
> 2. hammer 0.94.3
> 3. QEMU emulator version 2.1.2 (Debian 1:2.1+dfsg-12+deb8u4~bpo70+1)
>
> Thanks!
>
> ------------------
> hzwulibin
> 2015-10-27
>
> -------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJan Schermer <jan@schermer.cz>
> =E5=8F=91=E9=80=81=E6=97=A5=E6=9C=9F=EF=BC=9A2015-10-27 05:48
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ARick Balsano
> =E6=8A=84=E9=80=81=EF=BC=9Aceph-users@lists.ceph.com
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [ceph-users] Understanding the number =
of TCP connections
>         between clients and OSDs
>
> If we're talking about RBD clients (qemu) then the number also grows =
with number of volumes attached to the client. With a single volume it =
was <1000. It grows when there's heavy IO happening in the guest.
> I had to bump up the file open limits to several thusands (8000 was i=
t?) to accomodate client with 10 volumes in our cluster. We just scaled=
 the number of OSDs down so hopefully I could have a graph of that.
> But I just guesstimated what it could become, and that's not necessar=
ily what the theoretical limit is. Very bad things happen when you reac=
h that threshold. It could also depend on the guest settings (like queu=
e depth), and how much it seeks over the drive (how many different PGs =
it hits), but knowing the upper bound is most critical.
>
> Jan
>
>> On 26 Oct 2015, at 21:32, Rick Balsano <rick@opower.com> wrote:
>>
>> We've run into issues with the number of open TCP connections from a=
 single client to the OSDs in our Ceph cluster.
>>
>> We can (& have) increased the open file limit to work around this, b=
ut we're looking to understand what determines the number of open conne=
ctions maintained between a client and a particular OSD. Our naive assu=
mption was 1 open TCP connection per OSD or per port made available by =
the Ceph node. There are many more than this, presumably to allow paral=
lel connections, because we see 1-4 connections from each client per op=
en port on a Ceph node.
>>
>> Here is some background on our cluster:
>> * still running Firefly 0.80.8
>> * 414 OSDs, 35 nodes, one massive pool
>> * clients are KVM processes, accessing Ceph RBD images using virtio
>> * total number of open TCP connections from one client to all nodes =
between 500-1000
>>
>> Is there any way to either know or cap the maximum number of connect=
ions we should expect?
>>
>> I can provide more info as required. I've done some searches and fou=
nd references to "huge number of TCP connections" but nothing concrete =
to tell me how to predict how that scales.
>>
>> Thanks,
>> Rick
>> --
>> Rick Balsano
>> Senior Software Engineer
>> Opower <http://www.opower.com/>
>>
>> O +1 571 384 1210
>> We're Hiring! See jobs here <http://www.opower.com/careers>.
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
