From: Masuko Tomoya <tomoya.masuko@gmail.com>
Subject: Re: couldn't use rbd
Date: Fri, 3 Feb 2012 00:51:25 -0800
Message-ID: <CAM2zNoOgENLwoziggjN-Xi=iOqKwa914i7JTUDonvFGw9OjJ9w@mail.gmail.com>
References: <CAM2zNoOyURtLAzh=DNcPjazj1RpgEY7WeJ_-QVjOWzbTp+qSUQ@mail.gmail.com>
	<4F2B37DB.4070506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:45198 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754588Ab2BCIv1 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Feb 2012 03:51:27 -0500
Received: by lbom4 with SMTP id m4so518117lbo.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2012 00:51:26 -0800 (PST)
In-Reply-To: <4F2B37DB.4070506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@dreamhost.com
Cc: ceph-devel@vger.kernel.org

Hi Josh,

Thank you for reply !

> This might mean the rbd image list object can't be read for some
> reason, or the rbd tool is doing something weird that the rados tool
> isn't. Can you share the output of 'ceph -s' and
> 'rbd ls --log-to-stderr --debug-ms 1 --debug-objecter 20 --debug-monc=
 20
> --debug-auth 20'?

The output of 'ceph -s' is below.
-------
root@ceph01:~# ceph -s
2012-02-03 17:01:47.881960    pg v33: 6 pgs: 6 active+clean+degraded;
0 KB data, 1056 KB used, 15357 MB / 15358 MB avail
2012-02-03 17:01:47.882583   mds e9: 1/1/1 up {0=3D0=3Dup:creating}
2012-02-03 17:01:47.882733   osd e21: 1 osds: 1 up, 1 in
2012-02-03 17:01:47.883042   log 2012-02-03 16:35:11.183897 osd.0
10.68.119.191:6801/2912 12 : [WRN] map e19 wrongly marked me down or
wrong addr
2012-02-03 17:01:47.883144   mon e1: 1 mons at {0=3D10.68.119.191:6789/=
0}

The output of 'rbd ls --log-to-stderr --debug-ms 1 --debug-objecter 20
--debug-monc 20 --debug-auth 20' is below.
------
root@ceph01:~# rbd ls --log-to-stderr --debug-ms 1 --debug-objecter 20
--debug-monc 20 --debug-auth 20
2012-02-03 17:02:10.910598 7f88cbb91720 monclient(hunting): build_initi=
al_monmap
2012-02-03 17:02:10.910912 7f88cbb91720 -- :/0 messenger.start
2012-02-03 17:02:10.910966 7f88cbb91720 monclient(hunting): init
2012-02-03 17:02:10.911268 7f88cbb91720 auth: KeyRing::load: loaded
key file /etc/ceph/keyring.bin
2012-02-03 17:02:10.911952 7f88cbb91720 monclient(hunting): supporting
cephx auth protocol
2012-02-03 17:02:10.911984 7f88cbb91720 monclient(hunting): _reopen_ses=
sion
2012-02-03 17:02:10.912098 7f88cbb91720 monclient(hunting):
_pick_new_mon picked mon.0 con 0x24603e0 addr 10.68.119.191:6789/0
2012-02-03 17:02:10.912124 7f88cbb91720 monclient(hunting):
_send_mon_message to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:02:10.951553 7f88cbb91720 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x24606f0 con
0x24603e0
2012-02-03 17:02:10.951729 7f88cbb8f710 -- 10.68.119.191:0/1003500
learned my addr 10.68.119.191:0/1003500
2012-02-03 17:02:10.952949 7f88cbb91720 monclient(hunting): renew_subs
2012-02-03 17:02:10.953012 7f88cbb91720 monclient(hunting):
authenticate will time out at 2012-02-03 17:02:40.952983
2012-02-03 17:02:10.953392 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 1 =3D=3D=3D=3D auth_reply(proto 2 0 Success)=
 v1
=3D=3D=3D=3D 33+0+0 (1661896955 0 0) 0x24608d0 con 0x24603e0
2012-02-03 17:02:10.953444 7f88c9366710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:02:10.953455 7f88c9366710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:02:10.953462 7f88c9366710 cephx: set_have_need_key no
handler for service auth
2012-02-03 17:02:10.953504 7f88c9366710 cephx: validate_tickets want
37 have 0 need 37
2012-02-03 17:02:10.953526 7f88c9366710 monclient(hunting): my global_i=
d is 4106
2012-02-03 17:02:10.953546 7f88c9366710 cephx client: handle_response r=
et =3D 0
2012-02-03 17:02:10.953557 7f88c9366710 cephx client:  got initial
server challenge 15014444581746095987
2012-02-03 17:02:10.953575 7f88c9366710 cephx client: build_request
2012-02-03 17:02:10.953586 7f88c9366710 cephx client:
validate_tickets: want=3D37 need=3D37 have=3D0
2012-02-03 17:02:10.953592 7f88c9366710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:02:10.953598 7f88c9366710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:02:10.953604 7f88c9366710 cephx: set_have_need_key no
handler for service auth
2012-02-03 17:02:10.953610 7f88c9366710 cephx: validate_tickets want
37 have 0 need 37
2012-02-03 17:02:10.953617 7f88c9366710 cephx client: want=3D37 need=3D=
37 have=3D0
2012-02-03 17:02:10.953920 7f88c9366710 cephx client: get auth session
key: client_challenge 394141338555354357
2012-02-03 17:02:10.953953 7f88c9366710 monclient(hunting):
_send_mon_message to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:02:10.953967 7f88c9366710 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6789/0 -- auth(proto 2 32 bytes) v1 -- ?+0 0x24608d0 con
0x24603e0
2012-02-03 17:02:10.954517 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success)=
 v1
