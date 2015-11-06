From: Sage Weil <sage@newdream.net>
Subject: RE: Specify omap path for filestore
Date: Fri, 6 Nov 2015 02:28:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511060226110.5830@cobra.newdream.net>
References: <C8CF870384EBCF4CAB89D2041A5C80B322002AB8@SHSMSX101.ccr.corp.intel.com> <C8CF870384EBCF4CAB89D2041A5C80B322002D57@SHSMSX101.ccr.corp.intel.com> <C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
 <CALZt5jxkbA8OBe1zxxo9F1xjaJ8m+wSydzn_UQ4V=vBT2gty7A@mail.gmail.com> <C8CF870384EBCF4CAB89D2041A5C80B32200D93F@SHSMSX101.ccr.corp.intel.com> <6F3FA899187F0043BA1827A69DA2F7CC036411C6@shsmsx102.ccr.corp.intel.com> <CALZt5jy37yJ7q=Sz1UWxcqsUxmSY=jzWrgks1jDaKtJb2NagsQ@mail.gmail.com>
 <72556480-689c-430a-af36-4e01cfcec976@email.android.com> <6F3FA899187F0043BA1827A69DA2F7CC03641BA9@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-863391676-1446805725=:5830"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34136 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1033039AbbKFK2q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 05:28:46 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC03641BA9@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Ning Yao <zay11022@gmail.com>, "Xue, Chendi" <chendi.xue@intel.com>, Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-863391676-1446805725=:5830
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Nov 2015, Chen, Xiaoxi wrote:
> Can we simply the case as cephFS and RGW both has dedicate metadata poo=
l
> ---- So we can solve this in deployment, using OSD with keyvaluestore
> backend for it ( on SSD) should be a best fit.

I think that's a good approach for the current code (FileStore and/or=20
KeyValueStore).

But for NewStore I'd like to solve this problem directly so that it can b=
e=20
used for both cases.  Rocksdb has a mechanism for moving lower level ssts=
=20
to a slower device based on a total size threshold on the main device;=20
hopefully this can be used so that we can give it both an ssd and hdd.

sage

> =C2=A0
>=20
> Thus for New-Newstore, we just focus on data pool?
>=20
> =C2=A0
>=20
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Friday, November 6, 2015 1:11 AM
> To: Ning Yao; Chen, Xiaoxi
> Cc: Xue, Chendi; Samuel Just; ceph-devel@vger.kernel.org
> Subject: Re: Specify omap path for filestore
>=20
> =C2=A0
>=20
> Yes.=C2=A0 The hard part here in my view is the allocation of space bet=
ween ssd
> and hdd when the amount of omap data can vary widely, from very little =
for
> rbd to the entire pool for rgw indexes or cephfs metadata.
>=20
> sage
>=20
> =C2=A0
>=20
> On November 5, 2015 11:33:48 AM GMT+01:00, Ning Yao <zay11022@gmail.com=
>
> wrote:
>=20
> Agreed! Actually in different use cases.
> But still not heavily loaded with SSD under small write use case, on
> this point, I may assume that newstore overlay would be much better?
> It seems that we can do more based on NewStore to let the store using
> the raw device directly based on onode_t, data_map (which can act as
> the inode in filesystem), so that we can achieve the whole HDD iops as
> real data without the interference of filesystem-journal and inode
> get/set.
> Regards
> Ning Yao
> 2015-11-04 23:19 GMT+08:00 Chen, Xiaoxi <xiaoxi.chen@intel.com>:
>=20
>  Hi Ning,
>  Yes, we doesn?t save any IO, or may even need more IO as read amplific=
ation b
> y LevelDB. But the tradeoff is using SSD IOPS instead of HDD IOPS,=C2=A0=
 IOPS/$$=20
