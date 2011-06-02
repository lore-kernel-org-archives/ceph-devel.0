From: biyan chen <riby.chen@gmail.com>
Subject: ceph_tool_common_init failed
Date: Thu, 2 Jun 2011 20:29:26 +0800
Message-ID: <BANLkTinhA3T3F3+ocVrr9vzckJoWZRtXZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57461 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933602Ab1FBM31 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 08:29:27 -0400
Received: by gyd10 with SMTP id 10so302066gyd.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2011 05:29:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

[root@ceph_mon0 ~]#
[root@ceph_mon0 ~]# ceph -s
2011-06-02 20:30:12.960497 7f9e2494a720 -- :/0 messenger.start
2011-06-02 20:30:12.960844 7f9e2494a720 -- :/9113 -->
192.168.0.211:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0xbff380 con
0xbff0a0
2011-06-02 20:30:12.961100 7f9e21f08710 -- 192.168.0.211:0/9113
learned my addr 192.168.0.211:0/9113
2011-06-02 20:30:12.961550 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 1 =3D=3D=3D=3D auth_reply(proto 2 0 Success) =
v1 =3D=3D=3D=3D
33+0+0 (3324216284 0 0) 0x7f9e18000950 con 0xbff0a0
2011-06-02 20:30:12.961763 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- auth(proto 2 32 bytes) v1 -- ?+0
0x7f9e140014d0 con 0xbff0a0
2011-06-02 20:30:12.962196 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success) =
v1 =3D=3D=3D=3D
206+0+0 (3956748130 0 0) 0x7f9e18000c80 con 0xbff0a0
2011-06-02 20:30:12.962303 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- mon_subscribe({monmap=3D0+}) v1 -- ?+0 0xc1a2e0
con 0xbff0a0
2011-06-02 20:30:12.962329 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(0 v0) v1 -- ?+0 0x7f9e140008c0 con
0xbff0a0
2011-06-02 20:30:12.962344 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(1 v0) v1 -- ?+0 0x7f9e14000a90 con
0xbff0a0
2011-06-02 20:30:12.962380 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(2 v0) v1 -- ?+0 0x7f9e14000c60 con
0xbff0a0
2011-06-02 20:30:12.962397 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(3 v0) v1 -- ?+0 0x7f9e14000e30 con
0xbff0a0
2011-06-02 20:30:12.962416 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(4 v0) v1 -- ?+0 0x7f9e14001000 con
0xbff0a0
2011-06-02 20:30:12.962431 7f9e23d0b710 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(5 v0) v1 -- ?+0 0x7f9e140011d0 con
0xbff0a0
2011-06-02 20:30:12.964201 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 3 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0+=
0 (166897411 0
0) 0x7f9e18000c10 con 0xbff0a0
2011-06-02 20:30:12.964296 7f9e2494a720 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(0 v0) v1 -- ?+0 0xc1a2e0 con 0xbff0a0
2011-06-02 20:30:12.964324 7f9e2494a720 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(1 v0) v1 -- ?+0 0xbff380 con 0xbff0a0
2011-06-02 20:30:12.964341 7f9e2494a720 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(2 v0) v1 -- ?+0 0xbff590 con 0xbff0a0
2011-06-02 20:30:12.964367 7f9e2494a720 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(3 v0) v1 -- ?+0 0xc1a2e0 con 0xbff0a0
2011-06-02 20:30:12.964387 7f9e2494a720 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(4 v0) v1 -- ?+0 0xbff380 con 0xbff0a0
2011-06-02 20:30:12.964422 7f9e2494a720 -- 192.168.0.211:0/9113 -->
192.168.0.211:6789/0 -- observe(5 v0) v1 -- ?+0 0xbff590 con 0xbff0a0
2011-06-02 20:30:12.964822 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 4 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D
20+0+0 (4179376334 0 0) 0x7f9e18000c10 con 0xbff0a0
2011-06-02 20:30:12.964864 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 5 =3D=3D=3D=3D mon_observe_notify(v2 85965 by=
tes
latest v2) v1 =3D=3D=3D=3D 86016+0+0 (3821167787 0 0) 0x7f9e18015e30 co=
n
0xbff0a0
2011-06-02 20:30:12.964878    pg v2: 396 pgs: 396 creating; 0 KB data,
0 KB used, 0 KB / 0 KB avail
2011-06-02 20:30:12.965759 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 6 =3D=3D=3D=3D mon_observe_notify(v3 503 byte=
s
latest v3) v1 =3D=3D=3D=3D 554+0+0 (2388696997 0 0) 0x7f9e18016270 con
0xbff0a0
2011-06-02 20:30:12.965785   mds e3: 1/1/1 up {0=3Dalpha=3Dup:creating}
2011-06-02 20:30:12.965824 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 7 =3D=3D=3D=3D mon_observe_notify(v1 1511 byt=
es
latest v1) v1 =3D=3D=3D=3D 1562+0+0 (3327055785 0 0) 0x7f9e18016b50 con
0xbff0a0
2011-06-02 20:30:12.965833   osd e1: 0 osds: 0 up, 0 in
2011-06-02 20:30:12.965889 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 8 =3D=3D=3D=3D mon_observe_notify(v3 598 byte=
s
latest v3) v1 =3D=3D=3D=3D 649+0+0 (399222491 0 0) 0x7f9e180170a0 con 0=
xbff0a0
2011-06-02 20:30:12.965899   log 2011-06-02 20:22:42.667500 mon0
192.168.0.211:6789/0 2 : [INF] mds? 192.168.0.207:6800/9395 up:boot
2011-06-02 20:30:12.965933 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 9 =3D=3D=3D=3D mon_observe_notify(v1 183 byte=
s
latest v1) v1 =3D=3D=3D=3D 234+0+0 (2937807471 0 0) 0x7f9e18017450 con
0xbff0a0
2011-06-02 20:30:12.965942   mon e1: 1 mons at {0=3D192.168.0.211:6789/=
0}
2011-06-02 20:30:12.965969 7f9e23d0b710 -- 192.168.0.211:0/9113 <=3D=3D
mon0 192.168.0.211:6789/0 10 =3D=3D=3D=3D mon_observe_notify(v3 1121 by=
tes
latest v3) v1 =3D=3D=3D=3D 1172+0+0 (3930882285 0 0) 0x7f9e18017ba0 con
0xbff0a0
2011-06-02 20:30:12.966186 7f9e2494a720 -- 192.168.0.211:0/9113
shutdown complete.
[root@ceph_mon0 ~]#

