From: Ning Yao <zay11022@gmail.com>
Subject: Re: Specify omap path for filestore
Date: Thu, 5 Nov 2015 18:33:48 +0800
Message-ID: <CALZt5jy37yJ7q=Sz1UWxcqsUxmSY=jzWrgks1jDaKtJb2NagsQ@mail.gmail.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B322002AB8@SHSMSX101.ccr.corp.intel.com>
	<C8CF870384EBCF4CAB89D2041A5C80B322002D57@SHSMSX101.ccr.corp.intel.com>
	<C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
	<CALZt5jxkbA8OBe1zxxo9F1xjaJ8m+wSydzn_UQ4V=vBT2gty7A@mail.gmail.com>
	<C8CF870384EBCF4CAB89D2041A5C80B32200D93F@SHSMSX101.ccr.corp.intel.com>
	<6F3FA899187F0043BA1827A69DA2F7CC036411C6@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34167 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031089AbbKEKdt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Nov 2015 05:33:49 -0500
Received: by wmnn186 with SMTP id n186so10092907wmn.1
        for <ceph-devel@vger.kernel.org>; Thu, 05 Nov 2015 02:33:48 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC036411C6@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "Xue, Chendi" <chendi.xue@intel.com>, Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Agreed! Actually in different use cases.
But still not heavily loaded with SSD under small write use case, on
this point, I may assume that newstore overlay would be much better?
It seems that we can do more based on NewStore to let the store using
the raw device directly based on onode_t, data_map (which can act as
the inode in filesystem), so that we can achieve the whole HDD iops as
real data without the interference of filesystem-journal and inode
get/set.

Regards
Ning Yao


2015-11-04 23:19 GMT+08:00 Chen, Xiaoxi <xiaoxi.chen@intel.com>:
> Hi Ning,
>
> Yes, we doesn=E2=80=99t save any IO, or may even need more IO as read=
 amplification by LevelDB. But the tradeoff is using SSD IOPS instead o=
f HDD IOPS,  IOPS/$$ in SSD(10K+ IOPS per $100) is 2 order cheaper than=
 that of in an HDD( 100 IOPS per $100).
>
> Some use case:
>
> 1.When we have enough load, moving any load out of the HDD definitely=
 bring some help. Omap is the thing that could be easily moved out to S=
SD , note that omap workload is not intensive but random, which is just=
 fit into the ssd already working as journal.
>
> 2. Even, we could set max_inline_xattr to 0 that force all xattr to o=
map(SSD), which will reduce the inode size thus more inode could be cac=
hed in memory. Again, SSD is more than fast for this even sharing with =
journal.
>
> 3. in RGW case, we will have some container objects with tons of omap=
, moving the omap to SSD is a clear optimization.
>
> -Xiaoxi
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Xue, Chendi
>> Sent: Wednesday, November 4, 2015 4:15 PM
>> To: Ning Yao
>> Cc: Samuel Just; ceph-devel@vger.kernel.org
>> Subject: RE: Specify omap path for filestore
>>
>> Hi, Ning
>>
>> Thanks for the advice, we did done thing you suggested in our perfor=
mance
>> tuning work, actually tuning up the usage of memory is the first thi=
ng we
>> tried.
>>
>> Firstly, I should guess the omap to ssd benefit shows when we use qu=
ite
>> intensive workload, using 140 vm doing randwrite, 8 qd each, so we a=
lmost
>> drive each HDD to utility 95+%.
>>
>> We hoped and tested on tune up the inode memory size and fd cache si=
ze,
>> since I believe if inode can be always hit in the memory which defin=
itely
>> benefit more than using omap. Sadly our server only has 32G memory t=
otal.
>> Even we set xattr size as 65535 as original configured and also fd c=
ache size as
>> 10240 as I remembered, still gain a little to the performance but ma=
y lead to
>> OOM of OSD, so that is why we came up the solution of moving omap ou=
t to
>> a SSD device.
>>
>> Another reason to move omap out is because it helps on performance
>> analysis, since omap uses keyvaluestore, and each rbd request causes=
 one or