> in SSD(10K+ IOPS per $100) is 2 order cheaper than that
>=20
> of in an HDD( 100 IOPS per $100).
>  Some use case:
>  1.When we have enough load, moving any load out of the HDD definitely =
bring
>  some help. Omap is the thing that could be easily moved out to SSD , n=
ote t
> hat omap workload is not intensive but random, which is just fit into t=
he ss
> d already working as journal.
>  2. Even, we could set max_inline_xattr to 0 that force all xattr to om=
ap(SS
> D), which will reduce the inode size thus more inode could be cached in=
 memo
> ry. Again, SSD is more than fast for this even sharing with journal.
>  3. in RGW case, we will have some container objects with tons of omap,=
 movi
> ng the omap to SSD is a clear optimization.
>  -Xiaoxi
>=20
>  -----Original Message-----
>  From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>  owner@vger.kernel.org] On Behalf Of Xue, Chendi
>=20
> Sent: Wednesday, November 4, 2015 4:15 PM
>  To: Ning Yao
>  Cc: Samuel Just; ceph-devel@vger.kernel.org
>  Subject: RE: Specify omap path for filestore
>  Hi, Ning
>  Thanks for the advice, we did done thing you suggested in our performa=
nce
>  tuning work, actually tuning up the usage of memory is the first thing=
 we
>  tried.
>  Firstly, I should guess the omap to ssd benefit shows when we use quit=
e
>  intensive workload, using 140 vm doing randwrite, 8 qd each, so we alm=
ost
>  drive each HDD to utility 95+%.
>  We hoped and tested on tune up the inode memory size and fd cache size=
,
>  since I believe if inode can be always hit in the memory which definit=
ely
>  benefit more than using omap. Sadly our server only has 32G memory tot=
al.
>  Even we set xattr size as 65535 as original configured and also fd cac=
he si
> ze as
>  10240 as I remembered, still gain a little to the performance but may =
lead=20
> to
>  OOM of OSD,
>=20
> so that is why we came up the solution of moving omap out to
>  a SSD device.
>  Another reason to move omap out is because it helps on performance
>  analysis, since omap uses keyvaluestore, and each rbd request causes o=
ne or
>  more 4k inode operation, which lead a frontend and backend throughput
>  ratio as 1: 5.8, which is not that easy to explain the 5.8.
>  Also we can get more randwrite iops if there is no seqwrite to one HDD
>  device, when HDD handles randwrite iops and also some omap(leveldb)
>  write, we can only get 175 iops disk write per HDD when util is nearly=
 full
> .
>  when HDD only handles randwrite without any omap write, we can get 325
>  iops disk write per HDD when HDD util is nearly full.
>  System data please refer to below url
>  http://xuechendi.github.io/data/
>  omap on HDD is before mapping to other device omap on SSD is after
>  Best
>=20
> regards,
>  Chendi
>  -----Original Message-----
>  From: Ning Yao [mailto:zay11022@gmail.com]
>  Sent: Wednesday, November 4, 2015 3:09 PM
>  To: Xue, Chendi <chendi.xue@intel.com>
>  Cc: Samuel Just <sjust@redhat.com>; ceph-devel@vger.kernel.org
>  Subject: Re: Specify omap path for filestore
>  Hi, Chendi,
>  I don't think it will be a big improvement compared with normal way to=
 usin
> g
>  FileStore (enable filestore_max_inline_xattr_xfs and tune
>  filestore_fd_cache_size,osd_pg_object_context_cache_count,
>  filestore_omap_header_cache_size properly to achieve a high hit rate).=
Do
>  you enable=C2=A0 filestore_max_inline_xattr in the first test? If not,=
 it may be
