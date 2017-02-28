From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD crashing in ~Job()
Date: Tue, 28 Feb 2017 09:03:59 +0100
Message-ID: <f1342a1c-159c-a14f-ace7-cd41ecced803@digiware.nl>
References: <fc507396-656c-c2a5-8995-cf142ec01636@digiware.nl>
 <CAJ4mKGa5Ufgpksa+AtOeCQ_DELwnmeBWeF=6GFSKpGoc3UtwxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:42039 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdB1IMA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Feb 2017 03:12:00 -0500
In-Reply-To: <CAJ4mKGa5Ufgpksa+AtOeCQ_DELwnmeBWeF=6GFSKpGoc3UtwxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 27-2-2017 16:24, Gregory Farnum wrote:
> On Mon, Feb 27, 2017 at 6:37 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> Once every 10 runs  test-erasure-code.sh is terminated with a timeout
>> during my FreeBSD tests.
>>
>> It receives an assert in:
>> /usr/srcs/Ceph/work/ceph/src/osd/OSDMapMapping.h:31
>> class ParallelPGMapper {
>> public:
>>   struct Job {
>> ....
>>     virtual ~Job() {
>>       assert(shards == 0);
>>     }
>> } }
>>
>> Anydody any suggestions on what this can be, and/or how to start
>> debugging this?
> 
> Sounds like maybe
> 1) your test hardware is slower than what we mostly use, in this
> particular job, and
> 2) the OSDMapMapping code doesn't shut down cleanly when it gets a
> TERM signal. :/
> 
> So, extend the timeout or fix the OSDMapMapping, I guess?

Got a fix-PR from Sage, and now it complets 100 testruns wiithout any
trouble. Timeouts were due to the test started only one mon, and that
made the next rados command hang and ctest timeout.

--WjW

> -Greg
> 
>>
>> --WjW
>>
>>
>> 2017-02-27 14:15:28.034683 b134480 -1
>> /usr/srcs/Ceph/work/ceph/src/osd/OSDMapMapping.h: In function 'virtual
>> ParallelPGMapper::Job::~Job()' thread b134480 time 2017
>> -02-27 14:15:27.975342
>> /usr/srcs/Ceph/work/ceph/src/osd/OSDMapMapping.h: 31: FAILED
>> assert(shards == 0)
>>
>>  ceph version Development (no_version)
>>  1: <ceph::__ceph_assert_fail(char const*, char const, int, char
>> const)+0xb21> at /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  2: <ParallelPGMapper::Job::~Job(void)+0x50> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  3: <OSDMapMapping::MappingJob::~MappingJob(void)+0x15> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  4: <OSDMapMapping::MappingJob::~MappingJob(void)+0x19> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  5:
>> <OSDMonitor::encode_pending(std::__1::shared_ptr<MonitorDBStore::Transaction>)+0xefd>
>> at /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  6: <PaxosService::propose_pending(void)+0x91d> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  7:
>> <PaxosService::dispatch(boost::intrusive_ptr<MonOpRequest>)::C_Propose::finish(int)+0x3a>
>> at /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  8: <Context::complete(int)+0x22> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  9: <SafeTimer::timer_thread(void)+0x8d7> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  10: <SafeTimerThread::entry(void)+0x19> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  11: <Thread::entry_wrapper(void)+0xc6> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  12: <Thread::_entry_func(void*)+0x15> at
>> /usr/srcs/Ceph/work/ceph/build/bin/ceph-mon
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

