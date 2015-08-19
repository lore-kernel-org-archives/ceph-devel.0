From: =?UTF-8?Q?=C5=81ukasz_Redynk?= <lukas.redynk@gmail.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 11:47:30 -0700
Message-ID: <CADkk3iu_JkocKtnanLiJ978sCNPLTZUFfG1oBuVSf55voQ3zGw@mail.gmail.com>
References: <55D409F0.3050802@redhat.com> <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
 <1960465945.40252217.1440000351155.JavaMail.zimbra@oxygem.tv>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12211@SACMBXIP01.sdcorp.global.sandisk.com>
 <87804130.40306063.1440003324534.JavaMail.zimbra@oxygem.tv>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12406@SACMBXIP01.sdcorp.global.sandisk.com>
 <7334B4281E425749B85E08CF7EC6F853437CFAB8@SACMBXIP03.sdcorp.global.sandisk.com>
 <55D4CCA6.7050101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34862 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbbHSSsD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 14:48:03 -0400
Received: by lbcbn3 with SMTP id bn3so9241326lbc.2
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2015 11:48:00 -0700 (PDT)
In-Reply-To: <55D4CCA6.7050101@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

@Mark: could you also post your ceph.conf?

2015-08-19 11:36 GMT-07:00 Mark Nelson <mnelson@redhat.com>:
> On 08/19/2015 01:20 PM, Allen Samuels wrote:
>>
>> It was a surprising result that the memory allocator is making such =
a
>> large difference in performance. All of the recent work in fiddling =
with
>> TCmalloc's and Jemalloc's various knobs and switches has been excell=
ent a
>> great example of group collaboration. But I think it's only a partia=
l
>> optimization of the underlying problem. The real take-away from this
>> activity is that the code base is doing a LOT of memory
>> allocation/deallocation which is consuming substantial CPU time-- re=
gardless
>> of how much we optimize the memory allocator, you can't get away fro=
m the
>> fact that it macroscopically MATTERs. The better long-term solution =
is to
>> reduce reliance on the general-purpose memory allocator and to imple=
ment
>> strategies that are more specific to our usage model.
>>
>> What really needs to happen initially is to instrument the
>> allocation/deallocation. Most likely we'll find that 80+% of the wor=
k is
>> coming from just a few object classes and it will be easy to create =
custom
>> allocation strategies for those usages. This will lead to even highe=
r
>> performance that's much less sensitive to easy-to-misconfigure envir=
onmental
>> factors and the entire tcmalloc/jemalloc -- oops it uses more memory
>> discussion will go away.
>
>
> Yes, I think the real take away is the Ceph is really hard on memory
> allocators.  I think a lot of us have sort of had a feeling this was =
the
> case for a long time.  The current discussion/results just draws it a=
 lot
> more sharply into focus.
>
> On the plus side there is work going on to make things a little more
> manageable, though a more comprehensive analysis would be very welcom=
e!  I
> see the jemalloc has some interesting looking profiling options in th=
e newer
> releases.
>
> Mark
>
>
>>
>>
>> Allen Samuels
>> Software Architect, Systems and Software Solutions
>>
>> 2880 Junction Avenue, San Jose, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: Wednesday, August 19, 2015 10:30 AM
>> To: Alexandre DERUMIER
>> Cc: Mark Nelson; ceph-devel
>> Subject: RE: Ceph Hackathon: More Memory Allocator Testing
>>
>> Yes, it should be 1 per OSD...
>> There is no doubt that TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is rela=
tive
>> to the number of threads running..
>> But, I don't know if number of threads is a factor for jemalloc..
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Alexandre DERUMIER [mailto:aderumier@odiso.com]
>> Sent: Wednesday, August 19, 2015 9:55 AM
>> To: Somnath Roy
>> Cc: Mark Nelson; ceph-devel
>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>>
>> << I think that tcmalloc have a fixed size
>> (TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES), and share it between all pr=
ocess.
>>
>>>> I think it is per tcmalloc instance loaded , so, at least with num=
_osds
>>>> * num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in=
 a box.
