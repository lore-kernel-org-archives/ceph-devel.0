From: Sage Weil <sage@inktank.com>
Subject: Re: question for the new ceph-osd key/value backend
Date: Tue, 10 Dec 2013 22:09:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312102155520.19333@cobra.newdream.net>
References: <A9F57F2ABA6BB2469F01E127557C6C9B10E7BEDD@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-412503121-1386742165=:19333"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32905 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3LKGJ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 01:09:26 -0500
In-Reply-To: <A9F57F2ABA6BB2469F01E127557C6C9B10E7BEDD@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Duan, Jiangang" <jiangang.duan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-412503121-1386742165=:19333
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jiangang,

On Wed, 11 Dec 2013, Duan, Jiangang wrote:
> Sage,
>=20
> I have some questions regarding to the key/value backend work.
>=20
> What is the motivation to work on this? (or what is the problem we want=
 to solve?)
> 1) to use the new interface thus we can bypass all the OS layer thus ge=
t a short latency?

That is one part.  The current strategy of layering on top of a file=20
system and using a write-ahead journal makes sense given the existing=20
linux fs building blocks, but is far from an optimal solution for many=20
workloads.  A k/v interface based on something leveldb probably performs=20
much better for many small-object use-cases.  Also, a k/v backend can tak=
e=20
advatange of emerging non-block storage interfaces like NVMKV, Kinetic,=20
new libraries like rocksdb, etc.

> 2) or to leverage some new primitive e.g. the atomic write thus to simp=
lify the code writing?

That too.  Basically, we are currently doing a lot of work to get what we=
=20
need out of posix, and are paying the price.

> There are several different possibilities to use future NVM technology =
-=20
> NVM.FILE, NVM.BLOCK, PM.XXX=20
> http://snia.org/sites/default/files/NVMProgrammingModel_v1r10DRAFT.pdf=20
> Even for openNVM thing - there are other usage model than k/v.
>=20
> Do you have any typical usage model for this?=20

I wasn't familiar with these; thanks for the reference!  Of these,=20
NVM.FILE seems the most interesting (it maps most closely to an object). =
=20
I am predisposed to skepticism when it comes to these sorts of=20
standards/API docs that precede an actual implementation, but it is=20
encourgaging to see some effort here towards a common interface.

In the end, we want to support generic Ceph workloads.  These range from=20
rbd block and file type workloads (objects are stripes of files, with=20
random bytes rewritten) to omap type workloads (like rgw bucket indices=20
that are purely key/value).

I think the first wins would be:

1- a backend that more efficiently handles rgw bucket index workloads
2- a backend that is more efficient for rgw in general (i.e., immutable=20
objects)
3- a backend that can handle more general purpose workloads (like rbd and=
=20
cephfs)

and separately,

4- a backend that lets you plug in a next-gen backend beneath it, like=20
NVMKV and speedy flash.

sage



>=20
> -jiangang
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> From: Sage Weil <sage <at> inktank.com>
> Subject:=C2=A0new ceph-osd key/value backend
> Newsgroups:=C2=A0gmane.comp.file-systems.ceph.devel
> Date: 2013-11-09 10:09:52 GMT (4 weeks, 3 days, 16 hours and 39 minutes=
 ago)
> I've written up a blueprint with a rough sketch of how to take advantag=
e=20
> of alternative storage interfaces.  I am very happy to see that several=
 f=20
> them have emerged over the past year or two:
>=20
>  - fusionio's KVMKV is a key/value interface for their flash products
>  - seagate's kinetic is a key/value interface for their new ethernet-ba=
sed=20
> drive
>=20
> Also, leveldb is pretty great for many workloads when run on a=20
> tranditional disk/fs.
>=20
> The good news is a lot of the existing work that went into support omap=
=20
> looks to be reusable here.  Some new functionality and refactoring is=20
> needed, though, particularly when it comes to storing object data (the=20
> file-like bag of bytes portion) as key/value pairs.
>=20
> The blueprint is here:
>=20
>   http://wiki.ceph.com/01Planning/02Blueprints/Firefly/osd%3A_new_key%2=
F%2Fvalue_backend
>=20
> N?????r??y??????X???v???)?{.n?????z?]z????ay?=1D????j=07??f???h?????=1E=
?w???=0C???j:+v???w????????=07????zZ+???????j"????i
--557981400-412503121-1386742165=:19333--
