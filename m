From: Samuel Just <sam.just@inktank.com>
Subject: Re: [PATCH]ECBackend: Don't directyly use get_recovery_chunk_size()
 in RecoveryOp::WRITING state.
Date: Thu, 31 Jul 2014 14:48:52 -0700
Message-ID: <CA+4uBUYPzT0QLCuP-BfT2HRCsentqEfpkUT_XzH47Af3kxj0Jg@mail.gmail.com>
References: <6AA21C22F0A5DA478922644AD2EC308C897EBF@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:60530 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaGaVsx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 17:48:53 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so3104940qaq.10
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 14:48:52 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C897EBF@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "sage@redhat.com" <sage@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A pull request for this one as well.
-Sam

On Tue, Jul 29, 2014 at 11:09 PM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> We cannot guarantee that conf->osd_recovery_max_chunk don't change when
> recoverying a erasure object.
> If change between RecoveryOp::READING and RecoveryOp::WRITING, it can cause this bug:
>
> 2014-07-30 10:12:09.599220 7f7ff26c0700 -1 osd/ECBackend.cc: In function
> 'void ECBackend::continue_recovery_op(ECBackend::RecoveryOp&,
> RecoveryMessages*)' thread 7f7ff26c0700 time 2014-07-30 10:12:09.596837
> osd/ECBackend.cc: 529: FAILED assert(pop.data.length() ==
> sinfo.aligned_logical_offset_to_chunk_offset(
> after_progress.data_recovered_to -
> op.recovery_progress.data_recovered_to))
>
>  ceph version 0.83-383-g3cfda57
> (3cfda577b15039cb5c678b79bef3e561df826ed1)
>  1: (ECBackend::continue_recovery_op(ECBackend::RecoveryOp&,RecoveryMessages*)+0x1a50) [0x928070]
>  2: (ECBackend::handle_recovery_read_complete(hobject_t const&,
> boost::tuples::tuple<unsigned long, unsigned long, std::map<pg_shard_t,
> ceph::buffer::list, std::less<pg_shard_t>,
> std::allocator<std::pair<pg_shard_t const, ceph::buffer::list> > >,
> boost::tuples::null_type, boost::tuples::null_type,
> boost::tuples::null_type, boost::tuples::null_type,
> boost::tuples::null_type, boost::tuples::null_type,
> boost::tuples::null_type>&, boost::optional<std::map<std::string,
> ceph::buffer::list, std::less<std::string>,
> std::allocator<std::pair<std::string const, ceph::buffer::list> > > >,
> RecoveryMessages*)+0x90c) [0x92952c]
>  3: (OnRecoveryReadComplete::finish(std::pair<RecoveryMessages*,
> ECBackend::read_result_t&>&)+0x121) [0x938481]
>  4: (GenContext<std::pair<RecoveryMessages*,
> ECBackend::read_result_t&>&>::complete(std::pair<RecoveryMessages*,
> ECBackend::read_result_t&>&)+0x9) [0x929d69]
>  5: (ECBackend::complete_read_op(ECBackend::ReadOp&,RecoveryMessages*)+0x63) [0x91c6e3]
>  6: (ECBackend::handle_sub_read_reply(pg_shard_t, ECSubReadReply&,RecoveryMessages*)+0x96d) [0x920b4d]
>  7: (ECBackend::handle_message(std::tr1::shared_ptr<OpRequest>)+0x17e)[0x92884e]
>  8: (ReplicatedPG::do_request(std::tr1::shared_ptr<OpRequest>&,ThreadPool::TPHandle&)+0x23b) [0x7b34db]
>  9: (OSD::dequeue_op(boost::intrusive_ptr<PG>,std::tr1::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x428)
> [0x638d58]
>  10: (OSD::ShardedOpWQ::_process(unsigned int,ceph::heartbeat_handle_d*)+0x346) [0x6392f6]
>  11: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x8ce)[0xa5caae]
>  12: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xa5ed00]
>  13: (()+0x8182) [0x7f800b5d3182]
>  14: (clone()+0x6d) [0x7f800997430d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> So we only get the get_recovery_chunk_size() at RecoverOp::READING and
> record it using RecoveryOp::extent_requested.
>
> Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
> ---
>  src/osd/ECBackend.cc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/src/osd/ECBackend.cc b/src/osd/ECBackend.cc
> index 2a3913a..e9402e8 100644
> --- a/src/osd/ECBackend.cc
> +++ b/src/osd/ECBackend.cc
> @@ -476,6 +476,7 @@ void ECBackend::continue_recovery_op(
>        assert(!op.recovery_progress.data_complete);
>        set<int> want(op.missing_on_shards.begin(), op.missing_on_shards.end());
>        set<pg_shard_t> to_read;
> +      uint64_t recovery_max_chunk = get_recovery_chunk_size();
>        int r = get_min_avail_to_read_shards(
>         op.hoid, want, true, &to_read);
>        if (r != 0) {
> @@ -492,11 +493,11 @@ void ECBackend::continue_recovery_op(
>         this,
>         op.hoid,
>         op.recovery_progress.data_recovered_to,
> -       get_recovery_chunk_size(),
> +       recovery_max_chunk,
>         to_read,
>         op.recovery_progress.first);
>        op.extent_requested = make_pair(op.recovery_progress.data_recovered_to,
> -                                     get_recovery_chunk_size());
> +                                     recovery_max_chunk);
>        dout(10) << __func__ << ": IDLE return " << op << dendl;
>        return;
>      }
> @@ -506,7 +507,7 @@ void ECBackend::continue_recovery_op(
>        assert(op.returned_data.size());
>        op.state = RecoveryOp::WRITING;
>        ObjectRecoveryProgress after_progress = op.recovery_progress;
> -      after_progress.data_recovered_to += get_recovery_chunk_size();
> +      after_progress.data_recovered_to += op.extent_requested.second;
>        after_progress.first = false;
>        if (after_progress.data_recovered_to >= op.obc->obs.oi.size) {
>         after_progress.data_recovered_to =
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