[root@ceph_osd1 ceph]# ceph -s
2011-06-02 16:27:35.008949 7f3f53940720 -- :/0 messenger.start
2011-06-02 16:27:35.009151 7f3f53940720 -- :/6639 -->
192.168.0.211:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x1e28110 con
0x1e27e30
2011-06-02 16:27:35.009558 7f3f516fe710 -- 192.168.0.209:0/6639
learned my addr 192.168.0.209:0/6639
2011-06-02 16:27:35.010123 7f3f52f01710 -- 192.168.0.209:0/6639 <=3D=3D
mon0 192.168.0.211:6789/0 1 =3D=3D=3D=3D auth_reply(proto 2 0 Success) =
v1 =3D=3D=3D=3D
33+0+0 (1309484099 0 0) 0x7f3f48000950 con 0x1e27e30
2011-06-02 16:27:35.010190 7f3f52f01710 -- 192.168.0.209:0/6639 -->
192.168.0.211:6789/0 -- auth(proto 2 32 bytes) v1 -- ?+0
0x7f3f440014d0 con 0x1e27e30
2011-06-02 16:27:35.010750 7f3f52f01710 -- 192.168.0.209:0/6639 <=3D=3D
mon0 192.168.0.211:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 -1 Operatio=
n not
permitted) v1 =3D=3D=3D=3D 24+0+0 (2201186306 0 0) 0x7f3f48000950 con
0x1e27e30
2011-06-02 16:27:35.010776 7f3f53940720 unable to authenticate as clien=
t.admin
2011-06-02 16:27:35.010961 7f3f53940720 -- 192.168.0.209:0/6639
shutdown complete.
2011-06-02 16:27:35.011004 7f3f53940720 ceph_tool_common_init failed.
[root@ceph_osd1 ceph]#



[root@ceph_mds0 ceph]# ceph -s
2011-06-03 04:27:51.268147 7f4c45d8d720 -- :/0 messenger.start
2011-06-03 04:27:51.268336 7f4c45d8d720 -- :/9492 -->
192.168.0.211:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x8ff7f0 con
0x8ff550
2011-06-03 04:27:51.268761 7f4c4334b710 -- 192.168.0.207:0/9492
learned my addr 192.168.0.207:0/9492
2011-06-03 04:27:51.269402 7f4c4514e710 -- 192.168.0.207:0/9492 <=3D=3D
mon0 192.168.0.211:6789/0 1 =3D=3D=3D=3D auth_reply(proto 2 0 Success) =
v1 =3D=3D=3D=3D
33+0+0 (59750822 0 0) 0x7f4c38000950 con 0x8ff550
2011-06-03 04:27:51.269490 7f4c4514e710 -- 192.168.0.207:0/9492 -->
192.168.0.211:6789/0 -- auth(proto 2 32 bytes) v1 -- ?+0
0x7f4c340014d0 con 0x8ff550
2011-06-03 04:27:51.270031 7f4c4514e710 -- 192.168.0.207:0/9492 <=3D=3D
mon0 192.168.0.211:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 -1 Operatio=
n not
permitted) v1 =3D=3D=3D=3D 24+0+0 (3744109373 0 0) 0x7f4c38000950 con 0=
x8ff550
2011-06-03 04:27:51.270076 7f4c45d8d720 unable to authenticate as clien=
t.admin
2011-06-03 04:27:51.270243 7f4c45d8d720 -- 192.168.0.207:0/9492
shutdown complete.
2011-06-03 04:27:51.270325 7f4c45d8d720 ceph_tool_common_init failed.
[root@ceph_mds0 ceph]#



