From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Thu, 20 Aug 2015 10:17:46 +0200 (CEST)
Message-ID: <189248331.40627960.1440058666440.JavaMail.zimbra@oxygem.tv>
References: <55D409F0.3050802@redhat.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12211@SACMBXIP01.sdcorp.global.sandisk.com> <87804130.40306063.1440003324534.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12406@SACMBXIP01.sdcorp.global.sandisk.com> <1002950976.40342661.1440010026776.JavaMail.zimbra@oxygem.tv> <3649A15A2562B54294DE14BCE5AC79120B5940A0@FMSMSX119.amr.corp.intel.com> <1821412943.6571923.1440036015749.JavaMail.zimbra@redhat.com> <1987635974.40440667.1440048562601.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49350 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbbHTIRs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Aug 2015 04:17:48 -0400
In-Reply-To: <1987635974.40440667.1440048562601.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: Stephen L Blinick <stephen.l.blinick@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

memory results of osd daemon under load,

jemalloc use always more memory than tcmalloc,
jemalloc 4.0 seem to reduce memory usage but still a little bit more th=
an tcmalloc



osd_op_threads=3D2 : tcmalloc 2.1
------------------------------------------
root      38066  2.3  0.7 1223088 505144 ?      Ssl  08:35   1:32 /usr/=
bin/ceph-osd --cluster=3Dceph -i 4 -f
root      38165  2.4  0.7 1247828 525356 ?      Ssl  08:35   1:34 /usr/=
bin/ceph-osd --cluster=3Dceph -i 5 -f


osd_op_threads=3D32: tcmalloc 2.1
------------------------------------------

root      39002  102  0.7 1455928 488584 ?      Ssl  09:41   0:30 /usr/=
bin/ceph-osd --cluster=3Dceph -i 4 -f
root      39168  114  0.7 1483752 518368 ?      Ssl  09:41   0:30 /usr/=
bin/ceph-osd --cluster=3Dceph -i 5 -f


osd_op_threads=3D2 jemalloc 3.5
-----------------------------
root      18402 72.0  1.1 1642000 769000 ?      Ssl  09:43   0:17 /usr/=
bin/ceph-osd --cluster=3Dceph -i 0 -f
root      18434 89.1  1.2 1677444 797508 ?      Ssl  09:43   0:21 /usr/=
bin/ceph-osd --cluster=3Dceph -i 1 -f


osd_op_threads=3D32 jemalloc 3.5
-----------------------------
root      17204  3.7  1.2 2030616 816520 ?      Ssl  08:35   2:31 /usr/=
bin/ceph-osd --cluster=3Dceph -i 0 -f
root      17228  4.6  1.2 2064928 830060 ?      Ssl  08:35   3:05 /usr/=
bin/ceph-osd --cluster=3Dceph -i 1 -f


osd_op_threads=3D2 jemalloc 4.0
-----------------------------
root      19967  113  1.1 1432520 737988 ?      Ssl  10:04   0:31 /usr/=
bin/ceph-osd --cluster=3Dceph -i 1 -f
root      19976 93.6  1.0 1409376 711192 ?      Ssl  10:04   0:26 /usr/=
bin/ceph-osd --cluster=3Dceph -i 0 -f


osd_op_threads=3D32 jemalloc 4.0
-----------------------------
root      20484  128  1.1 1689176 778508 ?      Ssl  10:06   0:26 /usr/=
bin/ceph-osd --cluster=3Dceph -i 0 -f
root      20502  170  1.2 1720524 810668 ?      Ssl  10:06   0:35 /usr/=
bin/ceph-osd --cluster=3Dceph -i 1 -f



----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "Shinobu Kinjo" <skinjo@redhat.com>
Cc: "Stephen L Blinick" <stephen.l.blinick@intel.com>, "Somnath Roy" <S=
omnath.Roy@sandisk.com>, "Mark Nelson" <mnelson@redhat.com>, "ceph-deve=
l" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Jeudi 20 Ao=C3=BBt 2015 07:29:22
Objet: Re: Ceph Hackathon: More Memory Allocator Testing

