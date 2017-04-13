From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Measuring lock conention
Date: Thu, 13 Apr 2017 12:20:18 -0500
Message-ID: <61444443-9337-c5ce-76ba-7e8a7a765232@redhat.com>
References: <90991cbf-c59e-d080-783e-e712540a99b1@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------470B0810B708A68700828AE5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754049AbdDMRUU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Apr 2017 13:20:20 -0400
In-Reply-To: <90991cbf-c59e-d080-783e-e712540a99b1@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------470B0810B708A68700828AE5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Nice!  I will give it a try and see how it goes.  Specifically I want to 
compare it to what I ended up working on yesterday.  After the meeting I 
ended up doing major surgery on an existing gdb based wallclock profiler 
and modified it to a) work b) be thread aware c) print inverse 
call-graphs.  The code is still pretty rough but you can see it here:

https://github.com/markhpc/gdbprof

I've included an example inverse-callgraph from a run I did this morning.

Right now it can be invoked like:

gdb -ex 'set pagination off' -ex 'attach <pid>' -ex 'source 
./gdbprof.py' -ex 'profile begin' -ex 'quit'

I'm going to try and clean it up and give it more command line options 
for choosing the call-graph direction, sample count, etc.

Mark

On 04/13/2017 10:43 AM, Mohamad Gebai wrote:
> Hi all,
>
> Yesterday during the performance call there was some talk around
> measuring lock contention in wallclock, and it was mentioned that an
> option would be to monitor the futex system call. I just uploaded to
> Github a script I've used in the past that does exactly that, in case
> there was interest in pursuing this approach
> (https://github.com/mogeb/bt-futex). The Python script expects a CTF
> trace (e.g. LTTng). The functionality is very minimal at this point, but
> if there is interest I'd be happy to enhance it further. The main
> drawback of this approach is that it only works for locks that use futex
> (spinlocks, for instance, wouldn't be monitored). No instrumentation to
> the application is required.
>
> Here's an example output of the amount of time spent in the futex
> syscall, per thread (system-wide). The LOCK_TIME column shows the amount
> of time waiting on a lock, in nanoseconds:
>
> $> python3 count_futex.py kernel/
> PROCESS_NAME (TID): LOCK_TIME ns
> git (17550):  2,122
> git (17551):  8,124
> example (17554):  80,690,708
> example (17555):  80,020,536
> example (17556):  367,010,253
> example (17557):  459,009,153
> example (17558):  199,676,209
> example (17559):  108,401
> example (17560):  475,562,084
> example (17561):  80,549,102
> example (17562):  468,002,252
> example (17564):  92,108,616
> example (17566):  450,655,745
> example (17567):  49,904,388
> libvirtd (3772):  2,389
> libvirtd (3773):  2,839
> libvirtd (3775):  2,417
> libvirtd (3776):  3,577
> libvirtd (3777):  2,492
>
> Mohamad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------470B0810B708A68700828AE5
Content-Type: chemical/x-gulp;
 name="4kwrite_gdb_profiler.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="4kwrite_gdb_profiler.out"

Thread: 1

+ 100.00% main
  + 100.00% AsyncMessenger::wait
    + 100.00% Wait
      + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 2

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% std::(anonymous namespace)::execute_native_thread_routine
      + 100.00% rocksdb::ThreadPoolImpl::Impl::BGThreadWrapper
        + 100.00% rocksdb::ThreadPoolImpl::Impl::BGThread
          + 99.55% std::condition_variable::wait
          | + 99.55% __gthread_cond_wait
          |   + 99.55% pthread_cond_wait@@GLIBC_2.3.2
          + 0.45% rocksdb::DBImpl::BackgroundCallFlush
            + 0.45% rocksdb::DBImpl::BackgroundFlush
              + 0.45% rocksdb::DBImpl::FlushMemTableToOutputFile
                + 0.45% rocksdb::FlushJob::Run
                  + 0.45% rocksdb::FlushJob::WriteLevel0Table
                    + 0.45% rocksdb::BuildTable
                      + 0.25% rocksdb::CompactionIterator::Next
                      | + 0.25% rocksdb::CompactionIterator::NextFromInput
                      |   + 0.25% rocksdb::MemTableIterator::key
                      |     + 0.25% GetLengthPrefixedSlice
                      |       + 0.25% GetVarint32Ptr
                      + 0.10% rocksdb::WritableFileWriter::Sync
                      | + 0.10% rocksdb::WritableFileWriter::SyncInternal
                      |   + 0.10% BlueRocksWritableFile::Sync
                      |     + 0.10% fsync
                      |       + 0.10% BlueFS::_fsync
                      |         + 0.05% clear
                      |         + 0.05% BlueFS::wait_for_aio
                      + 0.10% rocksdb::BlockBasedTableBuilder::Add
                        + 0.05% rocksdb::BlockBuilder::Add
                        + 0.05% rocksdb::BlockBasedTableBuilder::Flush

Thread: 3

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SignalHandler::entry
      + 100.00% poll
        + 100.00% poll

Thread: 4

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% OSDService::AgentThread::entry
      + 100.00% OSDService::agent_entry
        + 100.00% Cond::Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 5

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 6

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 7

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 100.00% WaitUntil
          + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 8

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% Finisher::finisher_thread_entry
      + 100.00% Wait
        + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 9

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% Finisher::finisher_thread_entry
      + 100.00% Wait
        + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 10

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% OSD::T_Heartbeat::entry
      + 100.00% OSD::heartbeat_entry
        + 100.00% WaitInterval
          + 100.00% WaitUntil
            + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 11

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ThreadPool::WorkThread::entry
      + 100.00% ThreadPool::worker
        + 100.00% WaitInterval
          + 100.00% WaitUntil
            + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 12

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ThreadPool::WorkThread::entry
      + 100.00% ThreadPool::worker
        + 100.00% WaitInterval
          + 100.00% WaitUntil
            + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 13

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 100.00% WaitInterval
            + 100.00% WaitUntil
              + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 14

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.95% WaitInterval
          | + 99.95% WaitUntil
          |   + 99.95% pthread_cond_timedwait@@GLIBC_2.3.2
          |     + 0.05% __pthread_mutex_cond_lock
          + 0.05% run

Thread: 15

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.90% WaitInterval
          | + 99.90% WaitUntil
          |   + 99.90% pthread_cond_timedwait@@GLIBC_2.3.2
          |     + 0.15% __pthread_mutex_cond_lock
          |       + 0.15% _L_cond_lock_792
          |         + 0.15% __lll_lock_wait
          + 0.10% run
            + 0.10% apply_visitor<PGQueueable::RunVis, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> >
              + 0.10% apply_visitor<PGQueueable::RunVis>
                + 0.10% internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> >
                  + 0.10% internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*>
                    + 0.10% visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, boost::intrusive_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                      + 0.10% visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest>, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                        + 0.10% visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest> >
                          + 0.10% internal_visit<boost::intrusive_ptr<OpRequest> >
                            + 0.10% PGQueueable::RunVis::operator()
                              + 0.10% OSD::dequeue_op
                                + 0.10% PrimaryLogPG::do_request
                                  + 0.10% PrimaryLogPG::do_op
                                    + 0.10% PrimaryLogPG::execute_ctx
                                      + 0.10% PrimaryLogPG::issue_repop
                                        + 0.10% ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, boost::intrusive_ptr<OpRequest>)
                                          + 0.10% PrimaryLogPG::queue_transactions
                                            + 0.10% queue_transactions
                                              + 0.10% BlueStore::queue_transactions
                                                + 0.05% RocksDBStore::RocksDBTransactionImpl::set
                                                + 0.05% BlueStore::_txc_add_transaction

Thread: 16

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.95% WaitInterval
          | + 99.95% WaitUntil
          |   + 99.95% pthread_cond_timedwait@@GLIBC_2.3.2
          |     + 0.05% __pthread_mutex_cond_lock
          + 0.05% run

Thread: 17

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.90% WaitInterval
          | + 99.90% WaitUntil
          |   + 99.90% pthread_cond_timedwait@@GLIBC_2.3.2
          |     + 0.10% __pthread_mutex_cond_lock
          |       + 0.10% _L_cond_lock_792
          |         + 0.10% __lll_lock_wait
          + 0.10% run
            + 0.10% apply_visitor<PGQueueable::RunVis, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> >
              + 0.10% apply_visitor<PGQueueable::RunVis>
                + 0.10% internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> >
                  + 0.10% internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*>
                    + 0.10% visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, boost::intrusive_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                      + 0.10% visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest>, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                        + 0.10% visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest> >
                          + 0.10% internal_visit<boost::intrusive_ptr<OpRequest> >
                            + 0.10% PGQueueable::RunVis::operator()
                              + 0.10% OSD::dequeue_op
                                + 0.10% PrimaryLogPG::do_request
                                  + 0.10% PrimaryLogPG::do_op
                                    + 0.10% PrimaryLogPG::execute_ctx
                                      + 0.10% PrimaryLogPG::issue_repop
                                        + 0.10% ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, boost::intrusive_ptr<OpRequest>)
                                          + 0.10% PrimaryLogPG::queue_transactions
                                            + 0.10% queue_transactions
                                              + 0.10% BlueStore::queue_transactions
                                                + 0.10% BlueStore::_txc_add_transaction
                                                  + 0.05% decode_attrset
                                                  + 0.05% BlueStore::_omap_rmkeys

