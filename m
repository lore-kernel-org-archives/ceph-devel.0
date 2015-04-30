From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Thu, 30 Apr 2015 09:11:04 -0500
Message-ID: <554237F8.5070907@redhat.com>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net>,<55422E0A.6010204@redhat.com> <ijupkkkyuvtsofr81j33sd7l.1430402112852@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36674 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbbD3OLK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Apr 2015 10:11:10 -0400
In-Reply-To: <ijupkkkyuvtsofr81j33sd7l.1430402112852@email.android.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 04/30/2015 09:02 AM, Chen, Xiaoxi wrote:
> I am not sure I really understand the osd code, but from the osd log,=
  in the sequential small write case, only one inflight op happening=A1=
=AD
>
> and Mark, did you pre-allocate the rbd before doing sequential test? =
I believe you did, so both seq and random are in WAL mode.

Yes, the RBD image is pre-allocated.  Maybe Sage can chime in regarding=
=20
the one inflight op.

Mark

>
> ---- Mark Nelson=B1=E0=D0=B4 ----
>
>
> On 04/29/2015 11:38 AM, Sage Weil wrote:
>> On Wed, 29 Apr 2015, Chen, Xiaoxi wrote:
>>> Hi Mark,
>>>       Really good test:) I only played a bit on SSD, the parallel W=
AL
>>> threads really helps but we still have a long way to go especially =
on
>>> all-ssd case. I tried this
>>> https://github.com/facebook/rocksdb/blob/master/util/env_posix.cc#L=
1515
>>> by hacking the rocksdb, but the performance difference is negligibl=
e.
>>
>> It gave me a 25% bump when rocksdb is on a spinning disk, so I went =
ahead
>> and committed the change to the branch.  Probably not noticeable on =
the
>> SSD, though it can't hurt.
>>
>>> The rocksdb digest speed should be the problem, I believe, I was pl=
anned
>>> to prove this by skip all db transaction, but failed since hitting =
other
>>> deadlock bug in newstore.
>>
>> Will look at that next!
>>
>>>
>>> Below are a bit more comments.
>>>> Sage has been furiously working away at fixing bugs in newstore an=
d
>>>> improving performance.  Specifically we've been focused on write
>>>> performance as newstore was lagging filestore but quite a bit prev=
iously.  A
>>>> lot of work has gone into implementing libaio behind the scenes an=
d as a
>>>> result performance on spinning disks with SSD WAL (and SSD backed =
rocksdb)
>>>> has improved pretty dramatically. It's now often beating filestore=
:
>>>>
>>>
>>> SSD DB is still better than SSD WAL with request size > 128KB, this=
 indicate some WALs are actually written to Level0...Hmm, could we add =
newstore_wal_max_ops/bytes to capping the total WAL size(how much data =
is in WAL but not yet apply to backend FS) ?  I suspect this would impr=
ove performance by prevent some IO with high WA cost and latency?
>>>
>>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>>>
>>>> On the other hand, sequential writes are slower than random writes=
 when
>>>> the OSD, DB, and WAL are all on the same device be it a spinning d=
isk or SSD.
>>>
>>> I think sequential writes slower than random is by design in Newsto=
re,
>>> because for every object we can only have one WAL , that means no
>>> concurrent IO if the req_size* QD < 4MB. Not sure how many #QD do y=
ou
>>> have in the test? I suspect 64 since there is a boost in seq write
>>> performance with req size > 64 ( 64KB*64=3D4MB).
>>>
>>> In this case, IO pattern will be : 1 write to DB WAL->Sync-> 1 Writ=
e to
>>> FS -> Sync, we do everything in synchronize way ,which is essential=
ly
>>> expensive.
>>
>> The number of syncs is the same for appends vs wal... in both cases =
we
>> fdatasync the file and the db commit, but with WAL the fs sync comes=
 after
>> the commit point instead of before (and we don't double-write the da=
ta).
>> Appends should still be pipelined (many in flight for the same objec=
t)...
>> and the db syncs will be batched in both cases (submit_transaction f=
or
>> each io, and a single thread doing the submit_transaction_sync in a =
loop).
>>
>> If that's not the case then it's an accident?
>>
>> sage
>
> So I ran some more tests last night on 2c914df7 to see if any of the =
new
> changes made much difference for spinning disk small sequential write=
s,
> and the short answer is no.  Since overlay now works again I also ran
> tests with overlay enabled, and this may have helped marginally (and =
had
> mixed results for random writes, may need to tweak the default).
>
> After this I got to thinking about how the WAL-on-SSD results were so
> much better that I wanted to confirm that this issue is WAL related. =
 I
> tried setting DisableWAL. This resulted in about a 90x increase in
> sequential write performance, but only a 2x increase in random write
> performance.  What's more, if you look at the last graph on the pdf
> linked below, you can see that sequential 4k writes with WAL enabled =
are
> significantly slower than 4K random writes, but sequential 4K writes
> with WAL disabled are significantly faster.
>
> http://nhm.ceph.com/newstore/Newstore_DisableWAL.pdf
>
> So I guess now I wonder what is happening that is different in each
> case.  I'll probably sit down and start looking through the blktrace
> data and try to get more statistics out of rocksdb for each case.  It
> would be useful if we could tie the rocksdb stats call into an asok c=
ommand:
>
> DB::GetProperty("rocksdb.stats", &stats)
>
> Mark
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
