From: Samuel Just <sjust@redhat.com>
Subject: Re: replicatedPG assert fails
Date: Thu, 21 Jul 2016 08:22:41 -0700
Message-ID: <CAN=+7FWD4UzR0QnYEBmmh9brRWan+2yjd45P28b4DNhQYXgYmA@mail.gmail.com>
References: <CAG0LsznhUpP=ub-TmiHSO0A9JZWjk8eov2Lu8y15snqcdG_4Aw@mail.gmail.com>
 <CAN=+7FWkeX+5zwzuYcHE35ZSHWO7ZyUVG0vHd3Y+K5AEPPsb1w@mail.gmail.com> <CAG0LszmDNdrJpBM9sA3ivuZmzvqupPOyHafQCJuvooiamiUnqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34804 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbcGUPWn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 11:22:43 -0400
Received: by mail-qk0-f181.google.com with SMTP id o67so76699377qke.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 08:22:42 -0700 (PDT)
In-Reply-To: <CAG0LszmDNdrJpBM9sA3ivuZmzvqupPOyHafQCJuvooiamiUnqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sugang Li <sugangli@winlab.rutgers.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Oh, that's a much more complicated change.  You are going to need to
make extensive changes to the OSD to make that work.
-Sam

On Thu, Jul 21, 2016 at 8:21 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
> Hi Sam,
>
> Thanks for the quick reply. The main modification I made is to call
> calc_target within librados::IoCtxImpl::aio_operate before op_submit,
> so that I can get all replicated OSDs' id, and send a write op to each
> of them. I can also attach the modified code if necessary.
>
> I just reproduced this error with the conf you provided,  please see below:
> osd/ReplicatedPG.cc: In function 'int
> ReplicatedPG::find_object_context(const hobject_t&, ObjectContextRef*,
> bool, bool, hobject_t*)' thread 7fd6aba59700 time 2016-07-21
> 15:09:26.431436
> osd/ReplicatedPG.cc: 9042: FAILED assert(oid.pool ==
> static_cast<int64_t>(info.pgid.pool()))
>  ceph version 10.2.0-2562-g0793a28 (0793a2844baa38f6bcc5c1724a1ceb9f8f1bbd9c)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x8b) [0x7fd6c5733e8b]
>  2: (ReplicatedPG::find_object_context(hobject_t const&,
> std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*)+0x1e54)
> [0x7fd6c51ef7c4]
>  3: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x186e) [0x7fd6c521fe9e]
>  4: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
> ThreadPool::TPHandle&)+0x73c) [0x7fd6c51dca3c]
>  5: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f5)
> [0x7fd6c5094d65]
>  6: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
> const&)+0x5d) [0x7fd6c5094f8d]
>  7: (OSD::ShardedOpWQ::_process(unsigned int,
> ceph::heartbeat_handle_d*)+0x86c) [0x7fd6c50b603c]
>  8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x947)
> [0x7fd6c5724117]
>  9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7fd6c5726270]
>  10: (()+0x8184) [0x7fd6c3b98184]
>  11: (clone()+0x6d) [0x7fd6c1aa937d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 2016-07-21 15:09:26.454854 7fd6aba59700 -1 osd/ReplicatedPG.cc: In
> function 'int ReplicatedPG::find_object_context(const hobject_t&,
> ObjectContextRef*, bool, bool, hobject_t*)' thread 7fd6aba59700 time
> 2016-07-21 15:09:26.431436
>
>
> This error occurs three times since I wrote to three OSDs.
>
> Thanks,
>
> Sugang
>
> On Thu, Jul 21, 2016 at 10:54 AM, Samuel Just <sjust@redhat.com> wrote:
>> Hmm.  Can you provide more information about the poison op?  If you
>> can reproduce with
>> debug osd = 20
>> debug filestore = 20
>> debug ms = 1
>> it should be easier to work out what is going on.
>> -Sam
>>
>> On Thu, Jul 21, 2016 at 7:13 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>>> Hi all,
>>>
>>> I am working on a research project which requires multiple write
>>> operations for the same object at the same time from the client. At
>>> the OSD side, I got this error:
>>> osd/ReplicatedPG.cc: In function 'int
>>> ReplicatedPG::find_object_context(const hobject_t&, ObjectContextRef*,
>>> bool, bool, hobject_t*)' thread 7f0586193700 time 2016-07-21
>>> 14:02:04.218448
>>> osd/ReplicatedPG.cc: 9041: FAILED assert(oid.pool ==
>>> static_cast<int64_t>(info.pgid.pool()))
>>>  ceph version 10.2.0-2562-g0793a28 (0793a2844baa38f6bcc5c1724a1ceb9f8f1bbd9c)
>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>> const*)+0x8b) [0x7f059fe6dd7b]
>>>  2: (ReplicatedPG::find_object_context(hobject_t const&,
>>> std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*)+0x1dbb)
>>> [0x7f059f9296fb]
>>>  3: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x186e) [0x7f059f959d7e]
>>>  4: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
>>> ThreadPool::TPHandle&)+0x73c) [0x7f059f916a0c]
>>>  5: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f5)
>>> [0x7f059f7ced65]
>>>  6: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
>>> const&)+0x5d) [0x7f059f7cef8d]
>>>  7: (OSD::ShardedOpWQ::_process(unsigned int,
>>> ceph::heartbeat_handle_d*)+0x86c) [0x7f059f7f003c]
>>>  8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x947)
>>> [0x7f059fe5e007]
>>>  9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f059fe60160]
>>>  10: (()+0x8184) [0x7f059e2d2184]
>>>  11: (clone()+0x6d) [0x7f059c1e337d]
>>>
>>> And at the client side, I got segmentation fault.
>>>
>>> I am wondering what will be the possible reason that cause the assert fail?
>>>
>>> Thanks,
>>>
>>> Sugang
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
