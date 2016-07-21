From: David Zafman <dzafman@redhat.com>
Subject: Re: Ceph 10.2.2 OSD Crash
Date: Wed, 20 Jul 2016 17:05:25 -0700
Message-ID: <950a113d-2946-53f3-f7be-22a4caa5c077@redhat.com>
References: <ab9f0a2e-9caf-21d4-88c7-207ab2f54e90@wigen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbcGUAF0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Jul 2016 20:05:26 -0400
In-Reply-To: <ab9f0a2e-9caf-21d4-88c7-207ab2f54e90@wigen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexander Wigen <alex@wigen.net>, ceph-devel@vger.kernel.org


There is already a tracker http://tracker.ceph.com/issues/13937 and a 
pull request that hasn't merged yet https://github.com/ceph/ceph/pull/9304

As a work around you could use the osd logs to find the bad shard and 
remove it with the ceph-objectstore-tool.

David

On 7/20/16 3:06 PM, Alexander Wigen wrote:

> Hi there,
>
> I had a OSD crash today under heavy rebuild load. Here's the output:
>
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: osd/ECBackend.cc: In 
> function 'virtual void 
> OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)' t
> hread 7f0cc2ef4700 time 2016-07-20 22:42:03.738188
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: osd/ECBackend.cc: 
> 203: FAILED assert(res.errors.empty())
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: ceph version 10.2.2 
> (45107e21c568dd033c2f0a3107dec8f0b0e58374)
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 1: 
> (ceph::__ceph_assert_fail(char const*, char const*, int, char 
> const*)+0x85) [0x7f0ce761c5b5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2: 
> (OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x192) [0x7f0ce71bb982]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 3: 
> (GenContext<std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&>::complete(std::pair<RecoveryMessages*, 
> ECBackend::read_result_
> t&>&)+0x9) [0x7f0ce71a8f49]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 4: 
> (ECBackend::complete_read_op(ECBackend::ReadOp&, 
> RecoveryMessages*)+0x73) [0x7f0ce719f043]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 5: 
> (ECBackend::handle_sub_read_reply(pg_shard_t, ECSubReadReply&, 
> RecoveryMessages*)+0xfe9) [0x7f0ce71a00b9]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 6: 
> (ECBackend::handle_message(std::shared_ptr<OpRequest>)+0x1a3) 
> [0x7f0ce71a7513]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 7: 
> (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, 
> ThreadPool::TPHandle&)+0x100) [0x7f0ce70dc810]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 8: 
> (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, 
> ThreadPool::TPHandle&)+0x41d) [0x7f0ce6f91a8d]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 9: 
> (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>&)+0x6d) 
> [0x7f0ce6f91cdd]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 10: 
> (OSD::ShardedOpWQ::_process(unsigned int, 
> ceph::heartbeat_handle_d*)+0x869) [0x7f0ce6f96809]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 11: 
> (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) 
> [0x7f0ce760c557]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 12: 
> (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f0ce760e4c0]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 13: (()+0x7dc5) 
> [0x7f0ce554adc5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 14: (clone()+0x6d) 
> [0x7f0ce3bd5ced]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: NOTE: a copy of the 
> executable, or `objdump -rdS <executable>` is needed to interpret this.
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2016-07-20 
> 22:42:03.746704 7f0cc2ef4700 -1 osd/ECBackend.cc: In function 'virtual 
> void OnRecoveryReadComplete::finish(std::pair<Recover
> yMessages*, ECBackend::read_result_t&>&)' thread 7f0cc2ef4700 time 
> 2016-07-20 22:42:03.738188
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: osd/ECBackend.cc: 
> 203: FAILED assert(res.errors.empty())
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: ceph version 10.2.2 
> (45107e21c568dd033c2f0a3107dec8f0b0e58374)
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 1: 
> (ceph::__ceph_assert_fail(char const*, char const*, int, char 
> const*)+0x85) [0x7f0ce761c5b5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2: 
> (OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x192) [0x7f0ce71bb982]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 3: 
> (GenContext<std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&>::complete(std::pair<RecoveryMessages*, 
> ECBackend::read_result_
> t&>&)+0x9) [0x7f0ce71a8f49]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 4: 
> (ECBackend::complete_read_op(ECBackend::ReadOp&, 
> RecoveryMessages*)+0x73) [0x7f0ce719f043]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 5: 
> (ECBackend::handle_sub_read_reply(pg_shard_t, ECSubReadReply&, 
> RecoveryMessages*)+0xfe9) [0x7f0ce71a00b9]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 6: 
> (ECBackend::handle_message(std::shared_ptr<OpRequest>)+0x1a3) 
> [0x7f0ce71a7513]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 7: 
> (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, 
> ThreadPool::TPHandle&)+0x100) [0x7f0ce70dc810]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 8: 
> (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, 
> ThreadPool::TPHandle&)+0x41d) [0x7f0ce6f91a8d]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 9: 
> (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>&)+0x6d) 
> [0x7f0ce6f91cdd]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 10: 
> (OSD::ShardedOpWQ::_process(unsigned int, 
> ceph::heartbeat_handle_d*)+0x869) [0x7f0ce6f96809]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 11: 
> (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) 
> [0x7f0ce760c557]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 12: 
> (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f0ce760e4c0]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 13: (()+0x7dc5) 
> [0x7f0ce554adc5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 14: (clone()+0x6d) 
> [0x7f0ce3bd5ced]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: NOTE: a copy of the 
> executable, or `objdump -rdS <executable>` is needed to interpret this.
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 0> 2016-07-20 
> 22:42:03.746704 7f0cc2ef4700 -1 osd/ECBackend.cc: In function 'virtual 
> void OnRecoveryReadComplete::finish(std::pair<Reco
> veryMessages*, ECBackend::read_result_t&>&)' thread 7f0cc2ef4700 time 
> 2016-07-20 22:42:03.738188
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: osd/ECBackend.cc: 
> 203: FAILED assert(res.errors.empty())
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: ceph version 10.2.2 
> (45107e21c568dd033c2f0a3107dec8f0b0e58374)
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 1: 
> (ceph::__ceph_assert_fail(char const*, char const*, int, char 
> const*)+0x85) [0x7f0ce761c5b5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2: 
> (OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x192) [0x7f0ce71bb982]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 3: 
> (GenContext<std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&>::complete(std::pair<RecoveryMessages*, 
> ECBackend::read_result_
> t&>&)+0x9) [0x7f0ce71a8f49]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 4: 
> (ECBackend::complete_read_op(ECBackend::ReadOp&, 
> RecoveryMessages*)+0x73) [0x7f0ce719f043]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 5: 
> (ECBackend::handle_sub_read_reply(pg_shard_t, ECSubReadReply&, 
> RecoveryMessages*)+0xfe9) [0x7f0ce71a00b9]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 6: 
> (ECBackend::handle_message(std::shared_ptr<OpRequest>)+0x1a3) 
> [0x7f0ce71a7513]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 7: 
> (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, 
> ThreadPool::TPHandle&)+0x100) [0x7f0ce70dc810]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 8: 
> (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, 
> ThreadPool::TPHandle&)+0x41d) [0x7f0ce6f91a8d]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 9: 
> (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>&)+0x6d) 
> [0x7f0ce6f91cdd]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 10: 
> (OSD::ShardedOpWQ::_process(unsigned int, 
> ceph::heartbeat_handle_d*)+0x869) [0x7f0ce6f96809]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 11: 
> (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) 
> [0x7f0ce760c557]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 12: 
> (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f0ce760e4c0]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 13: (()+0x7dc5) 
> [0x7f0ce554adc5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 14: (clone()+0x6d) 
> [0x7f0ce3bd5ced]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: NOTE: a copy of the 
> executable, or `objdump -rdS <executable>` is needed to interpret this.
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: *** Caught signal 
> (Aborted) **
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: in thread 
> 7f0cc2ef4700 thread_name:tp_osd_tp
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: ceph version 10.2.2 
> (45107e21c568dd033c2f0a3107dec8f0b0e58374)
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 1: (()+0x91341a) 
> [0x7f0ce751c41a]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2: (()+0xf100) 
> [0x7f0ce5552100]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 3: (gsignal()+0x37) 
> [0x7f0ce3b145f7]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 4: (abort()+0x148) 
> [0x7f0ce3b15ce8]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 5: 
> (ceph::__ceph_assert_fail(char const*, char const*, int, char 
> const*)+0x267) [0x7f0ce761c797]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 6: 
> (OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x192) [0x7f0ce71bb982]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 7: 
> (GenContext<std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&>::complete(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x9) [0x7f0ce71a8f49]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 8: 
> (ECBackend::complete_read_op(ECBackend::ReadOp&, 
> RecoveryMessages*)+0x73) [0x7f0ce719f043]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 9: 
> (ECBackend::handle_sub_read_reply(pg_shard_t, ECSubReadReply&, 
> RecoveryMessages*)+0xfe9) [0x7f0ce71a00b9]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 10: 
> (ECBackend::handle_message(std::shared_ptr<OpRequest>)+0x1a3) 
> [0x7f0ce71a7513]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 11: 
> (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, 
> ThreadPool::TPHandle&)+0x100) [0x7f0ce70dc810]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 12: 
> (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, 
> ThreadPool::TPHandle&)+0x41d) [0x7f0ce6f91a8d]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 13: 
> (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>&)+0x6d) 
> [0x7f0ce6f91cdd]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 14: 
> (OSD::ShardedOpWQ::_process(unsigned int, 
> ceph::heartbeat_handle_d*)+0x869) [0x7f0ce6f96809]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 15: 
> (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) 
> [0x7f0ce760c557]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 16: 
> (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f0ce760e4c0]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 17: (()+0x7dc5) 
> [0x7f0ce554adc5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 18: (clone()+0x6d) 
> [0x7f0ce3bd5ced]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2016-07-20 
> 22:42:03.775158 7f0cc2ef4700 -1 *** Caught signal (Aborted) **
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: in thread 
> 7f0cc2ef4700 thread_name:tp_osd_tp
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: ceph version 10.2.2 
> (45107e21c568dd033c2f0a3107dec8f0b0e58374)
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 1: (()+0x91341a) 
> [0x7f0ce751c41a]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2: (()+0xf100) 
> [0x7f0ce5552100]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 3: (gsignal()+0x37) 
> [0x7f0ce3b145f7]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 4: (abort()+0x148) 
> [0x7f0ce3b15ce8]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 5: 
> (ceph::__ceph_assert_fail(char const*, char const*, int, char 
> const*)+0x267) [0x7f0ce761c797]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 6: 
> (OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x192) [0x7f0ce71bb982]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 7: 
> (GenContext<std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&>::complete(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x9) [0x7f0ce71a8f49]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 8: 
> (ECBackend::complete_read_op(ECBackend::ReadOp&, 
> RecoveryMessages*)+0x73) [0x7f0ce719f043]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 9: 
> (ECBackend::handle_sub_read_reply(pg_shard_t, ECSubReadReply&, 
> RecoveryMessages*)+0xfe9) [0x7f0ce71a00b9]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 10: 
> (ECBackend::handle_message(std::shared_ptr<OpRequest>)+0x1a3) 
> [0x7f0ce71a7513]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 11: 
> (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, 
> ThreadPool::TPHandle&)+0x100) [0x7f0ce70dc810]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 12: 
> (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, 
> ThreadPool::TPHandle&)+0x41d) [0x7f0ce6f91a8d]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 13: 
> (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>&)+0x6d) 
> [0x7f0ce6f91cdd]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 14: 
> (OSD::ShardedOpWQ::_process(unsigned int, 
> ceph::heartbeat_handle_d*)+0x869) [0x7f0ce6f96809]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 15: 
> (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) 
> [0x7f0ce760c557]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 16: 
> (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f0ce760e4c0]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 17: (()+0x7dc5) 
> [0x7f0ce554adc5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 18: (clone()+0x6d) 
> [0x7f0ce3bd5ced]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: NOTE: a copy of the 
> executable, or `objdump -rdS <executable>` is needed to interpret this.
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 0> 2016-07-20 
> 22:42:03.775158 7f0cc2ef4700 -1 *** Caught signal (Aborted) **
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: in thread 
> 7f0cc2ef4700 thread_name:tp_osd_tp
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: ceph version 10.2.2 
> (45107e21c568dd033c2f0a3107dec8f0b0e58374)
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 1: (()+0x91341a) 
> [0x7f0ce751c41a]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 2: (()+0xf100) 
> [0x7f0ce5552100]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 3: (gsignal()+0x37) 
> [0x7f0ce3b145f7]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 4: (abort()+0x148) 
> [0x7f0ce3b15ce8]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 5: 
> (ceph::__ceph_assert_fail(char const*, char const*, int, char 
> const*)+0x267) [0x7f0ce761c797]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 6: 
> (OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x192) [0x7f0ce71bb982]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 7: 
> (GenContext<std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&>::complete(std::pair<RecoveryMessages*, 
> ECBackend::read_result_t&>&)+0x9) [0x7f0ce71a8f49]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 8: 
> (ECBackend::complete_read_op(ECBackend::ReadOp&, 
> RecoveryMessages*)+0x73) [0x7f0ce719f043]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 9: 
> (ECBackend::handle_sub_read_reply(pg_shard_t, ECSubReadReply&, 
> RecoveryMessages*)+0xfe9) [0x7f0ce71a00b9]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 10: 
> (ECBackend::handle_message(std::shared_ptr<OpRequest>)+0x1a3) 
> [0x7f0ce71a7513]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 11: 
> (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, 
> ThreadPool::TPHandle&)+0x100) [0x7f0ce70dc810]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 12: 
> (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpRequest>, 
> ThreadPool::TPHandle&)+0x41d) [0x7f0ce6f91a8d]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 13: 
> (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>&)+0x6d) 
> [0x7f0ce6f91cdd]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 14: 
> (OSD::ShardedOpWQ::_process(unsigned int, 
> ceph::heartbeat_handle_d*)+0x869) [0x7f0ce6f96809]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 15: 
> (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x887) 
> [0x7f0ce760c557]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 16: 
> (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f0ce760e4c0]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 17: (()+0x7dc5) 
> [0x7f0ce554adc5]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: 18: (clone()+0x6d) 
> [0x7f0ce3bd5ced]
> Jul 20 22:42:03 node4.wigen.svg ceph-osd[24096]: NOTE: a copy of the 
> executable, or `objdump -rdS <executable>` is needed to interpret this.
> Jul 20 22:42:03 node4.wigen.svg systemd[1]: ceph-osd@12.service: main 
> process exited, code=killed, status=6/ABRT
> Jul 20 22:42:03 node4.wigen.svg systemd[1]: Unit ceph-osd@12.service 
> entered failed state.
> Jul 20 22:42:03 node4.wigen.svg systemd[1]: ceph-osd@12.service failed.
> Jul 20 22:42:04 node4.wigen.svg systemd[1]: ceph-osd@12.service 
> holdoff time over, scheduling restart.
>
> I've generated an object dump if anyone is interested let me know.
>
>
> Cheers,
> Alex
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

