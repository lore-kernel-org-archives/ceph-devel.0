From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 18:05:51 +0200 (CEST)
Message-ID: <1960465945.40252217.1440000351155.JavaMail.zimbra@oxygem.tv>
References: <55D409F0.3050802@redhat.com> <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58750 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbHSQFx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 12:05:53 -0400
In-Reply-To: <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I was listening at the today meeting,

and seem that the blocker to have jemalloc as default,

is that it's used more memory by osd (around 300MB?),
and some guys could have boxes with 60disks.


I just wonder if the memory increase is related to osd_op_num_shards/os=
d_op_threads value ?

Seem that as hackaton, the bench has been done on super big cpus boxed =
36cores/72T,
http://ceph.com/hackathon/2015-08-ceph-hammer-full-ssd.pptx
with osd_op_threads =3D 32.

I think that tcmalloc have a fixed size (TCMALLOC_MAX_TOTAL_THREAD_CACH=
E_BYTES), and share it between all process.

Maybe jemalloc allocated memory by threads.



(I think guys with 60disks box, dont use ssd, so low iops by osd, and t=
hey don't need a lot of threads by osd)



----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "Mark Nelson" <mnelson@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 16:01:28
Objet: Re: Ceph Hackathon: More Memory Allocator Testing

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

One of the goals at the Ceph Hackathon last week was to examine how to=20
improve Ceph Small IO performance. Jian Zhang presented findings=20
showing a dramatic improvement in small random IO performance when Ceph=
=20
is used with jemalloc. His results build upon Sandisk's original=20
findings that the default thread cache values are a major bottleneck in=
=20
TCMalloc 2.1. To further verify these results, we sat down at the=20
Hackathon and configured the new performance test cluster that Intel=20
generously donated to the Ceph community laboratory to run through a=20
variety of tests with different memory allocator configurations. I've=20
since written the results of those tests up in pdf form for folks who=20
are interested.=20

The results are located here:=20

http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing.p=
df=20

I want to be clear that many other folks have done the heavy lifting=20
here. These results are simply a validation of the many tests that=20
other folks have already done. Many thanks to Sandisk and others for=20
figuring this out as it's a pretty big deal!=20

Side note: Very little tuning other than swapping the memory allocator=20
and a couple of quick and dirty ceph tunables were set during these=20
tests. It's quite possible that higher IOPS will be achieved as we=20
really start digging into the cluster and learning what the bottlenecks=
 are.=20

Thanks,=20
Mark=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20

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
