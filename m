From: Sugang Li <sugangli@winlab.rutgers.edu>
Subject: Re: replicatedPG assert fails
Date: Fri, 22 Jul 2016 11:30:22 -0400
Message-ID: <CAG0Lsz=ncHsCLoowwXY3e2E694VKoqzDMyNfrTToaxE_4CxJNA@mail.gmail.com>
References: <CAG0LsznhUpP=ub-TmiHSO0A9JZWjk8eov2Lu8y15snqcdG_4Aw@mail.gmail.com>
 <CAN=+7FWkeX+5zwzuYcHE35ZSHWO7ZyUVG0vHd3Y+K5AEPPsb1w@mail.gmail.com>
 <CAG0LszmDNdrJpBM9sA3ivuZmzvqupPOyHafQCJuvooiamiUnqQ@mail.gmail.com>
 <CAN=+7FWD4UzR0QnYEBmmh9brRWan+2yjd45P28b4DNhQYXgYmA@mail.gmail.com>
 <CAG0LsznYeRyG8Bi9y6crBC2s1J1xSjm_YZvnaTuXvJkkrdD=4w@mail.gmail.com>
 <CAN=+7FWis8Gm-X2Zm59fVdBbwuXyJYMWWy5rJ9Wrpdzhw-pH6g@mail.gmail.com>
 <CAN=+7FVxvdPXofUXfB1D1h_nm-0uZOUAgRwX4Tiak3Sp+a5Hkw@mail.gmail.com>
 <CAG0Lsz=+JO2BtgUvoYkrnw-7WnOwZrOS+TANk6ykZbwt9X32Jg@mail.gmail.com>
 <CAN=+7FVRDO1yf_NaCm6PZ1P6rk=GhPBTqzxhSuiXZuJa0Yt8pg@mail.gmail.com>
 <CAG0Lszk9_Ngf0Q82FRYzs=7qWScNJimQp1y=zTDSyYCSC5S71w@mail.gmail.com>
 <CAN=+7FWe3B_5+_x3s09j9LnfL3dSAOvPSZJhLBdwyiNQ7123fw@mail.gmail.com>
 <CAG0Lsznj+cQf5CD9pirE2qArURT+DVHD0V0=g=ud4NLYqGm7ow@mail.gmail.com>
 <CAN=+7FVsj-9ek9GKD5apWr7S0iFwrfezQLGgKaOkECtkcH9_Cg@mail.gmail.com>
 <CAG0LszkW3pmOysb4jo1ZoGdTUjEwKoE==s=+bEmA+m5nNbL+Zg@mail.gmail.com> <CAN=+7FX1T_X9GfZVGX=uf3E3J2cnkO1Br=xO4E3UMdxv7DLOnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36180 "EHLO
	mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbcGVPaY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2016 11:30:24 -0400
Received: by mail-qt0-f173.google.com with SMTP id 52so63564143qtq.3
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jul 2016 08:30:23 -0700 (PDT)
In-Reply-To: <CAN=+7FX1T_X9GfZVGX=uf3E3J2cnkO1Br=xO4E3UMdxv7DLOnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I am confused. Could you describe a little bit more about that?

Sugang

