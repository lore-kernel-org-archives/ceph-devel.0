From: David Zafman <dzafman@redhat.com>
Subject: RESEND: Re: osd/ReplicatedPG.cc: 3101: FAILED assert(0)
Date: Wed, 10 Aug 2016 14:27:12 -0700
Message-ID: <200b328f-fd8a-3fef-beee-057cd3ee90c2@redhat.com>
References: <CALXUmNQDLuK+rO2bxz+gj8ZOGS4V2kJtiGJoZosXPDZfqwqZSA@mail.gmail.com>
 <CAOi1vP9dRCcuhFr0BanJ_noKqV0n+2JvmX-4TFhhC0ur2neYYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45316 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbcHJV1O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Aug 2016 17:27:14 -0400
In-Reply-To: <CAOi1vP9dRCcuhFr0BanJ_noKqV0n+2JvmX-4TFhhC0ur2neYYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Victor Payno <vpayno@gaikai.com>, Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Rae Yip <ryip@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>


There might be a messages earlier in the log like this with the name of 
the problem object.

trim_object(...could not find coid name-of-object

This has been seen when ceph-objectstore-tool has been used to remove a 
head object without removing the snapshots.  The newest 
ceph-objectstore-tool doesn't allow it by default with a warning unless 
you specify --force.

There might be more information if you change debug_osd and 
debug_filestore to 20 and start up that OSD.

David


On 8/9/16 1:18 AM, Ilya Dryomov wrote:
> On Tue, Aug 9, 2016 at 5:35 AM, Victor Payno<vpayno@gaikai.com>  wrote:
>> We got this error while we had mapped rbds, and creating and deleting
>> snapshots on unmapped rbds. We have more logs, just wasn't sure how
>> far back you need to go.
>>
>>
>>      -3> 2016-08-07 20:34:23.034180 7ff7a3d53700  1 --
>> 172.20.3.100:0/25852 <== osd.45 172.20.3.101:6801/61384 235931 ====
>> osd_ping(ping_reply e47657 stamp 2016-08-07 20:34:23.013702) v2 ====
>> 47+0+0 (1835738769 0 0) 0x55e757031e00 con 0x55e7597bef20
>>      -2> 2016-08-07 20:34:23.034188 7ff7a3d53700  1 --
>> 172.20.3.100:0/25852 <== osd.48 172.20.3.101:6807/61495 235931 ====
>> osd_ping(ping_reply e47657 stamp 2016-08-07 20:34:23.013702) v2 ====
>> 47+0+0 (1835738769 0 0) 0x55e757161800 con 0x55e7595f26e0
>>      -1> 2016-08-07 20:34:23.034207 7ff7a154e700  1 --
>> 172.20.3.100:6807/25852 --> 192.168.225.100:0/59480 --
>> osd_ping(ping_reply e47657 stamp 2016-08-07 20:34:23.060394) v2 -- ?+0
>> 0x55e7bdd78400 con 0x55e75660b340
>>       0> 2016-08-07 20:34:23.034428 7ff79953e700 -1
>> osd/ReplicatedPG.cc: In function 'ReplicatedPG::RepGather*
>> ReplicatedPG::trim_object(const hobject_t&)' thread 7ff79953e700 time
>> 2016-08-07 20:34:23.024037
>> osd/ReplicatedPG.cc: 3101: FAILED assert(0)
>>
>>   ceph version 9.2.0 (bb2ecea240f3a1d525bcb35670cb07bd1f0ca299)
>>   1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x8b) [0x55e751fba09b]
>>   2: (ReplicatedPG::trim_object(hobject_t const&)+0x2fb) [0x55e751cd10db]
>>   3: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>> const&)+0x424) [0x55e751d04694]
>>   4: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na,
>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>> mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
>> (boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
>> const&, void const*)+0xb4) [0x55e751d2e1c4]
>>   5: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>> ReplicatedPG::NotTrimming, std::allocator<void>,
>> boost::statechart::null_exception_translator>::process_queued_events()+0x12b)
>> [0x55e751d1c31b]
>>   6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>> ReplicatedPG::NotTrimming, std::allocator<void>,
>> boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
>> const&)+0x84) [0x55e751d1c4e4]
>>   7: (ReplicatedPG::snap_trimmer(unsigned int)+0x4bc) [0x55e751ca87dc]
>>   8: (OSD::ShardedOpWQ::_process(unsigned int,
>> ceph::heartbeat_handle_d*)+0x691) [0x55e751b350b1]
>>   9: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x872)
>> [0x55e751faab42]
>>   10: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x55e751faca20]
>>   11: (()+0x84b4) [0x7ff7b7cd24b4]
>>   12: (clone()+0x6d) [0x7ff7b60274cd]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
> Looks like an OSD bug - adding Sam.
>
> Thanks,
>
>                  Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message tomajordomo@vger.kernel.org
> More majordomo info athttp://vger.kernel.org/majordomo-info.html


