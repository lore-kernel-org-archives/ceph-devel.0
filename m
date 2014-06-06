From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: xattr spillout appears broken :(
Date: Sat, 7 Jun 2014 02:54:41 +0800
Message-ID: <CACJqLyb3cNVE=w6th0C4PavGxcppYOkVs0D+XsURyKL9=U4jww@mail.gmail.com>
References: <CAPYLRzh7bno0Ppb7hayJrc-TQM24iO-+RgtHYWZmYYVAtBYjVg@mail.gmail.com>
	<CACJqLybuxRR1hgL+b+ijmRzySFH054ZHqOYm50PmLNf-W01JOg@mail.gmail.com>
	<CAPYLRzi8HpyxEmJgyde9yrmpZP2t9_1odEwff_9Tck40tCiSCA@mail.gmail.com>
	<CACJqLyYiUcveR4-CxNsjA7PZjWyc30GjriQ_XfyaB8W+eJopbg@mail.gmail.com>
	<CACJqLyYECXY6p92Kr5G5y3mdPjDavGjFyVq6Ry5UP8fUAgJBqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:63261 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbaFFSym (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 14:54:42 -0400
Received: by mail-we0-f175.google.com with SMTP id p10so3248896wes.20
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jun 2014 11:54:41 -0700 (PDT)
In-Reply-To: <CACJqLyYECXY6p92Kr5G5y3mdPjDavGjFyVq6Ry5UP8fUAgJBqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

I have found the reason. "user.cephos.spill_out" can't be apply to new
object when calling clone method. So if the origin object is spill
out, the new object still has no spill out marker.

I pushed a commit (https://github.com/ceph/ceph/pull/1932) to help
cover this situation.


On Tue, Jun 3, 2014 at 10:33 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
> /familiar/not familiar/
>
> On Tue, Jun 3, 2014 at 10:33 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Hi Gregory,
>>
>> I checked again and again each line change about spill out codes,
>> still failed to find anything wrong.
>>
>> I ran "ceph_test_rados" then activate scrub process several times
>> locally, nothing unusual. I'm familiar with teuthoghy jobs, maybe we
>> can find the common thing among fail jobs.
>>
>>
>> On Sat, May 31, 2014 at 2:06 AM, Gregory Farnum <greg@inktank.com> wrote:
>>> On Fri, May 30, 2014 at 2:18 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>>>> Hi Gregory,
>>>>
>>>> I try to reproduce the bug in my local machine but failed.
>>>>
>>>> My test cmdline:
>>>> ./ceph_test_rados --op read 100 --op write 100 --op delete 50
>>>> --max-ops 400000 --objects 1024 --max-in-flight 64 --size 4000000
>>>> --min-stride-size 400000 --max-stride-size 800000 --max-seconds 600
>>>> --op copy_from 50 --op snap_create 50 --op snap_remove 50 --op
>>>> rollback 50 --op setattr 25 --op rmattr 25 --pool unique_pool_0
>>>>
>>>> Is there any tip to reproduce it?
>>>
>>> Hmm. I've been directly running the teuthology tests that failed; that
>>> is the command line it's running though so I think the only difference
>>> would be that I've got OSD thrashing (ie, recovery) happening while
>>> the test is running.
>>> Most of the other failures were scrub turning up inconsistencies in
>>> the xattrs at each replica/shard of an object. I didn't see any
>>> obvious mechanism by which storing values in xattrs versus leveldb
>>> would impact these higher-level primitives, but maybe you have some
>>> idea?
>>> -Greg
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
