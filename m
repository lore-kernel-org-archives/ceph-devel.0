From: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?=
	<maciejgalkiewicz@ragnarson.com>
Subject: Re: Problem with cephx in 0.55
Date: Tue, 25 Dec 2012 04:06:40 +0100
Message-ID: <CAGqxmDMXoiaFwxnt16b0VQtCYobm48WJYk0tLwssO1Q_FVh6oA@mail.gmail.com>
References: <CAGqxmDNyHLCKSc8z-F+XPJJG2xyYjBdgPaeM5TmZ1SM6BntfGA@mail.gmail.com>
	<20121212201353.GB24346@staff.dca.net>
	<CAGqxmDPp7ELLdfdWD2iQCp=Bc8Xbvngn3r0yV2yeGpo5pdy_nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:46573 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab2LYDN4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Dec 2012 22:13:56 -0500
Received: by mail-vc0-f182.google.com with SMTP id fy27so7851027vcb.41
        for <ceph-devel@vger.kernel.org>; Mon, 24 Dec 2012 19:13:55 -0800 (PST)
In-Reply-To: <CAGqxmDPp7ELLdfdWD2iQCp=Bc8Xbvngn3r0yV2yeGpo5pdy_nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Morgan <mmorgan@dca.net>
Cc: ceph-devel@vger.kernel.org

On 12 December 2012 23:20, Maciej Ga=C5=82kiewicz
<maciejgalkiewicz@ragnarson.com> wrote:
>>  Try removing the "=3D" from the osd cap, ie.
>
> Already tried and it did not help.

I have found two tickets probably related to this issue:
http://tracker.newdream.net/issues/3226
http://tracker.newdream.net/issues/3228

I was thinking that maybe following change is responsible for my proble=
m:
http://tracker.newdream.net/projects/ceph/repository/revisions/303f640c=
e561c22a85a16b49585a22115273f790/diff/src/osd/OSDCap.cc

I achieved something really weird for me. I can map rbd volume with
exactly the same command on one VM but not on the other:

VM1# cat /tmp/secret
AQBFAtNQwH9qHhAAdtwsbPKwmP1p3FTdmy0+Rg=3D=3D
VM2# rbd map postgresql --pool winnie-test --id winnie-test --keyfile
/tmp/secret
add failed: (1) Operation not permitted

VM2# cat /tmp/secret
AQBFAtNQwH9qHhAAdtwsbPKwmP1p3FTdmy0+Rg=3D=3D
VM2# rbd map postgresql --pool winnie-test --id winnie-test --keyfile
/tmp/secret
VM2# rbd showmapped
id      pool    image   snap    device
0       cephx   vol     -       /dev/rbd0
1       winnie-test     redis   -       /dev/rbd1
2       winnie-test     test    -       /dev/rbd2
3       winnie-test     mongodb -       /dev/rbd3
4       winnie-test     postgresql      -       /dev/rbd4

Of course ceph.conf looks exactly the same on both machines. Caps
configured just like in manual
(https://github.com/ceph/ceph/commit/7ea8f16e225d3b164828e5d25b262b3eb1=
56a165).
MON# ceph auth list
=2E..
client.winnie-test
        key: AQBFAtNQwH9qHhAAdtwsbPKwmP1p3FTdmy0+Rg=3D=3D
        caps: [mon] allow r
        caps: [osd] allow pool winnie-test rwx

On VM2 I have mapped volume redis when caps looked like this:
client.winnie-test
        key: AQBFAtNQwH9qHhAAdtwsbPKwmP1p3FTdmy0+Rg=3D=3D
        caps: [mon] allow r
        caps: [osd] allow rwx

and then changed them to those with pool limitation.

Is it possible that the pool is somehow broken? I managed to map
volumes from completely new pool created after the upgrade. It is not
enough for me because I still need to upgrade production cluster
without downtime.

