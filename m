From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Write operation is stuck
Date: Fri, 3 Sep 2010 12:20:21 -0700
Message-ID: <AANLkTi=dnfxFqSbj-nqCHOXz7+kR+5PH2Uc-jSse7s-w@mail.gmail.com>
References: <loom.20100827T140056-342@post.gmane.org>
	<Pine.LNX.4.64.1008270908001.1510@cobra.newdream.net>
	<Pine.LNX.4.64.1008301721100.28930@h1bombeiros.desy.de>
	<Pine.LNX.4.64.1008301237050.31074@cobra.newdream.net>
	<Pine.LNX.4.64.1008310952360.12851@h1bombeiros.desy.de>
	<Pine.LNX.4.64.1009011704550.15967@h1bombeiros.desy.de>
	<1283369392.3894.8.camel@wido-laptop.pcextreme.nl>
	<Pine.LNX.4.64.1009031631510.16053@h1bombeiros.desy.de>
	<AANLkTikSCXufwJC+=Ze4PhkvKnD6QK9hCqDasdrGsmLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47988 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab0ICTUY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Sep 2010 15:20:24 -0400
Received: by wyf22 with SMTP id 22so190914wyf.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Sep 2010 12:20:22 -0700 (PDT)
In-Reply-To: <AANLkTikSCXufwJC+=Ze4PhkvKnD6QK9hCqDasdrGsmLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bogdan Lobodzinski <bogdan@mail.desy.de>
Cc: Wido den Hollander <wido@widodh.nl>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

> On Fri, Sep 3, 2010 at 8:02 AM, Bogdan Lobodzinski <bogdan@mail.desy.=
de> wrote:
>>
>> Hello all,
>>
>> let me continue my troubles, the title can stay the same.
>> As I wrote, my ceph configuration survived my critical test
>> svn co https://root.cern.ch/svn/root/trunk root
>> and suddenly, during the night, at 5 oclock ceph became stuck again =
- without any kind of user activity, no work at all with /ceph director=
y.
>> The node is running as
>> mds1, mon1, osd0
>>
>> System log file reports (the problem starts with entry:
>> "Sep =A02 05:44:42 h1farm183 kernel: [72426.976029] ceph: mds0 caps =
stale" ):
>> --------
>> Sep =A01 12:40:38 h1farm183 kernel: [10983.398458] Btrfs loaded
>> Sep =A01 12:44:25 h1farm183 kernel: [11210.109913] ceph: loaded (mon=
/mds/osd proto 15/32/24, osdmap 5/5 5/5)
>> Sep =A01 13:08:25 h1farm183 kernel: [12650.255052] device fsid 754ae=
49f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
>> 1
>> Sep =A01 14:25:06 h1farm183 kernel: [17251.100851] RPC: Registered u=
dp transport module.
>> Sep =A01 14:25:06 h1farm183 kernel: [17251.100854] RPC: Registered t=
cp transport module.
>> Sep =A01 14:25:06 h1farm183 kernel: [17251.100855] RPC: Registered t=
cp NFSv4.1 backchannel transport module.
>> Sep =A01 14:25:20 h1farm183 kernel: [17265.404967] device fsid 754ae=
49f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
>> 1
>> Sep =A01 14:25:20 h1farm183 kernel: [17265.562870] udev: starting ve=
rsion 151
>> Sep =A01 14:25:26 h1farm183 kernel: [17271.752817] device fsid 754ae=
49f827ffac4-290543ed0a3b19a1 devid 1 transid 7 /dev/sdb
>> 1
>> ...
>> Sep =A01 16:41:51 h1farm183 kernel: [25456.385184] device fsid 4940e=
afa1c110ce7-c14b44192348589f devid 1 transid 12 /dev/sdb1
>> Sep =A01 16:42:21 h1farm183 kernel: [25486.297025] ceph: client4100 =
fsid 4ea08089-acf1-b738-6f72-96c3ed029b71
>> Sep =A01 16:42:21 h1farm183 kernel: [25486.297169] ceph: mon0 131.16=
9.74.116:6789 session established
>> Sep =A02 02:37:54 h1farm183 rsyslogd: [origin software=3D"rsyslogd" =
swVersion=3D"4.2.0" x-pid=3D"863" x-info=3D"http://www.rsyslog.com"] rs=
yslogd was HUPed, type 'lightweight'.
>> Sep =A02 05:44:42 h1farm183 kernel: [72426.976029] ceph: mds0 caps s=
tale
>> Sep =A02 05:44:57 h1farm183 kernel: [72441.976037] ceph: mds0 caps s=
tale
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.066320] ceph: mds0 reconn=
ect start
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.069681] Modules linked in=
: nfs lockd nfs_acl auth_rpcgss sunrpc ceph btrfs zlib_deflate crc32c l=
ibcrc32c ppdev lp parport openafs(P) ipt_MASQUERADE iptable_nat nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT xt_tc=
pudp iptable_filter ip_tables x_tables bridge stp fbcon tileblit font b=
itblit softcursor vga16fb vgastate radeon ttm mptctl drm_kms_helper bnx=
2 drm usbhid i5000_edac hid dell_wmi shpchp edac_core agpgart i2c_algo_=
bit i5k_amb dcdbas psmouse serio_raw mptsas mptscsih mptbase scsi_trans=
port_sas [last unloaded: kvm]
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332]
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] Pid: 6184, comm: =
ceph-msgr/1 Tainted: P =A0 =A0 =A0 =A0 =A0 (2.6.32-24-generic-pae #42-U=
buntu) PowerEdge 1950
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] EIP: 0060:[<c01ea=
907>] EFLAGS: 00010246 CPU: 1
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] EIP is at kunmap_=
high+0x97/0xa0
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] EAX: 00000000 EBX=
: f5d17000 ECX: c0916848 EDX: 00000292
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] ESI: c17ee940 EDI=
: f5d18000 EBP: f5fb3c6c ESP: f5fb3c64
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0DS: 007b ES: 0=
07b FS: 00d8 GS: 00e0 SS: 0068
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0c07d9280 f50b1=
0a0 f5fb3c74 c0138307 f5fb3c98 f9ad7d54 00000000 f5fb3cbc
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] <0> 00000038 0000=
002b eaee1018 ee4bcd70 00000000 f5fb3d14 f9ada09d 00000000
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] <0> eaee108c 0000=
005c f60bab40 eaee0e00 ee788440 f50b10a0 00000a21 00000000
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<c0138307>] ?=
 kunmap+0x57/0x60