>> more 4k inode operation, which lead a frontend and backend throughpu=
t
>> ratio as 1: 5.8, which is not that easy to explain the 5.8.
>>
>> Also we can get more randwrite iops if there is no seqwrite to one H=
DD
>> device, when HDD handles randwrite iops and also some omap(leveldb)
>> write, we can only get 175 iops disk write per HDD when util is near=
ly full.
>> when HDD only handles randwrite without any omap write, we can get 3=
25
>> iops disk write per HDD when HDD util is nearly full.
>>
>> System data please refer to below url
>> http://xuechendi.github.io/data/
>>
>> omap on HDD is before mapping to other device omap on SSD is after
>>
>> Best regards,
>> Chendi
>>
>>
>> -----Original Message-----
>> From: Ning Yao [mailto:zay11022@gmail.com]
>> Sent: Wednesday, November 4, 2015 3:09 PM
>> To: Xue, Chendi <chendi.xue@intel.com>
>> Cc: Samuel Just <sjust@redhat.com>; ceph-devel@vger.kernel.org
>> Subject: Re: Specify omap path for filestore
>>
>> Hi, Chendi,
>> I don't think it will be a big improvement compared with normal way =
to using
>> FileStore (enable filestore_max_inline_xattr_xfs and tune
>> filestore_fd_cache_size,osd_pg_object_context_cache_count,
>> filestore_omap_header_cache_size properly to achieve a high hit rate=
).Do
>> you enable  filestore_max_inline_xattr in the first test? If not, it=
 may be
>> reasonable. In my previous test, I remember just about 20%~30%
>> improvement.
>> And can you also provide cpu cost per Op on osd node?
>> Regards
>> Ning Yao
>>
>>
>> 2015-10-30 10:04 GMT+08:00 Xue, Chendi <chendi.xue@intel.com>:
>> > Hi, Sam
>> >
>> > Last week I introduced about how we saw the benefit of moving omap=
 to a
>> separate device.
>> >
>> > And here is the pull request:
>> > https://github.com/ceph/ceph/pull/6421
>> >
>> > I had tested redeploy and restart ceph cluster at my setup, the co=
des
>> works fine.
>> > one problem is do you think I should *DELETE* all the files under =
the
>> omap_path firstly? Because I notice if old pg data leaves there, osd=
 daemon
>> may run into chaos. But I am not sure if it should leave to users to=
 DELETE.
>> >
>> > Any thoughts?
>> >
>> > Also I paste some data I talked , which is about the rbd and osd w=
rite iops
>> ratio when doing randwrite to a rbd device.
>> >
>> > =3D=3D=3D=3D=3D=3DHere is some data=3D=3D=3D=3D=3D
>> > We uses 4 clients , 35 vm each to test on rbd randwrite.
>> > 4 osd physical nodes, each has 10 HDD as osd and 2 ssd as journal
>> > 2 replica
>> > filestore_max_inline_xattr_xfs=3D0
>> > filestore_max_inline_xattr_size_xfs=3D0
>> >
>> > Before moving omap to separate ssd, we saw a frontend and backend =
iops
>> > ratio of 1:5.8, rbd side total iops 1206, hdd total iops 7034 Like=
 we talked, 5.8
>> consists of 2 replica write, inode and omap writes
>> > runid         op_size    op_type             QD             engine=
               serverNum
>> clientNum         rbdNum   runtime             fio_iops         fio_=
bw               fio_latency
>> osd_iops           osd_bw             osd_latency
>> > 332            4k              randwrite         qd8            qe=
murbd           4                          4
>> 140            400 sec              1206.000         4.987 MB/s     =
 884.617 msec
>> 7034.975          47.407 MB/s    242.620 msec
>> >
>> > And after moving omap to a separate ssd, we saw a frontend vs. bac=
kend
>> ratio drops to 1:2.6, rbd side total iops 5006, hdd total iops 13089
>> > runid         op_size    op_type             QD             engine=
               serverNum
>> clientNum         rbdNum   runtime             fio_iops         fio_=
bw               fio_latency
>> osd_iops           osd_bw             osd_latency
>> > 326            4k              randwrite         qd8            qe=
murbd           4                          4
>> 140            400 sec              5006.000         19.822 MB/s    =
222.296 msec
>> 13089.020        82.897 MB/s    482.203 msec
>> >
>> >
>> > Best regards,
>> > Chendi
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>> > in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> > info at  http://vger.kernel.org/majordomo-info.html
>>   {.n +       +%  lzwm  b =EB=A7=B2  r  y=C7=A9 =D7=AFzX     =DC=A8}=
   =C6=A0z &j:+v        zZ+  +zf   h   ~    i   z   w   ?
>> & )=DF=A2 f
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
