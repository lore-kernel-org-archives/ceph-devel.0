From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: BUG: crash in mds after recovery
Date: Sat, 23 Jul 2011 09:01:03 -0600
Message-ID: <CALFpzo4Kd=vRGvcTu+bCR3c6pBMVQ5miROhwTVrk0c41L3JGwQ@mail.gmail.com>
References: <CALFpzo5ARRawUpcYGkzt=P7C+yqyF3PU8xmXS+Z-a1Vi6=e9uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60563 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab1GWPBE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jul 2011 11:01:04 -0400
Received: by wwe5 with SMTP id 5so2953523wwe.1
        for <ceph-devel@vger.kernel.org>; Sat, 23 Jul 2011 08:01:03 -0700 (PDT)
In-Reply-To: <CALFpzo5ARRawUpcYGkzt=P7C+yqyF3PU8xmXS+Z-a1Vi6=e9uQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In browsing this code it became obvious to me that this had something
to do with the snapshots, so I should mention that I did have two
snapshots created on my ceph filesystem.  I started fresh last night,
this time with a hard disk journal, and ran through the same steps:
mount filesystem, copy a few files, snapshot, delete a few files,
another snapshot, delete a few more, restart an mds, and bam, mds
won't stay up.

After looking through the code this morning and seeing that it was
looking for snapshot head, I continually restarted all of the mds
nodes until eventually the client connected long enough to delete the
snapshots. After that everything was fine.

On Fri, Jul 22, 2011 at 11:28 PM, Marcus Sorensen <shadowsor@gmail.com>=
 wrote:
> Should these be reported here or perhaps through the tracker? Just a
> warning, I'm going to purposely be trying to break things and figurin=
g
> out how to recover (or at least what never to do :), so now's probabl=
y
> a good time to set me straight on procedure.
>
> i was fiddling with my test cluster tonight and ran into this.
> Basically I decided to reboot the cluster, and after reboot I had to
> play a bit with the journals to get things going again. I didn't
> realize that putting them on tmpfs would require me to touch the file=
,
> pull down the monmap, run 'cosd -i <num> --monmap <monmap>
> --mkjournal' before the osds could come online. For some reason I had
> the impression it would create the journal... I did something like
> 'service ceph start', saw that the osd was mounted but cosd failed,
> pulled monmap, recreated journal, then 'service ceph start osd.<num>'=
=2E
> After getting these online I noticed the mds services were crashing o=
n
> all three nodes like so. Notice also that there were some clients
> connected prior.
>
> [root@ceph3 ~]# 2011-07-22 23:03:57.640115 7f27d02cd700 mds-1.0
> handle_mds_map standby
> 2011-07-22 23:04:21.928388 7f27d02cd700 mds-1.0 handle_mds_map standb=
y
> 2011-07-22 23:04:22.164395 7f27d02cd700 mds-1.0 handle_mds_map standb=
y
> 2011-07-22 23:04:37.634939 7f27d02cd700 mds0.22 handle_mds_map i am n=
ow mds0.22
> 2011-07-22 23:04:37.634967 7f27d02cd700 mds0.22 handle_mds_map state
> change up:standby --> up:replay
> 2011-07-22 23:04:37.634975 7f27d02cd700 mds0.22 replay_start
> 2011-07-22 23:04:37.634984 7f27d02cd700 mds0.22 =A0recovery set is
> 2011-07-22 23:04:37.634990 7f27d02cd700 mds0.22 =A0need osdmap epoch =
131, have 128
> 2011-07-22 23:04:37.634995 7f27d02cd700 mds0.22 =A0waiting for osdmap
> 131 (which blacklists prior instance)
> 2011-07-22 23:04:37.635027 7f27d02cd700 mds0.cache handle_mds_failure
> mds0 : recovery peers are
> 2011-07-22 23:04:37.644053 7f27d02cd700 mds0.22 ms_handle_connect on
> 10.10.10.93:6801/3468
> 2011-07-22 23:04:37.649460 7f27d02cd700 mds0.22 ms_handle_connect on
> 10.10.10.91:6801/4314
> 2011-07-22 23:04:37.654568 7f27d02cd700 mds0.22 ms_handle_connect on
> 10.10.10.92:6803/4193
> 2011-07-22 23:04:37.725419 7f27d02cd700 mds0.cache creating system
> inode with ino:100
> 2011-07-22 23:04:37.725542 7f27d02cd700 mds0.cache creating system
> inode with ino:1
> 2011-07-22 23:04:39.223574 7f27cdbc2700 mds0.22 replay_done
> 2011-07-22 23:04:39.223636 7f27cdbc2700 mds0.22 making mds journal wr=
iteable
> 2011-07-22 23:04:39.239472 7f27d02cd700 mds0.22 handle_mds_map i am n=
ow mds0.22
> 2011-07-22 23:04:39.239768 7f27d02cd700 mds0.22 handle_mds_map state
> change up:replay --> up:reconnect
> 2011-07-22 23:04:39.239981 7f27d02cd700 mds0.22 reconnect_start
> 2011-07-22 23:04:39.240187 7f27d02cd700 mds0.22 reopen_log
> 2011-07-22 23:04:39.240399 7f27d02cd700 mds0.server reconnect_clients
> -- 3 sessions
> 2011-07-22 23:05:27.040962 7f27cf0c9700 mds0.server reconnect gave up
> on client4108 10.10.10.99:0/1929168255
> 2011-07-22 23:05:27.041021 7f27cf0c9700 mds0.server reconnect gave up
> on client4906 10.10.10.99:0/3243338282
> 2011-07-22 23:05:27.041038 7f27cf0c9700 mds0.server reconnect gave up
> on client5114 10.10.10.99:0/2910973772
> 2011-07-22 23:05:27.041104 7f27cf0c9700 mds0.22 reconnect_done
> 2011-07-22 23:05:27.061458 7f27d02cd700 mds0.22 handle_mds_map i am n=
ow mds0.22
> 2011-07-22 23:05:27.061480 7f27d02cd700 mds0.22 handle_mds_map state
> change up:reconnect --> up:rejoin
> 2011-07-22 23:05:27.061490 7f27d02cd700 mds0.22 rejoin_joint_start
> 2011-07-22 23:05:27.161091 7f27d02cd700 mds0.22 rejoin_done
> 2011-07-22 23:05:27.181033 7f27d02cd700 mds0.22 handle_mds_map i am n=
ow mds0.22
> 2011-07-22 23:05:27.181092 7f27d02cd700 mds0.22 handle_mds_map state
> change up:rejoin --> up:active
> 2011-07-22 23:05:27.181107 7f27d02cd700 mds0.22 recovery_done --
> successful recovery!
> 2011-07-22 23:05:27.188878 7f27d02cd700 mds0.22 active_start
> 2011-07-22 23:05:27.191328 7f27d02cd700 mds0.22 cluster recovered.
> mds/Locker.cc: In function 'bool Locker::issue_caps(CInode*,
> Capability*)', in thread '0x7f27d02cd700'
> mds/Locker.cc: 1459: FAILED assert(in->is_head())
> =A0ceph version 0.31 (commit:9019c6ce64053ad515a493e912e2e63ba9b8e278=
)
> =A01: (Locker::issue_caps(CInode*, Capability*)+0x1a0c) [0x5b25dc]
> =A02: (Locker::issue_caps_set(std::set<CInode*, std::less<CInode*>,
> std::allocator<CInode*> >&)+0x26) [0x5b3ff6]
> =A03: (Locker::file_update_finish(CInode*, Mutation*, bool, client_t,
> Capability*, MClientCaps*)+0x665) [0x5c2a45]
> =A04: (C_Locker_FileUpdate_finish::finish(int)+0x2c) [0x5d6b1c]
> =A05: (finish_contexts(CephContext*, std::list<Context*,
> std::allocator<Context*> >&, int)+0xd0) [0x591250]
> =A06: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x20e) [=
0x6ac6be]
> =A07: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xa8e) [0x69290e]
> =A08: (MDS::handle_core_message(Message*)+0x86f) [0x49e67f]
> =A09: (MDS::_dispatch(Message*)+0x2aa) [0x49e99a]
> =A010: (MDS::ms_dispatch(Message*)+0x6d) [0x4a060d]
> =A011: (SimpleMessenger::dispatch_entry()+0x8a1) [0x6f45b1]
> =A012: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4806ac]
> =A013: (()+0x77e1) [0x7f27d354a7e1]
> =A014: (clone()+0x6d) [0x7f27d2b048ed]
> =A0ceph version 0.31 (commit:9019c6ce64053ad515a493e912e2e63ba9b8e278=
)
> =A01: (Locker::issue_caps(CInode*, Capability*)+0x1a0c) [0x5b25dc]
> =A02: (Locker::issue_caps_set(std::set<CInode*, std::less<CInode*>,
> std::allocator<CInode*> >&)+0x26) [0x5b3ff6]
> =A03: (Locker::file_update_finish(CInode*, Mutation*, bool, client_t,
> Capability*, MClientCaps*)+0x665) [0x5c2a45]
> =A04: (C_Locker_FileUpdate_finish::finish(int)+0x2c) [0x5d6b1c]
> =A05: (finish_contexts(CephContext*, std::list<Context*,
> std::allocator<Context*> >&, int)+0xd0) [0x591250]
> =A06: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x20e) [=
0x6ac6be]
> =A07: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xa8e) [0x69290e]
> =A08: (MDS::handle_core_message(Message*)+0x86f) [0x49e67f]
> =A09: (MDS::_dispatch(Message*)+0x2aa) [0x49e99a]
> =A010: (MDS::ms_dispatch(Message*)+0x6d) [0x4a060d]
> =A011: (SimpleMessenger::dispatch_entry()+0x8a1) [0x6f45b1]
> =A012: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4806ac]
> =A013: (()+0x77e1) [0x7f27d354a7e1]
> =A014: (clone()+0x6d) [0x7f27d2b048ed]
> *** Caught signal (Aborted) **
> =A0in thread 0x7f27d02cd700
> =A0ceph version 0.31 (commit:9019c6ce64053ad515a493e912e2e63ba9b8e278=
)
> =A01: /usr/bin/cmds() [0x747ea9]
> =A02: (()+0xf4c0) [0x7f27d35524c0]
> =A03: (gsignal()+0x35) [0x7f27d2a559a5]
> =A04: (abort()+0x175) [0x7f27d2a57185]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7f27d32faaa=
d]
> =A06: (()+0xbcc36) [0x7f27d32f8c36]
> =A07: (()+0xbcc63) [0x7f27d32f8c63]
> =A08: (()+0xbcd5e) [0x7f27d32f8d5e]
> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x3a7) [0x6c6a47]
> =A010: (Locker::issue_caps(CInode*, Capability*)+0x1a0c) [0x5b25dc]
> =A011: (Locker::issue_caps_set(std::set<CInode*, std::less<CInode*>,
> std::allocator<CInode*> >&)+0x26) [0x5b3ff6]
> =A012: (Locker::file_update_finish(CInode*, Mutation*, bool, client_t=
,
> Capability*, MClientCaps*)+0x665) [0x5c2a45]
> =A013: (C_Locker_FileUpdate_finish::finish(int)+0x2c) [0x5d6b1c]
> =A014: (finish_contexts(CephContext*, std::list<Context*,
> std::allocator<Context*> >&, int)+0xd0) [0x591250]
> =A015: (Journaler::_finish_flush(int, unsigned long, utime_t)+0x20e) =
[0x6ac6be]
> =A016: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xa8e) [0x69290e]
> =A017: (MDS::handle_core_message(Message*)+0x86f) [0x49e67f]
> =A018: (MDS::_dispatch(Message*)+0x2aa) [0x49e99a]
> =A019: (MDS::ms_dispatch(Message*)+0x6d) [0x4a060d]
> =A020: (SimpleMessenger::dispatch_entry()+0x8a1) [0x6f45b1]
> =A021: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4806ac]
> =A022: (()+0x77e1) [0x7f27d354a7e1]
> =A023: (clone()+0x6d) [0x7f27d2b048ed]
>
>
>
> 2011-07-22 23:18:55.727738 =A0 mds e196: 1/1/1 up
> {0=3Dceph3=3Dup:active(laggy or crashed)}, 1 up:standby
> 2011-07-22 23:18:55.742299 =A0 osd e140: 3 osds: 3 up, 3 in
> 2011-07-22 23:18:55.743943 =A0 mds e197: 1/1/1 up {0=3Dceph3=3Dup:rep=
lay}
> 2011-07-22 23:18:55.758649 =A0 =A0pg v957: 594 pgs: 594 active+clean;=
 3760
