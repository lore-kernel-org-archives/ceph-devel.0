From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 16:01:28 +0200 (CEST)
Message-ID: <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
References: <55D409F0.3050802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:48040 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbbHSOBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 10:01:30 -0400
In-Reply-To: <55D409F0.3050802@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Marc,

Results are matching exactly what I have seen with tcmalloc 2.1 vs 2.4 =
vs jemalloc.

and indeed tcmalloc, even with bigger cache, seem decrease over time.


What is funny, is that I see exactly same behaviour client librbd side,=
 with qemu and multiple iothreads.


Switching both server and client to jemalloc give me best performance o=
n small read currently.






----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
Objet: Ceph Hackathon: More Memory Allocator Testing

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

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