>  reasonable. In my previous test, I remember just about 20%~30%
>  improvement.
>  And can you also provide cpu cost per Op on osd node?
>  Regards
>  Ning Yao
>  2015-10-30 10:04 GMT+08:00 Xue, Chendi
>=20
> <chendi.xue@intel.com>:
>=20
>  Hi, Sam
>  Last week I introduced about how we saw the benefit of moving omap to =
a
>=20
>  separate device.
>=20
>  And here is the pull request:
>  https://github.com/ceph/ceph/pull/6421
>  I had tested redeploy and restart ceph cluster at my setup, the codes
>=20
>  works fine.
>=20
>  one problem is do you think I should *DELETE* all the files under the
>=20
>  omap_path firstly? Because I notice if old pg data leaves there, osd d=
aemon
>  may run into chaos. But I am not sure if it
>=20
> should leave to users to DELETE.
>=20
>  Any thoughts?
>  Also I paste some data I talked , which is about the rbd and osd write=
 iops
>=20
>  ratio when doing randwrite to a rbd device.
>=20
>  =3D=3D=3D=3D=3D=3DHere is some data=3D=3D=3D=3D=3D
>  We uses 4 clients , 35 vm each to test on rbd randwrite.
>  4 osd physical nodes, each has 10 HDD as osd and 2 ssd as journal
>  2 replica
>  filestore_max_inline_xattr_xfs=3D0
>  filestore_max_inline_xattr_size_xfs=3D0
>  Before moving omap to separate ssd, we saw a frontend and backend iops
>  ratio of 1:5.8, rbd side total iops 1206, hdd total iops 7034 Like we =
talke
> d, 5.8
>=20
>  consists of 2 replica write, inode and omap writes
>=20
>  runid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op_size=C2=A0=C2=
=A0=C2=A0 op_type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 QD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 engine=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serverNum
>=20
>  clientNum=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbdNum=C2=A0=
=C2=A0 runtime=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 fio_iops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fio=
_bw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fio_latency
>  osd_iops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
sd_bw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 osd_latency
>=20
>  332=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
4k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 randwrite=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qd8=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemurbd=C2=A0=
=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>=20
>  140=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
400 sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1206.000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.9=
87 MB/s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 884.61
> 7 msec
>  7034.975=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 47.407 =
MB/s=C2=A0=C2=A0 =C2=A0242.620 msec
>=20
>  And after moving omap to a separate ssd, we saw a frontend vs. backend
>=20
>  ratio drops to
>=20
> 1:2.6, rbd side total iops 5006, hdd total iops 13089
>=20
>  runid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op_size=C2=A0=C2=
=A0=C2=A0 op_type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 QD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 engine=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serverNum
>=20
>  clientNum=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbdNum=C2=A0=
=C2=A0 runtime=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 fio_iops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fio=
_bw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fio_latency
>  osd_iops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
sd_bw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 osd_latency
>=20
>  326=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
4k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 randwrite=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qd8=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemurbd=C2=A0=
=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A04
>=20
>  140=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
400 sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 5006.000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19.=
822 MB/s=C2=A0=C2=A0=C2=A0 222.296
>  msec
>  13089.020=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 82.897 MB/s=C2=A0=C2=
=A0=C2=A0 482.203 msec
>=20
>  Best regards,
>  Chendi
>=20
> --
>  To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>  in the body of a message to majordomo@vger.kernel.org More
>=20
>  majordomo
>=20
>  info at=C2=A0 http://vger.kernel.org/majordomo-info.html
>=20
> =C2=A0=C2=A0 {.n +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +%=C2=A0 lzwm=C2=
=A0 b ?=C2=A0 r=C2=A0 y? ?zX=C2=A0=C2=A0=C2=A0=C2=A0 ?}=C2=A0=C2=A0 ?z &j=
:+v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zZ+=C2=A0 +zf=C2=A0=C2=A0 h=
=C2=A0=C2=A0 ~=C2=A0=C2=A0=C2=A0 i
> =C2=A0=C2=A0 z =C2=A0=C2=A0w=C2=A0=C2=A0 ?
>  & )? f
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> Sent from Kaiten Mail. Please excuse my brevity.
>=20
>=20
>=20
--557981400-863391676-1446805725=:5830--
