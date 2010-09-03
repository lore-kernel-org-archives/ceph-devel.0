From: Bogdan Lobodzinski <bogdan@mail.desy.de>
Subject: Re: Write operation is stuck
Date: Fri, 3 Sep 2010 17:02:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009031631510.16053@h1bombeiros.desy.de>
References: <loom.20100827T140056-342@post.gmane.org>
 <Pine.LNX.4.64.1008270908001.1510@cobra.newdream.net>
 <Pine.LNX.4.64.1008301721100.28930@h1bombeiros.desy.de>
 <Pine.LNX.4.64.1008301237050.31074@cobra.newdream.net>
 <Pine.LNX.4.64.1008310952360.12851@h1bombeiros.desy.de>
 <Pine.LNX.4.64.1009011704550.15967@h1bombeiros.desy.de>
 <1283369392.3894.8.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp-out-3.desy.de ([131.169.56.86]:63356 "EHLO
	smtp-out-3.desy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab0ICPCc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Sep 2010 11:02:32 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
	by smtp-out-3.desy.de (DESY_OUT_3) with ESMTP id 2EA5C1036
	for <ceph-devel@vger.kernel.org>; Fri,  3 Sep 2010 17:02:31 +0200 (MEST)
Received: from adserv70.win.desy.de (adserv70.win.desy.de [131.169.97.56])
	by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id 10F401026
	for <ceph-devel@vger.kernel.org>; Fri,  3 Sep 2010 17:02:31 +0200 (MEST)
In-Reply-To: <1283369392.3894.8.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


Hello all,

let me continue my troubles, the title can stay the same.
As I wrote, my ceph configuration survived my critical test
svn co https://root.cern.ch/svn/root/trunk root
and suddenly, during the night, at 5 oclock ceph became stuck again - 
without any kind of user activity, no work at all with /ceph directory.
The node is running as
mds1, mon1, osd0

System log file reports (the problem starts with entry:
"Sep  2 05:44:42 h1farm183 kernel: [72426.976029] ceph: mds0 caps stale" ):
--------
Sep  1 12:40:38 h1farm183 kernel: [10983.398458] Btrfs loaded
Sep  1 12:44:25 h1farm183 kernel: [11210.109913] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 5/5 5/5)
Sep  1 13:08:25 h1farm183 kernel: [12650.255052] device fsid 754ae49f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
1
Sep  1 14:25:06 h1farm183 kernel: [17251.100851] RPC: Registered udp transport module.
Sep  1 14:25:06 h1farm183 kernel: [17251.100854] RPC: Registered tcp transport module.
Sep  1 14:25:06 h1farm183 kernel: [17251.100855] RPC: Registered tcp NFSv4.1 backchannel transport module.
Sep  1 14:25:20 h1farm183 kernel: [17265.404967] device fsid 754ae49f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
1
Sep  1 14:25:20 h1farm183 kernel: [17265.562870] udev: starting version 151
Sep  1 14:25:26 h1farm183 kernel: [17271.752817] device fsid 754ae49f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
1
...
Sep  1 16:41:51 h1farm183 kernel: [25456.385184] device fsid 4940eafa1c110ce7-c14b44192348589f devid 1 transid 12 /dev/sdb1
Sep  1 16:42:21 h1farm183 kernel: [25486.297025] ceph: client4100 fsid 4ea08089-acf1-b738-6f72-96c3ed029b71
Sep  1 16:42:21 h1farm183 kernel: [25486.297169] ceph: mon0 131.169.74.116:6789 session established
Sep  2 02:37:54 h1farm183 rsyslogd: [origin software="rsyslogd" swVersion="4.2.0" x-pid="863" x-info="http://www.rsyslog.com"] rsyslogd was 
HUPed, type 'lightweight'.
Sep  2 05:44:42 h1farm183 kernel: [72426.976029] ceph: mds0 caps stale
Sep  2 05:44:57 h1farm183 kernel: [72441.976037] ceph: mds0 caps stale
Sep  2 05:45:27 h1farm183 kernel: [72472.066320] ceph: mds0 reconnect start
Sep  2 05:45:27 h1farm183 kernel: [72472.069681] Modules linked in: nfs lockd nfs_acl auth_rpcgss sunrpc ceph btrfs zlib_deflate crc32c 
libcrc32c ppdev lp parport openafs(P) ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT 
xt_tcpudp iptable_filter ip_tables x_tables bridge stp fbcon tileblit font bitblit softcursor vga16fb vgastate radeon ttm mptctl 
drm_kms_helper bnx2 drm usbhid i5000_edac hid dell_wmi shpchp edac_core agpgart i2c_algo_bit i5k_amb dcdbas psmouse serio_raw mptsas 
mptscsih mptbase scsi_transport_sas [last unloaded: kvm]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332] Pid: 6184, comm: ceph-msgr/1 Tainted: P           (2.6.32-24-generic-pae #42-Ubuntu) 
PowerEdge 1950
Sep  2 05:45:27 h1farm183 kernel: [72472.072332] EIP: 0060:[<c01ea907>] EFLAGS: 00010246 CPU: 1
Sep  2 05:45:27 h1farm183 kernel: [72472.072332] EIP is at kunmap_high+0x97/0xa0
Sep  2 05:45:27 h1farm183 kernel: [72472.072332] EAX: 00000000 EBX: f5d17000 ECX: c0916848 EDX: 00000292
Sep  2 05:45:27 h1farm183 kernel: [72472.072332] ESI: c17ee940 EDI: f5d18000 EBP: f5fb3c6c ESP: f5fb3c64
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  c07d9280 f50b10a0 f5fb3c74 c0138307 f5fb3c98 f9ad7d54 00000000 f5fb3cbc
Sep  2 05:45:27 h1farm183 kernel: [72472.072332] <0> 00000038 0000002b eaee1018 ee4bcd70 00000000 f5fb3d14 f9ada09d 00000000
Sep  2 05:45:27 h1farm183 kernel: [72472.072332] <0> eaee108c 0000005c f60bab40 eaee0e00 ee788440 f50b10a0 00000a21 00000000
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c0138307>] ? kunmap+0x57/0x60
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9ad7d54>] ? ceph_pagelist_append+0x54/0x110 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9ada09d>] ? encode_caps_cb+0x16d/0x1f0 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9ad89e0>] ? iterate_session_caps+0xa0/0x170 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9ad9f30>] ? encode_caps_cb+0x0/0x1f0 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9adb46f>] ? send_mds_reconnect+0x23f/0x3b0 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9adb804>] ? ceph_mdsc_handle_map+0x224/0x380 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9addd9e>] ? dispatch+0x8e/0x430 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9ad7776>] ? con_work+0x1cf6/0x1ed0 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c010807d>] ? __switch_to+0xcd/0x180
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c0146d83>] ? finish_task_switch+0x43/0xc0
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c05b10dc>] ? schedule+0x44c/0x840
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c016bbce>] ? run_workqueue+0x8e/0x150
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<f9ad5a80>] ? con_work+0x0/0x1ed0 [ceph]
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c016bd14>] ? worker_thread+0x84/0xe0
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c016fc70>] ? autoremove_wake_function+0x0/0x50
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c016bc90>] ? worker_thread+0x0/0xe0
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c016f9e4>] ? kthread+0x74/0x80
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c016f970>] ? kthread+0x0/0x80
Sep  2 05:45:27 h1farm183 kernel: [72472.072332]  [<c010a4e7>] ? kernel_thread_helper+0x7/0x10
Sep  2 05:45:27 h1farm183 kernel: [72472.304298] ---[ end trace 47e346731d47774d ]---
---

