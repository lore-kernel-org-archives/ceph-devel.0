From: Tren Blackburn <tren@eotnetworks.com>
Subject: mds stuck in clientreplay state after failover
Date: Tue, 25 Sep 2012 10:22:33 -0700
Message-ID: <CANLRBoxx0cvP38sajROLyB57TVJq00y13+zUYUnf1EVwF_gAmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44665 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247Ab2IYRWe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 13:22:34 -0400
Received: by vbbff1 with SMTP id ff1so7659979vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 10:22:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List;

I'm having an issue where the mds failed over between two nodes, and
now is stuck in "clientreplay" state. It's been like this for several
hours. Here are some details about the environment:

mds/mon server sap:

sap ceph # emerge --info
Portage 2.1.10.65 (default/linux/amd64/10.0, gcc-4.5.3,
glibc-2.14.1-r3, 3.5.3-gentoo x86_64)
=================================================================
System uname: Linux-3.5.3-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5-2620_0_@_2.00GHz-with-gentoo-2.1
Timestamp of tree: Sun, 23 Sep 2012 18:00:01 +0000
app-shells/bash:          4.2_p20
dev-lang/python:          2.7.3-r2, 3.1.3-r1, 3.2.3
dev-util/pkgconfig:       0.26
sys-apps/baselayout:      2.1-r1
sys-apps/openrc:          0.9.8.4
sys-apps/sandbox:         2.5
sys-devel/autoconf:       2.65-r1
sys-devel/automake:       1.11.1
sys-devel/binutils:       2.21.1-r1
sys-devel/gcc:            4.4.5, 4.5.3-r2
sys-devel/gcc-config:     1.6
sys-devel/libtool:        2.4-r1
sys-devel/make:           3.82-r1
sys-kernel/linux-headers: 3.4 (virtual/os-headers)
sys-libs/glibc:           2.14.1-r3

mds/mon server fern:

fern ceph # emerge --info
Portage 2.1.10.65 (default/linux/amd64/10.0, gcc-4.5.3,
glibc-2.14.1-r3, 3.5.3-gentoo x86_64)
=================================================================
System uname: Linux-3.5.3-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5-2620_0_@_2.00GHz-with-gentoo-2.1
Timestamp of tree: Mon, 24 Sep 2012 18:00:01 +0000
app-shells/bash:          4.2_p20
dev-lang/python:          2.7.3-r2, 3.1.3-r1, 3.2.3
dev-util/pkgconfig:       0.26
sys-apps/baselayout:      2.1-r1
sys-apps/openrc:          0.9.8.4
sys-apps/sandbox:         2.5
sys-devel/autoconf:       2.65-r1
sys-devel/automake:       1.11.1
sys-devel/binutils:       2.21.1-r1
sys-devel/gcc:            4.4.5, 4.5.3-r2
sys-devel/gcc-config:     1.6
sys-devel/libtool:        2.4-r1
sys-devel/make:           3.82-r1
sys-kernel/linux-headers: 3.4 (virtual/os-headers)
sys-libs/glibc:           2.14.1-r3

mds/mon/osd server ocr46-ire

ocr46-ire ceph # emerge --info
Portage 2.1.10.65 (default/linux/amd64/10.0, gcc-4.4.5,
glibc-2.14.1-r3, 3.5.3-gentoo x86_64)
=================================================================
System uname: Linux-3.5.3-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5-2620_0_@_2.00GHz-with-gentoo-2.1
Timestamp of tree: Mon, 24 Sep 2012 18:00:01 +0000
app-shells/bash:          4.2_p20
dev-lang/python:          2.7.3-r2, 3.1.3-r1, 3.2.3
dev-util/pkgconfig:       0.26
sys-apps/baselayout:      2.1-r1
sys-apps/openrc:          0.9.8.4
sys-apps/sandbox:         2.5
sys-devel/autoconf:       2.65-r1
sys-devel/automake:       1.11.1
sys-devel/binutils:       2.21.1-r1
sys-devel/gcc:            4.4.5, 4.5.3-r2
sys-devel/gcc-config:     1.6
sys-devel/libtool:        2.4-r1
sys-devel/make:           3.82-r1
sys-kernel/linux-headers: 3.4 (virtual/os-headers)
sys-libs/glibc:           2.14.1-r3

