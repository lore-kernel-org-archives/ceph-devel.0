From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Tue, 05 May 2015 12:43:11 -0500
Message-ID: <5549012F.3040407@redhat.com>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net>, <55422E0A.6010204@redhat.com> <ijupkkkyuvtsofr81j33sd7l.1430402112852@email.android.com> <554237F8.5070907@redhat.com> <alpine.DEB.2.00.1504301107310.5458@cobra.newdream.net> <5543923E.1020607@redhat.com> <alpine.DEB.2.00.1505011731500.5458@cobra.newdream.net> <5547B156.8060508@redhat.com> <alpine.DEB.2.00.1505041106300.24939@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37532 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755623AbbEERnR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 13:43:17 -0400
In-Reply-To: <alpine.DEB.2.00.1505041106300.24939@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/04/2015 01:08 PM, Sage Weil wrote:
> On Mon, 4 May 2015, Mark Nelson wrote:
>> On 05/01/2015 07:33 PM, Sage Weil wrote:
>>
>> Ran through a bunch of tests on 0c728ccc over the weekend:
>>
>> http://nhm.ceph.com/newstore/5d96fe6f_vs_0c728ccc.pdf
>>
>> The good news is that sequential writes on spinning disks are looking
>> significantly better!  We went from 40x slower than filestore for small
>> sequential IO to only about 30-40% slower and we become faster than filestore
>> at 64kb+ IO sizes.
>>
>> 128kb-2MB sequential writes with data on spinning disk and rocksdb on SSD
>> regressed.  Newstore is no longer really any faster than filestore for those
>> IO sizes.  We saw something similar for random IO, where spinning disk only
>> results improved and spinning disk + rocksdb on SSD regressed.
>>
>> With everything on SSD, we saw small sequential writes improve and nearly all
>> random writes regress.  Not sure how much these regressions are due to
>> 0c728ccc vs other commits yet.
>
> That's surprising!  I pushed a commit that makes this tunable,
>
>   newstore sync submit transaction = false (default)
>
> Can you see if setting that to true (effectively reverting my last change)
> fixes the ssd regression?
>
> It may also be that this is a simple locking issue that we can fix in
> rocksdb.  Again, the behavior I saw was that the db->submit_transaction()
> call would block until the sync commit (from kv_sync_thread) finished.
> I would expect rocksdb to be more careful about that, so maybe there is
> something else funny/subtle going on.
>
> sage
>

Ok, ran through new SSD tests and wasn't able to replicate the poor 
random performance from 0c728ccc again.

http://nhm.ceph.com/newstore/sync_submit_transaction.pdf

Haven't dug into the blktrace or collectl data yet to see if there are 
any interesting differences, but I'll try to look at that later if I get 
a bit of free time.

The good news is that sync submit transaction = false seems to make a 
pretty noticeable improvement with 8c8c5903 on an SSD backed newstore 
OSD.  At small IO sizes we appear to be doing better than filestore for 
both random and sequential IO.  Interestingly random writes still appear 
to be faster than sequential writes when everything is on SSD!

It looks like the big remaining issue now is 64kb+ sized writes on SSD.

Mark