>>
>>
>> What is num_tcmalloc_instance ? I think 1 osd process use a defined
>> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES size ?
>>
>> I'm saying that, because I have exactly the same bug, client side, w=
ith
>> librbd + tcmalloc + qemu + iothreads.
>> When I defined too much iothread threads, I'm hitting the bug direct=
ly.
>> (can reproduce 100%).
>> Like the thread_cache size is divide by number of threads?
>>
>>
>>
>>
>>
>>
>> ----- Mail original -----
>> De: "Somnath Roy" <Somnath.Roy@sandisk.com>
>> =C3=80: "aderumier" <aderumier@odiso.com>, "Mark Nelson" <mnelson@re=
dhat.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 18:27:30
>> Objet: RE: Ceph Hackathon: More Memory Allocator Testing
>>
>> << I think that tcmalloc have a fixed size
>> (TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES), and share it between all pr=
ocess.
>>
>> I think it is per tcmalloc instance loaded , so, at least with num_o=
sds *
>> num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in a b=
ox.
>>
>> Also, I think there is no point of increasing osd_op_threads as it i=
s not
>> in IO path anymore..Mark is using default 5:2 for shard:thread per s=
hard..
>>
>> But, yes, it could be related to number of threads OSDs are using, n=
eed to
>> understand how jemalloc works..Also, there may be some tuning to red=
uce
>> memory usage (?).
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Alexandre DER=
UMIER
>> Sent: Wednesday, August 19, 2015 9:06 AM
>> To: Mark Nelson
>> Cc: ceph-devel
>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>>
>> I was listening at the today meeting,
>>
>> and seem that the blocker to have jemalloc as default,
>>
>> is that it's used more memory by osd (around 300MB?), and some guys =
could
>> have boxes with 60disks.
>>
>>
>> I just wonder if the memory increase is related to
>> osd_op_num_shards/osd_op_threads value ?
>>
>> Seem that as hackaton, the bench has been done on super big cpus box=
ed
>> 36cores/72T, http://ceph.com/hackathon/2015-08-ceph-hammer-full-ssd.=
pptx
>> with osd_op_threads =3D 32.
>>
>> I think that tcmalloc have a fixed size
>> (TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES), and share it between all pr=
ocess.
>>
>> Maybe jemalloc allocated memory by threads.
>>
>>
>>
>> (I think guys with 60disks box, dont use ssd, so low iops by osd, an=
d they
>> don't need a lot of threads by osd)
>>
>>
>>
>> ----- Mail original -----
>> De: "aderumier" <aderumier@odiso.com>
>> =C3=80: "Mark Nelson" <mnelson@redhat.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 16:01:28
>> Objet: Re: Ceph Hackathon: More Memory Allocator Testing
>>
>> Thanks Marc,
>>
>> Results are matching exactly what I have seen with tcmalloc 2.1 vs 2=
=2E4 vs
>> jemalloc.
>>
>> and indeed tcmalloc, even with bigger cache, seem decrease over time=
=2E
>>
>>
>> What is funny, is that I see exactly same behaviour client librbd si=
de,
>> with qemu and multiple iothreads.
>>
>>
>> Switching both server and client to jemalloc give me best performanc=
e on
>> small read currently.
>>
>>
>>
>>
>>
>>
>> ----- Mail original -----
>> De: "Mark Nelson" <mnelson@redhat.com>
>> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
>> Objet: Ceph Hackathon: More Memory Allocator Testing
>>
>> Hi Everyone,
>>
>> One of the goals at the Ceph Hackathon last week was to examine how =
to
>> improve Ceph Small IO performance. Jian Zhang presented findings sho=
wing a
>> dramatic improvement in small random IO performance when Ceph is use=
d with
>> jemalloc. His results build upon Sandisk's original findings that th=
e
>> default thread cache values are a major bottleneck in TCMalloc 2.1. =
To
>> further verify these results, we sat down at the Hackathon and confi=
gured
>> the new performance test cluster that Intel generously donated to th=
e Ceph
>> community laboratory to run through a variety of tests with differen=
t memory
>> allocator configurations. I've since written the results of those te=
sts up
>> in pdf form for folks who are interested.
>>
>> The results are located here:
>>
>> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testin=
g.pdf
>>
>> I want to be clear that many other folks have done the heavy lifting=
 here.
>> These results are simply a validation of the many tests that other f=
olks
>> have already done. Many thanks to Sandisk and others for figuring th=
is out
>> as it's a pretty big deal!
>>
>> Side note: Very little tuning other than swapping the memory allocat=
or and
>> a couple of quick and dirty ceph tunables were set during these test=
s. It's
>> quite possible that higher IOPS will be achieved as we really start =
digging
>> into the cluster and learning what the bottlenecks are.
>>
>> Thanks,
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org More majordomo in=
fo at
>> http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org More majordomo in=
fo at
>> http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org More majordomo in=
fo at
>> http://vger.kernel.org/majordomo-info.html
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail messa=
ge is
>> intended only for the use of the designated recipient(s) named above=
=2E If the
>> reader of this message is not the intended recipient, you are hereby
>> notified that you have received this message in error and that any r=
eview,
>> dissemination, distribution, or copying of this message is strictly
>> prohibited. If you have received this communication in error, please=
 notify
>> the sender by telephone or e-mail (as shown above) immediately and d=
estroy
>> any and all copies of this message in your possession (whether hard =
copies
>> or electronically stored copies).
>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay  =CA=87=DA=99 =
,j   f   h   z   w
>> j:+v   w j m         zZ+     =DD=A2j"  ! i
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
