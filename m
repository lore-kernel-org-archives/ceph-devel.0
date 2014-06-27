From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [RFC] add rocksdb support
Date: Fri, 27 Jun 2014 05:33:50 +0200 (CEST)
Message-ID: <0095e2af-3684-4e30-849d-e4c891610c08@mailpro>
References: <B9FF37F8E2D7894A9493A5314D0816FC226141BD@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47699 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbaF0DeA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jun 2014 23:34:00 -0400
In-Reply-To: <B9FF37F8E2D7894A9493A5314D0816FC226141BD@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sushma Gurram <Sushma.Gurram@sandisk.com>
Cc: Jian Zhang <jian.zhang@intel.com>, ceph-devel@vger.kernel.org, Xinxin Shu <xinxin.shu@intel.com>, Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>

Hi Sushma,

what is the hardware disk for osd ? ssd ?
where is the journal for xfs osd ? on the same disk ? another disk ?


also 2GB rbd, seem to be low to test, because reads can be done in page=
 cache.

65000 iops with xfs with a single osd seem to be a crazy.=20
All the benchs show around 3000-4000 iops limit of osd because of locks=
 contentions in osd daemon.
(are you sure that's it's not caches client side ?)

----- Mail original -----=20

De: "Sushma Gurram" <Sushma.Gurram@sandisk.com>=20
=C3=80: "Xinxin Shu" <xinxin.shu@intel.com>, "Mark Nelson" <mark.nelson=
@inktank.com>, "Sage Weil" <sage@inktank.com>=20
Cc: "Jian Zhang" <jian.zhang@intel.com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 27 Juin 2014 02:44:17=20
Objet: RE: [RFC] add rocksdb support=20

Delivery failure due to table format. Resending as plain text.=20

_____________________________________________=20
=46rom: Sushma Gurram=20
Sent: Thursday, June 26, 2014 5:35 PM=20
To: 'Shu, Xinxin'; 'Mark Nelson'; 'Sage Weil'=20
Cc: 'Zhang, Jian'; ceph-devel@vger.kernel.org=20
Subject: RE: [RFC] add rocksdb support=20


Hi Xinxin,=20

Thanks for providing the results of the performance tests.=20

I used fio (with support for rbd ioengine) to compare XFS and RockDB wi=
th a single OSD. Also confirmed with rados bench and both numbers seem =
to be of the same order.=20
My findings show that XFS is better than rocksdb. Can you please let us=
 know rocksdb configuration that you used, object size and duration of =
run for rados bench?=20
=46or random writes tests, I see "rocksdb:bg0" thread as the top CPU co=
nsumer (%CPU of this thread is 50, while that of all other threads in t=
he OSD is <10% utilized).=20
Is there a ceph.conf config option to configure the background threads =
in rocksdb?=20

We ran our tests with following configuration:=20
System : Intel(R) Xeon(R) CPU E5-4620 0 @ 2.20GHz (16 physical cores), =
HT disabled, 16 GB memory=20

rocksdb configuration has been set to the following values in ceph.conf=
=2E=20
rocksdb_write_buffer_size =3D 4194304=20
rocksdb_cache_size =3D 4194304=20
rocksdb_bloom_size =3D 0=20
rocksdb_max_open_files =3D 10240=20
rocksdb_compression =3D false=20
rocksdb_paranoid =3D false=20
rocksdb_log =3D /dev/null=20
rocksdb_compact_on_mount =3D false=20

fio rbd ioengine with numjobs=3D1 for writes and numjobs=3D16 for reads=
, iodepth=3D32. Unlike rados bench, fio rbd helps to create multiple (=3D=
numjobs) client connections to the OSD, thus stressing the OSD.=20

rbd image size =3D 2 GB, rocksdb_write_buffer_size=3D4MB=20
-------------------------------------------------------------------=20
IO Pattern XFS (IOPs) Rocksdb (IOPs)=20
4K writes ~1450 ~670=20
4K reads ~65000 ~2000=20
64K writes ~431 ~57=20
64K reads ~17500 ~180=20