My configuration files:

;
; Sample ceph ceph.conf file.
;
; This file defines cluster membership, the various locations
; that Ceph stores data, and any other runtime options.

; If a 'host' is defined for a daemon, the start/stop script will
; verify that it matches the hostname (or else ignore it).  If it is
; not defined, it is assumed that the daemon is intended to start on
; the current host (e.g., in a setup with a startup.conf on each
; node).

; The variables $type, $id and $name are available to use in paths
; $type =3D The type of daemon, possible values: mon, mds and osd
; $id =3D The ID of the daemon, for mon.alpha, $id will be alpha
; $name =3D $type.$id

; For example:
; osd.0
;  $type =3D osd
;  $id =3D 0
;  $name =3D osd.0

; mon.beta
;  $type =3D mon
;  $id =3D beta
;  $name =3D mon.beta

; global
[global]
	; enable secure authentication
	auth supported =3D cephx
        debug ms =3D 0;

        ; allow ourselves to open a lot of files
        max open files =3D 131072

        ; set log file
        log file =3D /var/log/ceph/$name.log
        ; log_to_syslog =3D true        ; uncomment this line to log to=
 syslog

        ; set up pid files
        pid file =3D /var/run/ceph/$name.pid

        ; If you want to run a IPv6 cluster, set this to true.
Dual-stack isn't possible
        ;ms bind ipv6 =3D true

; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
        mon data =3D /data/mon$id

        ; If you are using for example the RADOS Gateway and want to
have your newly created
        ; pools a higher replication level, you can set a default
        ;osd pool default size =3D 3

        ; You can also specify a CRUSH rule for new pools
        ; Wiki: http://ceph.newdream.net/wiki/Custom_data_placement_wit=
h_CRUSH
        ;osd pool default crush rule =3D 0

        ; Timing is critical for monitors, but if you want to allow
the clocks to drift a
        ; bit more, you can specify the max drift.
        ;mon clock drift allowed =3D 1

        ; Tell the monitor to backoff from this warning for 30 seconds
        ;mon clock drift warn backoff =3D 30

	; logging, for debugging monitor crashes, in order of
	; their likelihood of being helpful :)
	;debug ms =3D 1
	;debug mon =3D 20
	;debug paxos =3D 20
	;debug auth =3D 20

[mon.0]
	host =3D ceph_mon0
	mon addr =3D 192.168.0.211:6789

; mds
;  You need at least one.  Define two to get a standby.
[mds]
	; where the mds keeps it's secret encryption keys
	keyring =3D /etc/ceph/keyring.$name

	; mds logging to debug issues.
	;debug ms =3D 1
	;debug mds =3D 20

[mds.alpha]
	host =3D ceph_mds0

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
	; This is where the btrfs volume will be mounted.
	osd data =3D /data/$name

	debug osd =3D 1
	debug filestore =3D 1

	; Ideally, make this a separate disk or partition.  A few
 	; hundred MB should be enough; more if you have fast or many
 	; disks.  You can use a file under the osd data dir if need be
 	; (e.g. /data/$name/journal), but it will be slower than a
 	; separate disk or partition.

        ; This is an example of a file-based journal.
	osd journal =3D /data/$name/journal
	osd journal size =3D 1000 ; journal size, in megabytes

        ; If you want to run the journal on a tmpfs, disable DirectIO
        ;journal dio =3D false

        ; You can change the number of recovery operations to speed up =
recovery
        ; or slow it down if your machines can't handle it
        ; osd recovery max active =3D 3

	; osd logging to debug osd issues, in order of likelihood of being
	; helpful
	;debug ms =3D 1
	;debug osd =3D 20
	;debug filestore =3D 20
	;debug journal =3D 20

[osd.0]
	host =3D ceph_osd0

	; if 'btrfs devs' is not specified, you're responsible for
	; setting up the 'osd data' dir.  if it is not btrfs, things
	; will behave up until you try to recover from a crash (which
	; usually fine for basic testing).
	btrfs devs =3D /dev/sda7

        ; If you want to specify some other mount options, you can do s=
o.
        ; The default values are rw,noatime
        btrfs options =3D rw,noatime

[osd.1]
	host =3D ceph_osd1
	btrfs devs =3D /dev/sda7
	btrfs options =3D rw,noatime

[client]
      ; userspace client
      debug ms =3D 1
      debug client =3D 10



I can mount on the file system, but why tip failure? Log

Thanks all!



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