=3D=3D=3D=3D 206+0+0 (707160412 0 0) 0x24608d0 con 0x24603e0
2012-02-03 17:02:10.954535 7f88c9366710 cephx client: handle_response r=
et =3D 0
2012-02-03 17:02:10.954555 7f88c9366710 cephx client:  get_auth_session=
_key
2012-02-03 17:02:10.954576 7f88c9366710 cephx:
verify_service_ticket_reply got 1 keys
2012-02-03 17:02:10.954587 7f88c9366710 cephx: got key for service_id a=
uth
2012-02-03 17:02:10.954696 7f88c9366710 cephx:  ticket.secret_id=3D2
2012-02-03 17:02:10.954737 7f88c9366710 cephx:
verify_service_ticket_reply service auth secret_id 2 session_key
AQCClCtPyL7gOBAAaDicPRG6NHbgUs+4YNntWQ=3D=3D validity=3D43200.000000
2012-02-03 17:02:10.954756 7f88c9366710 cephx: ticket
expires=3D2012-02-04 05:02:10.954749 renew_after=3D2012-02-04
02:02:10.954749
2012-02-03 17:02:10.954764 7f88c9366710 cephx client:  want=3D37 need=3D=
37 have=3D0
2012-02-03 17:02:10.954771 7f88c9366710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:02:10.954777 7f88c9366710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:02:10.954783 7f88c9366710 cephx: validate_tickets want
37 have 32 need 5
2012-02-03 17:02:10.954792 7f88c9366710 cephx client: build_request
2012-02-03 17:02:10.954798 7f88c9366710 cephx client:
validate_tickets: want=3D37 need=3D5 have=3D32
2012-02-03 17:02:10.954804 7f88c9366710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:02:10.954810 7f88c9366710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:02:10.954816 7f88c9366710 cephx: validate_tickets want
37 have 32 need 5
2012-02-03 17:02:10.954823 7f88c9366710 cephx client: want=3D37 need=3D=
5 have=3D32
2012-02-03 17:02:10.954829 7f88c9366710 cephx client: get service
keys: want=3D37 need=3D5 have=3D32
2012-02-03 17:02:10.954875 7f88c9366710 monclient(hunting):
_send_mon_message to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:02:10.954891 7f88c9366710 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6789/0 -- auth(proto 2 165 bytes) v1 -- ?+0 0x24608d0
con 0x24603e0
2012-02-03 17:02:10.955499 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 3 =3D=3D=3D=3D auth_reply(proto 2 0 Success)=
 v1
=3D=3D=3D=3D 409+0+0 (2367917727 0 0) 0x2460df0 con 0x24603e0
2012-02-03 17:02:10.955518 7f88c9366710 cephx client: handle_response r=
et =3D 0
2012-02-03 17:02:10.955534 7f88c9366710 cephx client:
get_principal_session_key session_key
AQCClCtPyL7gOBAAaDicPRG6NHbgUs+4YNntWQ=3D=3D
2012-02-03 17:02:10.955543 7f88c9366710 cephx:
verify_service_ticket_reply got 2 keys
2012-02-03 17:02:10.955550 7f88c9366710 cephx: got key for service_id m=
on
2012-02-03 17:02:10.955583 7f88c9366710 cephx:  ticket.secret_id=3D7
2012-02-03 17:02:10.955599 7f88c9366710 cephx:
verify_service_ticket_reply service mon secret_id 7 session_key
AQCClCtPiEvuOBAAAS1JWDWR4qsQNRbzS5sP3A=3D=3D validity=3D3600.000000
2012-02-03 17:02:10.955612 7f88c9366710 cephx: ticket
expires=3D2012-02-03 18:02:10.955607 renew_after=3D2012-02-03
17:47:10.955607
2012-02-03 17:02:10.955619 7f88c9366710 cephx: got key for service_id o=
sd
2012-02-03 17:02:10.955639 7f88c9366710 cephx:  ticket.secret_id=3D7
2012-02-03 17:02:10.955654 7f88c9366710 cephx:
verify_service_ticket_reply service osd secret_id 7 session_key
AQCClCtP2JHuOBAAiOPA//0jJgXE3fFj6O9Zgg=3D=3D validity=3D3600.000000
2012-02-03 17:02:10.955666 7f88c9366710 cephx: ticket
expires=3D2012-02-03 18:02:10.955661 renew_after=3D2012-02-03
17:47:10.955661
2012-02-03 17:02:10.966672 7f88c9366710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:02:10.966727 7f88c9366710 monclient(hunting): found mon.0
2012-02-03 17:02:10.966742 7f88c9366710 monclient: _send_mon_message
to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:02:10.966794 7f88c9366710 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6789/0 -- mon_subscribe({monmap=3D0+}) v1 -- ?+0 0x24606f=
0
con 0x24603e0
2012-02-03 17:02:10.967235 7f88c9366710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:02:10.967251 7f88c9366710 cephx client: need_tickets:
want=3D37 need=3D0 have=3D37
2012-02-03 17:02:10.967259 7f88c9366710 monclient:
_check_auth_rotating not needed by client.admin
2012-02-03 17:02:10.967285 7f88cbb91720 monclient: authenticate
success, global_id 4106
2012-02-03 17:02:10.967452 7f88cbb91720 client.4106.objecter
maybe_request_map subscribing (onetime) to next osd map
2012-02-03 17:02:10.967472 7f88cbb91720 monclient: renew_subs
2012-02-03 17:02:10.967486 7f88cbb91720 monclient: _send_mon_message
to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:02:10.967500 7f88cbb91720 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6789/0 -- mon_subscribe({monmap=3D0+,osdmap=3D0}) v1 -- ?=
+0
0x2460ca0 con 0x24603e0
2012-02-03 17:02:10.967512 7f88cbb91720 monclient: renew_subs
2012-02-03 17:02:10.967522 7f88cbb91720 monclient: _send_mon_message
to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:02:10.967533 7f88cbb91720 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6789/0 -- mon_subscribe({monmap=3D0+,osdmap=3D0}) v1 -- ?=
+0
0x2461ab0 con 0x24603e0
2012-02-03 17:02:10.970017 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 4 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0=
+0 (1638929821
0 0) 0x2460cf0 con 0x24603e0
2012-02-03 17:02:10.970062 7f88c9366710 monclient: handle_monmap mon_ma=
p v1
2012-02-03 17:02:10.970114 7f88c9366710 monclient:  got monmap 1,
mon.0 is now rank 0
2012-02-03 17:02:10.970156 7f88c9366710 monclient: dump:
epoch 1
fsid fe5407e1-f9b0-69f4-4dfe-52ae762929ab
last_changed 2012-02-03 10:19:58.428136
created 2012-02-03 10:19:58.428136
0: 10.68.119.191:6789/0 mon.0