Thread: 18

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.75% WaitInterval
          | + 99.75% WaitUntil
          |   + 99.75% pthread_cond_timedwait@@GLIBC_2.3.2
          + 0.25% run
            + 0.25% apply_visitor<PGQueueable::RunVis, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> >
              + 0.25% apply_visitor<PGQueueable::RunVis>
                + 0.25% internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> >
                  + 0.25% internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*>
                    + 0.25% visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, boost::intrusive_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                      + 0.25% visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest>, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                        + 0.25% visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest> >
                          + 0.25% internal_visit<boost::intrusive_ptr<OpRequest> >
                            + 0.25% PGQueueable::RunVis::operator()
                              + 0.25% OSD::dequeue_op
                                + 0.25% PrimaryLogPG::do_request
                                  + 0.25% PrimaryLogPG::do_op
                                    + 0.25% PrimaryLogPG::execute_ctx
                                      + 0.25% PrimaryLogPG::issue_repop
                                        + 0.25% ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, boost::intrusive_ptr<OpRequest>)
                                          + 0.20% PrimaryLogPG::queue_transactions
                                          | + 0.20% queue_transactions
                                          |   + 0.20% BlueStore::queue_transactions
                                          |     + 0.10% BlueStore::_txc_add_transaction
                                          |     | + 0.05% vector
                                          |     | + 0.05% BlueStore::_omap_setkeys
                                          |     + 0.05% BlueStore::_txc_write_nodes
                                          |     + 0.05% BlueStore::_txc_state_proc
                                          + 0.05% ~unique_ptr

Thread: 19

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.70% WaitInterval
          | + 99.70% WaitUntil
          |   + 99.70% pthread_cond_timedwait@@GLIBC_2.3.2
          + 0.30% run
            + 0.30% apply_visitor<PGQueueable::RunVis, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> >
              + 0.30% apply_visitor<PGQueueable::RunVis>
                + 0.30% internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> >
                  + 0.30% internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*>
                    + 0.30% visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, boost::intrusive_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                      + 0.30% visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest>, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                        + 0.30% visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest> >
                          + 0.30% internal_visit<boost::intrusive_ptr<OpRequest> >
                            + 0.30% PGQueueable::RunVis::operator()
                              + 0.30% OSD::dequeue_op
                                + 0.30% PrimaryLogPG::do_request
                                  + 0.30% PrimaryLogPG::do_op
                                    + 0.30% PrimaryLogPG::execute_ctx
                                      + 0.30% PrimaryLogPG::issue_repop
                                        + 0.30% ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, boost::intrusive_ptr<OpRequest>)
                                          + 0.30% PrimaryLogPG::queue_transactions
                                            + 0.30% queue_transactions
                                              + 0.30% BlueStore::queue_transactions
                                                + 0.10% RocksDBStore::RocksDBTransactionImpl::set
                                                | + 0.10% Put
                                                |   + 0.10% rocksdb::WriteBatchInternal::Put
                                                |     + 0.10% PutLengthPrefixedSlice
                                                |       + 0.10% std::string::append
                                                |         + 0.05% std::string::reserve
                                                |         + 0.05% _M_copy
                                                + 0.10% BlueStore::_txc_add_transaction
                                                | + 0.10% BlueStore::_omap_setkeys
                                                |   + 0.05% operator+=
                                                |   + 0.05% begin
                                                + 0.05% Throttle::get_or_fail
                                                + 0.05% BlueStore::_txc_write_nodes

Thread: 20

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.80% WaitInterval
          | + 99.80% WaitUntil
          |   + 99.80% pthread_cond_timedwait@@GLIBC_2.3.2
          |     + 0.05% __pthread_mutex_cond_lock
          + 0.20% run
            + 0.20% apply_visitor<PGQueueable::RunVis, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> >
              + 0.20% apply_visitor<PGQueueable::RunVis>
                + 0.20% internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> >
                  + 0.20% internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*>
                    + 0.20% visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, boost::intrusive_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                      + 0.20% visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest>, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                        + 0.20% visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest> >
                          + 0.20% internal_visit<boost::intrusive_ptr<OpRequest> >
                            + 0.20% PGQueueable::RunVis::operator()
                              + 0.20% OSD::dequeue_op
                                + 0.20% PrimaryLogPG::do_request
                                  + 0.20% PrimaryLogPG::do_op
                                    + 0.20% PrimaryLogPG::execute_ctx
                                      + 0.20% PrimaryLogPG::issue_repop
                                        + 0.20% ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, boost::intrusive_ptr<OpRequest>)
                                          + 0.20% PrimaryLogPG::queue_transactions
                                            + 0.20% queue_transactions
                                              + 0.20% BlueStore::queue_transactions
                                                + 0.10% BlueStore::_txc_write_nodes
                                                | + 0.05% BlueStore::ExtentMap::update
                                                + 0.05% RocksDBStore::RocksDBTransactionImpl::set
                                                + 0.05% BlueStore::_txc_add_transaction

Thread: 21

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 100.00% OSD::ShardedOpWQ::_process
          + 99.60% WaitInterval
          | + 99.60% WaitUntil
          |   + 99.60% pthread_cond_timedwait@@GLIBC_2.3.2
          |     + 0.05% __pthread_mutex_cond_lock
          + 0.40% run
            + 0.40% apply_visitor<PGQueueable::RunVis, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> >
              + 0.40% apply_visitor<PGQueueable::RunVis>
                + 0.40% internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> >
                  + 0.40% internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*>
                    + 0.40% visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, boost::intrusive_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                      + 0.40% visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest>, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
                        + 0.40% visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest> >
                          + 0.40% internal_visit<boost::intrusive_ptr<OpRequest> >
                            + 0.40% PGQueueable::RunVis::operator()
                              + 0.40% OSD::dequeue_op
                                + 0.40% PrimaryLogPG::do_request
                                  + 0.40% PrimaryLogPG::do_op
                                    + 0.30% PrimaryLogPG::execute_ctx
                                    | + 0.30% PrimaryLogPG::issue_repop
                                    |   + 0.30% ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, boost::intrusive_ptr<OpRequest>)
                                    |     + 0.25% PrimaryLogPG::queue_transactions
                                    |     | + 0.25% queue_transactions
                                    |     |   + 0.25% BlueStore::queue_transactions
                                    |     |     + 0.10% BlueStore::_txc_write_nodes
                                    |     |     | + 0.10% BlueStore::ExtentMap::update
                                    |     |     |   + 0.05% generate_extent_shard_key_and_apply<std::basic_string<char, std::char_traits<char>, mempool::pool_allocator<(mempool::pool_index_t)2, char> > >(const std::basic_string<char, std::char_traits<char>, mempool::pool_allocator<(mempool::pool_index_t)2, char> > &, uint32_t, std::string *, std::function<void(const std::basic_string<char, std::char_traits<char>, std::allocator<char> >&)>)
                                    |     |     |   + 0.05% BlueStore::ExtentMap::encode_some
                                    |     |     + 0.05% RocksDBStore::RocksDBTransactionImpl::set
                                    |     |     + 0.05% BlueStore::_txc_state_proc
                                    |     |     + 0.05% BlueStore::_txc_add_transaction
                                    |     + 0.05% PrimaryLogPG::log_operation
                                    + 0.05% PG::op_has_sufficient_caps
                                    + 0.05% OpRequest::may_read

Thread: 22

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ShardedThreadPool::WorkThreadSharded::entry
      + 100.00% ShardedThreadPool::shardedthreadpool_worker
        + 99.95% OSD::ShardedOpWQ::_process
        | + 99.75% WaitInterval
        | | + 99.75% WaitUntil
        | |   + 99.75% pthread_cond_timedwait@@GLIBC_2.3.2
        | + 0.20% run
        |   + 0.20% apply_visitor<PGQueueable::RunVis, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery> >
        |     + 0.20% apply_visitor<PGQueueable::RunVis>
        |       + 0.20% internal_apply_visitor<boost::detail::variant::invoke_visitor<PGQueueable::RunVis> >
        |         + 0.20% internal_apply_visitor_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*>
        |           + 0.20% visitation_impl<mpl_::int_<0>, boost::detail::variant::visitation_impl_step<boost::mpl::l_iter<boost::mpl::l_item<mpl_::long_<4l>, boost::intrusive_ptr<OpRequest>, boost::mpl::l_item<mpl_::long_<3l>, PGSnapTrim, boost::mpl::l_item<mpl_::long_<2l>, PGScrub, boost::mpl::l_item<mpl_::long_<1l>, PGRecovery, boost::mpl::l_end> > > > >, boost::mpl::l_iter<boost::mpl::l_end> >, boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
        |             + 0.20% visitation_impl_invoke<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest>, boost::variant<boost::intrusive_ptr<OpRequest>, PGSnapTrim, PGScrub, PGRecovery>::has_fallback_type_>
        |               + 0.20% visitation_impl_invoke_impl<boost::detail::variant::invoke_visitor<PGQueueable::RunVis>, void*, boost::intrusive_ptr<OpRequest> >
        |                 + 0.20% internal_visit<boost::intrusive_ptr<OpRequest> >
        |                   + 0.20% PGQueueable::RunVis::operator()
        |                     + 0.20% OSD::dequeue_op
        |                       + 0.20% PrimaryLogPG::do_request
        |                         + 0.20% PrimaryLogPG::do_op
        |                           + 0.20% PrimaryLogPG::execute_ctx
        |                             + 0.20% PrimaryLogPG::issue_repop
        |                               + 0.20% ReplicatedBackend::submit_transaction(hobject_t const&, object_stat_sum_t const&, eversion_t const&, std::unique_ptr<PGTransaction, std::default_delete<PGTransaction> >&&, eversion_t const&, eversion_t const&, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t> > const&, boost::optional<pg_hit_set_history_t>&, Context*, Context*, Context*, unsigned long, osd_reqid_t, boost::intrusive_ptr<OpRequest>)
        |                                 + 0.10% PrimaryLogPG::queue_transactions
        |                                 | + 0.10% queue_transactions
        |                                 |   + 0.10% BlueStore::queue_transactions
        |                                 |     + 0.10% BlueStore::_txc_add_transaction
        |                                 |       + 0.05% BlueStore::_omap_setkeys
        |                                 + 0.05% ~unique_ptr
        |                                 + 0.05% PrimaryLogPG::log_operation
        + 0.05% ceph::HeartbeatMap::reset_timeout

