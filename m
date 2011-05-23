From: Sage Weil <sage@newdream.net>
Subject: Re: MDS crash
Date: Mon, 23 May 2011 15:27:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105231526470.30953@cobra.newdream.net>
References: <4DDACFF0.5060902@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60883 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab1EWW0J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 18:26:09 -0400
In-Reply-To: <4DDACFF0.5060902@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi Fyodor,

This looks like #1104.  Will try to sort it out today, it should be a 
simple one.

sage


On Tue, 24 May 2011, Fyodor Ustinov wrote:

> Hi.
> 
> 2011-05-24 00:17:45.490684 7f45415e1740 ceph version 0.28.commit:
> 071881d7e5599571e46bda17094bb4b48691e89a. process: cmds. pid: 4424
> 2011-05-24 00:17:45.492293 7f453ef81700 mds-1.0 ms_handle_connect on
> 77.120.112.193:6789/0
> 2011-05-24 00:17:49.497862 7f453ef81700 mds-1.0 handle_mds_map standby
> 2011-05-24 00:17:53.274911 7f453ef81700 mds0.5 handle_mds_map i am now mds0.5
> 2011-05-24 00:17:53.274939 7f453ef81700 mds0.5 handle_mds_map state change
> up:standby --> up:replay
> 2011-05-24 00:17:53.274951 7f453ef81700 mds0.5 replay_start
> 2011-05-24 00:17:53.274962 7f453ef81700 mds0.5  recovery set is
> 2011-05-24 00:17:53.274969 7f453ef81700 mds0.5  need osdmap epoch 104, have
> 103
> 2011-05-24 00:17:53.274985 7f453ef81700 mds0.5  waiting for osdmap 104 (which
> blacklists prior instance)
> 2011-05-24 00:17:53.275016 7f453ef81700 mds0.cache handle_mds_failure mds0 :
> recovery peers are
> 2011-05-24 00:17:53.276145 7f453ef81700 mds0.5 ms_handle_connect on
> 77.120.112.201:6800/29765
> 2011-05-24 00:17:53.276223 7f453ef81700 mds0.5 ms_handle_connect on
> 82.144.220.71:6800/5210
> 2011-05-24 00:17:53.276785 7f453ef81700 mds0.5 ms_handle_connect on
> 82.144.220.72:6800/3960
> 2011-05-24 00:17:53.301249 7f453ef81700 mds0.5 ms_handle_connect on
> 82.144.220.70:6800/25341
> 2011-05-24 00:17:53.307286 7f453ef81700 mds0.cache creating system inode with
> ino:100
> 2011-05-24 00:17:53.307441 7f453ef81700 mds0.cache creating system inode with
> ino:1
> 2011-05-24 00:17:53.308273 7f453ef81700 mds0.5 ms_handle_connect on
> 77.120.112.200:6800/9187
> 2011-05-24 00:17:54.506400 7f4537fff700 mds0.5 replay_done
> 2011-05-24 00:17:54.506431 7f4537fff700 mds0.5 making mds journal writeable
> 2011-05-24 00:17:54.511104 7f453ef81700 mds0.5 handle_mds_map i am now mds0.5
> 2011-05-24 00:17:54.511127 7f453ef81700 mds0.5 handle_mds_map state change
> up:replay --> up:reconnect
> 2011-05-24 00:17:54.511138 7f453ef81700 mds0.5 reconnect_start
> 2011-05-24 00:17:54.511144 7f453ef81700 mds0.5 reopen_log
> 2011-05-24 00:17:54.511163 7f453ef81700 mds0.server reconnect_clients -- 1
> sessions
> 2011-05-24 00:17:54.511832 7f453c472700 -- 77.120.112.193:6800/4424 >>
> 77.120.112.209:0/3638704563 pipe(0x10f8370 sd=11 pgs=0 cs=0 l=0).accept peer
> addr is really 77.120.112.209:0/3638704563 (socket is 77.120.112.209:38599/0)
> 2011-05-24 00:17:54.512859 7f453ef81700 log [DBG] : reconnect by client4404
> 77.120.112.209:0/3638704563 after 0.001651
> 2011-05-24 00:17:54.513057 7f453ef81700 mds0.server missing 1000000860a
> #10000008019/vtapes/drive0/data (mine), will load later
> 2011-05-24 00:17:54.513091 7f453ef81700 mds0.5 reconnect_done
> 2011-05-24 00:17:54.515176 7f453ef81700 mds0.5 handle_mds_map i am now mds0.5
> 2011-05-24 00:17:54.515193 7f453ef81700 mds0.5 handle_mds_map state change
> up:reconnect --> up:rejoin
> 2011-05-24 00:17:54.515201 7f453ef81700 mds0.5 rejoin_joint_start
> 2011-05-24 00:17:54.522602 7f453ef81700 mds0.5 rejoin_done
> 2011-05-24 00:17:54.528794 7f453ef81700 mds0.5 handle_mds_map i am now mds0.5
> 2011-05-24 00:17:54.528812 7f453ef81700 mds0.5 handle_mds_map state change
> up:rejoin --> up:active
> 2011-05-24 00:17:54.528819 7f453ef81700 mds0.5 recovery_done -- successful
> recovery!
> 2011-05-24 00:17:54.529315 7f453ef81700 mds0.5 active_start
> 2011-05-24 00:17:54.531405 7f453ef81700 mds0.5 cluster recovered.
> *** Caught signal (Segmentation fault) **
>  in thread 0x7f453ef81700
>  ceph version 0.28 (commit:071881d7e5599571e46bda17094bb4b48691e89a)
>  1: /usr/bin/cmds() [0x712c5e]
>  2: (()+0xfc60) [0x7f45411c0c60]
>  3: (MDCache::get_or_create_stray_dentry(CInode*)+0x25) [0x5356f5]
>  4: (Server::handle_client_unlink(MDRequest*)+0x997) [0x508857]
>  5: (Server::handle_client_request(MClientRequest*)+0x522) [0x520852]
>  6: (MDS::handle_deferrable_message(Message*)+0x9af) [0x4a266f]
>  7: (MDS::_dispatch(Message*)+0x173e) [0x4b617e]
>  8: (MDS::_dispatch(Message*)+0x427) [0x4b4e67]
>  9: (MDS::ms_dispatch(Message*)+0x59) [0x4b66c9]
>  10: (SimpleMessenger::dispatch_entry()+0x7ea) [0x4838aa]
>  11: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x47b26c]
>  12: (()+0x6d8c) [0x7f45411b7d8c]
>  13: (clone()+0x6d) [0x7f454006a04d]
> 
> WBR,
>     Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