2012-02-03 17:02:10.970221 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 5 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (3873334622 0 0) 0x2461cd0 con 0x24603e0
2012-02-03 17:02:10.970250 7f88c9366710 monclient:
handle_subscribe_ack sent 2012-02-03 17:02:10.952969 renew after
2012-02-03 17:04:40.952969
2012-02-03 17:02:10.970281 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 6 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0=
+0 (1638929821
0 0) 0x2461ee0 con 0x24603e0
2012-02-03 17:02:10.970324 7f88c9366710 monclient: handle_monmap mon_ma=
p v1
2012-02-03 17:02:10.970348 7f88c9366710 monclient:  got monmap 1,
mon.0 is now rank 0
2012-02-03 17:02:10.970379 7f88c9366710 monclient: dump:
epoch 1
fsid fe5407e1-f9b0-69f4-4dfe-52ae762929ab
last_changed 2012-02-03 10:19:58.428136
created 2012-02-03 10:19:58.428136
0: 10.68.119.191:6789/0 mon.0

2012-02-03 17:02:10.970431 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 7 =3D=3D=3D=3D osd_map(21..21 src has 1..21)=
 v2
=3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x2462630 con 0x24603e0
2012-02-03 17:02:10.970488 7f88c9366710 client.4106.objecter
handle_osd_map got epochs [21,21] > 0
2012-02-03 17:02:10.970507 7f88c9366710 client.4106.objecter
handle_osd_map decoding full epoch 21
2012-02-03 17:02:10.970664 7f88c9366710 client.4106.objecter
dump_active .. 0 homeless
2012-02-03 17:02:10.970863 7f88cbb91720 client.4106.objecter
recalc_op_target tid 1 pgid 2.30a98c1c acting [0]
2012-02-03 17:02:10.971004 7f88cbb91720 client.4106.objecter  note:
not requesting commit
2012-02-03 17:02:10.971391 7f88cbb91720 client.4106.objecter op_submit
oid rbd_directory @2 [read 0~0] tid 1 osd.0
2012-02-03 17:02:10.971465 7f88cbb91720 client.4106.objecter send_op 1 =
to osd.0
2012-02-03 17:02:10.971533 7f88cbb91720 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6801/2912 -- osd_op(client.4106.0:1 rbd_directory [read
0~0] 2.30a98c1c) v1 -- ?+0 0x24664c0 con 0x24661b0
2012-02-03 17:02:10.971558 7f88cbb91720 client.4106.objecter 1
unacked, 0 uncommitted
2012-02-03 17:02:10.971615 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 8 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (3873334622 0 0) 0x2462970 con 0x24603e0
2012-02-03 17:02:10.971638 7f88c9366710 monclient:
handle_subscribe_ack sent 0.000000, ignoring
2012-02-03 17:02:10.971666 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 9 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0=
+0 (1638929821
0 0) 0x2462c50 con 0x24603e0
2012-02-03 17:02:10.971683 7f88c9366710 monclient: handle_monmap mon_ma=
p v1
2012-02-03 17:02:10.971704 7f88c9366710 monclient:  got monmap 1,
mon.0 is now rank 0
2012-02-03 17:02:10.971736 7f88c9366710 monclient: dump:
epoch 1
fsid fe5407e1-f9b0-69f4-4dfe-52ae762929ab
last_changed 2012-02-03 10:19:58.428136
created 2012-02-03 10:19:58.428136
0: 10.68.119.191:6789/0 mon.0

