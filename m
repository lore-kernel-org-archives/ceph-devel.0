From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: mds dump
Date: Fri, 08 Jun 2012 03:35:01 -0400 (EDT)
Message-ID: <a1cf1173-9a9c-49b9-8f76-6a8267c692b3@mail.linserv.se>
References: <9CFDA4F85EA1425B888F7F62DA77038E@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:53872 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab2FHHfQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 03:35:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id B5E85E7F2
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 03:35:02 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eXrqUEjlBBhD for <ceph-devel@vger.kernel.org>;
	Fri,  8 Jun 2012 03:35:01 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 9F7DEE7EE
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 03:35:01 -0400 (EDT)
In-Reply-To: <9CFDA4F85EA1425B888F7F62DA77038E@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

And if i just want to mkfs or similar in mds is that possible. Or or my rbd will
also be removed ? Or how should I recover if I don't care of the data in
the POSIX file system ? 

 /Regards Martin 
> 
> On Thursday, June 7, 2012 at 9:53 PM, Martin Wilderoth wrote: 
> > Hello, 
> > 
> > Now my mds are all crashing after a while one by one. 
> > Is it possible to recover without removing my rbd images ? 
> 
> This is a pretty familiar MDS crash that we haven't tracked down yet. Sorry. :( 
> 
> However, it has absolutely no impact on your rbd images, which don't require, use, or in any way interface with the > MDS. :) 
> -Greg 
> 
> > 
> > /Best Regards Martin 
> > 
> > logfile from start to finish 
> > 
> > 2012-06-08 06:46:10.232863 7f999039b700 0 mds.-1.0 ms_handle_connect on 10.0.6.10:6789/0 
> > 2012-06-08 06:46:10.246006 7f999039b700 1 mds.-1.0 handle_mds_map standby 
> > 2012-06-08 06:46:10.275582 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > 2012-06-08 06:46:10.275618 7f999039b700 1 mds.0.34 handle_mds_map state change up:standby --> up:replay 
> > 2012-06-08 06:46:10.275636 7f999039b700 1 mds.0.34 replay_start 
> > 2012-06-08 06:46:10.275720 7f999039b700 1 mds.0.34 recovery set is 
> > 2012-06-08 06:46:10.275725 7f999039b700 1 mds.0.34 need osdmap epoch 1198, have 1197 
> > 2012-06-08 06:46:10.275729 7f999039b700 1 mds.0.34 waiting for osdmap 1198 (which blacklists prior instance) 
> > 2012-06-08 06:46:10.275790 7f999039b700 1 mds.0.cache handle_mds_failure mds.0 : recovery peers are 
> > 2012-06-08 06:46:10.279164 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.12:6801/1398 
> > 2012-06-08 06:46:10.279627 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.11:6804/1490 
> > 2012-06-08 06:46:10.280038 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.10:6801/1381 
> > 2012-06-08 06:46:10.280543 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.13:6803/1413 
> > 2012-06-08 06:46:10.365936 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.10:6804/1484 
> > 2012-06-08 06:46:10.449704 7f999039b700 0 mds.0.cache creating system inode with ino:100 
> > 2012-06-08 06:46:10.449984 7f999039b700 0 mds.0.cache creating system inode with ino:1 
> > 2012-06-08 06:46:10.452571 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.12:6804/1504 
> > 2012-06-08 06:46:10.458633 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.13:6800/1311 
> > 2012-06-08 06:46:10.971680 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.11:6801/1388 
> > 2012-06-08 06:46:13.571500 7f998d68a700 1 mds.0.34 replay_done 
> > 2012-06-08 06:46:13.571532 7f998d68a700 1 mds.0.34 making mds journal writeable 
> > 2012-06-08 06:46:13.585958 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > 2012-06-08 06:46:13.585977 7f999039b700 1 mds.0.34 handle_mds_map state change up:replay --> up:reconnect 
> > 2012-06-08 06:46:13.585985 7f999039b700 1 mds.0.34 reconnect_start 
> > 2012-06-08 06:46:13.585991 7f999039b700 1 mds.0.34 reopen_log 
> > 2012-06-08 06:46:13.586020 7f999039b700 1 mds.0.server reconnect_clients -- 1 sessions 
> > 2012-06-08 06:47:00.238913 7f998ea97700 1 mds.0.server reconnect gave up on client.5316 10.0.5.20:0/2377096102 
> > 2012-06-08 06:47:00.238981 7f998ea97700 1 mds.0.34 reconnect_done 
> > 2012-06-08 06:47:00.244284 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > 2012-06-08 06:47:00.244309 7f999039b700 1 mds.0.34 handle_mds_map state change up:reconnect --> up:rejoin 
> > 2012-06-08 06:47:00.244319 7f999039b700 1 mds.0.34 rejoin_joint_start 
> > 2012-06-08 06:47:00.263998 7f999039b700 1 mds.0.34 rejoin_done 
> > 2012-06-08 06:47:00.281992 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > 2012-06-08 06:47:00.282013 7f999039b700 1 mds.0.34 handle_mds_map state change up:rejoin --> up:active 
> > 2012-06-08 06:47:00.282035 7f999039b700 1 mds.0.34 recovery_done -- successful recovery! 
> > 2012-06-08 06:47:00.292276 7f999039b700 1 mds.0.34 active_start 
> > 2012-06-08 06:47:00.308009 7f999039b700 1 mds.0.34 cluster recovered. 
> > 2012-06-08 06:47:00.434050 7f999039b700 -1 mds/AnchorServer.cc (http://AnchorServer.cc): In function 'void AnchorServer::dec(inodeno_t)' thread 7f999039b700 time 2012-06-08 06:47:00.43086
> > mds/AnchorServer.cc (http://AnchorServer.cc): 98: FAILED assert(anchor_map.count(ino)) 
> > 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > 1: (AnchorServer::dec(inodeno_t)+0x26d) [0x6bf0dd] 
> > 2: (AnchorServer::_commit(unsigned long)+0x55a) [0x6c04ca] 
> > 3: (MDSTableServer::handle_commit(MMDSTableRequest*)+0xcf) [0x6bb86f] 
> > 4: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b1984] 
> > 5: (MDS::_dispatch(Message*)+0xafa) [0x4c61da] 
> > 6: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c73ab] 
> > 7: (SimpleMessenger::dispatch_entry()+0x979) [0x7b4729] 
> > 8: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7365cd] 
> > 9: (()+0x68ca) [0x7f9994e018ca] 
> > 10: (clone()+0x6d) [0x7f999368992d] 
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this. 
> > 
> > --- begin dump of recent events --- 
> > -38> 2012-06-08 06:46:10.227852 7f9995227780 0 ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372), process ceph-mds, pid 8751 
> > -37> 2012-06-08 06:46:10.232863 7f999039b700 0 mds.-1.0 ms_handle_connect on 10.0.6.10:6789/0 
> > -36> 2012-06-08 06:46:10.246006 7f999039b700 1 mds.-1.0 handle_mds_map standby 
> > -35> 2012-06-08 06:46:10.275582 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > -34> 2012-06-08 06:46:10.275618 7f999039b700 1 mds.0.34 handle_mds_map state change up:standby --> up:replay 
> > -33> 2012-06-08 06:46:10.275636 7f999039b700 1 mds.0.34 replay_start 
> > -32> 2012-06-08 06:46:10.275720 7f999039b700 1 mds.0.34 recovery set is 
> > -31> 2012-06-08 06:46:10.275725 7f999039b700 1 mds.0.34 need osdmap epoch 1198, have 1197 
> > -30> 2012-06-08 06:46:10.275729 7f999039b700 1 mds.0.34 waiting for osdmap 1198 (which blacklists prior instance) 
> > -29> 2012-06-08 06:46:10.275790 7f999039b700 1 mds.0.cache handle_mds_failure mds.0 : recovery peers are 
> > -28> 2012-06-08 06:46:10.279164 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.12:6801/1398 
> > -27> 2012-06-08 06:46:10.279627 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.11:6804/1490 
> > -26> 2012-06-08 06:46:10.280038 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.10:6801/1381 
> > -25> 2012-06-08 06:46:10.280543 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.13:6803/1413 
> > -24> 2012-06-08 06:46:10.365936 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.10:6804/1484 
> > -23> 2012-06-08 06:46:10.449704 7f999039b700 0 mds.0.cache creating system inode with ino:100 
> > -22> 2012-06-08 06:46:10.449984 7f999039b700 0 mds.0.cache creating system inode with ino:1 
> > -21> 2012-06-08 06:46:10.452571 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.12:6804/1504 
> > -20> 2012-06-08 06:46:10.458633 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.13:6800/1311 
> > -19> 2012-06-08 06:46:10.971680 7f999039b700 0 mds.0.34 ms_handle_connect on 10.0.6.11:6801/1388 
> > -18> 2012-06-08 06:46:13.571500 7f998d68a700 1 mds.0.34 replay_done 
> > -17> 2012-06-08 06:46:13.571532 7f998d68a700 1 mds.0.34 making mds journal writeable 
> > -16> 2012-06-08 06:46:13.585958 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > -15> 2012-06-08 06:46:13.585977 7f999039b700 1 mds.0.34 handle_mds_map state change up:replay --> up:reconnect 
> > -14> 2012-06-08 06:46:13.585985 7f999039b700 1 mds.0.34 reconnect_start 
> > -13> 2012-06-08 06:46:13.585991 7f999039b700 1 mds.0.34 reopen_log 
> > -12> 2012-06-08 06:46:13.586020 7f999039b700 1 mds.0.server reconnect_clients -- 1 sessions 
> >  -11> 2012-06-08 06:47:00.238913 7f998ea97700 1 mds.0.server reconnect gave up on client.5316 10.0.5.20:0/2377096102 
> > -10> 2012-06-08 06:47:00.238981 7f998ea97700 1 mds.0.34 reconnect_done 
> > -9> 2012-06-08 06:47:00.244284 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > -8> 2012-06-08 06:47:00.244309 7f999039b700 1 mds.0.34 handle_mds_map state change up:reconnect --> up:rejoin 
> > -7> 2012-06-08 06:47:00.244319 7f999039b700 1 mds.0.34 rejoin_joint_start 
> > -6> 2012-06-08 06:47:00.263998 7f999039b700 1 mds.0.34 rejoin_done 
> > -5> 2012-06-08 06:47:00.281992 7f999039b700 1 mds.0.34 handle_mds_map i am now mds.0.34 
> > -4> 2012-06-08 06:47:00.282013 7f999039b700 1 mds.0.34 handle_mds_map state change up:rejoin --> up:active 
> > -3> 2012-06-08 06:47:00.282035 7f999039b700 1 mds.0.34 recovery_done -- successful recovery! 
> > -2> 2012-06-08 06:47:00.292276 7f999039b700 1 mds.0.34 active_start 
> >  -1> 2012-06-08 06:47:00.308009 7f999039b700 1 mds.0.34 cluster recovered. 
> > 0> 2012-06-08 06:47:00.434050 7f999039b700 -1 mds/AnchorServer.cc (http://AnchorServer.cc): In function 'void AnchorServer::dec(inodeno_t)' thread 7f999039b700 time 2012-06-08 06:47:00.430863 
> > mds/AnchorServer.cc (http://AnchorServer.cc): 98: FAILED assert(anchor_map.count(ino)) 
> > 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > 1: (AnchorServer::dec(inodeno_t)+0x26d) [0x6bf0dd] 
> > 2: (AnchorServer::_commit(unsigned long)+0x55a) [0x6c04ca] 
> > 3: (MDSTableServer::handle_commit(MMDSTableRequest*)+0xcf) [0x6bb86f] 
> > 4: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b1984] 
> > 5: (MDS::_dispatch(Message*)+0xafa) [0x4c61da] 
> > 6: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c73ab] 
> > 7: (SimpleMessenger::dispatch_entry()+0x979) [0x7b4729] 
> > 8: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7365cd] 
> > 9: (()+0x68ca) [0x7f9994e018ca] 
> > 10: (clone()+0x6d) [0x7f999368992d] 
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this. 
> > 
> > --- end dump of recent events --- 
> > 2012-06-08 06:47:00.438584 7f999039b700 -1 *** Caught signal (Aborted) ** 
> > in thread 7f999039b700 
> > 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > 1: /usr/bin/ceph-mds() [0x81da89] 
> > 2: (()+0xeff0) [0x7f9994e09ff0] 
> > 3: (gsignal()+0x35) [0x7f99935ec1b5] 
> > 4: (abort()+0x180) [0x7f99935eefc0] 
> > 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f9993e80dc5] 
> > 6: (()+0xcb166) [0x7f9993e7f166] 
> > 7: (()+0xcb193) [0x7f9993e7f193] 
> > 8: (()+0xcb28e) [0x7f9993e7f28e] 
> > 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x940) [0x7555f0] 
> > 10: (AnchorServer::dec(inodeno_t)+0x26d) [0x6bf0dd] 
> > 11: (AnchorServer::_commit(unsigned long)+0x55a) [0x6c04ca] 
> > 12: (MDSTableServer::handle_commit(MMDSTableRequest*)+0xcf) [0x6bb86f] 
> > 13: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b1984] 
> > 14: (MDS::_dispatch(Message*)+0xafa) [0x4c61da] 
> > 15: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c73ab] 
> > 16: (SimpleMessenger::dispatch_entry()+0x979) [0x7b4729] 
> > 17: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7365cd] 
> > 18: (()+0x68ca) [0x7f9994e018ca] 
> > 19: (clone()+0x6d) [0x7f999368992d] 
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this. 
> > 
> > --- begin dump of recent events --- 
> > 0> 2012-06-08 06:47:00.438584 7f999039b700 -1 *** Caught signal (Aborted) ** 
> > in thread 7f999039b700 
> > 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > 1: /usr/bin/ceph-mds() [0x81da89] 
> > 2: (()+0xeff0) [0x7f9994e09ff0] 
> > 3: (gsignal()+0x35) [0x7f99935ec1b5] 
> > 4: (abort()+0x180) [0x7f99935eefc0] 
> > 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f9993e80dc5] 
> > 6: (()+0xcb166) [0x7f9993e7f166] 
> > 7: (()+0xcb193) [0x7f9993e7f193] 
> > 8: (()+0xcb28e) [0x7f9993e7f28e] 
> > 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x940) [0x7555f0] 
> > 10: (AnchorServer::dec(inodeno_t)+0x26d) [0x6bf0dd] 
> > 11: (AnchorServer::_commit(unsigned long)+0x55a) [0x6c04ca] 
> > 12: (MDSTableServer::handle_commit(MMDSTableRequest*)+0xcf) [0x6bb86f] 
> > 13: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b1984] 
> > 14: (MDS::_dispatch(Message*)+0xafa) [0x4c61da] 
> > 15: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c73ab] 
> > 16: (SimpleMessenger::dispatch_entry()+0x979) [0x7b4729] 
> > 17: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7365cd] 
> > 18: (()+0x68ca) [0x7f9994e018ca] 
> > 19: (clone()+0x6d) [0x7f999368992d] 
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this. 
> > 
> > --- end dump of recent events --- 
> > -- 
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
> > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org) 
> > More majordomo info at http://vger.kernel.org/majordomo-info.html 