Thread: 23

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ThreadPool::WorkThread::entry
      + 100.00% ThreadPool::worker
        + 100.00% WaitInterval
          + 100.00% WaitUntil
            + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 24

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ThreadPool::WorkThread::entry
      + 100.00% ThreadPool::worker
        + 100.00% WaitInterval
          + 100.00% WaitUntil
            + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 25

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 99.80% WaitUntil
        | + 99.80% pthread_cond_timedwait@@GLIBC_2.3.2
        + 0.20% Context::complete
          + 0.20% FunctionContext::finish
            + 0.20% operator()
              + 0.20% MgrClient::send_report
                + 0.20% operator()
                  + 0.20% std::_Function_handler<MPGStats*(), OSD::init()::__lambda25>::_M_invoke(const std::_Any_data &)
                    + 0.20% operator()
                      + 0.10% is_primary
                      | + 0.10% operator==
                      + 0.05% operator[]
                      + 0.05% operator=

Thread: 26

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% Finisher::finisher_thread_entry
      + 100.00% Wait
        + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 27

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 100.00% WaitUntil
          + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 28

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::LocalDeliveryThread::entry
      + 100.00% DispatchQueue::run_local_delivery
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 29

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::DispatchThread::entry
      + 100.00% DispatchQueue::entry
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 30

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::LocalDeliveryThread::entry
      + 100.00% DispatchQueue::run_local_delivery
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 31

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::DispatchThread::entry
      + 100.00% DispatchQueue::entry
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 32

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::LocalDeliveryThread::entry
      + 100.00% DispatchQueue::run_local_delivery
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 33

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::DispatchThread::entry
      + 100.00% DispatchQueue::entry
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 34

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::LocalDeliveryThread::entry
      + 100.00% DispatchQueue::run_local_delivery
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 35

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::DispatchThread::entry
      + 100.00% DispatchQueue::entry
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 36

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::LocalDeliveryThread::entry
      + 100.00% DispatchQueue::run_local_delivery
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 37

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::DispatchThread::entry
      + 100.00% DispatchQueue::entry
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 38

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::LocalDeliveryThread::entry
      + 100.00% DispatchQueue::run_local_delivery
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 39

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::DispatchThread::entry
      + 100.00% DispatchQueue::entry
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 40

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::LocalDeliveryThread::entry
      + 100.00% DispatchQueue::run_local_delivery
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 41

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% DispatchQueue::DispatchThread::entry
      + 100.00% DispatchQueue::entry
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 42

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% BlueStore::MempoolThread::entry
      + 100.00% WaitInterval
        + 100.00% WaitUntil
          + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 43

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% BlueStore::KVSyncThread::entry
      + 100.00% BlueStore::_kv_sync_thread
        + 74.90% std::condition_variable::wait
        | + 74.90% __gthread_cond_wait
        |   + 74.90% pthread_cond_wait@@GLIBC_2.3.2
        |     + 0.05% __pthread_enable_asynccancel
        + 16.10% RocksDBStore::submit_transaction_sync
        | + 16.05% rocksdb::DBImpl::Write
        |   + 16.05% rocksdb::DBImpl::WriteImpl
        |     + 15.55% rocksdb::WritableFileWriter::Sync
        |     | + 15.55% rocksdb::WritableFileWriter::SyncInternal
        |     |   + 15.55% BlueRocksWritableFile::Sync
        |     |     + 15.55% fsync
        |     |       + 15.55% BlueFS::_fsync
        |     |         + 11.55% BlueFS::wait_for_aio
        |     |         | + 11.50% IOContext::aio_wait
        |     |         | | + 11.50% std::condition_variable::wait
        |     |         | |   + 11.50% __gthread_cond_wait
        |     |         | |     + 11.50% pthread_cond_wait@@GLIBC_2.3.2
        |     |         | |       + 0.30% __pthread_mutex_cond_lock
        |     |         | |         + 0.30% _L_cond_lock_792
        |     |         | |           + 0.30% __lll_lock_wait
        |     |         | + 0.05% operator-
        |     |         + 3.40% BlueFS::_flush
        |     |         | + 3.40% BlueFS::_flush_range
        |     |         |   + 2.15% KernelDevice::aio_submit
        |     |         |   | + 2.10% FS::aio_queue_t::submit
        |     |         |   | | + 2.10% io_submit
        |     |         |   | + 0.05% operator-=
        |     |         |   + 0.85% KernelDevice::aio_write
        |     |         |   | + 0.75% ceph::buffer::list::rebuild_aligned_size_and_memory
        |     |         |   | | + 0.55% ceph::buffer::list::rebuild
        |     |         |   | | | + 0.45% __memcpy_ssse3_back
        |     |         |   | | | + 0.05% push_back
        |     |         |   | | | + 0.05% clear
        |     |         |   | | + 0.20% ceph::buffer::create_aligned
        |     |         |   | |   + 0.10% raw_posix_aligned
        |     |         |   | |   | + 0.10% allocate_aligned
        |     |         |   | |   |   + 0.10% tc_posix_memalign
        |     |         |   | |   |     + 0.10% do_memalign_or_cpp_memalign
        |     |         |   | |   |       + 0.10% (anonymous namespace)::do_memalign
        |     |         |   | |   |         + 0.05% tcmalloc::AlignmentForSize
        |     |         |   | |   |         + 0.05% SizeClass
        |     |         |   | |   + 0.10% ceph::buffer::raw_posix_aligned::operator new
        |     |         |   | |     + 0.10% allocate
        |     |         |   | |       + 0.10% operator+=
        |     |         |   | + 0.05% push_back
        |     |         |   + 0.10% ceph::buffer::ptr::zero
        |     |         |   | + 0.10% ceph::buffer::ptr::zero
        |     |         |   |   + 0.10% invalidate_crc
        |     |         |   |     + 0.10% simple_spin_lock
        |     |         |   + 0.05% ~list
        |     |         |   + 0.05% ceph::buffer::list::substr_of
        |     |         |   + 0.05% __memset_sse2
        |     |         + 0.40% BlueFS::flush_bdev
        |     |         | + 0.40% KernelDevice::flush
        |     |         |   + 0.40% fdatasync
        |     |         + 0.10% clear
        |     |         | + 0.10% std::_List_base<FS::aio_t, std::allocator<FS::aio_t> >::_M_clear
        |     |         |   + 0.10% destroy<std::_List_node<FS::aio_t> >
        |     |         |     + 0.10% ~_List_node
        |     |         |       + 0.10% ~aio_t
        |     |         |         + 0.10% ~list
        |     |         |           + 0.10% ~list
        |     |         |             + 0.10% ~_List_base
        |     |         |               + 0.10% std::_List_base<ceph::buffer::ptr, std::allocator<ceph::buffer::ptr> >::_M_clear
        |     |         |                 + 0.10% destroy<std::_List_node<ceph::buffer::ptr> >
        |     |         |                   + 0.10% ~_List_node
        |     |         |                     + 0.10% ~ptr
        |     |         |                       + 0.10% ceph::buffer::ptr::release
        |     |         |                         + 0.05% tc_deletearray
        |     |         |                         + 0.05% ceph::buffer::raw_posix_aligned::~raw_posix_aligned
        |     |         + 0.05% lock
        |     |         + 0.05% BlueFS::_claim_completed_aios
        |     + 0.15% rocksdb::WriteBatchInternal::InsertInto
        |     | + 0.15% rocksdb::WriteBatch::Iterate
        |     |   + 0.10% rocksdb::MemTableInserter::SingleDeleteCF
        |     |     + 0.10% DeleteImpl
        |     |       + 0.10% rocksdb::MemTable::Add
        |     |         + 0.10% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::Insert<false>
        |     |           + 0.10% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::RecomputeSpliceLevels
        |     |             + 0.10% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::FindSpliceForLevel
        |     |               + 0.10% KeyIsAfterNode
        |     |                 + 0.10% rocksdb::MemTable::KeyComparator::operator()
        |     |                   + 0.10% rocksdb::InternalKeyComparator::Compare
        |     |                     + 0.05% rocksdb::(anonymous namespace)::BytewiseComparatorImpl::Compare
        |     + 0.05% rocksdb::WriteThread::JoinBatchGroup
        |     + 0.05% rocksdb::WriteThread::ExitAsBatchGroupLeader
        |     + 0.05% rocksdb::DBImpl::WriteContext::~WriteContext
        |     + 0.05% Unlock
        + 4.20% RocksDBStore::submit_transaction
        | + 4.15% rocksdb::DBImpl::Write
        |   + 4.10% rocksdb::DBImpl::WriteImpl
        |     + 2.40% rocksdb::WriteBatchInternal::InsertInto
        |     | + 2.40% rocksdb::WriteBatch::Iterate
        |     |   + 2.30% rocksdb::MemTableInserter::PutCF
        |     |   | + 2.20% rocksdb::MemTable::Add
        |     |   | | + 1.60% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::Insert<false>
        |     |   | | | + 1.30% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::RecomputeSpliceLevels
        |     |   | | | | + 1.25% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::FindSpliceForLevel
        |     |   | | | |   + 1.10% KeyIsAfterNode
        |     |   | | | |     + 1.10% rocksdb::MemTable::KeyComparator::operator()
        |     |   | | | |       + 0.85% rocksdb::InternalKeyComparator::Compare
        |     |   | | | |       | + 0.60% rocksdb::(anonymous namespace)::BytewiseComparatorImpl::Compare
        |     |   | | | |       |   + 0.60% compare
        |     |   | | | |       |     + 0.45% __memcmp_sse4_1
        |     |   | | | |       + 0.25% GetLengthPrefixedSlice
        |     |   | | | |         + 0.05% GetVarint32Ptr
        |     |   | | | + 0.20% KeyIsAfterNode
        |     |   | | |   + 0.20% rocksdb::MemTable::KeyComparator::operator()
        |     |   | | |     + 0.15% rocksdb::InternalKeyComparator::Compare
        |     |   | | |       + 0.10% rocksdb::(anonymous namespace)::BytewiseComparatorImpl::Compare
        |     |   | | |         + 0.10% compare
        |     |   | | |           + 0.10% __memcmp_sse4_1
        |     |   | | + 0.45% __memcpy_ssse3_back
        |     |   | | + 0.10% rocksdb::(anonymous namespace)::SkipListRep::Allocate
        |     |   | | | + 0.10% AllocateKey
        |     |   | | |   + 0.10% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator const&>::AllocateNode
        |     |   | | |     + 0.10% rocksdb::ConcurrentArena::AllocateAligned
        |     |   | | |       + 0.05% AllocateImpl<rocksdb::ConcurrentArena::AllocateAligned(size_t, size_t, rocksdb::Logger*)::__lambda1>
        |     |   | | + 0.05% rocksdb::MemTable::UpdateFlushState
        |     |   | + 0.05% SeekToColumnFamily
        |     |   | + 0.05% CheckMemtableFull
        |     |   + 0.05% rocksdb::ReadRecordFromWriteBatch
        |     |   + 0.05% rocksdb::MemTableInserter::DeleteCF
        |     + 1.20% rocksdb::log::Writer::AddRecord
        |     | + 1.20% rocksdb::log::Writer::EmitPhysicalRecord
        |     |   + 0.80% rocksdb::WritableFileWriter::Append
        |     |   | + 0.80% rocksdb::WritableFileWriter::WriteBuffered
        |     |   |   + 0.75% BlueRocksWritableFile::Append
        |     |   |   | + 0.75% append
        |     |   |   |   + 0.75% append
        |     |   |   |     + 0.75% memcpy
        |     |   |   |       + 0.75% __memcpy_ssse3_back
        |     |   |   + 0.05% operator=
        |     |   + 0.25% rocksdb::WritableFileWriter::Flush
        |     |   | + 0.20% BlueRocksWritableFile::Flush
        |     |   |   + 0.20% flush
        |     |   |     + 0.10% lock_guard
        |     |   |     | + 0.10% lock
        |     |   |     |   + 0.10% __gthread_mutex_lock
        |     |   |     |     + 0.10% __GI___pthread_mutex_lock
        |     |   |     |       + 0.10% _L_lock_791
        |     |   |     |         + 0.10% __lll_lock_wait
        |     |   |     + 0.10% BlueFS::_flush
        |     |   |       + 0.05% flush
        |     |   + 0.15% rocksdb::crc32c::ExtendImpl<rocksdb::crc32c::Fast_CRC32>
        |     |     + 0.05% Fast_CRC32
        |     + 0.10% rocksdb::WriteThread::JoinBatchGroup
        |     | + 0.10% rocksdb::WriteThread::LinkOne
        |     |   + 0.10% store
        |     + 0.10% rocksdb::WriteThread::ExitAsBatchGroupLeader
        |     | + 0.05% compare_exchange_strong
        |     + 0.05% rocksdb::WriteController::IsStopped
        |     + 0.05% rocksdb::FlushScheduler::Empty
        |     + 0.05% rocksdb::DBImpl::WriteContext::~WriteContext
        + 2.10% BlueStore::_txc_state_proc
        | + 0.80% BlueStore::_deferred_queue
        | | + 0.75% BlueStore::DeferredBatch::prepare_write
        | | | + 0.25% operator[]
        | | | | + 0.15% _M_emplace_hint_unique<const std::piecewise_construct_t&, std::tuple<long unsigned int const&>, std::tuple<> >
        | | | | | + 0.15% _M_insert_node
        | | | | |   + 0.10% std::_Rb_tree_insert_and_rebalance
        | | | | + 0.10% lower_bound
        | | | |   + 0.10% lower_bound
        | | | |     + 0.10% _M_lower_bound
        | | | + 0.20% ceph::buffer::list::iterator_impl<true>::copy
        | | | | + 0.10% ceph::buffer::list::append
        | | | | | + 0.05% ceph::buffer::ptr::ptr
        | | | | + 0.05% ceph::buffer::list::iterator_impl<true>::advance
        | | | + 0.10% insert<std::pair<unsigned long, BlueStore::DeferredBatch::deferred_io>, void>
        | | | | + 0.05% std::_Rb_tree<unsigned long, std::pair<unsigned long const, BlueStore::DeferredBatch::deferred_io>, std::_Select1st<std::pair<unsigned long const, BlueStore::DeferredBatch::deferred_io> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, BlueStore::DeferredBatch::deferred_io> > >::_M_insert_unique<std::pair<unsigned long, BlueStore::DeferredBatch::deferred_io> >(std::pair<unsigned long, BlueStore::DeferredBatch::deferred_io>&&)
        | | | + 0.05% make_pair<unsigned long&, BlueStore::DeferredBatch::deferred_io>
        | | | + 0.05% BlueStore::DeferredBatch::_discard
        | | + 0.05% push_back
        | + 0.60% BlueStore::_txc_finish
        | | + 0.50% BlueStore::_osr_reap_done
        | | | + 0.50% ~TransContext
        | | |   + 0.20% ~shared_ptr
        | | |   | + 0.20% ~__shared_ptr
        | | |   |   + 0.20% ~__shared_count
        | | |   |     + 0.20% std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release
        | | |   |       + 0.20% RocksDBStore::RocksDBTransactionImpl::~RocksDBTransactionImpl
        | | |   |         + 0.20% rocksdb::WriteBatch::~WriteBatch
        | | |   |           + 0.20% ~basic_string
        | | |   |             + 0.20% _M_dispose
        | | |   |               + 0.20% std::string::_Rep::_M_destroy
        | | |   |                 + 0.20% deallocate
        | | |   |                   + 0.20% tc_delete
        | | |   |                     + 0.20% do_free
        | | |   |                       + 0.20% do_free_with_callback
        | | |   |                         + 0.20% do_free_helper
        | | |   |                           + 0.20% Deallocate
        | | |   |                             + 0.20% tcmalloc::ThreadCache::ListTooLong
        | | |   |                               + 0.20% tcmalloc::ThreadCache::ReleaseToCentralCache
        | | |   |                                 + 0.20% tcmalloc::CentralFreeList::InsertRange
        | | |   |                                   + 0.20% tcmalloc::CentralFreeList::ReleaseListToSpans
        | | |   |                                     + 0.20% tcmalloc::CentralFreeList::ReleaseToSpans
        | | |   |                                       + 0.20% tcmalloc::PageHeap::Delete
        | | |   |                                         + 0.20% tcmalloc::PageHeap::MergeIntoFreeList
        | | |   |                                           + 0.20% tcmalloc::PageHeap::DecommitSpan
        | | |   |                                             + 0.20% TCMalloc_SystemRelease
        | | |   |                                               + 0.20% madvise
        | | |   + 0.20% ~bluestore_deferred_transaction_t
        | | |   | + 0.15% ~list
        | | |   | | + 0.15% ~_List_base
        | | |   | |   + 0.15% std::_List_base<bluestore_deferred_op_t, std::allocator<bluestore_deferred_op_t> >::_M_clear
        | | |   | |     + 0.15% destroy<std::_List_node<bluestore_deferred_op_t> >
        | | |   | |       + 0.15% ~_List_node
        | | |   | |         + 0.15% ~bluestore_deferred_op_t
        | | |   | |           + 0.15% ~list
        | | |   | |             + 0.10% ~list
        | | |   | |             | + 0.10% ~_List_base
        | | |   | |             |   + 0.10% std::_List_base<ceph::buffer::ptr, std::allocator<ceph::buffer::ptr> >::_M_clear
        | | |   | |             |     + 0.10% destroy<std::_List_node<ceph::buffer::ptr> >
        | | |   | |             |       + 0.10% ~_List_node
        | | |   | |             + 0.05% ~ptr
        | | |   | + 0.05% ~interval_set
        | | |   + 0.10% ~intrusive_ptr
        | | |     + 0.10% RefCountedObject::put
        | | |       + 0.10% dec
        | | + 0.10% BlueStore::BufferSpace::finish_write
        | |   + 0.10% erase
        | |     + 0.10% std::_Rb_tree<unsigned int, std::pair<unsigned int const, std::unique_ptr<BlueStore::Buffer, std::default_delete<BlueStore::Buffer> > >, std::_Select1st<std::pair<unsigned int const, std::unique_ptr<BlueStore::Buffer, std::default_delete<BlueStore::Buffer> > > >, std::less<unsigned int>, mempool::pool_allocator<(mempool::pool_index_t)2, std::pair<unsigned int const, std::unique_ptr<BlueStore::Buffer, std::default_delete<BlueStore::Buffer> > > > >::erase
        | |       + 0.10% erase
        | |         + 0.10% _M_erase_aux
        | |           + 0.05% erase
        | |           + 0.05% clear
        | + 0.45% BlueStore::_txc_committed_kv
        | | + 0.35% queue
        | |   + 0.35% Signal
        | |     + 0.35% pthread_cond_broadcast@@GLIBC_2.3.2
        | + 0.10% log_state_latency
        |   + 0.10% PerfCounters::tinc
        |     + 0.10% inc
        |       + 0.05% ceph_spin_lock
        + 0.50% BlueStore::_balance_bluefs_freespace
        | + 0.40% BlueFS::get_usage
        | | + 0.20% BitMapAllocator::get_free
        | | | + 0.15% BitAllocator::get_used_blocks
        | | | | + 0.15% BitMapAreaIN::get_used_blocks_adj
        | | | |   + 0.10% lock_guard
        | | | |     + 0.10% lock
        | | | |       + 0.10% __gthread_mutex_lock
        | | | |         + 0.10% __GI___pthread_mutex_lock
        | | | + 0.05% total_blocks
        | | + 0.10% resize
        | | | + 0.10% std::vector<std::pair<unsigned long, unsigned long>, std::allocator<std::pair<unsigned long, unsigned long> > >::_M_default_append
        | | |   + 0.10% _M_allocate
        | | |     + 0.10% allocate
        | | |       + 0.05% tc_new
        | | + 0.05% operator[]
        | | + 0.05% lock_guard
        | + 0.05% ~vector
        | + 0.05% BitMapAllocator::get_free
        + 0.30% RocksDBStore::get_transaction
        | + 0.25% make_shared<RocksDBStore::RocksDBTransactionImpl, RocksDBStore* const>
        |   + 0.25% allocate_shared<RocksDBStore::RocksDBTransactionImpl, std::allocator<RocksDBStore::RocksDBTransactionImpl>, RocksDBStore* const>
        |     + 0.25% shared_ptr<std::allocator<RocksDBStore::RocksDBTransactionImpl>, RocksDBStore* const>
        |       + 0.25% __shared_ptr<std::allocator<RocksDBStore::RocksDBTransactionImpl>, RocksDBStore* const>
        |         + 0.20% __shared_count<RocksDBStore::RocksDBTransactionImpl, std::allocator<RocksDBStore::RocksDBTransactionImpl>, RocksDBStore* const>
        |         | + 0.15% construct<std::_Sp_counted_ptr_inplace<RocksDBStore::RocksDBTransactionImpl, std::allocator<RocksDBStore::RocksDBTransactionImpl>, (__gnu_cxx::_Lock_policy)2>, std::allocator<RocksDBStore::RocksDBTransactionImpl> const, RocksDBStore* const>
        |         | | + 0.15% _S_construct<std::_Sp_counted_ptr_inplace<RocksDBStore::RocksDBTransactionImpl, std::allocator<RocksDBStore::RocksDBTransactionImpl>, (__gnu_cxx::_Lock_policy)2>, std::allocator<RocksDBStore::RocksDBTransactionImpl> const, RocksDBStore* const>
        |         | |   + 0.15% construct<std::_Sp_counted_ptr_inplace<RocksDBStore::RocksDBTransactionImpl, std::allocator<RocksDBStore::RocksDBTransactionImpl>, (__gnu_cxx::_Lock_policy)2>, std::allocator<RocksDBStore::RocksDBTransactionImpl> const, RocksDBStore* const>
        |         | |     + 0.15% _Sp_counted_ptr_inplace<RocksDBStore* const>
        |         | |       + 0.15% construct<RocksDBStore::RocksDBTransactionImpl, RocksDBStore* const>
        |         | |         + 0.15% _S_construct<RocksDBStore::RocksDBTransactionImpl, RocksDBStore* const>
        |         | |           + 0.15% construct<RocksDBStore::RocksDBTransactionImpl, RocksDBStore* const>
        |         | |             + 0.15% RocksDBStore::RocksDBTransactionImpl::RocksDBTransactionImpl
        |         | |               + 0.15% rocksdb::WriteBatch::WriteBatch
        |         | |                 + 0.05% std::string::reserve
        |         | |                 + 0.05% resize
        |         | |                 + 0.05% basic_string
        |         | + 0.05% allocate
        |         + 0.05% _M_get_deleter
        + 0.25% BlueStore::_txc_applied_kv
        | + 0.15% lock_guard
        | | + 0.15% lock
        | |   + 0.15% __gthread_mutex_lock
        | |     + 0.15% __GI___pthread_mutex_lock
        | + 0.05% std::condition_variable::notify_all
        | + 0.05% erase
        + 0.15% unlock
        | + 0.15% unlock
        |   + 0.15% __gthread_mutex_unlock
        |     + 0.15% __GI___pthread_mutex_unlock
        |       + 0.15% __pthread_mutex_unlock_usercnt
        |         + 0.15% _L_unlock_697
        |           + 0.15% __lll_unlock_wake
        + 0.15% lock_guard
        | + 0.10% std::mutex::lock
        |   + 0.10% __gthread_mutex_lock
        |     + 0.05% __GI___pthread_mutex_lock
        + 0.15% Throttle::put
        | + 0.05% read
        | + 0.05% PerfCounters::set
        | + 0.05% PerfCounters::inc
        + 0.15% BlueStore::_reap_collections
        | + 0.05% ~list
        | + 0.05% lock_guard
        + 0.10% ~deque
        | + 0.10% std::_Deque_base<BlueStore::DeferredBatch*, std::allocator<BlueStore::DeferredBatch*> >::~_Deque_base
        |   + 0.05% _M_deallocate_map
        + 0.10% ~DeferredBatch
        | + 0.10% ~IOContext
        |   + 0.10% ~list
        |     + 0.10% ~_List_base
        |       + 0.10% std::_List_base<FS::aio_t, std::allocator<FS::aio_t> >::_M_clear
        |         + 0.10% destroy<std::_List_node<FS::aio_t> >
        |           + 0.10% ~_List_node
        |             + 0.10% ~aio_t
        |               + 0.10% ~list
        |                 + 0.10% ~list
        |                   + 0.10% ~_List_base
        |                     + 0.10% std::_List_base<ceph::buffer::ptr, std::allocator<ceph::buffer::ptr> >::_M_clear
        |                       + 0.10% destroy<std::_List_node<ceph::buffer::ptr> >
        |                         + 0.10% ~_List_node
        |                           + 0.10% ~ptr
        |                             + 0.10% ceph::buffer::ptr::release
        |                               + 0.05% ceph::buffer::raw_posix_aligned::~raw_posix_aligned
        |                               + 0.05% ceph::buffer::raw_posix_aligned::operator delete
        + 0.10% past_midpoint
        | + 0.10% read
        |   + 0.05% AO_nop_full
        |   + 0.05% AO_load_read
        + 0.10% ceph_clock_now
        + 0.10% BlueStore::_deferred_try_submit
        | + 0.10% BlueStore::_deferred_try_submit
        |   + 0.05% ceph::buffer::list::claim_append
        |   + 0.05% KernelDevice::aio_submit
        + 0.05% ~vector
        + 0.05% vector
        + 0.05% shared_ptr
        + 0.05% operator->
        + 0.05% log_state_latency
        + 0.05% deque
        + 0.05% KernelDevice::flush