2012-02-03 17:02:10.971770 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 10 =3D=3D=3D=3D osd_map(21..21 src has 1..21=
) v2
=3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x24655a0 con 0x24603e0
2012-02-03 17:02:10.971789 7f88c9366710 client.4106.objecter
handle_osd_map ignoring epochs [21,21] <=3D 21
2012-02-03 17:02:10.971801 7f88c9366710 client.4106.objecter
dump_active .. 0 homeless
2012-02-03 17:02:10.971815 7f88c9366710 client.4106.objecter 1
2.30a98c1c      osd.0   rbd_directory   [read 0~0]
2012-02-03 17:02:10.971851 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 11 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (3873334622 0 0) 0x24658c0 con 0x24603e0
2012-02-03 17:02:10.971870 7f88c9366710 monclient:
handle_subscribe_ack sent 0.000000, ignoring
2012-02-03 17:02:10.973607 7f88c6a60710 cephx client: build_authorizer
for service osd
2012-02-03 17:02:13.912816 7f88c8364710 monclient: tick
2012-02-03 17:02:13.912887 7f88c8364710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:02:13.912896 7f88c8364710 cephx client: need_tickets:
want=3D37 need=3D0 have=3D37
2012-02-03 17:02:13.912903 7f88c8364710 monclient:
_check_auth_rotating not needed by client.admin
2012-02-03 17:02:15.967773 7f88c7261710 client.4106.objecter tick
2012-02-03 17:02:20.969006 7f88c7261710 client.4106.objecter tick
2012-02-03 17:02:23.913191 7f88c8364710 monclient: tick
2012-02-03 17:02:23.913276 7f88c8364710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:02:23.913285 7f88c8364710 cephx client: need_tickets:
want=3D37 need=3D0 have=3D37
2012-02-03 17:02:23.913292 7f88c8364710 monclient:
_check_auth_rotating not needed by client.admin
2012-02-03 17:02:25.969271 7f88c7261710 client.4106.objecter tick
2012-02-03 17:02:25.969338 7f88c7261710 client.4106.objecter  tid 1 on
osd.0 is laggy
2012-02-03 17:02:25.969352 7f88c7261710 client.4106.objecter
maybe_request_map subscribing (onetime) to next osd map
2012-02-03 17:02:25.969368 7f88c7261710 monclient: renew_subs
2012-02-03 17:02:25.969410 7f88c7261710 monclient: _send_mon_message
to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:02:25.969433 7f88c7261710 -- 10.68.119.191:0/1003500 -->
10.68.119.191:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D22}) v1 -- =
?+0
0x2462970 con 0x24603e0
2012-02-03 17:02:25.969484 7f88c7261710 -- 10.68.119.191:0/1003500 -->
osd.0 10.68.119.191:6801/2912 -- ping v1 -- ?+0 0x2465890
2012-02-03 17:02:25.970074 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 12 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (3873334622 0 0) 0x2462970 con 0x24603e0
2012-02-03 17:02:25.970099 7f88c9366710 monclient:
handle_subscribe_ack sent 2012-02-03 17:02:25.969373 renew after
2012-02-03 17:04:55.969373
2012-02-03 17:02:30.970489 7f88c7261710 client.4106.objecter tick
2012-02-03 17:02:30.970556 7f88c7261710 client.4106.objecter  tid 1 on
osd.0 is laggy
2012-02-03 17:02:30.970574 7f88c7261710 client.4106.objecter
maybe_request_map subscribing (onetime) to next osd map
2012-02-03 17:02:30.970622 7f88c7261710 -- 10.68.119.191:0/1003500 -->
osd.0 10.68.119.191:6801/2912 -- ping v1 -- ?+0 0x2462970
2012-02-03 17:02:33.913630 7f88c8364710 monclient: tick
2012-02-03 17:02:33.913702 7f88c8364710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:02:33.913710 7f88c8364710 cephx client: need_tickets:
want=3D37 need=3D0 have=3D37
2012-02-03 17:02:33.913717 7f88c8364710 monclient:
_check_auth_rotating not needed by client.admin
2012-02-03 17:02:35.971828 7f88c7261710 client.4106.objecter tick
2012-02-03 17:02:35.971896 7f88c7261710 client.4106.objecter  tid 1 on
osd.0 is laggy
2012-02-03 17:02:35.971911 7f88c7261710 client.4106.objecter
maybe_request_map subscribing (onetime) to next osd map
2012-02-03 17:02:35.971946 7f88c7261710 -- 10.68.119.191:0/1003500 -->
osd.0 10.68.119.191:6801/2912 -- ping v1 -- ?+0 0x2462970
2012-02-03 17:02:40.972951 7f88c7261710 client.4106.objecter tick
2012-02-03 17:02:40.973014 7f88c7261710 client.4106.objecter  tid 1 on
osd.0 is laggy
2012-02-03 17:02:40.973027 7f88c7261710 client.4106.objecter
maybe_request_map subscribing (onetime) to next osd map
2012-02-03 17:02:40.973059 7f88c7261710 -- 10.68.119.191:0/1003500 -->
osd.0 10.68.119.191:6801/2912 -- ping v1 -- ?+0 0x2462970
2012-02-03 17:02:43.914127 7f88c8364710 monclient: tick
2012-02-03 17:02:43.914201 7f88c8364710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:02:43.914210 7f88c8364710 cephx client: need_tickets:
want=3D37 need=3D0 have=3D37
2012-02-03 17:02:43.914218 7f88c8364710 monclient:
_check_auth_rotating not needed by client.admin
2012-02-03 17:02:45.974193 7f88c7261710 client.4106.objecter tick
2012-02-03 17:02:45.974277 7f88c7261710 client.4106.objecter  tid 1 on
osd.0 is laggy
2012-02-03 17:02:45.974291 7f88c7261710 client.4106.objecter
maybe_request_map subscribing (onetime) to next osd map
2012-02-03 17:02:45.974324 7f88c7261710 -- 10.68.119.191:0/1003500 -->
osd.0 10.68.119.191:6801/2912 -- ping v1 -- ?+0 0x2462970


