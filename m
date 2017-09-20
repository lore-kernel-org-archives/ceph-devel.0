From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Luminous OSD high mem usage cause OS die
Date: Thu, 21 Sep 2017 00:07:42 +0800
Message-ID: <CAEYCsV+xFvBCqenVgNo9Lu=cG3mbM6MpR2WJAeUwdwHJnjC-_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:55942 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdITQHo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Sep 2017 12:07:44 -0400
Received: by mail-io0-f182.google.com with SMTP id z187so4597939ioz.12
        for <ceph-devel@vger.kernel.org>; Wed, 20 Sep 2017 09:07:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hi,

    We just have a node die during a long recovery.   The
recovery(backfill) is from 3 Host , each host with 8 OSDs to 1 Host,
with 24 OSDs(crush chooseleaf type OSD), almost all data need to be
move and it already last for ~40 Hours before the target host crash.
Till that it is about 50% done, total data set is ~ 7 TB * 3 Replica.

    Despite the slow recovery speed (which is tracked in another
mailing thread), this time the target host (10.153.55.105) died due to
page allocation failure.  It looks like we run out all the memory and
some OSD on this Host died, which cause even more recovery /peering
and eaten more memory.

--------Some OSD log--------

2017-09-20 01:34:33.827924 7f82c127d700  1 osd.66 pg_epoch: 183092
pg[25.111d( v 170496'124722 (159408'121639,170496'124722]
local-lis/les=3D182588/182652 n=3D330 ec=3D112674/112674 lis/c 182588/18147=
3
les/c/f 182652/181490/0 183092/183092/183092) [123,66,311] r=3D1
lpr=3D183092 pi=3D[181473,183092)/3 crt=3D170496'124722 lcod 0'0 unknown
NOTIFY] state<Start>: transitioning to Stray
2017-09-20 01:34:34.981430 7f82c6a88700  0 osd.66 183093 crush map has
features 720595732696154112, adjusting msgr requires for osds
2017-09-20 01:34:37.398096 7f82c6a88700  0 osd.66 183095 crush map has
features 720595732696154112, adjusting msgr requires for osds
2017-09-20 01:34:47.271077 7f82c6a88700  0 osd.66 183096 crush map has
features 720595732696154112, adjusting msgr requires for osds
2017-09-20 01:34:49.573938 7f82c6a88700  0 osd.66 183097 crush map has
features 720595732696154112, adjusting msgr requires for osds
2017-09-20 01:34:49.677852 7f82d4a50700  0 --
10.153.55.105:6820/5012957 >> 10.153.55.105:6870/2013287
conn(0x7f8424875800 :6820 s=3DSTATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH
pgs=3D0 cs=3D0 l=3D0).handle_connect_msg accept connect_seq 0 vs existing
csq=3D0 existing_state=3DSTATE_CONNECTING
2017-09-20 01:34:50.879427 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.135:6840 osd.65 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879452 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.52.40:6885 osd.67 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879461 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6875 osd.105 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879467 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6822 osd.256 since back
2017-09-20 01:34:39.380397 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879473 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6835 osd.308 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879478 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6884 osd.311 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879482 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6845 osd.313 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879486 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6885 osd.318 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879491 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6841 osd.323 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879495 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6858 osd.329 since back
2017-09-20 01:34:49.183115 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879500 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6888 osd.332 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879506 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6896 osd.343 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879510 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6881 osd.414 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879515 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6851 osd.420 since back
2017-09-20 01:34:43.481058 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879521 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6893 osd.440 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:30.879423)
2017-09-20 01:34:50.879534 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6869 osd.542 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:30.879423)
2017-09-20 01:34:51.879795 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.135:6840 osd.65 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879828 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.52.40:6885 osd.67 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879832 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6875 osd.105 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879836 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6822 osd.256 since back
2017-09-20 01:34:39.380397 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879841 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6835 osd.308 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879844 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6884 osd.311 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879849 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6845 osd.313 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879853 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6885 osd.318 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879856 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6841 osd.323 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879859 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6858 osd.329 since back
2017-09-20 01:34:49.183115 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879863 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6888 osd.332 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879866 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6896 osd.343 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879869 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6881 osd.414 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879872 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6851 osd.420 since back
2017-09-20 01:34:43.481058 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879876 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6893 osd.440 ever on
either front or back, first ping sent 2017-09-20 01:34:30.677800
(cutoff 2017-09-20 01:34:31.879794)
2017-09-20 01:34:51.879879 7f82d129d700 -1 osd.66 183097
heartbeat_check: no reply from 10.153.55.105:6869 osd.542 since back
2017-09-20 01:34:30.677800 front 2017-09-20 01:34:30.677800 (cutoff
2017-09-20 01:34:31.879794)
2017-09-20 01:34:52.859141 7f82c6a88700  0 osd.66 183098 crush map has
features 720595732696154112, adjusting msgr requires for osds
2017-09-20 01:34:52.861665 7f82c1a7e700  1 osd.66 pg_epoch: 183098
pg[25.6fc( v 172737'68180 (157545'65180,172737'68180] lb
25:3f604bd7:::rbd_data.02058c74dc44db.0000000000001ace:head (bitwise)
local-lis/les=3D182580/182586 n=3D8 ec=3D112668/112668 lis/c 182824/172974
les/c/f 182825/172978/0 183098/183098/182910)
[323,123,268]/[323,137,321] r=3D-1 lpr=3D183098 pi=3D[172974,183098)/2
crt=3D172737'68180 remapped NOTIFY] start_peering_interval up [323,123]
-> [323,123,268], acting [323,137,321] -> [323,137,321],
acting_primary 323 -> 323, up_primary 323 -> 323, role -1 -> -1,
features acting 2305244844532236283 upacting 2305244844532236283
2017-09-20 01:34:52.862009 7f82c1a7e700  1 osd.66 pg_epoch: 183098
pg[25.6fc( v 172737'68180 (157545'65180,172737'68180] lb
25:3f604bd7:::rbd_data.02058c74dc44db.0000000000001ace:head (bitwise)
local-lis/les=3D182580/182586 n=3D8 ec=3D112668/112668 lis/c 182824/172974
les/c/f 182825/172978/0 183098/183098/182910)
[323,123,268]/[323,137,321] r=3D-1 lpr=3D183098 pi=3D[172974,183098)/2
crt=3D172737'68180 remapped NOTIFY] state<Start>: transitioning to Stray
2017-09-20 01:34:52.862660 7f82c127d700  1 osd.66 pg_epoch: 183098
pg[25.1765( v 170313'232833 (159408'229833,170313'232833] lb MIN
(bitwise) local-lis/les=3D182705/182719 n=3D0 ec=3D112676/112676 lis/c
182119/151043 les/c/f 182120/151044/0 183098/183098/159530)
[123,323,268]/[163,243,313] r=3D-1 lpr=3D183098 pi=3D[151043,183098)/2
crt=3D170313'232833 lcod 0'0 remapped NOTIFY] start_peering_interval up
[123,323] -> [123,323,268], acting [163,243,313] -> [163,243,313],
acting_primary 163 -> 163, up_primary 123 -> 123, role -1 -> -1,
features acting 2305244844532236283 upacting 2305244844532236283
2017-09-20 01:34:52.862718 7f82c127d700  1 osd.66 pg_epoch: 183098
pg[25.1765( v 170313'232833 (159408'229833,170313'232833] lb MIN
(bitwise) local-lis/les=3D182705/182719 n=3D0 ec=3D112676/112676 lis/c
182119/151043 les/c/f 182120/151044/0 183098/183098/159530)
[123,323,268]/[163,243,313] r=3D-1 lpr=3D183098 pi=3D[151043,183098)/2
crt=3D170313'232833 lcod 0'0 remapped NOTIFY] state<Start>:
transitioning to Stray
2017-09-20 01:34:52.865002 7f82c127d700  1 osd.66 pg_epoch: 183098
pg[25.1277( v 170886'428486 (164923'425486,170886'428486] lb
25:ee485f19:::rbd_data.02079821c85ca0.0000000000001a60:head (bitwise)
local-lis/les=3D182474/182495 n=3D17 ec=3D112674/112674 lis/c 183087/174035
les/c/f 183089/174039/0 183098/183098/183067) [414,268,66]/[414,111]
r=3D-1 lpr=3D183098 pi=3D[174035,183098)/3 luod=3D0'0 crt=3D170886'428486
active+remapped] start_peering_interval up [414,66] -> [414,268,66],
acting [414,111] -> [414,111], acting_primary 414 -> 414, up_primary
414 -> 414, role -1 -> -1, features acting 2305244844532236283
upacting 2305244844532236283
2017-09-20 01:34:52.865190 7f82c1a7e700  1 osd.66 pg_epoch: 183098
pg[25.35a( v 170244'21010 (147357'18010,170244'21010] lb
25:5ac00a15:::rbd_data.0209c81be3e81c.00000000000005e8:8cf (bitwise)
local-lis/les=3D176548/176551 n=3D1 ec=3D112666/112666 lis/c 176796/157467
les/c/f 176798/157468/0 183098/183098/159530) [318,313,268]/[131,275]
r=3D-1 lpr=3D183098 pi=3D[157467,183098)/1 crt=3D170244'21010 lcod 0'0
remapped NOTIFY] start_peering_interval up [318,313] -> [318,313,268],
acting [131,275] -> [131,275], acting_primary 131 -> 131, up_primary
318 -> 318, role -1 -> -1, features acting 2305244844532236283
upacting 2305244844532236283
2017-09-20 01:34:52.865289 7f82c1a7e700  1 osd.66 pg_epoch: 183098
pg[25.35a( v 170244'21010 (147357'18010,170244'21010] lb
25:5ac00a15:::rbd_data.0209c81be3e81c.00000000000005e8:8cf (bitwise)
local-lis/les=3D176548/176551 n=3D1 ec=3D112666/112666 lis/c 176796/157467
les/c/f 176798/157468/0 183098/183098/159530) [318,313,268]/[131,275]
r=3D-1 lpr=3D183098 pi=3D[157467,183098)/1 crt=3D170244'21010 lcod 0'0
remapped NOTIFY] state<Start>: transitioning to Stray
2017-09-20 01:34:52.865295 7f82c127d700  1 osd.66 pg_epoch: 183098
pg[25.1277( v 170886'428486 (164923'425486,170886'428486] lb
25:ee485f19:::rbd_data.02079821c85ca0.0000000000001a60:head (bitwise)
local-lis/les=3D182474/182495 n=3D17 ec=3D112674/112674 lis/c 183087/174035
les/c/f 183089/174039/0 183098/183098/183067) [414,268,66]/[414,111]
r=3D-1 lpr=3D183098 pi=3D[174035,183098)/3 crt=3D170886'428486 remapped
NOTIFY] state<Start>: transitioning to Stray
2017-09-20 01:34:52.866938 7f82c127d700  1 osd.66 pg_epoch: 183098
pg[25.27c( v 170291'47116 (158296'44074,170291'47116]
local-lis/les=3D169174/169175 n=3D258 ec=3D112666/112666 lis/c 169174/16917=
4
les/c/f 169175/169188/0 183087/183087/183087) [66,440] r=3D0 lpr=3D183087
pi=3D[169174,183087)/8 crt=3D170291'47116 lcod 0'0 mlcod 0'0 down]
state<Started/Primary/Peering>: Peering, affected_by_map, going to
Reset




=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8DKern.log ------------=
----
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779332] swapper/28: page
allocation failure: order:0, mode:0x20
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779339] CPU: 28 PID: 0
Comm: swapper/28 Not tainted 3.13.0-24-generic #47-Ubuntu
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779341] Hardware name:
Dell DCS8420G/0C6G21, BIOS 1.1.3 02/06/2015
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779343]
0000000000000000 ffff88207fd83b58 ffffffff81715ac4 0000000000000020
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779350]
ffff88207fd83be0 ffffffff81153aab 00000000ffffffff ffff88207fff9e08
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779354]
0000000200000001 ffff88207fd977e0 ffff88207fd977f0 ffff88207fff9e00
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779359] Call Trace:
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779361]  <IRQ>
[<ffffffff81715ac4>] dump_stack+0x45/0x56
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779379]
[<ffffffff81153aab>] warn_alloc_failed+0xeb/0x140
Sep 19 22:45:10 slx03c-6rqx kernel: [16500140.779385]
[<ffffffff81158105>] __alloc_pages_nodemask+0x865/0xa20
Sep 19 22:45:11 slx03c-6rqx kernel: [16500140.779389]
[<ffffffff81195413>] alloc_pages_current+0xa3/0x160
Sep 19 22:45:11 slx03c-6rqx kernel: [16500140.779395]
[<ffffffff8160966c>] __netdev_alloc_frag+0x8c/0x140
Sep 19 22:45:11 slx03c-6rqx kernel: [16500140.779399]
[<ffffffff8160b707>] __netdev_alloc_skb+0x77/0xc0
Sep 19 22:45:11 slx03c-6rqx kernel: [16500140.779419]
[<ffffffffa007b9e4>] ixgbe_clean_rx_irq+0xf4/0xb10 [ixgbe]
Sep 19 22:45:11 slx03c-6rqx kernel: [16500140.779425]
[<ffffffffa007d140>] ixgbe_poll+0x460/0x800 [ixgbe]
Sep 19 22:45:11 slx03c-6rqx kernel: [16500140.779431]
[<ffffffff8161aee2>] net_rx_action+0x152/0x250
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779439]
[<ffffffff8106caec>] __do_softirq+0xec/0x2c0
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779443]
[<ffffffff8106d035>] irq_exit+0x105/0x110
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779452]
[<ffffffff817287d6>] do_IRQ+0x56/0xc0
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779461]
[<ffffffff8171df6d>] common_interrupt+0x6d/0x6d
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779462]  <EOI>
[<ffffffff815c95e2>] ? cpuidle_enter_state+0x52/0xc0
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779476]
[<ffffffff815c9709>] cpuidle_idle_call+0xb9/0x1f0
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779484]
[<ffffffff8101ceae>] arch_cpu_idle+0xe/0x30
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779489]
[<ffffffff810beb85>] cpu_startup_entry+0xc5/0x290
Sep 19 22:45:12 slx03c-6rqx kernel: [16500140.779497]
[<ffffffff81040fc8>] start_secondary+0x218/0x2c0
