From: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Subject: Custom STL allocator
Date: Thu, 7 Jan 2016 10:23:10 +0000
Message-ID: <D2B160E5.9FE1%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0089.outbound.protection.outlook.com ([207.46.100.89]:12034
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752013AbcAGKXN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 05:23:13 -0500
Content-Language: en-US
Content-ID: <079EBF073387BC4DBF0F644910CE7ABE@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I want your opinion guys regarding two features implemented in attempt =
to
greatly reduce number of memory allocation without major surgery in the
code.

The features are:
1. Custom STL allocator, which allocates first N items from the STL
container itself. This is semi-transparent replacement of standard
allocator. Just need to replace std::map with ceph_map for example.
Limitation: a) Brakes move semantic. b) No deallocation implemented, so=
 no
good for big long living containers.
2. Placement allocator, which allows chained allocation of shorter livi=
ng
object from longer living. Example would be allocation of finish contex=
ts
from aio completion context.
Limitation: a) May require some code rearrangement in order to avoid
concurrent deallocations, otherwise deallocation code uses synchronizat=
ion
what limits performance. b) same as above b)

Performance results for 32 threads in a synthetic test, std allocator t=
ime
to custom=20
allocator time ratio:
            stlalloc	    		 stl+placement alloc	=09
block jemalloc tcmalloc ptmalloc      jemalloc tcmalloc ptmalloc
1M	1298.01	650.66	137.64		735.49	824.45	9.62
64K	514.84	2.82	304.62		570.74	4.85	12.21
32K	838.89	2.17	5.03		1600.5	7.43	8.28
4K	2.76	1.99	4.98		4.36	5.3	8.23
32B	2.67	5.09	3.69		4.41	8.48	6.4
(100M test iterations for 32B and 4K, 2M for 32K and 64K, 200K for 1M)

I didn=B9t see any performance improvement in 100% write fio test, it s=
till
can shine in other workloads or proper classes replaced.
Let me know if it worth to PR them.

STL allocator:=20
https://github.com/efirs/ceph/commit/4eed0d63dbcbd00ee3aa325355bfbe56ac=
bb7b
05
STL allocator usage example:
https://github.com/efirs/ceph/commit/362c5c4e10563785cc89370d28511e0493=
f1b2
11
https://github.com/efirs/ceph/commit/e2df67f7570c68e53775bc55cda12c6253=
e66d
2f
Placement allocator:
https://github.com/efirs/ceph/commit/8df5cd7d753fd09e79a24f2fc781cf3af0=
2e6d
3e
Placement allocator usage example:
https://github.com/efirs/ceph/commit/70db18d9c1b39190bde68548b57c2aa7a9=
e455
e0

=8B
Evgeniy

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