I executed 'rados lspools' with the same options.
-------
root@ceph01:~# rados lspools --log-to-stderr --debug-ms 1
--debug-objecter 20 --debug-monc 20 --debug-auth 20
2012-02-03 17:11:52.849708 7f9c59a59720 monclient(hunting): build_initi=
al_monmap
2012-02-03 17:11:52.850071 7f9c59a59720 -- :/0 messenger.start
2012-02-03 17:11:52.850121 7f9c59a59720 monclient(hunting): init
2012-02-03 17:11:52.850469 7f9c59a59720 auth: KeyRing::load: loaded
key file /etc/ceph/keyring.bin
2012-02-03 17:11:52.851095 7f9c59a59720 monclient(hunting): supporting
cephx auth protocol
2012-02-03 17:11:52.851127 7f9c59a59720 monclient(hunting): _reopen_ses=
sion
2012-02-03 17:11:52.851258 7f9c59a59720 monclient(hunting):
_pick_new_mon picked mon.0 con 0x771440 addr 10.68.119.191:6789/0
2012-02-03 17:11:52.851288 7f9c59a59720 monclient(hunting):
_send_mon_message to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:11:52.851833 7f9c59a59720 -- :/1003868 -->
10.68.119.191:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x771760 con
0x771440
2012-02-03 17:11:52.851864 7f9c59a59720 monclient(hunting): renew_subs
2012-02-03 17:11:52.851922 7f9c59a59720 monclient(hunting):
authenticate will time out at 2012-02-03 17:12:22.851894
2012-02-03 17:11:52.852565 7f9c59a57710 -- 10.68.119.191:0/1003868
learned my addr 10.68.119.191:0/1003868
2012-02-03 17:11:52.854120 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 1 =3D=3D=3D=3D auth_reply(proto 2 0 Success)=
 v1
=3D=3D=3D=3D 33+0+0 (1236223873 0 0) 0x76e000 con 0x771440
2012-02-03 17:11:52.854189 7f9c5764b710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:11:52.854245 7f9c5764b710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:11:52.854261 7f9c5764b710 cephx: set_have_need_key no
handler for service auth
2012-02-03 17:11:52.854280 7f9c5764b710 cephx: validate_tickets want
37 have 0 need 37
2012-02-03 17:11:52.854294 7f9c5764b710 monclient(hunting): my global_i=
d is 4107
2012-02-03 17:11:52.854311 7f9c5764b710 cephx client: handle_response r=
et =3D 0
2012-02-03 17:11:52.854523 7f9c5764b710 cephx client: =A0got initial
server challenge 9453701282273502885
2012-02-03 17:11:52.854554 7f9c5764b710 cephx client: build_request
2012-02-03 17:11:52.854567 7f9c5764b710 cephx client:
validate_tickets: want=3D37 need=3D37 have=3D0
2012-02-03 17:11:52.854580 7f9c5764b710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:11:52.854592 7f9c5764b710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:11:52.854603 7f9c5764b710 cephx: set_have_need_key no
handler for service auth
2012-02-03 17:11:52.854614 7f9c5764b710 cephx: validate_tickets want
37 have 0 need 37
2012-02-03 17:11:52.854626 7f9c5764b710 cephx client: want=3D37 need=3D=
37 have=3D0
2012-02-03 17:11:52.855052 7f9c5764b710 cephx client: get auth session
key: client_challenge 11458308468581777284
2012-02-03 17:11:52.855082 7f9c5764b710 monclient(hunting):
_send_mon_message to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:11:52.855104 7f9c5764b710 -- 10.68.119.191:0/1003868 -->
10.68.119.191:6789/0 -- auth(proto 2 32 bytes) v1 -- ?+0 0x76e000 con
0x771440
2012-02-03 17:11:52.856042 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success)=
 v1
=3D=3D=3D=3D 206+0+0 (4278599348 0 0) 0x76e000 con 0x771440
2012-02-03 17:11:52.856072 7f9c5764b710 cephx client: handle_response r=
et =3D 0
2012-02-03 17:11:52.856083 7f9c5764b710 cephx client: =A0get_auth_sessi=
on_key
2012-02-03 17:11:52.856096 7f9c5764b710 cephx:
verify_service_ticket_reply got 1 keys
2012-02-03 17:11:52.856106 7f9c5764b710 cephx: got key for service_id a=
uth
2012-02-03 17:11:52.856333 7f9c5764b710 cephx: =A0ticket.secret_id=3D2
2012-02-03 17:11:52.856369 7f9c5764b710 cephx:
verify_service_ticket_reply service auth secret_id 2 session_key
AQDIlitPgOj/MhAASonUfgU6AS64ilA1CcYskQ=3D=3D validity=3D43200.000000
2012-02-03 17:11:52.856394 7f9c5764b710 cephx: ticket
expires=3D2012-02-04 05:11:52.856384 renew_after=3D2012-02-04
02:11:52.856384
2012-02-03 17:11:52.856407 7f9c5764b710 cephx client: =A0want=3D37 need=
=3D37 have=3D0
2012-02-03 17:11:52.856418 7f9c5764b710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:11:52.856427 7f9c5764b710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:11:52.856437 7f9c5764b710 cephx: validate_tickets want
37 have 32 need 5
2012-02-03 17:11:52.856449 7f9c5764b710 cephx client: build_request
2012-02-03 17:11:52.856458 7f9c5764b710 cephx client:
validate_tickets: want=3D37 need=3D5 have=3D32
2012-02-03 17:11:52.856470 7f9c5764b710 cephx: set_have_need_key no
handler for service mon
2012-02-03 17:11:52.856480 7f9c5764b710 cephx: set_have_need_key no
handler for service osd
2012-02-03 17:11:52.856490 7f9c5764b710 cephx: validate_tickets want
37 have 32 need 5
2012-02-03 17:11:52.856499 7f9c5764b710 cephx client: want=3D37 need=3D=
5 have=3D32
2012-02-03 17:11:52.856509 7f9c5764b710 cephx client: get service
keys: want=3D37 need=3D5 have=3D32
2012-02-03 17:11:52.856618 7f9c5764b710 monclient(hunting):
_send_mon_message to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:11:52.856641 7f9c5764b710 -- 10.68.119.191:0/1003868 -->
10.68.119.191:6789/0 -- auth(proto 2 165 bytes) v1 -- ?+0 0x76e000 con
0x771440
2012-02-03 17:11:52.857320 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 3 =3D=3D=3D=3D auth_reply(proto 2 0 Success)=
 v1