Logs from monitor when mapping on VM2:
2012-12-25 03:55:08.262504 7fe0982d5700 10 mon.cc@0(leader).auth v2019
update_from_paxos()
2012-12-25 03:55:08.262513 7fe0982d5700 10 mon.cc@0(leader).auth v2019 =
auth
2012-12-25 03:55:08.262516 7fe0982d5700 10 cephx keyserver:
_check_rotating_secrets
2012-12-25 03:55:09.611592 7fe0963cb700  1 -- 10.255.128.1:6789/0 >>
:/0 pipe(0x26d9b00 sd=3D21 :6789 pgs=3D0 cs=3D0 l=3D0).accept sd=3D21
2012-12-25 03:55:09.611642 7fe0963cb700  0 -- 10.255.128.1:6789/0 >>
10.255.0.16:0/903309176 pipe(0x26d9b00 sd=3D21 :6789 pgs=3D0 cs=3D0
l=3D0).accept peer addr is really 10.25
5.0.16:0/903309176 (socket is 10.255.0.16:36850/0)
2012-12-25 03:55:09.611665 7fe0963cb700 10 mon.cc@0(leader) e2
ms_verify_authorizer 10.255.0.16:0/903309176 client protocol 0
2012-12-25 03:55:09.611674 7fe0963cb700 10 In get_auth_session_handler
for protocol 0
2012-12-25 03:55:09.611905 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
client.11617 10.255.0.16:0/903309176 1 =3D=3D=3D=3D auth(proto 0 40 byt=
es
epoch 0) =3D=3D=3D=3D 66+0+0 (3435522658
 0 0) 0x26db200 con 0x26f7a20
