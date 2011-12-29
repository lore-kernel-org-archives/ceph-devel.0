From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Bug #1047 reproduced
Date: Thu, 29 Dec 2011 12:30:58 +0100
Message-ID: <201112291230.59323.a.ott@m-privacy.de>
References: <201112010937.37642.a.ott@m-privacy.de> <201112211736.25725.a.ott@m-privacy.de> <CAF3hT9BrL8WJbG2cgDADfSZk02HWwi4Q2MgK_yu6fiDSyZrwRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_z9E/O9Q2SrDXI4K"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:47709 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab1L2LbL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Dec 2011 06:31:11 -0500
In-Reply-To: <CAF3hT9BrL8WJbG2cgDADfSZk02HWwi4Q2MgK_yu6fiDSyZrwRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

--Boundary-00=_z9E/O9Q2SrDXI4K
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Greg,

I finally got the test cluster freed up for more Ceph testing.

On Friday 23 December 2011 wrote Gregory Farnum:
> Unfortunately there's not enough info in this log either. If you can
> reproduce it with "mds debug =3D 20" and put that log somewhere, it
> ought to be enough to work out what's going on, though. Sorry. :(
> -Greg

Here is what MDS logs with debug 20. No idea if it really helps. The cluste=
r=20
is still in the broken state, should I try to reproduce with a recreated ce=
ph=20
fs and debug 20? This could be GBs of logs.

Amon Ott
=2D-=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--Boundary-00=_z9E/O9Q2SrDXI4K
Content-Type: text/x-log;
  charset="iso 8859-15";
  name="mds-crash.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mds-crash.log"