=3D=3D=3D=3D 409+0+0 (1297679136 0 0) 0x76e280 con 0x771440
2012-02-03 17:11:52.857340 7f9c5764b710 cephx client: handle_response r=
et =3D 0
2012-02-03 17:11:52.857362 7f9c5764b710 cephx client:
get_principal_session_key session_key
AQDIlitPgOj/MhAASonUfgU6AS64ilA1CcYskQ=3D=3D
2012-02-03 17:11:52.857374 7f9c5764b710 cephx:
verify_service_ticket_reply got 2 keys
2012-02-03 17:11:52.857384 7f9c5764b710 cephx: got key for service_id m=
on
2012-02-03 17:11:52.857420 7f9c5764b710 cephx: =A0ticket.secret_id=3D7
2012-02-03 17:11:52.857440 7f9c5764b710 cephx:
verify_service_ticket_reply service mon secret_id 7 session_key
AQDIlitPaPETMxAA7ySt6XbGvUPIIo5o4NhBqQ=3D=3D validity=3D3600.000000
2012-02-03 17:11:52.857457 7f9c5764b710 cephx: ticket
expires=3D2012-02-03 18:11:52.857450 renew_after=3D2012-02-03
17:56:52.857450
2012-02-03 17:11:52.857468 7f9c5764b710 cephx: got key for service_id o=
sd
2012-02-03 17:11:52.857553 7f9c5764b710 cephx: =A0ticket.secret_id=3D7
2012-02-03 17:11:52.862340 7f9c5764b710 cephx:
verify_service_ticket_reply service osd secret_id 7 session_key
AQDIlitPsGIUMxAARR3derMOFYPJX+SGVRmhPA=3D=3D validity=3D3600.000000
2012-02-03 17:11:52.862386 7f9c5764b710 cephx: ticket
expires=3D2012-02-03 18:11:52.862378 renew_after=3D2012-02-03
17:56:52.862378
2012-02-03 17:11:52.862399 7f9c5764b710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:11:52.862410 7f9c5764b710 monclient(hunting): found mon.0
2012-02-03 17:11:52.862424 7f9c5764b710 monclient: _send_mon_message
to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:11:52.862469 7f9c5764b710 -- 10.68.119.191:0/1003868 -->
10.68.119.191:6789/0 -- mon_subscribe({monmap=3D0+}) v1 -- ?+0 0x76dd30
con 0x771440
2012-02-03 17:11:52.862805 7f9c5764b710 cephx: validate_tickets want
37 have 37 need 0
2012-02-03 17:11:52.862820 7f9c5764b710 cephx client: need_tickets:
want=3D37 need=3D0 have=3D37
2012-02-03 17:11:52.862829 7f9c5764b710 monclient:
_check_auth_rotating not needed by client.admin
2012-02-03 17:11:52.862850 7f9c59a59720 monclient: authenticate
success, global_id 4107
2012-02-03 17:11:52.863062 7f9c59a59720 client.4107.objecter
maybe_request_map subscribing (onetime) to next osd map
2012-02-03 17:11:52.863085 7f9c59a59720 monclient: renew_subs
2012-02-03 17:11:52.863097 7f9c59a59720 monclient: _send_mon_message
to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:11:52.863109 7f9c59a59720 -- 10.68.119.191:0/1003868 -->
10.68.119.191:6789/0 -- mon_subscribe({monmap=3D0+,osdmap=3D0}) v1 -- ?=
+0
0x76e280 con 0x771440
2012-02-03 17:11:52.863121 7f9c59a59720 monclient: renew_subs
2012-02-03 17:11:52.863131 7f9c59a59720 monclient: _send_mon_message
to mon.0 at 10.68.119.191:6789/0
2012-02-03 17:11:52.863142 7f9c59a59720 -- 10.68.119.191:0/1003868 -->
10.68.119.191:6789/0 -- mon_subscribe({monmap=3D0+,osdmap=3D0}) v1 -- ?=
+0
0x76ed70 con 0x771440
2012-02-03 17:11:52.865300 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 4 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0=
+0 (1638929821
0 0) 0x76e280 con 0x771440
2012-02-03 17:11:52.865354 7f9c5764b710 monclient: handle_monmap mon_ma=
p v1
2012-02-03 17:11:52.865377 7f9c5764b710 monclient: =A0got monmap 1,
mon.0 is now rank 0
2012-02-03 17:11:52.865877 7f9c5764b710 monclient: dump:
epoch 1
fsid fe5407e1-f9b0-69f4-4dfe-52ae762929ab
last_changed 2012-02-03 10:19:58.428136
created 2012-02-03 10:19:58.428136
0: 10.68.119.191:6789/0 mon.0

2012-02-03 17:11:52.865922 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 5 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (3873334622 0 0) 0x770040 con 0x771440
2012-02-03 17:11:52.865944 7f9c5764b710 monclient:
handle_subscribe_ack sent 2012-02-03 17:11:52.851875 renew after
2012-02-03 17:14:22.851875
2012-02-03 17:11:52.865962 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 6 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0=
+0 (1638929821
0 0) 0x770320 con 0x771440
2012-02-03 17:11:52.865972 7f9c5764b710 monclient: handle_monmap mon_ma=
p v1
2012-02-03 17:11:52.865984 7f9c5764b710 monclient: =A0got monmap 1,
mon.0 is now rank 0
2012-02-03 17:11:52.866001 7f9c5764b710 monclient: dump:
epoch 1
fsid fe5407e1-f9b0-69f4-4dfe-52ae762929ab
last_changed 2012-02-03 10:19:58.428136
created 2012-02-03 10:19:58.428136
0: 10.68.119.191:6789/0 mon.0

