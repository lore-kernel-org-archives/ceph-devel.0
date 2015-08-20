From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Thu, 20 Aug 2015 10:46:24 -0400 (EDT)
Message-ID: <1505100477.6819228.1440081984457.JavaMail.zimbra@redhat.com>
References: <55D409F0.3050802@redhat.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12406@SACMBXIP01.sdcorp.global.sandisk.com> <1002950976.40342661.1440010026776.JavaMail.zimbra@oxygem.tv> <3649A15A2562B54294DE14BCE5AC79120B5940A0@FMSMSX119.amr.corp.intel.com> <1821412943.6571923.1440036015749.JavaMail.zimbra@redhat.com> <1987635974.40440667.1440048562601.JavaMail.zimbra@oxygem.tv> <189248331.40627960.1440058666440.JavaMail.zimbra@oxygem.tv> <1388436889.6755045.1440075299003.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:41078 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbbHTOqh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Aug 2015 10:46:37 -0400
In-Reply-To: <1388436889.6755045.1440075299003.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Stephen L Blinick <stephen.l.blinick@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Jemalloc 4.0 seems to have some shiny new capabilities, at least.

Matt

--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-761-4689
fax.  734-769-8938
cel.  734-216-5309

----- Original Message -----
> From: "Shinobu Kinjo" <skinjo@redhat.com>
> To: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "Stephen L Blinick" <stephen.l.blinick@intel.com>, "Somnath Roy" =
<Somnath.Roy@sandisk.com>, "Mark Nelson"
> <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, August 20, 2015 8:54:59 AM
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> Thank you for that result.
> So it might make sense to know difference between jemalloc and jemall=
oc 4.0.
>=20
>  Shinobu
>=20
> ----- Original Message -----
> From: "Alexandre DERUMIER" <aderumier@odiso.com>
> To: "Shinobu Kinjo" <skinjo@redhat.com>
> Cc: "Stephen L Blinick" <stephen.l.blinick@intel.com>, "Somnath Roy"
> <Somnath.Roy@sandisk.com>, "Mark Nelson" <mnelson@redhat.com>, "ceph-=
devel"
> <ceph-devel@vger.kernel.org>
> Sent: Thursday, August 20, 2015 5:17:46 PM
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> memory results of osd daemon under load,
>=20
> jemalloc use always more memory than tcmalloc,
> jemalloc 4.0 seem to reduce memory usage but still a little bit more =
than
> tcmalloc
>=20
>=20
>=20
> osd_op_threads=3D2 : tcmalloc 2.1
> ------------------------------------------
> root      38066  2.3  0.7 1223088 505144 ?      Ssl  08:35   1:32
> /usr/bin/ceph-osd --cluster=3Dceph -i 4 -f
> root      38165  2.4  0.7 1247828 525356 ?      Ssl  08:35   1:34
> /usr/bin/ceph-osd --cluster=3Dceph -i 5 -f
>=20
>=20
> osd_op_threads=3D32: tcmalloc 2.1
> ------------------------------------------
>=20
> root      39002  102  0.7 1455928 488584 ?      Ssl  09:41   0:30
> /usr/bin/ceph-osd --cluster=3Dceph -i 4 -f
> root      39168  114  0.7 1483752 518368 ?      Ssl  09:41   0:30
> /usr/bin/ceph-osd --cluster=3Dceph -i 5 -f
>=20
>=20
> osd_op_threads=3D2 jemalloc 3.5
> -----------------------------
> root      18402 72.0  1.1 1642000 769000 ?      Ssl  09:43   0:17
> /usr/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      18434 89.1  1.2 1677444 797508 ?      Ssl  09:43   0:21
> /usr/bin/ceph-osd --cluster=3Dceph -i 1 -f
>=20
>=20
> osd_op_threads=3D32 jemalloc 3.5
> -----------------------------
> root      17204  3.7  1.2 2030616 816520 ?      Ssl  08:35   2:31
> /usr/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      17228  4.6  1.2 2064928 830060 ?      Ssl  08:35   3:05
> /usr/bin/ceph-osd --cluster=3Dceph -i 1 -f
>=20
>=20
> osd_op_threads=3D2 jemalloc 4.0
> -----------------------------
> root      19967  113  1.1 1432520 737988 ?      Ssl  10:04   0:31
> /usr/bin/ceph-osd --cluster=3Dceph -i 1 -f
> root      19976 93.6  1.0 1409376 711192 ?      Ssl  10:04   0:26
> /usr/bin/ceph-osd --cluster=3Dceph -i 0 -f
>=20
>=20
> osd_op_threads=3D32 jemalloc 4.0
> -----------------------------
> root      20484  128  1.1 1689176 778508 ?      Ssl  10:06   0:26
> /usr/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      20502  170  1.2 1720524 810668 ?      Ssl  10:06   0:35
> /usr/bin/ceph-osd --cluster=3Dceph -i 1 -f
>=20
>=20
>=20
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: "Shinobu Kinjo" <skinjo@redhat.com>
> Cc: "Stephen L Blinick" <stephen.l.blinick@intel.com>, "Somnath Roy"
> <Somnath.Roy@sandisk.com>, "Mark Nelson" <mnelson@redhat.com>, "ceph-=
devel"
> <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Jeudi 20 Ao=C3=BBt 2015 07:29:22
> Objet: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> Hi,
>=20
> jemmaloc 4.0 has been released 2 days agos
>=20
> https://github.com/jemalloc/jemalloc/releases
>=20
> I'm curious to see performance/memory usage improvement :)
>=20
>=20
> ----- Mail original -----
> De: "Shinobu Kinjo" <skinjo@redhat.com>
> =C3=80: "Stephen L Blinick" <stephen.l.blinick@intel.com>
> Cc: "aderumier" <aderumier@odiso.com>, "Somnath Roy"
> <Somnath.Roy@sandisk.com>, "Mark Nelson" <mnelson@redhat.com>, "ceph-=
devel"
> <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Jeudi 20 Ao=C3=BBt 2015 04:00:15
> Objet: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> How about making any sheet for testing patter?
>=20
> Shinobu
>=20
> ----- Original Message -----
> From: "Stephen L Blinick" <stephen.l.blinick@intel.com>
> To: "Alexandre DERUMIER" <aderumier@odiso.com>, "Somnath Roy"
> <Somnath.Roy@sandisk.com>
> Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel"
> <ceph-devel@vger.kernel.org>
> Sent: Thursday, August 20, 2015 10:09:36 AM
> Subject: RE: Ceph Hackathon: More Memory Allocator Testing
>=20
> Would it make more sense to try this comparison while changing the si=
ze of
> the worker thread pool? i.e. changing "osd_op_num_threads_per_shard" =
and
> "osd_op_num_shards" (default is currently 2 and 5 respectively, for a=
 total
> of 10 worker threads).
>=20
> Thanks,
>=20
> Stephen
>=20
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Alexandre DERU=
MIER
> Sent: Wednesday, August 19, 2015 11:47 AM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> Just have done a small test with jemalloc, change osd_op_threads valu=
e, and
> check the memory just after daemon restart.
>=20
> osd_op_threads =3D 2 (default)
>=20
>=20
> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
> root 10246 6.0 0.3 1086656 245760 ? Ssl 20:36 0:01 /usr/bin/ceph-osd
> --cluster=3Dceph -i 0 -f
>=20
> osd_op_threads =3D 32
>=20
> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
> root 10736 19.5 0.4 1474672 307412 ? Ssl 20:37 0:01 /usr/bin/ceph-osd
> --cluster=3Dceph -i 0 -f
>=20
>=20
>=20
> I'll try to compare with tcmalloc tommorow and under load.
>=20
>=20
>=20
> ----- Mail original -----
> De: "Somnath Roy" <Somnath.Roy@sandisk.com>
> =C3=80: "aderumier" <aderumier@odiso.com>
> Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel"
> <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 19:29:56
> Objet: RE: Ceph Hackathon: More Memory Allocator Testing
>=20
> Yes, it should be 1 per OSD...
> There is no doubt that TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is relat=
ive to
> the number of threads running..
> But, I don't know if number of threads is a factor for jemalloc..
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Alexandre DERUMIER [mailto:aderumier@odiso.com]
> Sent: Wednesday, August 19, 2015 9:55 AM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> << I think that tcmalloc have a fixed size
> (TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES), and share it between all pro=
cess.
>=20
> >>I think it is per tcmalloc instance loaded , so, at least with num_=
osds *
> >>num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in a =
box.
>=20
> What is num_tcmalloc_instance ? I think 1 osd process use a defined
> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES size ?
>=20
> I'm saying that, because I have exactly the same bug, client side, wi=
th
> librbd + tcmalloc + qemu + iothreads.
> When I defined too much iothread threads, I'm hitting the bug directl=
y. (can
> reproduce 100%).
> Like the thread_cache size is divide by number of threads?
>=20
>=20
>=20
>=20
>=20
>=20
> ----- Mail original -----
> De: "Somnath Roy" <Somnath.Roy@sandisk.com>
> =C3=80: "aderumier" <aderumier@odiso.com>, "Mark Nelson" <mnelson@red=
hat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 18:27:30
> Objet: RE: Ceph Hackathon: More Memory Allocator Testing
>=20
> << I think that tcmalloc have a fixed size
> (TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES), and share it between all pro=
cess.
>=20
> I think it is per tcmalloc instance loaded , so, at least with num_os=
ds *
> num_tcmalloc_instance * TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES in a bo=
x.
>=20
> Also, I think there is no point of increasing osd_op_threads as it is=
 not in
