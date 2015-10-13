From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] Initial performance cluster SimpleMessenger vs
 AsyncMessenger results
Date: Tue, 13 Oct 2015 14:48:14 +0800
Message-ID: <CACJqLyZ1jvhpBciSae1z_Sr_d8nuFDLKcC--veCJG6vYWNSK4Q@mail.gmail.com>
References: <561BE4E3.7050404@redhat.com>
	<CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F31740C2F@SACMBXIP02.sdcorp.global.sandisk.com>
	<CACJqLyZp=+c0BbHRW3JUdAXrT9nWPopE82GEAJUUFrPi5g1vnQ@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F31740E6B@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36411 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbJMGsP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 02:48:15 -0400
Received: by vkgc187 with SMTP id c187so4651087vkg.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 23:48:14 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F31740E6B@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Yep, as I said below, I consider to add auto scale up/down for worker
threads with connection load balance ability. It may let users not
entangled with how much thread number I need. :-(

Actually thread number for config value is a pain in ceph osd io stack.=
=2E...

On Tue, Oct 13, 2015 at 2:45 PM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:
> Thanks Haomai..
> Since Async messenger is always using a constant number of threads , =
there could be a potential performance problem of scaling up the client=
 connections keeping the constant number of OSDs ?
> May be it's a good tradeoff..
>
> Regards
> Somnath
>
>
> -----Original Message-----
> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> Sent: Monday, October 12, 2015 11:35 PM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel; ceph-users@lists.ceph.com
> Subject: Re: [ceph-users] Initial performance cluster SimpleMessenger=
 vs AsyncMessenger results
>
> On Tue, Oct 13, 2015 at 12:18 PM, Somnath Roy <Somnath.Roy@sandisk.co=
m> wrote:
>> Mark,
>>
>> Thanks for this data. This means probably simple messenger (not OSD
>> core) is not doing optimal job of handling memory.
>>
>>
>>
>> Haomai,
>>
>> I am not that familiar with Async messenger code base, do you have a=
n
>> explanation of the behavior (like good performance with default
>> tcmalloc) Mark reported ? Is it using lot less thread overall than S=
imple ?
>
> Originally async messenger mainly want to solve with high thread numb=
er problem which limited the ceph cluster size. High context switch and=
 cpu usage caused by simple messenger under large cluster.
>
> Recently we have memory problem discussed on ML and I also spend time=
s to think about the root cause. Currently I would like to consider the=
 simple messenger's memory usage is deviating from the design of tcmall=
oc. Tcmalloc is aimed to provide memory with local cache, and it also h=
as memory control among all threads, if we have too much threads, it ma=
y let tcmalloc busy with memory lock contention.
>
> Async messenger uses thread pool to serve connections, it make all bl=
ocking calls in simple messenger async.
>
>>
>> Also, it seems Async messenger has some inefficiencies in the io pat=
h
>> and that=E2=80=99s why it is not performing as well as simple if the=
 memory
>> allocation stuff is optimally handled.
>
> Yep, simple messenger use two threads(one for read, one for write) to=
 serve one connection, async messenger at most have one thread to serve=
 one connection and multi connection  will share the same thread.
>
> Next, I would like to have several plans to improve performance:
> 1. add poll mode support, I hope it can help enhance high performance=
 storage need 2. add load balance ability among worker threads 3. move =
more works out of messenger thread.
>
>>
>> Could you please send out any documentation around Async messenger ?=
 I
>> tried to google it , but, not even blueprint is popping up.
>
>>
>>
>>
>>
>>
>> Thanks & Regards
>>
>> Somnath
>>
>> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behal=
f
>> Of Haomai Wang
>> Sent: Monday, October 12, 2015 7:57 PM
>> To: Mark Nelson
>> Cc: ceph-devel; ceph-users@lists.ceph.com
>> Subject: Re: [ceph-users] Initial performance cluster SimpleMessenge=
r
>> vs AsyncMessenger results
>>
>>
>>
>> COOL
>>
>>
>>
>> Interesting that async messenger will consume more memory than simpl=
e,
>> in my mind I always think async should use less memory. I will give =
a
>> look at this
>>
>>
>>
>> On Tue, Oct 13, 2015 at 12:50 AM, Mark Nelson <mnelson@redhat.com> w=
rote:
>>
>> Hi Guy,
>>
>> Given all of the recent data on how different memory allocator
>> configurations improve SimpleMessenger performance (and the effect o=
f
>> memory allocators and transparent hugepages on RSS memory usage), I
>> thought I'd run some tests looking how AsyncMessenger does in
>> comparison.  We spoke about these a bit at the last performance meet=
ing but here's the full write up.
>> The rough conclusion as of right now appears to be:
>>
>> 1) AsyncMessenger performance is not dependent on the memory allocat=
or
>> like with SimpleMessenger.
>>
>> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32M=
B
>> (ie
>> default) thread cache.
>>
>> 3) AsyncMessenger is consistently faster than SimpleMessenger for 12=
8K
>> random reads.
>>
>> 4) AsyncMessenger is sometimes slower than SimpleMessenger when memo=
ry
>> allocator optimizations are used.
>>
>> 5) AsyncMessenger currently uses far more RSS memory than SimpleMess=
enger.
>>
>> Here's a link to the paper:
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view
>>
>> Mark
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>>
>>
>>
>> --
>>
>> Best Regards,
>>
>> Wheat
>>
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail messa=
ge
>> is intended only for the use of the designated recipient(s) named
>> above. If the reader of this message is not the intended recipient,
>> you are hereby notified that you have received this message in error
>> and that any review, dissemination, distribution, or copying of this
>> message is strictly prohibited. If you have received this
>> communication in error, please notify the sender by telephone or
>> e-mail (as shown above) immediately and destroy any and all copies o=
f
>> this message in your possession (whether hard copies or electronical=
ly stored copies).
>>
>
>
>
> --
> Best Regards,
>
> Wheat
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