2012-02-03 17:11:52.866072 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 7 =3D=3D=3D=3D osd_map(21..21 src has 1..21)=
 v2
=3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x770a70 con 0x771440
2012-02-03 17:11:52.866103 7f9c5764b710 client.4107.objecter
handle_osd_map got epochs [21,21] > 0
2012-02-03 17:11:52.866111 7f9c5764b710 client.4107.objecter
handle_osd_map decoding full epoch 21
2012-02-03 17:11:52.866272 7f9c5764b710 client.4107.objecter
dump_active .. 0 homeless
data
metadata
rbd
2012-02-03 17:11:52.866605 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 8 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (3873334622 0 0) 0x770d80 con 0x771440
2012-02-03 17:11:52.866621 7f9c5764b710 monclient: discarding stray
monitor message mon_subscribe_ack(300s) v1
2012-02-03 17:11:52.866635 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 9 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0=
+0 (1638929821
0 0) 0x76f050 con 0x771440
2012-02-03 17:11:52.866644 7f9c5764b710 monclient: discarding stray
monitor message mon_map v1
2012-02-03 17:11:52.866659 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 10 =3D=3D=3D=3D osd_map(21..21 src has 1..21=
) v2
=3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x76f7a0 con 0x771440
2012-02-03 17:11:52.866668 7f9c5764b710 client.4107.objecter
handle_osd_map ignoring epochs [21,21] <=3D 21
2012-02-03 17:11:52.866676 7f9c5764b710 client.4107.objecter
dump_active .. 0 homeless
2012-02-03 17:11:52.866692 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 11 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (3873334622 0 0) 0x76fae0 con 0x771440
2012-02-03 17:11:52.866701 7f9c5764b710 monclient: discarding stray
monitor message mon_subscribe_ack(300s) v1
2012-02-03 17:11:52.867234 7f9c59a59720 -- 10.68.119.191:0/1003868
shutdown complete.

I compared those logs and found there is differences.
'rbd list'
2012-02-03 17:02:10.971770 7f88c9366710 -- 10.68.119.191:0/1003500 <=3D=
=3D
mon.0 10.68.119.191:6789/0 10 =3D=3D=3D=3D osd_map(21..21 src has 1..21=
) v2
=3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x24655a0 con 0x24603e0
2012-02-03 17:02:10.971789 7f88c9366710 client.4106.objecter
handle_osd_map ignoring epochs [21,21] <=3D 21
2012-02-03 17:02:10.971801 7f88c9366710 client.4106.objecter
dump_active .. 0 homeless
2012-02-03 17:02:10.971815 7f88c9366710 client.4106.objecter 1
2.30a98c1c      osd.0   rbd_directory   [read 0~0]
--(snip)--

'rados lspools'
2012-02-03 17:11:52.866072 7f9c5764b710 -- 10.68.119.191:0/1003868 <=3D=
=3D
mon.0 10.68.119.191:6789/0 7 =3D=3D=3D=3D osd_map(21..21 src has 1..21)=
 v2
=3D=3D=3D=3D 1284+0+0 (473305567 0 0) 0x770a70 con 0x771440
2012-02-03 17:11:52.866103 7f9c5764b710 client.4107.objecter
handle_osd_map got epochs [21,21] > 0
2012-02-03 17:11:52.866111 7f9c5764b710 client.4107.objecter
handle_osd_map decoding full epoch 21
2012-02-03 17:11:52.866272 7f9c5764b710 client.4107.objecter
dump_active .. 0 homeless
data
metadata
rbd
--(snip)--

What do these logs mean ?

>> *ceph cluster is configured on single server.
>> *server is ubuntu 10.10 maverick.
>> *ceph, librados2 and librbd1 packages are installed.
>>  (version: 0.38-1maverick)
>> *apparmor is disable.
>
>
> apparmor shouldn't matter if you have libvirt 0.9.9 or newer.

I use libvirt 0.8.3 (latest version for maverick), so I disabled apparm=
or.