> MB data, 13164 MB used, 18063 MB / 35997 MB avail
> 2011-07-22 23:18:55.792549 =A0 log 2011-07-22 23:18:58.459865 mon0
> 10.10.10.91:6789/0 26 : [INF] mds? 10.10.10.93:6800/4702 up:boot
> 2011-07-22 23:18:57.304880 =A0 mds e198: 1/1/1 up {0=3Dceph3=3Dup:rec=
onnect}
> 2011-07-22 23:18:57.367480 =A0 log 2011-07-22 23:19:00.037792 mon0
> 10.10.10.91:6789/0 27 : [INF] mds0 10.10.10.93:6800/4702 up:reconnect
> 2011-07-22 23:18:58.493288 =A0 =A0pg v958: 594 pgs: 594 active+clean;=
 3760
> MB data, 13164 MB used, 18063 MB / 35997 MB avail
> 2011-07-22 23:19:01.139243 =A0 =A0pg v959: 594 pgs: 594 active+clean;=
 3760
> MB data, 13163 MB used, 18063 MB / 35997 MB avail
> 2011-07-22 23:19:21.118647 =A0 osd e141: 3 osds: 3 up, 3 in
> 2011-07-22 23:19:21.141306 =A0 =A0pg v960: 594 pgs: 594 active+clean;=
 3760