Thread: 44

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% Finisher::finisher_thread_entry
      + 94.15% Wait
      | + 94.10% pthread_cond_wait@@GLIBC_2.3.2
      | | + 0.05% __pthread_mutex_cond_lock
      | + 0.05% _post_lock
      + 3.10% C_ContextsBase<Context, Context>::complete
      | + 3.10% complete
      |   + 3.10% finish_contexts<Context>
      |     + 3.05% Context::complete
      |     | + 3.05% PrimaryLogPG::BlessedContext::finish
      |     |   + 2.95% Context::complete
      |     |   | + 2.95% ReplicatedBackend::op_applied
      |     |   |   + 1.50% Context::complete
      |     |   |   | + 1.50% PrimaryLogPG::repop_all_applied
      |     |   |   |   + 1.50% PrimaryLogPG::eval_repop
      |     |   |   |     + 1.00% PrimaryLogPG::remove_repop
      |     |   |   |     | + 0.65% PrimaryLogPG::release_object_locks
      |     |   |   |     | | + 0.25% put_locks
      |     |   |   |     | | | + 0.10% pair
      |     |   |   |     | | | | + 0.05% hobject_t::hobject_t
      |     |   |   |     | | | | + 0.05% ObjectLockState
      |     |   |   |     | | | + 0.05% ~list
      |     |   |   |     | | | + 0.05% put_lock_type
      |     |   |   |     | | | + 0.05% clear
      |     |   |   |     | | + 0.20% PG::requeue_ops
      |     |   |   |     | | | + 0.10% clear
      |     |   |   |     | | + 0.15% hobject_t::~hobject_t
      |     |   |   |     | | | + 0.10% ~object_t
      |     |   |   |     | | | | + 0.10% ~basic_string
      |     |   |   |     | | | |   + 0.05% std::string::_Rep::_M_dispose
      |     |   |   |     | | | + 0.05% ~basic_string
      |     |   |   |     | | + 0.05% write_blocked_by_scrub
      |     |   |   |     | + 0.30% std::_Function_handler<void(), PrimaryLogPG::execute_ctx(PrimaryLogPG::OpContext*)::__lambda27>::_M_invoke(const std::_Any_data &)
      |     |   |   |     | | + 0.30% operator()
      |     |   |   |     | |   + 0.30% PrimaryLogPG::OpContext::~OpContext
      |     |   |   |     | |     + 0.10% ~list
      |     |   |   |     | |     | + 0.10% ~_List_base
      |     |   |   |     | |     |   + 0.05% std::_List_base<std::function<void ()>, std::allocator<std::function<void ()> > >::_M_clear()
      |     |   |   |     | |     |   + 0.05% std::_List_base<PrimaryLogPG::OpContext::NotifyAck, std::allocator<PrimaryLogPG::OpContext::NotifyAck> >::_M_clear
      |     |   |   |     | |     + 0.05% ~vector
      |     |   |   |     | |     + 0.05% ~interval_set
      |     |   |   |     | |     + 0.05% hobject_t::~hobject_t
      |     |   |   |     | |     + 0.05% SnapSet::~SnapSet
      |     |   |   |     | + 0.05% tc_delete
      |     |   |   |     + 0.30% PG::publish_stats_to_osd
      |     |   |   |     | + 0.20% pg_stat_t
      |     |   |   |     | | + 0.10% vector
      |     |   |   |     | |   + 0.05% __uninitialized_copy_a<__gnu_cxx::__normal_iterator<int const*, std::vector<int> >, int*, int>
      |     |   |   |     | |   + 0.05% _Vector_base
      |     |   |   |     | + 0.05% pg_stat_t::operator=
      |     |   |   |     | + 0.05% PG::_update_calc_stats
      |     |   |   |     + 0.20% PG::calc_min_last_complete_ondisk
      |     |   |   |       + 0.10% operator==
      |     |   |   |       + 0.05% operator++
      |     |   |   + 1.45% erase
      |     |   |     + 1.45% std::_Rb_tree<unsigned long, std::pair<unsigned long const, ReplicatedBackend::InProgressOp>, std::_Select1st<std::pair<unsigned long const, ReplicatedBackend::InProgressOp> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, ReplicatedBackend::InProgressOp> > >::erase
      |     |   |       + 1.45% erase
      |     |   |         + 1.45% _M_erase_aux
      |     |   |           + 1.45% clear
      |     |   |             + 1.45% std::_Rb_tree<unsigned long, std::pair<unsigned long const, ReplicatedBackend::InProgressOp>, std::_Select1st<std::pair<unsigned long const, ReplicatedBackend::InProgressOp> >, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, ReplicatedBackend::InProgressOp> > >::_M_erase
      |     |   |               + 1.40% _M_destroy_node
      |     |   |                 + 1.40% destroy<std::_Rb_tree_node<std::pair<unsigned long const, ReplicatedBackend::InProgressOp> > >
      |     |   |                   + 1.40% ~_Rb_tree_node
      |     |   |                     + 1.40% ~pair
      |     |   |                       + 1.40% ~InProgressOp
      |     |   |                         + 1.40% ~intrusive_ptr
      |     |   |                           + 1.40% intrusive_ptr_release
      |     |   |                             + 1.25% OpTracker::unregister_inflight_op
      |     |   |                             | + 0.35% OpHistory::insert
      |     |   |                             | | + 0.20% OpHistory::cleanup
      |     |   |                             | | | + 0.20% erase
      |     |   |                             | | |   + 0.20% erase
      |     |   |                             | | |     + 0.10% std::_Rb_tree<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> >, std::pair<utime_t, boost::intrusive_ptr<TrackedOp> >, std::_Identity<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > >, std::less<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > >, std::allocator<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > > >::equal_range
      |     |   |                             | | |     + 0.05% erase
      |     |   |                             | | + 0.15% insert
      |     |   |                             | |   + 0.10% std::_Rb_tree<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> >, std::pair<utime_t, boost::intrusive_ptr<TrackedOp> >, std::_Identity<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > >, std::less<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > >, std::allocator<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > > >::_M_insert_unique<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > >(std::pair<utime_t, boost::intrusive_ptr<TrackedOp> >&&)
      |     |   |                             | |   | + 0.05% _M_insert_<std::pair<utime_t, boost::intrusive_ptr<TrackedOp> > >
      |     |   |                             | |   | + 0.05% _M_get_insert_unique_pos
      |     |   |                             | |   + 0.05% std::_Rb_tree<std::pair<double, boost::intrusive_ptr<TrackedOp> >, std::pair<double, boost::intrusive_ptr<TrackedOp> >, std::_Identity<std::pair<double, boost::intrusive_ptr<TrackedOp> > >, std::less<std::pair<double, boost::intrusive_ptr<TrackedOp> > >, std::allocator<std::pair<double, boost::intrusive_ptr<TrackedOp> > > >::_M_insert_unique<std::pair<double, boost::intrusive_ptr<TrackedOp> > >(std::pair<double, boost::intrusive_ptr<TrackedOp> >&&)
      |     |   |                             | + 0.30% ~intrusive_ptr
      |     |   |                             | | + 0.30% intrusive_ptr_release
      |     |   |                             | |   + 0.30% put
      |     |   |                             | |     + 0.30% OpRequest::~OpRequest
      |     |   |                             | |       + 0.30% ~OpRequest
      |     |   |                             | |         + 0.15% ~TrackedOp
      |     |   |                             | |         | + 0.15% ~vector
      |     |   |                             | |         |   + 0.10% _Destroy<TrackedOp::Event*, TrackedOp::Event>
      |     |   |                             | |         |   | + 0.10% _Destroy<TrackedOp::Event*>
      |     |   |                             | |         |   |   + 0.10% __destroy<TrackedOp::Event*>
      |     |   |                             | |         |   |     + 0.10% _Destroy<TrackedOp::Event>
      |     |   |                             | |         |   |       + 0.10% ~Event
      |     |   |                             | |         |   |         + 0.10% ~basic_string
      |     |   |                             | |         |   |           + 0.05% _M_dispose
      |     |   |                             | |         |   + 0.05% ~_Vector_base
      |     |   |                             | |         + 0.15% RefCountedObject::put
      |     |   |                             | |           + 0.10% MOSDOp::~MOSDOp
      |     |   |                             | |           | + 0.05% tc_delete
      |     |   |                             | |           + 0.05% dec
      |     |   |                             | + 0.30% OpRequest::_unregistered
      |     |   |                             | | + 0.25% clear_data
      |     |   |                             | | | + 0.15% clear
      |     |   |                             | | | | + 0.15% clear
      |     |   |                             | | | |   + 0.15% std::_List_base<ceph::buffer::ptr, std::allocator<ceph::buffer::ptr> >::_M_clear
      |     |   |                             | | | |     + 0.15% destroy<std::_List_node<ceph::buffer::ptr> >
      |     |   |                             | | | |       + 0.15% ~_List_node
      |     |   |                             | | | |         + 0.15% ~ptr
      |     |   |                             | | | |           + 0.15% ceph::buffer::ptr::release
      |     |   |                             | | | + 0.10% Throttle::put
      |     |   |                             | | |   + 0.05% ~Locker
      |     |   |                             | | + 0.05% set_connection
      |     |   |                             | + 0.20% ~RLocker
      |     |   |                             | | + 0.20% unlock
      |     |   |                             | |   + 0.10% read
      |     |   |                             | |   | + 0.10% AO_load_read
      |     |   |                             | |   |   + 0.10% AO_load
      |     |   |                             | |   + 0.05% pthread_rwlock_unlock
      |     |   |                             | + 0.05% RLocker
      |     |   |                             + 0.15% TrackedOp::put
      |     |   |                               + 0.05% ceph_clock_now
      |     |   |                               + 0.05% TrackedOp::mark_event
      |     |   + 0.05% tc_delete
      |     |   + 0.05% PG::lock
      |     + 0.05% tc_delete
      + 2.20% Context::complete
      | + 2.20% PrimaryLogPG::BlessedContext::finish
      |   + 2.05% Context::complete
      |   | + 2.05% ReplicatedBackend::op_commit
      |   |   + 1.65% Context::complete
      |   |   | + 1.60% PrimaryLogPG::repop_all_committed
      |   |   |   + 1.55% PrimaryLogPG::eval_repop
      |   |   |     + 1.50% PrimaryLogPG::__lambda25::operator()
      |   |   |     | + 0.95% send_message_osd_client
      |   |   |     | | + 0.95% AsyncConnection::send_message
      |   |   |     | |   + 0.60% EventCenter::dispatch_event_external
      |   |   |     | |   | + 0.60% EventCenter::wakeup
      |   |   |     | |   |   + 0.60% write
      |   |   |     | |   + 0.15% operator[]
      |   |   |     | |   | + 0.15% _M_emplace_hint_unique<const std::piecewise_construct_t&, std::tuple<int&&>, std::tuple<> >
      |   |   |     | |   |   + 0.15% _M_create_node<const std::piecewise_construct_t&, std::tuple<int&&>, std::tuple<> >
      |   |   |     | |   |     + 0.15% _M_get_node
      |   |   |     | |   |       + 0.15% allocate
      |   |   |     | |   |         + 0.15% tc_new
      |   |   |     | |   |           + 0.15% cpp_alloc
      |   |   |     | |   |             + 0.15% do_malloc_no_errno
      |   |   |     | |   |               + 0.15% do_malloc_small
      |   |   |     | |   |                 + 0.05% class_to_size
      |   |   |     | |   |                 + 0.05% SizeClass
      |   |   |     | |   |                 + 0.05% Allocate
      |   |   |     | |   + 0.10% emplace_back<ceph::buffer::list, Message*&>
      |   |   |     | |   | + 0.10% _M_insert<ceph::buffer::list, Message*&>
      |   |   |     | |   |   + 0.05% _ZNSt8__detail15_List_node_base7_M_hookEPS0_@plt
      |   |   |     | |   |   + 0.05% _M_create_node<ceph::buffer::list, Message*&>
      |   |   |     | |   + 0.05% ms_can_fast_dispatch
      |   |   |     | + 0.55% PrimaryLogPG::log_op_stats
      |   |   |     |   + 0.25% PerfCounters::hinc
      |   |   |     |   | + 0.25% inc<long, long>
      |   |   |     |   |   + 0.20% get_raw_index_for_value<long, long>
      |   |   |     |   |   | + 0.20% get_raw_index_internal<0, long (*)(long, PerfHistogramCommon::axis_config_d const&), long>
      |   |   |     |   |   |   + 0.15% PerfHistogramCommon::get_bucket_for_axis
      |   |   |     |   |   |   | + 0.10% get_quants
      |   |   |     |   |   |   + 0.05% get_raw_index_internal<1, long (*)(long, PerfHistogramCommon::axis_config_d const&)>
      |   |   |     |   |   + 0.05% add
      |   |   |     |   + 0.15% PerfCounters::inc
      |   |   |     |   | + 0.05% add
      |   |   |     |   + 0.05% PerfCounters::tinc
      |   |   |     + 0.05% std::function<void ()>::operator()() const
      |   |   + 0.15% erase
      |   |   | + 0.15% std::_Rb_tree<pg_shard_t, pg_shard_t, std::_Identity<pg_shard_t>, std::less<pg_shard_t>, std::allocator<pg_shard_t> >::erase
      |   |   |   + 0.15% erase
      |   |   |     + 0.15% _M_erase_aux
      |   |   |       + 0.15% clear
      |   |   |         + 0.15% std::_Rb_tree<pg_shard_t, pg_shard_t, std::_Identity<pg_shard_t>, std::less<pg_shard_t>, std::allocator<pg_shard_t> >::_M_erase
      |   |   |           + 0.15% _M_destroy_node
      |   |   |             + 0.15% _M_put_node
      |   |   |               + 0.15% deallocate
      |   |   |                 + 0.10% tc_delete
      |   |   |                 | + 0.05% do_free
      |   |   |                 + 0.05% _ZdlPv@plt
      |   |   + 0.10% TrackedOp::mark_event
      |   |   + 0.05% tc_delete
      |   |   + 0.05% C_OSD_RepopCommit::~C_OSD_RepopCommit
      |   + 0.05% PG::lock
      |   + 0.05% C_OSD_OnOpCommit::~C_OSD_OnOpCommit
      + 0.25% Mutex::Unlock
      | + 0.25% __GI___pthread_mutex_unlock
      |   + 0.25% __pthread_mutex_unlock_usercnt
      |     + 0.25% _L_unlock_697
      |       + 0.25% __lll_unlock_wake
      + 0.10% swap
      | + 0.10% std::__detail::_List_node_base::swap
      + 0.05% ceph_clock_now
      + 0.05% PerfCounters::dec
      + 0.05% Mutex::Lock