2012/2/2 Josh Durgin <josh.durgin@dreamhost.com>:
> On 02/02/2012 01:49 AM, Masuko Tomoya wrote:
>>
>> Hi, all.
>>
>> When I execute "rbd" command, it is not success.
>>
>> root@ceph01:~# rbd list
>> (no response)
>>
>> /var/log/ceph/mon.0.log
>> -----
>> 2012-02-02 17:58:19.801762 7ff4bbfb1710 -- 10.68.119.191:6789/0<=3D=3D
>> client.? 10.68.119.191:0/1002580 1 =3D=3D=3D=3D auth(proto 0 30 byte=
s) v1 =3D=3D=3D=3D
>> 56+0+0 (625540289 0 0) 0x1619a00 con 0x1615a00
>> 2012-02-02 17:58:19.801919 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
>> 0x1619c00 con 0x1615a00
>> 2012-02-02 17:58:19.802505 7ff4bbfb1710 -- 10.68.119.191:6789/0<=3D=3D
>> client.? 10.68.119.191:0/1002580 2 =3D=3D=3D=3D auth(proto 2 32 byte=
s) v1 =3D=3D=3D=3D
>> 58+0+0 (346146289 0 0) 0x161fc00 con 0x1615a00
>> 2012-02-02 17:58:19.802673 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
>> 0x1619a00 con 0x1615a00
>> 2012-02-02 17:58:19.803473 7ff4bbfb1710 -- 10.68.119.191:6789/0<=3D=3D
>> client.? 10.68.119.191:0/1002580 3 =3D=3D=3D=3D auth(proto 2 165 byt=
es) v1
>> =3D=3D=3D=3D 191+0+0 (3737796417 0 0) 0x1619600 con 0x1615a00
>> 2012-02-02 17:58:19.803745 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
>> 0x161fc00 con 0x1615a00
>> 2012-02-02 17:58:19.804425 7ff4bbfb1710 -- 10.68.119.191:6789/0<=3D=3D
>> client.? 10.68.119.191:0/1002580 4 =3D=3D=3D=3D mon_subscribe({monma=
p=3D0+}) v2
>> =3D=3D=3D=3D 23+0+0 (1620593354 0 0) 0x1617380 con 0x1615a00
>> 2012-02-02 17:58:19.804488 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1635700 con 0x1615a00
>> 2012-02-02 17:58:19.804517 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> client.? 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 -- ?+=
0
>> 0x163d780
>> 2012-02-02 17:58:19.804550 7ff4bbfb1710 -- 10.68.119.191:6789/0<=3D=3D
>> client.4112 10.68.119.191:0/1002580 5 =3D=3D=3D=3D
>> mon_subscribe({monmap=3D0+,osdmap=3D0}) v2 =3D=3D=3D=3D 42+0+0 (9825=
83713 0 0)
>> 0x1617a80 con 0x1615a00
>> 2012-02-02 17:58:19.804578 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617380 con 0x1615a00
>> 2012-02-02 17:58:19.804656 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v1 --
>> ?+0 0x1619600
>> 2012-02-02 17:58:19.804744 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 --
>> ?+0 0x163d900
>> 2012-02-02 17:58:19.804778 7ff4bbfb1710 -- 10.68.119.191:6789/0<=3D=3D
>> client.4112 10.68.119.191:0/1002580 6 =3D=3D=3D=3D
>> mon_subscribe({monmap=3D0+,osdmap=3D0}) v2 =3D=3D=3D=3D 42+0+0 (9825=
83713 0 0)
>> 0x16178c0 con 0x1615a00
>> 2012-02-02 17:58:19.804811 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617a80 con 0x1615a00
>> 2012-02-02 17:58:19.804855 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v1 --
>> ?+0 0x1619400
>> 2012-02-02 17:58:19.804884 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
>> client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 --
>> ?+0 0x161d300
>> -----
>
>
> No problems there.
>
>
>>
>> BTW, I could execute "rados lspools".
>>
>> root@ceph01:~# rados lspools
>> data
>> metadata
>> rbd
>
>
> This might mean the rbd image list object can't be read for some
> reason, or the rbd tool is doing something weird that the rados tool
> isn't. Can you share the output of 'ceph -s' and
> 'rbd ls --log-to-stderr --debug-ms 1 --debug-objecter 20 --debug-monc=
 20
> --debug-auth 20'?
>
> You can run 'rados lspools' with those options as well and compare.
>
>
>> I would like to use rbd volume and attach it as virtual device for V=
M
>> guest on KVM.
>>
>> Could you advice to me ?
>>
>>
>> My environment is below.
>>
>> *ceph cluster is configured on single server.
>> *server is ubuntu 10.10 maverick.
>> *ceph, librados2 and librbd1 packages are installed.
>> =A0(version: 0.38-1maverick)
>> *apparmor is disable.
>
>
> apparmor shouldn't matter if you have libvirt 0.9.9 or newer.
>
>
>> *root@ceph01:/# ls -l /etc/ceph
>> total 16
>> -rw-r--r-- 1 root root 340 2012-02-02 17:28 ceph.conf
>> -rw------- 1 root root =A092 2012-02-02 17:28 client.admin.keyring
>> -rw------- 1 root root =A085 2012-02-02 17:28 mds.0.keyring
>> -rw------- 1 root root =A085 2012-02-02 17:28 osd.0.keyring
>> */var/lib/ceph/tmp is exists.
>> root@ceph01:/var/log# ls -l /var/lib/ceph/
>> total 4
>> drwxrwxrwx 2 root root 4096 2011-11-11 09:28 tmp
>>
>> */etc/ceph/ceph.conf
>> [global]
>> =A0 =A0 =A0 =A0 auth supported =3D cephx
>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/$name.keyring
>> [mon]
>> =A0 =A0 =A0 =A0 mon data =3D /data/data/mon$id
>> =A0 =A0 =A0 =A0 debug ms =3D 1
>> [mon.0]
>> =A0 =A0 =A0 =A0 host =3D ceph01
>> =A0 =A0 =A0 =A0 mon addr =3D 10.68.119.191:6789
>> [mds]
>>
>> [mds.0]
>> =A0 =A0 =A0 =A0 host =3D ceph01
>> [osd]
>> =A0 =A0 =A0 =A0 osd data =3D /data/osd$id
>> =A0 =A0 =A0 =A0 osd journal =3D /data/osd$id/journal
>> =A0 =A0 =A0 =A0 osd journal size =3D 512
>> =A0 =A0 =A0 =A0 osd class tmp =3D /var/lib/ceph/tmp
>> [osd.0]
>> =A0 =A0 =A0 =A0 host =3D ceph01
>> =A0 =A0 =A0 =A0 btrfs devs =3D /dev/sdb1
>>
>>
>> Waiting for your reply,
>>
>> Tomoya.
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
