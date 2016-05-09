From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Perhaps a missing dependancy in the makefiles
Date: Mon, 9 May 2016 18:26:10 +0200
Message-ID: <73845ecd-292b-351c-75ec-c8ca2f8241dc@digiware.nl>
References: <add58916-4482-936f-53f7-a79573fc9925@digiware.nl>
 <CAJE9aOO5bhVwGwBEDXEz+=uDx_nosV+F=NBmJv5qCcHiTSn8fw@mail.gmail.com>
 <8106b460-2ae6-4202-ad61-6a98e4f3cbae@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:33881 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbcEIQ0l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 May 2016 12:26:41 -0400
In-Reply-To: <8106b460-2ae6-4202-ad61-6a98e4f3cbae@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 6-5-2016 09:28, Willem Jan Withagen wrote:
> On 6-5-2016 06:57, kefu chai wrote:
>> On Thu, May 5, 2016 at 12:27 AM, Willem Jan Withagen <wjw@digiware.nl>
>> wrote:
>>> Hi,
>>>
>>> Everytime I run a parallel make on the full tree I get the following
>>> complaint:
>>> In file included from db/builder.cc:16:
>>> In file included from ./db/compaction_iterator.h:14:
>>> In file included from ./db/compaction.h:13:
>>> ./util/mutable_cf_options.h:28:21: error: no member named
>>> 'soft_pending_compaction_bytes_limit' in
>>>       'rocksdb::Options'; did you mean
>>> 'hard_pending_compaction_bytes_limit'?
>>>             options.soft_pending_compaction_bytes_limit),
>>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>                     hard_pending_compaction_bytes_limit
>>>
>>> Then I just run along with a single threaded make, and everything
>>> completes just fine.
>>>
>>> So that is probably a missing dependency for either db/builder.cc, or
>>> ./util/mutable_cf_options.h.
>>>
>>> Suggestions on how to fix this?
>>
>> Willem, not sure what is going on in your tree. but rocksdb::Options does
>> have this member variables: it is inherited from its parent class
>> ColumnFamilyOptions.
> 
> Oke, thanx for the confirmation.
> 
> Well the "joke" is that a next run continuing where it left off makes it to
> the end, without any hickups...
> And yes, a run on CentOS with the Ceph/Ceph tree does not have this
> problem.
> Perhaps that my packages installed rockdb throws dirt into the equation...

It seems a fresh checkout "fixed" this.

--WjW