Thread: 45

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% std::(anonymous namespace)::execute_native_thread_routine
      + 100.00% rocksdb::ThreadPoolImpl::Impl::BGThreadWrapper
        + 100.00% rocksdb::ThreadPoolImpl::Impl::BGThread
          + 96.40% std::condition_variable::wait
          | + 96.40% __gthread_cond_wait
          |   + 96.40% pthread_cond_wait@@GLIBC_2.3.2
          + 3.60% rocksdb::DBImpl::BackgroundCallCompaction
            + 3.60% rocksdb::DBImpl::BackgroundCompaction
              + 3.60% rocksdb::CompactionJob::Run
                + 3.60% rocksdb::CompactionJob::ProcessKeyValueCompaction
                  + 3.10% rocksdb::CompactionIterator::Next
                  | + 2.75% rocksdb::MergingIterator::Next
                  | | + 2.65% Next
                  | | | + 2.20% rocksdb::(anonymous namespace)::TwoLevelIterator::Next
                  | | | | + 2.20% Next
                  | | | |   + 2.10% rocksdb::(anonymous namespace)::TwoLevelIterator::SkipEmptyDataBlocksForward
                  | | | |   | + 2.10% rocksdb::(anonymous namespace)::TwoLevelIterator::InitDataBlock
                  | | | |   |   + 2.10% rocksdb::BlockBasedTable::NewDataBlockIterator
                  | | | |   |     + 2.00% rocksdb::(anonymous namespace)::ReadBlockFromFile
                  | | | |   |     | + 2.00% rocksdb::ReadBlockContents
                  | | | |   |     |   + 1.95% ReadBlock
                  | | | |   |     |   | + 1.90% rocksdb::RandomAccessFileReader::Read
                  | | | |   |     |   | | + 1.85% BlueRocksRandomAccessFile::Read
                  | | | |   |     |   | | | + 1.85% read_random
                  | | | |   |     |   | | |   + 1.85% BlueFS::_read_random
                  | | | |   |     |   | | |     + 1.80% KernelDevice::read_random
                  | | | |   |     |   | | |       + 1.80% KernelDevice::direct_read_unaligned
                  | | | |   |     |   | | |         + 1.80% pread
                  | | | |   |     |   | | |           + 1.80% pread64
                  | | | |   |     |   | | + 0.05% use_direct_io
                  | | | |   |     |   | + 0.05% Value
                  | | | |   |     |   + 0.05% __memcpy_ssse3_back
                  | | | |   |     + 0.05% rocksdb::BlockBasedTable::MaybeLoadDataBlockToCache
                  | | | |   |     + 0.05% operator=
                  | | | |   + 0.05% rocksdb::BlockIter::ParseNextKey
                  | | | |   + 0.05% rocksdb::(anonymous namespace)::TwoLevelIterator::Next
                  | | | + 0.45% rocksdb::(anonymous namespace)::TwoLevelIterator::SkipEmptyDataBlocksForward
                  | | |   + 0.45% rocksdb::(anonymous namespace)::TwoLevelIterator::InitDataBlock
                  | | |     + 0.45% rocksdb::BlockBasedTable::NewDataBlockIterator
                  | | |       + 0.45% rocksdb::(anonymous namespace)::ReadBlockFromFile
                  | | |         + 0.45% rocksdb::ReadBlockContents
                  | | |           + 0.45% ReadBlock
                  | | |             + 0.40% rocksdb::RandomAccessFileReader::Read
                  | | |             | + 0.35% BlueRocksRandomAccessFile::Read
                  | | |             | | + 0.35% read_random
                  | | |             | |   + 0.35% BlueFS::_read_random
                  | | |             | |     + 0.35% KernelDevice::read_random
                  | | |             | |       + 0.35% KernelDevice::direct_read_unaligned
                  | | |             | |         + 0.35% pread
                  | | |             | |           + 0.35% pread64
                  | | |             | + 0.05% ~StopWatch
                  | | |             + 0.05% Value
                  | | + 0.05% replace_top
                  | + 0.35% rocksdb::CompactionIterator::NextFromInput
                  |   + 0.20% rocksdb::MergingIterator::Next
                  |   | + 0.20% Next
                  |   |   + 0.15% rocksdb::(anonymous namespace)::TwoLevelIterator::Next
                  |   |   | + 0.15% Next
                  |   |   |   + 0.15% rocksdb::(anonymous namespace)::TwoLevelIterator::SkipEmptyDataBlocksForward
                  |   |   |     + 0.15% rocksdb::(anonymous namespace)::TwoLevelIterator::InitDataBlock
                  |   |   |       + 0.15% rocksdb::BlockBasedTable::NewDataBlockIterator
                  |   |   |         + 0.15% rocksdb::(anonymous namespace)::ReadBlockFromFile
                  |   |   |           + 0.15% rocksdb::ReadBlockContents
                  |   |   |             + 0.15% ReadBlock
                  |   |   |               + 0.15% rocksdb::RandomAccessFileReader::Read
                  |   |   |                 + 0.15% BlueRocksRandomAccessFile::Read
                  |   |   |                   + 0.15% read_random
                  |   |   |                     + 0.15% BlueFS::_read_random
                  |   |   |                       + 0.15% KernelDevice::read_random
                  |   |   |                         + 0.15% KernelDevice::direct_read_unaligned
                  |   |   |                           + 0.15% pread
                  |   |   |                             + 0.15% pread64
                  |   |   + 0.05% rocksdb::(anonymous namespace)::TwoLevelIterator::SkipEmptyDataBlocksForward
                  |   + 0.05% rocksdb::MergingIterator::value
                  |   + 0.05% rocksdb::Compaction::KeyNotExistsBeyondOutputLevel
                  + 0.35% rocksdb::BlockBasedTableBuilder::Add
                  | + 0.15% rocksdb::BlockBuilder::Add
                  | | + 0.05% std::string::append
                  | | + 0.05% std::string::_M_replace_safe
                  | | + 0.05% difference_offset
                  | + 0.15% rocksdb::BlockBasedTableBuilder::Flush
                  |   + 0.15% rocksdb::WritableFileWriter::Flush
                  |     + 0.10% BlueRocksWritableFile::Flush
                  |       + 0.10% flush
                  |         + 0.10% BlueFS::_flush
                  |           + 0.10% BlueFS::_flush_range
                  |             + 0.10% KernelDevice::aio_write
                  |               + 0.10% ceph::buffer::list::rebuild_aligned_size_and_memory
                  |                 + 0.10% ceph::buffer::list::rebuild
                  |                   + 0.10% __memcpy_ssse3_back
                  + 0.05% rocksdb::BlockBasedTableBuilder::FileSize
                  + 0.05% UpdateBoundaries