my mds1.log from the node shows:
--------
10.09.02_05:45:15.001538 b5168b70 mds-1.0 beacon_send up:standby seq 11751 
(currently up:standby)
10.09.02_05:45:15.001555 b5168b70 -- 131.169.74.117:6800/3679 --> mon1 
131.169.74.117:6789/0 -- mdsbeacon(4099/1 up:stand
10.09.02_05:45:19.001663 b5168b70 mds-1.0 beacon_send up:standby seq 11752 
(currently up:standby)
10.09.02_05:45:19.001681 b5168b70 -- 131.169.74.117:6800/3679 --> mon1 
131.169.74.117:6789/0 -- mdsbeacon(4099/1 up:stand
10.09.02_05:45:19.128037 b5168b70 mds-1.0  last tick was 80.001470 > 5 
seconds ago, laggy_until 0.000000, setting laggy f
10.09.02_05:45:19.795620 b636cb70 -- 131.169.74.117:6800/3679 <== mon1 
131.169.74.117:6789/0 12055 ==== mdsmap(e 6) v1 ==
10.09.02_05:45:19.795669 b636cb70 mds-1.0 handle_mds_map epoch 6 from mon1
10.09.02_05:45:19.795697 b636cb70 mds-1.0      my compat 
compat={},rocompat={},incompat={1=base v0.20}
10.09.02_05:45:19.795708 b636cb70 mds-1.0  mdsmap compat 
compat={},rocompat={},incompat={1=base v0.20}
10.09.02_05:45:19.795715 b636cb70 mds0.0 map says i am 
131.169.74.117:6800/3679 mds0 state up:replay
10.09.02_05:45:19.795803 b636cb70 mds0.2 handle_mds_map i am now mds0.2
10.09.02_05:45:19.795812 b636cb70 mds0.2 handle_mds_map state change 
up:standby --> up:replay
10.09.02_05:45:19.795818 b636cb70 mds0.2 replay_start
10.09.02_05:45:19.795825 b636cb70 mds0.2 now replay.  my recovery peers 
are
10.09.02_05:45:19.795835 b636cb70 mds0.cache set_recovery_set
10.09.02_05:45:19.795856 b636cb70 mds0.2 boot_start 1: opening inotable
10.09.02_05:45:19.795866 b636cb70 mds0.inotable: load
10.09.02_05:45:19.795912 b636cb70 -- 131.169.74.117:6800/3679 --> mon1 
131.169.74.117:6789/0 -- mon_subscribe({mdsmap=7+,
10.09.02_05:45:19.795940 b636cb70 mds0.2 boot_start 1: opening sessionmap
10.09.02_05:45:19.795951 b636cb70 mds0.sessionmap load
10.09.02_05:45:19.795975 b636cb70 mds0.2 boot_start 1: opening anchor 
table
10.09.02_05:45:19.795982 b636cb70 mds0.anchortable: load
10.09.02_05:45:19.795998 b636cb70 mds0.2 boot_start 1: opening snap table
10.09.02_05:45:19.796015 b636cb70 mds0.snaptable: load
10.09.02_05:45:19.796030 b636cb70 mds0.2 boot_start 1: opening mds log
10.09.02_05:45:19.796041 b636cb70 mds0.log open discovering log bounds
10.09.02_05:45:19.796082 b636cb70 mds0.cache handle_mds_failure mds0
10.09.02_05:45:19.796093 b636cb70 mds0.cache handle_mds_failure mds0 : 
recovery peers are
10.09.02_05:45:19.796101 b636cb70 mds0.cache  wants_resolve
10.09.02_05:45:19.796107 b636cb70 mds0.cache  got_resolve
10.09.02_05:45:19.796112 b636cb70 mds0.cache  rejoin_sent
10.09.02_05:45:19.796117 b636cb70 mds0.cache  rejoin_gather
10.09.02_05:45:19.796123 b636cb70 mds0.cache  rejoin_ack_gather
10.09.02_05:45:19.796133 b636cb70 mds0.migrator handle_mds_failure_or_stop 
mds0
10.09.02_05:45:19.796164 b636cb70 mds0.cache show_subtrees - no subtrees
10.09.02_05:45:19.796177 b636cb70 mds0.bal check_targets have  need  want
10.09.02_05:45:19.796195 b636cb70 mds0.bal rebalance done
10.09.02_05:45:19.796201 b636cb70 mds0.cache show_subtrees - no subtrees
10.09.02_05:45:19.798127 b636cb70 -- 131.169.74.117:6800/3679 <== mon1 
131.169.74.117:6789/0 12056 ==== osd_map(1,5) v1 =
10.09.02_05:45:19.798152 b636cb70 mds0.2 laggy, deferring osd_map(1,5) v1
10.09.02_05:45:19.798165 b636cb70 -- 131.169.74.117:6800/3679 <== mon1 
131.169.74.117:6789/0 12057 ==== mon_subscribe_ack
10.09.02_05:45:19.984913 b636cb70 -- 131.169.74.117:6800/3679 <== mon1 
131.169.74.117:6789/0 12058 ==== mdsbeacon(4099/1
10.09.02_05:45:19.984951 b636cb70 mds0.2 handle_mds_beacon up:boot seq 2 
dne
10.09.02_05:45:19.985185 b636cb70 -- 131.169.74.117:6800/3679 <== mon1 
131.169.74.117:6789/0 12059 ==== mdsbeacon(4099/1
10.09.02_05:45:19.985210 b636cb70 mds0.2 handle_mds_beacon up:standby seq 
11730 rtt 88.986215
10.09.02_05:45:19.985245 b5168b70 mds0.2 beacon_kill last_acked_stamp 
10.09.02_05:43:50.998994, setting laggy flag.
10.09.02_05:45:19.985293 b636cb70 -- 131.169.74.117:6800/3679 <== mon1 
131.169.74.117:6789/0 12060 ==== mdsbeacon(4099/1
10.09.02_05:45:19.985320 b636cb70 mds0.2 handle_mds_beacon up:standby seq 
11731 rtt 84.986197

--------

The node was stuck at all.
Do you know what can be a reason ?
Any hint how to change the configuration are welcome

Cheers,

Bogdan





On Wed, 1 Sep 2010, Wido den Hollander wrote:

> Hi Bogdan,
>
> Yes, you can place your journal on a file, that is no problem.
>
> Performance wise you might want to use a block device (or partition) and
> a other device then the one where your data is one.
>
> Wido
>
> On Wed, 2010-09-01 at 17:21 +0200, Bogdan Lobodzinski wrote:
>> Hello Sage,
>>
>> replacing ext3 by btrfs my ceph test-bed survived my test comand:
>> svn co https://root.cern.ch/svn/root/trunk root
>>
>> I didn't try ext4.
>>
>> However, I did a few changes in my initial ceph.conf.
>> Could you, please, check if such a configuration is reasonable ?
>> Is it correct to use "osd journal" location as it is done below ?
>>
>> My new ceph.conf:
>> -----------
>> [global]
>>         pid file = /var/run/ceph/$name.pid
>>         debug ms = 1
>>         keyring = /etc/ceph/keyring.bin
>> [mon]
>>         mon data = /x01/mon$id
>>         debug mon = 20
>>         debug paxos = 20
>>         mon lease wiggle room = 0.5
>> [mon0]
>>         host = h1farm182
>>         mon addr = xxx.xxx.xxx.116:6789
>> [mon1]
>>         host = h1farm183
>>         mon addr = xxx.xxx.xxx.117:6789
>> [mds]
>>         debug mds = 10
>>         mds log max segments = 2
>>         keyring = /etc/ceph/keyring.$name
>> [mds0]
>>         host = h1farm182
>> [mds1]
>>         host = h1farm183
>> [osd]
>>         sudo = true
>>         keyring = /etc/ceph/keyring.$name
>>         osd data = /x02/osd$id
>>         osd journal = /x02/osd$id/journal
>>         osd journal size = 100
>>         debug osd = 20
>>         debug journal = 20
>>         debug filestore = 20
>> [osd0]
>>         host = h1farm183
>>         btrfs devs = /dev/sdb1
>> [osd1]
>>         host = h1farm184
>>         btrfs devs = /dev/sdb1
>> -----------
>>
>> Thank you for help,
>>
>> Cheers,
>>
>> Bogdan
>>
>>
>> On Tue, 31 Aug 2010, Bogdan Lobodzinski wrote:
>>
>>>
>>> Hello Sage,
>>>
>>> On Mon, 30 Aug 2010, Sage Weil wrote:
>>>
>>>> On Mon, 30 Aug 2010, Bogdan Lobodzinski wrote:
>>>>>
>>>>> Hello Sage,
>>>>>
>>>>> I moved to the kernel 2.6.35, keeping ext3 filesystem.
>>>>> After executing teh same command:
>>>>> svn co https://root.cern.ch/svn/root/trunk root
>>>>>
>>>>> System is again dead. The command and kjournald are stuck
>>>>> bogdan  8539  0.9  0.6  31168 22040 pts/0  DL+  16:44  0:21 svn co
>>>>> https://root.cern.ch/svn/root/trunk root
>>>>> root    802   0.0  0.0      0     0 ?        D  12:59  0:01 [kjournald]
>>>>
>>>> Hmm.  Have you tried ext4?
>>>>
>>>> I stopped seeing this on my own machine with recent kernels, but it looks
>>>> like it isn't in fact fixed.  This should be reported to the ext4 list.
>>>> Are you running ceph via vstart.sh or a custom ceph.conf?
>>> I am using vstart.sh taken from compiled by me source tarball
>>> ceph-0.21.tar.gz  (http://ceph.newdream.net/download/)
>>> and the client from
>>> git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client-standalone.git
>>>
>>> Cheers,
>>>
>>> Bogdan
>>>
>>>>
>>>> sage
>>>>
>>>>>
>>>>> Looks like the bug is not fixed, dmesg shows:
>>>>> ---------
>>>>> [14325.304068] kernel BUG at
>>>>> /build/buildd/linux-maverick-2.6.35/fs/ext3/balloc.c:1385!
>>>>> [14325.304191] invalid opcode: 0000 [#1] SMP
>>>>> [14325.304263] last sysfs file:
>>>>> /sys/devices/pci0000:00/0000:00:00.0/device
>>>>> [14325.304266] Modules linked in: nfs lockd fscache nfs_acl auth_rpcgss
>>>>> sunrpc
>>>>> ceph crc32c libcrc32c radeon ttm drm_kms_helper drm mptctl psmouse agpgart
>>>>> i5000_edac usbhid hid edac_core i2c_algo_bit bnx2 i5k_amb dcdbas shpchp
>>>>> serio_raw mptsas mptscsih mptbase scsi_transport_sas
>>>>> [14325.304266]
>>>>> [14325.304266] Pid: 8391, comm: cosd Not tainted 2.6.35-14-generic
>>>>> #20~lucid2-Ubuntu 0DT097/PowerEdge 1950
>>>>> [14325.304266] EIP: 0060:[<c0274a4d>] EFLAGS: 00210286 CPU: 1
>>>>> [14325.304266] EIP is at ext3_try_to_allocate_with_rsv+0x1cd/0x2b0
>>>>> [14325.304266] EAX: 00000027 EBX: c8641440 ECX: c07d7cfc EDX: 00000000
>>>>> [14325.304266] ESI: 007b7fff EDI: f640fa00 EBP: f5823c50 ESP: f5823c10
>>>>> [14325.304266]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
>>>>> [14325.304266] Process cosd (pid: 8391, ti=f5822000 task=f6b7bf70
>>>>> task.ti=f5822000)
>>>>> [14325.304266] Stack:
>>>>> [14325.304266]  000000f6 c6c11930 c0273a58 00001000 f62e549c 00000007
>>>>> c8641454
>>>>> 007b7fff
>>>>> [14325.304266] <0> f6f7e420 007b0000 000000f6 f640de00 00000001 000000f6
>>>>> c4063ec0 00000000
>>>>> [14325.304266] <0> f5823cc0 c0274daf c6c11930 ffffffff c8641440 f5823ca8
>>>>> f5823cac c0256017
>>>>> [14325.304266] Call Trace:
>>>>> [14325.304266]  [<c0273a58>] ? read_block_bitmap+0x48/0x160
>>>>> [14325.304266]  [<c0274daf>] ? ext3_new_blocks+0x1ff/0x610
>>>>> [14325.304266]  [<c0256017>] ? mb_cache_entry_find_first+0x67/0x80
>>>>> [14325.304266]  [<c02751e5>] ? ext3_new_block+0x25/0x30
>>>>> [14325.304266]  [<c0287721>] ? ext3_xattr_block_set+0x481/0x550
>>>>> [14325.304266]  [<c0286490>] ? ext3_xattr_set_entry+0x20/0x2f0
>>>>> [14325.304266]  [<c0287b0b>] ? ext3_xattr_set_handle+0x31b/0x400
>>>>> [14325.304266]  [<c0287c65>] ? ext3_xattr_set+0x75/0xc0
>>>>> [14325.304266]  [<c0287d24>] ? ext3_xattr_user_set+0x74/0x80
>>>>> [14325.304266]  [<c023348b>] ? generic_setxattr+0x9b/0xb0
>>>>> [14325.304266]  [<c02333f0>] ? generic_setxattr+0x0/0xb0
>>>>> [14325.304266]  [<c0234084>] ? __vfs_setxattr_noperm+0x44/0x150
>>>>> [14325.304266]  [<c03017dc>] ? cap_inode_setxattr+0x2c/0x60
>>>>> [14325.304266]  [<c0234221>] ? vfs_setxattr+0x91/0xa0
>>>>> [14325.304266]  [<c02342e8>] ? setxattr+0xb8/0x110
>>>>> [14325.304266]  [<c0221d0e>] ? path_to_nameidata+0x1e/0x50
>>>>> [14325.304266]  [<c0223492>] ? link_path_walk+0x412/0x890
>>>>> [14325.304266]  [<c013a159>] ? enqueue_task_fair+0x39/0x80
>>>>> [14325.304266]  [<c022ff3f>] ? mntput_no_expire+0x1f/0xd0
>>>>> [14325.304266]  [<c022ff3f>] ? mntput_no_expire+0x1f/0xd0
>>>>> [14325.304266]  [<c022168b>] ? putname+0x2b/0x40
>>>>> [14325.304266]  [<c022470a>] ? user_path_at+0x4a/0x80
>>>>> [14325.304266]  [<c0179902>] ? sys_futex+0x72/0x120
>>>>> [14325.304266]  [<c0234503>] ? sys_setxattr+0x83/0x90
>>>>> [14325.304266]  [<c05c9bb4>] ? syscall_call+0x7/0xb
>>>>> [14325.304266]  [<c05c0000>] ? cache_add_dev+0x73/0x195
>>>>> [14325.304266] Code: 83 3a ff ff ff 90 39 45 dc c7 45 0c ff ff ff ff 0f 83
>>>>> 32
>>>>> ff ff ff 8b 87 80 01 00 00 ba 5a 7e 5e c0 05 d0 00 00 00 e8 83 f1 ff ff
>>>>> <0f>
>>>>> 0b eb fe 8b 45 ec 89 55 d4 05 cc 00 00 00 89 45 ec e8 ec 4b
>>>>> [14325.304266] EIP: [<c0274a4d>] ext3_try_to_allocate_with_rsv+0x1cd/0x2b0
>>>>> SS:ESP 0068:f5823c10
>>>>> [14325.326777] ---[ end trace 53e0b3b55af7a83c ]---
>>>>> [14384.001261] ceph: mds0 caps stale
>>>>> [14413.616132] ceph:  tid 33594 timed out on osd2, will reset osd
>>>>> [14628.992279] ceph: mds0 hung
>>>>> ---------
>>>>>
>>>>> as a next step I wil try to use btrfs .
>>>>>
>>>>> Cheers,
>>>>>
>>>>> Bogdan
>>>>>
>>>>>
>>>>> On Fri, 27 Aug 2010, Sage Weil wrote:
>>>>>
>>>>>> Hi Bogdan,
>>>>>>
>>>>>> This is a bug in the ext3 xattr code.  It seems to be gone in 2.6.34 and
>>>>>> later.  Or, you can switch to btrfs!
>>>>>>
>>>>>> sage
>>>>>>
>>>>>>
>>>>>> On Fri, 27 Aug 2010, Bogdan Lobodzinski wrote:
>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> working with ceph on my test configuration
>>>>>>> (3 nodes Ubuntu 10.04.1 LTS, Linux 2.6.32-24-generic-pae #41-Ubuntu SMP)
>>>>>>> After starting
>>>>>>> svn co https://root.cern.ch/svn/root/trunk root
>>>>>>>
>>>>>>> on the /ceph directory, the command become stuck, and also:
>>>>>>> root      5303  0.0  0.0      0     0 ?        D    Aug26   0:00
>>>>>>> [kjournald]
>>>>>>> root     30181  0.0  0.0   6972  2056 pts/1    D+   13:46   0:00
>>>>>>> /usr//bin/cosd
>>>>>>> -i 2 -c /etc/ceph/ceph.conf
>>>>>>>
>>>>>>> any mount, unmount are going also to the state D.
>>>>>>> This is a permanennt behaviour of the ceph if the command is started.
>>>>>>>
>>>>>>> dmesg shows:
>>>>>>> -------------
>>>>>>> [99048.567704] ------------[ cut here ]------------
>>>>>>> [99048.568767] kernel BUG at
>>>>>>> /build/buildd/linux-2.6.32/fs/ext3/balloc.c:1384!
>>>>>>> [99048.568767] invalid opcode: 0000 [#1] SMP
>>>>>>> [99048.568767] last sysfs file:
>>>>>>> /sys/devices/pci0000:00/0000:00:00.0/device
>>>>>>> [99048.596652] Modules linked in: nfs lockd nfs_acl auth_rpcgss sunrpc
>>>>>>> ceph
>>>>>>> crc32c libcrc32c openafs(P) fbcon tileblit font bitblit softcursor vga
>>>>>>> vgastate mptctl radeon ttm drm_kms_helper drm bnx2 psmouse i5000_edac
>>>>>>> edac_core agpgart serio_raw i5k_amb i2c_algo_bit shpchp dell_wmi dcdbas
>>>>>>> usbhid mptsas mptscsih mptbase scsi_transport_sas
>>>>>>> [99048.596652]
>>>>>>> [99048.596652] Pid: 6258, comm: cosd Tainted: P
>>>>>>> (2.6.32-24-generic-pae #41-Ubuntu) PowerEdge 1950
>>>>>>> [99048.596652] EIP: 0060:[<c026dc8d>] EFLAGS: 00210296 CPU: 3
>>>>>>> [99048.596652] EIP is at ext3_try_to_allocate_with_rsv+0x1cd/0x2b0
>>>>>>> [99048.596652] EAX: 00000027 EBX: f6dd5480 ECX: fffe48f7 EDX: 00000000
>>>>>>> [99048.596652] ESI: 02147fff EDI: f625e200 EBP: f5ccbc54 ESP: f5ccbc14
>>>>>>> [99048.596652]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
>>>>>>> [99048.596652] Process cosd (pid: 6258, ti=f5cca000 task=f6263300
>>>>>>> task.ti=f5cca000)
>>>>>>> [99048.596652] Stack:
>>>>>>> [99048.596652]  00000428 f14f1bc0 c026cc88 00001000 00000007 f1a80e9c
>>>>>>> f6dd5494 02147fff
>>>>>>> [99048.596652] <0> f70d89c0 02140000 00000428 f625d800 00000001 00000428
>>>>>>> f1058500 00000000
>>>>>>> [99048.596652] <0> f5ccbcc8 c026e048 f14f1bc0 ffffffff f6dd5480 f5ccbcb0
>>>>>>> f5ccbcb4 f5ccbc90
>>>>>>> [99048.596652] Call Trace:
>>>>>>> [99048.596652]  [<c026cc88>] ? read_block_bitmap+0x48/0x160
>>>>>>> [99048.596652]  [<c026e048>] ? ext3_new_blocks+0x228/0x6c0
>>>>>>> [99048.596652]  [<c024fbd7>] ? mb_cache_entry_find_first+0x67/0x80
>>>>>>> [99048.596652]  [<c026e505>] ? ext3_new_block+0x25/0x30
>>>>>>> [99048.596652]  [<c02809a4>] ? ext3_xattr_block_set+0x554/0x670
>>>>>>> [99048.596652]  [<c027f589>] ? ext3_xattr_set_entry+0x29/0x350
>>>>>>> [99048.596652]  [<c0280d8b>] ? ext3_xattr_set_handle+0x2cb/0x3e0
>>>>>>> [99048.596652]  [<c0280f15>] ? ext3_xattr_set+0x75/0xc0
>>>>>>> [99048.596652]  [<c0280fd6>] ? ext3_xattr_user_set+0x76/0x80
>>>>>>> [99048.596652]  [<c022dd8c>] ? generic_setxattr+0x9c/0xb0
>>>>>>> [99048.596652]  [<c022dcf0>] ? generic_setxattr+0x0/0xb0
>>>>>>> [99048.596652]  [<c022e984>] ? __vfs_setxattr_noperm+0x44/0x160
>>>>>>> [99048.596652]  [<c02fed4c>] ? cap_inode_setxattr+0x2c/0x60
>>>>>>> [99048.596652]  [<c022eb31>] ? vfs_setxattr+0x91/0xa0
>>>>>>> [99048.596652]  [<c022ebf8>] ? setxattr+0xb8/0x110
>>>>>>> [99048.596652]  [<c021d512>] ? __link_path_walk+0x632/0xca0
>>>>>>> [99048.596652]  [<c014e369>] ? enqueue_task_fair+0x39/0x80
>>>>>>> [99048.596652]  [<c022a9bf>] ? mntput_no_expire+0x1f/0xe0
>>>>>>> [99048.596652]  [<c022a9bf>] ? mntput_no_expire+0x1f/0xe0
>>>>>>> [99048.596652]  [<c021be45>] ? path_put+0x25/0x30
>>>>>>> [99048.596652]  [<c021ba8b>] ? putname+0x2b/0x40
>>>>>>> [99048.596652]  [<c021ea6a>] ? user_path_at+0x4a/0x80
>>>>>>> [99048.596652]  [<c0183242>] ? sys_futex+0x72/0x120
>>>>>>> [99048.596652]  [<c022ee13>] ? sys_setxattr+0x83/0x90
>>>>>>> [99048.596652]  [<c0109763>] ? sysenter_do_call+0x12/0x28
>>>>>>> [99048.596652] Code: 83 3a ff ff ff 90 39 45 dc c7 45 0c ff ff ff ff 0f
>>>>>>> 83
>>>>>>> 32 ff ff ff 8b 87 84 01 00 00 ba ba c6 5c c0 05 d0 00 00 00 e8 73 f1
>>>>>>> ff<0f>
>>>>>>> 0b eb fe 8b 45 ec 89 55 d4 05 cc 00 00 00 89 45 ec e8 fc 53
>>>>>>> [99048.596652] EIP: [<c026dc8d>]
>>>>>>> ext3_try_to_allocate_with_rsv+0x1cd/0x2b0
>>>>>>> SS:ESP 0068:f5ccbc14
>>>>>>> [99049.044090] ---[ end trace 35860103963ee444 ]---
>>>>>>> h1farm184#
>>>>>>> --------------------
>>>>>>>
>>>>>>> my ceph.conf is:
>>>>>>> -------
>>>>>>> [global]
>>>>>>>        pid file = /var/run/ceph/$name.pid
>>>>>>>        debug ms = 1
>>>>>>>        keyring = /etc/ceph/keyring.bin
>>>>>>> ; monitors
>>>>>>> [mon]
>>>>>>>        ;Directory for monitor files
>>>>>>>        mon data = /x02/mon$id
>>>>>>>        debug mon = 20
>>>>>>>        debug paxos = 20
>>>>>>>        mon lease wiggle room = 0.5
>>>>>>>
>>>>>>> [mon0]
>>>>>>>        host = h1farm182
>>>>>>>        mon addr = xxx.xxx.xx.116:6789
>>>>>>> [mon1]
>>>>>>>        host = h1farm183
>>>>>>>        mon addr = xxx.xxx.xx.117:6789
>>>>>>> ; metadata servers
>>>>>>> [mds]
>>>>>>>        debug mds = 20
>>>>>>>        mds log max segments = 2
>>>>>>>        keyring = /etc/ceph/keyring.$name
>>>>>>> [mds0]
>>>>>>>        host = h1farm182
>>>>>>> [mds1]
>>>>>>>        host = h1farm183
>>>>>>> [osd]
>>>>>>>        sudo = true
>>>>>>>        osd data = /x02/osd$id
>>>>>>>        osd journal = /x02/osd$id/journal
>>>>>>>        osd journal size = 100
>>>>>>>        keyring = /etc/ceph/keyring.$name
>>>>>>>        debug osd = 20
>>>>>>>        debug journal = 20
>>>>>>>        debug filestore = 20
>>>>>>>        ;osd journal size = 100
>>>>>>> [osd0]
>>>>>>>        host = h1farm182
>>>>>>> [osd1]
>>>>>>>        host = h1farm183
>>>>>>> [osd2]
>>>>>>>        host = h1farm184
>>>>>>>
>>>>>>> -------
>>>>>>>
>>>>>>> Any idea how to improve the situation ?
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>>>
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