>> Sep =A02 05:45:27 h1farm183 kernel: [72472.072332] =A0[<f9ad7d54>] ?=
 ceph_pagelist_append+0x54/0x110 [ceph]
=2E..
>> The node was stuck at all.
>> Do you know what can be a reason ?

Maybe the following patch fixes it? I'll push a fix to the unstable
branch, let me know if it works for you.

Thanks,
Yehuda

diff --git a/fs/ceph/pagelist.c b/fs/ceph/pagelist.c
index b6859f4..46a368b 100644
--- a/fs/ceph/pagelist.c
+++ b/fs/ceph/pagelist.c
@@ -5,10 +5,18 @@

 #include "pagelist.h"

+static void ceph_pagelist_unmap_tail(struct ceph_pagelist *pl)
+{
+	struct page *page =3D list_entry(pl->head.prev, struct page,
+				       lru);
+	kunmap(page);
+}
+
 int ceph_pagelist_release(struct ceph_pagelist *pl)
 {
 	if (pl->mapped_tail)
-		kunmap(pl->mapped_tail);
+		ceph_pagelist_unmap_tail(pl);
+
 	while (!list_empty(&pl->head)) {
 		struct page *page =3D list_first_entry(&pl->head, struct page,
 						     lru);
@@ -26,7 +34,7 @@ static int ceph_pagelist_addpage(struct ceph_pagelist=
 *pl)
 	pl->room +=3D PAGE_SIZE;
 	list_add_tail(&page->lru, &pl->head);
 	if (pl->mapped_tail)
-		kunmap(pl->mapped_tail);
+		ceph_pagelist_unmap_tail(pl);
 	pl->mapped_tail =3D kmap(page);
 	return 0;
 }
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