On Fri, Jul 22, 2016 at 11:27 AM, Samuel Just <sjust@redhat.com> wrote:
> Not if you want the PG log to have consistent ordering.
> -Sam
>
> On Fri, Jul 22, 2016 at 7:00 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>> Actually write lock the object only.  Is that gonna work?
>>
>> Sugang
>>
>> On Thu, Jul 21, 2016 at 5:59 PM, Samuel Just <sjust@redhat.com> wrote:
>>> Write lock on the whole pg?  How do parallel clients work?
>>> -Sam
>>>
>>> On Thu, Jul 21, 2016 at 12:36 PM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>>>> The error above occurs when I am sending MOSOp to the replicas, and I
>>>> have to fix that first.
>>>>
>>>> For the consistency, we are still using the Primary OSD as a control
>>>> center. That is, the client always goes to Primary OSD to ask for a
>>>> write lock, then write the replica.
>>>>
>>>> Sugang
>>>>
>>>> On Thu, Jul 21, 2016 at 3:28 PM, Samuel Just <sjust@redhat.com> wrote:
>>>>> Well, they are actually different types with different encodings and
>>>>> different contents.  The client doesn't really have the information
>>>>> needed to build a MSG_OSD_REPOP.  Your best bet will be to send an
>>>>> MOSDOp to the replicas and hack up a write path that makes that work.
>>>>>
>>>>> How do you plan to address the consistency problems?
>>>>> -Sam
>>>>>
>>>>> On Thu, Jul 21, 2016 at 11:11 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>>>>>> So, to start with, I think one naive  way is to make the replica think
>>>>>> it receives an op from the primary OSD, which actually comes from the
>>>>>> client. And the branching point looks like started from
>>>>>> OSD::dispatch_op_fast, where handle_op or handle_replica_op is called
>>>>>> based on the type of the request. So my question is, at the client
>>>>>> side, is there a way that I could set the corresponding variables
>>>>>> referred by "op->get_req()->get_type()" to  MSG_OSD_SUBOP or
>>>>>> MSG_OSD_REPOP?
>>>>>>
>>>>>> Sugang
>>>>>>
>>>>>> On Thu, Jul 21, 2016 at 12:03 PM, Samuel Just <sjust@redhat.com> wrote:
>>>>>>> Parallel read will be a *lot* easier since read-from-replica already
>>>>>>> works.  Write to replica, however, is tough.  The write path uses a
>>>>>>> lot of structures which are only populated on the primary.  You're
>>>>>>> going to have to hack up most of the write path to bypass the existing
>>>>>>> replication machinery.  Beyond that, maintaining consistency will
>>>>>>> obviously be a challenge.
>>>>>>> -Sam
>>>>>>>
>>>>>>> On Thu, Jul 21, 2016 at 8:49 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>>>>>>>> My goal is to achieve parallel write/read from the client instead of
>>>>>>>> the primary OSD.
>>>>>>>>
>>>>>>>> Sugang
>>>>>>>>
>>>>>>>> On Thu, Jul 21, 2016 at 11:47 AM, Samuel Just <sjust@redhat.com> wrote:
>>>>>>>>> I may be misunderstanding your goal.  What are you trying to achieve?
>>>>>>>>> -Sam
>>>>>>>>>
>>>>>>>>> On Thu, Jul 21, 2016 at 8:43 AM, Samuel Just <sjust@redhat.com> wrote:
>>>>>>>>>> Well, that assert is asserting that the object is in the pool that the
>>>>>>>>>> pg operating on it belongs to.  Something very wrong must have
>>>>>>>>>> happened for it to be not true.  Also, replicas have basically none of
>>>>>>>>>> the code required to handle a write, so I'm kind of surprised it got
>>>>>>>>>> that far.  I suggest that you read the debug logging and read the OSD
>>>>>>>>>> op handling path.
>>>>>>>>>> -Sam
>>>>>>>>>>
>>>>>>>>>> On Thu, Jul 21, 2016 at 8:34 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>>>>>>>>>>> Yes, I understand that. I was introduced to Ceph only 1 month ago, but
>>>>>>>>>>> I have the basic idea of Ceph communication pattern now. I have not
>>>>>>>>>>> make any changes to OSD yet. So I was wondering what is purpose of
>>>>>>>>>>> this "assert(oid.pool == static_cast<int64_t>(info.pgid.pool()))", and
>>>>>>>>>>> to change the code in OSD, what are the main aspects I should pay
>>>>>>>>>>> attention to?
>>>>>>>>>>> Since this is only a research project, the implementation does not
>>>>>>>>>>> have to be very sophisticated.
>>>>>>>>>>>
>>>>>>>>>>> I know my question is kinda too broad, any hints or suggestions will
>>>>>>>>>>> be highly appreciated.
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>>
>>>>>>>>>>> Sugang
>>>>>>>>>>>
>>>>>>>>>>> On Thu, Jul 21, 2016 at 11:22 AM, Samuel Just <sjust@redhat.com> wrote:
>>>>>>>>>>>> Oh, that's a much more complicated change.  You are going to need to
>>>>>>>>>>>> make extensive changes to the OSD to make that work.
>>>>>>>>>>>> -Sam
>>>>>>>>>>>>
>>>>>>>>>>>> On Thu, Jul 21, 2016 at 8:21 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>>>>>>>>>>>>> Hi Sam,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks for the quick reply. The main modification I made is to call
>>>>>>>>>>>>> calc_target within librados::IoCtxImpl::aio_operate before op_submit,
>>>>>>>>>>>>> so that I can get all replicated OSDs' id, and send a write op to each
>>>>>>>>>>>>> of them. I can also attach the modified code if necessary.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I just reproduced this error with the conf you provided,  please see below:
>>>>>>>>>>>>> osd/ReplicatedPG.cc: In function 'int
>>>>>>>>>>>>> ReplicatedPG::find_object_context(const hobject_t&, ObjectContextRef*,
>>>>>>>>>>>>> bool, bool, hobject_t*)' thread 7fd6aba59700 time 2016-07-21
>>>>>>>>>>>>> 15:09:26.431436
>>>>>>>>>>>>> osd/ReplicatedPG.cc: 9042: FAILED assert(oid.pool ==
>>>>>>>>>>>>> static_cast<int64_t>(info.pgid.pool()))
>>>>>>>>>>>>>  ceph version 10.2.0-2562-g0793a28 (0793a2844baa38f6bcc5c1724a1ceb9f8f1bbd9c)
>>>>>>>>>>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>>>>>>>>> const*)+0x8b) [0x7fd6c5733e8b]
>>>>>>>>>>>>>  2: (ReplicatedPG::find_object_context(hobject_t const&,
>>>>>>>>>>>>> std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*)+0x1e54)
>>>>>>>>>>>>> [0x7fd6c51ef7c4]
>>>>>>>>>>>>>  3: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x186e) [0x7fd6c521fe9e]
>>>>>>>>>>>>>  4: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
>>>>>>>>>>>>> ThreadPool::TPHandle&)+0x73c) [0x7fd6c51dca3c]
>>>>>>>>>>>>>  5: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>>>>>>>>>>>> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f5)
>>>>>>>>>>>>> [0x7fd6c5094d65]
>>>>>>>>>>>>>  6: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
>>>>>>>>>>>>> const&)+0x5d) [0x7fd6c5094f8d]
>>>>>>>>>>>>>  7: (OSD::ShardedOpWQ::_process(unsigned int,
>>>>>>>>>>>>> ceph::heartbeat_handle_d*)+0x86c) [0x7fd6c50b603c]
>>>>>>>>>>>>>  8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x947)
>>>>>>>>>>>>> [0x7fd6c5724117]
>>>>>>>>>>>>>  9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7fd6c5726270]
>>>>>>>>>>>>>  10: (()+0x8184) [0x7fd6c3b98184]
>>>>>>>>>>>>>  11: (clone()+0x6d) [0x7fd6c1aa937d]
>>>>>>>>>>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>>>>>>>>>>> needed to interpret this.
>>>>>>>>>>>>> 2016-07-21 15:09:26.454854 7fd6aba59700 -1 osd/ReplicatedPG.cc: In
>>>>>>>>>>>>> function 'int ReplicatedPG::find_object_context(const hobject_t&,
>>>>>>>>>>>>> ObjectContextRef*, bool, bool, hobject_t*)' thread 7fd6aba59700 time
>>>>>>>>>>>>> 2016-07-21 15:09:26.431436
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> This error occurs three times since I wrote to three OSDs.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sugang
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Thu, Jul 21, 2016 at 10:54 AM, Samuel Just <sjust@redhat.com> wrote:
>>>>>>>>>>>>>> Hmm.  Can you provide more information about the poison op?  If you
>>>>>>>>>>>>>> can reproduce with
>>>>>>>>>>>>>> debug osd = 20
>>>>>>>>>>>>>> debug filestore = 20
>>>>>>>>>>>>>> debug ms = 1
>>>>>>>>>>>>>> it should be easier to work out what is going on.
>>>>>>>>>>>>>> -Sam
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Thu, Jul 21, 2016 at 7:13 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>>>>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I am working on a research project which requires multiple write
>>>>>>>>>>>>>>> operations for the same object at the same time from the client. At
>>>>>>>>>>>>>>> the OSD side, I got this error:
>>>>>>>>>>>>>>> osd/ReplicatedPG.cc: In function 'int
>>>>>>>>>>>>>>> ReplicatedPG::find_object_context(const hobject_t&, ObjectContextRef*,
>>>>>>>>>>>>>>> bool, bool, hobject_t*)' thread 7f0586193700 time 2016-07-21
>>>>>>>>>>>>>>> 14:02:04.218448
>>>>>>>>>>>>>>> osd/ReplicatedPG.cc: 9041: FAILED assert(oid.pool ==
>>>>>>>>>>>>>>> static_cast<int64_t>(info.pgid.pool()))
>>>>>>>>>>>>>>>  ceph version 10.2.0-2562-g0793a28 (0793a2844baa38f6bcc5c1724a1ceb9f8f1bbd9c)
>>>>>>>>>>>>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>>>>>>>>>>> const*)+0x8b) [0x7f059fe6dd7b]
>>>>>>>>>>>>>>>  2: (ReplicatedPG::find_object_context(hobject_t const&,
>>>>>>>>>>>>>>> std::shared_ptr<ObjectContext>*, bool, bool, hobject_t*)+0x1dbb)
>>>>>>>>>>>>>>> [0x7f059f9296fb]
>>>>>>>>>>>>>>>  3: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x186e) [0x7f059f959d7e]
>>>>>>>>>>>>>>>  4: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
>>>>>>>>>>>>>>> ThreadPool::TPHandle&)+0x73c) [0x7f059f916a0c]
>>>>>>>>>>>>>>>  5: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>>>>>>>>>>>>>>> std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3f5)
>>>>>>>>>>>>>>> [0x7f059f7ced65]
>>>>>>>>>>>>>>>  6: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>
>>>>>>>>>>>>>>> const&)+0x5d) [0x7f059f7cef8d]
>>>>>>>>>>>>>>>  7: (OSD::ShardedOpWQ::_process(unsigned int,
>>>>>>>>>>>>>>> ceph::heartbeat_handle_d*)+0x86c) [0x7f059f7f003c]
>>>>>>>>>>>>>>>  8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x947)
>>>>>>>>>>>>>>> [0x7f059fe5e007]
>>>>>>>>>>>>>>>  9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f059fe60160]
>>>>>>>>>>>>>>>  10: (()+0x8184) [0x7f059e2d2184]
>>>>>>>>>>>>>>>  11: (clone()+0x6d) [0x7f059c1e337d]
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> And at the client side, I got segmentation fault.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I am wondering what will be the possible reason that cause the assert fail?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Sugang
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