> MB data, 13163 MB used, 18063 MB / 35997 MB avail
> 2011-07-22 23:19:23.488866 =A0 =A0pg v961: 594 pgs: 594 active+clean;=
 3760
> MB data, 13165 MB used, 18063 MB / 35997 MB avail
> 2011-07-22 23:19:24.516985 =A0 =A0pg v962: 594 pgs: 594 active+clean;=
 3760
> MB data, 13167 MB used, 18063 MB / 35997 MB avail
> 2011-07-22 23:19:46.738637 =A0 mds e199: 1/1/1 up {0=3Dceph3=3Dup:rej=
oin}
> 2011-07-22 23:19:46.800581 =A0 log 2011-07-22 23:19:48.667174 mon0
> 10.10.10.91:6789/0 28 : [INF] mds0 10.10.10.93:6800/4702 up:rejoin
> 2011-07-22 23:19:46.859582 =A0 mds e200: 1/1/1 up {0=3Dceph3=3Dup:act=
ive}
> 2011-07-22 23:19:47.814926 =A0 log 2011-07-22 23:19:48.787984 mon0
> 10.10.10.91:6789/0 29 : [INF] mds0 10.10.10.93:6800/4702 up:active
> 2011-07-22 23:19:49.584346 =A0 =A0pg v963: 594 pgs: 594 active+clean;=
 3761
> MB data, 13168 MB used, 18063 MB / 35997 MB avail
> 2011-07-22 23:19:50.598374 =A0 =A0pg v964: 594 pgs: 594 active+clean;=
 3761
> MB data, 13166 MB used, 18062 MB / 35997 MB avail
> 2011-07-22 23:20:01.943931 =A0 mds e201: 1/1/1 up
> {0=3Dceph3=3Dup:active(laggy or crashed)}
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
