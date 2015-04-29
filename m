From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Wed, 29 Apr 2015 08:20:18 -0500
Message-ID: <5540DA92.3070505@redhat.com>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422850AbbD2NUW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 09:20:22 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 04/29/2015 03:33 AM, Chen, Xiaoxi wrote:
> Hi Mark,
> 	Really good test:) I only played a bit on SSD, the parallel WAL thre=
ads really helps but we still have a long way to go especially on all-s=
sd case.
> I tried this https://github.com/facebook/rocksdb/blob/master/util/env=
_posix.cc#L1515  by hacking the rocksdb, but the performance difference=
 is negligible.
>
> The rocksdb digest speed should be the problem, I believe, I was plan=
ned to prove this by skip all db transaction, but failed since hitting =
other deadlock bug in newstore.

I think sage has worked through all of the deadlock bugs I was seeing=20
short of possibly something going on with the overlay code.  That=20
probably shouldn't matter on SSD though as it's probably best to leave=20
overlay off.

>
> Below are a bit more comments.
>> Sage has been furiously working away at fixing bugs in newstore and
>> improving performance.  Specifically we've been focused on write
>> performance as newstore was lagging filestore but quite a bit previo=
usly.  A
>> lot of work has gone into implementing libaio behind the scenes and =
as a
>> result performance on spinning disks with SSD WAL (and SSD backed ro=
cksdb)
>> has improved pretty dramatically. It's now often beating filestore:
>>
>
> SSD DB is still better than SSD WAL with request size > 128KB, this i=
ndicate some WALs are actually written to Level0...Hmm, could we add ne=
wstore_wal_max_ops/bytes to capping the total WAL size(how much data is=
 in WAL but not yet apply to backend FS) ?  I suspect this would improv=
e performance by prevent some IO with high WA cost and latency?

Seems like it could work, but I wish we didn't have to add a workaround=
=2E=20
  It'd be nice if we could just tell rocksdb not to propagate that data=
=2E=20
  I don't remember, can we use column families for this?

>
>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>
>> On the other hand, sequential writes are slower than random writes w=
hen
>> the OSD, DB, and WAL are all on the same device be it a spinning dis=
k or SSD.
>
> I think sequential writes slower than random is by design in Newstore=
, because for every object we can only have one WAL , that means no con=
current IO if the req_size* QD < 4MB. Not sure how many #QD do you have=
 in the test? I suspect 64 since there is a boost in seq write performa=
nce with req size > 64 ( 64KB*64=3D4MB).

You nailed it, 64.

>
> In this case,  IO pattern will be : 1 write to DB WAL->Sync-> 1 Write=
 to FS -> Sync,  we do everything in synchronize way ,which is essentia=
lly expensive.

Will you be on the performance call this morning?  Perhaps we can talk=20
about it more there?

>
> 													Xiaoxi.
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Wednesday, April 29, 2015 7:25 AM
>> To: ceph-devel
>> Subject: newstore performance update
>>
>> Hi Guys,
>>
>> Sage has been furiously working away at fixing bugs in newstore and
>> improving performance.  Specifically we've been focused on write
>> performance as newstore was lagging filestore but quite a bit previo=
usly.  A
>> lot of work has gone into implementing libaio behind the scenes and =
as a
>> result performance on spinning disks with SSD WAL (and SSD backed ro=
cksdb)
>> has improved pretty dramatically. It's now often beating filestore:
>>
>
>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>
>> On the other hand, sequential writes are slower than random writes w=
hen
>> the OSD, DB, and WAL are all on the same device be it a spinning dis=
k or SSD.
>
>> In this situation newstore does better with random writes and someti=
mes
>> beats filestore (such as in the everything-on-spinning disk tests, a=
nd when IO
>> sizes are small in the everything-on-ssd tests).
>>
>> Newstore is changing daily so keep in mind that these results are al=
most
>> assuredly going to change.  An interesting area of investigation wil=
l be why
>> sequential writes are slower than random writes, and whether or not =
we are
>> being limited by rocksdb ingest speed and how.
>
>>
>> I've also uploaded a quick perf call-graph I grabbed during the "all=
-SSD" 32KB
>> sequential write test to see if rocksdb was starving one of the core=
s, but
>> found something that looks quite a bit different:
>>
>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
