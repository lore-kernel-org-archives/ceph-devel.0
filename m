From: Linux Chips <linux.chips@gmail.com>
Subject: Re: High memory usage kills OSD while peering
Date: Mon, 21 Aug 2017 13:48:07 +0300
Message-ID: <d767c5fb-5381-15d4-6e18-fb34638e589d@gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
 <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
 <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com>
 <CAGtbiz1eHTiaO4pWu4sU97E8N+=DthTXjbY_Ga9CONW862y2XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38083 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdHUKsL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Aug 2017 06:48:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id k10so4323072wre.5
        for <ceph-devel@vger.kernel.org>; Mon, 21 Aug 2017 03:48:10 -0700 (PDT)
In-Reply-To: <CAGtbiz1eHTiaO4pWu4sU97E8N+=DthTXjbY_Ga9CONW862y2XQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JDQvdCz0LDQv9C+0LI=?= <angapov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Vasily;
well, we are trying to get help from Red Hat. but that will take some time.
any idea of what they have changed in there? what was the cause of 
stopping the cluster? any info might be helpful here.

thanks

On 08/18/2017 05:02 PM, Василий Ангапов wrote:
> Hi,
>
> We had exactly the same problem like you, we stopped the whole cluster 
> and then we were unable to start because of OSDs getting OOMed. We 
> have 10 nodes with 29 OSDs each, 1.5 PB of raw space with erasure 
> coding 6+3. We had 10.2.3 community Ceph version.
> We had nodes with 192 GB RAM each, we then increased RAM to 1TB and 
> slowly were starting OSDs one by one, but still at some point 
> everything went down very quickly.
> We requested paid help from Red Hat and after some time they produced 
> a special patch for us with version 10.2.3-374-gc3d3a11 
> (c3d3a11c068ee2fbab73208c3d5e01ba2f86afc4). After that memory 
> consumption went back to normal and we were able to start cluster.
> Not sure this is exactly your problem but the symptoms are very much 
> the same. I can elaborate more on that if you like.
>
> Regards, Vasily.
>
>
> 2017-08-18 0:21 GMT+05:30 Linux Chips <linux.chips@gmail.com 
> <mailto:linux.chips@gmail.com>>:
>
>
>
>     On 08/17/2017 08:53 PM, Gregory Farnum wrote:
>
>         On Thu, Aug 17, 2017 at 7:13 AM, Linux Chips
>         <linux.chips@gmail.com <mailto:linux.chips@gmail.com>> wrote:
>
>             Hello everybody,
>             I have Kraken cluster with 660 OSD, currently it is down
>             due to not
>             being able to complete peering, OSDs start consuming lots
>             of memory
>             draining the system and killing the node, so I set a limit
>             on the OSD
>             service (on some OSDs 28G and others as high as 35G), so
>             they get
>             killed before taking down the whole node.
>             Now I still can't peer, one OSD entering the cluster (with
>             about 300
>             already up) makes memory usage of most other OSDs so high
>             (15G+, some as
>             much as 30G) and
>             sometimes kills them when they reach the service limit.
>             which cause a spiral
>             load and causing all the OSDs to consume all the available.
>
>             I found this thread with similar symptoms:
>
>             http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-April/017522.html
>             <http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-April/017522.html>
>
>             with a request for stack trace, I have a 14G core dump, we
>             generated it by
>             running the osd from the terminal, enabling the core
>             dumps, and setting
>             ulimits to 15G. what kind of a trace would be useful? all
>             thread?! any
>             better way to debug this?
>
>             What can I do do make it work, is this memory allocation
>             normal?
>
>             some info about the cluster:
>             41 hdd nodes with 12 x 4TB osd each, 5 of the nodes have
>             8TB disks. 324 GB
>             RAM and dula socket intel xeon.
>             7 nodes with 400GB x 24 ssd and 256GB RAM, and dual socket
>             cpu.
>             3 monitors
>
>             all dual 10GB ethernet, except for the monitor with dual
>             1GB ethers.
>
>             all nodes running centos 7.2
>             it is an old cluster that was upgraded continuously for
>             the past 3 years.
>             the cluster was on jewel when the issue happened due to
>             some accidental OSD
>             map changes, causing a heavy recovery operations on the
>             cluster. then we
>             upgraded to kraken in the hope of less memory foot prints.
>
>             any advice on how to proceed?
>
>         It's not normal but if something really bad happened to your
>         cluster,
>         it's been known to occur. You should go through the
>         troubleshooting
>         guides at docs.ceph.com <http://docs.ceph.com>, but the
>         general strategy is to set
>         nodown/noout/etc flags, undo whatever horrible thing you tried
>         to make
>         the map do, and then turn all the OSDs back on.
>         -Greg
>
>
>     Hi,
>     we have been trying this for the past week, it keeps consuming the
>     RAM.
>     we got the map back to the original places. marked all the flags,
>     started all the OSDs. then "ceph osd unset noup", wait 5 min, and
>     all OSDs are killed by the oom.
>     we tried one node at a time, let it finish recovering, and start
>     the next. we got to a point when we started the next node, every
>     thing got killed.
>     we tried one OSD at a time, same result. one OSD up, ~40 killed by
>     oom, then it is a snow ball from here until all of the active OSDs
>     get kiiled.
>
>     I think all this up/down that we generated has increased the
>     recovery too much. btw, we stopped all clients. and also we have
>     some not so friendly erasure pools. some OSDs now report loading
>     as much as 800 pg, while we originally had about 300-400 (I know
>     too much, but we were trying to fix it and.... well we could not).
>
>     we did a memory profiling on one of the OSDs.
>     here is the results
>
>
>      12878.6  47.6%  47.6%  12878.6  47.6% std::_Rb_tree::_M_create_node
>      12867.6  47.6%  95.2%  25746.2  95.2% std::_Rb_tree::_M_copy
>        532.4   2.0%  97.2%    686.3   2.5% OSD::heartbeat
>        122.8   0.5%  97.7%    122.8   0.5%
>     std::_Rb_tree::_M_emplace_hint_unique
>        121.9   0.5%  98.1%    171.1   0.6% AsyncConnection::send_message
>        104.2   0.4%  98.5%    104.2   0.4%
>     ceph::buffer::list::append@c4a770
>         99.7   0.4%  98.9%     99.7   0.4% std::vector::_M_default_append
>         99.6   0.4%  99.2%     99.6   0.4%
>     ceph::logging::Log::create_entry
>         72.6   0.3%  99.5%     72.6   0.3% ceph::buffer::create_aligned
>         52.4   0.2%  99.7%     52.5   0.2%
>     std::vector::_M_emplace_back_aux
>         23.9   0.1%  99.8%     57.8   0.2% OSD::do_notifies
>         17.0   0.1%  99.8%     23.1   0.1%
>     OSDService::build_incremental_map_msg
>          9.8   0.0%  99.9%    222.5   0.8% std::enable_if::type decode
>          6.2   0.0%  99.9%      6.3   0.0% std::map::operator[]
>          5.5   0.0%  99.9%      5.5   0.0% std::vector::vector
>          3.5   0.0%  99.9%      3.5   0.0% EventCenter::create_time_event
>          2.5   0.0%  99.9%      2.5   0.0%
>     AsyncConnection::AsyncConnection
>          2.4   0.0% 100.0%      2.4   0.0% std::string::_Rep::_S_create
>          1.5   0.0% 100.0%      1.5   0.0% std::_Rb_tree::_M_insert_unique
>          1.4   0.0% 100.0%      1.4   0.0% std::list::operator=
>          1.3   0.0% 100.0%      1.3   0.0% ceph::buffer::list::list
>          0.9   0.0% 100.0%    204.1   0.8% decode_message
>          0.8   0.0% 100.0%      0.8   0.0% OSD::send_failures
>          0.7   0.0% 100.0%      0.9   0.0% void decode
>          0.6   0.0% 100.0%      0.6   0.0% std::_Rb_tree::_M_insert_equal
>          0.6   0.0% 100.0%      2.5   0.0% PG::queue_null
>          0.6   0.0% 100.0%      1.8   0.0% AsyncMessenger::create_connect
>          0.6   0.0% 100.0%      1.8   0.0% AsyncMessenger::add_accept
>          0.5   0.0% 100.0%      0.5   0.0% boost::statechart::event::clone
>          0.4   0.0% 100.0%      0.4   0.0% PG::queue_peering_event
>          0.3   0.0% 100.0%      0.3   0.0% OSD::PeeringWQ::_enqueue
>          0.3   0.0% 100.0%    148.6   0.5% OSD::_dispatch
>          0.1   0.0% 100.0%    147.9   0.5% OSD::handle_osd_map
>          0.1   0.0% 100.0%      0.1   0.0% std::deque::_M_push_back_aux
>          0.1   0.0% 100.0%      0.2   0.0% SharedLRU::add
>          0.1   0.0% 100.0%      0.1   0.0% OSD::PeeringWQ::_dequeue
>          0.1   0.0% 100.0%      0.1   0.0%
>     ceph::buffer::list::append@c4a9b0
>          0.1   0.0% 100.0%      0.2   0.0% DispatchQueue::enqueue
>          0.1   0.0% 100.0%    283.5   1.0% EventCenter::process_events
>          0.1   0.0% 100.0%      0.1   0.0% HitSet::Params::create_impl
>          0.1   0.0% 100.0%      0.1   0.0% SimpleLRU::clear_pinned
>          0.0   0.0% 100.0%      0.0   0.0% std::_Rb_tree::_M_insert_
>          0.0   0.0% 100.0%      0.2   0.0% TrackedOp::mark_event
>          0.0   0.0% 100.0%      0.0   0.0% OSD::create_context
>          0.0   0.0% 100.0%      0.0   0.0%
>     std::_Hashtable::_M_allocate_node
>          0.0   0.0% 100.0%      0.0   0.0% OSDMap::OSDMap
>          0.0   0.0% 100.0%    281.6   1.0% AsyncConnection::process
>          0.0   0.0% 100.0%  25802.4  95.4%
>     PG::RecoveryState::RecoveryMachine::send_notify
>          0.0   0.0% 100.0%      0.0   0.0% SharedLRU::lru_add
>          0.0   0.0% 100.0%      0.0   0.0%
>     std::_Rb_tree::_M_insert_unique_
>          0.0   0.0% 100.0%      0.1   0.0%
>     OpTracker::unregister_inflight_op
>          0.0   0.0% 100.0%      0.0   0.0% OSD::ms_verify_authorizer
>          0.0   0.0% 100.0%      0.0   0.0% OSDService::_add_map
>          0.0   0.0% 100.0%      0.1   0.0% OSD::wait_for_new_map
>          0.0   0.0% 100.0%      0.5   0.0% OSD::handle_pg_notify
>          0.0   0.0% 100.0%      0.0   0.0%
>     std::__shared_count::__shared_count
>          0.0   0.0% 100.0%      0.0   0.0% std::__shared_ptr::reset
>          0.0   0.0% 100.0%     35.1   0.1% OSDMap::decode@b84080
>          0.0   0.0% 100.0%      0.0   0.0%
>     std::_Rb_tree::_M_emplace_unique
>          0.0   0.0% 100.0%      0.0   0.0% std::vector::operator=
>          0.0   0.0% 100.0%      0.0   0.0% MonClient::_renew_subs
>          0.0   0.0% 100.0%      0.0   0.0% std::_Hashtable::_M_emplace
>          0.0   0.0% 100.0%      0.0   0.0% PORT_Alloc_Util
>          0.0   0.0% 100.0%      0.0   0.0% CryptoAES::get_key_handler
>          0.0   0.0% 100.0%      0.0   0.0% get_auth_session_handler
>          0.0   0.0% 100.0%      0.0   0.0% PosixWorker::connect
>          0.0   0.0% 100.0%      0.0   0.0%
>     ceph::buffer::list::append@c4a440
>          0.0   0.0% 100.0%      0.0   0.0% std::vector::_M_fill_insert
>          0.0   0.0% 100.0%      4.8   0.0% AsyncConnection::fault
>          0.0   0.0% 100.0%      0.0   0.0% OSD::send_pg_stats
>          0.0   0.0% 100.0%      0.0   0.0% AsyncMessenger::accept_conn
>          0.0   0.0% 100.0%      0.0   0.0% PosixServerSocketImpl::accept
>          0.0   0.0% 100.0%      9.3   0.0%
>     AsyncConnection::_process_connection
>          0.0   0.0% 100.0%      0.2   0.0% FileStore::lfn_open
>          0.0   0.0% 100.0%      0.0   0.0%
>     ceph::buffer::list::append@c4a350
>          0.0   0.0% 100.0%      0.0   0.0% crush_create
>          0.0   0.0% 100.0%      0.1   0.0% MgrClient::send_report
>          0.0   0.0% 100.0%      0.0   0.0% WBThrottle::queue_wb
>          0.0   0.0% 100.0%      0.2   0.0% LogClient::_get_mon_log_message
>          0.0   0.0% 100.0%      0.0   0.0% CryptoKey::_set_secret
>          0.0   0.0% 100.0%      0.0   0.0%
>     std::_Deque_base::_M_initialize_map
>          0.0   0.0% 100.0%      0.1   0.0%
>     ThreadPool::BatchWorkQueue::_void_dequeue
>          0.0   0.0% 100.0%      0.0   0.0% ceph::Formatter::create@ba6a50
>          0.0   0.0% 100.0%      0.0   0.0% MonClient::schedule_tick
>          0.0   0.0% 100.0%      0.1   0.0% OSD::tick
>          0.0   0.0% 100.0%     37.6   0.1% OSD::tick_without_osd_lock
>          0.0   0.0% 100.0%      0.0   0.0%
>     boost::spirit::classic::impl::get_definition
>          0.0   0.0% 100.0%      9.4   0.0% MonClient::_send_mon_message
>          0.0   0.0% 100.0%      0.0   0.0% DispatchQueue::queue_refused
>          0.0   0.0% 100.0%      0.0   0.0% OSD::handle_command
>          0.0   0.0% 100.0%      0.0   0.0% DispatchQueue::queue_accept
>          0.0   0.0% 100.0%      0.0   0.0% AsyncConnection::_connect
>          0.0   0.0% 100.0%      0.0   0.0% AsyncConnection::_stop
>          0.0   0.0% 100.0%      0.0   0.0% AsyncConnection::accept
>          0.0   0.0% 100.0%      0.0   0.0%
>     AsyncConnection::handle_connect_msg
>          0.0   0.0% 100.0%      0.0   0.0% AsyncConnection::mark_down
>          0.0   0.0% 100.0%      0.0   0.0%
>     AsyncConnection::prepare_send_message
>          0.0   0.0% 100.0%      0.0   0.0% AsyncConnection::read_bulk
>          0.0   0.0% 100.0%      0.0   0.0% AsyncConnection::read_until
>          0.0   0.0% 100.0%      0.0   0.0% AsyncConnection::send_keepalive
>          0.0   0.0% 100.0%      3.3   0.0% AsyncConnection::wakeup_from
>          0.0   0.0% 100.0%      1.8   0.0% AsyncMessenger::get_connection
>          0.0   0.0% 100.0%      0.0   0.0% AsyncMessenger::reap_dead
>          0.0   0.0% 100.0%      2.5   0.0% C_OnMapCommit::finish
>          0.0   0.0% 100.0%      0.0   0.0%
>     CephXTicketHandler::verify_service_ticket_reply
>          0.0   0.0% 100.0%      0.0   0.0%
>     CephXTicketManager::verify_service_ticket_reply
>          0.0   0.0% 100.0%      0.0   0.0%
>     CephxAuthorizeHandler::verify_authorizer
>          0.0   0.0% 100.0%      0.0   0.0%
>     CephxClientHandler::handle_response
>          0.0   0.0% 100.0%     40.9   0.2% Context::complete
>          0.0   0.0% 100.0%      4.8   0.0% CrushWrapper::encode
>          0.0   0.0% 100.0%      0.0   0.0% CryptoAESKeyHandler::decrypt
>          0.0   0.0% 100.0%      0.0   0.0% CryptoKey::decode
>          0.0   0.0% 100.0%    160.4   0.6%
>     DispatchQueue::DispatchThread::entry
>          0.0   0.0% 100.0%    160.4   0.6% DispatchQueue::entry
>          0.0   0.0% 100.0%      0.4   0.0% DispatchQueue::fast_dispatch
>          0.0   0.0% 100.0%      0.4   0.0% DispatchQueue::pre_dispatch
>          0.0   0.0% 100.0%      0.0   0.0% EntityName::set
>          0.0   0.0% 100.0%      0.0   0.0% EpollDriver::event_wait
>          0.0   0.0% 100.0%      3.0   0.0%
>     EventCenter::dispatch_event_external
>          0.0   0.0% 100.0%      3.3   0.0%
>     EventCenter::process_time_events
>          0.0   0.0% 100.0%      3.0   0.0% EventCenter::wakeup
>          0.0   0.0% 100.0%      0.0   0.0% FileJournal::prepare_entry
>          0.0   0.0% 100.0%      0.2   0.0% FileStore::_do_op
>          0.0   0.0% 100.0%      0.2   0.0% FileStore::_do_transaction
>          0.0   0.0% 100.0%      0.2   0.0% FileStore::_do_transactions
>          0.0   0.0% 100.0%      0.0   0.0% FileStore::_journaled_ahead
>          0.0   0.0% 100.0%      0.2   0.0% FileStore::_write
>          0.0   0.0% 100.0%      0.0   0.0% FileStore::queue_transactions
>          0.0   0.0% 100.0%      2.6   0.0% Finisher::finisher_thread_entry
>          0.0   0.0% 100.0%      0.1   0.0% FunctionContext::finish
>          0.0   0.0% 100.0%      0.1   0.0% HitSet::Params::decode
>          0.0   0.0% 100.0%      0.2   0.0% LogChannel::do_log@a90a00
>          0.0   0.0% 100.0%      0.3   0.0% LogChannel::do_log@a91030
>          0.0   0.0% 100.0%      0.2   0.0% LogClient::get_mon_log_message
>          0.0   0.0% 100.0%      0.0   0.0% LogClient::handle_log_ack
>          0.0   0.0% 100.0%      0.1   0.0% LogClient::queue
>          0.0   0.0% 100.0%      0.3   0.0% LogClientTemp::~LogClientTemp
>          0.0   0.0% 100.0%      0.0   0.0% MAuthReply::decode_payload
>          0.0   0.0% 100.0%      0.0   0.0% MCommand::decode_payload
>          0.0   0.0% 100.0%      0.0   0.0% MCommand::print
>          0.0   0.0% 100.0%      0.0   0.0% MMgrMap::decode_payload
>          0.0   0.0% 100.0%      0.0   0.0% MOSDFailure::print
>          0.0   0.0% 100.0%      0.1   0.0% MOSDMap::decode_payload
>          0.0   0.0% 100.0%    203.1   0.8% MOSDPGNotify::decode_payload
>          0.0   0.0% 100.0%      0.0   0.0% MOSDPGNotify::print
>          0.0   0.0% 100.0%      0.0   0.0% MOSDPing::encode_payload
>          0.0   0.0% 100.0%      0.0   0.0% Message::encode
>          0.0   0.0% 100.0%      0.0   0.0% MgrClient::handle_mgr_map
>          0.0   0.0% 100.0%      0.0   0.0% MgrClient::ms_dispatch
>          0.0   0.0% 100.0%      0.0   0.0% MgrMap::decode
>          0.0   0.0% 100.0%      0.0   0.0% MonClient::_check_auth_rotating
>          0.0   0.0% 100.0%      0.0   0.0% MonClient::_check_auth_tickets
>          0.0   0.0% 100.0%      0.0   0.0% MonClient::_finish_hunting
>          0.0   0.0% 100.0%      0.8   0.0%
>     MonClient::_reopen_session@aeab80
>          0.0   0.0% 100.0%      0.6   0.0%
>     MonClient::_reopen_session@af2ba0
>          0.0   0.0% 100.0%      9.5   0.0% MonClient::handle_auth
>          0.0   0.0% 100.0%      9.6   0.0% MonClient::ms_dispatch
>          0.0   0.0% 100.0%      0.2   0.0% MonClient::send_log
>          0.0   0.0% 100.0%      0.6   0.0% MonClient::tick
>          0.0   0.0% 100.0%    283.5   1.0% NetworkStack::get_worker
>          0.0   0.0% 100.0%      0.0   0.0% OSD::CommandWQ::_process
>          0.0   0.0% 100.0%  25862.5  95.7% OSD::PeeringWQ::_process
>          0.0   0.0% 100.0%      0.0   0.0% OSD::Session::Session
>          0.0   0.0% 100.0%    686.3   2.5% OSD::T_Heartbeat::entry
>          0.0   0.0% 100.0%      2.5   0.0% OSD::_committed_osd_maps
>          0.0   0.0% 100.0%  25804.6  95.5% OSD::advance_pg
>          0.0   0.0% 100.0%      0.3   0.0% OSD::check_ops_in_flight
>          0.0   0.0% 100.0%      0.0   0.0% OSD::check_osdmap_features
>          0.0   0.0% 100.0%      2.5   0.0% OSD::consume_map
>          0.0   0.0% 100.0%     57.8   0.2% OSD::dispatch_context
>          0.0   0.0% 100.0%      0.5   0.0% OSD::dispatch_op
>          0.0   0.0% 100.0%      0.0   0.0% OSD::do_command
>          0.0   0.0% 100.0%      0.2   0.0% OSD::do_waiters
>          0.0   0.0% 100.0%      0.0   0.0% OSD::get_osdmap_pobject_name
>          0.0   0.0% 100.0%      0.1   0.0% OSD::handle_osd_ping
>          0.0   0.0% 100.0%      0.0   0.0% OSD::handle_pg_peering_evt
>          0.0   0.0% 100.0%     37.2   0.1% OSD::heartbeat_check
>          0.0   0.0% 100.0%      0.1   0.0% OSD::heartbeat_dispatch
>          0.0   0.0% 100.0%    686.3   2.5% OSD::heartbeat_entry
>          0.0   0.0% 100.0%      1.1   0.0% OSD::heartbeat_reset
>          0.0   0.0% 100.0%    148.7   0.6% OSD::ms_dispatch
>          0.0   0.0% 100.0%      0.8   0.0% OSD::ms_handle_connect
>          0.0   0.0% 100.0%      0.0   0.0% OSD::ms_handle_refused
>          0.0   0.0% 100.0%      0.0   0.0% OSD::ms_handle_reset
>          0.0   0.0% 100.0%  25862.5  95.7% OSD::process_peering_events
>          0.0   0.0% 100.0%      0.1   0.0% OSD::require_same_or_newer_map
>          0.0   0.0% 100.0%      0.0   0.0% OSD::write_superblock
>          0.0   0.0% 100.0%      0.0   0.0% OSDCap::parse
>          0.0   0.0% 100.0%      0.0   0.0% OSDMap::Incremental::decode
>          0.0   0.0% 100.0%     35.1   0.1% OSDMap::decode@b85440
>          0.0   0.0% 100.0%    110.8   0.4% OSDMap::encode
>          0.0   0.0% 100.0%      0.5   0.0% OSDMap::post_decode
>          0.0   0.0% 100.0%      0.1   0.0% OSDService::_get_map_bl
>          0.0   0.0% 100.0%      0.0   0.0%
>     OSDService::check_nearfull_warning
>          0.0   0.0% 100.0%      0.1   0.0%
>     OSDService::clear_map_bl_cache_pins
>          0.0   0.0% 100.0%      1.1   0.0% OSDService::get_con_osd_hb
>          0.0   0.0% 100.0%      1.3   0.0% OSDService::get_inc_map_bl
>          0.0   0.0% 100.0%      1.3   0.0% OSDService::pin_map_bl
>          0.0   0.0% 100.0%      0.0   0.0% OSDService::pin_map_inc_bl
>          0.0   0.0% 100.0%      0.0   0.0% OSDService::publish_superblock
>          0.0   0.0% 100.0%      0.3   0.0% OSDService::queue_for_peering
>          0.0   0.0% 100.0%     27.2   0.1%
>     OSDService::send_incremental_map
>          0.0   0.0% 100.0%     27.2   0.1% OSDService::share_map_peer
>          0.0   0.0% 100.0%      0.0   0.0% OSDService::update_osd_stat
>          0.0   0.0% 100.0%      0.0   0.0%
>     ObjectStore::Transaction::_get_coll_id
>          0.0   0.0% 100.0%      0.0   0.0%
>     ObjectStore::Transaction::_get_next_op
>          0.0   0.0% 100.0%      0.2   0.0% ObjectStore::Transaction::write
>          0.0   0.0% 100.0%      0.0   0.0% ObjectStore::queue_transaction
>          0.0   0.0% 100.0%      0.0   0.0% Objecter::_maybe_request_map
>          0.0   0.0% 100.0%      0.1   0.0% Objecter::handle_osd_map
>          0.0   0.0% 100.0%      0.1   0.0% OpHistory::insert
>          0.0   0.0% 100.0%      0.0   0.0% OpRequest::OpRequest
>          0.0   0.0% 100.0%      0.1   0.0% OpRequest::mark_flag_point
>          0.0   0.0% 100.0%      0.1   0.0% OpRequest::mark_started
>          0.0   0.0% 100.0%      0.1   0.0%
>     OpTracker::RemoveOnDelete::operator
>          0.0   0.0% 100.0%      0.1   0.0% OpTracker::_mark_event
>          0.0   0.0% 100.0%      0.0   0.0% OpTracker::get_age_ms_histogram
>          0.0   0.0% 100.0%  25802.4  95.4% PG::RecoveryState::Stray::react
>          0.0   0.0% 100.0%      0.0   0.0% PG::_prepare_write_info
>          0.0   0.0% 100.0%  25802.4  95.4% PG::handle_activate_map
>          0.0   0.0% 100.0%      1.6   0.0% PG::handle_advance_map
>          0.0   0.0% 100.0%      0.0   0.0% PG::prepare_write_info
>          0.0   0.0% 100.0%      0.0   0.0% PG::write_if_dirty
>          0.0   0.0% 100.0%      1.6   0.0% PGPool::update
>          0.0   0.0% 100.0%      0.0   0.0% PK11_FreeSymKey
>          0.0   0.0% 100.0%      0.0   0.0% PK11_GetIVLength
>          0.0   0.0% 100.0%      0.0   0.0% PK11_ImportSymKey
>          0.0   0.0% 100.0%      0.0   0.0% PrebufferedStreambuf::overflow
>          0.0   0.0% 100.0%      1.8   0.0% Processor::accept
>          0.0   0.0% 100.0%      0.0   0.0% SECITEM_CopyItem_Util
>          0.0   0.0% 100.0%      0.0   0.0% SafeTimer::add_event_after
>          0.0   0.0% 100.0%      0.0   0.0% SafeTimer::add_event_at
>          0.0   0.0% 100.0%     38.4   0.1% SafeTimer::timer_thread
>          0.0   0.0% 100.0%     38.4   0.1% SafeTimerThread::entry
>          0.0   0.0% 100.0%  25862.7  95.7% ThreadPool::WorkThread::entry
>          0.0   0.0% 100.0%  25862.7  95.7% ThreadPool::worker
>          0.0   0.0% 100.0%  27023.8 100.0% __clone
>          0.0   0.0% 100.0%      0.0   0.0%
>     boost::detail::function::void_function_obj_invoker2::invoke
>          0.0   0.0% 100.0%      0.0   0.0%
>     boost::proto::detail::default_assign::impl::operator
>          0.0   0.0% 100.0%      0.0   0.0%
>     boost::spirit::classic::impl::concrete_parser::do_parse_virtual
>          0.0   0.0% 100.0%      0.0   0.0%
>     boost::spirit::qi::action::parse
>          0.0   0.0% 100.0%      0.3   0.0%
>     boost::statechart::event_base::intrusive_from_this
>          0.0   0.0% 100.0%  25802.4  95.4%
>     boost::statechart::simple_state::react_impl
>          0.0   0.0% 100.0%  25802.4  95.4%
>     boost::statechart::state_machine::send_event
>          0.0   0.0% 100.0%      0.0   0.0% ceph::Formatter::create@48b620
>          0.0   0.0% 100.0%      0.4   0.0%
>     ceph::buffer::list::contiguous_appender::contiguous_appender
>          0.0   0.0% 100.0%      2.4   0.0% ceph::buffer::list::crc32c
>          0.0   0.0% 100.0%      0.1   0.0%
>     ceph::buffer::list::iterator_impl::copy
>          0.0   0.0% 100.0%      0.0   0.0%
>     ceph::buffer::list::iterator_impl::copy_deep
>          0.0   0.0% 100.0%      5.7   0.0%
>     ceph::buffer::list::iterator_impl::copy_shallow
>          0.0   0.0% 100.0%      0.0   0.0% ceph::buffer::ptr::ptr
>          0.0   0.0% 100.0%      0.0   0.0%
>     ceph_heap_profiler_handle_command
>          0.0   0.0% 100.0%      0.0   0.0% ceph_os_fremovexattr
>          0.0   0.0% 100.0%      0.0   0.0% cephx_verify_authorizer
>          0.0   0.0% 100.0%      0.0   0.0% cmdmap_from_json
>          0.0   0.0% 100.0%      2.2   0.0% crush_hash_name
>          0.0   0.0% 100.0%      0.1   0.0% decode
>          0.0   0.0% 100.0%     20.1   0.1% entity_addr_t::encode
>          0.0   0.0% 100.0%      0.0   0.0% get_str_vec
>          0.0   0.0% 100.0%      0.0   0.0% int decode_decrypt@c15110
>          0.0   0.0% 100.0%      0.0   0.0% int decode_decrypt@c15b90
>          0.0   0.0% 100.0%      0.0   0.0%
>     json_spirit::Semantic_actions::new_name
>          0.0   0.0% 100.0%      0.0   0.0%
>     json_spirit::Semantic_actions::new_str
>          0.0   0.0% 100.0%      1.1   0.0%
>     json_spirit::Value_impl::get_uint64
>          0.0   0.0% 100.0%      0.0   0.0% json_spirit::get_str
>          0.0   0.0% 100.0%      0.0   0.0% json_spirit::get_str_
>          0.0   0.0% 100.0%      0.0   0.0% json_spirit::read
>          0.0   0.0% 100.0%      0.0   0.0% json_spirit::read_range
>          0.0   0.0% 100.0%      0.0   0.0%
>     json_spirit::read_range_or_throw
>          0.0   0.0% 100.0%      0.0   0.0%
>     json_spirit::substitute_esc_chars
>          0.0   0.0% 100.0%      0.0   0.0% operator<<@a91e90
>          0.0   0.0% 100.0%      3.5   0.0% osd_info_t::encode
>          0.0   0.0% 100.0%      4.4   0.0% osd_xinfo_t::encode
>          0.0   0.0% 100.0%      0.1   0.0% pg_info_t::decode
>          0.0   0.0% 100.0%      0.0   0.0% pg_info_t::operator=
>          0.0   0.0% 100.0%      9.9   0.0% pg_info_t::pg_info_t
>          0.0   0.0% 100.0%     87.5   0.3% pg_interval_t::decode
>          0.0   0.0% 100.0%      1.0   0.0% pg_pool_t::decode
>          0.0   0.0% 100.0%      1.8   0.0% pg_pool_t::encode
>          0.0   0.0% 100.0%      0.0   0.0% pg_stat_t::decode
>          0.0   0.0% 100.0%  27032.1 100.0% start_thread
>          0.0   0.0% 100.0%      1.3   0.0% std::_Rb_tree::operator=
>          0.0   0.0% 100.0%      0.1   0.0%
>     std::_Sp_counted_base::_M_release
>          0.0   0.0% 100.0%      0.0   0.0%
>     std::__detail::_Map_base::operator[]
>          0.0   0.0% 100.0%      0.0   0.0% std::__ostream_insert
>          0.0   0.0% 100.0%      0.1   0.0% std::basic_streambuf::xsputn
>          0.0   0.0% 100.0%      0.1   0.0% std::basic_string::basic_string
>          0.0   0.0% 100.0%      0.0   0.0% std::basic_stringbuf::overflow
>          0.0   0.0% 100.0%      1.0   0.0% std::basic_stringbuf::str
>          0.0   0.0% 100.0%     71.0   0.3% std::enable_if::type encode
>          0.0   0.0% 100.0%      0.1   0.0% std::getline
>          0.0   0.0% 100.0%      0.0   0.0% std::num_put::_M_insert_int
>          0.0   0.0% 100.0%      0.0   0.0% std::num_put::do_put
>          0.0   0.0% 100.0%      0.0   0.0% std::operator<<
>          0.0   0.0% 100.0%      0.0   0.0% std::ostream::_M_insert
>          0.0   0.0% 100.0%      1.2   0.0% std::string::_Rep::_M_clone
>          0.0   0.0% 100.0%      1.2   0.0% std::string::_S_construct
>          0.0   0.0% 100.0%      1.2   0.0% std::string::append
>          0.0   0.0% 100.0%      1.2   0.0% std::string::reserve
>          0.0   0.0% 100.0%    283.5   1.0% std::this_thread::__sleep_for
>          0.0   0.0% 100.0%      0.0   0.0% void
>     decode_decrypt_enc_bl@c12db0
>          0.0   0.0% 100.0%      0.0   0.0% void
>     decode_decrypt_enc_bl@c14a80
>          0.0   0.0% 100.0%      0.0   0.0% void
>     decode_decrypt_enc_bl@c15450
>          0.0   0.0% 100.0%     20.1   0.1% void encode
>
>
>     I also generated the PDf with all the charts, but not sure how to
>     share it with you guys.
>     any Idea what is happening here ?
>
>     thanks
>     ali
>
>
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
>
>

