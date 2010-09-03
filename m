From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Write operation is stuck
Date: Fri, 3 Sep 2010 10:10:19 -0700
Message-ID: <AANLkTikSCXufwJC+=Ze4PhkvKnD6QK9hCqDasdrGsmLQ@mail.gmail.com>
References: <loom.20100827T140056-342@post.gmane.org>
	<Pine.LNX.4.64.1008270908001.1510@cobra.newdream.net>
	<Pine.LNX.4.64.1008301721100.28930@h1bombeiros.desy.de>
	<Pine.LNX.4.64.1008301237050.31074@cobra.newdream.net>
	<Pine.LNX.4.64.1008310952360.12851@h1bombeiros.desy.de>
	<Pine.LNX.4.64.1009011704550.15967@h1bombeiros.desy.de>
	<1283369392.3894.8.camel@wido-laptop.pcextreme.nl>
	<Pine.LNX.4.64.1009031631510.16053@h1bombeiros.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51021 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab0ICRKV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Sep 2010 13:10:21 -0400
Received: by ewy23 with SMTP id 23so1275310ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Sep 2010 10:10:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009031631510.16053@h1bombeiros.desy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bogdan Lobodzinski <bogdan@mail.desy.de>
Cc: Wido den Hollander <wido@widodh.nl>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Fri, Sep 3, 2010 at 8:02 AM, Bogdan Lobodzinski <bogdan@mail.desy.de=
> wrote:
>
> Hello all,
>
> let me continue my troubles, the title can stay the same.
> As I wrote, my ceph configuration survived my critical test
> svn co https://root.cern.ch/svn/root/trunk root
> and suddenly, during the night, at 5 oclock ceph became stuck again -=
 without any kind of user activity, no work at all with /ceph directory=