> IO path anymore..Mark is using default 5:2 for shard:thread per shard=
=2E.
>=20
> But, yes, it could be related to number of threads OSDs are using, ne=
ed to
> understand how jemalloc works..Also, there may be some tuning to redu=
ce
> memory usage (?).
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Alexandre DERU=
MIER
> Sent: Wednesday, August 19, 2015 9:06 AM
> To: Mark Nelson
> Cc: ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> I was listening at the today meeting,
>=20
> and seem that the blocker to have jemalloc as default,
>=20
> is that it's used more memory by osd (around 300MB?), and some guys c=
ould
> have boxes with 60disks.
>=20
>=20
> I just wonder if the memory increase is related to
> osd_op_num_shards/osd_op_threads value ?
>=20
> Seem that as hackaton, the bench has been done on super big cpus boxe=
d
> 36cores/72T, http://ceph.com/hackathon/2015-08-ceph-hammer-full-ssd.p=
ptx
> with osd_op_threads =3D 32.
>=20
> I think that tcmalloc have a fixed size
> (TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES), and share it between all pro=
cess.
>=20
> Maybe jemalloc allocated memory by threads.
>=20
>=20
>=20
> (I think guys with 60disks box, dont use ssd, so low iops by osd, and=
 they
> don't need a lot of threads by osd)
>=20
>=20
>=20
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: "Mark Nelson" <mnelson@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 16:01:28
> Objet: Re: Ceph Hackathon: More Memory Allocator Testing
>=20
> Thanks Marc,
>=20
> Results are matching exactly what I have seen with tcmalloc 2.1 vs 2.=
4 vs
> jemalloc.
>=20
> and indeed tcmalloc, even with bigger cache, seem decrease over time.
>=20
>=20
> What is funny, is that I see exactly same behaviour client librbd sid=
e, with
> qemu and multiple iothreads.
>=20
>=20
> Switching both server and client to jemalloc give me best performance=
 on
> small read currently.
>=20
>=20
>=20
>=20
>=20
>=20
> ----- Mail original -----
> De: "Mark Nelson" <mnelson@redhat.com>
> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
> Objet: Ceph Hackathon: More Memory Allocator Testing
>=20
> Hi Everyone,
>=20
> One of the goals at the Ceph Hackathon last week was to examine how t=
o
> improve Ceph Small IO performance. Jian Zhang presented findings show=
ing a
> dramatic improvement in small random IO performance when Ceph is used=
 with
> jemalloc. His results build upon Sandisk's original findings that the
> default thread cache values are a major bottleneck in TCMalloc 2.1. T=
o
> further verify these results, we sat down at the Hackathon and config=
ured
> the new performance test cluster that Intel generously donated to the=
 Ceph
> community laboratory to run through a variety of tests with different=
 memory
> allocator configurations. I've since written the results of those tes=
ts up
> in pdf form for folks who are interested.
>=20
> The results are located here:
>=20
> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing=
=2Epdf
>=20
> I want to be clear that many other folks have done the heavy lifting =
here.
> These results are simply a validation of the many tests that other fo=
lks
> have already done. Many thanks to Sandisk and others for figuring thi=
s out
> as it's a pretty big deal!
>=20
> Side note: Very little tuning other than swapping the memory allocato=
r and a
> couple of quick and dirty ceph tunables were set during these tests. =
It's
> quite possible that higher IOPS will be achieved as we really start d=
igging
> into the cluster and learning what the bottlenecks are.
>=20
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is
> intended only for the use of the designated recipient(s) named above.=
 If the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any re=
view,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please =
notify
> the sender by telephone or e-mail (as shown above) immediately and de=
stroy
> any and all copies of this message in your possession (whether hard c=
opies
> or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
