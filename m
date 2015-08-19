From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 18:55:24 +0200 (CEST)
Message-ID: <87804130.40306063.1440003324534.JavaMail.zimbra@oxygem.tv>
References: <55D409F0.3050802@redhat.com> <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv> <1960465945.40252217.1440000351155.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12211@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33562 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbbHSQz0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 12:55:26 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12211@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

<< I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD_C=
ACHE_BYTES), and share it between all process.=20

>>I think it is per tcmalloc instance loaded , so, at least with num_os=
ds * num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in a=
 box.=20

What is num_tcmalloc_instance ? I think 1 osd process use a defined TCM=
ALLOC_MAX_TOTAL_THREAD_CACHE_BYTES size ?

I'm saying that, because I have exactly the same bug, client side, with=
 librbd + tcmalloc + qemu + iothreads.
When I defined too much iothread threads, I'm hitting the bug directly.=
 (can reproduce 100%).
Like the thread_cache size is divide by number of threads?






----- Mail original -----
De: "Somnath Roy" <Somnath.Roy@sandisk.com>
=C3=80: "aderumier" <aderumier@odiso.com>, "Mark Nelson" <mnelson@redha=
t.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 18:27:30
Objet: RE: Ceph Hackathon: More Memory Allocator Testing

<< I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD_C=
ACHE_BYTES), and share it between all process.=20

I think it is per tcmalloc instance loaded , so, at least with num_osds=
 * num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in a b=
ox.=20

Also, I think there is no point of increasing osd_op_threads as it is n=
ot in IO path anymore..Mark is using default 5:2 for shard:thread per s=
hard..=20

But, yes, it could be related to number of threads OSDs are using, need=
 to understand how jemalloc works..Also, there may be some tuning to re=
duce memory usage (?).=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER=20
Sent: Wednesday, August 19, 2015 9:06 AM=20
To: Mark Nelson=20
Cc: ceph-devel=20
Subject: Re: Ceph Hackathon: More Memory Allocator Testing=20

I was listening at the today meeting,=20

and seem that the blocker to have jemalloc as default,=20

is that it's used more memory by osd (around 300MB?), and some guys cou=
ld have boxes with 60disks.=20


I just wonder if the memory increase is related to osd_op_num_shards/os=
d_op_threads value ?=20

Seem that as hackaton, the bench has been done on super big cpus boxed =
36cores/72T, http://ceph.com/hackathon/2015-08-ceph-hammer-full-ssd.ppt=
x=20
with osd_op_threads =3D 32.=20

I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD_CACH=
E_BYTES), and share it between all process.=20

Maybe jemalloc allocated memory by threads.=20



(I think guys with 60disks box, dont use ssd, so low iops by osd, and t=
hey don't need a lot of threads by osd)=20



----- Mail original -----=20
De: "aderumier" <aderumier@odiso.com>=20
=C3=80: "Mark Nelson" <mnelson@redhat.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 16:01:28=20
Objet: Re: Ceph Hackathon: More Memory Allocator Testing=20

Thanks Marc,=20

Results are matching exactly what I have seen with tcmalloc 2.1 vs 2.4 =
vs jemalloc.=20

and indeed tcmalloc, even with bigger cache, seem decrease over time.=20


What is funny, is that I see exactly same behaviour client librbd side,=
 with qemu and multiple iothreads.=20


Switching both server and client to jemalloc give me best performance o=
n small read currently.=20






----- Mail original -----=20
De: "Mark Nelson" <mnelson@redhat.com>=20
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36=20
Objet: Ceph Hackathon: More Memory Allocator Testing=20

Hi Everyone,=20

One of the goals at the Ceph Hackathon last week was to examine how to =
improve Ceph Small IO performance. Jian Zhang presented findings showin=
g a dramatic improvement in small random IO performance when Ceph is us=
ed with jemalloc. His results build upon Sandisk's original findings th=
at the default thread cache values are a major bottleneck in TCMalloc 2=
=2E1. To further verify these results, we sat down at the Hackathon and=
 configured the new performance test cluster that Intel generously dona=
ted to the Ceph community laboratory to run through a variety of tests =
with different memory allocator configurations. I've since written the =
results of those tests up in pdf form for folks who are interested.=20

The results are located here:=20

http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing.p=
df=20

I want to be clear that many other folks have done the heavy lifting he=
re. These results are simply a validation of the many tests that other =
folks have already done. Many thanks to Sandisk and others for figuring=
 this out as it's a pretty big deal!=20

Side note: Very little tuning other than swapping the memory allocator =
and a couple of quick and dirty ceph tunables were set during these tes=
ts. It's quite possible that higher IOPS will be achieved as we really =
start digging into the cluster and learning what the bottlenecks are.=20

Thanks,=20
Mark=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