osd servers ocr31-ire - ocr46-ire

Portage 2.1.10.65 (default/linux/amd64/10.0, gcc-4.4.5,
glibc-2.14.1-r3, 3.5.3-gentoo x86_64)
=================================================================
System uname: Linux-3.5.3-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5-2620_0_@_2.00GHz-with-gentoo-2.1
Timestamp of tree: Mon, 24 Sep 2012 18:00:01 +0000
app-shells/bash:          4.2_p20
dev-lang/python:          2.7.3-r2, 3.2.3
dev-util/pkgconfig:       0.26
sys-apps/baselayout:      2.1-r1
sys-apps/openrc:          0.9.8.4
sys-apps/sandbox:         2.5
sys-devel/autoconf:       2.65-r1
sys-devel/automake:       1.11.1
sys-devel/binutils:       2.21.1-r1
sys-devel/gcc:            4.5.3-r2
sys-devel/gcc-config:     1.6
sys-devel/libtool:        2.4-r1
sys-devel/make:           3.82-r1
sys-kernel/linux-headers: 3.4 (virtual/os-headers)
sys-libs/glibc:           2.14.1-r3

All ceph servers are running ceph-0.51. Here is the output of ceph -s:

ocr31-ire ~ # ceph -s
   health HEALTH_OK
   monmap e1: 3 mons at
{fern=10.87.1.88:6789/0,ocr46=10.87.1.104:6789/0,sap=10.87.1.87:6789/0},
election epoch 92, quorum 0,1,2 fern,ocr46,sap
   osdmap e60: 192 osds: 192 up, 192 in
    pgmap v47728: 73728 pgs: 73728 active+clean; 290 GB data, 2794 GB
used, 283 TB / 286 TB avail
   mdsmap e19: 1/1/1 up {0=fern=up:clientreplay}, 2 up:standby

Here are the logs from sap, which was the mds master before it was
told to respawn:

2012-09-25 04:45:32.588374 7f2a34a40700  0 mds.0.3 ms_handle_reset on
10.87.1.100:6832/32257
2012-09-25 04:45:32.589064 7f2a34a40700  0 mds.0.3 ms_handle_connect
on 10.87.1.100:6832/32257
2012-09-25 04:45:57.787416 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 04:55:21.718357 7f2a34a40700  0 mds.0.3 ms_handle_reset on
10.87.1.89:6815/8101
2012-09-25 04:55:21.719044 7f2a34a40700  0 mds.0.3 ms_handle_connect
on 10.87.1.89:6815/8101
2012-09-25 04:55:26.758359 7f2a34a40700  0 mds.0.3 ms_handle_reset on
10.87.1.96:6800/6628
2012-09-25 04:55:26.759415 7f2a34a40700  0 mds.0.3 ms_handle_connect
on 10.87.1.96:6800/6628
2012-09-25 05:13:16.367476 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:18:45.177585 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:19:44.911831 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:30:38.178449 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:37:26.597832 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:37:34.088781 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:38:37.548132 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:39:21.528884 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:39:57.791457 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:40:13.579926 7f2a34a40700  0 mds.0.3 handle_mds_beacon
no longer laggy
2012-09-25 05:41:07.598457 7f2a2f709700  0 -- 10.87.1.87:6801/27351 >>
10.87.1.89:0/30567 pipe(0x1db2fc0 sd=100 pgs=2 cs=1 l=0).fault with
nothing to send, going to standby
2012-09-25 05:41:07.603802 7f2a30517700  0 -- 10.87.1.87:6801/27351 >>
10.87.1.94:0/9358 pipe(0x1db2b40 sd=99 pgs=2 cs=1 l=0).fault with
nothing to send, going to standby
2012-09-25 05:41:07.969148 7f2a34a40700  1 mds.-1.-1 handle_mds_map i
(10.87.1.87:6801/27351) dne in the mdsmap, respawning myself
2012-09-25 05:41:07.969154 7f2a34a40700  1 mds.-1.-1 respawn
2012-09-25 05:41:07.969155 7f2a34a40700  1 mds.-1.-1  e: '/usr/bin/ceph-mds'
2012-09-25 05:41:07.969157 7f2a34a40700  1 mds.-1.-1  0: '/usr/bin/ceph-mds'
2012-09-25 05:41:07.969159 7f2a34a40700  1 mds.-1.-1  1: '-i'
2012-09-25 05:41:07.969160 7f2a34a40700  1 mds.-1.-1  2: 'sap'
2012-09-25 05:41:07.969161 7f2a34a40700  1 mds.-1.-1  3: '--pid-file'
2012-09-25 05:41:07.969162 7f2a34a40700  1 mds.-1.-1  4:
'/var/run/ceph/mds.sap.pid'
2012-09-25 05:41:07.969163 7f2a34a40700  1 mds.-1.-1  5: '-c'
2012-09-25 05:41:07.969164 7f2a34a40700  1 mds.-1.-1  6: '/etc/ceph/ceph.conf'
2012-09-25 05:41:07.969165 7f2a34a40700  1 mds.-1.-1  cwd /
2012-09-25 05:41:08.003262 7fae819af780  0 ceph version 0.51
(commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30), process ceph-mds,
pid 1173
2012-09-25 05:41:08.005237 7fae7c9bd700  0 mds.-1.0 ms_handle_connect
on 10.87.1.88:6789/0
2012-09-25 05:41:08.802610 7fae7c9bd700  1 mds.-1.0 handle_mds_map standby
2012-09-25 05:41:09.602141 7fae7c9bd700  1 mds.-1.0 handle_mds_map standby
2012-09-25 05:41:23.772891 7fae7c9bd700  1 mds.-1.0 handle_mds_map standby
2012-09-25 05:41:25.273745 7fae7c9bd700  1 mds.-1.0 handle_mds_map standby
2012-09-25 05:41:27.994344 7fae7c9bd700  1 mds.-1.0 handle_mds_map standby
2012-09-25 05:41:28.588681 7fae7c9bd700  1 mds.-1.0 handle_mds_map standby
2012-09-25 05:41:42.282588 7fae7c9bd700  1 mds.-1.0 handle_mds_map standby

Why did sap get marked as down in the mdsmap?

Here is the mds logs from fern, the node that took over:

2012-09-25 05:41:09.482638 7f6a921c5700  1 mds.0.4 replay_done
2012-09-25 05:41:09.482652 7f6a921c5700  1 mds.0.4 making mds journal writeable
2012-09-25 05:41:09.483589 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.94:6800/19702
2012-09-25 05:41:09.483602 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.101:6818/7441
2012-09-25 05:41:09.483606 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.90:6812/13521
2012-09-25 05:41:09.483623 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.104:6825/30845
2012-09-25 05:41:09.602861 7f6a95ae2700  1 mds.0.4 handle_mds_map i am
now mds.0.4
2012-09-25 05:41:09.602865 7f6a95ae2700  1 mds.0.4 handle_mds_map
state change up:replay --> up:reconnect
2012-09-25 05:41:09.602867 7f6a95ae2700  1 mds.0.4 reconnect_start
2012-09-25 05:41:09.602869 7f6a95ae2700  1 mds.0.4 reopen_log
2012-09-25 05:41:09.602879 7f6a95ae2700  1 mds.0.server
reconnect_clients -- 2 sessions
2012-09-25 05:41:10.793524 7f6a95ae2700  0 log [DBG] : reconnect by
client.4755 10.87.1.89:0/30567 after 1.190611
2012-09-25 05:41:10.793568 7f6a95ae2700  0 mds.0.server non-auth
10000000004 #10000000004, will pass off to authority
2012-09-25 05:41:10.793594 7f6a95ae2700  0 mds.0.server non-auth
10000000005 #10000000005, will pass off to authority
2012-09-25 05:41:10.793609 7f6a95ae2700  0 mds.0.server non-auth
10000000006 #10000000006, will pass off to authority
2012-09-25 05:41:10.793625 7f6a95ae2700  0 mds.0.server non-auth
100000000d7 #100000000d7, will pass off to authority
2012-09-25 05:41:10.793636 7f6a95ae2700  0 mds.0.server non-auth
100000000d8 #100000000d8, will pass off to authority
2012-09-25 05:41:10.793653 7f6a95ae2700  0 mds.0.server non-auth
100000000d9 #100000000d9, will pass off to authority
2012-09-25 05:41:10.793664 7f6a95ae2700  0 mds.0.server non-auth
100000000da #100000000da, will pass off to authority
2012-09-25 05:41:10.793675 7f6a95ae2700  0 mds.0.server non-auth
100000000db #100000000db, will pass off to authority
...
Goes on for a few hundred thousand lines. It seems like there's a race
here somewhere as it made about 860,000 lines of this "server
non-auth"
...
2012-09-25 05:41:19.474557 7f6a95ae2700  0 mds.0.server non-auth
100002b8a83 #100002b8a83, will pass off to authority
2012-09-25 05:41:19.474568 7f6a95ae2700  0 mds.0.server non-auth
100002b8a84 #100002b8a84, will pass off to authority
2012-09-25 05:41:19.474579 7f6a95ae2700  0 mds.0.server non-auth
100002b8a87 #100002b8a87, will pass off to authority
2012-09-25 05:41:19.474588 7f6a95ae2700  0 mds.0.server non-auth
100002b8a89 #100002b8a89, will pass off to authority
2012-09-25 05:41:19.474605 7f6a95ae2700  0 mds.0.server non-auth
100002b8a8a #100002b8a8a, will pass off to authority
2012-09-25 05:41:19.474626 7f6a95ae2700  0 mds.0.server non-auth
100002b8a8b #100002b8a8b, will pass off to authority
2012-09-25 05:41:19.474637 7f6a95ae2700  0 mds.0.server non-auth
100002b8a8c #100002b8a8c, will pass off to authority
2012-09-25 05:41:19.474652 7f6a95ae2700  0 mds.0.server non-auth
100002b8a8d #100002b8a8d, will pass off to authority
2012-09-25 05:41:19.474667 7f6a95ae2700  0 mds.0.server non-auth
100002b8a8f #100002b8a8f, will pass off to authority
2012-09-25 05:41:19.474689 7f6a95ae2700  0 mds.0.server non-auth
100002b8a96 #100002b8a96, will pass off to authority
2012-09-25 05:41:19.484342 7f6a95ae2700  0 mds.0.server missing
100002ba853 #10000000002/ArchiveOutbound/111/1111968/20110701/385439240.tif
(mine), will load later
2012-09-25 05:41:19.484361 7f6a95ae2700  0 mds.0.server missing
100002ba854 #10000000002/ArchiveOutbound/111/1111968/20110701/385439251.tif
(mine), will load later
2012-09-25 05:41:19.484367 7f6a95ae2700  0 mds.0.server missing
100002ba855 #10000000002/ArchiveOutbound/111/1111968/20110701/385439350.tif
(mine), will load later
2012-09-25 05:41:19.484378 7f6a95ae2700  0 mds.0.server missing
100002ba856 #10000000002/ArchiveOutbound/111/1111968/20110701/385439352.tif
(mine), will load later
2012-09-25 05:41:19.484382 7f6a95ae2700  0 mds.0.server missing
100002ba857 #10000000002/ArchiveOutbound/111/1111968/20110701/385439354.tif
(mine), will load later
2012-09-25 05:41:19.484387 7f6a95ae2700  0 mds.0.server missing
100002ba858 #10000000002/ArchiveOutbound/111/1111968/20110701/385439430.tif
(mine), will load later
2012-09-25 05:41:19.484393 7f6a95ae2700  0 mds.0.server missing
100002ba859 #10000000002/ArchiveOutbound/111/1111968/20110701/.385439444.tif.RxChkh
(mine), will load later
2012-09-25 05:41:19.484401 7f6a95ae2700  1 mds.0.4 reconnect_done
2012-09-25 05:41:23.835106 7f6a95ae2700  0 mds.0.4 handle_mds_beacon
no longer laggy
2012-09-25 05:41:27.994961 7f6a95ae2700  1 mds.0.4 handle_mds_map i am
now mds.0.4
2012-09-25 05:41:27.994965 7f6a95ae2700  1 mds.0.4 handle_mds_map
state change up:reconnect --> up:rejoin
2012-09-25 05:41:27.994968 7f6a95ae2700  1 mds.0.4 rejoin_joint_start
2012-09-25 05:41:28.424292 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.98:6827/21424
2012-09-25 05:41:28.441796 7f6a95ae2700  1 mds.0.4 rejoin_done
2012-09-25 05:41:28.589425 7f6a95ae2700  1 mds.0.4 handle_mds_map i am
now mds.0.4
2012-09-25 05:41:28.589428 7f6a95ae2700  1 mds.0.4 handle_mds_map
state change up:rejoin --> up:clientreplay
2012-09-25 05:41:28.589430 7f6a95ae2700  1 mds.0.4 recovery_done --
successful recovery!
2012-09-25 05:41:28.598110 7f6a95ae2700  1 mds.0.4 clientreplay_start
2012-09-25 05:41:28.613610 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.103:6833/9804
2012-09-25 05:41:28.615111 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.95:6818/8725
2012-09-25 05:41:28.616342 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.98:6812/20834
2012-09-25 05:41:28.618528 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.102:6809/21045
2012-09-25 05:41:28.619851 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.98:6821/21183
2012-09-25 05:41:28.622614 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.89:6809/7883
2012-09-25 05:56:07.824706 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.103:6818/9242
2012-09-25 05:56:07.824827 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.100:6816/31393
2012-09-25 05:56:07.825437 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.103:6818/9242
2012-09-25 05:56:07.834669 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.96:6809/6968
2012-09-25 05:56:07.835271 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.96:6809/6968
2012-09-25 05:56:08.094667 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.101:6824/7669
2012-09-25 05:56:08.095320 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.101:6824/7669
2012-09-25 05:56:08.104670 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.94:6803/19811
2012-09-25 05:56:08.105254 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.94:6803/19811
2012-09-25 05:56:08.464684 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.99:6815/4360
2012-09-25 05:56:08.465283 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.99:6815/4360
2012-09-25 05:56:08.554740 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.101:6830/7898
2012-09-25 05:56:08.554815 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.96:6827/7710
2012-09-25 05:56:08.555387 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.96:6827/7710
2012-09-25 05:56:08.555395 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.101:6830/7898
2012-09-25 05:56:08.564681 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.104:6816/30466
2012-09-25 05:56:08.564759 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.93:6833/28547
2012-09-25 05:56:08.565390 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.104:6816/30466
2012-09-25 05:56:08.565415 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.93:6833/28547
2012-09-25 05:56:08.574702 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.98:6830/21540
2012-09-25 05:56:08.574746 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.104:6804/29957
2012-09-25 05:56:08.575357 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.104:6804/29957
2012-09-25 05:56:08.575366 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.98:6830/21540
2012-09-25 05:56:08.584683 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.101:6806/6990
2012-09-25 05:56:08.585261 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.101:6806/6990
2012-09-25 05:56:08.594677 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.100:6828/31704
2012-09-25 05:56:08.654687 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.102:6833/21939
2012-09-25 05:56:08.655264 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.102:6833/21939
2012-09-25 05:56:08.694689 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.90:6833/14293
2012-09-25 05:56:08.695442 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.90:6833/14293
...
2012-09-25 09:41:30.183380 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.95:6818/8725
2012-09-25 09:41:30.202467 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.89:6809/7883
2012-09-25 09:41:30.203014 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.89:6809/7883
2012-09-25 09:41:30.224668 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.98:6812/20834
2012-09-25 09:41:30.254959 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.98:6812/20834
2012-09-25 09:41:30.274665 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.98:6821/21183
2012-09-25 09:41:30.286990 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.93:6827/28326
2012-09-25 09:41:30.287631 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.93:6827/28326
2012-09-25 09:41:30.294907 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.98:6821/21183
2012-09-25 09:41:30.353745 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.99:6833/5044
2012-09-25 09:41:30.354364 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.99:6833/5044
2012-09-25 09:41:32.934674 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.104:6819/30603
2012-09-25 09:41:32.935642 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.104:6819/30603
2012-09-25 09:41:33.254681 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.100:6854/32722
2012-09-25 09:41:33.279245 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.100:6854/32722
2012-09-25 09:41:40.012905 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.103:6833/9804
2012-09-25 09:41:40.013620 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.103:6833/9804
2012-09-25 09:41:51.574710 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.93:6800/27331
2012-09-25 09:41:51.581248 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.93:6800/27331
2012-09-25 09:42:01.164453 7f6a95ae2700  0 mds.0.4 ms_handle_reset on
10.87.1.94:6815/20249
2012-09-25 09:42:01.165036 7f6a95ae2700  0 mds.0.4 ms_handle_connect
on 10.87.1.94:6815/20249

