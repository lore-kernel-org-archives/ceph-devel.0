From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: ceph-mds crash v12.0.3
Date: Mon, 12 Jun 2017 12:13:59 +0300
Message-ID: <eaf869fc-892f-a8e1-fea3-2661ce7f401e@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ns.unixsol.org ([193.110.159.2]:53338 "EHLO ns.unixsol.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752312AbdFLJTC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Jun 2017 05:19:02 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We started getting these on all of our 3 MDS-es. Any idea how to fix it or at least debug
it and remove the dir entries that are causing the problem?

[root@amssn3 ~]# yum info ceph-mds
Name        : ceph-mds
Arch        : x86_64
Epoch       : 1
Version     : 12.0.3
Release     : 0.el7

Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: *** Caught signal (Segmentation fault) **
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: in thread 7f9e0ae70700 thread_name:mds_rank_progr
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: ceph version 12.0.3 (f2337d1b42fa49dbb0a93e4048a42762e3dffbbf)
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 1: (()+0x563caf) [0x7f9e16d46caf]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 2: (()+0xf370) [0x7f9e148cc370]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 3: (Server::handle_client_readdir(boost::intrusive_ptr<MDRequestImpl>&)+0xbb9) [0x7f9e16ac3559]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 4: (Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl>&)+0x9b1) [0x7f9e16af2231]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 5: (MDSInternalContextBase::complete(int)+0x1eb) [0x7f9e16cd1bcb]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 6: (MDSRank::_advance_queues()+0x4a5) [0x7f9e16a7e375]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 7: (MDSRank::ProgressThread::entry()+0x4a) [0x7f9e16a7e7ea]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 8: (()+0x7dc5) [0x7f9e148c4dc5]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 9: (clone()+0x6d) [0x7f9e137a476d]
Jun 12 04:11:39 amssn1.sgvps.net ceph-mds[3532]: 2017-06-12 04:11:39.585944 7f9e0ae70700 -1 *** Caught signal (Segmentation fault) **


Jun 12 03:36:19 amssn3.sgvps.net ceph-mds[3503]: ceph version 12.0.3 (f2337d1b42fa49dbb0a93e4048a42762e3dffbbf)
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 1: (()+0x563caf) [0x7f24fe425caf]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 2: (()+0xf370) [0x7f24fbfab370]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 3: (Server::handle_client_readdir(boost::intrusive_ptr<MDRequestImpl>&)+0xbb9) [0x7f24fe1a2559]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 4: (Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl>&)+0x9b1) [0x7f24fe1d1231]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 5: (Server::handle_client_request(MClientRequest*)+0x48d) [0x7f24fe1d1a6d]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 6: (Server::dispatch(Message*)+0x38b) [0x7f24fe1d619b]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 7: (MDSRank::handle_deferrable_message(Message*)+0x7fc) [0x7f24fe152bbc]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 8: (MDSRank::_dispatch(Message*, bool)+0x1eb) [0x7f24fe15db4b]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 9: (MDSRankDispatcher::ms_dispatch(Message*)+0x15) [0x7f24fe15ea95]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 10: (MDSDaemon::ms_dispatch(Message*)+0xf3) [0x7f24fe14a7c3]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 11: (DispatchQueue::entry()+0x7a2) [0x7f24fe6a9a02]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 12: (DispatchQueue::DispatchThread::entry()+0xd) [0x7f24fe4dd23d]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 13: (()+0x7dc5) [0x7f24fbfa3dc5]
Jun 12 03:36:19 amssn3 ceph-mds[3503]: 14: (clone()+0x6d) [0x7f24fae8376d]


Jun 12 04:01:33 amssn5 ceph-mds[2544]: starting mds.amssn5 at -
Jun 12 04:01:43 amssn5 ceph-mds[2544]: *** Caught signal (Segmentation fault) **
Jun 12 04:01:43 amssn5 ceph-mds[2544]: in thread 7f45d2595700 thread_name:mds_rank_progr
Jun 12 04:01:43 amssn5 ceph-mds[2544]: ceph version 12.0.3 (f2337d1b42fa49dbb0a93e4048a42762e3dffbbf)
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 1: (()+0x563caf) [0x7f45de46bcaf]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 2: (()+0xf370) [0x7f45dbff1370]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 3: (Server::handle_client_readdir(boost::intrusive_ptr<MDRequestImpl>&)+0xbb9) [0x7f45de1e8559]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 4: (Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl>&)+0x9b1) [0x7f45de217231]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 5: (MDSInternalContextBase::complete(int)+0x1eb) [0x7f45de3f6bcb]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 6: (MDSRank::_advance_queues()+0x4a5) [0x7f45de1a3375]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 7: (MDSRank::ProgressThread::entry()+0x4a) [0x7f45de1a37ea]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 8: (()+0x7dc5) [0x7f45dbfe9dc5]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 9: (clone()+0x6d) [0x7f45daec976d]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 2017-06-12 04:01:43.579491 7f45d2595700 -1 *** Caught signal (Segmentation fault) **
Jun 12 04:01:43 amssn5 ceph-mds[2544]: in thread 7f45d2595700 thread_name:mds_rank_progr
Jun 12 04:01:43 amssn5 ceph-mds[2544]: ceph version 12.0.3 (f2337d1b42fa49dbb0a93e4048a42762e3dffbbf)
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 1: (()+0x563caf) [0x7f45de46bcaf]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 2: (()+0xf370) [0x7f45dbff1370]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 3: (Server::handle_client_readdir(boost::intrusive_ptr<MDRequestImpl>&)+0xbb9) [0x7f45de1e8559]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 4: (Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl>&)+0x9b1) [0x7f45de217231]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 5: (MDSInternalContextBase::complete(int)+0x1eb) [0x7f45de3f6bcb]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 6: (MDSRank::_advance_queues()+0x4a5) [0x7f45de1a3375]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 7: (MDSRank::ProgressThread::entry()+0x4a) [0x7f45de1a37ea]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 8: (()+0x7dc5) [0x7f45dbfe9dc5]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 9: (clone()+0x6d) [0x7f45daec976d]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 0> 2017-06-12 04:01:43.579491 7f45d2595700 -1 *** Caught signal (Segmentation fault) **
Jun 12 04:01:43 amssn5 ceph-mds[2544]: in thread 7f45d2595700 thread_name:mds_rank_progr
Jun 12 04:01:43 amssn5 ceph-mds[2544]: ceph version 12.0.3 (f2337d1b42fa49dbb0a93e4048a42762e3dffbbf)
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 1: (()+0x563caf) [0x7f45de46bcaf]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 2: (()+0xf370) [0x7f45dbff1370]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 3: (Server::handle_client_readdir(boost::intrusive_ptr<MDRequestImpl>&)+0xbb9) [0x7f45de1e8559]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 4: (Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl>&)+0x9b1) [0x7f45de217231]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 5: (MDSInternalContextBase::complete(int)+0x1eb) [0x7f45de3f6bcb]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 6: (MDSRank::_advance_queues()+0x4a5) [0x7f45de1a3375]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 7: (MDSRank::ProgressThread::entry()+0x4a) [0x7f45de1a37ea]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 8: (()+0x7dc5) [0x7f45dbfe9dc5]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: 9: (clone()+0x6d) [0x7f45daec976d]
Jun 12 04:01:43 amssn5 ceph-mds[2544]: NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