=2E
> The node is running as
> mds1, mon1, osd0
>
> System log file reports (the problem starts with entry:
> "Sep =A02 05:44:42 h1farm183 kernel: [72426.976029] ceph: mds0 caps s=
tale" ):
> --------
> Sep =A01 12:40:38 h1farm183 kernel: [10983.398458] Btrfs loaded
> Sep =A01 12:44:25 h1farm183 kernel: [11210.109913] ceph: loaded (mon/=
mds/osd proto 15/32/24, osdmap 5/5 5/5)
> Sep =A01 13:08:25 h1farm183 kernel: [12650.255052] device fsid 754ae4=
9f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
> 1
> Sep =A01 14:25:06 h1farm183 kernel: [17251.100851] RPC: Registered ud=
p transport module.
> Sep =A01 14:25:06 h1farm183 kernel: [17251.100854] RPC: Registered tc=
p transport module.
> Sep =A01 14:25:06 h1farm183 kernel: [17251.100855] RPC: Registered tc=
p NFSv4.1 backchannel transport module.
> Sep =A01 14:25:20 h1farm183 kernel: [17265.404967] device fsid 754ae4=
9f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
> 1
> Sep =A01 14:25:20 h1farm183 kernel: [17265.562870] udev: starting ver=
sion 151
> Sep =A01 14:25:26 h1farm183 kernel: [17271.752817] device fsid 754ae4=
9f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
> 1
> ...
> Sep =A01 16:41:51 h1farm183 kernel: [25456.385184] device fsid 4940ea=
fa1c110ce7-c14b44192348589f devid 1 transid 12 /dev/sdb1
> Sep =A01 16:42:21 h1farm183 kernel: [25486.297025] ceph: client4100 f=
sid 4ea08089-acf1-b738-6f72-96c3ed029b71
> Sep =A01 16:42:21 h1farm183 kernel: [25486.297169] ceph: mon0 131.169=
=2E74.116:6789 session established
> Sep =A02 02:37:54 h1farm183 rsyslogd: [origin software=3D"rsyslogd" s=
wVersion=3D"4.2.0" x-pid=3D"863" x-info=3D"http://www.rsyslog.com"] rsy=
slogd was HUPed, type 'lightweight'.
> Sep =A02 05:44:42 h1farm183 kernel: [72426.976029] ceph: mds0 caps st=
ale
> Sep =A02 05:44:57 h1farm183 kernel: [72441.976037] ceph: mds0 caps st=
ale
> Sep =A02 05:45:27 h1farm183 kernel: [72472.066320] ceph: mds0 reconne=
ct start
> Sep =A02 05:45:27 h1farm183 kernel: [72472.069681] Modules linked in:=
 nfs lockd nfs_acl auth_rpcgss sunrpc ceph btrfs zlib_deflate crc32c li=
bcrc32c ppdev lp parport openafs(P) ipt_MASQUERADE iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT xt_tcp=
udp iptable_filter ip_tables x_tables bridge stp fbcon tileblit font bi=
tblit softcursor vga16fb vgastate radeon ttm mptctl drm_kms_helper bnx2=
 drm usbhid i5000_edac hid dell_wmi shpchp edac_core agpgart i2c_algo_b=
it i5k_amb dcdbas psmouse serio_raw mptsas mptscsih mptbase scsi_transp=
ort_sas [last unloaded: kvm]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] Pid: 6184, comm: c=
eph-msgr/1 Tainted: P =A0 =A0 =A0 =A0 =A0 (2.6.32-24-generic-pae #42-Ub=
untu) PowerEdge 1950
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] EIP: 0060:[<c01ea9=
07>] EFLAGS: 00010246 CPU: 1
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] EIP is at kunmap_h=
igh+0x97/0xa0
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] EAX: 00000000 EBX:=
 f5d17000 ECX: c0916848 EDX: 00000292
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] ESI: c17ee940 EDI:=
 f5d18000 EBP: f5fb3c6c ESP: f5fb3c64
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0DS: 007b ES: 00=
7b FS: 00d8 GS: 00e0 SS: 0068
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0c07d9280 f50b10=
a0 f5fb3c74 c0138307 f5fb3c98 f9ad7d54 00000000 f5fb3cbc
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] <0> 00000038 00000=
02b eaee1018 ee4bcd70 00000000 f5fb3d14 f9ada09d 00000000
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] <0> eaee108c 00000=
05c f60bab40 eaee0e00 ee788440 f50b10a0 00000a21 00000000
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c0138307>] ? =
kunmap+0x57/0x60
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9ad7d54>] ? =
ceph_pagelist_append+0x54/0x110 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9ada09d>] ? =
encode_caps_cb+0x16d/0x1f0 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9ad89e0>] ? =
iterate_session_caps+0xa0/0x170 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9ad9f30>] ? =
encode_caps_cb+0x0/0x1f0 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9adb46f>] ? =
send_mds_reconnect+0x23f/0x3b0 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9adb804>] ? =
ceph_mdsc_handle_map+0x224/0x380 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9addd9e>] ? =
dispatch+0x8e/0x430 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9ad7776>] ? =
con_work+0x1cf6/0x1ed0 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c010807d>] ? =
__switch_to+0xcd/0x180
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c0146d83>] ? =
finish_task_switch+0x43/0xc0
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c05b10dc>] ? =
schedule+0x44c/0x840
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c016bbce>] ? =
run_workqueue+0x8e/0x150
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9ad5a80>] ? =
con_work+0x0/0x1ed0 [ceph]
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c016bd14>] ? =
worker_thread+0x84/0xe0
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c016fc70>] ? =
autoremove_wake_function+0x0/0x50
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c016bc90>] ? =
worker_thread+0x0/0xe0
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c016f9e4>] ? =
kthread+0x74/0x80
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c016f970>] ? =
kthread+0x0/0x80
> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c010a4e7>] ? =
kernel_thread_helper+0x7/0x10
> Sep =A02 05:45:27 h1farm183 kernel: [72472.304298] ---[ end trace 47e=
346731d47774d ]---

Is that all info? Missing some info about what triggered this trace.

> --------
>
> The node was stuck at all.
> Do you know what can be a reason ?

What client version are you using? This looks like a 32-bit related
client issue that we haven't hit, as we mostly run 64 bit. Does this
client have more than 4GB of memory? If not, you can try running it on
a non-pae kernel.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