Hi,=20

jemmaloc 4.0 has been released 2 days agos=20

https://github.com/jemalloc/jemalloc/releases=20

I'm curious to see performance/memory usage improvement :)=20


----- Mail original -----=20
De: "Shinobu Kinjo" <skinjo@redhat.com>=20
=C3=80: "Stephen L Blinick" <stephen.l.blinick@intel.com>=20
Cc: "aderumier" <aderumier@odiso.com>, "Somnath Roy" <Somnath.Roy@sandi=
sk.com>, "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@v=
ger.kernel.org>=20
Envoy=C3=A9: Jeudi 20 Ao=C3=BBt 2015 04:00:15=20
Objet: Re: Ceph Hackathon: More Memory Allocator Testing=20

How about making any sheet for testing patter?=20

Shinobu=20

----- Original Message -----=20
=46rom: "Stephen L Blinick" <stephen.l.blinick@intel.com>=20
To: "Alexandre DERUMIER" <aderumier@odiso.com>, "Somnath Roy" <Somnath.=
Roy@sandisk.com>=20
Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>=20
Sent: Thursday, August 20, 2015 10:09:36 AM=20
Subject: RE: Ceph Hackathon: More Memory Allocator Testing=20

Would it make more sense to try this comparison while changing the size=
 of the worker thread pool? i.e. changing "osd_op_num_threads_per_shard=
" and "osd_op_num_shards" (default is currently 2 and 5 respectively, f=
or a total of 10 worker threads).=20

Thanks,=20

Stephen=20


-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER=20
Sent: Wednesday, August 19, 2015 11:47 AM=20
To: Somnath Roy=20
Cc: Mark Nelson; ceph-devel=20
Subject: Re: Ceph Hackathon: More Memory Allocator Testing=20

Just have done a small test with jemalloc, change osd_op_threads value,=
 and check the memory just after daemon restart.=20

osd_op_threads =3D 2 (default)=20


USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
root 10246 6.0 0.3 1086656 245760 ? Ssl 20:36 0:01 /usr/bin/ceph-osd --=
cluster=3Dceph -i 0 -f=20

osd_op_threads =3D 32=20

USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
root 10736 19.5 0.4 1474672 307412 ? Ssl 20:37 0:01 /usr/bin/ceph-osd -=
-cluster=3Dceph -i 0 -f=20



I'll try to compare with tcmalloc tommorow and under load.=20



----- Mail original -----=20
De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "aderumier" <aderumier@odiso.com>=20
Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>=20
Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 19:29:56=20
Objet: RE: Ceph Hackathon: More Memory Allocator Testing=20

Yes, it should be 1 per OSD...=20
There is no doubt that TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is relativ=
e to the number of threads running..=20
But, I don't know if number of threads is a factor for jemalloc..=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: Alexandre DERUMIER [mailto:aderumier@odiso.com]=20
Sent: Wednesday, August 19, 2015 9:55 AM=20
To: Somnath Roy=20
Cc: Mark Nelson; ceph-devel=20
Subject: Re: Ceph Hackathon: More Memory Allocator Testing=20

<< I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD_C=
ACHE_BYTES), and share it between all process.=20

>>I think it is per tcmalloc instance loaded , so, at least with num_os=
ds * num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in a=
 box.=20

What is num_tcmalloc_instance ? I think 1 osd process use a defined TCM=
ALLOC_MAX_TOTAL_THREAD_CACHE_BYTES size ?=20

I'm saying that, because I have exactly the same bug, client side, with=
 librbd + tcmalloc + qemu + iothreads.=20
When I defined too much iothread threads, I'm hitting the bug directly.=
 (can reproduce 100%).=20
Like the thread_cache size is divide by number of threads?=20






----- Mail original -----=20
De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "aderumier" <aderumier@odiso.com>, "Mark Nelson" <mnelson@redha=
t.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 18:27:30=20
Objet: RE: Ceph Hackathon: More Memory Allocator Testing=20

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
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20
N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=
=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=BD=
f=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=BF=
=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=
=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=
=BF=BD=EF=BF=BD=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