2011-12-29 12:21:16.289250 4ce1e710 ceph version  (commit:), process ceph-mds, pid 31315
2011-12-29 12:21:16.292369 4ae19b70 mds.-1.0 ms_handle_connect on 192.168.111.2:6789/0
2011-12-29 12:21:20.424101 4ae19b70 mds.-1.0 handle_mds_map standby
2011-12-29 12:21:30.369706 4ae19b70 mds.0.13 handle_mds_map i am now mds.0.13
2011-12-29 12:21:30.369778 4ae19b70 mds.0.13 handle_mds_map state change up:standby --> up:replay
2011-12-29 12:21:30.369809 4ae19b70 mds.0.13 replay_start
2011-12-29 12:21:30.369840 4ae19b70 mds.0.13  recovery set is 
2011-12-29 12:21:30.369868 4ae19b70 mds.0.13  need osdmap epoch 252, have 251
2011-12-29 12:21:30.369890 4ae19b70 mds.0.13  waiting for osdmap 252 (which blacklists prior instance)
2011-12-29 12:21:30.369960 4ae19b70 mds.0.cache handle_mds_failure mds.0 : recovery peers are 
2011-12-29 12:21:30.455693 4ae19b70 mds.0.13 ms_handle_connect on 192.168.111.2:6801/4849
2011-12-29 12:21:30.455803 4ae19b70 mds.0.13 ms_handle_connect on 192.168.111.4:6801/5054
2011-12-29 12:21:30.456156 4ae19b70 mds.0.13 ms_handle_connect on 192.168.111.3:6801/5187
2011-12-29 12:21:30.616751 4ae19b70 mds.0.cache creating system inode with ino:100
2011-12-29 12:21:30.616984 4ae19b70 mds.0.cache creating system inode with ino:1
2011-12-29 12:21:33.246212 4860db70 mds.0.13 replay_done
2011-12-29 12:21:33.246270 4860db70 mds.0.13 making mds journal writeable
2011-12-29 12:21:33.391477 4ae19b70 mds.0.13 handle_mds_map i am now mds.0.13
2011-12-29 12:21:33.391531 4ae19b70 mds.0.13 handle_mds_map state change up:replay --> up:reconnect
2011-12-29 12:21:33.391556 4ae19b70 mds.0.13 reconnect_start
2011-12-29 12:21:33.391579 4ae19b70 mds.0.13 reopen_log
2011-12-29 12:21:33.391637 4ae19b70 mds.0.server reconnect_clients -- 7 sessions
2011-12-29 12:22:21.294278 49414b70 mds.0.server reconnect gave up on client.4531 192.168.111.4:0/257053315
2011-12-29 12:22:21.294334 49414b70 mds.0.server reconnect gave up on client.5000 192.168.111.2:0/1865366646
2011-12-29 12:22:21.294363 49414b70 mds.0.server reconnect gave up on client.5113 192.168.111.1:0/4105687565
2011-12-29 12:22:21.294391 49414b70 mds.0.server reconnect gave up on client.5202 192.168.111.3:0/705815956
2011-12-29 12:22:21.294420 49414b70 mds.0.server reconnect gave up on client.5414 192.168.111.2:0/1736181750
2011-12-29 12:22:21.294447 49414b70 mds.0.server reconnect gave up on client.5417 192.168.111.3:0/3526419788
2011-12-29 12:22:21.294474 49414b70 mds.0.server reconnect gave up on client.5420 192.168.111.4:0/1587151157
2011-12-29 12:22:21.294509 49414b70 mds.0.13 reconnect_done
2011-12-29 12:22:21.419600 4ae19b70 mds.0.13 handle_mds_map i am now mds.0.13
2011-12-29 12:22:21.419647 4ae19b70 mds.0.13 handle_mds_map state change up:reconnect --> up:rejoin
2011-12-29 12:22:21.419673 4ae19b70 mds.0.13 rejoin_joint_start
2011-12-29 12:22:21.443395 4ae19b70 mds.0.13 rejoin_done
2011-12-29 12:22:21.554730 4ae19b70 mds.0.13 handle_mds_map i am now mds.0.13
2011-12-29 12:22:21.554772 4ae19b70 mds.0.13 handle_mds_map state change up:rejoin --> up:active
2011-12-29 12:22:21.554797 4ae19b70 mds.0.13 recovery_done -- successful recovery!
2011-12-29 12:22:21.557761 4ae19b70 mds.0.13 active_start
2011-12-29 12:22:21.561821 4ae19b70 mds.0.13 cluster recovered.
2011-12-29 12:22:21.569550 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80832 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569608 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80833 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569643 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80835 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569675 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80836 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569705 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80839 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569739 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80840 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569770 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80841 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569801 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80843 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569831 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80845 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569863 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80848 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.569981 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80849 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.570403 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80851 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.571011 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80852 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.576171 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80853 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.576414 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80859 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.576573 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80861 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.577048 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80864 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.577701 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80865 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.577988 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80866 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.578247 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80867 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.578435 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80868 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.578493 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80870 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.578655 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80872 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.578813 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80874 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.578870 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80879 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.578895 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80881 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579090 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80883 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579148 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80884 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579174 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80887 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579193 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80888 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579210 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80890 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579228 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80891 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579246 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80893 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579264 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80895 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579281 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80897 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579298 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80899 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579315 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80901 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579332 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80902 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579349 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80903 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579367 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80904 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579383 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80905 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579413 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80906 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579432 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80909 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579450 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80910 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579513 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80911 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579537 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80912 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579575 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80913 <= 81240, already committed, sending ack.
2011-12-29 12:22:21.579600 4ae19b70 mds.0.tableserver(anchortable) got commit for tid 80914 <= 81240, already committed, sending ack.
mds/AnchorServer.cc: In function 'void AnchorServer::dec(inodeno_t)', in thread '4ae19b70'
mds/AnchorServer.cc: 98: FAILED assert(anchor_map.count(ino))
 ceph version  (commit:)
 1: (AnchorServer::dec(inodeno_t)+0x33a) [0x137f0f2a]
 2: (AnchorServer::_commit(unsigned long long)+0x2cc) [0x137f3d3c]
 3: (MDSTableServer::handle_commit(MMDSTableRequest*)+0x1fb) [0x137ef8cb]
 4: (MDS::handle_deferrable_message(Message*)+0xe01) [0x1358b7a1]
 5: (MDS::_dispatch(Message*)+0x1ae2) [0x135a3592]
 6: (MDS::ms_dispatch(Message*)+0xa5) [0x135a3c55]
 7: (SimpleMessenger::dispatch_entry()+0x7c9) [0x138b9219]
 8: (SimpleMessenger::DispatchThread::entry()+0x3b) [0x135780db]
 9: (Thread::_entry_func(void*)+0x1c) [0x1387119c]
 10: (()+0x5905) [0x4d556905]
 11: (clone()+0x5e) [0x4ceee8ce]
 ceph version  (commit:)
 1: (AnchorServer::dec(inodeno_t)+0x33a) [0x137f0f2a]
 2: (AnchorServer::_commit(unsigned long long)+0x2cc) [0x137f3d3c]
 3: (MDSTableServer::handle_commit(MMDSTableRequest*)+0x1fb) [0x137ef8cb]
 4: (MDS::handle_deferrable_message(Message*)+0xe01) [0x1358b7a1]
 5: (MDS::_dispatch(Message*)+0x1ae2) [0x135a3592]
 6: (MDS::ms_dispatch(Message*)+0xa5) [0x135a3c55]
 7: (SimpleMessenger::dispatch_entry()+0x7c9) [0x138b9219]
 8: (SimpleMessenger::DispatchThread::entry()+0x3b) [0x135780db]
 9: (Thread::_entry_func(void*)+0x1c) [0x1387119c]
 10: (()+0x5905) [0x4d556905]
 11: (clone()+0x5e) [0x4ceee8ce]
*** Caught signal (Aborted) **
 in thread 4ae19b70
 ceph version  (commit:)
 1: (()+0x471833) [0x13956833]
 2: [0x4d599400]
 3: [0x4d599422]
 4: (gsignal()+0x4f) [0x4ce4b02f]

--Boundary-00=_z9E/O9Q2SrDXI4K--