rbd image size =3D 2 GB, rocksdb_write_buffer_size=3D1GB=20
-------------------------------------------------------------------=20
IO Pattern XFS (IOPs) Rocksdb (IOPs)=20
4K writes ~1450 ~962=20
4K reads ~65000 ~1641=20
64K writes ~431 ~426=20
64K reads ~17500 ~209=20

I guess theoretically lower rocksdb performance can be attributed to co=
mpaction during writes and merging during reads, but I'm not sure if RE=
ADs are lower by this magnitude.=20
However, your results seem to show otherwise. Can you please help us wi=
th rockdb config and how the rados bench has been run?=20

Thanks,=20
Sushma=20

-----Original Message-----=20
=46rom: Shu, Xinxin [mailto:xinxin.shu@intel.com]=20
Sent: Sunday, June 22, 2014 6:18 PM=20
To: Sushma Gurram; 'Mark Nelson'; 'Sage Weil'=20
Cc: 'ceph-devel@vger.kernel.org'; Zhang, Jian=20
Subject: RE: [RFC] add rocksdb support=20


Hi all,=20

We enabled rocksdb as data store in our test setup (10 osds on two serv=
ers, each server has 5 HDDs as osd , 2 ssds as journal , Intel(R) Xeon(=
R) CPU E31280) and have performance tests for xfs, leveldb and rocksdb =
(use rados bench as our test tool), the following chart shows details, =
for write , with small number threads , leveldb performance is lower th=
an the other two backends , from 16 threads point , rocksdb perform a l=
ittle better than xfs and leveldb , leveldb and rocksdb perform much be=
tter than xfs with higher thread number.=20

xfs leveldb rocksdb=20
throughtput latency throughtput latency throughtput latency=20
1 thread write 84.029 0.048 52.430 0.076 71.920 0.056=20
2 threads write 166.417 0.048 97.917 0.082 155.148 0.052=20
4 threads write 304.099 0.052 156.094 0.102 270.461 0.059=20
8 threads write 323.047 0.099 221.370 0.144 339.455 0.094=20
16 threads write 295.040 0.216 272.032 0.235 348.849 0.183=20
32 threads write 324.467 0.394 290.072 0.441 338.103 0.378=20
64 threads write 313.713 0.812 293.261 0.871 324.603 0.787=20
1 thread read 75.687 0.053 71.629 0.056 72.526 0.055=20
2 threads read 182.329 0.044 151.683 0.053 153.125 0.052=20
4 threads read 320.785 0.050 307.180 0.052 312.016 0.051=20
8 threads read 504.880 0.063 512.295 0.062 519.683 0.062=20
16 threads read 477.706 0.134 643.385 0.099 654.149 0.098=20
32 threads read 517.670 0.247 666.696 0.192 678.480 0.189=20
64 threads read 516.599 0.495 668.360 0.383 680.673 0.376=20

-----Original Message-----=20
=46rom: Shu, Xinxin=20
Sent: Saturday, June 14, 2014 11:50 AM=20
To: Sushma Gurram; Mark Nelson; Sage Weil=20
Cc: ceph-devel@vger.kernel.org; Zhang, Jian=20
Subject: RE: [RFC] add rocksdb support=20

Currently ceph will get stable rocksdb from branch 3.0.fb of ceph/rocks=
db , since PR https://github.com/ceph/rocksdb/pull/2 has not been merge=
d , so if you use 'git submodule update --init' to get rocksdb submodul=
e , It did not support autoconf/automake .=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Sushma Gurram=20
Sent: Saturday, June 14, 2014 2:52 AM=20
To: Shu, Xinxin; Mark Nelson; Sage Weil=20
Cc: ceph-devel@vger.kernel.org; Zhang, Jian=20
Subject: RE: [RFC] add rocksdb support=20

Hi Xinxin,=20

I tried to compile the wip-rocksdb branch, but the src/rocksdb director=
y seems to be empty. Do I need toput autoconf/automake in this director=
y?=20
It doesn't seem to have any other source files and compilation fails:=20
os/RocksDBStore.cc:10:24: fatal error: rocksdb/db.h: No such file or di=
rectory compilation terminated.=20