2012-12-25 03:55:09.611922 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:55:09.611928 7fe097ad4700 10 mon.cc@0(leader) e2 do not
have session, making new one
2012-12-25 03:55:09.611934 7fe097ad4700 10 mon.cc@0(leader) e2
ms_dispatch new session MonSession: client.11617
10.255.0.16:0/903309176 is open for client.11617 10.255.
0.16:0/903309176
2012-12-25 03:55:09.611942 7fe097ad4700 10 mon.cc@0(leader) e2 setting
timeout on session
2012-12-25 03:55:09.611946 7fe097ad4700 20 mon.cc@0(leader) e2  caps
2012-12-25 03:55:09.611958 7fe097ad4700 10 mon.cc@0(leader).auth v2019
update_from_paxos()
2012-12-25 03:55:09.611962 7fe097ad4700 10 mon.cc@0(leader).auth v2019
preprocess_query auth(proto 0 40 bytes epoch 0) from client.11617
10.255.0.16:0/903309176
2012-12-25 03:55:09.611968 7fe097ad4700 10 mon.cc@0(leader).auth v2019
prep_auth() blob_size=3D40
2012-12-25 03:55:09.611982 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.16:0/903309176 -- mon_map v1 -- ?+0 0x28001e0 con 0x26f7a20
2012-12-25 03:55:09.612021 7fe097ad4700 10 cephx server
client.winnie-test: start_session server_challenge 80a9fc35fd9f5d17
2012-12-25 03:55:09.612028 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.16:0/903309176 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x27d4a00 con 0x26f7a20
2012-12-25 03:55:09.612303 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
client.11617 10.255.0.16:0/903309176 2 =3D=3D=3D=3D auth(proto 2 144 by=
tes
epoch 0) =3D=3D=3D=3D 170+0+0 (29998387
98 0 0) 0x27d5200 con 0x26f7a20
2012-12-25 03:55:09.612318 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:55:09.612321 7fe097ad4700 20 mon.cc@0(leader) e2
ms_dispatch existing session MonSession: client.11617
10.255.0.16:0/903309176 is open for client.11617
10.255.0.16:0/903309176
2012-12-25 03:55:09.612330 7fe097ad4700 20 mon.cc@0(leader) e2  caps
2012-12-25 03:55:09.612340 7fe097ad4700 10 mon.cc@0(leader).auth v2019
update_from_paxos()
2012-12-25 03:55:09.612343 7fe097ad4700 10 mon.cc@0(leader).auth v2019
preprocess_query auth(proto 2 144 bytes epoch 0) from client.11617
10.255.0.16:0/903309176
2012-12-25 03:55:09.612349 7fe097ad4700 10 mon.cc@0(leader).auth v2019
prep_auth() blob_size=3D144
2012-12-25 03:55:09.612353 7fe097ad4700 10 cephx server
client.winnie-test: handle_request get_auth_session_key for
client.winnie-test
2012-12-25 03:55:09.612411 7fe097ad4700 20 cephx server
client.winnie-test:  checking key: req.key=3D1640729a9e305c31
expected_key=3D1640729a9e305c31
2012-12-25 03:55:09.612478 7fe097ad4700 10 cephx server
client.winnie-test: decoded old_ticket with global_id=3D11617
2012-12-25 03:55:09.612510 7fe097ad4700 10 cephx:
build_service_ticket_reply encoding 1 tickets with secret
AQBFAtNQwH9qHhAAdtwsbPKwmP1p3FTdmy0+Rg=3D=3D
2012-12-25 03:55:09.612551 7fe097ad4700 10 cephx: build_service_ticket
service auth secret_id 134 ticket_info.ticket.name=3Dclient.winnie-test
2012-12-25 03:55:09.612606 7fe097ad4700 10 cephx keyserverdata:
get_caps: name=3Dclient.winnie-test
2012-12-25 03:55:09.612614 7fe097ad4700 10 cephx keyserverdata:
get_secret: num of caps=3D2
2012-12-25 03:55:09.612627 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.16:0/903309176 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x26db200 con 0x26f7a20
2012-12-25 03:55:09.612895 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
client.11617 10.255.0.16:0/903309176 3 =3D=3D=3D=3D mon_subscribe({monm=
ap=3D0+})
=3D=3D=3D=3D 31+0+0 (2650579135 0 0) 0x2740e00 con 0x26f7a20
2012-12-25 03:55:09.612911 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:55:09.612914 7fe097ad4700 20 mon.cc@0(leader) e2
ms_dispatch existing session MonSession: client.11617
10.255.0.16:0/903309176 is openallow r for client.11617
10.255.0.16:0/903309176
2012-12-25 03:55:09.612922 7fe097ad4700 20 mon.cc@0(leader) e2  caps al=
low r
2012-12-25 03:55:09.612925 7fe097ad4700 10 mon.cc@0(leader) e2
handle_subscribe mon_subscribe({monmap=3D0+})
2012-12-25 03:55:09.612933 7fe097ad4700 10 mon.cc@0(leader) e2
check_sub monmap next 0 have 2
2012-12-25 03:55:09.612940 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.16:0/903309176 -- mon_map v1 -- ?+0 0x28005a0 con 0x26f7a20
2012-12-25 03:55:09.612966 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
client.11617 10.255.0.16:0/903309176 -- mon_subscribe_ack(300s) v1 --
?+0 0x2704ea0
2012-12-25 03:55:11.906561 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
mds.0 10.255.128.1:6800/16937 7 =3D=3D=3D=3D mdsbeacon(11597/cc up:acti=
ve seq
1407 v168) v2 =3D=3D=3D=3D 241+0+0 (4249480194 0 0) 0x26e3080 con 0x26f=
7080
2012-12-25 03:55:11.906586 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:55:11.906590 7fe097ad4700 20 mon.cc@0(leader) e2
ms_dispatch existing session MonSession: mds.0 10.255.128.1:6800/16937
is openallow rwx for mds.0 10.255.128.1:6800/16937
2012-12-25 03:55:11.906596 7fe097ad4700 20 mon.cc@0(leader) e2  caps al=
low rwx
2012-12-25 03:55:11.906607 7fe097ad4700 10 mon.cc@0(leader).mds e168
preprocess_query mdsbeacon(11597/cc up:active seq 1407 v168) v2 from
mds.0 10.255.128.1:6800/16937
2012-12-25 03:55:11.906614 7fe097ad4700 12 mon.cc@0(leader).mds e168
preprocess_beacon mdsbeacon(11597/cc up:active seq 1407 v168) v2 from
mds.0 10.255.128.1:6800/16937 compat=3D{},rocompat=3D{},incompat=3D{1=3D=
base
v0.20,2=3Dclient writeable ranges,3=3Ddefault file layouts on dirs,4=3D=
dir
inode in separate object}
2012-12-25 03:55:11.906622 7fe097ad4700 15 mon.cc@0(leader).mds e168
_note_beacon mdsbeacon(11597/cc up:active seq 1407 v168) v2 noting
time
2012-12-25 03:55:11.906627 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.128.1:6800/16937 -- mdsbeacon(11597/cc up:active seq 1407 v168)
v2 -- ?+0 0x26e38c0 con 0x26f7080
2012-12-25 03:55:13.262652 7fe0982d5700 11 mon.cc@0(leader) e2 tick
2012-12-25 03:55:13.262679 7fe0982d5700 10 mon.cc@0(leader).pg v830408
v830408: 408 pgs: 384 active+remapped, 24 active+degraded; 242 MB
data, 27478 MB used, 321 GB / 349 GB avail; 120/282 degraded (42.553%)
2012-12-25 03:55:13.262712 7fe0982d5700 10 mon.cc@0(leader).mds e168
e168: 1/1/1 up {0=3Dcc=3Dup:active}
2012-12-25 03:55:13.262726 7fe0982d5700 10 mon.cc@0(leader).osd e809
e809: 2 osds: 2 up, 2 in
2012-12-25 03:55:13.262779 7fe0982d5700 10 mon.cc@0(leader).osd e809
min_last_epoch_clean 806
2012-12-25 03:55:13.262789 7fe0982d5700 10 mon.cc@0(leader).log v832208=
 log
