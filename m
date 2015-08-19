From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 13:36:22 -0500
Message-ID: <55D4CCA6.7050101@redhat.com>
References: <55D409F0.3050802@redhat.com> <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv> <1960465945.40252217.1440000351155.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12211@SACMBXIP01.sdcorp.global.sandisk.com> <87804130.40306063.1440003324534.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12406@SACMBXIP01.sdcorp.global.sandisk.com> <7334B4281E425749B85E08CF7EC6F853437CFAB8@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59699 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbbHSSgZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Aug 2015 14:36:25 -0400
In-Reply-To: <7334B4281E425749B85E08CF7EC6F853437CFAB8@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/19/2015 01:20 PM, Allen Samuels wrote:
> It was a surprising result that the memory allocator is making such a=
 large difference in performance. All of the recent work in fiddling wi=
th TCmalloc's and Jemalloc's various knobs and switches has been excell=
ent a great example of group collaboration. But I think it's only a par=
tial optimization of the underlying problem. The real take-away from th=
is activity is that the code base is doing a LOT of memory allocation/d=
eallocation which is consuming substantial CPU time-- regardless of how=
 much we optimize the memory allocator, you can't get away from the fac=
t that it macroscopically MATTERs. The better long-term solution is to =
reduce reliance on the general-purpose memory allocator and to implemen=
t strategies that are more specific to our usage model.
>
> What really needs to happen initially is to instrument the allocation=
/deallocation. Most likely we'll find that 80+% of the work is coming f=
rom just a few object classes and it will be easy to create custom allo=
cation strategies for those usages. This will lead to even higher perfo=
rmance that's much less sensitive to easy-to-misconfigure environmental=
 factors and the entire tcmalloc/jemalloc -- oops it uses more memory d=
iscussion will go away.

Yes, I think the real take away is the Ceph is really hard on memory=20
allocators.  I think a lot of us have sort of had a feeling this was th=
e=20
case for a long time.  The current discussion/results just draws it a=20
lot more sharply into focus.

On the plus side there is work going on to make things a little more=20
manageable, though a more comprehensive analysis would be very welcome!=
=20
  I see the jemalloc has some interesting looking profiling options in=20
the newer releases.

Mark

>
>
> Allen Samuels
> Software Architect, Systems and Software Solutions
>
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Somnath Roy
> Sent: Wednesday, August 19, 2015 10:30 AM
> To: Alexandre DERUMIER
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Ceph Hackathon: More Memory Allocator Testing
>
> Yes, it should be 1 per OSD...
> There is no doubt that TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is relat=
ive to the number of threads running..
> But, I don't know if number of threads is a factor for jemalloc..
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Alexandre DERUMIER [mailto:aderumier@odiso.com]
> Sent: Wednesday, August 19, 2015 9:55 AM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>
> << I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD=
_CACHE_BYTES), and share it between all process.
>
>>> I think it is per tcmalloc instance loaded , so, at least with num_=
osds * num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in=
 a box.
>
> What is num_tcmalloc_instance ? I think 1 osd process use a defined T=
CMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES size ?
>
> I'm saying that, because I have exactly the same bug, client side, wi=
th librbd + tcmalloc + qemu + iothreads.
> When I defined too much iothread threads, I'm hitting the bug directl=
y. (can reproduce 100%).
> Like the thread_cache size is divide by number of threads?
>
>
>
>
>
>
> ----- Mail original -----
> De: "Somnath Roy" <Somnath.Roy@sandisk.com>
> =C3=80: "aderumier" <aderumier@odiso.com>, "Mark Nelson" <mnelson@red=
hat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 18:27:30
> Objet: RE: Ceph Hackathon: More Memory Allocator Testing
>
> << I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD=
_CACHE_BYTES), and share it between all process.
>
> I think it is per tcmalloc instance loaded , so, at least with num_os=
ds * num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in a=
 box.
>
> Also, I think there is no point of increasing osd_op_threads as it is=
 not in IO path anymore..Mark is using default 5:2 for shard:thread per=
 shard..
>
> But, yes, it could be related to number of threads OSDs are using, ne=
ed to understand how jemalloc works..Also, there may be some tuning to =
reduce memory usage (?).
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER
> Sent: Wednesday, August 19, 2015 9:06 AM
> To: Mark Nelson
> Cc: ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>
> I was listening at the today meeting,
>
> and seem that the blocker to have jemalloc as default,
>
> is that it's used more memory by osd (around 300MB?), and some guys c=
ould have boxes with 60disks.
>
>
> I just wonder if the memory increase is related to osd_op_num_shards/=
osd_op_threads value ?
>
> Seem that as hackaton, the bench has been done on super big cpus boxe=
d 36cores/72T, http://ceph.com/hackathon/2015-08-ceph-hammer-full-ssd.p=
ptx
> with osd_op_threads =3D 32.
>
> I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD_CA=
CHE_BYTES), and share it between all process.
>
> Maybe jemalloc allocated memory by threads.
>
>
>
> (I think guys with 60disks box, dont use ssd, so low iops by osd, and=
 they don't need a lot of threads by osd)
>
>
>
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: "Mark Nelson" <mnelson@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 16:01:28
> Objet: Re: Ceph Hackathon: More Memory Allocator Testing
>
> Thanks Marc,
>
> Results are matching exactly what I have seen with tcmalloc 2.1 vs 2.=
4 vs jemalloc.
>
> and indeed tcmalloc, even with bigger cache, seem decrease over time.
>
>
> What is funny, is that I see exactly same behaviour client librbd sid=
e, with qemu and multiple iothreads.
>
>
> Switching both server and client to jemalloc give me best performance=
 on small read currently.
>
>
>
>
>
>
> ----- Mail original -----
> De: "Mark Nelson" <mnelson@redhat.com>
> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
> Objet: Ceph Hackathon: More Memory Allocator Testing
>
> Hi Everyone,
>
> One of the goals at the Ceph Hackathon last week was to examine how t=
o improve Ceph Small IO performance. Jian Zhang presented findings show=
ing a dramatic improvement in small random IO performance when Ceph is =
used with jemalloc. His results build upon Sandisk's original findings =
that the default thread cache values are a major bottleneck in TCMalloc=
 2.1. To further verify these results, we sat down at the Hackathon and=
 configured the new performance test cluster that Intel generously dona=
ted to the Ceph community laboratory to run through a variety of tests =
with different memory allocator configurations. I've since written the =
results of those tests up in pdf form for folks who are interested.
>
> The results are located here:
>
> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing=
=2Epdf
>
> I want to be clear that many other folks have done the heavy lifting =
here. These results are simply a validation of the many tests that othe=
r folks have already done. Many thanks to Sandisk and others for figuri=
ng this out as it's a pretty big deal!
>
> Side note: Very little tuning other than swapping the memory allocato=
r and a couple of quick and dirty ceph tunables were set during these t=
ests. It's quite possible that higher IOPS will be achieved as we reall=
y start digging into the cluster and learning what the bottlenecks are.
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at http://vger.kernel.org/majordomo-info.html
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
> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w       j:+v   w j m         zZ+     =DD=A2j"  ! i
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