Thanks,=20
Sushma=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Shu, Xinxin=20
Sent: Monday, June 09, 2014 10:00 PM=20
To: Mark Nelson; Sage Weil=20
Cc: ceph-devel@vger.kernel.org; Zhang, Jian=20
Subject: RE: [RFC] add rocksdb support=20

Hi mark=20

I have finished development of support of rocksdb submodule, a pull req=
uest for support of autoconf/automake for rocksdb has been created , yo=
u can find https://github.com/ceph/rocksdb/pull/2 , if this patch is ok=
 , I will create a pull request for rocksdb submodule support , current=
ly this patch can be found https://github.com/xinxinsh/ceph/tree/wip-ro=
cksdb .=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Mark Nelson=20
Sent: Tuesday, June 10, 2014 1:12 AM=20
To: Shu, Xinxin; Sage Weil=20
Cc: ceph-devel@vger.kernel.org; Zhang, Jian=20
Subject: Re: [RFC] add rocksdb support=20

Hi Xinxin,=20

On 05/28/2014 05:05 AM, Shu, Xinxin wrote:=20
> Hi sage ,=20
> I will add two configure options to --with-librocksdb-static and --wi=
th-librocksdb , with --with-librocksdb-static option , ceph will compil=
e the code that get from ceph repository , with --with-librocksdb optio=
n , in case of distro packages for rocksdb , ceph will not compile the =
rocksdb code , will use pre-installed library. is that ok for you ?=20
>=20
> since current rocksdb does not support autoconf&automake , I will add=
 autoconf&automake support for rocksdb , but before that , i think we s=
hould fork a stable branch (maybe 3.0) for ceph .=20

I'm looking at testing out the rocksdb support as well, both for the OS=
D and for the monitor based on some issues we've been seeing lately. An=
y news on the 3.0 fork and autoconf/automake support in rocksdb?=20

Thanks,=20
Mark=20

>=20
> -----Original Message-----=20
> From: Mark Nelson [mailto:mark.nelson@inktank.com]=20
> Sent: Wednesday, May 21, 2014 9:06 PM=20
> To: Shu, Xinxin; Sage Weil=20
> Cc: ceph-devel@vger.kernel.org; Zhang, Jian=20
> Subject: Re: [RFC] add rocksdb support=20
>=20
> On 05/21/2014 07:54 AM, Shu, Xinxin wrote:=20
>> Hi, sage=20
>>=20
>> I will add rocksdb submodule into the makefile , currently we want t=
o have fully performance tests on key-value db backend , both leveldb a=
nd rocksdb. Then optimize on rocksdb performance.=20
>=20
> I'm definitely interested in any performance tests you do here. Last =
winter I started doing some fairly high level tests on raw leveldb/hype=
rleveldb/raikleveldb. I'm very interested in what you see with rocksdb =
as a backend.=20
>=20
>>=20
>> -----Original Message-----=20
>> From: Sage Weil [mailto:sage@inktank.com]=20
>> Sent: Wednesday, May 21, 2014 9:19 AM=20
>> To: Shu, Xinxin=20
>> Cc: ceph-devel@vger.kernel.org=20
>> Subject: Re: [RFC] add rocksdb support=20
>>=20
>> Hi Xinxin,=20
>>=20
>> I've pushed an updated wip-rocksdb to github/liewegas/ceph.git that =
includes the latest set of patches with the groundwork and your rocksdb=
 patch. There is also a commit that adds rocksdb as a git submodule. I'=
m thinking that, since there aren't any distro packages for rocksdb at =
this point, this is going to be the easiest way to make this usable for=
 people.=20
>>=20
>> If you can wire the submodule into the makefile, we can merge this i=
n so that rocksdb support is in the ceph.com packages on ceph.com. I su=
spect that the distros will prefer to turns this off in favor of separa=
te shared libs, but they can do this at their option if/when they inclu=
de rocksdb in the distro. I think the key is just to have both --with-l=
ibrockdb and --with-librocksdb-static (or similar) options so that you =
can either use the static or dynamically linked one.=20
>>=20
>> Has your group done further testing with rocksdb? Anything interesti=
ng to share?=20
>>=20
>> Thanks!=20
>> sage=20
>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>=20

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