2012-12-25 03:55:13.262795 7fe0982d5700 10 mon.cc@0(leader).auth v2019
update_from_paxos()
2012-12-25 03:55:13.262799 7fe0982d5700 10 mon.cc@0(leader).auth v2019 =
auth

Logs from monitor when mapping on VM1:
2012-12-25 03:59:26.213790 7fe0961c9700  0 -- 10.255.128.1:6789/0 >>
10.255.0.13:0/816657923 pipe(0x283f8c0 sd=3D22 :6789 pgs=3D0 cs=3D0
l=3D0).accept peer addr is really 10.25
5.0.13:0/816657923 (socket is 10.255.0.13:39799/0)
2012-12-25 03:59:26.213806 7fe0961c9700 10 mon.cc@0(leader) e2
ms_verify_authorizer 10.255.0.13:0/816657923 client protocol 0
2012-12-25 03:59:26.213812 7fe0961c9700 10 In get_auth_session_handler
for protocol 0
2012-12-25 03:59:26.214061 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
unknown.0 10.255.0.13:0/816657923 1 =3D=3D=3D=3D auth(proto 0 40 bytes =
epoch
0) =3D=3D=3D=3D 66+0+0 (745319961 0 0
) 0x26dba00 con 0x26f78c0
2012-12-25 03:59:26.214080 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:59:26.214083 7fe097ad4700 10 mon.cc@0(leader) e2 do not
have session, making new one
2012-12-25 03:59:26.214086 7fe097ad4700 10 mon.cc@0(leader) e2
ms_dispatch new session MonSession: unknown.0 10.255.0.13:0/816657923
is open for unknown.0 10.255.0.13:0
/816657923
2012-12-25 03:59:26.214091 7fe097ad4700 10 mon.cc@0(leader) e2 setting
timeout on session
2012-12-25 03:59:26.214094 7fe097ad4700 20 mon.cc@0(leader) e2  caps
2012-12-25 03:59:26.214103 7fe097ad4700 10 mon.cc@0(leader).auth v2019
update_from_paxos()
2012-12-25 03:59:26.214105 7fe097ad4700 10 mon.cc@0(leader).auth v2019
preprocess_query auth(proto 0 40 bytes epoch 0) from unknown.0
10.255.0.13:0/816657923
2012-12-25 03:59:26.214115 7fe097ad4700 10 mon.cc@0(leader).auth v2019
prep_auth() blob_size=3D40
2012-12-25 03:59:26.214124 7fe097ad4700 10 mon.cc@0(leader).auth v2019
AuthMonitor::assign_global_id m=3Dauth(proto 0 40 bytes epoch 0) mon=3D=
0/1
last_allocated=3D11696 max_g
lobal_id=3D11696
2012-12-25 03:59:26.214146 7fe097ad4700 10 mon.cc@0(leader).auth v2019
prepare_update auth(proto 0 40 bytes epoch 0) from unknown.0
10.255.0.13:0/816657923
2012-12-25 03:59:26.214150 7fe097ad4700 10 mon.cc@0(leader).auth v2019
prep_auth() blob_size=3D40
2012-12-25 03:59:26.214154 7fe097ad4700 10 mon.cc@0(leader).auth v2019
AuthMonitor::assign_global_id m=3Dauth(proto 0 40 bytes epoch 0) mon=3D=
0/1
last_allocated=3D11696 max_g
lobal_id=3D11696
2012-12-25 03:59:26.214157 7fe097ad4700 10 mon.cc@0(leader).auth v2019
increasing max_global_id to 11796
2012-12-25 03:59:26.214163 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.13:0/816657923 -- mon_map v1 -- ?+0 0x2800960 con 0x26f78c0
2012-12-25 03:59:26.214190 7fe097ad4700 10 cephx server
client.winnie-test: start_session server_challenge e8fbf2c4dfb02344
2012-12-25 03:59:26.214195 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.13:0/816657923 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x26dbc00 con 0x26f78c0
2012-12-25 03:59:26.214206 7fe097ad4700 10 mon.cc@0(leader).auth v2019
encode_pending v 2020
2012-12-25 03:59:26.214210 7fe097ad4700 20 mon.cc@0(leader) e2
get_global_paxos_version 1665629
2012-12-25 03:59:26.214223 7fe097ad4700 15 store(/srv/ceph/mon) put_bl
auth/2020 =3D 19 bytes
2012-12-25 03:59:26.240769 7fe097ad4700 15 store(/srv/ceph/mon)
set_int auth_gv/2020 =3D 1665629
2012-12-25 03:59:26.265611 7fe097ad4700 15 store(/srv/ceph/mon)
set_int auth/last_committed =3D 2020
2012-12-25 03:59:26.303288 7fe097ad4700 10 mon.cc@0(leader).auth v2020
update_from_paxos()
2012-12-25 03:59:26.303309 7fe097ad4700 20 store(/srv/ceph/mon)
reading at off 0 of 19
2012-12-25 03:59:26.303316 7fe097ad4700 15 store(/srv/ceph/mon) get_bl
auth/2020 =3D 19 bytes
2012-12-25 03:59:26.303320 7fe097ad4700 10 mon.cc@0(leader).auth v2020
update_from_paxos() last_allocated_id=3D11697 max_global_id=3D11796
2012-12-25 03:59:26.303366 7fe097ad4700 15 store(/srv/ceph/mon) put_bl
auth/latest =3D 2035 bytes
2012-12-25 03:59:26.390068 7fe097ad4700 15 store(/srv/ceph/mon)
erase_ss auth/1999
2012-12-25 03:59:26.390205 7fe097ad4700 15 store(/srv/ceph/mon)
set_int auth/first_committed =3D 2000
2012-12-25 03:59:26.431526 7fe097ad4700 10 mon.cc@0(leader).auth v2020
create_pending v 2021
2012-12-25 03:59:26.431536 7fe097ad4700 10 mon.cc@0(leader).auth v2020
AuthMonitor::on_active()
2012-12-25 03:59:26.431540 7fe097ad4700 10 cephx keyserver:
_check_rotating_secrets
2012-12-25 03:59:26.431553 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
unknown.0 10.255.0.13:0/816657923 2 =3D=3D=3D=3D auth(proto 2 32 bytes =
epoch
0) =3D=3D=3D=3D 58+0+0 (1292146797 0
0) 0x26db200 con 0x26f78c0
2012-12-25 03:59:26.431566 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:59:26.431570 7fe097ad4700 20 mon.cc@0(leader) e2
ms_dispatch existing session MonSession: unknown.0
10.255.0.13:0/816657923 is open for unknown.0 10.255.0
=2E13:0/816657923
2012-12-25 03:59:26.431578 7fe097ad4700 20 mon.cc@0(leader) e2  caps
2012-12-25 03:59:26.431589 7fe097ad4700 10 mon.cc@0(leader).auth v2020
update_from_paxos()
2012-12-25 03:59:26.431592 7fe097ad4700 10 mon.cc@0(leader).auth v2020
preprocess_query auth(proto 2 32 bytes epoch 0) from unknown.0
10.255.0.13:0/816657923
2012-12-25 03:59:26.431598 7fe097ad4700 10 mon.cc@0(leader).auth v2020
prep_auth() blob_size=3D32
2012-12-25 03:59:26.431601 7fe097ad4700 10 cephx server
client.winnie-test: handle_request get_auth_session_key for
client.winnie-test
2012-12-25 03:59:26.431659 7fe097ad4700 20 cephx server
client.winnie-test:  checking key: req.key=3D24efef80f27143fa
expected_key=3D24efef80f27143fa
2012-12-25 03:59:26.431700 7fe097ad4700 10 cephx:
build_service_ticket_reply encoding 1 tickets with secret
AQBFAtNQwH9qHhAAdtwsbPKwmP1p3FTdmy0+Rg=3D=3D
2012-12-25 03:59:26.431739 7fe097ad4700 10 cephx: build_service_ticket
service auth secret_id 134 ticket_info.ticket.name=3Dclient.winnie-test
2012-12-25 03:59:26.431772 7fe097ad4700 10 cephx keyserverdata:
get_caps: name=3Dclient.winnie-test
2012-12-25 03:59:26.431779 7fe097ad4700 10 cephx keyserverdata:
get_secret: num of caps=3D2
2012-12-25 03:59:26.431792 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.13:0/816657923 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x26dba00 con 0x26f78c0
2012-12-25 03:59:26.432154 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
unknown.0 10.255.0.13:0/816657923 3 =3D=3D=3D=3D auth(proto 2 181 bytes=
 epoch
0) =3D=3D=3D=3D 207+0+0 (3268636739
0 0) 0x26dae00 con 0x26f78c0
2012-12-25 03:59:26.432173 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:59:26.432175 7fe097ad4700 20 mon.cc@0(leader) e2
ms_dispatch existing session MonSession: unknown.0
10.255.0.13:0/816657923 is openallow r for unknown.0 1
0.255.0.13:0/816657923
2012-12-25 03:59:26.432181 7fe097ad4700 20 mon.cc@0(leader) e2  caps al=
low r
2012-12-25 03:59:26.432189 7fe097ad4700 10 mon.cc@0(leader).auth v2020
update_from_paxos()
2012-12-25 03:59:26.432191 7fe097ad4700 10 mon.cc@0(leader).auth v2020
preprocess_query auth(proto 2 181 bytes epoch 0) from unknown.0
10.255.0.13:0/816657923
2012-12-25 03:59:26.432194 7fe097ad4700 10 mon.cc@0(leader).auth v2020
prep_auth() blob_size=3D181
2012-12-25 03:59:26.432197 7fe097ad4700 10 cephx server
client.winnie-test: handle_request get_principal_session_key
2012-12-25 03:59:26.432199 7fe097ad4700 10 cephx: verify_authorizer
decrypted service auth secret_id=3D134
2012-12-25 03:59:26.432231 7fe097ad4700 10 cephx: verify_authorizer
global_id=3D11697
2012-12-25 03:59:26.432259 7fe097ad4700 10 cephx: verify_authorizer ok
nonce a007d6f1f482ed4b reply_bl.length()=3D36
2012-12-25 03:59:26.432266 7fe097ad4700 10 cephx server
client.winnie-test:  ticket_req.keys =3D 7
2012-12-25 03:59:26.432268 7fe097ad4700 10 cephx server
client.winnie-test:  adding key for service mon
2012-12-25 03:59:26.432287 7fe097ad4700 10 cephx server
client.winnie-test:  adding key for service mds
2012-12-25 03:59:26.432300 7fe097ad4700 10 cephx keyserverdata:
get_caps: name=3Dclient.winnie-test
2012-12-25 03:59:26.432306 7fe097ad4700 10 cephx keyserverdata:
get_secret: num of caps=3D2
2012-12-25 03:59:26.432309 7fe097ad4700 10 cephx server
client.winnie-test:  adding key for service osd
2012-12-25 03:59:26.432322 7fe097ad4700 10 cephx keyserverdata:
get_caps: name=3Dclient.winnie-test
2012-12-25 03:59:26.432324 7fe097ad4700 10 cephx keyserverdata:
get_secret: num of caps=3D2
2012-12-25 03:59:26.432328 7fe097ad4700 10 cephx:
build_service_ticket_reply encoding 3 tickets with secret
AQCOFtlQyBy7GRAAEaTb/F1TkIaNgEf8EoJr5A=3D=3D
2012-12-25 03:59:26.432350 7fe097ad4700 10 cephx: build_service_ticket
service mon secret_id 1590 ticket_info.ticket.name=3Dclient.winnie-test
2012-12-25 03:59:26.432379 7fe097ad4700 10 cephx: build_service_ticket
service mds secret_id 1590 ticket_info.ticket.name=3Dclient.winnie-test
2012-12-25 03:59:26.432413 7fe097ad4700 10 cephx: build_service_ticket
service osd secret_id 1590 ticket_info.ticket.name=3Dclient.winnie-test
2012-12-25 03:59:26.432438 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.13:0/816657923 -- auth_reply(proto 2 0 Success) v1 -- ?+0
0x26db200 con 0x26f78c0
2012-12-25 03:59:26.432766 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
client.11697 10.255.0.13:0/816657923 4 =3D=3D=3D=3D
mon_subscribe({monmap=3D0+,osdmap=3D0}) =3D=3D=3D=3D 58+0+0 (631413433 =
0 0)
0x2743500 con 0x26f78c0
2012-12-25 03:59:26.432780 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:59:26.432782 7fe097ad4700 20 mon.cc@0(leader) e2
ms_dispatch existing session MonSession: unknown.0
10.255.0.13:0/816657923 is openallow r for unknown.0
10.255.0.13:0/816657923
2012-12-25 03:59:26.432787 7fe097ad4700 20 mon.cc@0(leader) e2  caps al=
low r
2012-12-25 03:59:26.432789 7fe097ad4700 10 mon.cc@0(leader) e2
handle_subscribe mon_subscribe({monmap=3D0+,osdmap=3D0})
2012-12-25 03:59:26.432795 7fe097ad4700 10 mon.cc@0(leader) e2
check_sub monmap next 0 have 2
2012-12-25 03:59:26.432800 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.0.13:0/816657923 -- mon_map v1 -- ?+0 0x2800780 con 0x26f78c0
2012-12-25 03:59:26.432951 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
unknown.0 10.255.0.13:0/816657923 -- osd_map(809..809 src has
309..809) v3 -- ?+0 0x26dae00
2012-12-25 03:59:26.432968 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
client.11697 10.255.0.13:0/816657923 -- mon_subscribe_ack(300s) v1 --
?+0 0x2705040
2012-12-25 03:59:26.437142 7fe097ad4700 10 mon.cc@0(leader) e2
ms_handle_reset 0x26f78c0 10.255.0.13:0/816657923
2012-12-25 03:59:26.437155 7fe097ad4700 10 mon.cc@0(leader) e2
reset/close on session unknown.0 10.255.0.13:0/816657923
2012-12-25 03:59:26.437159 7fe097ad4700 10 mon.cc@0(leader) e2
remove_session MonSession: unknown.0 10.255.0.13:0/816657923 is
openallow r unknown.0 10.255.0.13:0/816657923
2012-12-25 03:59:27.918541 7fe097ad4700  1 -- 10.255.128.1:6789/0 <=3D=3D
mds.0 10.255.128.1:6800/16937 72 =3D=3D=3D=3D mdsbeacon(11597/cc up:act=
ive seq
1471 v168) v2 =3D=3D=3D=3D 241+0+0 (2761870254 0 0) 0x26e3080 con 0x26f=
7080
2012-12-25 03:59:27.918568 7fe097ad4700 20 mon.cc@0(leader) e2 have con=
nection
2012-12-25 03:59:27.918571 7fe097ad4700 20 mon.cc@0(leader) e2
ms_dispatch existing session MonSession: mds.0 10.255.128.1:6800/16937
is openallow rwx for mds.0 10.255.128.1:6800/16937
2012-12-25 03:59:27.918578 7fe097ad4700 20 mon.cc@0(leader) e2  caps al=
low rwx
2012-12-25 03:59:27.918591 7fe097ad4700 10 mon.cc@0(leader).mds e168
preprocess_query mdsbeacon(11597/cc up:active seq 1471 v168) v2 from
mds.0 10.255.128.1:6800/16937
2012-12-25 03:59:27.918597 7fe097ad4700 12 mon.cc@0(leader).mds e168
preprocess_beacon mdsbeacon(11597/cc up:active seq 1471 v168) v2 from
mds.0 10.255.128.1:6800/16937 compat=3D{},rocompat=3D{},incompat=3D{1=3D=
base
v0.20,2=3Dclient writeable ranges,3=3Ddefault file layouts on dirs,4=3D=
dir
inode in separate object}
2012-12-25 03:59:27.918606 7fe097ad4700 15 mon.cc@0(leader).mds e168
_note_beacon mdsbeacon(11597/cc up:active seq 1471 v168) v2 noting
time
2012-12-25 03:59:27.918610 7fe097ad4700  1 -- 10.255.128.1:6789/0 -->
10.255.128.1:6800/16937 -- mdsbeacon(11597/cc up:active seq 1471 v168)
v2 -- ?+0 0x26e3340 con 0x26f7080
2012-12-25 03:59:28.276900 7fe0982d5700 11 mon.cc@0(leader) e2 tick
2012-12-25 03:59:28.276924 7fe0982d5700 10 mon.cc@0(leader).pg v830415
v830415: 408 pgs: 384 active+remapped, 24 active+degraded; 242 MB
data, 27478 MB used, 321 GB / 349 GB avail; 120/282 degraded (42.553%)
2012-12-25 03:59:28.276961 7fe0982d5700 10 mon.cc@0(leader).mds e168
e168: 1/1/1 up {0=3Dcc=3Dup:active}
2012-12-25 03:59:28.276971 7fe0982d5700 10 mon.cc@0(leader).osd e809
e809: 2 osds: 2 up, 2 in
2012-12-25 03:59:28.277010 7fe0982d5700 10 mon.cc@0(leader).osd e809
min_last_epoch_clean 806
2012-12-25 03:59:28.277016 7fe0982d5700 10 mon.cc@0(leader).log v832215=
 log
2012-12-25 03:59:28.277020 7fe0982d5700 10 mon.cc@0(leader).auth v2020
update_from_paxos()
2012-12-25 03:59:28.277025 7fe0982d5700 10 mon.cc@0(leader).auth v2020 =
auth
2012-12-25 03:59:28.277029 7fe0982d5700 10 cephx keyserver:
_check_rotating_secrets

Logs from VM1:
Dec 25 03:59:26 Debian-50-lenny-64-minimal kernel: [ 2377.382344]
libceph: client0 fsid d0c0d7d4-67cf-4c3b-ab83-e73fab897e17
Dec 25 03:59:26 Debian-50-lenny-64-minimal kernel: [ 2377.602640]
libceph: mon0 10.255.128.1:6789 session established

regards
Maciej Galkiewicz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