Thread: 46

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% KernelDevice::AioCompletionThread::entry
      + 100.00% KernelDevice::_aio_thread
        + 99.40% FS::aio_queue_t::get_next_completed
        | + 99.40% __io_getevents_0_4
        + 0.60% aio_wake
          + 0.55% std::condition_variable::notify_all
          | + 0.55% __gthread_cond_broadcast
          |   + 0.55% pthread_cond_broadcast@@GLIBC_2.3.2
          + 0.05% _ZNSt18condition_variable10notify_allEv@plt

Thread: 47

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% KernelDevice::AioCompletionThread::entry
      + 100.00% KernelDevice::_aio_thread
        + 100.00% FS::aio_queue_t::get_next_completed
          + 100.00% __io_getevents_0_4

Thread: 48

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% KernelDevice::AioCompletionThread::entry
      + 100.00% KernelDevice::_aio_thread
        + 100.00% FS::aio_queue_t::get_next_completed
          + 100.00% __io_getevents_0_4

Thread: 49

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% KernelDevice::AioCompletionThread::entry
      + 100.00% KernelDevice::_aio_thread
        + 100.00% FS::aio_queue_t::get_next_completed
          + 100.00% __io_getevents_0_4

Thread: 50

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 100.00% Wait
          + 100.00% pthread_cond_wait@@GLIBC_2.3.2