I enabled a higher level of debugging from ferns mds server:

ceph mds tell 'fern' injectargs "--debug_mds 20"

Here is what the mds logs show on fern:

2012-09-25 09:54:50.017750 7f6a95ae2700 -1 mds.0.4 applying
configuration change: internal_safe_to_start_threads = 'true'

2012-09-25 09:54:52.770191 7f6a941de700 10 mds.0.4 beacon_send
up:clientreplay seq 16692 (currently up:clientreplay)
2012-09-25 09:54:52.770761 7f6a95ae2700 10 mds.0.4 handle_mds_beacon
up:clientreplay seq 16692 rtt 0.000562
2012-09-25 09:54:54.723205 7f6a941de700 15 mds.0.bal get_load
mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0>
2012-09-25 09:54:54.723241 7f6a941de700 10 mds.0.locker scatter_tick
2012-09-25 09:54:54.723244 7f6a941de700 10 mds.0.server
find_idle_sessions.  laggy until 2012-09-25 05:41:23.835106
2012-09-25 09:54:54.723256 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567
2012-09-25 09:54:54.723262 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567 and sufficiently new
(2012-09-25 09:54:45.380736)
2012-09-25 09:54:56.770279 7f6a941de700 10 mds.0.4 beacon_send
up:clientreplay seq 16693 (currently up:clientreplay)
2012-09-25 09:54:56.770782 7f6a95ae2700 10 mds.0.4 handle_mds_beacon
up:clientreplay seq 16693 rtt 0.000489
2012-09-25 09:54:59.723269 7f6a941de700 15 mds.0.bal get_load
mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0>
2012-09-25 09:54:59.723304 7f6a941de700 10 mds.0.locker scatter_tick
2012-09-25 09:54:59.723306 7f6a941de700 10 mds.0.server
find_idle_sessions.  laggy until 2012-09-25 05:41:23.835106
2012-09-25 09:54:59.723312 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567
2012-09-25 09:54:59.723318 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567 and sufficiently new
(2012-09-25 09:54:45.380736)
2012-09-25 09:55:00.770376 7f6a941de700 10 mds.0.4 beacon_send
up:clientreplay seq 16694 (currently up:clientreplay)
2012-09-25 09:55:00.770875 7f6a95ae2700 10 mds.0.4 handle_mds_beacon
up:clientreplay seq 16694 rtt 0.000491
2012-09-25 09:55:04.723314 7f6a941de700 15 mds.0.bal get_load
mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0>
2012-09-25 09:55:04.723340 7f6a941de700 10 mds.0.locker scatter_tick
2012-09-25 09:55:04.723344 7f6a941de700 10 mds.0.server
find_idle_sessions.  laggy until 2012-09-25 05:41:23.835106
2012-09-25 09:55:04.723349 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567
2012-09-25 09:55:04.723355 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567 and sufficiently new
(2012-09-25 09:54:45.380736)
2012-09-25 09:55:04.770462 7f6a941de700 10 mds.0.4 beacon_send
up:clientreplay seq 16695 (currently up:clientreplay)
2012-09-25 09:55:04.771033 7f6a95ae2700 10 mds.0.4 handle_mds_beacon
up:clientreplay seq 16695 rtt 0.000566
2012-09-25 09:55:05.381914 7f6a95ae2700 20 mds.0.server get_session
have 0x3419d40 client.4755 10.87.1.89:0/30567 state open
2012-09-25 09:55:05.381922 7f6a95ae2700  3 mds.0.server
handle_client_session client_session(request_renewcaps seq 3303) v1
from client.4755
2012-09-25 09:55:06.426145 7f6a95ae2700 20 mds.0.server get_session
have 0x302b680 client.4746 10.87.1.94:0/9358 state open
2012-09-25 09:55:06.426153 7f6a95ae2700  3 mds.0.server
handle_client_session client_session(request_renewcaps seq 3304) v1
from client.4746
2012-09-25 09:55:08.770543 7f6a941de700 10 mds.0.4 beacon_send
up:clientreplay seq 16696 (currently up:clientreplay)
2012-09-25 09:55:08.771030 7f6a95ae2700 10 mds.0.4 handle_mds_beacon
up:clientreplay seq 16696 rtt 0.000479
2012-09-25 09:55:09.723353 7f6a941de700 15 mds.0.bal get_load
mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0>
2012-09-25 09:55:09.723372 7f6a941de700 10 mds.0.locker scatter_tick
2012-09-25 09:55:09.723374 7f6a941de700 10 mds.0.server
find_idle_sessions.  laggy until 2012-09-25 05:41:23.835106
2012-09-25 09:55:09.723379 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567
2012-09-25 09:55:09.723383 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567 and sufficiently new
(2012-09-25 09:55:05.381926)
2012-09-25 09:55:12.770623 7f6a941de700 10 mds.0.4 beacon_send
up:clientreplay seq 16697 (currently up:clientreplay)
2012-09-25 09:55:12.771158 7f6a95ae2700 10 mds.0.4 handle_mds_beacon
up:clientreplay seq 16697 rtt 0.000529
2012-09-25 09:55:14.723412 7f6a941de700 15 mds.0.bal get_load
mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0>
2012-09-25 09:55:14.723431 7f6a941de700 10 mds.0.locker scatter_tick
2012-09-25 09:55:14.723433 7f6a941de700 10 mds.0.server
find_idle_sessions.  laggy until 2012-09-25 05:41:23.835106
2012-09-25 09:55:14.723438 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567
2012-09-25 09:55:14.723442 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567 and sufficiently new
(2012-09-25 09:55:05.381926)
2012-09-25 09:55:16.770700 7f6a941de700 10 mds.0.4 beacon_send
up:clientreplay seq 16698 (currently up:clientreplay)
2012-09-25 09:55:16.771198 7f6a95ae2700 10 mds.0.4 handle_mds_beacon
up:clientreplay seq 16698 rtt 0.000491
2012-09-25 09:55:19.723466 7f6a941de700 15 mds.0.bal get_load
mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0>
2012-09-25 09:55:19.723485 7f6a941de700 10 mds.0.locker scatter_tick
2012-09-25 09:55:19.723487 7f6a941de700 10 mds.0.server
find_idle_sessions.  laggy until 2012-09-25 05:41:23.835106
2012-09-25 09:55:19.723491 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567
2012-09-25 09:55:19.723496 7f6a941de700 20 mds.0.server laggiest
active session is client.4755 10.87.1.89:0/30567 and sufficiently new
(2012-09-25 09:55:05.381926)

The mds is still in clientreplay. I have not attempted to restart the
mds process yet as I wanted to leave it in this state so we can
hopefully provide whatever information is needed to get this resolved.

Please let me know if there is any extra information I can provide
that would be helpful.

Regards,

Tren
