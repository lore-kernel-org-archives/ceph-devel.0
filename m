From: Srikanth Madugundi <srikanth.madugundi@gmail.com>
Subject: Re: osd crash with object store set to newstore
Date: Mon, 1 Jun 2015 22:25:40 -0700
Message-ID: <CACAg-u81zF+QJm6-pMDMHSqjFw8DrkdpOAgc9nB6YUQdtt8EFw@mail.gmail.com>
References: <CACAg-u_4mdrj=eCwwYzMzk-RDjCkAWYT6KwaAvUSNJK52gcO6g@mail.gmail.com>
	<alpine.DEB.2.00.1506012053340.9814@cobra.newdream.net>
	<CACAg-u8jU0Jf56ZCf38DpDaW1bvW=ff-goOiFriqqDo8uA31vA@mail.gmail.com>
	<alpine.DEB.2.00.1506012206110.9814@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33132 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbFBFZl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 01:25:41 -0400
Received: by qgfa63 with SMTP id a63so55357442qgf.0
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2015 22:25:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1506012206110.9814@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Unfortunately I purged the cluster yesterday and restarted the
backfill tool. I did not see the osd crash yet on the cluster. I am
monitoring the OSDs and will update you once I see the crash.

With the new backfill run I have reduced the rps by half, not sure if
this is the reason for not seeing the crash yet.

Regards
Srikanth


On Mon, Jun 1, 2015 at 10:06 PM, Sage Weil <sage@newdream.net> wrote:
> I pushed a commit to wip-newstore-debuglist.. can you reproduce the crash
> with that branch with 'debug newstore = 20' and send us the log?
> (You can just do 'ceph-post-file <filename>'.)
>
> Thanks!
> sage
>
> On Mon, 1 Jun 2015, Srikanth Madugundi wrote:
>
>> Hi Sage,
>>
>> The assertion failed at line 1639, here is the log message
>>
>>
>> 2015-05-30 23:17:55.141388 7f0891be0700 -1 os/newstore/NewStore.cc: In
>> function 'virtual int NewStore::collection_list_partial(coll_t,
>> ghobject_t, int, int, snapid_t, std::vector<ghobject_t>*,
>> ghobject_t*)' thread 7f0891be0700 time 2015-05-30 23:17:55.137174
>>
>> os/newstore/NewStore.cc: 1639: FAILED assert(k >= start_key && k < end_key)
>>
>>
>> Just before the crash the here are the debug statements printed by the
>> method (collection_list_partial)
>>
>> 2015-05-30 22:49:23.607232 7f1681934700 15
>> newstore(/var/lib/ceph/osd/ceph-7) collection_list_partial 75.0_head
>> start -1/0//0/0 min/max 1024/1024 snap head
>> 2015-05-30 22:49:23.607251 7f1681934700 20
>> newstore(/var/lib/ceph/osd/ceph-7) collection_list_partial range
>> --.7fffffffffffffb4.00000000. to --.7fffffffffffffb4.08000000. and
>> --.800000000000004b.00000000. to --.800000000000004b.08000000. start
>> -1/0//0/0
>>
>>
>> Regards
>> Srikanth
>>
>> On Mon, Jun 1, 2015 at 8:54 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Mon, 1 Jun 2015, Srikanth Madugundi wrote:
>> >> Hi Sage and all,
>> >>
>> >> I build ceph code from wip-newstore on RHEL7 and running performance
>> >> tests to compare with filestore. After few hours of running the tests
>> >> the osd daemons started to crash. Here is the stack trace, the osd
>> >> crashes immediately after the restart. So I could not get the osd up
>> >> and running.
>> >>
>> >> ceph version b8e22893f44979613738dfcdd40dada2b513118
>> >> (eb8e22893f44979613738dfcdd40dada2b513118)
>> >> 1: /usr/bin/ceph-osd() [0xb84652]
>> >> 2: (()+0xf130) [0x7f915f84f130]
>> >> 3: (gsignal()+0x39) [0x7f915e2695c9]
>> >> 4: (abort()+0x148) [0x7f915e26acd8]
>> >> 5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f915eb6d9d5]
>> >> 6: (()+0x5e946) [0x7f915eb6b946]
>> >> 7: (()+0x5e973) [0x7f915eb6b973]
>> >> 8: (()+0x5eb9f) [0x7f915eb6bb9f]
>> >> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> >> const*)+0x27a) [0xc84c5a]
>> >> 10: (NewStore::collection_list_partial(coll_t, ghobject_t, int, int,
>> >> snapid_t, std::vector<ghobject_t, std::allocator<ghobject_t> >*,
>> >> ghobject_t*)+0x13c9) [0xa08639]
>> >> 11: (PGBackend::objects_list_partial(hobject_t const&, int, int,
>> >> snapid_t, std::vector<hobject_t, std::allocator<hobject_t> >*,
>> >> hobject_t*)+0x352) [0x918a02]
>> >> 12: (ReplicatedPG::do_pg_op(std::tr1::shared_ptr<OpRequest>)+0x1066) [0x8aa906]
>> >> 13: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>&)+0x1eb) [0x8cd06b]
>> >> 14: (ReplicatedPG::do_request(std::tr1::shared_ptr<OpRequest>&,
>> >> ThreadPool::TPHandle&)+0x68a) [0x85dbea]
>> >> 15: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
>> >> std::tr1::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x3ed)
>> >> [0x6c3f5d]
>> >> 16: (OSD::ShardedOpWQ::_process(unsigned int,
>> >> ceph::heartbeat_handle_d*)+0x2e9) [0x6c4449]
>> >> 17: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x86f) [0xc746bf]
>> >> 18: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xc767f0]
>> >> 19: (()+0x7df3) [0x7f915f847df3]
>> >> 20: (clone()+0x6d) [0x7f915e32a01d]
>> >> NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> >> needed to interpret this.
>> >>
>> >> Please let me know the cause of this crash, when this crash happens I
>> >> noticed that two osds on separate machines are down. I can bring one
>> >> osd up but restarting the other osd causes both OSDs to crash. My
>> >> understanding is the crash seems to happen when two OSDs try to
>> >> communicate and replicate a particular PG.
>> >
>> > Can you include the log lines that preceed the dump above?  In particular,
>> > there should be a line that tells you what assertion failed in what
>> > function and at what line number.  I haven't seen this crash so I'm not
>> > sure offhand what it is.
>> >
>> > Thanks!
>> > sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