Thread: 51

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 100.00% WaitUntil
          + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 52

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% SafeTimerThread::entry
      + 100.00% SafeTimer::timer_thread
        + 100.00% WaitUntil
          + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 53

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% std::(anonymous namespace)::execute_native_thread_routine
      + 100.00% ceph::timer_detail::timer<ceph::time_detail::mono_clock>::timer_thread
        + 100.00% wait_until<ceph::time_detail::mono_clock, std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
          + 100.00% __wait_until_impl<std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
            + 100.00% __gthread_cond_timedwait
              + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 54

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% AdminSocket::entry
      + 100.00% poll
        + 100.00% poll

Thread: 55

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% CephContextServiceThread::entry
      + 100.00% WaitInterval
        + 100.00% WaitUntil
          + 100.00% pthread_cond_timedwait@@GLIBC_2.3.2

Thread: 56

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% std::(anonymous namespace)::execute_native_thread_routine
      + 100.00% NetworkStack::__lambda4::operator()
        + 100.00% EventCenter::process_events
          + 100.00% EpollDriver::event_wait
            + 100.00% epoll_wait

Thread: 57

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% std::(anonymous namespace)::execute_native_thread_routine
      + 100.00% NetworkStack::__lambda4::operator()
        + 100.00% EventCenter::process_events
          + 90.45% EpollDriver::event_wait
          | + 90.35% epoll_wait
          | + 0.05% resize
          + 4.65% AsyncConnection::process
          | + 1.80% DispatchQueue::fast_dispatch
          | | + 1.70% ms_fast_dispatch
          | | | + 1.60% OSD::ms_fast_dispatch
          | | | | + 0.80% OSD::enqueue_op
          | | | | | + 0.70% queue
          | | | | | | + 0.70% OSD::ShardedOpWQ::_enqueue
          | | | | | |   + 0.45% SignalOne
          | | | | | |   | + 0.45% pthread_cond_signal@@GLIBC_2.3.2
          | | | | | |   + 0.10% WeightedPriorityQueue<std::pair<spg_t, PGQueueable>, entity_inst_t>::enqueue
          | | | | | |   + 0.05% ceph::logging::SubsystemMap::should_gather
          | | | | | + 0.05% mark_queued_for_pg
          | | | | | + 0.05% make_pair<spg_t&, PGQueueable>
          | | | | + 0.70% create_request<OpRequest, Message*>
          | | | | | + 0.40% OpRequest::OpRequest
          | | | | | | + 0.30% TrackedOp
          | | | | | | | + 0.20% std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string
          | | | | | | | | + 0.20% _S_construct<char const*>
          | | | | | | | |   + 0.20% _S_construct_aux<char const*>
          | | | | | | | |     + 0.20% std::string::_S_construct<char const*>
          | | | | | | | |       + 0.05% std::string::_Rep::_S_create
          | | | | | | | |       + 0.05% _ZNSs4_Rep9_S_createEmmRKSaIcE@plt
          | | | | | | | |       + 0.05% _M_set_length_and_sharable
          | | | | | | | + 0.10% Mutex::Mutex
          | | | | | | |   + 0.05% std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string
          | | | | | | |   + 0.05% __GI___pthread_mutex_init
          | | | | | | + 0.10% TrackedOp::mark_event
          | | | | | + 0.25% tracking_start
          | | | | | | + 0.15% OpTracker::register_inflight_op
          | | | | | | | + 0.10% ~RLocker
          | | | | | | | | + 0.10% unlock
          | | | | | | | |   + 0.05% read
          | | | | | | | |   + 0.05% pthread_rwlock_unlock
          | | | | | | | + 0.05% inc
          | | | | | | + 0.10% Event
          | | | | | + 0.05% operator->
          | | | | + 0.05% maybe_inject_dispatch_delay
          | | | + 0.05% ceph_clock_now
          | | | + 0.05% OSD::ms_can_fast_dispatch
          | | + 0.05% DispatchQueue::post_dispatch
          | + 1.35% AsyncConnection::read_until
          | | + 1.10% AsyncConnection::read_bulk
          | | | + 1.10% read
          | | |   + 1.05% PosixConnectedSocketImpl::read
          | | |     + 1.00% read
          | | |       + 1.00% read
          | | + 0.15% memcpy
          | |   + 0.15% __memcpy_ssse3_back
          | + 0.30% Throttle::get_or_fail
          | | + 0.05% ~Locker
          | | + 0.05% PerfCounters::inc
          | + 0.15% decode_message
          | | + 0.10% MOSDOp::MOSDOp
          | | | + 0.10% MOSDFastDispatchOp
          | | |   + 0.10% Message::Message
          | | |     + 0.05% memset
          | | |     + 0.05% list
          | | + 0.05% tc_new
          | + 0.15% ceph::buffer::create
          | | + 0.15% ceph::buffer::create_aligned
          | |   + 0.15% create
          | |     + 0.15% allocate_aligned
          | |       + 0.15% tc_posix_memalign
          | |         + 0.15% do_memalign_or_cpp_memalign
          | |           + 0.15% (anonymous namespace)::do_memalign
          | |             + 0.15% do_malloc
          | |               + 0.15% do_malloc_no_errno
          | |                 + 0.10% do_malloc_small
          | |                 | + 0.10% Allocate
          | |                 |   + 0.10% Pop
          | |                 |     + 0.10% SLL_Pop
          | |                 |       + 0.05% SLL_Next
          | |                 + 0.05% MinSizeForSlowPath
          | + 0.10% std::mutex::lock
          | | + 0.10% __gthread_mutex_lock
          | |   + 0.05% __GI___pthread_mutex_lock
          | + 0.10% now
          | | + 0.10% clock_gettime
          | |   + 0.05% clock_gettime
          | + 0.10% ceph::buffer::list::clear
          | | + 0.05% clear
          | + 0.05% set
          | + 0.05% ms_fast_preprocess
          | + 0.05% ceph_crc32c
          | + 0.05% ceph_clock_now
          | + 0.05% ceph::logging::SubsystemMap::should_gather
          | + 0.05% ceph::buffer::list::push_back
          | + 0.05% alloc_aligned_buffer
          | + 0.05% PerfCounters::inc
          + 4.15% AsyncConnection::handle_write
          | + 3.10% AsyncConnection::write_message
          | | + 2.45% AsyncConnection::_try_send
          | | | + 2.45% send
          | | |   + 2.45% PosixConnectedSocketImpl::send
          | | |     + 2.45% do_sendmsg
          | | |       + 2.45% sendmsg
          | | + 0.25% RefCountedObject::put
          | | | + 0.25% MOSDOpReply::~MOSDOpReply
          | | |   + 0.20% ~MOSDOpReply
          | | |     + 0.10% ~vector
          | | |     | + 0.05% ~_Vector_base
          | | |     | + 0.05% _Destroy<OSDOp*, OSDOp>
          | | |     + 0.10% Message::~Message
          | | |       + 0.05% ~list
          | | |       + 0.05% ~intrusive_ptr
          | | + 0.20% ceph::buffer::list::append
          | | | + 0.10% create
          | | | | + 0.10% allocate_aligned
          | | | |   + 0.10% tc_posix_memalign
          | | | |     + 0.10% do_memalign_or_cpp_memalign
          | | | |       + 0.10% (anonymous namespace)::do_memalign
          | | | |         + 0.10% do_malloc
          | | | |           + 0.10% do_malloc_no_errno
          | | | |             + 0.10% do_malloc_small
          | | | |               + 0.10% Allocate
          | | | |                 + 0.10% Pop
          | | | |                   + 0.10% SLL_Pop
          | | | + 0.05% ceph::buffer::list::append
          | | + 0.05% calc_header_crc
          | | + 0.05% PerfCounters::inc
          | + 0.75% AsyncConnection::prepare_send_message
          | | + 0.70% Message::encode
          | |   + 0.45% MOSDOpReply::encode_payload
          | |   | + 0.45% encode
          | |   |   + 0.30% encode
          | |   |   | + 0.25% encode
          | |   |   | | + 0.10% encode
          | |   |   | | | + 0.10% encode_raw<ceph_le32>
          | |   |   | | |   + 0.10% ceph::buffer::list::append
          | |   |   | | |     + 0.10% create
          | |   |   | | |       + 0.10% allocate_aligned
          | |   |   | | |         + 0.10% tc_posix_memalign
          | |   |   | | |           + 0.10% do_memalign_or_cpp_memalign
          | |   |   | | |             + 0.10% (anonymous namespace)::do_memalign
          | |   |   | | |               + 0.10% do_malloc
          | |   |   | | |                 + 0.10% do_malloc_no_errno
          | |   |   | | |                   + 0.05% do_malloc_small
          | |   |   | | |                   + 0.05% MinSizeForSlowPath
          | |   |   | | + 0.10% ceph::buffer::list::append
          | |   |   | | | + 0.10% ceph::buffer::ptr::append
          | |   |   | | |   + 0.10% maybe_inline_memcpy
          | |   |   | | |     + 0.10% memcpy
          | |   |   | | |       + 0.10% __memcpy_ssse3_back
          | |   |   | | + 0.05% encode_raw<ceph_le32>
          | |   |   | + 0.05% ceph::buffer::list::append
          | |   |   + 0.10% encode_raw<ceph_le32>
          | |   |   | + 0.10% ceph::buffer::list::append
          | |   |   |   + 0.05% ceph::buffer::ptr::append
          | |   |   + 0.05% encode_raw<ceph_le64>
          | |   + 0.15% MPGStats::encode_payload
          | |   | + 0.15% encode<pg_t, pg_stat_t, std::less<pg_t>, std::allocator<std::pair<pg_t const, pg_stat_t> >, denc_traits<pg_t, void>, denc_traits<pg_stat_t, void> >
          | |   |   + 0.15% encode
          | |   |     + 0.15% pg_stat_t::encode
          | |   |       + 0.10% encode
          | |   |       | + 0.05% encode_raw<ceph_le64>
          | |   |       | + 0.05% encode
          | |   |       + 0.05% encode<std::vector<int>, denc_traits<std::vector<int>, void> >
          | |   + 0.05% calc_front_crc
          | + 0.25% _get_next_outgoing
          |   + 0.15% erase
          |   | + 0.10% _M_erase
          |   | | + 0.05% std::__detail::_List_node_base::_M_unhook
          |   | | + 0.05% _M_put_node
          |   | + 0.05% std::_Rb_tree<int, std::pair<int const, std::list<std::pair<ceph::buffer::list, Message*>, std::allocator<std::pair<ceph::buffer::list, Message*> > > >, std::_Select1st<std::pair<int const, std::list<std::pair<ceph::buffer::list, Message*>, std::allocator<std::pair<ceph::buffer::list, Message*> > > > >, std::less<int>, std::allocator<std::pair<int const, std::list<std::pair<ceph::buffer::list, Message*>, std::allocator<std::pair<ceph::buffer::list, Message*> > > > > >::erase
          |   + 0.05% operator->
          |   + 0.05% ceph::buffer::list::swap
          + 0.45% C_handle_notify::do_request
          | + 0.45% read
          |   + 0.45% read
          + 0.10% now
          | + 0.10% clock_gettime
          |   + 0.10% clock_gettime
          + 0.05% deque
          + 0.05% C_handle_write::do_request
          + 0.05% C_handle_read::do_request

Thread: 58

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% std::(anonymous namespace)::execute_native_thread_routine
      + 100.00% NetworkStack::__lambda4::operator()
        + 100.00% EventCenter::process_events
          + 100.00% EpollDriver::event_wait
            + 100.00% epoll_wait

Thread: 59

+ 100.00% clone
  + 100.00% start_thread
    + 100.00% ceph::logging::Log::entry
      + 100.00% pthread_cond_wait@@GLIBC_2.3.2


--------------470B0810B708A68700828AE5--
