From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Custom STL allocator
Date: Thu, 7 Jan 2016 11:46:19 -0500 (EST)
Message-ID: <1819364811.10026395.1452185179817.JavaMail.zimbra@redhat.com>
References: <D2B160E5.9FE1%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:33915 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbcAGQqX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 11:46:23 -0500
In-Reply-To: <D2B160E5.9FE1%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: ceph-devel@vger.kernel.org


----- Original Message -----
> I want your opinion guys regarding two features implemented in attemp=
t to
> greatly reduce number of memory allocation without major surgery in t=
he
> code.
>=20
> The features are:
> 1. Custom STL allocator, which allocates first N items from the STL
> container itself. This is semi-transparent replacement of standard
> allocator. Just need to replace std::map with ceph_map for example.
> Limitation: a) Brakes move semantic. b) No deallocation implemented, =
so no
> good for big long living containers.
> 2. Placement allocator, which allows chained allocation of shorter li=
ving
> object from longer living. Example would be allocation of finish cont=
exts
> from aio completion context.
> Limitation: a) May require some code rearrangement in order to avoid
> concurrent deallocations, otherwise deallocation code uses synchroniz=
ation
> what limits performance. b) same as above b)
>=20
> Performance results for 32 threads in a synthetic test, std allocator=
 time
> to custom
> allocator time ratio:
>             stlalloc	    		 stl+placement alloc
> block jemalloc tcmalloc ptmalloc      jemalloc tcmalloc ptmalloc
> 1M	1298.01	650.66	137.64		735.49	824.45	9.62
> 64K	514.84	2.82	304.62		570.74	4.85	12.21
> 32K	838.89	2.17	5.03		1600.5	7.43	8.28
> 4K	2.76	1.99	4.98		4.36	5.3	8.23
> 32B	2.67	5.09	3.69		4.41	8.48	6.4
> (100M test iterations for 32B and 4K, 2M for 32K and 64K, 200K for 1M=
)
>=20
> I didn=C2=B9t see any performance improvement in 100% write fio test,=
 it still
> can shine in other workloads or proper classes replaced.
> Let me know if it worth to PR them.
>=20
> STL allocator:
> https://github.com/efirs/ceph/commit/4eed0d63dbcbd00ee3aa325355bfbe56=
acbb7b
> 05
> STL allocator usage example:
> https://github.com/efirs/ceph/commit/362c5c4e10563785cc89370d28511e04=
93f1b2
> 11
> https://github.com/efirs/ceph/commit/e2df67f7570c68e53775bc55cda12c62=
53e66d
> 2f
> Placement allocator:
> https://github.com/efirs/ceph/commit/8df5cd7d753fd09e79a24f2fc781cf3a=
f02e6d
> 3e
> Placement allocator usage example:
> https://github.com/efirs/ceph/commit/70db18d9c1b39190bde68548b57c2aa7=
a9e455
> e0
>=20
> =E2=80=B9
> Evgeniy
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Hi Evgeniy,

I did some investigation into custom allocators recently as well. The u=
se
cases that Sage was interested in were a) inline allocation for std::ve=
ctor
that avoids the heap allocation from reserve(), and b) preallocation of
elements for std::maps that are long-lived but mostly small.

I made a branch[1] that explored this, and ran into some of the same
limitations that you did. Deallocation was a big one, and there's no si=
mple
solution there that's both space- and time-efficient. So while it's les=
s
useful for containers like list and map that mix insertions and deletio=
ns,
it's a great fit for vector because it never needs to reclaim that memo=
ry.

And while you mention that moves can't be supported, I found that copie=
s were
a problem as well. Because the standard library assumes that allocators=
 are
stateless (until c++14, at least), it expected the copied allocator to =
be able
to deallocate entries from the initial allocator.

The boost container library includes a small_vector[2] class that does =
this
preallocation, but also supports move and copy. It wasn't added until v=
1.58,
however, so we can't depend on it yet without doing some boost header s=
urgery.

=46or list/map containers, there may be a benefit to using a custom all=
ocator
if all we're doing is constructing, inserting some elements, then destr=
ucting.
But I would argue that choosing a more appropriate data structure (whet=
her it's
just std::vector, or something like boost::small_vector, boost::flat_ma=
p, etc)
would provide more wins overall with less code to maintain.

Casey

[1] https://github.com/cbodley/ceph/commits/wip-preallocator
[2] http://www.boost.org/doc/libs/1_60_0/doc/html/container/non_standar=
d_containers.html#container.non_standard_containers.small_vector
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
